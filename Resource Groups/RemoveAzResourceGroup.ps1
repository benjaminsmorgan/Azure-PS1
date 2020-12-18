# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0

} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    SearchAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroup.ps1
        SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupName.ps1
        SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupType.ps1
        SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupLoc.ps1
        SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupTag.ps1  
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1
} #>    
<# Function Description: {
    GetAzResourceGroup:         Collects resource group object
    SearchAzResouceGroup:       Management function for all SearchAzResourceGroup*
        SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
        SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
        SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
        SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzResourceGroupLocksAll: Collects resource locks
    RemoveAzResourceLocks:      Removes resource locks passed in $Locks
} #>
<# Variables: {
    RemoveAzResourceGroup {
        $RGObject:              Resource group object, used for all actions
        $RGObjectName:          Name of the resource group object, used only in confirmation
        $RGObjectVerify:        Resource group object pulled again using $RGObjectName to check if existing
        $OperatorSearchOption:  Operator input for how to get $RGObject
        $OperatorConfirm:       Operator confirmation info is correctly input
        $Locks:                 All lock objects if existing
        :RemoveAzureRGObject    Named outer loop for running all commands in function
        :GetAzureRGObject       Named inner loop for setting and confirming the resource group object
    GetAzResourceGroup {
            $RGObject:              Resource group object
            $RGObjectInput:         Operator input for the resource group name
            $RGList:                Variable used for printing all resource groups to screen if needed
    }
    SearchAzResourceGroup {
        $SearchAzRG:            Operator input for type of search
        :SearchAzureRG          Named loop for selecting search type
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
    } End SearchAzResourceGroup
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
    }
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
        $OperatorConfirm:       Operator input what locks to collect
        }
    } End RemoveAzResourceGroup
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceGroup > Send $RGObject
            Call GetAzResourceGroup > Get $RGObject
            Call SearchAzResourceGroup > Get $RGObject
                Return RemoveAzResourceGroup > Send $RGObject
            Call GetAzResourceGroupLocksAll > Get $Locks
            Call RemoveAzResourceLocks > Send $Locks
        Return Function > Send $null
}#>
function RemoveAzResourceGroup { # Function to remove a resource group, includes function to remove all locks. Can be called from another function
    Begin {
        :RemoveAzureRGObject while ($true) { # named loop for function
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            :GetAzureRGObject while ($true) { # Named while loop to collect the resource group object and confirm its deletion
                if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                    Write-Host "1 Get resource group by exact name match" # Write message to screen
                    Write-Host "2 Search for resource group" # Write message to screen
                    $OperatorSearchOption = Read-Host "Option?" # Operator input for the type of $RGObject collection
                    if ($OperatorSearchOption -eq 'exit') { # If statement to break :RemoveAzureRGObject
                        Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
                    } # End if ($OperatorSearchOption -eq 'exit')
                    elseif ($OperatorSearchOption -eq '1') { # else if statement for using the full resource group name
                        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
                        if ($RGObject) { # If statement for an object in $RGObject
                            Break GetAzureRGObject # Breaks :GetAzureRGObject
                        } # End if ($RGObject)
                        else { # Else statement for no object in $RGObject
                            Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
                        } # End else (if ($RGObject))
                    } # End elseif ($OperatorSearchOption -eq '1')
                    elseif ($OperatorSearchOption -eq '2') { # else if statement for searching for the resource group
                        $RGObject = SearchAzResourceGroup # Calls function SearchAzResourceGroup and assigns to $RGObject
                        if ($RGObject) { # If statement for an object in $RGObject
                            Break GetAzureRGObject # Breaks :GetAzureRGObject
                        } # End if ($RGObject)
                        else { # Else statement for no object in $RGObject
                            Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
                        } # End else (if ($RGObject))
                    } # End elseif ($OperatorSearchOption -eq '2')
                } # End if statement
            } # End :GetAzureRGObject while ($true)
            Write-Host "|////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\|" # Warning write to screen
            Write-Host "|"$RGObject.ResourceGroupName "will be deleted, this cannot be undone" # Warning write to screen
            Write-Host "| All resource locks will be removed automatically if confirmed |" # Warning write to screen
            Write-Host "| All resources within the resource group will also be deleted  |" # Warning write to screen
            Write-Host "| This option can be exited by typing 'Exit'                    |" # Warning write to screen
            Write-Host "|\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////|" # Warning write to screen
            $OperatorConfirm = Read-Host "Confirm with 'Y' or 'Yes' (Case Sensitive)" # Operator input on confirming deletion of the resource group
            $RGObjectName = $RGObject.ResourceGroupName # Collects the name of the resource group for later use
            if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes") { # If statement for operator confirmation on deletion
                Write-Host "This resource group has been approved for deletion"
            } # End if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes")
            else { # Elseif statement for operator input to end this function
                Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
            } # End else (if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes"))
            $Locks = $null # Clears any previous use of $Locks
            $Locks = GetAzResourceGroupLocksAll ($RGObject) # Calls function GetAzResourceLock and assigns to $Locks
            if ($Locks) { # If statement for if function GetAzResourceLock collects any locks and assigns them to $locks
                Write-Host "Removing all locks"... # Message write to screen
                RemoveAzResourceLocks ($Locks) # Calls function RemoveAzResourceLocks
                Write-Host "Locks removed" # Message write to screen
            } # End if ($Locks)
            Write-Host $RGObject.ResourceGroupName"is being removed, this may take a while" # Message write to screen
            Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force # Removes the resource group assigned to $RGObject, -force removes confirmation
            $RGObjectVerify = Get-AzResourceGroup -Name $RGObjectName # Collects the resource group using $RGObjectName and assigns to $RGObjectVerify
            if (!$RGObjectVerify) { # If statement for $RGObjectVerify being empty (This is a successful deletion)
                Write-Host $RGObjectName "has been deleted" # Write message to screen
            } # End if (!$RGObjectVerify)
            else { # Else statement for $RGObjectVerify having a value (This is an unsuccessful deletion)
                Write-Host $RGObjectName "was not deleted, you may not have correct permissions" # Write message to screen
            } # End else (if (!$RGObjectVerify))
        } # End :RemoveAzureRGObject while ($True)
        Return # Returns to calling function
    } # End begin statement
} # End function