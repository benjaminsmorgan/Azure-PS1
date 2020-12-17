# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupName.ps1
    SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupType.ps1
    SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupLoc.ps1
    SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupTag.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
    SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
    SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
    SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource

} #>
<# Variables: {
    SearchAzResourceGroup {
        $SearchAzRG:            Operator input for type of search
        :SearchAzureRG          Named loop for selecting search type
    }
    SearchAzResourceGroupName {
        $OperatorSearchOption:  Operator input for search option
        $RSObjectInput:         Operator input for the resource name
        $RSObject:              Resource object, used to get $RGObject
        $RGObjectInput:         Operator input for the resource group name
        $RGObject:              Resource group object, used for all actions
        :SearchAzureRGByName    Named outer loop for function
        :SearchAzureRSName      Named inner loop for finding $RGObject using resource name
        :SearchAzureRGName      Named inner loop for finding $RGObject
    }
    SearchAzResourceGroupType {
        $ProviderList:          List of all available Azure providers, created at function start as takes time to create
        $OperatorSearchOption:  Operator input for the search type within this function
        $RPObjectInput:         Operator input for search option
        $RPObject:              Resource provider object
        $RPTObjectInput:        Operator input for the resource provider type
        $RPTObject:             Object for the resource provider type, only used to verify type exists
        $RPTObjectName:         Combination of $RPObject.ProviderNamespace "/" $RPTObject.ResourceTypeName, used for getting $RSObject
        $RSObjectInput:         Operator input for the resource name
        $RSObject:              Resource object, used to get $RGObject
        $RGObject:              Resource group object, used for all actions
        :SearchAzureRStype      Named outer loop for function
        :SearchAzureRSProvider  Named middle loop for getting a resource group by provider name only
        :SearchAzureRSType      Named middle loop for getting a resource group by provider name plus type
        :SearchAzureRPName      Named inner loop for getting the provider name, used in both middle loops
        :GetAzureRPTName        Named inner loop for getting the provider type, used in :SearchAzureRSType only
        :GetAzureRSObject       Named inner loop for getting the resource object and resource group, used in both middle loops
    }
    SearchAzResourceGroupName {
        $ValidLocation:         Object containing all Azure location names
        $OperatorSearchOption:  Operator input for search option
        $Location:              Operator input for the Azure location
        $RSObjectInput:         Operator input for the resource name
        $RSObject:              Resource object, used to get $RGObject
        $RGObjectInput:         Operator input for the resource group name
        $RGObject:              Resource group object, used for all actions
        :SearchAzureRGByLoc     Named outer loop for function
        :SearchAzureRSLoc       Named middle loop for finding $RGObject using resource location
        :SearchAzureRGLoc       Named middle loop for finding $RGObject using resource group location
        :SetLocation            Named inner loop for getting and verifying Azure location, used in both middle loops
        :GetAzureRSObject       Named inner loop for getting a matching resource object, used in :SearchAzureRSLoc
        :GetAzureRGObject       Named inner loop for getting a matching resource group object, used in :SearchAzureRGLoc
    }
    SearchAzResourceGroupTag {
        $ValidTagName:          Object containing all Azure Tags
        $ValidTagValue:         Object containing all the $TagNameInput values
        $OperatorSearchOption:  Operator input for search option
        $TagNameInputNameInput: Operator input for the tag name
        $TagNameInputValueInput:Operator input for the tag value
        $RSObjectInput:         Operator input for the resource name
        $RSObject:              Resource object, used to get $RGObject
        $RGObjectInput:         Operator input for the resource group name
        $RGObject:              Resource group object, used for all actions
        :SearchAzureRGByTag     Named outer loop for function
        :SearchAzureRSTag       Named middle loop for finding $RGObject using resource Tag
        :SearchAzureRGTag       Named middle loop for finding $RGObject using resource group Tag
        :SetTagName             Named inner loop for getting and verifying Azure tag name, used in both middle loops
        :SetTagValue            Named inner loop for getting and verifying Azure tag value, used in both middle loops
        :GetAzureRSObject       Named inner loop for getting a matching resource object, used in :SearchAzureRSTag
        :GetAzureRGObject       Named inner loop for getting a matching resource group object, used in :SearchAzureRGTag
    }
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroup > Get $RGObject
            Call SearchAzResourceGroupName > Get $RGObject
            Call SearchAzResourceGroupType > Get $RGObject
            Call SearchAzResourceGroupLoc  > Get $RGObject
            Call SearchAzResourceGroupTag  > Get $RGObject
                Return SearchAzResourceGroup > Send $RGObject
                    Return Function > Send $RGObject
}#>
function SearchAzResourceGroup { # Search for resource group management function
    Begin {
        :SearchAzureRG while($true) { # :SearchAzureRG named loop to select search function
            Write-Host "Azure Resource Group Search" # Write message to screen
            Write-Host "1 Search by partial name lookup" # Write message to screen
            Write-Host "2 Search by contained resource type" # Write message to screen
            Write-Host "3 Search by resource group location" # Write message to screen
            Write-Host "4 Search by tags" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $SearchAzRG = Read-Host "Option?" # Collects operator input on $SearchAzRG option
            if ($SearchAzRG -eq 'exit') { # Exit if statement for this function
                Break SearchAzureRG # Ends :SearchAzureRG loop, leading to return statement
            } # End if ($SearchAzRG -eq 'exit')
            elseif ($SearchAzRG -eq '1') { # Elseif statement for searching by name
                Write-Host "Search by name" # Write message to screen
                $RGObject = SearchAzResourceGroupName # Calls function to assign object to $RGObject
            } # End elseif ($SearchAzRG -eq '1')
            elseif ($SearchAzRG -eq '2') { # Elseif statement for searching by resource provider and type
                Write-Host "Search by type" # Write message to screen
                $RGObject = SearchAzResourceGroupType # Calls function to assign object to $RGObject
            } # End elseif ($SearchAzRG -eq '2')
            elseif ($SearchAzRG -eq '3') { # Elseif statement for searching by location
                Write-Host "Search by location" # Write message to screen
                $RGObject = SearchAzResourceGroupLoc # Calls function to assign object to $RGObject
            } # End elseif ($SearchAzRG -eq '3')
            elseif ($SearchAzRG -eq '4') { # Elseif statement for searching by tag
                Write-Host "Search by tag" # Write message to screen
                $RGObject = SearchAzResourceGroupTag
            } # End elseif ($SearchAzRG -eq '4')
            <# elseif ($SearchAzRG -eq '5') { # Unused elseif statement
                Write-Host "Option 5" # Write message to screen
            } # End elseif ($SearchAzRG -eq '5') #>
            Return $RGObject # Returns to calling function if search option is used
        } # End $SearchAzRG while statement
        Return # Returns to calling function if no search option is used
    } # End begin statement
} # End SearchAzResourceGroup function
function SearchAzResourceGroupName { # Searchs for resource group using partial name matches on the group name, or a contained resource name
    Begin {
        :SearchAzureRGByName while($true) { # :SearchAzureRGByName loop finds a resource group off partial name inputs
            Write-Host "Resource Group Search By Name" # Write message to screen
            Write-Host "1 Search by resource name" # Write message to screen
            Write-Host "2 Search by group name" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRGByName loop if operator types exit
                Break SearchAzureRGByName # Breaks the SearchAzureRGByName loop
            } # End exit if statement
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for search by resource name
                :SearchAzureRSName while ($true) { # :SearchAzureRSName loop finds resource group off partial resource name inputs
                    Write-Host "Search by resource name" # Write message to screen
                    $RSObjectInput = Read-Host "Parital resource name" # Operator input for $RSObjectInput
                    if ($RSObjectInput -eq 'exit') { # Ends SearchAzureRSName loop if operator types exit
                        Break SearchAzureRSName # Breaks the SearchAzureRSName loop
                    } # End exit if statement
                    $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                    $RSObject = Get-AzResource | Where-Object {$_.Name -Like $RSObjectInput} # Performs search and assigns any matching resources to $RSObject
                    if ($RSObject) { # If statement if $RSObject value is found
                        if ($RSObject.count -gt 1) { # If statement if more than one $RSObject value found
                            Write-Host "More than one value found" # Write message to screen
                            Write-Host " " # Write message to screen
                            Write-host $RSObject.name -Separator `n # Write message to screen
                            Write-Host " " # Write message to screen
                            $RSObject = $null # Clears $RSObject, restarting :SearchAzureRSName loop
                        } # End multiple $RSObject if statement
                        else { # If statement for single $RSObject value
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Gets $RGObject using $RSObject.ResourceGroupName
                            $RSObject = $null # Sets $RSObject as $null
                            Return $RGObject # Returns $RGObject to calling function
                        } # End else statement for single $RSObject value
                    } # End if statement for $RSObject value is found
                    else { # Else statment for no $RSObject value found
                        Write-Host " " # Write message to screen
                        Write-Host "No resource found that matches" # Write message to screen
                        Write-Host "Please try again" # Write message to screen
                        Write-Host " " # Write message to screen
                    } # End else statment for no $RSObject value found
                } # End :SearchAzureRSName loop
            } # End else if statment for $OperatorSearchOption -eq '1'
            elseif ($OperatorSearchOption -eq '2') {  # Elseif statement for search by resource group name
                :SearchAzureRGName while ($true) { # :SearchAzureRGName loop finds resource group off partial resource group name inputs
                    Write-Host "Search by resource group name" # Write message to screen
                    $RGObjectInput = Read-Host "Parital resource group name" # Operator input for $RGObjectInput
                    if ($RGObjectInput -eq 'exit') { # Ends SearchAzureRGName loop if operator types exit
                        Break SearchAzureRGName # Breaks the SearchAzureRGName loop
                    } # End exit if statement
                    $RGObjectInput = "*"+$RGObjectInput+"*"
                    $RGObject = Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -Like $RGObjectInput}
                    if ($RGObject) { # If statement if $RGObject value is found
                        if ($RGObject.count -gt 1) { # If statement if more than one $RGObject value found
                            Write-Host "More than one value found" # Write message to screen
                            Write-Host " " # Write message to screen
                            Write-host $RGObject.ResourceGroupName -Separator `n # Write message to screen
                            Write-Host " " # Write message to screen
                            $RGObject = $null # Clears $RGObject, restarting :SearchAzureRGName loop
                        } # End multiple $RGObject if statement
                        else { # If statement for single $RGObject value
                            Return $RGObject # Returns $RGObject to calling function
                        } # End else statement for single $RGObject value
                    } # End if statement for $RGObject value is found
                    else { # Else statment for no $RGObject value found
                        Write-Host " " # Write message to screen
                        Write-Host "No resource groups found that matches" # Write message to screen
                        Write-Host "Please try again" # Write message to screen
                        Write-Host " " # Write message to screen
                    } # End else statment for no $RGObject value found
                } # End :SearchAzureRGName loop
            } # End else if statment for $OperatorSearchOption -eq '2'
        } # End $SearchAzRGName while statement 
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceGroupName
function SearchAzResourceGroupType { # Searchs for resource group resource provider or type on a resource or resource group
    Begin {
        $ProviderList = Get-AzResourceProvider | select-object ProviderNamespace # Collects all current Azure resource provider names
        :SearchAzureRGByType while($True) { # :SearchAzureRGByType loop finds a resource group off resource providers and types
            Write-Host "Resource Group Search By Resource Type" # Write message to screen
            Write-Host "1 Search by provider type" # Write message to screen
            Write-Host "2 Search by resource type" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRGByType loop if operator types exit
                Break SearchAzureRGByType # Breaks the SearchAzureRGByType loop
            } # End exit if statement
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for searching by resource provider
                :SearchAzureRSProvider while($True) { # :SearchAzureRSProvider loops finds a resource group off resource types
                    $RPObject = $null # Clears listed $var from all previous use with in this function
                    $RGObject = $null # Clears listed $var from all previous use with in this function
                    $RSObject = $null # Clears listed $var from all previous use with in this function
                    Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                    :SearchAzureRPName while ($True) { # :SearchAzureRPName loop, used for getting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider" # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq 'exit') {  # If statement to end :SearchAzureRSType loop
                            Break SearchAzureRSProvider # Ends :SearchAzureRSType loop, returns to :SearchAzureRGByType loop
                        } # End if ($RPObjectInput -eq 'exit') statement
                        $RPObjectInput = "*"+$RPObjectInput+"*" # Adds wildcards to $RPObjecInput
                        $RPObject = Get-AzResourceProvider | Where-Object ProviderNamespace -Like $RPObjectInput # Collects resource provider name space and assigns to $RPObject
                        if (!$RPObject) { # If statement if $RPObject input does not match a provider name space
                            Write-Host "The provider name input did not match an existing provider" # Message write to screen
                            Write-Host "Please re-enter the provider name" # Message write to screen
                            Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                        } # End if (!$RPObject)
                        elseif ($RPObject.count -eq 1) { # Elseif statement for confirming that the correct provider name space has been found
                            $OperatorConfirm = Read-Host $RPObject.ProviderNamespace "is the correct resource provider?" # Operator confirmation on provider name space
                            if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'Yes') { # If statement if operator confirms provider name space is correct
                                Break SearchAzureRPName # Breaks :SearchAzurePRName loop
                            } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'Yes')
                            else { # Else statement for non-operator confirmation of the provider name space
                                "Please re-enter the provider name"  # Message write to screen
                            } # End else statement
                        } # End elseif ($RPObject.count -eq 1)
                        elseif ($RPObject.count -gt 1) { # Elseif statement for multiple resource providers being found
                            Write-Host "The resource provider entry provided matches more than 1 provider" # Write message to screen
                            Write-Host " " # Write message to screen
                            Write-Host $RPObject.ProviderNamespace -Separator `n # Writes $RPObject to screen
                            Write-Host " " # Write message to screen
                            Write-Host "Please re-enter the provider name" # Write message to screen    
                        } # End elseif ($RPObject.count -gt 1)
                    } # End while ($RPObject.count -ne 1)
                    $RPObject = $RPObject.ProviderNamespace+"/*"
                    $RSObject = Get-AzResource | Where-Object {$_.ResourceType -like $RPObject} # Collects all resource with a resource provider matching $RPObject
                    if (!$RSObject) { # If statement if no resources match the resource provider type
                        Write-Host "No resources found with the selected provider type"$RPObject # Write message to screen
                        Break SearchAzureRSProvider # Ends :SearchAzureRSProvider loop, returns to :SearchAzureRGByType loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($True) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource provider type
                            Write-Host "Multiple resources found" # Write message to screen
                            Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                            $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSType
                                Break SearchAzureRSProvider # Ends :SearchAzureRSProvider loop, returns to :SearchAzureRGByType loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RSObject = Get-AzResource | Where-Object {$_.Name -Like $RSObjectInput -and $_.ResourceType -like $RPObject} # Collects $RSObject again using the narrower search options
                        } # if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Collects the resource group object containing $RSObject
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSType while($True)
            } # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for searching by resource provider plus resource type
                :SearchAzureRSType while($True) { # :SearchAzureRSType loops finds a resource group off resource types
                    $RPObject = $null # Clears listed $var from all previous use with in this function
                    $RPTObject = $null # Clears listed $var from all previous use with in this function
                    $RGObject = $null # Clears listed $var from all previous use with in this function
                    $RSObject = $null # Clears listed $var from all previous use with in this function
                    Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                    :SearchAzureRPName while ($True) { # :SearchAzureRPName loop, used for getting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider" # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq 'exit') {  # If statement to end :SearchAzureRSType loop
                            Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRGByType loop
                        } # End if ($RPObjectInput -eq 'exit') statement
                        $RPObjectInput = "*"+$RPObjectInput+"*" # Adds wildcards to $RPObjecInput
                        $RPObject = Get-AzResourceProvider | Where-Object ProviderNamespace -Like $RPObjectInput # Collects resource provider name space and assigns to $RPObject
                        if (!$RPObject) { # If statement if $RPObject input does not match a provider name space
                            Write-Host "The provider name input did not match an existing provider" # Message write to screen
                            Write-Host "Please re-enter the provider name" # Message write to screen
                            Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                        } # End if (!$RPObject)
                        elseif ($RPObject.count -eq 1) { # Elseif statement for confirming that the correct provider name space has been found
                            $OperatorConfirm = Read-Host $RPObject.ProviderNamespace "is the correct resource provider?" # Operator confirmation on provider name space
                            if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'Yes') { # If statement if operator confirms provider name space is correct
                                Break SearchAzureRPName # Breaks :SearchAzurePRName loop
                            } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'Yes')
                            else { # Else statement for non-operator confirmation of the provider name space
                                "Please re-enter the provider name"  # Message write to screen
                            } # End else statement
                        } # End elseif ($RPObject.count -eq 1)
                        elseif ($RPObject.count -gt 1) { # Elseif statement for multiple resource providers being found
                            Write-Host "The resource provider entry provided matches more than 1 provider" # Write message to screen
                            Write-Host " " # Write message to screen
                            Write-Host $RPObject.ProviderNamespace -Separator `n # Writes $RPObject to screen
                            Write-Host " " # Write message to screen
                            Write-Host "Please re-enter the provider name" # Write message to screen    
                        } # End elseif ($RPObject.count -gt 1)
                    } # End while ($RPObject.count -ne 1)
                    $RPTObjectList = $RPObject.ResourceTypes # Collects all resource types under $RPObject
                    :GetAzureRPTName while ($True) { # :SearchAzureRPTName loop, used for getting a resource provider type
                        Write-Host $RPTObjectList.ResourceTypeName -Separator `n # Writes $RPObjects.ResourceTypes list to screen
                        $RPTObjectInput = Read-Host "Resource provider type" # Operator input for the resource provider type name
                        if ($RPTObjectInput -eq 'exit') { # If statement for exiting SearchAzureRSType 
                            Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRGByType loop
                        } # End if ($RPTObjectInput -eq 'exit')
                        $RPTObject = (Get-AzResourceProvider | Where-Object {$_.ProviderNamespace -eq $RPObject.ProviderNamespace}).ResourceTypes | Where-Object {$_.ResourceTypeName -eq $RPTObjectInput} # Pulls resource type object from resource provider
                        $RPTObjectName = $RPObject.ProviderNamespace+"/"+$RPTObject.ResourceTypeName # Creates full ResourceType search name using $RPObject.ProviderNamespace and $RPTOBject.ResourceTypeName
                        if (!$RPTObject) { # If statement if the provider type name input does not match
                            Write-Host "No resource provider type matches" # Write message to screen
                            Write-Host "Please re-enter the resource provider type name again" # Write message to screen
                        } # End if (!$RPTObject)
                        elseif ($RPTObject.count -eq 1) { # Elseif statement for an exact match on the resource provider type name 
                            Break GetAzureRPTName # Ends :GetAzureRPTName loop
                        } # End elseif ($RPTObject.count -eq 1
                    } # End :GetAzureRPTObject while ($True)
                    $RSObject = Get-AzResource -ResourceType $RPTObjectName # Collects all resource with a resource provider type matching $RPTObject
                    if (!$RSObject) { # If statement if no resources match the resource provider type
                        Write-Host "No resources found with the selected provider type"$RPTObjectName # Write message to screen
                        Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRGByType loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($True) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource provider type
                            Write-Host "Multiple resources found" # Write message to screen
                            Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                            $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSType
                                Break SearchAzureRSType # # Ends :SearchAzureRSType loop, returns to :SearchAzureRGByType loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RSObject = Get-AzResource -ResourceType $RPTObjectName | Where-Object Name -Like $RSObjectInput # Collects $RSObject again using the narrower search options
                        } # if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Collects the resource group object containing $RSObject
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSType while($True)
            } # End elseif ($OperatorSearchOption -eq '2')
        } # End :SearchAzRGByType while statement
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceGroupType
function SearchAzResourceGroupLoc { # Searchs for resource group using location matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
        :SearchAzureRGByLoc while($true) { # :SearchAzureRGByLoc loop finds a resource group off partial name inputs
            Write-Host "Resource Group Search By Location" # Write message to screen
            Write-Host "1 Search by resource location" # Write message to screen
            Write-Host "2 Search by group location" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRGByLoc loop if operator types exit
                Break SearchAzureRGByLoc # Breaks the SearchAzureRGByLoc loop
            } # End exit if statement
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for search by resource location
                :SearchAzureRSLoc while ($true) { # :SearchAzureRSLoc loop finds resource group off location
                    Write-Host "Search by resource location" # Write message to screen
                    :SetLocation while ($true) { # Loop for getting and verifing $Location
                        $Location = Read-Host "Resource location" # Operator input for the location
                        if ($Location -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSLoc # Ends :SearchAzureRSLoc loop, returns to :SearchAzureRGByLoc loop
                        } # End if ($Location -eq 'exit')
                        elseif ($Location -iin $ValidLocation.Location) { # Validates $Location against $ValidLocation
                            Break SetLocation # End :SetLocation while ($true) 
                        } # End elseif statment
                        else { # Else statement for $Location not matching anything in $ValidLocation
                            Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidLocation.Location -Separator `n # Outputs the valid location lists
                        } # End else statement
                    } # End :SetLocation while ($true)
                    $RSObject = Get-AzResource | Where-Object {$_.Location -eq $Location} # Collects all resource objects where location matches $Location
                    if (!$RSObject) { # If statement if no resources match the resource location
                        Write-Host "No resources found in the location"$Location # Write message to screen
                        Break SearchAzureRSLoc # Ends :SearchAzureRSLoc loop, returns to :SearchAzureRGByLoc loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource location
                            Write-Host "Multiple resources found" # Write message to screen
                            Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                            $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSLoc
                                Break SearchAzureRSLoc # Ends :SearchAzureRSLoc loop, returns to :SearchAzureRGByLoc loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RSObject = Get-AzResource | Where-Object {$_.Location -eq $Location -and $_.Name -like $RSObjectInput} # Collects $RSObject again using the narrower search options
                        } # End if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Collects the resource group object containing $RSObject
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSLoc loop
            } # End else if statment for $OperatorSearchOption -eq '1'
            elseif ($OperatorSearchOption -eq '2') {  # Elseif statement for search by resource group name
                :SearchAzureRGLoc while ($true) { # :SearchAzureRGLoc loop finds resource group off location
                    Write-Host "Search by resource group location" # Write message to screen
                    :SetLocation while ($true) { # Loop for getting and verifing $Location
                        $Location = Read-Host "Resource group location" # Operator input for the location
                        if ($Location -eq 'exit') { # If statement to end this function
                            Break SearchAzureRGLoc # Ends :SearchAzureRGLoc loop, returns to :SearchAzureRGByLoc loop
                        } # End if ($Location -eq 'exit')
                        elseif ($Location -iin $ValidLocation.Location) { # Validates $Location against $ValidLocation
                            Break SetLocation # End :SetLocation while ($true) 
                        } # End elseif statment
                        else { # Else statement for $Location not matching anything in $ValidLocation
                            Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidLocation.Location -Separator `n # Outputs the valid location lists
                        } # End else statement
                    } # End :SetLocation while ($true)
                    $RGObject = Get-AzResourceGroup | Where-Object {$_.Location -eq $Location} # Collects all resource group objects where location matches $Location
                    if (!$RGObject) { # If statement if no resources match the resource group location
                        Write-Host "No resource groups found in the location"$Location # Write message to screen
                        Break SearchAzureRGLoc # Ends :SearchAzureRGLoc loop, returns to :SearchAzureRGByLoc loop
                    } # End if (!$RSObject)
                    :GetAzureRGObject while ($true) { # :GetAzureRGObject loop for narrowing down matching resources
                        if ($RGObject.count -gt 1) { # If statement if more than 1 resource group matches the resource location
                            Write-Host "Multiple resource groups found" # Write message to screen
                            Write-Host $RGObject.ResourceGroupName -Separator `n # Writes list of all resource group names to screen
                            $RGObjectInput = Read-Host "Resource name" # Collects resource group name value to narrow selection
                            if ($RGObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRGLoc
                                Break SearchAzureRGLoc # Ends :SearchAzureRGLoc loop, returns to :SearchAzureRGByLoc loop
                            } # End if ($RGObjectInput -eq 'exit')
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RGObject = Get-AzResourceGroup | Where-Object {$_.Location -eq $Location -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RGObject again using the narrower search options
                        } # End if ($RGObject.count -gt 1)
                        elseif ($RGObject.count -eq 1) { # elseif statement for a single matching resource group object
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRGObject while ($True)
                } # End :SearchAzureRGLoc loop
            } # End else if statment for $OperatorSearchOption -eq '2'
        } # End :SearchAzureByLoc while statement 
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceGroupLoc
function SearchAzResourceGroupTag { # Searchs for resource group using tag matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidTagName = Get-AzTag # Collects the list of all existing tags
        :SearchAzureRGByTag while($true) { # :SearchAzureRGByTag loop finds a resource group off tag values
            Write-Host "Resource Group Search By Tag" # Write message to screen
            Write-Host "1 Search by resource tag" # Write message to screen
            Write-Host "2 Search by group tag" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRGByTag loop if operator types exit
                Break SearchAzureRGByTag # Breaks the SearchAzureRGByTag loop
            } # End exit if statement
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for search by resource Tag
                :SearchAzureRSTag while ($true) { # :SearchAzureRSTag loop finds resource group off Tag
                    Write-Host "Search by resource Tag" # Write message to screen
                    $TagNameInput = $null # Clears $var from previous use
                    $TagValueInput = $null # Clears $var from previous use
                    $RSObject = $null # Clears $var from previous use
                    $RGObject = $null # Clears $var from previous use
                    :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                        $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                        if ($TagNameInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                        } # End if ($TagNameInput -eq 'exit')
                        elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                            Break SetTagName # End :SetTagName while ($true) 
                        } # End elseif statment
                        else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                            Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                        } # End else statement
                    } # End :SetTagName while ($true)
                    $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                    if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                        :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                            $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                            $TagValueInput = Read-Host "Tag value" # Operator input for the tag value
                            if ($TagValueInput -eq 'exit') { # If statement to end this function
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($TagValueInput -eq 'exit')
                            elseif ($TagValueInput -iin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                Break SetTagValue # Breaks out of :SetTagValue loop
                            } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                            else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                            } # End else statement
                        } # End :SetTagValue while ($true) 
                    } # End if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') 
                    if ($TagValueInput) { # If statement for $TagValueInput having a value
                        $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects all resource objects where tag name and value matches $TagNameInput and TagValueInput
                    } # End if ($TagValueInput)
                    else {  # Else statement for $TagValueInput not having a value
                        $RSObject = Get-AzResource -TagName $TagNameInput # Collects all resource objects where tag name matches $TagNameInput
                    } # End else if (($TagValueInput))
                    if (!$RSObject) { # If statement if no resources match the resource tag name
                        Write-Host "No resources found for the Tag name"$TagNameInput # Write message to screen
                        Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource tag
                            if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                                $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                            } # End if ($TagValueInput) 
                            else { # else statement for $TagValueInput not having a value
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                                Write-Host "1 Narrow search using tag value" # Write message to screen
                                Write-Host "2 Narrow Search using resource name" # Write message to screen
                                $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                            } # End else if ($TagValueInput)
                            if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($OperatorSearchOption -eq 'exit')
                            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                                $TagValueInput = Read-Host "Tag value" # Operator input for $TagValueInput
                                $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects $RSObject with additional search values
                            } # End elseif ($OperatorSearchOption -eq '1')
                            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource name
                                $RSObjectInput = Read-Host "Resource name" # Operator inout for the resource name
                                if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                    Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                                } # End if ($RSObjectInput -eq 'exit')
                                $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                                $RSObject = Get-AzResource -TagName $TagNameInput | Where-Object {$_.Name -like $RSObjectInput} # Collects $RSObject again using the narrower search options
                            } # End elseif ($OperatorSearchOption -eq '2')
                        } # End if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Collects the resource group object containing $RSObject
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSTag loop
            } # End else if statment for $OperatorSearchOption -eq '1'
            elseif ($OperatorSearchOption -eq '2') {  # Elseif statement for search by resource group name
                :SearchAzureRGTag while ($true) { # :SearchAzureRGTag loop finds resource group off Tag
                    Write-Host "Search by resource group Tag" # Write message to screen
                    $TagNameInput = $null # Clears $var from previous use
                    $TagValueInput = $null # Clears $var from previous use
                    $RGObject = $null # Clears $var from previous use
                    :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                        $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                        if ($TagNameInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                        } # End if ($TagNameInput -eq 'exit')
                        elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                            Break SetTagName # End :SetTagName while ($true) 
                        } # End elseif statment
                        else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                            Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                        } # End else statement
                    } # End :SetTagName while ($true)
                    $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                    if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                        :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                            $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                            $TagValueInput = Read-Host "Tag value (Case sensitive)" # Operator input for the tag value
                            if ($TagValueInput -eq 'exit') { # If statement to end this function
                                Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($TagValueInput -eq 'exit')
                            elseif ($TagValueInput -cin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                Break SetTagValue # Breaks out of :SetTagValue loop
                            } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                            else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                            } # End else statement
                        } # End :SetTagValue while ($true) 
                    } # End if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') 
                    if ($TagValueInput) { # If statement for $TagValueInput having a value
                        $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=$TagValueInput} # Collects all resource group objects where tag name and value matches $TagNameInput and TagValueInput
                    } # End if ($TagValueInput)
                    else {  # Else statement for $TagValueInput not having a value
                        $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=""} # Collects all resource objects where tag name matches $TagNameInput
                    } # End else if (($TagValueInput))
                    if (!$RGObject) { # If statement if no resources match the resource group tag name
                        Write-Host "No resource groups found for the Tag name"$TagNameInput # Write message to screen
                        Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                    } # End if (!$RGObject)
                    :GetAzureRGObject while ($true) { # :GetAzureRGObject loop for narrowing down matching resource groups
                        if ($RGObject.count -gt 1) { # If statement if more than 1 resource groups matche the resource group tag
                            if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                                Write-Host "Multiple resource groups found" # Write message to screen
                                Write-Host $RGObject.ResourceGroupName -Separator `n # Writes list of all resource group names to screen
                                $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                            } # End if ($TagValueInput) 
                            else { # else statement for $TagValueInput not having a value
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RGObject.ResourceGroupName -Separator `n # Writes list of all resource names to screen
                                Write-Host "1 Narrow search using tag value" # Write message to screen
                                Write-Host "2 Narrow Search using resource group name" # Write message to screen
                                $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                            } # End else if ($TagValueInput)
                            if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($OperatorSearchOption -eq 'exit')
                            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                                :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                                    $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                                    $TagValueInput = Read-Host "Tag value (Case sensitive)" # Operator input for the tag value
                                    if ($TagValueInput -eq 'exit') { # If statement to end this function
                                        Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                                    } # End if ($TagValueInput -eq 'exit')
                                    elseif ($TagValueInput -cin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                        Break SetTagValue # Breaks out of :SetTagValue loop
                                    } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                                    else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                        Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                        Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                                    } # End else statement
                                } # End :SetTagValue while ($true) 
                                $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=$TagValueInput} # Collects $RGObject with additional search values
                            } # End elseif ($OperatorSearchOption -eq '1')
                            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource group name
                                $RGObjectInput = Read-Host "Resource group name" # Operator input for the resource group name
                                if ($RGObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRGTag
                                    Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                                } # End if ($RGObjectInput -eq 'exit')
                                $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                                $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=""}  | Where-Object {$_.ResourceGroupName -like $RGObjectInput} # Collects $RGObject again using the narrower search options
                            } # End elseif ($OperatorSearchOption -eq '2')
                        } # End if ($RGObject.count -gt 1)
                        elseif ($RGObject.count -eq 1) { # elseif statement for a single matching resource group object
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRGTag loop
            } # End else if statment for $OperatorSearchOption -eq '2'
        } # End :SearchAzureByTag while statement 
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceGroupTag