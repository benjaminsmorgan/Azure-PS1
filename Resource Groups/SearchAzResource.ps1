# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
    SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
    SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
    SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup*
        SearchAzResourceName:       Searchs for resource using partial name matches on a resource name
        SearchAzResourceType:       Searchs for resource using resource provider or type on a resource or resource
        SearchAzResourceLoc:        Searchs for resource using location matches on a resource
        SearchAzResourceTag:        Searchs for resource using tag matches on a resource
} #>
<# Variables: {
    SearchAzResourceGroup {
        :SearchAzureRS          Outer loop for function
        $SearchAzRS:            Operator input for type of search
        $RSObject:              Resource object      
        SearchAzResourceName {
            :SearchAzureRSByName    Outer loop for function
            :SearchAzureRSName      Inner loop for finding resource by name
            $RSObjectInput:         Operator input for the resource name
            $RSObject:              Resource object
            $RGObjectInput:         Operator input for the resource group name
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceName
        SearchAzResourceType {                
            :SearchAzureRSByType    Outer loop for function
            :SearchAzureRPName      Inner lopp for getting the Azure resource provider
            :SearchAzureRSType      Inner loop for getting the Azure resource provider type
            :GetAzureRSObject       Inner loop for collecting the resource object
            $OperatorSearchOption:  Operator input to search by provider or provider and type
            $ProviderList:          List of all Azure resource providers
            $RPObjectInput:         Azure resource provider object input
            $RPObject:              Azure resource provider object
            $RPTObjectList:         List of all types on selected Azure resource provider 
            $RPTObjectInput:        Operator input for Azure resource provider type object
            $RPTObject:             Azure resource provider type object
            $RSObjectInput:         Operator input for the resource name
            $RSObject:              Resource object
            $RGObjectInput:         Operator input for the resource group name       
            $OperatorConfirm:       Operator confirmation that the resource provider and type are correct
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceType
        SearchAzResourceLoc {
            :SearchAzureRSByLoc     Outer loop for function
            :SearchAzureRSLoc       Inner loop for finding resource by location
            :SetLocation            Inner loop for setting $Location
            :GetAzureRSObject       Inner loop for collecting the resource object
            $ValidLocation:         List of all valid Azure locations
            $Location:              Operator input for the resource location
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name 
            $RGObjectInput:         Operator input for the resource group name 
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceLoc
        SearchAzResourceTag {
            :SearchAzureRSByTag     Outer loop for function
            :SearchAzureRSTag       Inner loop for finding resource by tags
            :SetTagName             Inner loop for setting tag name
            :SetTagValue            Inner loop for setting tag value
            $ValidTagName:          List of all available tags in Azure subscription
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $RSObject:              Resource object
            $OperatorSearchOption:  Operator input to narrow search 
            $ForEachCount:          Number used in foreach statement for each found resource          
            $RSObjectInput:         Operator input for the resource name 
            $RGObjectInput:         Operator input for the resource group name
        } End SearchAzResourceTag
    } # End SearchAzResourceGroup
} #>
<# Process Flow {
    Function
        Call SearchAzResource > Get $RSObject
            Call SearchAzResourceName > Get $RSObject
            End SearchAzResourceName
                Return SearchAzResource > Send $RSObject
            Call SearchAzResourceType > Get $RSObject
            End SearchAzResourceType
                Return SearchAzResource > Send $RSObject                
            Call SearchAzResourceLoc  > Get $RSObject
            End SearchAzResourceLoc
                Return SearchAzResource > Send $RSObject
            Call SearchAzResourceTag  > Get $RSObject
            End SearchAzResourceTag
                Return SearchAzResource > Send $RSObject
            End SearchAzResource
                Return Function > Send $RSObject
}#>
function SearchAzResource { # Search for resource group management function
    Begin {
        :SearchAzureRS while($true) { # :SearchAzureRS named loop to select search function
            Write-Host "Azure Resource Search" # Write message to screen
            Write-Host "1 Search by partial name lookup" # Write message to screen
            Write-Host "2 Search by resource type" # Write message to screen
            Write-Host "3 Search by resource location" # Write message to screen
            Write-Host "4 Search by tags" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $SearchAzRG = Read-Host "Option?" # Collects operator input on $SearchAzRG option
            if ($SearchAzRG -eq 'exit') { # Exit if statement for this function
                Break SearchAzureRS # Ends :SearchAzureRS loop, leading to return statement
            } # End if ($SearchAzRG -eq 'exit')
            elseif ($SearchAzRG -eq '1') { # Elseif statement for searching by name
                Write-Host "Search by name" # Write message to screen
                $RSObject = SearchAzResourceName # Calls function to assign object to $RSObject
            } # End elseif ($SearchAzRG -eq '1')
            elseif ($SearchAzRG -eq '2') { # Elseif statement for searching by resource provider and type
                Write-Host "Search by type" # Write message to screen
                $RSObject = SearchAzResourceType # Calls function to assign object to $RSObject
            } # End elseif ($SearchAzRG -eq '2')
            elseif ($SearchAzRG -eq '3') { # Elseif statement for searching by location
                Write-Host "Search by location" # Write message to screen
                $RSObject = SearchAzResourceLoc # Calls function to assign object to $RSObject
            } # End elseif ($SearchAzRG -eq '3')
            elseif ($SearchAzRG -eq '4') { # Elseif statement for searching by tag
                Write-Host "Search by tag" # Write message to screen
                $RSObject = SearchAzResourceTag
            } # End elseif ($SearchAzRG -eq '4')
            Return $RSObject # Returns to calling function if search option is used
        } # End :SearchAzureRS while($true)
        Return # Returns to calling function if no search option is used
    } # End begin statement
} # End SearchAzResource 
function SearchAzResourceName { # Searchs for resource group using partial name matches on the group name, or a contained resource name
    Begin {
        :SearchAzureRSByName while($true) { # :SearchAzureRSByName loop finds a resource group off partial name inputs
            :SearchAzureRSName while ($true) { # :SearchAzureRSName loop finds resource group off partial resource name inputs
                $RSObjectInput = Read-Host "Parital resource name" # Operator input for $RSObjectInput
                if ($RSObjectInput -eq 'exit') { # Ends SearchAzureRSName loop if operator types exit
                    Break SearchAzureRSByName # Breaks the SearchAzureRSName loop
                } # End if ($RSObjectInput -eq 'exit') 
                $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                $RGObjectInput = Read-Host "Resource group"
                if ($RGObjectInput) { # If $RGObjectInput has a value
                    $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                    $RSObject = Get-AzResource | Where-Object {$_.Name -Like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Performs search and assigns any matching resources to $RSObject
                } # End if ($RGObjectInput)
                else { # If $RGObjectInput is $null
                    $RSObject = Get-AzResource | Where-Object {$_.Name -Like $RSObjectInput} # Performs search and assigns any matching resources to $RSObject
                } # End else (if ($RGObjectInput))
                if ($RSObject) { # If statement if $RSObject value is found
                    if ($RSObject.count -gt 1) { # If statement if more than one $RSObject value found
                        Write-Host "More than one value found" # Write message to screen
                        Write-Host " " # Write message to screen
                        $ForEachCount = 1 # Counter used in foreach statement
                        foreach ($Name in $RSObject) { # For each resource name in $RSObject
                            Write-Host "" # Write message to screen
                            Write-Host "Matching resource" $ForEachCount # Write message to screen
                            Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                            Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                            $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                        } # End foreach ($Name in $RSObject)
                        Write-Host "" # Write message to screen
                    } # End if ($RSObject.count -gt 1) 
                    else { # If statement for single $RSObject value
                        Return $RSObject # Returns $RSObject to calling function
                    } # End else )(if ($RSObject.count -gt 1) )
                } # End if ($RSObject)
                else { # Else statment for no $RSObject value found
                    Write-Host "" # Write message to screen
                    Write-Host "No resource found that matches" # Write message to screen
                    Write-Host "Please try again" # Write message to screen
                    Write-Host "" # Write message to screen
                } # End else (if ($RSObject))
            } # End :SearchAzureRSName while ($true)
        } # End :SearchAzureRSByName while($true)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceName
function SearchAzResourceType { # Searchs for resource group resource provider or type on a resource or resource group
    Begin {
        $ProviderList = Get-AzResourceProvider | select-object ProviderNamespace # Collects all current Azure resource provider names
        :SearchAzureRSByType while($True) { # :SearchAzureRSByType loop finds a resource group off resource providers and types
            Write-Host "Resource search by resource type" # Write message to screen
            Write-Host "1 Search by provider type" # Write message to screen
            Write-Host "2 Search by resource type" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRSByType loop if operator types exit
                Break SearchAzureRSByType # Breaks the SearchAzureRSByType loop
            } # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for searching by resource provider
                :SearchAzureRSProvider while($True) { # :SearchAzureRSProvider loops finds a resource group off resource types
                    $RPObject = $null # Clears listed $var from all previous use with in this function
                    $RSObject = $null # Clears listed $var from all previous use with in this function
                    Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                    :SearchAzureRPName while ($True) { # :SearchAzureRPName loop, used for getting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider" # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq 'exit') {  # If statement to end :SearchAzureRSType loop
                            Break SearchAzureRSProvider # Ends :SearchAzureRSType loop, returns to :SearchAzureRSByType loop
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
                                Write-Host "Please re-enter the provider name"  # Message write to screen
                            } # End else (if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'Yes'))
                        } # End elseif ($RPObject.count -eq 1)
                        elseif ($RPObject.count -gt 1) { # Elseif statement for multiple resource providers being found
                            Write-Host "The resource provider entry provided matches more than 1 provider" # Write message to screen
                            Write-Host " " # Write message to screen
                            Write-Host $RPObject.ProviderNamespace -Separator `n # Writes $RPObject to screen
                            Write-Host " " # Write message to screen
                            Write-Host "Please re-enter the provider name" # Write message to screen    
                        } # End elseif ($RPObject.count -gt 1)
                    } # End :SearchAzureRPName while ($True)
                    $RPObject = $RPObject.ProviderNamespace+"/*"
                    $RSObject = Get-AzResource | Where-Object {$_.ResourceType -like $RPObject} # Collects all resources with a resource provider matching $RPObject
                    if (!$RSObject) { # If statement if no resources match the resource provider type
                        Write-Host "No resources found with the selected provider type"$RPObject # Write message to screen
                        Break SearchAzureRSProvider # Ends :SearchAzureRSProvider loop, returns to :SearchAzureRSByType loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($True) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource provider type
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSType
                                Break SearchAzureRSProvider # Ends :SearchAzureRSProvider loop, returns to :SearchAzureRSByType loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RSObject = Get-AzResource | Where-Object {$_.Name -Like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput -and $_.ResourceType -like $RPObject} # Collects $RSObject again using the narrower search options
                        } # if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            Write-Host "Returning with RSObject" # Write message to screen
                            Return $RSObject # Returns $RSObject to calling function # Returns $RSObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSType while($True)
            } # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for searching by resource provider plus resource type
                :SearchAzureRSType while($True) { # :SearchAzureRSType loops finds a resource group off resource types
                    $RPObject = $null # Clears listed $var from all previous use with in this function
                    $RPTObject = $null # Clears listed $var from all previous use with in this function
                    $RSObject = $null # Clears listed $var from all previous use with in this function
                    Write-Host $ProviderList.ProviderNamespace -Separator `n # Writes resource provider list to screen
                    :SearchAzureRPName while ($True) { # :SearchAzureRPName loop, used for getting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider" # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq 'exit') {  # If statement to end :SearchAzureRSType loop
                            Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRSByType loop
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
                    } # End :SearchAzureRPName while ($True)
                    $RPTObjectList = $RPObject.ResourceTypes # Collects all resource types under $RPObject
                    :GetAzureRPTName while ($True) { # :SearchAzureRPTName loop, used for getting a resource provider type
                        Write-Host $RPTObjectList.ResourceTypeName -Separator `n # Writes $RPObjects.ResourceTypes list to screen
                        $RPTObjectInput = Read-Host "Resource provider type" # Operator input for the resource provider type name
                        if ($RPTObjectInput -eq 'exit') { # If statement for exiting SearchAzureRSType 
                            Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRSByType loop
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
                        Break SearchAzureRSType # Ends :SearchAzureRSType loop, returns to :SearchAzureRSByType loop
                    } # End if (!$RSObject)
                    :GetAzureRSObject while ($True) { # :GetAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource provider type
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSType
                                Break SearchAzureRSType # # Ends :SearchAzureRSType loop, returns to :SearchAzureRSByType loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RSObject = Get-AzResource -ResourceType $RPTObjectName | Where-Object {$_.Name -Like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RSObject again using the narrower search options
                        } # if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            Write-Host "Returning with RSObject" # Write message to screen
                            Return $RSObject # Returns $RSObject to calling function \
                        } # End elseif ($RSObject.count -eq 1) 
                    } # End :GetAzureRSObject while ($True)
                } # End :SearchAzureRSType while($True)
            } # End elseif ($OperatorSearchOption -eq '2')
        } # End :SearchAzureRSByType while($True)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceType
function SearchAzResourceLoc { # Searchs for resource group using location matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
        :SearchAzureRSByLoc while($true) { # :SearchAzureRSByLoc loop finds a resource group off partial name inputs
            :SearchAzureRSLoc while ($true) { # :SearchAzureRSLoc loop finds resource group off location
                Write-Host "Search by resource location" # Write message to screen
                :SetLocation while ($true) { # Loop for getting and verifing $Location
                    $Location = Read-Host "Resource location" # Operator input for the location
                    if ($Location -eq 'exit') { # If statement to end this function
                        Break SearchAzureRSByLoc # Ends :SearchAzureRSByLoc
                    } # End if ($Location -eq 'exit')
                    elseif ($Location -iin $ValidLocation.Location) { # Validates $Location against $ValidLocation
                        Break SetLocation # End :SetLocation while ($true) 
                    } # End elseif elseif ($Location -iin $ValidLocation.Location)
                    else { # Else statement for $Location not matching anything in $ValidLocation
                        Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                        Write-Host $ValidLocation.Location -Separator `n # Outputs the valid location lists
                    } # End else (if ($Location -eq 'exit'))
                } # End :SetLocation while ($true)
                $RSObject = Get-AzResource | Where-Object {$_.Location -eq $Location} # Collects all resource objects where location matches $Location
                if (!$RSObject) { # If statement if no resources match the resource location
                    Write-Host "No resources found in the location"$Location # Write message to screen
                    Break SearchAzureRSLoc # Ends SearchAzureRSLoc
                } # End if (!$RSObject)
                :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                    if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource location
                        Write-Host "Multiple resources found" # Write message to screen
                        $ForEachCount = 1 # Counter used in foreach statement
                        foreach ($Name in $RSObject) { # For each resource name in $RSObject
                            Write-Host "" # Write message to screen
                            Write-Host "Matching resource" $ForEachCount # Write message to screen
                            Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                            Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                            $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                        } # End foreach ($Name in $RSObject)
                        Write-Host "" # Write message to screen
                        $RSObjectInput = Read-Host "Resource name" # Collects resource name value to narrow selection
                        if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSLoc
                            Break SearchAzureRSByLoc # Ends :SearchAzureRSByLoc 
                        } # End if ($RSObjectInput -eq 'exit')
                        $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                        $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                        $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                        $RSObject = Get-AzResource | Where-Object {$_.Location -eq $Location -and $_.Name -like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RSObject again using the narrower search options
                    } # End if ($RSObject.count -gt 1)
                    elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                        Write-Host "Returning with RSObject" # Write message to screen
                        Return $RSObject # Returns $RSObject to calling function # Returns $RSObject to calling function
                    } # End if ($RSObject.count -eq 1) 
                } # End :GetAzureRSObject while ($True)
            } # End :SearchAzureRSLoc loop
        } # End :SearchAzureRSByLoc while($true)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceLoc
function SearchAzResourceTag { # Searchs for resource group using tag matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidTagName = Get-AzTag # Collects the list of all existing tags
        :SearchAzureRSByTag while($true) { # :SearchAzureRSByTag loop finds a resource group off tag values
            :SearchAzureRSTag while ($true) { # :SearchAzureRSTag loop finds resource group off Tag
                Write-Host "Search by resource Tag" # Write message to screen
                $TagNameInput = $null # Clears $var from previous use
                $TagValueInput = $null # Clears $var from previous use
                $RSObject = $null # Clears $var from previous use
                :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                    $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                    if ($TagNameInput -eq 'exit') { # If statement to end this function
                        Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                    } # End if ($TagNameInput -eq 'exit')
                    elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                        Break SetTagName # End :SetTagName while ($true) 
                    } # End elseif ($TagNameInput -iin $ValidTagName.Name)
                    else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                        Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                        Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                    } # End if ($TagNameInput -eq 'exit')
                } # End :SetTagName while ($true)
                $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                    :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                        $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                        $TagValueInput = Read-Host "Tag value" # Operator input for the tag value
                        if ($TagValueInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($TagValueInput -eq 'exit')
                        elseif ($TagValueInput -iin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                            Break SetTagValue # Breaks out of :SetTagValue loop
                        } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                        else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                            Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                        } # End else (if ($TagValueInput -eq 'exit'))
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
                    Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                } # End if (!$RSObject)
                :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                    if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource tag
                        if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                        } # End if ($TagValueInput) 
                        else { # else statement for $TagValueInput not having a value
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            Write-Host "1 Narrow search using tag value" # Write message to screen
                            Write-Host "2 Narrow Search using resource name" # Write message to screen
                            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                        } # End else if ($TagValueInput)
                        if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($OperatorSearchOption -eq 'exit')
                        elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                            $TagValueInput = Read-Host "Tag value" # Operator input for $TagValueInput
                            $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects $RSObject with additional search values
                        } # End elseif ($OperatorSearchOption -eq '1')
                        elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource name
                            $RSObjectInput = Read-Host "Resource name" # Operator inout for the resource name
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RSObject = Get-AzResource -TagName $TagNameInput | Where-Object {$_.Name -like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RSObject again using the narrower search options
                        } # End elseif ($OperatorSearchOption -eq '2')
                    } # End if ($RSObject.count -gt 1)
                    elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                        Write-Host "Returning with RSObject" # Write message to screen
                        Return $RSObject # Returns $RSObject to calling function # Returns $RSObject to calling function
                    } # End if ($RSObject.count -eq 1) 
                } # End :GetAzureRSObject while ($True)
            } # End :SearchAzureRSTag while ($true)
        } # End :SearchAzureRSByTag while($true)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceTag