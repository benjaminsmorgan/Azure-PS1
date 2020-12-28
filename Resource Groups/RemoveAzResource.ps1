# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {  
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    SearchAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResource.ps1
        SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
        SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1
} #>
<# Functions Description: {
    RemoveAzResource:           Removes a selected resource
    GetAzResource:              Collects resources within a resource group 
    GetAzResourceGroup:         Gets resource group from full name match
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup*
        SearchAzResourceName:       Searchs for resource using partial name matches on a resource name
        SearchAzResourceType:       Searchs for resource using resource provider or type on a resource or resource
        SearchAzResourceLoc:        Searchs for resource using location matches on a resource
        SearchAzResourceTag:        Searchs for resource using tag matches on a resource
    GetAzResourceLocksAll:      Collects all locks on a resource
    RemoveAzResourceLocks:      Removes resource locks passed in $Locks
} #>
<# Variables: {
    Remove-AzResource {
        :RemoveAzureRSObject   Outer loop for function      
        :GetAzureRSObject      Inner loop to collect $RSObject
        $RSObject:             Resource object
        $OperatorSearchOption: Operator input for method to get $RSObject 
        $RGLocks:              Check if $RSObject's containing resource group has locks
        $OperatorConfirm:      Operator confirmation to delete $RSObject
        $RSObjectName:         $RSObject name, used to check for sucessful deletion
        $Locks:                All locks assigned to $RSObject
        $RSObjectVerify:       Check if $RSObjectName still returns a valid object
        GetAzResource {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name
            $RSList:                Variable used for printing all resources to screen if needed
            GetAzResourceGroup {
                $RGObject:              Resource group object
                $RGObjectInput:         Operator input for the resource group name
                $RGList:                Variable used for printing all resource groups to screen if needed
                :GetAzureResourceGroup  Named loop for getting the resource group object
            } # End GetAzResourceGroup
        } # End GetAzResource 
        SearchAzResource {
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
        } End SearchAzResource
        GetAzResourceLocksAll {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Locks object
        } End GetAzResourceLocksAll
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
        } End RemoveAzResourceLocks
    } End RemoveAzResource   
} #>
<# Process Flow {
    Function
        Call RemoveAzResource > Send $RSObject
            Call GetAzResource > Get $RSObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzResource > Send $RGObject
                End GetAzResource
                    Return RemoveAzResource > Send $RSObject
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
                    Return RemoveAzResource > Send $RSObject
            Call GetAzResourceLocksAll > Get $Locks
                End GetAzResourceLocksAll
                    Return RemoveAzResource > Send $Locks
            Call RemoveAzResourceLocks > Send $Locks
                End RemoveAzResourceLocks
                    Return RemoveAzResourceLocks > Send $null
            End RemoveAzResource
                Return Function > Send $null                                    
}#>  
function RemoveAzResource { Removes a selected resource
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
                        $RSObject = SearchAzResource # Calls function SearchAzResource and assigns to $RSObject
                        if ($RSObject) { # If statement for an object in $RSObject
                            Break GetAzureRSObject # Breaks :GetAzureRSObject
                        } # End if ($RSObject)
                        else { # Else statement for no object in $RSObject
                            Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
                        } # End else (if ($RSObject))
                    } # End elseif ($OperatorSearchOption -eq '2')
                } # End :GetAzureRSObject while ($true)
            } # End if (!$RSObject)
            $RGLocks = $null # Clears $RGLocks from all previous uses
            $RGLocks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName # Collects all locks on $RSObject group and assigns to $RGLocks
            if ($RGLocks) { # If $RGLocks is not empty
                Write-Host $RSObject.Name "cannot be deleted until the locks on"$RSObject.ResourceGroupName"have been removed" # Write message to screen
                Break RemoveAzureRSObject # Breaks :RemoveAzureRSObject
            } # End if ($RGLocks)
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