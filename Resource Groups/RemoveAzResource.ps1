function RemoveAzResource {
    Begin {
        :RemoveAzureRSObject while ($true) { # named loop for function
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            if (!$RSObject) { # If statement if $RSObject is $null after calling GetAzRSObject
                :GetAzureRSObject while ($true) { # Named while loop to collect the resource object and confirm its deletion
                    Write-Host "1 Get resource by exact name match" # Write message to screen
                    Write-Host "2 Search for resource " # Write message to screen
                    $OperatorSearchOption = Read-Host "Option?" # Operator input for the type of $RSObject collection
                    if ($OperatorSearchOption -eq 'exit') { # If statement to break :RemoveAzureRSObject
                        Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
                    } # End if ($OperatorSearchOption -eq 'exit')
                    elseif ($OperatorSearchOption -eq '1') { # else if statement for using the full resource name
                        $RSObject = GetAzResource # Calls function GetAzResource and assigns to $RSObject
                        if ($RSObject) { # If statement for an object in $RSObject
                            Break GetAzureRSObject # Breaks :GetAzureRSObject
                        } # End if ($RSObject)
                        else { # Else statement for no object in $RSObject
                            Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
                        } # End else (if ($RSObject))
                    } # End elseif ($OperatorSearchOption -eq '1')
                    elseif ($OperatorSearchOption -eq '2') { # else if statement for searching for the resource
                        $RSObject = SearchAzResourceGroup # Calls function SearchAzResource and assigns to $RSObject
                        if ($RSObject) { # If statement for an object in $RSObject
                            Break GetAzureRSObject # Breaks :GetAzureRSObject
                        } # End if ($RSObject)
                        else { # Else statement for no object in $RSObject
                            Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
                        } # End else (if ($RSObject))
                    } # End elseif ($OperatorSearchOption -eq '2')
                } # End :GetAzureRSObject while ($true)
            } # End if (!$RSObject)
            Write-Host "|////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\|" # Warning write to screen
            Write-Host "|"$RSObject.Name "will be deleted, this cannot be undone" # Warning write to screen
            Write-Host "| All resource locks will be removed automatically if confirmed |" # Warning write to screen
            Write-Host "| This option can be exited by typing 'Exit'                    |" # Warning write to screen
            Write-Host "|\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////|" # Warning write to screen
            $OperatorConfirm = Read-Host "Confirm with 'Y' or 'Yes' (Case Sensitive)" # Operator input on confirming deletion of the resource
            $RSObjectName = $RSObject.Name # Collects the name of the resource group for later use
            if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes") { # If statement for operator confirmation on deletion
                Write-Host "This resource has been approved for deletion"
            } # End if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes")
            else { # Elseif statement for operator input to end this function
                Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
            } # End else (if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes"))
            $Locks = $null # Clears any previous use of $Locks
            $Locks = GetAzResourceLocksAll ($RSObject) # Calls function GetAzResourceLocksAll and assigns to $Locks
            if ($Locks) { # If statement for if function GetAzResourceLock collects any locks and assigns them to $locks
                Write-Host "Removing all locks"... # Message write to screen
                RemoveAzResourceLocks ($Locks) # Calls function RemoveAzResourceLocks
                Write-Host "Locks removed" # Message write to screen
            } # End if ($Locks)
            Write-Host $RSObject.Name"is being removed, this may take a while" # Message write to screen
            Remove-AzResource -Name $RSObject.Name -Force # Removes the resource assigned to $RSObject, -force removes confirmation
            $RSObjectVerify = Get-AzResource -Name $RSObjectName # Collects the resource using $RSObjectName and assigns to $RSObjectVerify
            if (!$RSObjectVerify) { # If statement for $RSObjectVerify being empty (This is a successful deletion)
                Write-Host $RSObjectName "has been deleted" # Write message to screen
                Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
            } # End if (!$RSObjectVerify)
            else { # Else statement for $RSObjectVerify having a value (This is an unsuccessful deletion)
                Write-Host $RSObjectName "was not deleted, you may not have correct permissions" # Write message to screen
                Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
            } # End else (if (!$RSObjectVerify))
        } # End :RemoveAzureRSObject while ($True)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzResource
function GetAzResource { # Function to get a resource, can pipe $RSObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RSObject = $null # Sets $RSObject to $null from previous uses
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResource function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$RSObject) { # Loop to continue getting a resource until the operator provided name matches an existing resource
            $RSObjectInput = Read-Host "Resource name" # Operator input of the resource name
            if ($RSObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResource function was terminated"
                Return # Returns to calling function
            } # End if statement
            $RSObject = Get-AzResource -Name $RSObjectInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the resource from the operator input
            if (!$RSObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource" # Error note
                Write-Host "This is the list of available resources" # Error note
                $RSList = Get-AzResource -ResourceGroupName $RGObject.ResourceGroupName # Collects all resource objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RSObject is assigned
                Write-Host $RSObject.Name 'Has been assigned to "$RSObject"' # Writes the resource name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RSObject  # Returns the value of $RSObject to a function that called it
    } # End begin statement
} # End function
function SearchAzResource { # Search for resource group management function
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