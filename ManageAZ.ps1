# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    None:                       https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    ManageAzResourceGroups:     TBD
    ManageAzStorage:            TBD
    ManageAzCompute:            TBD
    ManageAzNetwork:            TBD
    ManageAzMonitoringBackup:   TBD
    ManageAzureADRBAC:          TBD
} #>
<# Functions Description: {
    ManageAzResourceGroups:     TBD
    ManageAzStorage:            TBD
    ManageAzCompute:            TBD
    ManageAzNetwork:            TBD
    ManageAzMonitoringBackup:   TBD
    ManageAzureADRBAC:          TBD
} #>
<# Variables: {
   ManageAz{
       :TBD                         TBD
       TBD:                         TBD
   }
} #>
<# Process Flow {
    ManageAZ
        Call ManageAzResourceGroups
        Call ManageAzStorage
        Call ManageAzCompute
        Call ManageAzNetwork
        Call ManageAzMonitoringBackup
        Call ManageAzureADRBAC
}#>
function ManageAz {
    Begin {
        :ManageAzure while($true) {
            Write-Host "Azure Management"
            Write-Host "1 Resource Groups"
            Write-Host "2 Storage"
            Write-Host "3 Compute"
            Write-Host "4 Network"
            Write-Host "5 Monitoring and Backups"
            Write-Host "6 Azure AD and RBAC"
            Write-Host "'Exit'"
            $ManAzure = Read-Host "Option?"
            if ($ManAzure -eq 'exit') {
                Break ManageAZ
            } # End if statement
            elseif ($ManAzure -eq '1') {
                $RGObject, $RSOBject = ManageAzResourceGroup
            } # End elseif statement
            elseif ($ManAzure -eq '2') {
                ManageAzStorage ($RGObject, $RSOBject)
            } # End elseif statement
            elseif ($ManAzure -eq '3') {
                ManageAzCompute
            } # End elseif statement
            elseif ($ManAzure -eq '4') {
                Functionnamegohere
            } # End elseif statement
            elseif ($ManAzure -eq '5') {
                Functionnamegohere
            } # End elseif statement
            elseif ($ManAzure -eq '6') {
                Functionnamegohere
            } # End elseif statement
            elseif ($ManAzure -eq '7') {
                Functionnamegohere
            } # End elseif statement
        }# End :ManageAzure while loop
    } # End begin statement
} # End function
# ManageAzResourceGroup
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.2.0
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Remove-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-aztag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroup.ps1
        SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupName.ps1
        SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupType.ps1
        SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupLoc.ps1
        SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupTag.ps1    
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    NewAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/NewAzResourceGroup.ps1 
    RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/RemoveAzResourceGroup.ps1
    RemoveAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/RemoveAzResource.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    SearchAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResource.ps1
        SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
        SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
    ManageAzResourceGroupLocks: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ManageAzResourceGroupLocks.ps1
        NewAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceGroupLock.ps1
        NewAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceLock.ps1
        GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLocksAll.ps1
        GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLockNamed.ps1
        GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLockNamed.ps1
    ManageAzResourceGroupTags:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ManageAzResourceGroupTags.ps1    
        SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
        AddAzResourceGroupTag:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzResourceGroupTag.ps1
        AddAzResourceTag:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzResourceTag.ps1
        GetAzResourceGroupTags:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/GetAzResourceGroupTags.ps1
        GetAzResourceTags:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/GetAzResourceTags.ps1
        RemoveAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceGroupTag.ps1
        RemoveAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceTag.ps1
        RemoveAzResourceGroupTags:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceGroupTags.ps1
        RemoveAzResourceTags:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceTags.ps1
} #>
<# Functions Description: {
    ManageAzResourceGroup:      Manages all functions related to Resource Group objects
        SearchAzResouceGroup:       Management function for all SearchAzResourceGroup*
            SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
            SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
            SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
            SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
        GetAzResourceGroup:         Gets resource group from full name match
        NewAzResourceGroup:         Creates a resource group object
        RemoveAzResourceGroup:      Removes a resource group object
        RemoveAzResource:           Removes a selected resource    
        GetAzResource:              Gets a resource from a full name match
        SearchAzResource:           Management function for all SearchAzResource*
            SearchAzResourceName:       Searches for a resource using a partial name match
            SearchAzResourceType:       Searches for a resource usting a resource provider or type match
            SearchAzResourceLoc:        Searches for a resource using a location match
            SearchAzResourceTag:        Searches for a resource using a tag match
        ManageAzResourceGroupLocks: Management function for Locks functions
            NewAzResourceGroupLock:     Create a new resource lock on a resource group
            GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
            GetAzResourceGroupLockNamed:Collects a named locks on a resource group
            GetAzResourceLocksAll:      Collects all locks on a resource
            GetAzResourceLockNamed:     Collects a named lock on a resource
        ManageAzResourceGroupTags:  Management function for tags functions
            SetAzTagPair:               Create a tag for multiple uses
            AddAzResourceGroupTag:      Create a new resource tag on a resource group
            AddAzResourceTag:           Create a new resource tag on a resource
            GetAzResourceGroupTags:     Get all tags on a resource group
            GetAzResourceTags:          Get all tags on a resource
            RemoveAzResourceGroupTag:   Remove a named tag from a resource group
            RemoveAzResourceTag:        Remove a named tag from a resource
            RemoveAzResourceGroupTags:  Remove all tags from a resource group
            RemoveAzResourceTags:       Remove all tags from a resource   
} #>
<# Variables: {
    ManageAzResourceGroup {
        $OperatorSearchOption:      Operator input for search option
        :ManageAzureRG              Named loop for selecting the management option
        SearchAzResourceGroup{}     Gets $RGObject
            SearchAzResourceGroupName{} Gets $RGObject
            SearchAzResourceGroupType{} Gets $RGObject
            SearchAzResourceGroupName{} Gets $RGObject
            SearchAzResourceGroupTag{}  Gets $RGObject
        GetAzResourceGroup{}        Gets $RGObject
        NewAzResourceGroup{}        Creates $RGObject
        RemoveAzResourceGroup{}     Removes $RGObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceGroupLocksAll{}Gets $Locks
            RemoveAzResourceLocks{}     Removes $Locks
        Remove-AzResource{}         Removes $RSObject
            SearchAzResource{}          Gets $RSObject
                SearchAzResourceName{}      Gets $RSObject
                SearchAzResourceType{}      Gets $RSObject
                SearchAzResourceLoc{}       Gets $RSObject
                SearchAzResourceTag{}       Gets $RSObject
            GetAzResourceLocksAll{}     Gets $Locks
            RemoveAzResourceLocks{}     Removes $Locks
        GetAzResource{}             Gets Gets $RSObject
        SearchAzResource{}          Gets $RSObject
            SearchAzResourceName{}      Gets $RSObject
            SearchAzResourceType{}      Gets $RSObject
            SearchAzResourceLoc{}       Gets $RSObject
            SearchAzResourceTag{}       Gets $RSObject
        ManageAzResourceGroupLocks{}Gets $Locks
            NewAzResourceGroupLock{}    Creates $Locks
                GetAzResourceGroup{}        Gets $RGObject
            NewAzResourceLock{}         Creates $Locks
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceGroupLocksAll{}Gets $Locks
                GetAzResourceGroup{}        Gets $RGObject            
            GetAzResourceGroupLockNamed{}Gets $Locks
                GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceLocksAll{}     Gets $Locks
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceLockNamed{}    Gets $Locks
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceLocks{}     Removes $Locks
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
        ManageAzResourceGroupTags{} Gets $TagArray
            SetAzTagPair{}              Creates $TagArray
            AddAzResourceGroupTag{}     Creates $TagArray
                GetAzResourceGroup{}        Gets $RGObject
            AddAzResourceTag{}          Creates $TagArray
                GetAzResource{} 
                    GetAzResourceGroup{} 
            GetAzResourceGroupTags{}    Gets $TagArray
                GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceTags{}         Gets $TagArray
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceGroupTag{}  Removes $TagArray
                GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceTag{}       Removes $TagArray
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceGroupTags{} Removes $TagArray
                GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceTags{}      Removes $TagArray
                GetAzResource{}             Gets $RSObject
                    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroups
            Call SearchAzResourceGroup > Get $RGObject
                Call SearchAzResourceGroupName > Get $RGObject
                Call SearchAzResourceGroupType > Get $RGObject
                Call SearchAzResourceGroupLoc  > Get $RGObject
                Call SearchAzResourceGroupTag  > Get $RGObject
                End SearchAzResourceGroup    
                    Return SearchAzResourceGroup > Send $RGObject
                        Return ManageAzResourceGroups > Send $RGObject
            Call GetAzResourceGroup > Get $RGObject
                Return ManageAzResourceGroup > Send $RGObject
            Call NewAzResourceGroup
                Return ManageAzResourceGroup > Send $RGObject
            Call RemoveAzResourceGroup > Send $RGObject
                Call GetAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceGroup > Send $RGObject
                Call GetAzResourceGroupLocksAll > Get $Locks
                    Return RemoveAzResourceGroup > Send $Locks
                Call RemoveAzResourceLocks > Send $Locks
                    Return RemoveAzResourceGroup > Send $Null
                End RemoveAzResourceGroup
                    Return ManageAzResourceGroups > Send $null
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
                    Return ManageAzResourceGroup > Send $null  
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
                    Return ManageAzResourceGroups > Send $RSObject
            Call ManageAzResourceGroupLock
                Call NewAzResourceGroupLock > Get $Locks
                    Return ManageAzResourceGroupLock > Send $Locks
                Call NewAzResourceLock > Get $Locks 
                    Return ManageAzResourceGroupLock > Send $Locks
                Call GetAzResourceGroupLocksAll > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                        Return GetAzResourceGroupLocksAll > Send $RGObject
                    Return ManageAzResourceGroupLock > Send $Locks
                Call GetAzResourceGroupLockNamed > Get $Locks
                    Call GetAzResourceGroup > Get RGObject
                        Return GetAzResourceGroup > Send $RGObject
                    Return ManageAzResourceGroupLock > Send $Locks                
                Call GetAzResourceLocksAll > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                        Return GetAzResourceLocksAll > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return GetAzResource > Send $RSObject
                    Return ManageAzResourceGroupLock > Send $Locks
                Call GetAzResourceLockNamed > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                        Return GetAzResourceLockNamed > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return GetAzResourceLockNamed > Send $RSObject
                    Return ManageAzResourceGroupLock > Send $Locks
                Call RemoveAzResourceLocks > Send $Locks
                    Return ManageAzResourceGroupLock 
                End ManageAzResourceGroupLock
                    Return ManageAzResourceGroup > Send $null
            Call ManageAzResourceGroupTags > Send $RGObject, $RSObject
                Call SetAzTagPair > Get $TagNameInput, $TagValueInput
                    Return ManageAzResourceGroupTags > Send $TagNameInput, $TagValueInput
                Call AddAzResourceGroupTag > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return AddAzResourceGroupTag > Send $RGObject
                    End function AddAzResourceGroupTag
                    Return ManageAzResourceGroupTags > Send $TagList
                Call AddAzResourceTag > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return AddAzResourceTag > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return AddAzResourceTag > Send $RSObject
                    End AddAzResourceTag
                    Return ManageAzResourceGroupTags > Send $TagList
                Call GetAzResourceGroupTags > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return GetAzResourceGroupTags > Send $RGObject
                    End GetAzResourceGroupTags
                    Return ManageAzResourceGroupTags > Send $TagList
                Call GetAzResourceTags > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return GetAzResourceTags > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return GetAzResourceTags > Send $RSObject
                    End GetAzResourceTags
                    Return ManageAzResourceGroupTags > Send $TagList
                Call RemoveAzResourceGroupTag > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return RemoveAzResourceGroupTag > Send $RGObject
                    End RemoveAzResourceGroupTag
                    Return ManageAzResourceGroupTags > Send $TagList
                Call RemoveAzResourceTag  > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return RemoveAzResourceTag > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return RemoveAzResourceTag > Send $RSObject
                    End RemoveAzResourceTag
                    Return ManageAzResourceGroupTags > Send $TagList
                Call RemoveAzResourceGroupTags > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return RemoveAzResourceGroupTags > Send $RGObject
                    End RemoveAzResourceGroupTags
                    Return ManageAzResourceGroupTags > Send $TagList
                Call RemoveAzResourceTags > Get $TagList
                    Call GetAzResourceGroup > Get $RGObject
                        Return RemoveAzResourceTags > Send $RGObject
                    Call GetAzResource > Get $RSObject
                        Return RemoveAzResourceTags > Send $RSObject
                    End RemoveAzResourceTags
                    Return ManageAzResourceGroupTags > Send $TagList
                End ManageAzResourceGroupTags
                    Return ManageAzResourceGroups > Send $null
            End Function ManageAzResourceGroups
                Return Function > Send $null                                    
}#>  
function ManageAzResourceGroup {
    Begin {
        :ManageAzureRG while($true) {
            Write-Host "Resource Group Management"
            Write-Host "1 Search For Resource Group"
            Write-Host "2 Get Resource Group"
            Write-Host "3 New Resource Group"
            Write-Host "4 Remove Resource Group"
            Write-Host "5 Remove Resource from Group"
            Write-Host "6 Search For Resource"
            Write-Host "7 Manage Locks"
            Write-Host "8 Manage Tags"
            Write-Host "'Exit to return'"
            $OperatorSearchOption = Read-Host "Option?"
            if ($OperatorSearchOption -eq 'exit') {
                Break ManageAzureRG
            } # End if statement
            elseif ($OperatorSearchOption -eq '1') {
                Write-Host " Search for resource group"
                $RGObject = SearchAzResourceGroup
                $RGObject
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '2') {
                Write-Host "Get resource group"
                $RGObject = GetAzResourceGroup
                $RGObject
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '3') {
                Write-Host "New resource group"
                $RGObject = NewAzResourceGroup
                $RGObject
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '4') {
                Write-Host "Remove resource group"
                RemoveAzResourceGroup ($RGObject)
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '5') {
                Write-Host "Remove resource from group"
                Write-Host "Additional settings may need to be" 
                Write-Host "changed prior to removing a resource"
                RemoveAzResource ($RSObject)
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '6') {
                $RSObject = SearchAzResource
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '7') {
                ManageAzResourceGroupLocks ($RGObject, $RSObject)
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '8') {
                ManageAzResourceGroupTags ($RGObject, $RSObject)
                Write-Host "Returned to ManageAzResourceGroup"
            } # End elseif statement
            elseif ($OperatorSearchOption -eq '0') {
                $RGObject = $null
                $RSObject = $null
                Write-Host '$RGObject has been cleared'
                Write-Host '$RSObject has been cleared'
            }
            if ($RGOBject) {
            Write-Host $RGObject.ResourceGroupName "is the currently selected resource group"
            Write-Host 'Use option "0" to clear $RGObject'
            }
            if ($RSObject) {
                Write-Host $RSObject.Name "is the currently selected resource"
                Write-Host 'Use option "0" to clear $RSObject'
            }
            $OperatorSearchOption = $null
        }# End :ManageAzResourceGroup while loop
    } # End begin statement
} # End function
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
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
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
function NewAzResourceGroup { # Function to create a resource group, can pipe $RGObject to another function.
    Begin {
        :NewAzureRGObject while ($true) {
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            $Tag = $null # Clears all previous use
            $RGObject = $null # Clears all previous use
            :SetTag while ($true) { # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag (Enter 'skip' to leave untagged)" # Operator input for a tag name
                if ($TagNameInput -eq 'skip') {
                    Break SetTag # Breaks :SetTagLoop, allowing this step to be skipped
                } # End if ($TagNameInput -eq 'skip')
                if ($TagNameInput -eq 'exit') {
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag" # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput} # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }" # Writes tag to screen
                $OperatorConfirm = Read-Host "This is the tag to be applied to the new resource group" # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $Tag being correct
                    break SetTag # Ends :SetTag while loop
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')
            } # End :SetTag while ($true)
            :SetName while ($true) { # Loop for creating and verifying $RGObject
                $RGObjectInput = Read-Host "New resource group name" # Operator input for the resource group name
                $OperatorConfirm = Read-Host "The new resource group will be called" $RGObjectInput # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $RGObject being correct
                    Break SetName # Ends :SetName while loop
                } # End  if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End elseif ($OperatorConfirm -eq 'exit')    
            } # End while statement
            :SetLocation while ($true) { # Loop for creating and verifing $LocationInput
                $LocationInput = Read-Host "New resource group location" # Operator input for the location
                if ($LocationInput -eq 'exit') { # elseif statement to end this function
                    Break NewAzureRGObject # Breaks :NewAzrueRGObject
                } # End if ($LocationInput -eq 'exit')
                if ($LocationInput -iin $ValidLocation.Location) { # Validates $LocationInput against $ValidLocation
                    $OperatorConfirm = Read-Host "The new resource group will be located in" $LocationInput # Operator confirmation that the location is correct
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If statement for $LocationInput being correct
                        Break SetLocation # Ends :SetLocation while loop
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    elseif ($OperatorConfirm -eq 'exit') { # elseif statement to end this function
                        Break NewAzureRGObject # Breaks :NewAzrueRGObject
                    } # End elseif ($OperatorConfirm -eq 'exit')
                } # End if ($LocationInput -iin $ValidLocation.Location) 
                else { # Else statement for $LocationInput not matching anything in $ValidLocation
                    Write-Host "The location provided is not valid, please chose from the following" # Error reporting to the screen
                    Write-Host $ValidLocation.Location -Separator `n # Outputs the valid location lists
                } # End else (if ($LocationInput -iin $ValidLocation.Location)) 
            } # End :SetLocation while ($true)
            $ErrorActionPreference='Continue' # Turns back on error reporting, used if policy denies creation of a resource group
            if ($Tag) { # If statement for creating a resource group with the assigned tag
                $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location $LocationInput -Tag $Tag # Creates the resouce group and assigns to $RGObject
            } # End if ($Tag)
            else { # Create a resource group without a tag
                $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location $LocationInput # Creates the resouce group and assigns to $RGObject
            } # End else (if ($Tag))
            if ($RGObject) { # If $RGObject has been successfully created
                Return $RGObject # Returns to calling function
            } # End if ($RGObject)
            else { # else $RGObject has not been created
                Break NewAzrueRGObject # Ends :NewAzureRGObject loop
            } # End else (if ($RGObject))
        } # End :NewAzureRGObject while ($true)
        Return # Returns to a function that called it
    } # End of begin statement
} # End of function
function RemoveAzResourceGroup { # Function to remove a resource group, includes function to remove all locks. Can be called from another function
    Begin {
        :RemoveAzureRGObject while ($true) { # named loop for function
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                :GetAzureRGObject while ($true) { # Named while loop to collect the resource group object and confirm its deletion
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
                } # End :GetAzureRGObject while ($true)
            } # End if (!$RGObject)
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
                Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
            } # End if (!$RGObjectVerify)
            else { # Else statement for $RGObjectVerify having a value (This is an unsuccessful deletion)
                Write-Host $RGObjectName "was not deleted, you may not have correct permissions" # Write message to screen
                Break RemoveAzureRGObject # Breaks :RemoveAzureRGObject
            } # End else (if (!$RGObjectVerify))
        } # End :RemoveAzureRGObject while ($True)
        Return # Returns to calling function
    } # End begin statement
} # End function
function RemoveAzResource { # Removes a selected resource
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
            $RGLocks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName -AtScope # Collects all locks on $RSObject group and assigns to $RGLocks
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
            Remove-AzResource -Name $RSObject.Name -ResourceGroup $RSObject.ResourceGroupName -ResourceType $RSObject.ResourceType -Force # Removes the resource assigned to $RSObject, -force removes confirmation
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
function ManageAzResourceGroupLocks {
    Begin {
        :ManageAzureRGLocks while($true) { # :ManageAzureRGLocks loop for managing resource group locks 
            Write-Host "Resource Group Lock Management" # Write message to screen
            Write-Host "1 New Resource Group Lock" # Write message to screen
            Write-Host "2 New Resource Lock" # Write message to screen
            Write-Host "3 Get All Resource Group Locks" # Write message to screen
            Write-Host "4 Get Named Resource Group Lock" # Write message to screen
            Write-Host "5 Get All Resource Locks" # Write message to screen
            Write-Host "6 Get Named Resource Lock" # Write message to screen
            Write-Host "7 Remove Locks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGLocks # Ends :ManageAzureRGLocks loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for new resource group lock
                Write-Host "New Resource Group Lock" # Write message to screen
                $Locks = NewAzResourceGroupLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource lock
                Write-Host "New Resource Lock" # Write message to screen
                $Locks = NewAzResourceLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option to get all locks on a resource group
                Write-Host "Get All Resource Group Locks" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get a named lock on a resource group
                Write-Host "Get Named Resource Group Lock" # Write message to screen
                $Locks = GetAzResourceGroupLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get all locks on a resource
                Write-Host "Get All Resource Locks" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to get a named lock on a resource
                Write-Host "Get Named Resource Lock" # Write message to screen
                $Locks = GetAzResourceLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '6')
            elseif ($OperatorManageOption -eq '7') { # Option to remove locks
                Write-Host "7 Remove Locks" # Write message to screen
                RemoveAzResourceLocks ($Locks) # Calls function to remove locks, passed $Locks
            } # End elseif ($OperatorManageOption -eq '7')
            elseif ($OperatorManageOption -eq '0') { # Option to clear the current $Locks, $RGObject, $RSObject values
                $OperatorSelect = Read-Host "Lock, RGObject, and/or RSObject" # Operator input for removing a value from $var
                if ($OperatorSelect -like "*Lock*") { # Option for clearing $Locks
                    $Locks = $null # Clears $Locks value
                    Write-Host '$Locks has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*Lock*")
                if ($OperatorSelect -like "*RGObject*") { # Option for clearing $RGObject
                    $RGObject = $null # Clears $RGObject value
                    Write-Host '$RGObject has been cleared' # Write message to screen
                } # #End if ($OperatorSelect -like "*RGObject*")
                if ($OperatorSelect -like "*RSObject*") { # Option for clearing $RSObject
                    $RSObject = $null # Clears $RSObject value
                    Write-Host '$RSObject has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*RSObject*")
            } # End elseif ($OperatorManageOption -eq '0')
            if ($Locks -or $RGObject -or $RSObject) { # If $Locks, $RGObject, or $RSObject object has a value, writes info to screen
                if ($Locks) { # If $Locks has a value
                    if ($Locks.count -gt 1) { # If $Locks has 2 or more objects
                        Write-Host "The following locks are selected"
                        $ForEachCount = 1 # Counter used in foreach statement
                        foreach ($Name in $Locks) { # For each lock name in $Locks
                            Write-Host "" # Write message to screen
                            Write-Host "Matching resource" $ForEachCount # Write message to screen
                            Write-Host "Lock name:          "$Name.Name
                            Write-Host "Lock properties:    "$Name.Properties
                            Write-Host "Lock resource name: "$Name.ResourceName
                            $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                        } # End foreach ($Name in $Locks)
                        Write-Host ""
                    } # End if ($Locks.count -gt 1)
                    else { # If $Locks has a single object
                    Write-Host $Locks.Name "is the currently selected lock" # Write message to screen
                    } # End else if ($Locks.count -gt 1)
                } # End if ($Locks)
                if ($RGObject) { # If $RGObject has a value
                    Write-Host $RGObject.ResourceGroupName "is the currently selected resource group" # Write message to screen
                } # End if ($RGObject)
                if ($RSObject) { # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource" # Write message to screen
                } # End if ($RSObject) 
            Write-Host 'Use option "0" to clear $Locks' # Write message to screen
            } # End if ($Locks -or $RGObject -or $RSObject)
            $OperatorManageOption = $null # Clears $Operator search option incase of error
        }# End :ManageAzureRGLocks while loop
        Return # Returns to calling function, no info is returned
    } # End begin
} # End function ManageAzResourceGroupLocks
function NewAzResourceGroupLock { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRGLock while ($true) { # :NewAzureRGLock loop for creating a new resource group lock
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :GetAzureLockName while ($true) { # :GetAzureLockName loop for setting the lock name
                $LockName = Read-Host "Lock Name?" # Operator input for the lock name
                if ($LockName -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName # Write message to screen
                $OperatorConfirm = Read-Host "Confirm?" # Operator input to confirm the lock name
                if ($OperatorConfirm -eq 'exit') { # If operator input is 'exit' 
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($OperatorConfirm -eq 'exit')
                elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # Operator confirm is 'y' or 'yes'
                    Break GetAzureLockName # Breaks :GetAzureLockName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureLockName while ($true)
            :GetAzureLockLevel while ($true) { # :GetAzureLockLevel loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureLockLevel while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (No lock notes)
                Return $Locks # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRGLock while ($true) {
        Return
    } # End begin
} # End function NewAzResourceGroupLock
function NewAzResourceLock { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRSLock while ($true) { # :NewAzureRsLock loop for creating a new resource lock
            if (!$RSObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if (!$RGObject)
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            :GetAzureLockName while ($true) { # :GetAzureLockName loop for setting the lock name
                $LockName = Read-Host "Lock Name?" # Operator input for the lock name
                if ($LockName -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName # Write message to screen
                $OperatorConfirm = Read-Host "Confirm?" # Operator input to confirm the lock name
                if ($OperatorConfirm -eq 'exit') { # If operator input is 'exit' 
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($OperatorConfirm -eq 'exit')
                elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # Operator confirm is 'y' or 'yes'
                    Break GetAzureLockName # Breaks :GetAzureLockName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureLockName while ($true)
            :GetAzureLockLevel while ($true) { # :GetAzureLockLevel loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureLockLevel while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RSObject.ResourceGroupName -Force # Deploys resource lock to resource (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RSObject.ResourceGroupName -Force # Deploys resource lock to resource (No lock notes)
                Return $Locks # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRSLock while ($true) {
        Return
    } # End begin
} # End function NewAzResourceLock
function GetAzResourceGroupLocksAll { # Function to get all locks assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource group" # Write message to screen
            Write-Host "The GetAzResourceGroupLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceGroupLockNamed { # Function to get a named lock assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = $null
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource group lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -LockName $LocksInput # Collects the named lock and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource group" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RGObject.ResourceGroupName
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -AtScope
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else { # Else statement if a lock is found with the operator input
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceGroupLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        if (!$RSObject) {
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if (!$RGObject)
            $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if if (!$RSObject)
        } # End if (!$RSObject)
        $Locks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function   
function GetAzResourceLockNamed { # Function to get a named lock assigned to a resource, can pipe $Locks to another function
    Begin {
        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $Locks = $null
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -LockName $LocksInput | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RSObject.Name
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else {
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End funtion
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function ManageAzResourceGroupTags { # Management function for tags
    Begin {
        :ManageAzureRGTag while($true) { # :ManageAzureRGTag loop for managing resource group tags 
            Write-Host "Resource Group Tag Management" # Write message to screen
            Write-Host "1 Set Tag Info For Multiple Use" # Write message to screen
            Write-Host "2 Add Resource Group Tag" # Write message to screen
            Write-Host "3 Add Resource Tag" # Write message to screen
            Write-Host "4 Get All Resource Group Tags" # Write message to screen
            Write-Host "5 Get All Resource Tags" # Write message to screen
            Write-Host "6 Remove Named Resource Group Tag" # Write message to screen
            Write-Host "7 Remove Named Resource Tag" # Write message to screen
            Write-Host "8 Remove All Resource Group Tags" # Write message to screen
            Write-Host "9 Remove All Resource Tags" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGTag # Ends :ManageAzureRGTag loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for setting tag name and value
                Write-Host "Set Tag Info For Multiple Use" # Write message to screen
                $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource group tag
                Write-Host "Add Resource Group Tag" # Write message to screen
                $TagsList = AddAzResourceGroupTag ($RGObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option for new resource tag
                Write-Host "Add Resource Tag" # Write message to screen
                $TagsList = AddAzResourceTag ($RGObject, $RSObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get tags a resource group
                Write-Host "Get Resource Group Tag" # Write message to screen
                $TagsList = GetAzResourceGroupTags ($RGObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get tags on a resource
                Write-Host "Get Resource Tag" # Write message to screen
                $TagsList = GetAzResourceTags ($RGObject, $RSObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to remove a named tag on resource group
                Write-Host "Remove Named Resource Group Tag" # Write message to screen
                $TagsList = RemoveAzResourceGroupTag ($RGObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '6')
            elseif ($OperatorManageOption -eq '7') { # Option to remove a named tag on a resource
                Write-Host "Remove Named Resource Tag" # Write message to screen
                $TagsList = RemoveAzResourceTag ($RGObject, $RSObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '7')
            elseif ($OperatorManageOption -eq '8') { # Option to remove all resource group tags
                Write-Host "Remove Resource Group Tag" # Write message to screen
                $TagsList = RemoveAzResourceGroupTags ($RGObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '8')
            elseif ($OperatorManageOption -eq '9') { # Option to remove all resource tags
                Write-Host "Remove Resource Tag" # Write message to screen
                $TagsList = RemoveAzResourceTags ($RGObject, $RSObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '9')
            elseif ($OperatorManageOption -eq '0') { # Option to clear the current $Tags, $RGObject, $RSObject values
                $OperatorSelect = Read-Host "Tag, RGObject, and/or RSObject" # Operator input for removing a value from $var
                if ($OperatorSelect -like "*Tag*") { # Option for clearing $TagNameInput
                    $TagNameInput = $null # Clears $TagNameInput value
                    $TagValueInput = $null # Clears $TagValueInput value
                    Write-Host '$TagNameInput and $TagValueInput has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*Lock*")
                if ($OperatorSelect -like "*RGObject*") { # Option for clearing $RGObject
                    $RGObject = $null # Clears $RGObject value
                    Write-Host '$RGObject has been cleared' # Write message to screen
                } # #End if ($OperatorSelect -like "*RGObject*")
                if ($OperatorSelect -like "*RSObject*") { # Option for clearing $RSObject
                    $RSObject = $null # Clears $RSObject value
                    Write-Host '$RSObject has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*RSObject*")
            } # End elseif ($OperatorManageOption -eq '0')
            if ($TagNameInput -or $RGObject -or $RSObject) { # If $TagNameInput, $RGObject, or $RSObject object has a value, writes info to screen
                if ($TagNameInput) { # If $TagsName has a value
                    Write-Host $TagNameInput "is the currently selected Tag" # Write message to screen
                } # End if if ($TagNameInput)
                if ($RGObject) { # If $RGObject has a value
                    Write-Host $RGObject.ResourceGroupName "is the currently selected resource group" # Write message to screen
                } # End if ($RGObject)
                if ($RSObject) { # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource" # Write message to screen
                } # End if ($RSObject) 
            Write-Host 'Use option "0" to clear $Tags' # Write message to screen
            } # End if ($TagNameInput -or $RGObject -or $RSObject)
            $OperatorManageOption = $null # Clears $Operator search option incase of error
        }# End :ManageAzureRGTag while loop
        Return # Returns to calling function, no info is returned
    } # End begin
} # End function ManageAzResourceGroupTags
function SetAzTagPair { # Function for setting the tag name and value pair
    Begin {
        :SetAzureTagPair while ($true) { # :SetAzureTagPairLoop
            :SetAzureTagName while ($true) { # :SetAzureTagNameLoop
                $TagNameInput = Read-Host "Tag Name" # Operator input for the tag name
                if ($TagNameInput -eq 'exit') { # If $TagNameInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagNameInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagNameInput "is correct" # Operator confirmation that the name entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagName # Breaks :setAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) { # :SetAzureTagValue loop
                $TagValueInput = Read-Host "Tag Value" # Operator input for the tag value
                if ($TagValueInput -eq 'exit') { # If $TagValueInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagVlaueInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagValueInput "is correct" # Operator confirmation that the value entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagValue # Breaks :SetAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagValue while ($true)
            Return $TagNameInput, $TagValueInput # Returns $TagNameInput and $TagValueInput to the calling function
        } # End :SetAzureTagPair while ($true)
        Return # Retruns to calling function with $null
    } # End begin
} # End function SetAzTagPair
function AddAzResourceGroupTag { # Function to add a new tag to a resource group
    Begin {
        :AddAzureRGTag while ($true) { # :AddAzureRGTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRGTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRGTag # Breaks :AddAzureRGTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            Return $TagsList # Returns $TagsList to the calling function
        } # End :AddAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceGroupTag
function AddAzResourceTag { # Function to add a new tag to a resource
    Begin {
        :AddAzureRSTag while ($true) { # :AddAzureRSTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String
            Return $TagsList # Returns $Tags to the calling function
        } # End :AddAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceTag
function GetAzResourceGroupTags { # Gets all resource group tags and writes them to screen with values
    Begin {
        :GetAzureRGTag while ($true) { # :GetAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRGTag # Breaks :GetAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into 
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceGroupTags
function GetAzResourceTags {
    Begin {
        :GetAzureRSTag while ($true) { # :GetAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceTags
function RemoveAzResourceGroupTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRGTag while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $ValidTagName = (Get-AzResourceGroup -ResourceId $RGObject.ResourceId).Tags.Keys # Collects current tag names on resource group and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) { # Checks passed $TagNameInput against $ValidTagName
                $TagNameInput = $null # Clears $TagNameInput
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource group" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :RemoveAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceGroupTag
function RemoveAzResourceTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRSTag while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $ValidTagName = (Get-AzResource -ResourceId $RSObject.ResourceId).Tags.Keys # Collects current tag names on resource and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) {
                $TagNameInput = $null
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName, build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceTags
function RemoveAzResourceGroupTags {
    Begin { 
        :RemoveAzureRGTags while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTags # Breaks :RemoveAzureRGTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
        Remove-AzTag -ResourceId $RGObject.ResourceID -PassThru # Removes all tags on the resource group
        $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
        if (!$TagsList) { # If $TagsList is $null
            Write-Host "No tags exist on this resource group" # Write message to screen
        } # End if (!$TagsList)
        Return $TagsList # Returns $TagsList to the calling function
    } # End :RemoveAzureRGTags while ($true) {
    Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceGroupTags
function RemoveAzResourceTags {
    Begin {
        :RemoveAzureRSTags while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            Remove-AzTag -ResourceId $RSObject.ResourceID -PassThru # Removes all tags on the resource
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTags while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceTags
# End ManageAzResourceGroup

# ManageAzStorage
# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.3.0
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.3.0
    Get-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblobcontent?view=azps-5.3.0
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.3.0
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    New-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Set-AzDiskDiskEncryptionKey:https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskdiskencryptionkey?view=azps-5.4.0
    Set-AzDiskKeyEncryptionKey: https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskkeyencryptionkey?view=azps-5.4.0
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
    Remove-AzDisk:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    ManageAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/ManageAzStorageAccount.ps1
        NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
        GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        RemoveAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/RemoveAzStorageAccount.ps1
    ManageAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ManageAzStorageContainer.ps1
        NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
        ListAzStorageContainer:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ListAzStorageContainer.ps1
        GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
        RemoveAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/RemoveAzStorageContainer.ps1
    ManageAzStorageBlobs:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/ManageAzStorageBlob.ps1
        SetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/SetAzStorageBlobContent.ps1
        ListAzStorageBlobs:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/ListAzStorageBlobs.ps1
        GetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/GetAzStorageBlobContent.ps1
        RemoveAzStorageBlob:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/RemoveAzStorageBlob.ps1
    ManageAzStorageShares:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageShare.ps1
        NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
        GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
        GetAzStorageShareAll:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShareAll.ps1
        RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
        ManageAzStorageShareItems:  TBD
    ManageAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ManageAzKeyVault.ps1
        NewAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/NewAzKeyVault.ps1
        ListAzKeyVault:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ListAzKeyVault.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        RemoveAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/RemoveAzKeyVault.ps1
        ManageAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ManageAzKeyVaultKey.ps1
            NewAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/NewAzKeyVaultKey.ps1
            AddAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/AddAzKeyVaultKey.ps1
            ListAzKeyVaultKey:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ListAzKeyVaultKey.ps1
            GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
            DownloadAzKeyVaultKey:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/DownloadAzKeyVaultKey.ps1
            RemoveAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/RemoveAzKeyVaultKey.ps1
        ManageAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ManageAzKeyVaultSecret.ps1
            NewAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/NewAzKeyVaultSecret.ps1
            ListAzKeyVaultSecret:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ListAzKeyVaultSecret.ps1
            GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
            GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
            UpdateAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/UpdateAzKeyVaultSecret.ps1
            RemoveAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/RemoveAzKeyVaultSecret.ps1
    ManageAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main//Storage/Disks/ManageAzDisk.ps1
        NewAzDisk:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main//Storage/Disks/NewAzDisk.ps1
        ListAzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/ListAzDisk.ps1
        Get-AzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/GetAzDisk.ps1
        RemoveAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/RemoveAzDisk.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorage:            Manage function for storage
        ManageAzStorageAccount:     Management function for storage accounts
            NewAzStorageAccount:        Creates new storage account object
            GetAzStorageAccount:        Collects the storage account object
            RemoveAzStorageAccount:     Removes the selected storage account
        ManageAzStorageContainer:   Management function for storage containers
            NewAzStorageContainer:      Creates new storage container(s) in a storage account 
            ListAzStorageContainer:     Lists all storage containers
            GetAzStorageContainer:      Collects storage container in a storage account  
            RemoveAzStorageContainer:   Removes existing storage container
        ManageAzStorageBlob:        Management function for storage blobs
            SetAzStorageBlobContent:    Uploads new blobs
            ListAzStorageBlobs:         Gets blob(s) information
            GetAzStorageBlobContent:    Downloads existing blob(s)
            RemoveAzStorageBlob:        Removes blobs from Azure
        ManageAzStorageShare:       Manages all functions for storage shares
            NewAzStorageShare:          Creates a new storage share
            GetAzStorageShare:          Gets a storage share
            GetAzStorageShareAll:       Lists all storage shares in a subscription
            RemoveAzStorageShare:       Removes a storage share
            ManageAzStoreShareItems:    Management function for storage share items
        ManageAzKeyVault:            Management function for key vaults
            NewAzKeyVault:              Creates new key vault object
            ListAzKeyVault:             Lists all key vaults in subscription
            GetAzKeyVault:              Gets $KeyVaultObject
            RemoveAzKeyVault:           Removes $KeyVaultObject
            ManageAzKeyVaultKey:        Management function for key vault keys
                NewAzKeyVaultKey:           Creates a new key vault Key
                AddAzKeyVaultKey:           Uploads an existing key into vault
                ListAzKeyVaultKey:          Lists all key vault Keys by vault name
                GetAzKeyVaultKey:           Gets a key vault Key
                DownloadAzKeyVaultKey:      Downloads selected key vault Key
                RemoveAzKeyVaultKey:        Removes a selected key vault Key
            ManageAzKeyVaultSecret:     Management function for key vault secrets
                NewAzKeyVaultSecret:        Creates a new key vault secret
                ListAzKeyVaultSecret:       Lists all key vault secrets by vault name
                GetAzKeyVaultSecret:        Gets a key vault secret
                UpdateAzKeyVaultSecret:     Updates the value of selected key vault secret
                RemoveAzKeyVaultSecret:     Removes a selected key vault secret
        ManageAzDisk:               Management function for disks
            NewAzDisk:                  Creates a new disk
            ListAzDisk:                 Lists all disks
            GetAzDisk:                  Gets a disk
            RemoveAzDisk:               Removes a selected disk
        GetAzResourceGroup:         Collects resource group object
        RemoveAzResourceLocks:      Removes locks
        GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    :ManageAzureStorage         Outer loop for managing function
    ManageAzStorage:            Operator input for function selection
    $RGObject:                  Resource group object
    $StorageAccObject:          Storage account object
    $StorageConObject:          Storage container object
    $StorageShareObject:        Storage share object
    ManageAzStorageAccount{}    Function for managing storage accounts
        NewAzStorageAccount{}       Function for creating new storage accounts
            GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageAccount{}    Removes $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceLocksAll{}     Gets $Locks
            RemoveAzResourceLocks{}     Removes $Locks
    ManageAzStorageContainer{}  Function for managing storage containers
        NewAzStorageContainer{}     Function for creating new storage containers
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        ListAzStorageContainer{}    Lists all storage containers
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageContainer{}  Removes $StorageConObject
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageBlob{}       Function for managing storage container blobs
        SetAzStorageBlobContent{}   Uploads new blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        ListAzStorageBlob{}         Lists all storage blobs
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageBlobContent{}   Downloads blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageBlob{}       Deletes blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageShare{}      Function for managing storage shares
        NewAzStorageShare{}         Function to create new storage share
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageShare{}         Gets $StorageShareObject               
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup {}        Gets $RGObject
        GetAzStorageShareAll{}      Gets all storage shares
        RemoveAzStorageShare{}      Removes $StorageShareObject
            GetAzStorageShare{}         Gets $StorageShareObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzKeyVault{}          Manages $KeyVaultObject  
        NewAzKeyvault{}             Creates $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject
        ListAzKeyVault{}            Lists all key vaults in subscription
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzKeyVault{}          Removes $KeyVaultObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
        ManageAzKeyVaultKey{}       Manages $KeyVaultKeyObject
            NewAzKeyVaultKey{}          Creates $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            AddAzKeyVaultKey{}          Uploads $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            ListAzKeyVaultKey{}         Lists all key vault keys in vault
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            RemoveAzKeyVaultKey{}       Removes $KeyVaultKeyObject
                GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject
        ManageAzKeyVaultSecret{}    Manages $KeyVaultSecretObject
            NewAzKeyVaultSecret{}       Creates $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultSecret
                    GetAzResourceGroup{}        Gets $RGObject
            ListAzKeyVaultSecret{}      Lists all secrets in subscription
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject 
            GetAzKeyVaultSecretValue{}  Lists value of $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject
            UpdateAzKeyVaultSecret{}    Updates $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject   
            RemoveAzKeyVaultSecret{}    Removes $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject 
        ManageAzDisk{}              Manages $DiskObject
            NewAzDisk{}                 Creates $DiskObject           
                GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            ListAzDisk{}                Lists disks
            GetAzDisk{}                 Gets $DiskObject
            RemoveAzDisk{}              Removes $DiskObject
                GetAzDisk{}                 Gets $DiskObject 
} #>
<# Process Flow {
    function
        Call ManageAzStorage > Get $null
            Call ManageAzStorageAccount > Get $null
                Call NewAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzStorageAccount > Send $RGObject
                End NewAzStorageAccount 
                    Return Function > Send $StorageAccObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return ManagageAzStorageAccount > Send $StorageAccObject
                Call RemoveAzStorageAccount > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return RemoveAzStorageAccount > Send $StorageAccObject
                End RemoveAzStorageAccount
                    Return ManageAzStorageAccount > Send $Null
            End ManageAzStorageAccount
                Return ManageAzStorage > Send $null
            Call ManageAzStorageContainer > Get $null
                Call NewAzStorageContainer > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return NewAzStorageContainer > Send $StorageAccObject
                    End NewAzStorageContainer 
                        Return ManageStorageContainer > Send $null
                Call ListAzStorageContainer > Get $null
                End ListAzStorageContainer
                    Return ManageStorageContainer > Send $null
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return ManageAzStorageContainer > Send $StorageConObject, $StorageAccObject
                Call RemoveAzStorageContainer > Get $null
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                    End RemoveAzStorageContainer      
                        Return ManageAzStorageContainer > Send $null
            End ManageAzStorageContainer
                Return ManageAzStorage > Send $null
            Call ManageAzStorageBlob
                Call SetAzStorageBlobContent > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End SetAzStorageBlobContent
                    Return ManageAzStorageBlob > Send $StorageBlobObject
                Call ListAzStorageBlob > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End ListAzStorageBlob
                    Return ManageAzStorageBlob > Send $StorageBlobObject
                Call GetAzStorageBlobContent > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End GetAzStorageBlobContent
                    Return ManageAzStorageBlob > Send $StorageBlobObject 
                Call RemoveAzStorageBlob > Get $null
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End RemoveAzStorageBlob
                    Return ManageAzStorageBlob > Send $null
            End ManageAzStorageBlob
                Return ManageAzStorage > Send $null 
            Call ManageAzKeyVault > Get $null
                Call NewAzKeyvault
                    Call GetAzResource Group > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzKeyVault > Send $RGObject
                End NewAzKeyvault
                    Return ManageAzKeyVault > Send $KeyVaultObject
                Call ListAzKeyVault
                End ListAzKeyVault
                    Return ManageAzKeyVault > Send $null
                Call GetAzKeyVault
                    Call GetAzResource Group > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return ManageAzKeyVault > Send $KeyVaultObject
                Call RemoveAzKeyVault
                    Call GetAzKeyVault
                        Call GetAzResource Group > Get $RGObject
                        End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                    Return RemoveAzKeyVault > Send $KeyVaultObject
                End RemoveAzKeyVault
                    Return ManageAzKeyVault > Send $null
                Call ManageAzKeyVaultKey                
                    Call NewAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return NewAzKeyVaultKey > Send $KeyVaultObject  
                    End NewAzKeyVaultKey
                        Return ManageAzKeyVaultKey > Send $KeyVaultKeyObject
                    Call AddAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return AddAzKeyVaultKey > Send $KeyVaultObject  
                    End AddAzKeyVaultKey
                        Return ManageAzKeyVaultKey > Send $KeyVaultKeyObject
                    Call ListAzKeyVaultKey > Get $null
                    End ListAzKeyVaultKey
                        Return ManageAzKeyVaultKey > Send $null          
                    Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultKey > Send $KeyVaultObject
                    End GetAzKeyVaultKey 
                        Return ManageAzKeyVaultKey> Send $KeyVaultKeyObject            
                    Call RemoveAzKeyVaultKey > Get $null
                        Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                            Call GetAzKeyVault > Get $KeyVaultObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzKeyVault > Send $RGObject
                            End GetAzKeyVault
                                Return GetAzKeyVaultKey > Send $KeyVaultObject
                        End GetAzKeyVaultKey
                            Return RemoveAzKeyVaultKey > Send $KeyVaultKeyObject  
                    End RemoveAzKeyVaultKey
                        Return ManageAzKeyVaultKey > Send $null  
                End ManageAzKeyVaultKey
                    Return ManageAzKeyVault > Send $null
                Call ManageAzKeyVaultSecret > Get $KeyVaultSecretObject
                    Call NewAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return NewAzKeyVaultSecret > Send $KeyVaultObject  
                    End NewAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $KeyVaultSecretObject
                    Call ListAzKeyVaultSecret > Get $null
                    End ListAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $null          
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret 
                        Return ManageAzKeyVaultSecret> Send $KeyVaultSecretObject            
                    Call GetAzKeyVaultSecretValue > Get $null
                        Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                            Call GetAzKeyVault > Get $KeyVaultObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzKeyVault > Send $RGObject
                            End GetAzKeyVault
                                Return GetAzKeyVaultSecret > Send $KeyVaultObject
                        End GetAzKeyVaultSecret
                            Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject  
                    End GetAzKeyVaultSecretValue
                        Return ManageAzKeyVaultSecret > Send $null                   
                    Call RemoveAzKeyVaultSecret > Get $null
                        Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                            Call GetAzKeyVault > Get $KeyVaultObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzKeyVault > Send $RGObject
                            End GetAzKeyVault
                                Return GetAzKeyVaultSecret > Send $KeyVaultObject
                        End GetAzKeyVaultSecret
                            Return RemoveAzKeyVaultSecret > Send $KeyVaultSecretObject  
                    End RemoveAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $null   
                End ManageAzKeyVaultSecret
                    Return ManageAzKeyVault > Send $null
            End ManageAzKeyVault
                Return ManageAzStorage > Send $null
            Call ManageAzDisk > Get $null
                Call NewAzDisk > Get $DiskObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzDisk > Send $RGObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGoup
                            Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                        Return NewAzDisk > Send $KeyVaultObject
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                    End GetAzKeyVaultSecret
                        Return *** > Send $KeyVaultSecretObject
                    Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                    End GetAzKeyVaultKey
                        Return NewAzDisk > Send $KeyVaultKeyObject
                End NewAzDisk
                    Return ManageAzDisk > Return $DiskObject
                Call ListAzDisk > Get $null
                End ListAzDisk
                    Return ManageAzDisk > Return $null
                Call GetAzDisk > Get $DiskObject
                End GetAzDisk
                    Return ManageAzDisk > Return $DiskObject
                Call RemoveAzDisk > Get $null
                    Call GetAzDisk > Get $DiskObject
                    End GetAzDisk
                        Return RemoveAzDisk > Send $DiskObject
                End RemoveAzDisk
                    Return ManageAzDisk > Return $null
            End ManageAzDisk
                Return ManageAzStorage > Send $null
        End ManageAzStorage
            Return Function > Send $null
}#>
function ManageAzStorage { # Function for managing Azure storage
    Begin {
        :ManageAzureStorage while ($true) { # :ManageAzureStorage named loop to select search function
            Write-Host "Azure Storage Management" # Write message to screen
            Write-Host "1 Manage Storage Accounts" # Write message to screen
            Write-Host "2 Manage Storage Containers" # Write message to screen
            Write-Host "3 Manage Blobs" # Write message to screen
            Write-Host "4 Manage Storage Shares" # Write message to screen
            Write-Host "5 Manage Key Vaults" # Write message to screen
            Write-Host "6 Manage Disks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorage = Read-Host "Option?" # Collects operator input on $ManageAzStorage option
            if ($ManageAzStorage -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorage # Ends :ManageAzureStorage loop, leading to return statement
            } # End if ($ManageAzStorage -eq 'exit')
            elseif ($ManageAzStorage -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Manage Storage Accounts" # Write message to screen
                $StorageAccObject = ManageAzStorageAccount ($RGObject, $RSObject)  # Calls function
            } # End elseif ($ManageAzStorage -eq '1')
            elseif ($ManageAzStorage -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Manage Storage Containers" # Write message to screen
                $StorageConObject = ManageAzStorageContainer ($RGObject, $RSObject, $StorageAccObject)  # Calls function
            } # End elseif ($ManageAzStorage -eq '2')
            elseif ($ManageAzStorage -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Manage Blobs" # Write message to screen
                $StorageBlobObject = ManageAzStorageBlob ($RGObject, $RSObject, $StorageAccObject, $StorageConObject)  # Calls function
            } # End elseif ($ManageAzStorage -eq '3')
            elseif ($ManageAzStorage -eq '4') { # Elseif statement for managing file shares
                Write-Host "Manage Storage Shares" # Write message to screen
                $StorageShareObject = ManageAzStorageShare ($RGObject, $RSObject, $StorageAccObject)  # Calls function
            } # End elseif ($ManageAzStorage -eq '4')
            elseif ($ManageAzStorage -eq '5') { # Elseif statement for managing keyvaults
                Write-Host "Manage Key Vaults" # Write message to screen
                ManageAzKeyVault ($RGObject) # Calls function
            } # End elseif ($ManageAzStorage -eq '5')
            elseif ($ManageAzStorage -eq '6') { # Elseif statement for managing disks
                Write-Host "Manage Disks" # Write message to screen
                ManageAzDisk ($RGObject) # Calls function
            } # End elseif ($ManageAzStorage -eq '6')
            Write-Host $RGObject.ResourceGroupName
            Write-Host $RSObject.Name
            Write-Host $StorageAccObject.StorageAccountName
            Write-Host $StorageConObject.Name
        } # End ManageAzureStorage while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function ManageAzStorageAccount { # Management function for storage accounts
    Begin {
        :ManageAzureStorageAcc while ($true) { # :ManageAzureStorageAcc named loop to select search function
            Write-Host "Azure Storage Account Management" # Write message to screen
            Write-Host "1 New Storage Account" # Write message to screen
            Write-Host "2 Get Storage Account" # Write message to screen
            Write-Host "3 Remove Storage Account" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageACC = Read-Host "Option?" # Collects operator input on $ManageAzStorageACC option
            if ($ManageAzStorageACC -eq 'exit') { # Exit if statement for this function
                if ($StorageAccObject) { # If $StorageAccObject is not $null
                    Return $StorageAccObject # Returns $StorageAccObject to calling function
                } # End if ($StorageAccObject)
                Break ManageAzureStorageAcc # Ends :ManageAzureStorageAcc loop, leading to return statement
            } # End if ($ManageAzStorageACC -eq 'exit')
            elseif ($ManageAzStorageACC -eq '1') { # Elseif statement for creating storage accounts
                Write-Host "New Storage Account" # Write message to screen
                $StorageAccObject = NewAzStorageAccount ($RSObject, $RGObject) # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '1')
            elseif ($ManageAzStorageACC -eq '2') { # Elseif statement for getting storage accounts
                Write-Host "Get Storage Account" # Write message to screen
                $StorageAccObject = GetAzStorageAccount ($RSObject, $RGObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '2')
            elseif ($ManageAzStorageACC -eq '3') { # Elseif statement for removing storage accounts
                Write-Host "Remove Storage Accounts" # Write message to screen
                RemoveAzStorageAccount  # Calls function
            } # End elseif ($ManageAzStorageACC -eq '3')
            elseif ($ManageAzStorageACC -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageACC -eq '0')
            else { # All other inputs for $ManageAzStorageAcc
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageACC -eq 'exit'))
        } # End ManageAzureStorageAcc while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageAccount
function NewAzStorageAccount { # Creates a new storage account
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureStorageAcc while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) { # Inner loop for setting the storage account name
                $StorageAccNameInput = '000100000000001000000' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of account name
                    [ValidatePattern('^[a-z,0-9]+$')][ValidateLength (3, 24)]$StorageAccNameInput = [string](Read-Host "New storage account name").ToLower() # Operator input for the account name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The provided name was not valid characters in length and use numbers and lower-case letters only"} # Error message for failed try
                if ($StorageAccNameInput -eq 'exit') { # $StorageAccNameInput is equal to exit
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput -eq '000100000000001000000') {}# Elseif when Try statement fails
                else { # If Try statement input has value not equal to exit
                    Write-Host $StorageAccNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccName # Breaks SetAzureStorageAccName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($StorageAccNameInput -eq 'exit'))
            } # :SetAzureStorageAccName while ($true)
            $ValidSku = 'Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', 'Standard_ZRS', 'Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', 'Standard_RAGZRS' # Current list of all skus
            :SetAzureStorageAccSku while ($true) { # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host "New storage account sku" # Operator input for the sku
                if ($StorageAccSkuInput -eq 'exit') { # If $StorageAccSkuInput -eq 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageACC loop
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccSkuInput -cin $ValidSku) { # If $StorageAccSkuInput is in $ValidSku (Case sensitive)
                    Write-Host $StorageAccSkuInput # Writes $StorageAccSkuInput to screen
                    $OperatorConfirm = Read-Host "Is the Sku correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccSku # Breaks :SetAzureStorageAccSku
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccNameInput -iin $ValidSku)
                else { # Else for all other inputs 
                    Write-Host "The Sku name provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidSku -Separator `n # Write $ValidSku list to screen
                } # End else (if ($StorageAccNameInput -iin $ValidSku))
            } # End :SetAzureStorageAccSku while
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureStorageAccLoc while ($true) { # Inner loop for setting the account location
                $StorageAccLocInput = Read-Host "New storage account location" # Operator input for the account location
                if ($StorageAccLocInput -eq 'exit') { # If $StorageAccLocInput is 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageAcc
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccLocInput -iin $ValidLocation.Location) { # if $StorageAccLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $StorageAccLocInput # Write $StorageAccLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccLoc # Breaks :SetAzureStorageAccLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccLocInput -iin $ValidLocation)
                else { # All other inputs for $StorageAccLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($StorageAccLocInput -iin $ValidLocation))
            } # End :SetAzStorageAccLoc while ($true)
            $StorageAccObject = New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Location $StorageAccLocInput -Name $StorageAccNameInput -SkuName $StorageAccSkuInput # Creates the new storage account and assigns to $StorageAccObject
            Return $StorageAccObject # Returns $var to calling function
        } # End :NewAzureStorageAcc while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzStorageAccount
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$StorageAccList) { # If $StorageAcclist returns empty
                Write-Host "No storage accounts found" # Message write to screen
                Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
            } # End if (!$StorageAccList)
            $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                Write-Host $StorageAccListNumber"." $_.StorageAccountName # Writes $StorageAccList to screen
                $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
            } # End foreach ($_ in $StorageAccList)
            :GetAzureStorageAccount while ($true) {
                $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
                $StorageAccListSelect = Read-Host "Please enter the number of the storage account" # Operator input for the storage account selection
                if ($StorageAccListSelect -eq '0') { # If $StorageAccList is '0'
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # if ($StorageAccListSelect -eq '0')
                foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                    if ($StorageAccListSelect -eq $StorageAccListNumber) { # If the operator input matches the current $StorageAccListNumber
                        $StorageAccObject = $_ # Assigns current item in $StorageAccList to $StorageAccObject
                        Break GetAzureStorageAccount # Breaks :GetAzureStorageAccount
                    } # End if ($StorageAccListSelect -eq $StorageAccListNumber)
                    else { # If user input does not match the current $StorageAccListNumber
                        $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
                    } # End else (if ($StorageAccListSelect -eq $StorageAccListNumber))
                } # End foreach ($_ in $StorageAccList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $StorageAccObject # Returns to calling function with $StorageAccObject
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function RemoveAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :RemoveAzureStorageAcc while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            else { # Else for when $StorageAccObject is assigned
                $StoreAccName = $StorageAccObject.StorageAccountName # Collects the name of the storage account and assigns to own $var
                $OperatorConfirm = Read-Host "Remove the following storage account" $StorageAccObject.StorageAccountName "in" $StorageAccObject.ResourceGroupName # Operator confimation to remove the storage account
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                Write-Host "Checking for resource locks" # Write message to screen
                $RSObject = Get-AzResource -Name $StorageAccObject.StorageAccountName -ResourceGroupName $StorageAccObject.ResourceGroupName # Collects the $RSObject 
                $RGObject = Get-AzResourceGroup -Name $StorageAccObject.ResourceGroupName # Collects the $RGObject
                $Locks = GetAzResourceLocksAll ($RSObject, $RGObject) #Calls function and assigns to $var
                if ($Locks) { # If $Locks is not $null
                    RemoveAzResourceLocks ($Locks) # Calls function assigns $null
                } # End if ($Locks)
                else { # If $Locks is $null
                    Write-Host "No locks present on this storage account" # Write message to screen
                } # End else (if ($Locks))
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageAccount -ResourceGroupName $StorageAccObject.ResourceGroupName -AccountName $StorageAccObject.StorageAccountName -Force -ErrorAction Stop # Removes storage account, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "The storage account was not deleted" # Write message to screen
                    if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope) { # If a lock exists on the resource group
                        Write-Host "There are locks on the resource group that must be removed before this storage account can be removed" # Write message to screen
                    } # End if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope)
                    else { # All other results for failing to remove the storage account
                        Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    } # End else (if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope))
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreAccName" has been removed" # Write message to screen
                Return # Returns to calling function
            } # End else ((!$StorageAccObject))
        } # End :RemoveAzureStorageAcc while ($true)
        Write-Host "No changes made"
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function ManageAzStorageContainer { # Management function for containers
    Begin {
        :ManageAzureStorageCon while ($true) { # :ManageAzureStorageCon named loop to select search function
            Write-Host "Azure Storage Container Management" # Write message to screen
            Write-Host "1 New Storage Container" # Write message to screen
            Write-Host "2 List All Storage Containers" # Write message to screen
            Write-Host "3 Get Storage Container" # Write message to screen
            Write-Host "4 Remove Storage Container" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageCon = Read-Host "Option?" # Collects operator input on $ManageAzStorageCon option
            if ($ManageAzStorageCon -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageCon # Ends :ManageAzureStorageCon loop, leading to return statement
            } # End if ($ManageAzStorageCon -eq 'exit')
            elseif ($ManageAzStorageCon -eq '1') { # Elseif statement for creating storage Containers
                Write-Host "New Storage Container" # Write message to screen
                NewAzStorageContainer ($RSObject, $RGObject, $StorageAccObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageCon -eq '1')
            elseif ($ManageAzStorageCon -eq '2') { # Elseif statement for getting storage Containers
                Write-Host "List All Storage Containers" # Write message to screen
                ListAzStorageContainer # Calls function    
            } # End elseif ($ManageAzStorageCon -eq '2')
            elseif ($ManageAzStorageCon -eq '3') { # Elseif statement for getting storage Containers
                Write-Host "Get Storage Container" # Write message to screen
                $StorageAccObject = GetAzStorageContainer ($RSObject, $RGObject, $StorageAccObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageContainerName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageCon -eq '3')
            elseif ($ManageAzStorageCon -eq '4') { # Elseif statement for removing storage Containers
                Write-Host "Remove Storage Containers" # Write message to screen
                RemoveAzStorageContainer  # Calls function
            } # End elseif ($ManageAzStorageCon -eq '4')
            elseif ($ManageAzStorageCon -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageCon -eq '0')
            else { # All other inputs for $ManageAzStorageCon
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageCon -eq 'exit'))
        } # End ManageAzureStorageCon while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageContainer
function NewAzStorageContainer { # Creates new storage container(s) in a storage account
    Begin {
        :NewAzureStorageCon while ($true) { # Outer loop for function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) { # Inner loop for setting storage account name
                Try { # First validation of the storage container name or names
                    Write-Host "Storage container names must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    Write-Host "To create multiple containers in this storage account, enter each name seperated by a [Space]" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = [string](Read-Host "Storage account name or names").ToLower() # Operator input for the container names
                } # End Try 
                catch { # Catch for failing to meet character validation of the container names
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name(s) were not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $StorageConNameInput = '0' # Sets $StorageConNameInput value to a failed check to reset loop
                } # End Catch
                if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($StorageConNameInput -eq '0')
                elseif ($StorageConNameInput.Length -le 2) { # If unsplit $StorageConNameInput is 2 or less characters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                } # End elseif ($StorageConNameInput.Length -le 2)
                else { # Inital validation checks passed, performing secondary validation
                    $StorageConName = $StorageConNameInput # Creats $StorageConName $Var
                    if ($StorageConName -eq 'exit') { # If $StorageConName equals exit
                        Break NewAzStorageAccount # Breaks :NewAzStorageAccount
                    } # End if ($StorageConNameInput -eq 'exit')
                    $StorageConNameSplit = $StorageConName.split() # Creates $StorageConNameSplit, a list of names for each space in $StoreConName
                    foreach ($_ in $StorageConNameSplit) { # Performs length check on all names in list
                        if ($_.length -le 2) { # If $StoreConNameSplit.listitem is 2 or less charaters
                            Write-Host "***Error***" # Write message to screen
                            Write-Host $_ "is not a valid name" # Write message to screen
                            Write-Host "***Error***" # Write message to screen
                            $StorageConNameInput = '0'# Sets $StorageConNameInput value to a failed check to reset loop
                            $StorageConNameSplit = $null # Sets $StorageConNameSplit to $null
                        } # End if ($_.length -le 2)
                    } # End foreach ($_ in $StorageConNameSplit) 
                    if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                        Write-Host " " # Writes a message to screen, last action before restarting loop
                    } # End if ($StorageConNameInput -eq '0')
                    else { # All validation passed
                        if ($StorageConNameSplit.count -gt 1) { # If $StorageConNameSplit has more than one value
                            Write-Host "Create multiple storage containers with the following names" # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n # Writes all names to screen
                        } # End if ($StorageConNameSplit.count -gt 1)
                        else { # If $StorageConNameSplit has 1 value
                            Write-Host "Create a single storage account named"$StorageConName # Write message to screen
                            $StorageConNameSplit = $null  # Sets $StorageConNameSplit to $null
                        } # End else (if ($StorageConNameSplit.count -gt 1))
                        $OperatorConfirm = Read-Host "Yes or No" # Operator input for approving the name
                        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                            Break SetAzureStorageConName # Breaks :SetAzureStorageConName
                        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    } # End else (if ($StorageConNameInput -eq '0'))
                } # End else (if ($StorageConNameInput -eq '0'))
            } # End :SetAzureStorageConName while ($true)
            Write-Host "Container - Provides full read access to a container and its blobs." # Write message to screen
            Write-Host "Blob      - Provides read access to blob data throughout a container through" # Write message to screen
            Write-Host "            anonymous request, but does not provide access to container data." # Write message to screen
            Write-Host "Off       - Which restricts access to only the storage account owner." # Write message to screen
            $ValidRights = 'Container', 'Blob', 'Off' # List of valid rights input
            :SetAzureStorageConRights while ($true) { # Inner loop for setting the rights level
                $StorageConRightsInput = Read-Host "Container rights level" # Operator input for the rights level
                if ($StorageConRightsInput -eq 'exit') { # If $StorageConRightsInput is equal to 'exit'
                    Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                } # End if ($StorageConRightsInput -eq 'exit')
                elseif ($StorageConRightsInput -iin $ValidRights) { # If $StorageConRightsInput is in $ValidRights list
                    Break SetAzureStorageConRights # Breaks :SetAzureStorageConRights
                } # End elseif ($StorageConRightsInput -iin $ValidRights)
                else { # All other inputs for $StorageConRightsInput
                    Write-Host 'That was not a valid input'# Write message to screen
                    Write-Host 'please select from the following'# Write message to screen
                    Write-Host $ValidRights -Separator `n # Writes $ValidRights list to screen
                } # End else (if ($StorageConRightsInput -eq 'exit'))
            } # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit) { # If StorageConNameSplit is not $null
                Write-Host "Creating storage containers, this may take a minute"# Write message to screen
                $StorageConNameSplit | New-AzStorageContainer -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates the storage containers
            } # End if ($StorageConNameSplit) 
            else { # If $StorageConNameSplit is $null
                New-AzStorageContainer -Name $StorageConName -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates to storage container
            } # End else (if ($StorageConNameSplit) )
            Return # Returns to calling function empty
        } # End :NewAzureStorageCon while ($true)
    } # End begin
} # End NewAzStorageContainer
function ListAzStorageContainer { # Lists storage containers
    Begin {
        $RGList = Get-AzResourceGroup # creates list of all resource groups
        foreach ($_ in $RGList) { # For each object in $RGList
            Write-Host "------------------------------------------" # Write message to screen
            Write-Host $_.ResourceGroupName # Write message to screen
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $_.ResourceGroupName # Creates a list of all storage accounts in current resource group
            if ($StorageAccList) { # If storage accounts exist in this group
                foreach ($StorageAccountName in $StorageAccList) { # For each object in $StorageAccList
                    Write-Host "------------------------------------------" # Write message to screen
                    Write-Host "StorageAccount: " $StorageAccountName.StorageAccountName # Write message to screen
                    Try { # Try the following command
                        $StorageConList = Get-AzStorageContainer -Context $StorageAccountName.Context # Creates a list of all containers in current $StorageAccount
                    } # End Try
                    catch { # If try fails
                        Write-Host "You may not have the permissions to view this acount" # Write message to screen
                        Write-Host "The account maybe locked which prevents listing containers" # Write message to screen
                    } # End catch
                    if ($StorageConList) { # If storage containers exist in the current account
                        Write-Host "" # Write message to screen
                        foreach ($Name in $StorageConList) { # For each object in $StorageConList
                            Write-Host "Container Name:   " $Name.Name # Write message to screen
                        } # End foreach ($Name in $StorageConList)
                    } # End if ($StorageConList)
                    else { # If no storage containers exist in the current account
                        Write-Host "No containers exist in this storage account" # Write message to screen
                    } # End if ($StorageConList)
                } # End foreach ($_ in $StorageAccList)
            } # End if ($StorageAccList)
            else { # If no storage accounts exist in current group
                Write-Host "No Storage Accounts in this resource group" # Write message to screen
            } # End else(if ($StorageAccList))
        } # End foreach ($_ in $RGList)
        Write-Host "------------------------------------------" # Write message to screen
        Return # Returns to calling function
    } # End Begin
} # End function ListAzStorageContainer
function GetAzStorageContainer { # Gets an existing stoage container
    Begin {
        $ErrorActionPreference='silentlyContinue'
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            $SCList = Get-AzStorageContainer -Context $StorageAccObject.Context
            $SCListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $SCList) { # For each item in list
                Write-Host $SCListNumber"." $_.Name # Writes the option number and storage container name
                $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
            } # End foreach ($_ in $SCList)
            :GetAzureStorageConName while ($true) { # Loop for selecting the storage container object
                $SCListNumber = 1 # Resets list number to 1
                $SCListSelect = Read-Host "Please enter the number of the storage container" # Operator input for selecting which storage container
                if ($SCListSelect -eq '0') { # If $SCListSelect is equal to 0
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($SCListSelect -eq '0')
                foreach ($_ in $SCList) { # For each item in list
                    if ($SCListSelect -eq $SCListNumber) { # If the operator input matches the current $SCListNumber
                        $StorageConObject = Get-AzStorageContainer -Context $StorageAccObject.Context -Name $_.Name # collects the full storage container object
                        Break GetAzureStorageConName # Breaks :GetAzureStorageConName 
                    } # End if ($SCListSelect -eq $SCListNumber)
                    else { # If user input does not match the current $SCListNumber
                        $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
                    } # End else (if ($SCListSelect -eq $SCListNumber))
                } # End foreach ($_ in $SCList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :GetAzureStorageConName while ($true)
            Return $StorageConObject
        } # End GetAzureStorageContainer
        Return # Returns to calling function with #null
    } # End Begin
} # End GetAzStorageContainer
function RemoveAzStorageContainer { # Removes existing storage container
    Begin {
        :RemoveAzureStorageCon while ($true) { # Outer loop for function
            <#if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject) #>
            if (!$StorageConObject) { # If $StorageConObject is $null
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                    if (!$StorageConObject) { # If $StorageConObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            Write-Host "***WARNING RESOURCELOCKS WILL NOT PROTECT THIS STORAGECONTAINER FROM BEING DELETED***"
            $OperatorConfirm = Read-Host "Remove the following storage container" $StorageConObject.Name "in" $StorageAccObject.StorageAccountName # Operator confimation to remove the storage container
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageCon
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                $StoreConName = $StorageConObject.Name
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name $StorageConObject.Name -Force -ErrorAction Stop # Removes storage container, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreConName" has been removed" # Write message to screen
                Return # Returns to calling function
        } # End :RemoveAzureStorageCon while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzStorageContainer
function ManageAzStorageBlob { # Manages storage blob functions
    Begin {
        :ManageAzureStorageBlob while ($true) { # :ManageAzureStorageBlob named loop to select search function
            Write-Host "Azure Storage Blob Management" # Write message to screen
            Write-Host "1 Add Storage Blob" # Write message to screen
            Write-Host "2 List Storage Blobs" # Write message to screen
            Write-Host "3 Download Storage Blobs" # Write message to screen
            Write-Host "4 Remove Storage Blobs" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageBlob = Read-Host "Option?" # Collects operator input on $ManageAzStorageBlob option
            if ($ManageAzStorageBlob -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageBlob # Ends :ManageAzureStorageBlob loop, leading to return statement
            } # End if ($ManageAzStorageBlob -eq 'exit')
            elseif ($ManageAzStorageBlob -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Add Storage Blob" # Write message to screen
                $StorageBlobObject = SetAzStorageBlobContent ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '1')
            elseif ($ManageAzStorageBlob -eq '2') { # Elseif statement for managing storage containers
                Write-Host "List Storage Blobs" # Write message to screen
                $StorageBlobObject, $StorageAccObject, $StorageConObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '2')
            elseif ($ManageAzStorageBlob -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Download Storage Blobs" # Write message to screen
                $StorageBlobObject = GetAzStorageBlobContent ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '3')
            elseif ($ManageAzStorageBlob -eq '4') { # Elseif statement for managing file shares
                Write-Host "Remove Storage Blobs" # Write message to screen
                RemoveAzStorageBlob ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageBlob -eq '4')
            elseif ($ManageAzStorageBlob -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageConObject) { # If $var is not $null
                Write-Host "Clearing" $StorageConObject.Name # Write message to screen
                $StorageConObject = $null # Sets $var to $null
                } # End if ($StorageConObject)
                if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Clearing" $StorageBlobObject.Name # Write message to screen
                $StorageBlobObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageBlob -eq '0')
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageConObject) { # If $var is not $null
                Write-Host "Current Storage Container: " $StorageConObject.Name # Write message to screen
            } # End if ($StorageConObject)
            if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Current Storage Blob(s):   " $StorageBlobObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageBlob while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function SetAzStorageBlobContent { # Uploads item as a blob
    Begin {
        :SetAzureBlobContent while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break SetAzureBlobContent
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) { # Inner loop for setting access tier
                $BlobTierInput = Read-Host "Hot or Cool" # Operator input for $BlobTierInput
                if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool') { # If $Var is a valid entry
                    Break SetAzureBlobTier
                } # End if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool')
                elseif ($BlobTierInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End elseif ($BlobTierInput -eq 'exit')
                else { # Else if no valid entry for $Var
                    Write-Host "Please enter hot or cool" # Write message to screen
                } # End else (if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool'))
            } # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {
                $LocalFileNameInput = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
                if ($LocalFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($LocalFileNameInput -eq 'exit')
                Write-Host "This is the file to be uploaded" # Write message to screen
                Write-Host $LocalFileNameInput
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {
                $BlobFileNameInput = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
                if ($BlobFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($BlobFileNameInput -eq 'exit')
                Write-Host "This will be the file name in the container" # Write message to screen
                Write-Host $BlobFileNameInput # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetAzureBlobName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureBlobName while ($true)
            $StorageBlobObject = Set-AzStorageBlobContent -File $LocalFileNameInput -Blob $BlobFileNameInput -Container $StorageConObject.Name -Context $StorageAccObject.Context -StandardBlobTier $BlobTierInput
            Return $StorageBlobObject 
        } # End  :SetAzureBlobContent while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function SetAzStorageBlobContent
function ListAzStorageBlob { # Lists all blobs
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :ListAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break ListAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            $OperatorSelect = Read-Host "Search for a named blob [Y] or [N]"
            if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes') {
                :GetAzureBlob while ($true) {
                    $StorageBlobNameInput = Read-Host "Blob name (Case Sensitive)"
                    if ($StorageBlobNameInput -eq 'exit') { # If $Var is 'exit'
                        Break ListAzureBlobs
                    } # End if ($StorageBlobNameInput -eq 'exit')
                    $StorageBlobObject = Get-AzStorageBlob -Blob $StorageBlobNameInput -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                    if (!$StorageBlobObject) { # If $Var is $null
                        Write-Host "No blobs names matched" # Write message to screen
                        Write-Host "Please chose from the following" # Write message to screen
                        $StorageBlobList = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                        Write-Host $StorageBlobList.Name -Separator `n # Write message to screen
                        Write-Host "" # Write message to screen
                    } # End if (!$StorageBlobObject)
                    else {
                        Write-Host $StorageBlobObject.Name $StorageBlobObject.Length $StorageBlobObject.LastModified $StorageBlobObject.AccessTier # Write message to screen 
                        Return $StorageBlobObject, $StorageAccObject, $StorageConObject
                    } # End else (if (!$StorageBlobObject))
                } # End :GetAzureBlob while ($true)
            } # End if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes')
            else {
                $StorageBlobObject = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                foreach ($Name in $StorageBlobObject) {
                    Write-Host $Name.Name $Name.Length $Name.LastModified $Name.AccessTier # Write message to screen
                } # End foreach ($Name in $StorageBlobList)
                Return $StorageBlobObject, $StorageAccObject, $StorageConObject
            } # End else (if ($StorageBlobNameInput))
        } # End :ListAzureBlobs while
        Return # Returns to calling function empty
    } # End Begin
} # End function GetAzStorageBlob
function GetAzStorageBlobContent {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :GetAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetLocalFilePath while ($true) {
                $LocalFileDownloadPath = Read-Host "Path to download file to" # Operator input for the destination folder
                if ($LocalFileDownloadPath -eq 'exit') { # If $Var is 'exit'
                    Break GetAzureBlobs
                } # End if ($LocalFileDownloadPath -eq 'exit')
                Write-Host "Download blobs to"$LocalFileDownloadPath # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFilePath
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFilePath while ($true)
            Try {
                foreach ($Name in $StorageBlobObject) {
                    Get-AzStorageBlobContent -Context $StorageAccObject.context -Container $StorageConObject.Name -Blob $Name.Name -Destination $LocalFileDownloadPath
                } # End foreach ($Name in $StorageBlobObject)
            }
            catch {Write-Host "An error has occured"}
            Return $StorageBlobObject
        } # End while statement
        Return # Returns to calling function
    } # End Begin
} # End function GetAzStorageBlobContent
function RemoveAzStorageBlob { # Removes a storage blob
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :RemoveAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            foreach ($Name in $StorageBlobObject) {
                $ConfirmDelete = Read-Host "Do you want to delete"$Name.Name # Operator input to confirm delete
                if ($ConfirmDelete -eq 'exit') { # If $Var is 'exit'
                    Break RemoveAzureBlobs
                } # End if ($ConfirmDelete -eq 'exit')
                if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
                    Remove-AzStorageBlob -Blob $Name.Name -Container $StorageConObject.Name -Context $StorageAccObject.Context # Removes the selected blob
                    Write-Host $Name.Name"has been deleted"  # Write message to screen
                } # End if statement
                else { # If $ConfirmDelete is not 'y' or 'yes'
                    Write-Host $Name.Name "was not deleted"  # Write message to screen
                } # End else statement
            } # End foreach ($Name in $StorageBlobObject)
            $StorageBlobObject = $null # Sets $var to $null
            Return
        } # End RemoveAzureBlobs
        Return
    } # End Begin
} # End function RemoveAzStorageBlob
function ManageAzStorageShare { # Manages storage blob functions
    Begin {
        :ManageAzureStorageShares while ($true) { # :ManageAzureStorageShares named loop to select search function
            Write-Host "Azure Storage Share Management" # Write message to screen
            Write-Host "1 New Storage Share" # Write message to screen
            Write-Host "2 Get Storage Share" # Write message to screen
            Write-Host "3 List All Storage Shares" # Write message to screen
            Write-Host "4 Remove Storage Share" # Write message to screen
            Write-Host "5 Manage Storage Share Contents" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageShare = Read-Host "Option?" # Collects operator input on $ManageAzStorageShare option
            if ($ManageAzStorageShare -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageShares # Ends :ManageAzureStorageShares loop, leading to return statement
            } # End if ($ManageAzStorageShare -eq 'exit')
            elseif ($ManageAzStorageShare -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "New Storage Share" # Write message to screen
                $StorageShareObject = NewAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
                Write-Host $StorageShareObject.Name
            } # End elseif ($ManageAzStorageShare -eq '1')
            elseif ($ManageAzStorageShare -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Share" # Write message to screen
                $StorageShareObject, $StorageAccObject = GetAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageShare -eq '2')
            elseif ($ManageAzStorageShare -eq '3') { # Elseif statement for managing Blobs
                Write-Host "List All Storage Shares" # Write message to screen
                GetAzStorageShareAll # Calls function 
            } # End elseif ($ManageAzStorageShare -eq '3')
            elseif ($ManageAzStorageShare -eq '4') { # Elseif statement for managing Storage shares
                Write-Host "Remove Storage Share" # Write message to screen
                RemoveAzStorageShare ($StorageAccObject, $StorageShareObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageShare -eq '4')
            elseif ($ManageAzStorageShare -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageShareObject) { # If $var is not $null
                Write-Host "Clearing" $StorageShareObject.Name # Write message to screen
                $StorageShareObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageShare -eq '0')
            Write-Host "" # Write message to screen
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageShareObject) { # If $var is not $null
                Write-Host "Current Storage Share:   " $StorageShareObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageShares while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function NewAzStorageShare { # Creates a new storage share
    Begin {
        :NewAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break NewAzureStorageShare # Breaks :NewAzureStorageShare
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) { # Inner loop for setting the name of the new share
                Try { # First validation of the storage share name
                    Write-Host "Storage share name must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$ShareNameInput = [string](Read-Host "New Storage share name").ToLower() # Operator input for the share name
                } # End Try 
                catch { # Catch for failing to meet character validation of the share name
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name was not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End Catch
                if ($ShareNameInput.Length -le 2) { # If $ShareNameInput is less than 3 charaters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameInput.Length -le 2)
                $ShareNameSplit = $ShareNameInput.split() # Creates $ShareNameSplit, a list of entries for each space in $ShareNameInput
                if ($ShareNameSplit.Count -gt 1) { # If $ShareNameSplit is greater than 1 value
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, no spaces are allowed in the name" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameSplit.Count -gt 1)
                $ShareNameSplit = $null  # Sets $StorageConNameSplit to $null
                if ($ShareNameInput -eq '0') { # If $ShareNameInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($ShareNameInput -eq '0')
                else { # All checks on $ShareNameInput passed
                    Write-Host "This will be the share name" # Write message to screen
                    Write-Host $ShareNameInput # Write message to screen
                    $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation on using this name
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfrim is equal to 'y' or 'yes'
                        Break SetAzureShareName # Breaks :SetAzureShareName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End else (if ($ShareNameInput.Length -le 2))
            } # End :SetAzureShareName while ($true)
            $StorageShareObject = New-AzStorageShare -Name $ShareNameInput -Context $StorageAccObject.Context # Creates the storage share and assigns to $StorageShareObject
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :NewAzureStorageShare while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzStorageShare
Function GetAzStorageShare { # Gets a storage share
    Begin {
        :GetAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if (!$StorageAccObject) 
            } # End if (!$StorageAccObject) {
            $StorageShareList = Get-AzStorageShare -Context $StorageAccObject.Context # Collects all shares in selected storage account
            if (!$StorageShareList) { # If $StorageSharelist returns empty
                Write-Host "No storage shares found" # Message write to screen
                Break GetAzureStorageShare # Ends :GetAzureStorageShare
            } # End if (!$StorageShareList)
            $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                Write-Host $StorageShareListNumber"." $_.Name # Writes $StorageShareList to screen
                $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
            } # End foreach ($_ in $StorageShareList)
            :GetAzureStorageShareNumber while ($true) {
                $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
                $StorageShareListSelect = Read-Host "Please enter the number of the storage share" # Operator input for the storage share selection
                if ($StorageShareListSelect -eq '0') { # If $StorageShareList is '0'
                    Break :GetAzureStorageShare # Ends :GetAzureStorageShare
                } # if ($StorageShareListSelect -eq '0')
                foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                    if ($StorageShareListSelect -eq $StorageShareListNumber) { # If the operator input matches the current $StorageShareListNumber
                        $StorageShareObject = $_ # Assigns current item in $StorageShareList to $StorageShareObject
                        Break GetAzureStorageShareNumber # Breaks :GetAzureStorageShare
                    } # End if ($StorageShareListSelect -eq $StorageShareListNumber)
                    else { # If user input does not match the current $StorageShareListNumber
                        $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
                    } # End else (if ($StorageShareListSelect -eq $StorageShareListNumber))
                } # End foreach ($_ in $StorageShareList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageShare while ($true) {
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :GetAzureStorageShare while ($true)
        Return # Returns $null
    } # End Begin
} # End Function GetAzStorageShare
Function GetAzStorageShareAll { # Lists all storage shares in a subscription
    Begin {
        $StorageAccObject = Get-AzStorageAccount # Collects all storage accounts in the subscription
        foreach ($Name in $StorageAccObject) { # For each name in $StorageAccObject
            Write-Host "Resource Group:"$Name.ResourceGroupName # Write message to screen
            Write-Host "Storage Account:"$Name.StorageAccountName # Write message to screen
            Try { # Try to get storage shares within a storage account
                $StorageShareObject = Get-AzStorageShare -Context $Name.Context # Collects all storage shares in a storage account
            } # End Try
            Catch { # If Try fails
                Write-Host "Permissions or locks prevent a search in this storage account" # Write message to screen
                $StorageShareObject = $null # Clears $StorageShareObject
            } # End Catch
            foreach ($Name in $StorageShareObject) { # For each name in $StorageShareObject
                Write-Host "Storage Share:"$Name.Name # Write message to screen
            } # End foreach ($Name in $StorageShareObject)
            Write-Host "" # Write message to screen
        } # End foreach ($Name in $StorageAccObject) 
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShareAll
function RemoveAzStorageShare { # Removes a storage share
    Begin {
        if (!$StorageAccObject) { # If $StorageAccObject is $null
            $StorageAccObject = GetAzStorageAccount # Call function and assign result to $var
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                Return # Returns to calling function with $null
            } # End if (!$StorageAccObject)
        } # End if (!$StorageShareObject)
        if (!$StorageShareObject) { # If $StorageShareObject is $null 
            $StorageShareObject = GetAzStorageShare ($StorageAccObject) # Call function and assign result to $var
            if (!$StorageShareObject) { # If $StorageShareObject is $null 
                Return # Returns to calling function with $null
            } # End if (!$StorageShareObject)
        } # End if (!$StorageShareObject)
        Write-Host "Remove the storage share:"$StorageShareObject.Name"in storage account:"$StorageAccObject.StorageAccountName # Write message to screen
        $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation to remove storage share
        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
            Try { # Try to do the following
                Remove-AzStorageShare -Name $StorageShareObject.Name -Context $StorageAccObject.Context # Remove the selected share
            } # End Try
            Catch { # If try fails
                Write-Host "" # Write message to screen
                Write-Host "The storage share was not removed, you may not have the permissions to do so" # Write message to screen
                Write-Host "" # Write message to screen
                Return # Returns to calling function with $null
            } # End Catch
            Write-Host "" # Write message to screen
            Write-Host "The storage share was removed" # Write message to screen
            Write-Host "" # Write message to screen
            Return # Returns to calling function with $null
        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
        else { # Returns to calling function with $null
            Write-Host "No action taken, returning to menu" # Write message to screen
            Return # Returns to calling function with $null
        } # End else (if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
    } # End Begin
} # End function RemoveAzStorageShare
function ManageAzKeyVault { # Script for managing Azure
    Begin {
        :ManageAzureKeyVault while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($RGObject -or $KeyVaultObject) { # If $RGObject or $KeyVault Object has a value
                Write-Host '0 to clear $RGObject and $KeyVaultObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault" # Write message to screen
            Write-Host "2 List All Key Vaults" # Write message to screen
            Write-Host "3 Get Key Vault" # Write message to screen
            Write-Host "4 Remove Key Vault" # Write message to screen
            Write-Host "5 Manage Key Vault Keys" # Write message to screen
            Write-Host "6 Manage Key Vault Secrets" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultSelect = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultSelect -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault" # Option selection write to screen
                $KeyVaultObject = NewAzKeyVault ($RGObject) # Calls function NewAzKeyVault
            } # End if statement
            elseif ($ManageAzKeyVaultSelect -eq '2') { # Elseif statement for option 2
                Write-Host "List All Key Vaults" # Option selection write to screen
                ListAzKeyVault # Calls function ListAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '3') { # Elseif statement for option 3
                Write-Host "Get Key Vault" # Option selection write to screen
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function GetAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '4') { # Elseif statement for option 4
                Write-Host "Remove Key Vault" # Option selection write to screen
                RemoveAzKeyVault ($KeyVaultObject) # Calls function RemoveAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '5') { # Elseif statement for option 5
                Write-Host "Manage Key Vault Keys" # Option selection write to screen
                ManageAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function ManageAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '6') { # Elseif statement for option 6
                Write-Host "Manage Key Vault Secrets" # Option selection write to screen
                ManageAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function ManageAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                Write-Host '$RGObject and $KeyVaultObject have been cleared'
            } # End elseif ($ManageAzKeyVaultSelect -eq '0')
            elseif ($ManageAzKeyVaultSelect -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVault # Breaks :ManageAzureKeyVault
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureKeyVault while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVault
function NewAzKeyVault { # Creates a new key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureKeyVaultName while ($true) { # Inner loop for setting the key vault name
                $KeyVaultNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of vault name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultNameInput = [string](Read-Host "New vault name (3-24 letters and numbers only)") # Operator input for the vault name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The vault name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultNameInput -eq 'exit') { # $KeyVaultNameInput is equal to exit
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultNameInput -eq 'exit')
                elseif ($KeyVaultNameInput -eq '0') {}# Elseif when Try statement fails
                elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25) { # If $KeyVaultNameInput is not between 3 and 24 characters
                    Write-Host "The vault name must be between 3 and 24 characters in length" # Write message to screen
                } # End elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultNameInput -eq 'exit'))
            } # :SetAzureKeyVaultName while ($true)
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureKeyVaultLoc while ($true) { # Inner loop for setting the vault location
                $KeyVaultLocInput = Read-Host "New key vault location" # Operator input for the vault location
                if ($KeyVaultLocInput -eq 'exit') { # If $KeyVaultLocInput is 'exit'
                    Break NewAzureKeyVault # Breaks :NewAzureKeyVault
                } # if ($KeyVaultNameInput -eq 'exit')
                if ($KeyVaultLocInput -iin $ValidLocation.Location) { # if $KeyVaultLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $KeyVaultLocInput # Write $KeyVaultLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultLoc # Breaks :SetAzureKeyVaultLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($KeyVaultLocInput -iin $ValidLocation)
                else { # All other inputs for $KeyVaultLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($KeyVaultLocInput -iin $ValidLocation))
            } # End :SetAzKeyVaultLoc while ($true)
            $KeyVaultObject = New-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName -Location $KeyVaultLocInput -Name $KeyVaultNameInput # Creates the new key vault and assigns to $KeyVaultObject
            Return $KeyVaultObject # Returns $var to calling function
        } # End :NewAzureKeyVault while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzkeyvault
function GetAzKeyVault { # Collects a key vault object
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is empty
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # If $RGObject is still empty after returning
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $KVList = Get-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName # Gets all key vaults in resource group and assigns to $KVList
            if (!$KVList) { # If $KVList returns empty
                Write-Host "No key vaults found" # Message write to screen
                Break GetAzureKeyVault # Breaks :GetAzureKeyVault
            } # End if (!$KVList)
            $KVListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $KVList) { # For each item in list
                Write-Host $KVListNumber"." $_.VaultName # Writes the option number and key vault name
                $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
            } # End foreach ($_ in $KVList)
            :SelectAzureKeyVault while ($true) { # Loop for selecting the key vault object
                $KVListNumber = 1 # Resets list number to 1
                $KVListSelect = Read-Host "Enter the option number" # Operator input for selecting which key vault
                if ($KVListSelect -eq '0') { # If $KVListSelect is equal to 0
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if ($KVListSelect -eq '0')
                foreach ($_ in $KVList) { # For each item in list
                    if ($KVListSelect -eq $KVListNumber) { # If the operator input matches the current $KVListNumber
                        $KeyVaultObject = Get-AzKeyVault -VaultName $_.VaultName # Currently selected item in $KVList is assigned to $KeyVaultObject
                        Break SelectAzureKeyVault # Breaks :SelectAzureKeyVault
                    } # End if ($KVListSelect -eq $KVListNumber)
                    else { # If user input does not match the current $KVListNumber
                        $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
                    } # End else (if ($KVListSelect -eq $KVListNumber))
                } # End foreach ($_ in $KVList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :SelectAzureKeyVault while ($true)
            Return $KeyVaultObject # Returns $RGObject to calling function
        } # End :GetAzureKeyVault while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzKeyVault
function ListAzKeyVault { # Lists all key vaults in subscription
    Begin {
        #$ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $KVList = Get-AzKeyVault # Gets all key vaults and assigns to $KVList
        if (!$KVList) { # If $KVList returns empty
            Write-Host "No key vaults found" # Message write to screen
        } # End if (!$KVList)
        else { # If $KVList has a value
            foreach ($_ in $KVList) { # For each item in $KVList
                Write-Host "VaultName:" $_.VaultName "ResourceGroup:" $_.ResourceGroupName # Write message to screen 
            } # End else 
        } # End else (if (!$KVList))
        Return # Returns to calling function with $null
    } # End Begin
} # End function ListAzKeyVault
function RemoveAzKeyVault { # Removes $KeyVaultObject
    Begin {
        :RemoveAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is empty
                $KeyVaultKeyObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is still empty after returning
                    Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
                } # End if (!$KeyVaultKeyObject)
            } # End if (!$KeyVaultKeyObject)
            Write-Host "Remove Vault "$KeyVaultKeyObject.VaultName "in resource group "$KeyVaultKeyObject.ResourceGroupName # Write message to screen
            $ConfirmDelete = Read-Host "[Y] or [N]" # Operator confirmation to delete the key vault
            if (!($ConfirmDelete -eq 'y')) { # If Confirm delete is not 'y'
                Write-Host "No action taken" # Write message to screen
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # IF $ConfrimDelete is not 'y'
                Write-Host "Deleting "$KeyVaultKeyObject.VaultName # Write message to screen
                Remove-AzKeyVault -VaultName $KeyVaultKeyObject.VaultName -ResourceGroupName $KeyVaultKeyObject.ResourceGroupName -force # Removes the key vault
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End else if (!($ConfirmDelete -eq 'y'))
        } # End :RemoveAzureKeyVault while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzKeyVault
function ManageAzKeyVaultKey { # Script for managing Azure
    Begin {
        :ManageAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($KeyVaultKeyObject) { # If $KeyVaultObjectKey has a value
                Write-Host '$KeyVaultObjectKey:' $KeyVaultKeyObject.Name # Write message to screen
            } # End if ($KeyVaultKeyObject)
            if ($RGObject -or $KeyVaultObject -or $KeyVaultKeyObject) { # If $RGObject, $KeyVaultObject, or $KeyVaultKeyObject has a value
                Write-Host '0 to clear $RGObject, $KeyVaultObject $KeyVaultKeyObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault Key" # Write message to screen
            Write-Host "2 Add Key Vault Key" # Write message to screen
            Write-Host "3 List All Key Vaults Keys" # Write message to screen
            Write-Host "4 Get Key Vault Key" # Write message to screen
            Write-Host "5 Download Key Vault Key" # Write message to screen
            Write-Host "6 Remove Key Vault Key" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultKeySel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultKeySel -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault Keys" # Option selection write to screen
                $KeyVaultKeyObject = NewAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function NewAzKeyVaultKey
            } # End if statement
            elseif ($ManageAzKeyVaultKeySel -eq '2') { # Elseif statement for option 2
                Write-Host "Add Key Vault Key" # Option selection write to screen
                AddAzKeyVaultKey # Calls function ListAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '3') { # Elseif statement for option 3
                Write-Host "List All Key Vaults Keys" # Option selection write to screen
                ListAzKeyVaultKey # Calls function ListAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '4') { # Elseif statement for option 4
                Write-Host "Get Key Vault Key" # Option selection write to screen
                $KeyVaultKeyObject = GetAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function GetAzKeyVaultKey
                $KeyVaultKeyObject
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '5') { # Elseif statement for option 5
                Write-Host "Download Key Vault Key" # Option selection write to screen
                DownloadAzKeyVaultKey ($RGObject, $KeyVaultObject, $KeyVaultKeyObject) # Calls function DownloadAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '6') { # Elseif statement for option 6
                Write-Host "Remove Key Vault Key" # Option selection write to screen
                RemoveAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function RemoveAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                $KeyVaultKeyObject = $null # Sets $var to $null
                Write-Host '$RGObject, $KeyVaultObject, and $KeyVaultKey have been cleared'
            } # End elseif ($ManageAzKeyVaultKeySel -eq '0')
            elseif ($ManageAzKeyVaultKeySel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVaultKey # Breaks :ManageAzureKeyVaultKey
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
         } # End :ManageAzureKeyVaultKey while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVaultKey
function NewAzKeyVaultKey { # Creates a new $KeyVaultKeyObject
    Begin {
        :NewAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :AzureKeyVaultKeyName while ($true) { # Inner loop for validating and setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of key name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultKeyNameInput = [string](Read-Host "New key name (less than 64 characters, letters and numbers only)") # Operator input for the key name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The key name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultKeyNameInput -eq 'exit') { # $KeyVaultKeyNameInput is equal to exit
                    Break NewAzureKeyVaultKey # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultKeyNameInput -eq 'exit')
                elseif ($KeyVaultKeyNameInput.Length -ge 64) { # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host "The key name must be between 1 and 63 characters in length" # Write message to screen
                    $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                } # End elseif ($KeyVaultKeyNameInput.Length -ge 63
                elseif ($KeyVaultKeyNameInput -eq '0') {}# Elseif when Try statement fails)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultKeyNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break AzureKeyVaultKeyName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultKeyNameInput -eq 'exit'))
            } # End :AzureKeyVaultKeyName while ($true)
            $KeyNotBefore = $null # Clears all previous uses of this $var
            $KeyExpiration = Read-Host "Set key expiration [Y] or [N]"
            if ($KeyExpiration -eq 'y') { # If $KeyExpiration equals 'y'
                :AzureKeyVaultKeyExpire while ($true) { # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date # Gets current date
                    $EndDate = Read-Host 'Key expiration date: YEAR-MO-DY' # Operator input for end date
                    if ($EndDate -eq 'exit') { # If $EndDate equals 'exit'
                        Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                    } # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate # Gets count of days between current and end date
                    if (!$DateDiff) { # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host "The expiration date entry was not valid" # Write message to screen
                        Write-Host "Please enter a date in the listed format" # Write message to screen
                    } # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) { # $DateDiff is 0 or less
                        Write-Host "The date entered was not in the future" # Write message to screen
                        Write-Host "Please enter a future date" # Write message to screen
                        $DateDiff = $null # Clears all previous uses of this $var
                    } # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) { # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime() # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime() # Sets $KeyNotBefore to current date
                        Break AzureKeyVaultKeyExpire # Breaks :AzureKeyVaultKeyExpire
                    } # End if ($DateDiff)
                } # End AzureKeyVaultKeyExpire while ($true)
            } # End if ($KeyExpiration -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) { # Inner loop for setting the encyption type
                $KeyEncryptType = Read-Host "[HSM] or [Software]" # Operator input for the key encryption type
                if ($KeyEncryptType -eq 'exit') { # If $KeyEncryptType is equal to 'exit'
                    Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                } # End if ($KeyEncryptType -eq 'exit')
                elseif ($KeyEncryptType -eq 'HSM') { # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') { # If $KeyEncryptType is equal to 'HSM' and $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host "HSM is not supported on this key vault" # Write message to screen
                        Write-Host "Please enter 'Software' if this vault is used" # Write message to screen
                        Write-Host "Otherwise, enter 'exit' to leave this function" # Write message to screen
                    } # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else { # If $KeyVaultObject.SKU does not equal 'standard'
                        Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt 
                    } # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                } # End elseif ($KeyEncryptType -eq 'HSM')
                elseif ($KeyEncryptType -like 'Soft*') { # If $KeyEncryptType is equal to 'Soft*'
                    $KeyEncryptType = 'Software' # Sets $KeyEncryptType to 'Software'
                    Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt
                } # End elseif ($KeyEncryptType -like 'Soft*')
                else { # If $KeyEncryptType is not HSM or Software
                    Write-Host "That was not a valid input" # Write message to screen
                } # End ese (if ($KeyEncryptType -eq 'exit'))
            } # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) { # If $KeyNotBefore has a value
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires $KeyExpires -NotBefore $KeyNotBefore # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End if ($KeyNotBefore)
            else { # If $KeyNotBefore is $null
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End else (if ($KeyNotBefore))
        } # End :NewAzureKeyVaultKey while ($true)
        Return # Returns with $null
    } # End Begin
} # End function NewAzKeyVaultKey
function AddAzKeyVaultKey { # Creates a new key vault key
    Begin {
        :AddAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :GetLocalDownloadPath while ($true) { # Inner loop for getting the file patch
                $LocalPath = Read-Host "Please enter the file path (E.X. C:\Users\Admin\Downloads\)" # Operator input for the download path
                if ($LocalPath -eq 'exit') { # If $var is equal to 'exit' 
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey
                } # End if ($LocalPath -eq 'exit')
                if ($LocalPath -notlike '*\') { # If $LocalPath does not end with \
                    Write-Host "The path is not valid" # Write message to screen
                    Write-Host "Please re-enter the path" # Write message to screen
                } # End if ($LocalPath -notlike '*\')
                else { # If $LocalPath ends with \
                    Break GetLocalDownloadPath # Breaks :GetLocalDownloadPath
                } # End else (if ($LocalPath -notlike '*\'))
            } # End :GetLocalDownloadPath while ($true)
            :GetLocalFileName while ($true) { # Inner loop for getting the key local name
                $LocalFileName = Read-Host "Enter the key name and extension (E.X. Key.pfx)" # Operator input for the key name
                if ($LocalFileName -eq 'exit') { # If $var is equal to 'exit'
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey
                } # End if ($LocalFileName -eq 'exit')
                #$LocalfileName = $LocalFileName+'.pem' # Adds .pem to file name
                Write-Host $LocalFileName # Write message to screen
                $OperatorConfirm = Read-Host "Use this file name [Y] or [N]" # Operator confirmation of file name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break GetLocalFileName # Breaks :GetLocalFileName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :GetLocalFileName while ($true)
            $Fullpath = $LocalPath+$LocalFileName # Creates the full file path and name $var
            :AzureKeyVaultKeyName while ($true) { # Inner loop for validating and setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of key name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultKeyNameInput = [string](Read-Host "New key name (less than 64 characters, letters and numbers only)") # Operator input for the key name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The key name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultKeyNameInput -eq 'exit') { # $KeyVaultKeyNameInput is equal to exit
                    Break AddAzureKeyVaultKey # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultKeyNameInput -eq 'exit')
                elseif ($KeyVaultKeyNameInput.Length -ge 64) { # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host "The key name must be between 1 and 63 characters in length" # Write message to screen
                    $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                } # End elseif ($KeyVaultKeyNameInput.Length -ge 63
                elseif ($KeyVaultKeyNameInput -eq '0') {}# Elseif when Try statement fails)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultKeyNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break AzureKeyVaultKeyName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultKeyNameInput -eq 'exit'))
            } # End :AzureKeyVaultKeyName while ($true)
            $KeyNotBefore = $null # Clears all previous uses of this $var
            $KeyExpiration = Read-Host "Set key expiration [Y] or [N]"
            if ($KeyExpiration -eq 'y') { # If $KeyExpiration equals 'y'
                :AzureKeyVaultKeyExpire while ($true) { # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date # Gets current date
                    $EndDate = Read-Host 'Key expiration date: YEAR-MO-DY' # Operator input for end date
                    if ($EndDate -eq 'exit') { # If $EndDate equals 'exit'
                        Break AddAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                    } # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate # Gets count of days between current and end date
                    if (!$DateDiff) { # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host "The expiration date entry was not valid" # Write message to screen
                        Write-Host "Please enter a date in the listed format" # Write message to screen
                    } # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) { # $DateDiff is 0 or less
                        Write-Host "The date entered was not in the future" # Write message to screen
                        Write-Host "Please enter a future date" # Write message to screen
                        $DateDiff = $null # Clears all previous uses of this $var
                    } # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) { # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime() # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime() # Sets $KeyNotBefore to current date
                        Break AzureKeyVaultKeyExpire # Breaks :AzureKeyVaultKeyExpire
                    } # End if ($DateDiff)
                } # End AzureKeyVaultKeyExpire while ($true)
            } # End if ($KeyExpiration -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) { # Inner loop for setting the encyption type
                $KeyEncryptType = Read-Host "[HSM] or [Software]" # Operator input for the key encryption type
                if ($KeyEncryptType -eq 'exit') { # If $KeyEncryptType is equal to 'exit'
                    Break AddAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                } # End if ($KeyEncryptType -eq 'exit')
                elseif ($KeyEncryptType -eq 'HSM') { # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') { # If $KeyEncryptType is equal to 'HSM' and $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host "HSM is not supported on this key vault" # Write message to screen
                        Write-Host "Please enter 'Software' if this vault is used" # Write message to screen
                        Write-Host "Otherwise, enter 'exit' to leave this function" # Write message to screen
                    } # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else { # If $KeyVaultObject.SKU does not equal 'standard'
                        Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt 
                    } # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                } # End elseif ($KeyEncryptType -eq 'HSM')
                elseif ($KeyEncryptType -like 'Soft*') { # If $KeyEncryptType is equal to 'Soft*'
                    $KeyEncryptType = 'Software' # Sets $KeyEncryptType to 'Software'
                    Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt
                } # End elseif ($KeyEncryptType -like 'Soft*')
                else { # If $KeyEncryptType is not HSM or Software
                    Write-Host "That was not a valid input" # Write message to screen
                } # End ese (if ($KeyEncryptType -eq 'exit'))
            } # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) { # If $KeyNotBefore has a value
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires $KeyExpires -NotBefore $KeyNotBefore -KeyFilePath $Fullpath # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End if ($KeyNotBefore)
            else { # If $KeyNotBefore is $null
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -KeyFilePath $Fullpath # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End else (if ($KeyNotBefore))
        } # End :AddAzureKeyVaultKey while ($true)
        Return # Returns with $null
    } # End Begin
} # End function AddAzKeyVaultKey
function ListAzKeyVaultKey { # Lists all key vault Keys
    Begin {
        $KVList = Get-AzKeyVault # Creates lists of all key vaults
        foreach ($VaultName in $KVList) { # For each key vault in $KVList
            Write-Host "-----------------------------------" # Write message to screen
            $KVKeylist = Get-AzKeyVaultKey -VaultName $VaultName.VaultName # Creates a list of all keys in current $VaultName
            Write-Host "Vault Name: " $VaultName.VaultName # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($Name in $KVKeylist) { # For each Key name in $KVKeyList
                Write-Host "Key Name:   " $Name.Name # Write message to screen
                Write-Host "Key ID:     " $Name.ID
                Write-Host "Enabled:    " $Name.Enabled # Write message to screen
                Write-Host "Updated:    " $Name.Updated # Write message to screen
                if ($Name.Expires) { # If Selected key has an existing expiration
                    Write-Host "Expires:    " $Name.Expires # Write message to screen
                    Write-Host "NotBefore:  " $Name.NotBefore
                } # End if ($Name.Expires)
                Write-Host "" # Write message to screen
            } # End foreach ($Name in $KVKeylist)
        } # End foreach ($VaultName in $KVList)
        Write-Host "-----------------------------------" # Write message to screen
        Return # Retures to calling function with $null
    } # End Begin 
} # End function ListAzKeyVaultKey
function GetAzKeyVaultKey { # Function to get a key vault Key
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVKeylist = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName # Creates list of all Keys in vault
            if (!$KVKeylist) { # If $KVKeylist returns empty
                Write-Host "No Keys found" # Message write to screen
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if (!$KVKeylist)
            $KVKeylistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVKeylist) { # For each item in list
                Write-Host $KVKeylistNumber"." $_.Name # Writes list to screen
                $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
            } # End foreach ($_ in $KVKeylist) 
            $KVKeylistNumber = 1 # Resets list number to 1
            $KVKeylistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVKeylistSelect -eq '0') { # If $KVKeyListSelect is 0
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if ($KVKeylistSelect -eq '0')
            :SelectAzureKeyVaultKey foreach ($_ in $KVKeylist) { # For each item in list
                if ($KVKeylistSelect -eq $KVKeylistNumber) { # If the user input matches the current $KVKeylistNumber
                    $KeyVaultKeyObject = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultKeyObject
                    Break SelectAzureKeyVaultKey # Breaks :SelectAzureKeyVaultKey
                } # End if ($KVKeylistSelect -eq $KVKeylistNumber)
                else { # If user input does not match the current $KVKeylistNumber
                    $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
                } # End else (if ($KVKeylistSelect -eq $KVKeylistNumber))
            } # End :SelectAzureKeyVaultKey
            Return $KeyVaultKeyObject # Returns $KeyVaultKeyObject to calling function
        } # End :GetAzureKeyVaultKey while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultKey
function DownloadAzKeyVaultKey { # Downloads a selected key vault key
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :DownloadAzureKVKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is $null 
                $KeyVaultKeyObject = GetAzKeyVaultKey # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $var is still $null
                    Break DownloadAzureKeyVaultKey # Breaks :DownloadAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :SetLocalDownloadPath while ($true) { # Inner loop for setting the download path
                $LocalPath = Read-Host "Please enter the file path (E.X. C:\Users\Admin\Downloads\)" # Operator input for the download path
                if ($LocalPath -eq 'exit') { # If $var is equal to 'exit' 
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalPath -eq 'exit')
                if ($LocalPath -notlike '*\') { # If $LocalPath does not end with \
                    Write-Host "The path is not valid" # Write message to screen
                    Write-Host "Please re-enter the path" # Write message to screen
                } # End if ($LocalPath -notlike '*\')
                else { # If $LocalPath ends with \
                    Break SetLocalDownloadPath # Breaks :SetLocalDownloadPath
                } # End else (if ($LocalPath -notlike '*\'))
            } # End :SetLocalDownloadPath while ($true)
            :SetLocalFileName while ($true) { # Inner loop for setting the key local name
                $LocalFileName = Read-Host "Enter the key name" # Operator input for the key name
                if ($LocalFileName -eq 'exit') { # If $var is equal to 'exit'
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem' # Adds .pem to file name
                Write-Host $LocalFileName # Write message to screen
                $OperatorConfirm = Read-Host "Use this file name [Y] or [N]" # Operator confirmation of file name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetLocalFileName # Breaks :SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetLocalFileName while ($true)
            $Fullpath = $LocalPath+$LocalFileName # Creates the full download path and name $var
            Try { # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultKeyObject.VaultName -Name $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction Stop # Downloads the selected key
            } # End Try
            Catch { # If try fails
                Write-Host "An error has occured" # Write message to screen
                Write-Host "You may not have permissions to this key" # Write message to screen
                Write-Host "You may not have permissions to the download location" # Write message to screen
                Write-Host "The selected download location may not exist" # Write message to screen
            } # End Catch
            Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
        } # End :DownloadAzureKVKey while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function DownloadAzKeyVaultKey
function RemoveAzKeyVaultKey { # Removes a key vault key
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :RemoveAzureKeyVaultKey while ($true) {
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is $null 
                $KeyVaultKeyObject = GetAzKeyVaultKey # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $var is still $null
                    Break RemoveAzureKeyVaultKey # Breaks :DownloadAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            Write-host "The selected key for removal is:"$KeyVaultKeyObject.Name"in vault:"$KeyVaultKeyObject.VaultName # Write message to screen
            $ConfirmDelete = Read-Host "Remove this key [Y] or [N]" # Operator confirmation for deletion
            if (!($ConfirmDelete -eq 'y')) { # $Confirm delete is not equal to 'y'
                Break RemoveAzureKeyVaultkey # Breaks :RemoveAzureKeyVaultKey
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is equal to 'y'
                Write-Host "Removing" $KeyVaultKeyObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName $KeyVaultKeyObject.VaultName -Force # Removes the selected key
                } # End Try
                catch { # If error on Try
                    Write-Host "There was an issue removing the selected key" # Write message to screen
                    Write-Host "You may not have the permissions to remove this key" # Write message to screen
                    Break RemoveAzureKeyVaultKey # Breaks :RemoveAzureKeyVaultKey 
                } # End catch
                Write-Host "This Key has been removed" # Write message to screen
                Break RemoveAzureKeyVaultKey # Breaks :RemoveAzureKeyVaultKey
            } # End else (if (!($ConfirmDelete -eq 'y')))
        } # End :RemoveAzureKeyVaultKey while ($true)
        Return
    } # End Begin
} # End function RemoveAzKeyVaultKey
function ManageAzKeyVaultSecret { # Script for managing Azure
    Begin {
        :ManageAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($KeyVaultSecretObject) { # If $KeyVaultObjectSecret has a value
                Write-Host '$KeyVaultObjectSecret:' $KeyVaultSecretObject.Name # Write message to screen
            } # End if ($KeyVaultSecretObject)
            if ($RGObject -or $KeyVaultObject -or $KeyVaultSecretObject) { # If $RGObject, $KeyVaultObject, or $KeyVaultSecretObject has a value
                Write-Host '0 to clear $RGObject, $KeyVaultObject $KeyVaultSecretObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault Secret" # Write message to screen
            Write-Host "2 List All Key Vaults Secret" # Write message to screen
            Write-Host "3 Get Key Vault Secret" # Write message to screen
            Write-Host "4 Get Key Vault Secret Value" # Write message to screen
            Write-Host "5 Update Key Vault Secret Value" # Write message to screen
            Write-Host "6 Remove Key Vault Secret Value" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultSecretSel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultSecretSel -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault Secrets" # Option selection write to screen
                $KeyVaultSecretObject = NewAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function NewAzKeyVaultSecret
            } # End if statement
            elseif ($ManageAzKeyVaultSecretSel -eq '2') { # Elseif statement for option 2
                Write-Host "List All Key Vaults Secrets" # Option selection write to screen
                ListAzKeyVaultSecret # Calls function ListAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '3') { # Elseif statement for option 3
                Write-Host "Get Key Vault Secret" # Option selection write to screen
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function GetAzKeyVaultSecret
                $KeyVaultSecretObject
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '4') { # Elseif statement for option 4
                Write-Host "Get Key Vaule Secret Value" # Option selection write to screen
                GetAzKeyVaultSecretValue ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function GetAzKeyVaultSecretValue
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '5') { # Elseif statement for option 5
                Write-Host "Update Key Vault Secret Value" # Option selection write to screen
                UpdateAzKeyVaultSecret ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function UpdateAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '6') { # Elseif statement for option 6
                Write-Host "Remove Key Vault Secret Value" # Option selection write to screen
                RemoveAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function RemoveAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                $KeyVaultSecretObject = $null # Sets $var to $null
                Write-Host '$RGObject, $KeyVaultObject, and $KeyVaultSecret have been cleared'
            } # End elseif ($ManageAzKeyVaultSecretSel -eq '0')
            elseif ($ManageAzKeyVaultSecretSel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVaultSecret # Breaks :ManageAzureKeyVaultSecret
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVaultSecret
function NewAzKeyVaultSecret { # Creates a new key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :NewAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $var is $null
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function and assigns output to $Var
                if (!$KeyVaultObject) { # If $var is $null
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :NewAzureKeyVaultSecretName while ($true) { # Inner loop for setting the new key vault secret name
                $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
                Write-Host $KeyVaultSecretName # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret name [Y] or [N]" # Operator confirmation of name
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretName # Breaks :NewAzureKeyVaultSecretName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretName while ($true)
            :NewAzureKeyVaultSecretValue while ($true) { # Inner loop for setting the new key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value" # Prompt for operator input for $KeyVaultSecretvalue
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretValue # Breaks :NewAzureKeyVaultSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates $KeyVaultSecretObject
            Return $KeyVaultSecretObject # Returns to calling function with $KeyVaultSecretObject
        } # End :NewAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzKeyVaultSecret
function ListAzKeyVaultSecret { # Lists all key vault secrets
    Begin {
        $KVList = Get-AzKeyVault # Creates lists of all key vaults
        foreach ($VaultName in $KVList) { # For each key vault in $KVList
            Write-Host "-----------------------------------" # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName # Creates a list of all keys in current $VaultName
            Write-Host "Vault Name: " $VaultName.VaultName # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($Name in $KVSecretlist) { # For each secret name in $KVSecretList
                Write-Host "Secret Name:" $Name.Name # Write message to screen
                Write-Host "Enabled:    " $Name.Enabled # Write message to screen
                Write-Host "Created:    " $Name.Created # Write message to screen
                Write-Host "Updated:    " $Name.Updated # Write message to screen
                if ($Name.Expires) { # If Selected key has an existing expiration
                    Write-Host "Expires:    " $Name.Expires # Write message to screen
                } # End if ($Name.Expires)
                Write-Host "" # Write message to screen
            } # End foreach ($Name in $KVSecretlist)
        } # End foreach ($VaultName in $KVList)
        Write-Host "-----------------------------------" # Write message to screen
        Return # Retures to calling function with $null
    } # End Begin 
} # End function ListAzKeyVaultSecret
function GetAzKeyVaultSecret { # Function to get a key vault secret
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName # Creates list of all secrets in vault
            if (!$KVSecretlist) { # If $KVSecretlist returns empty
                Write-Host "No secrets found" # Message write to screen
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if (!$KVSecretlist)
            $KVSecretlistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVSecretlist) { # For each item in list
                Write-Host $KVSecretlistNumber"." $_.Name # Writes list to screen
                $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
            } # End foreach ($_ in $KVSecretlist) 
            $KVSecretlistNumber = 1 # Resets list number to 1
            $KVSecretlistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVSecretlistSelect -eq '0') { # If $KVSecretListSelect is 0
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if ($KVSecretlistSelect -eq '0')
            :SelectAzureKeyVaultSecret foreach ($_ in $KVSecretlist) { # For each item in list
                if ($KVSecretlistSelect -eq $KVSecretlistNumber) { # If the user input matches the current $KVSecretlistNumber
                    $KeyVaultSecretObject = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultSecretObject
                    Break SelectAzureKeyVaultSecret # Breaks :SelectAzureKeyVaultSecret
                } # End if ($KVSecretlistSelect -eq $KVSecretlistNumber)
                else { # If user input does not match the current $KVSecretlistNumber
                    $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
                } # End else (if ($KVSecretlistSelect -eq $KVSecretlistNumber))
            } # End :SelectAzureKeyVaultSecret
            Return $KeyVaultSecretObject # Returns $KeyVaultSecretObject to calling function
        } # End :GetAzureKeyVaultSecret while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultSecret
function GetAzKeyVaultSecretValue { # Function to return the value of a key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :GetAzureKeyVaultSecretVal while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            $KeyVaultSecretValue = $null # Clears $KeyVaultSecretValue from all previous use
            $KeyVaultSecretHash = $null # Clears $KeyVaultSecretHash from all previous use
            $KeyVaultSecretHash = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyVaultSecretObject.SecretValue) # Provided by MS Azure
            try { # Provided by MS Azure
                $KeyVaultSecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure
            Catch { # Catch for try statement
                Write-Host "An error has occured, you may not have permissions to this secret or vault" # Write message to screen
                Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
            } # End catch
            finally { # Provided by MS Azure
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure # This code was provided by MS, at this time is not needed and has commented out
            Write-Host "The value of"$KeyVaultSecretObject.Name "is:" $KeyVaultSecretValue # Prints secret name and value to screen
            Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
        } # End :GetAzureKeyVaultSecretValue while ($true) 
        Return # Returns to calling function with $null
    } # End begin statement   
} # End function GetAzKeyVaultSecretValue
function UpdateAzKeyVaultSecret { # Updates the value of selected key
    Begin { 
        :UpdateAzureKeyVaultSecret while ($true) { # Outer loop for managing funciton
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break UpdateAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) { # Inner loop for updating key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value for"$KeyVaultSecretObject.Name # Prompt for operator input for $KeyVaultSecretvalue
                if ($KeyVaultSecretValue -eq 'exit') { # If $KeyVaultSecretValue is equal to 'exit'
                    Break UpdateAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($KeyVaultSecretValue -eq 'exit')
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break UpdateAzureKVSecretValue # Breaks :UpdateAzureKVSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            try { # Try to do the following
                $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultSecretObject.VaultName -Name $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash # Updates $KeyVaultSecretObject
            } # End Try
            catch { # If try statement fails
                Write-Host "There was an issue updating this secret" # Write message to screen
                Write-Host "You may not have the permissions to modify this secret" # Write message to screen
                Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue 
            } # End catch
            Write-Host $KeyVaultSecretObject.Name"has been updated with the new value" # Write message to screen
            Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue
        } # End  :UpdateAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function UpdateAzKeyVaultSecret
function RemoveAzKeyVaultSecret { # Removes a key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :RemoveAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            Write-host "The selected secret for removal is:"$KeyVaultSecretObject.Name"in vault:"$KeyVaultSecretObject.VaultName # Write message to screen
            $ConfirmDelete = Read-Host "Remove this secret [Y] or [N]" # Operator confirmation for deletion
            if (!($ConfirmDelete -eq 'y')) { # $Confirm delete is not equal to 'y'
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is equal to 'y'
                Write-Host "Removing" $KeyVaultSecretObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName $KeyVaultSecretObject.VaultName -Force # Removes the selected key
                } # End Try
                catch { # If error on Try
                    Write-Host "There was an issue removing the selected key" # Write message to screen
                    Write-Host "You may not have the permissions to remove this key" # Write message to screen
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret 
                } # End catch
                Write-Host "This secret has been removed" # Write message to screen
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End else (if (!($ConfirmDelete -eq 'y')))
        } # End :RemoveAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function RemoveAzKeyVaultSecret
function ManageAzDisk { # Script for managing Azure
    Begin {
        :ManageAzureDisk while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($DiskObject) { # If $DiskObject has a value
                Write-Host '$DiskObject:' $DiskObject.Name # Write message to screen
            } # End if ($DiskObject)
            Write-Host "0 Clear Selected Objects" # Write message to screen
            Write-Host "1 New Disk" # Write message to screen
            Write-Host "2 List All Disks" # Write message to screen
            Write-Host "3 Get Disk" # Write message to screen
            Write-Host "4 Remove Disk" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzDiskSel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzDiskSel -eq '1') { # Elseif statement for option 1
                Write-Host "New Disk" # Option selection write to screen
                $DiskObject = NewAzDisk ($RGObject) # Calls function and assigns output to $var
            } # End if statement
            elseif ($ManageAzDiskSel -eq '2') { # Elseif statement for option 2
                Write-Host "List All Disks" # Option selection write to screen
                ListAzDisk # Calls function ListAzDisk
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '3') { # Elseif statement for option 3
                Write-Host "Get Disk" # Option selection write to screen
                $DiskObject = GetAzDisk # Calls function and assigns output to $var
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '4') { # Elseif statement for option 4
                Write-Host "Remove Disk" # Option selection write to screen
                RemoveAzDisk ($DiskObject) # Calls function RemoveAzDisk
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $DiskObject = $null # Sets $var to $null
                Write-Host '$RGObject and $DiskObject have been cleared'
            } # End elseif ($ManageAzDiskSel -eq '0')
            elseif ($ManageAzDiskSel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureDisk # Breaks :ManageAzureDisk
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzDisk
function NewAzDisk { # Creats a new disk object
    Begin {
        :NewAzureDisk while ($true) { 
            if (!$RGObject) { # IF $RGObject is $null 
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # IF $RGObject is $null
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location} # Pulls location from $RGObject 
            :SetAzureDiskName while ($true) { # Inner loop for setting the disk name
                $DiskNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of disk name
                    [ValidatePattern('^[a-z,0-9]+$')]$DiskNameInput = [string](Read-Host "New disk name (3-24 letters and numbers only)") # Operator input for the disk name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The disk name can only include letters and numbers"} # Error message for failed try
                if ($DiskNameInput -eq 'exit') { # $DiskNameInput is equal to exit
                    Break NewAzureDisk # Breaks :NewAzureDisk loop
                } # if ($DiskNameInput -eq 'exit')
                elseif ($DiskNameInput -eq '0') {}# Elseif when Try statement fails
                elseif ($DiskNameInput.Length -le 2 -or $DiskNameInput.Length -ge 25) { # If $DiskNameInput is not between 3 and 24 characters
                    Write-Host "The disk name must be between 3 and 24 characters in length" # Write message to screen
                } # End elseif ($DiskNameInput.Length -le 2 -or $DiskNameInput.Length -ge 25)
                else { # If Try statement input has value not equal to exit
                    Write-Host $DiskNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureDiskName # Breaks SetAzureDiskName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($DiskNameInput -eq 'exit'))
            } # End :SetAzureDiskName while ($true)
            :SetAzureDiskSku while ($true) { # Inner loop for configuring the new disk sku
                [System.Collections.ArrayList]$ValidSku = @() # Creates the valid sku array
                $ValidSkuList = @('Standard_LRS','Premium_LRS','StandardSSD_LRS','UltraSSD_LRS') # Creates a list of items to load into $ValidSku Array
                $SkuNumber = 1 # Sets the base number for the valid sku array
                foreach ($_ in $ValidSkuList) { # For each item in $ValidSkuList
                    $SkuInput = [PSCustomObject]@{'Name' = $_;'Number' = $SkuNumber} # Creates the item to loaded into array
                    $ValidSku.Add($SkuInput) | Out-Null # Loads item into array, out-null removes write to screen
                    $SkuNumber = $SkuNumber + 1 # Increments $SkuNumber up 1
                } # End foreach ($_ in $ValidSkuList)
                foreach ($_ in $ValidSku) { # For each item in $ValidSkut
                    Write-Host $_.Number $_.Name # Write message to screen
                } # End foreach ($_ in $ValidSku)
                :SelectAzureDiskSku while ($true) { # Inner loop for selecting object from list
                    $SkuObjectSelect = Read-Host "Please enter the number of the sku" # Operator input for the selection
                    if ($SkuObjectSelect -eq '0') { # If $$SkuObjectSelect is 0
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } # End if ($_Select -eq '0')
                    $SkuObject = $ValidSku | Where-Object {$_.Number -eq $SkuObjectSelect} # Isolates selected object 
                    $SkuObject = $SkuObject.Name # Pulls just the .name value
                    if ($SkuObject) { # If $SkuObject has a value
                        Break SetAzureDiskSku # Breaks :SetAzureDiskSku
                    } # End if ($SetAzureDiskSku)
                    Write-Host "That was not a valid selection" # Write message to screen 
                } # End :SelectAzureDiskSku while ($true)
            } #End :SetAzureDiskSku while ($true)
            :SetAzureDiskSize while ($true) { # Inner loop for configuring the new disk size
                $DiskSizeObject = -1 # Sets $var to non-break value
                Try{ # Try the following
                    [int]$DiskSizeObject = Read-Host "Size in GB of the Disk [0] to exit" # Operator input for the disk size
                } # End Try
                catch {} # If Try fails
                if ($DiskSizeObject -eq 0) { # If $DiskSizeObject equals 0
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if ($DiskSizeObject -eq 0)
                if ($DiskSizeObject -ge 1) { # If $DiskSizeObject has a value greater than 1
                    Break SetAzureDiskSize # Breaks :SetAzureDiskSize
                } # End if ($DiskSizeObject)
                else { # All other inputs
                    Write-Host "Please enter a positive integer" # Write message to screen
                } # End else (if ($DiskSizeObject -ge 1))
            } # End :SetAzureDiskSize while ($true)
            :SetAzureDiskOSType while ($true) { # ***COMPLETE****
                Write-Host "1 Windows" # Write message to screen
                Write-Host "2 Linux" # Write message to screen
                $DiskOSObject = Read-Host "[1] or [2]" # Operator input for disk os type
                if ($DiskOSObject -eq 'exit') { # If $DiskOSObject equals 'exit'
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } #End if ($DiskOSObject -eq 'exit') 
                elseif ($DiskOSObject -eq '1') { # If $DiskOSObject equals '1'
                    $DiskOSObject = 'Windows' # Changes $DiskOSObject to 'Windows'
                    Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                } # End elseif ($DiskOSObject -eq '1')
                elseif ($DiskOSObject -eq '2') { # If $DiskOSObject equals '2'
                    $DiskOSObject = 'Linux' # Changes $DiskOSObject to 'Linux'
                    Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                } # End elseif ($DiskOSObject -eq '2')
                else { # All other inputs for $DiskOSType
                    Write-Host "That was not a valid option" # Write message to screen
                } # End else (if ($DiskOSObject -eq 'exit') )
            } # End :SetAzureDiskOSType while ($true)
            :EnableAzureDiskEncrypt while ($true) { # Inner loop for configuring the new disk encyption
                $UseEncryptOption = Read-Host "Encypt this disk [Y] or [N]" # Operator input for adding disk encyption
                if ($UseEncryptOption -eq 'exit') { # If $UseEncyptOption equals 'exit'
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if ($UseEncryptOption -eq 'exit')
                elseif ($UseEncryptOption -eq 'n') { # If $UseEncyptOption equals 'n'
                    Break EnableAzureDiskEncrypt # Breaks :EnableAzureDiskEncrypt 
                } # End elseif ($UseEncryptOption -eq 'n')
                elseif ($UseEncryptOption -eq 'y') { # If $UseEncyptOption equals 'y'
                    if (!$KeyVaultObject) { # If $KeyVaultObject has no value
                        $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                        if (!$KeyVaultObject) { # If $KeyVaultObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultObject)
                    } # End if (!$KeyVaultObject)
                    if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject has no value
                        $KeyVaultKeyObject = GetAzKeyVaultKey ($KeyVaultObject) # Calls function and assigns output to $var
                        if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultKeyObject)
                    } # End if (!$KeyVaultKeyObject)
                    if (!$KeyVaultSecretObject) { # If $KeyVaultSecretObject has no value
                        $KeyVaultSecretObject = GetAzKeyVaultSecret ($KeyVaultObject) # Calls function and assigns output to $var
                        if (!$KeyVaultSecretObject) { # If $KeyVaultSecretObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultSecretObject)
                    } # End if (!$KeyVaultSecretObject)
                    Break EnableAzureDiskEncrypt # Breaks :EnableAzureDiskEncrypt
                } # End elseif ($UseEncryptOption -eq 'y')
                else { # All other options for if ($UseEncryptOption -eq 'exit')
                    Write-Host "That was not a valid option" # Write message to screen
                } # End else (if ($UseEncryptOption -eq 'exit'))
            } # End :EnableAzureDiskEncrypt while ($true)
            if ($UseEncryptOption -eq 'y') { # If $UseEncyptOption equals 'y'
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $true # Starts the disk configuration
                $KeyVaultSecretUrl = $KeyVaultSecretObject.ID # Assigns secret URL for later use
                $KeyVaultKeyUrl = $KeyVaultKeyObject.ID # Assigns key URL for later use
                $KeyVaultID = $KeyVaultObject.ResourceID # Assigns key vault ID for later use
                $DiskConfig = Set-AzDiskDiskEncryptionKey -Disk $DiskConfig -SecretUrl $KeyVaultSecretUrl -SourceVaultId $KeyVaultID # Sets the disk encyption secret
                $DiskConfig = Set-AzDiskKeyEncryptionKey -Disk $DiskConfig -KeyUrl $KeyVaultKeyUrl -SourceVaultId $KeyVaultID # Sets the disk encyption key
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName $DiskNameInput -Disk $DiskConfig # Creates the disk
            } # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') { # If $UseEncyptOption equals 'n'
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $false # Sets the disk settings
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName $DiskNameInput -Disk $DiskConfig # Creates the disk
            } # End elseif ($UseEncryptOption -eq 'n')
            Return $DiskObject # Returns to calling function with $DiskObject
        } # End :NewAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzDisk
function ListAzDisk { # Collects disk object
    Begin {
        :ListAzureDisk while ($true) { # Outer loop for managing function
            $DiskList = Get-AzDisk # Gets a list of all disks
            foreach ($_ in $DiskList) { # Writes all objects to screen
                Write-Host "Name:    " $_.Name               # Write message to screen
                Write-Host "RG:      " $_.ResourceGroupName  # Write message to screen
                Write-Host "OS:      " $_.OsType             # Write message to screen
                Write-Host "Size GB: " $_.DiskSizeGB         # Write message to screen
                Write-Host "State:   " $_.DiskState          # Write message to screen
                Write-Host "Location:" $_.Location           # Write message to screen
                Write-Host""                                # Write space at end of each foreach
            } # End foreach ($_ in $DiskList)
            Return # Returns to calling function with $null
        } # End :ListAzureDisk while ($true) 
    } # End Begin
} # End function ListAzDisk
function GetAzDisk { # Collects disk object
    Begin {
        :GetAzureDisk while ($true) { # Outer loop for managing function
            $DiskList = Get-AzDisk # Gets a list of all disks
            $DiskListNumber = 1 # $Var for setting $DiskList.Number
            foreach ($_ in $DiskList) { # For each item in $DiskList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $DiskListNumber # Adds number property to each item in list
                $DiskListNumber = $DiskListNumber + 1 # Increments $DiskListNumber by 1
            } # End foreach ($_ in $DiskList)
            Write-Host "Option:  0 [Exit]" # Write message to screen
            Write-Host"" # Write message to screen
            foreach ($_ in $DiskList) { # Writes all objects to screen
                Write-Host "Option: "$_.Number # Write message to screen
                Write-Host "Name:   " $_.Name # Write message to screen
                Write-Host "RG:     " $_.ResourceGroupName # Write message to screen
                Write-Host "State:  " $_.DiskState # Write message to screen
                Write-Host"" # Write message to screen
            } # End foreach ($_ in $DiskList)
            :SelectAzureDisk while ($true) { # Inner loop for selecting object from list
                $DiskSelect = Read-Host "Please enter the number of the disk" # Operator input for the selection
                if ($DiskSelect -eq '0') { # If $DiskSelect is 0
                    Break GetAzureDisk # Breaks :GetAzureDisk
                } # End if ($_Select -eq '0')
                $DiskListSelect = $DiskList | Where-Object {$_.Number -eq $DiskSelect} # Isolates selected object 
                if ($DiskListSelect) { # If $DiskListSelect has a valud
                    Break SelectAzureDisk # Breaks SelectAzureDisk
                } # End if ($DiskListSelect)
                Write-Host "That was not a valid selection" # Write message to screen 
            } # End :SelectAzureDisk while ($true)
            $DiskObject = Get-AzDisk | Where-Object {$_.Name -eq $DiskListSelect.Name} # Pulls the full list object
            Return $DiskObject # Returns $Object to calling function
        } # End :GetAzureDisk while ($true)
        Return # Returns to calling function with $null 
    } # End Begin
} # End function GetAzDisk
function RemoveAzDisk { # Removes a disk object
    Begin {
        :RemoveAzureDisk while ($true) { # Outer loop for managing function
            if (!$DiskObject) { # If $DiskObject is $null
                $DiskObject = GetAzDisk # Calls function and assigns output to $var
                if (!$DiskObject) { # If $DiskObject is $null
                    Break RemoveAzureDisk # Breaks :RemoveAzureDisk
                } # End if (!$DiskObject)
            } # End if (!$DiskObject)
            Write-Host "Remove disk"$DiskObject.Name "in resource group"$DiskObject.ResourceGroupName # Write message to screen
            $ConfirmDelete = Read-Host "[Y] or [N]" # Operator confirmation to delete the disk
            if (!($ConfirmDelete -eq 'y')) { # If Confirm delete is not 'y'
                Write-Host "No action taken" # Write message to screen
                Break RemoveAzureDisk # Breaks :RemoveAzureDisk
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is 'y'
                Write-Host "Deleting"$DiskObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzDisk -ResourceGroupName $DiskObject.ResourceGroupName -DiskName $DiskObject.Name -Force -ErrorAction 'Stop' # Removes selected disk
                } # End Try
                Catch { # If try fails
                    Write-Host "An error has occured" # Write message to screen
                    Write-Host "The disk may still be in use" # Write message to screen
                    Write-Host "The resource group maybe locked" # Write message to screen
                    Write-Host "You may not have the permissions to remove this disk" # Write message to screen
                    Break RemoveAzureDisk # Breaks :RemoveAzureDisk
                } # End catch
                Write-Host "The selected disk has been deleted" # Write message to screen
                Break RemoveAzureDisk # Breaks :RemoveAzureDisk
            } # End else if (!($ConfirmDelete -eq 'y'))
        } # End :RemoveAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin 
} # End function RemoveAzDisk
# Manage Compute
# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-Object:                 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object?view=powershell-7.1
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.4.0
    New-AzVMConfig:             https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmconfig?view=azps-5.4.0
    Set-AzVMOperatingSystem:    https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmoperatingsystem?view=azps-5.4.0
    Add-AzVMNetworkInterface:   https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-5.4.0
    Set-AzVMSourceImage:        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmsourceimage?view=azps-5.4.0
    New-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm?view=azps-5.4.0     
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Start-AzVM:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Stop-AzVM:                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Invoke-AzVMReimage:         https://docs.microsoft.com/en-us/powershell/module/az.compute/Invoke-AzVMReimage?view=azps-5.4.0
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.4.0
    New-AzVmssConfig:           https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssconfig
    New-AzVmssIPConfig:         https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssipconfig
    Add-AzVmssNetworkInterfaceConfiguration: https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmssnetworkinterfaceconfiguration
    New-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmss
    Set-AzVmssOsProfile:        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssosprofile
    Set-AzVmssStorageProfile:   https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssstorageprofile
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzVMImageOffer:         https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimageoffer
    Get-AzVMImageSku:           https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku
    Get-AzVMImage:              https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimage
    Get-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer
    New-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer
    New-AzLoadBalancerFrontendIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig
    New-AzLoadBalancerProbeConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerprobeconfig
    New-AzLoadBalancerInboundNatPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerinboundnatpoolconfig
    New-AzLoadBalancerRuleConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.6.0
    Get-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Remove-AzVmss:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmss?view=azps-5.6.0
    Get-AzVmssVM:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmssvm?view=azps-5.6.0
    Start-AzVmss:               https://docs.microsoft.com/en-us/powershell/module/az.compute/start-azvmss?view=azps-5.6.0
    Stop-AzVmss:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Stop-azvmss?view=azps-5.6.0
    New-AzContainerGroup :      https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.6.0
    Get-AzContainerGroup:       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0
    Remove-AzContainerGroup:    https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/remove-azcontainergroup?view=azps-5.6.0
    New-AzAksCluster :          https://docs.microsoft.com/en-us/powershell/module/az.aks/new-azakscluster?view=azps-5.6.0
    Get-AzAksCluster:           https://docs.microsoft.com/en-us/powershell/module/az.aks/get-azakscluster?view=azps-5.6.0
    Remove-AzAksCluster:        https://docs.microsoft.com/en-us/powershell/module/az.aks/remove-azakscluster?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    ManageAzVM:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/ManageAzVM.ps1
        NewAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/NewAzVM.ps1
        GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1                    
        StartAzVM:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StartAzVM.ps1
        StopAzVM:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StopAzVM.ps1
        ReImageAzVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/ReimageAzVM.ps1
        RemoveAzVM:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/RemoveAzVM.ps1
        SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
        GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
        NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzVmss:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/ManageAzVmss.ps1
        SetAzVmssOsProfile:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssOsProfile.ps1
        SetAzVmssStorageProfile:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssStorageProfile.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
        GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
        GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
        NewAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLoadBalancer.ps1
        NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
        NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
        GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
        NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
        NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
        NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
        NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
        GetAzVmss:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmSS.ps1
        RemoveAzVmss:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/RemoveAzVmss.ps1
        GetAzVmssVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmssVM.ps1
        StartAzVmss:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/StartAzVmss.ps1
        StopAzVmss:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/StopAzVmss.ps1
    ManageAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/ManageAzContainerGroup.ps1
        NewAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/NewAzContainerGroup.ps1
        GetAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/GetAzContainerGroup.ps1
        RemoveAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/RemoveAzContainerGroup.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzAksCluster:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/ManageAzAksCluster.ps1
        GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/NewAzAksCluster.ps1 
        GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/GetAzAksCluster.ps1 
        RemoveAzAksCluster:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/RemoveAzAksCluster.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1 
} #>
<# Functions Description: {
    ManageAzCompute:            Management function for computer object
    ManageAzVM:                 Management function for VMs
        NewAzVM:                    Creates a new virtual machine
        GetAzVM:                    Gets an existing VM                    
        StartAzVM:                  Starts a selected VM
        StopAzVM:                   Stops a selected VM
        ReImageAzVM:                Reimages a selected VM
        RemoveAzVM:                 hRemoves a selected VM
        SetAzVMOS:                  Selects a market place image
        GetAzVMSize:                Gets a VM size
        NewAzNetworkInterface:      Creates a new network interface
        GetAzVNetSubnetConfig:      Gets a vnet subnet
        GetAzVirtualNetwork:        Gets a virtual network
        GetAzNetworkInterface:      Gets a network interface
        GetAzResourceGroup:         Gets a resource group
    ManageAzVmss:               Management function for Vmss(s)
        GetAzVMSize:                Function for setting the VM size
        NewAzVmss:                  Function for creating a new Vmss
        SetAzVmssOsProfile:         Function for setting Vmss username and password
        SetAzVmssStorageProfile:    Function for setting up Vmss storage for new instances
        GetAzVirtualNetwork:        Gets an existing virtual network
        AddAzVNetSubnetConfig:      Adds a new subnet
        GetAzVNetSubnetConfig:      Gets an existing subnet
        GetAzResourceGroup:         Gets an existing resource group
        SetAzVMOS:                  Gets an Azure OS image config
        GetAzVMSize:                Gets an Azure VM sku
        GetAzLoadBalancer:          Gets an existing load balancer
        NewAzLoadBalancer:          Creates a new load balancer
        NewAzLBFrontendIpConfig:    Creates a load balancer front end config 
        NewAzPublicIpAddress:       Creates a new public ip sku
        GetAzPublicIpAddress:       Gets an existing public ip sku
        NewAzLBBackendIpConfig:     Creates a load balancer back end IP config
        NewAzLBProbeConfig:         Creates a load balancer health probe
        NewAzLBIBNatPoolConfig:     Creates a load balancer inbound nat pool
        NewAzLBRuleConfig:          Creates a load balancer rule
        RemoveAzVmss:               Removes a Vmss
        GetAzVmss:                  Gets a Vmss
        GetAzVmssVM:                Gets a Vmss instance
        StartAzVmss:                Starts instances of a Vmss
        StopAzVmss:                 Stops instances of a Vmss
    ManageAzContainerGroup:     Management function for container groups
        NewAzContainerGroup:        Creates a container group
        GetAzContainerGroup:        Gets a container group
        RemoveAzContainerGroup:     Removes a container group
        GetAzResourceGroup:         Gets a resource group
    ManageAzAksCluster:         Management function for Aks clusters
        NewAzAksCluster:            Creates an Aks cluster
        GetAzAksCluster:            Gets an Aks cluster
        RemoveAzAksCluster:         Removes a selected Aks cluster
        GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :ManageAzCompute         Outer loop for managing function
    ManageAzVM{}                Manages $VMObject
        NewAzVM{}                   Creates $VMObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzVMSize{}               Gets $VMSizeObject
            NewAzNetworkInterface{}     Gets $NicObject
                GetAzVNetSubnetConfig{} Gets $SubnetObject
                    GetAzVirtualNetwork{}       Gets $VnetObject
            GetAzNetworkInterface{}     Gets $NicObject 
                GetAzVNetSubnetConfig{} Gets $SubnetObject
                    GetAzVirtualNetwork{}       Gets $VnetObject
            SetAzVMOS{}                 Gets $VMImageObject
        GetAzVM{}                   Gets $VMObject
        StartAzVM{}                 Starts $VMObject
            GetAzVM{}                   Gets $VMObject
        StopAzVM{}                  Stopss $VMObject
            GetAzVM{}                   Gets $VMObject
        ReimageAzVM{}               Reimages $VMObject
            GetAzVM{}                   Gets $VMObject
        RemoveAzVM{}                Removes $VMObject
            GetAzVM{}                   Gets $VMObject
    ManageAzVmss{}              Manages $VmssObject
        NewAzVmss{}                 Creates $VmssObject    
            GetAzResourceGroup{}        Gets $RGObject
            GetAzVMSize{}               Gets $VMSizeObject
            SetAzVmssOsProfile{}        Gets $VmssOSProfileObject
                SetAzVMOS{}                 Gets $VMImageObject
            SetAzVmssStorageProfile{}   Gets $VmssStorageProfileObject
            NewAzLoadBalancer{}         Creates $LoadBalancerObject
                GetAzResourceGroup{}        Gets $RGObject
                NewAzLBFrontendIpConfig{}   Creates $FrontEndIPConfigObject
                    NewAzPublicIpAddress{}      Creates $PublicIPObject
                        GetAzResourceGroup{}        Gets $RGObject
                    GetAzPublicIpAddress{}      Gets $PublicIPObject
                NewAzLBBackendIpConfig{}    Creates $BackEndIPConfigObject
                NewAzLBProbeConfig{}        Creates $HealthProbeObject
                NewAzLBIBNatPoolConfig{}    Creates $InboundNatPoolObject
                NewAzLBRuleConfig{}         Creates $LoadBalanceRule
            GetAzLoadBalancer{}         Gets $LoadBalancerObject
            AddAzVNetSubnetConfig{}     Creates $SubnetObject
                GetAzVirtualNetwork{}       Gets $VnetObject
            GetAzVNetSubnetConfig{}     Gets $SubnetObject
                GetAzVirtualNetwork{}       Gets $VnetObject
        GetAzVmssObject{}           Gets $VmssObject
        RemoveAzVmssObject{}        Removes $VmssObject
            GetAzVmssObject{}           Gets $VmssObject
        GetAzVmssVMObject{}         Gets $VmssVMObject
            GetAzVmmsObject{}           Gets $VmssObject
        StartAzVmss{}               Starts $VmssVMObject(s)
            GetAzVmssVMObject{}         Gets $VmssVMObject
                GetAzVmmsObject{}           Gets $VmssObject
            GetAzVmmsObject{}           Gets $VmssObject
        StopAzVmss{}                Stops $VmssVMObject(s)
            GetAzVmssVMObject{}         Gets $VmssVMObject
                GetAzVmmsObject{}           Gets $VmssObject
            GetAzVmmsObject{}           Gets $VmssObject
    ManageAzContainerGroup{}    Manages $ContainerObject
        NewAzContainerGroup{}       Creates $ContainerGroup
        GetAzContainerGroup{}       Gets $ContainerGroup
        RemoveAzContainerGroup{}    Removes $ContainerGroup
            GetAzContainerGroup{}       Gets $ContainerGroup
    ManageAzAksCluster{}        Manages $AksObject
        NewAzAksCluster{}           Creates $AksObject
            GetAzResourceGroup{}        Gets $RGObject
        GetAzAksCluster{}           Gets $AksObject
        RemoveAzAksCluster          Removes $AksObject
            GetAzAksCluster{}           Gets $AksObject
} #>
<# Process Flow {
    function
        Call ManageAzCompute > Get $null
            Call ManageAzVM > Get $null
                Call NewAzVMWin > Get $WinVMObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzVMWin > Send $RGObject
                    Call GetAzVMSize > Get $VMSizeObject
                    End GetAzVMSize
                        Return NewAzVMWin > Send $VMSizeObject
                    Call NewAzNetworkInterface > Get $NicObject
                        Call GetAzVNetSubnetConfig > Get $SubnetObject
                            Call GetAzVirtualNetwork > Get $Vnet
                            End GetAzVirtualNetwork
                                Return GetAzVNetSubnetConfig > Send $Vnet
                        End GetAzVNetSubnetConfig
                            Return NewAzNetworkInterface > Send $SubnetObject
                    End NewAzNetworkInterface
                        Return NewAzVMWin > Send $ NicObject
                    Call GetAzNetworkInterface > Get $NicObject
                        Call GetAzVNetSubnetConfig > Get $SubnetObject
                            Call GetAzVirtualNetwork > Get $Vnet
                            End GetAzVirtualNetwork
                                Return GetAzVNetSubnetConfig > Send $Vnet
                        End GetAzVNetSubnetConfig
                            Return NewAzNetworkInterface > Send $SubnetObject
                    End GetAzNetworkInterface
                        Return NewAzVMWin > Send $NicObject
                    Call GetAzVMSize > Get $VMImageObject
                    End GetAzVMSize
                        Return NewAzVMWin > Send $VMImageObject
                End NewAzVMWin
                    Return ManageAzVM > Send $VMObject
                Call GetAzVM > Get $VMObject
                End GetAzVM
                    Return ManageAzVM > Send $VMObject
                Call StartAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return StartAzVM > Send $VMObject
                End StartAzVM
                    Return ManageAzVM > Send $null
                Call StopAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return StopAzVM > Send $VMObject
                End StopAzVM
                    Return ManageAzVM > Send $null
                Call ReimageAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return ReimageAzVM > Send $VMObject
                End ReimageAzVM
                    Return ManageAzVM > Send $null
                Call RemoveAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return RemoveAzVM > Send $VMObject
                End RemoveAzVM
                    Return ManageAzVM > Send $null
            End ManageAzVM
                Return ManageAzCompute > Send $null
            Call ManageAzVmss > Get $null
                Call NewAzVmss > Get $VmssObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzVmss > Send $RGObject
                    Call GetAzVMSize > Get $VMSizeObject
                    End GetAzVMSize
                        Return NewAzVmss > Send $VMSizeObject
                    Call SetAzVmssOsProfile > Get $VmssOSProfileObject
                        Call SetAzVMOS > Get $VMImageObject
                        End SetAzVMOS
                    End SetAzVmssOsProfile
                        Return NewAzVmss > Send $VmssOSProfileObject
                    Call SetAzVmssStorageProfile > Get $VmssStorageProfileObject
                    End SetAzVmssStorageProfile
                        Return NewAzVmss > Send $VmssStorageProfileObject
                    Call NewAzLoadBalancer > Get $LoadBalancerObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return NewAzLoadBalancer > Send $RGObject
                        Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
                            Call NewAzPublicIpAddress > Get $PublicIPObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return NewAzPublicIpAddress > Send $RGObject
                            End NewAzPublicIpAddress
                                Return NewAzLBFrontendIpConfig > Send $PublicIPObject
                            Call GetAzPublicIpAddress > Get $PublicIPObject
                            End GetAzPublicIpAddress
                                Return NewAzLBFrontendIpConfig > Send $PublicIPObject
                        End NewAzLBFrontendIpConfig
                            Return NewAzLoadBalancer > Send $FrontEndIPConfigObject 
                        Call NewAzLBBackendIpConfig > Get $BackEndIPConfigObject
                        End NewAzLBBackendIpConfig
                            Return NewAzLoadBalancer > Send $BackEndIPConfigObject
                        Call NewAzLBProbeConfig > Get $HealthProbeObject
                        End NewAzLBProbeConfig
                            Return NewAzLoadBalancer > Send $HealthProbeObject
                        Call NewAzLBIBNatPoolConfig > Get $InboundNatPoolObject
                        End NewAzLBIBNatPoolConfig
                            Return NewAzLoadBalancer > Send $InboundNatPoolObject
                        Call NewAzLBRuleConfig > Get $LoadBalanceRule
                        End NewAzLBRuleConfig
                            Return NewAzLoadBalancer > Send $LoadBalanceRule
                    End NewAzLoadBalancer
                        Return NewAzVmss > Send $LoadBalancerObject
                    Call GetAzLoadBalancer > Get $LoadBalancerObject
                    End GetAzLoadBalancer
                        Return NewAzVmss > Send $LoadBalancerObject
                    Call AddAzVNetSubnetConfig > Get $SubnetObject
                        Call GetAzVirtualNetwork > Get $VnetObject
                        End GetAzVirtualNetwork
                            Return AddAzVNetSubnetConfig > Send $VnetObject
                    End AddAzVNetSubnetConfig
                        Return NewAzVmss > Send $SubnetObject
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                        Call GetAzVirtualNetwork > Get $VnetObject
                        End GetAzVirtualNetwork
                            Return GetAzVNetSubnetConfig > Send $VnetObject
                    End GetAzVNetSubnetConfig
                        Return NewAzVmss > Send $SubnetObject
                End NewAzVmss
                    Return ManageAzVmss > Send $VmssObject
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return ManageAzVmss > Send $VmssObject
                Call RemoveAzVmss > Get $null
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return RemoveAzVmss > Send $VmssObject
                End RemoveAzVmss
                    Return ManageAzVmss > Send $null
                Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return GetAzVmssVM > Send $VmssObject
                End GetAzVmssVM
                    Return ManageAzVmss > Send $VmssVMObject, $VmssObject
                Call StartAzVmss > Get $null
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return StartAzVmss > Send $VmssObject   
                    Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                        Call GetAzVmss > Get $VmssObject
                        End GetAzVmss
                            Return GetAzVmssVM > Send $VmssObject
                    End GetAzVmssVM
                        Return StartAzVmss > Send $VmssVMObject, $VmssObject
                End StartAzVmss
                    Return ManageAzVmss > Send $null
                Call StopAzVmss > Get $null
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return StopAzVmss > Send $VmssObject   
                    Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                        Call GetAzVmss > Get $VmssObject
                        End GetAzVmss
                            Return GetAzVmssVM > Send $VmssObject
                    End GetAzVmssVM
                        Return StopAzVmss > Send $VmssVMObject, $VmssObject
                End StopAzVmss
                    Return ManageAzVmss > Send $null
            End ManageAzVmss
                Return ManageAzCompute > Send $null
            Call ManageAzContainerGroup > Get $null
                Call NewAzContainerGroup > Get $ContainerObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup 
                    Return NewAzContainerGroup > Send $RGObject
                End NewAzContainerGroup
                    Return ManageAzContainerGroup > Send $ContainerObject
                Call GetAzContainerGroup > Get $ContainerObject
                End GetAzContainerGroup
                        Return ManageAzContainerGroup > Send $ContainerObject
                Call RemoveAzContainerGroup > Get $null
                    Call GetAzContainerGroup > Get $ContainerObject
                    End GetAzContainerGroup
                        Return RemoveAzContainerGroup > Send $ContainerObject
                End RemoveAzContainerGroup
                    Return ManageAzContainerGroup > Send $null
            End ManageAzContainerGroup
                Return ManageAzCompute > Send $null
            Call ManageAzAksCluster > Get $null
                Call NewAzAksCluster > Get $AksObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup 
                        Return NewAzAksCluster > Send $RGObject
                End NewAzAksCluster
                    Return ManageAzAksCluster > Send $AksObject
                Call GetAzAksCluster > Get $AksObject
                End GetAzAksCluster
                    Return ManageAzAksCluster > Send $AksObject
                Call RemoveAzAksCluster > Get $null
                    Call GetAzAksCluster > Get $AksObject
                    End GetAzAksCluster
                        Return RemoveAzAksCluster > Send $AksObject
                End RemoveAzAksCluster
                    Return ManageAzAksCluster > Send $null
            End ManageAzAksCluster
                Return ManageAzCompute > Send $null
        End ManageAzCompute
            Return Function > Send $null
}#>
function ManageAzCompute {                                                                  # Function to manage azure compute
    Begin {                                                                                 # Begin function
        :ManageAzureCompute while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Azure Compute Management'                                           # Write message to screen
            Write-Host '1 Manage VMs'                                                       # Write message to screen
            Write-Host '2 Manage Vmss'                                                      # Write message to screen
            Write-Host '3 Manage compute containers'                                        # Write message to screen
            Write-Host '4 Manage Kubernetes'                                                # Write message to screen
            Write-Host '5 Manage Disks (In Dev)'                                            # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $ManageAzCompute = Read-Host "Option?"                                          # Collects operator input on $ManageAzCompute option
            if ($ManageAzCompute -eq 'exit') {                                              # If $ManageAzCompute equals 'exit'
                Break ManageAzureCompute                                                    # Breaks :ManageAzureCompute
            }                                                                               # End if ($ManageAzCompute -eq 'exit')
            elseif ($ManageAzCompute -eq '1') {                                             # Elseif $ManageAzCompute equals 1
                Write-Host 'Manage VMs'                                                     # Write message to screen
                ManageAzVM ($RGObject, $RSObject)                                           # Calls function
            }                                                                               # End elseif ($ManageAzCompute -eq '1')
            elseif ($ManageAzCompute -eq '2') {                                             # Elseif $ManageAzCompute equals 2
                Write-Host 'Manage Vmss'                                                    # Write message to screen
                ManageAzVmss                                                                # Calls function
            }                                                                               # End elseif ($ManageAzCompute -eq '2')
            elseif ($ManageAzCompute -eq '3') {                                             # Elseif $ManageAzCompute equals 3
                Write-Host 'Manage compute containers'                                      # Write message to screen
                ManageAzContainerGroup                                                      # Calls function
            }                                                                               # End elseif ($ManageAzCompute -eq '3')
            elseif ($ManageAzCompute -eq '4') {                                             # Elseif $ManageAzCompute equals 4
                Write-Host "Manage Kubernetes"                                              # Write message to screen
            }                                                                               # End elseif ($ManageAzCompute -eq '4')
            elseif ($ManageAzCompute -eq '5') {                                             # Elseif $ManageAzCompute equals 5
                Write-Host "Manage Disks (In Dev)"                                          # Write message to screen
            }                                                                               # End elseif ($ManageAzCompute -eq '5')
            else {                                                                          # If $ManageAzCompute do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzCompute -eq 'exit'))
        }                                                                                   # End ManageAzCompute while ($true)
        Return                                                                              # Returns to calling function if no search option is used
    }                                                                                       # End begin
}                                                                                           # End function ManageAzCompute
# Functions for ManageAzVM
function ManageAzVM {                                                                       # Function to manage VMs
    Begin {                                                                                 # Begin function
        :ManageAzureVM while ($true) {                                                      # Outer loop for managing function
            if ($RGObject) {                                                                # If $var has a value
                Write-Host "Current RG: "$RGObject.ResourceGroupName                        # Write message to screen
            }                                                                               # End if ($RGObject) 
            if ($LocationObject) {                                                          # If $var has a value
                Write-Host "Current Loc: "$LocationObject.Location                          # Write message to screen
            }                                                                               # End if ($LocationObject)
            if ($VMObject) {                                                                # If $var has a value
                Write-Host "Current VM:  "$VMObject.Name                                    # Write message to screen
            }                                                                               # End if ($VMObject)
            Write-Host "Azure VM Management"                                                # Write message to screen
            Write-Host '0 Clear varibles'                                                   # Write message to screen
            Write-Host "1 Create New VM"                                                    # Write message to screen
            Write-Host "2 Get existing VM"                                                  # Write message to screen
            Write-Host "3 Start VM"                                                         # Write message to screen
            Write-Host "4 Stop VM"                                                          # Write message to screen
            Write-Host "5 Reimage VM"                                                       # Write message to screen
            Write-Host "6 Remove VM"                                                        # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzVM = Read-Host "Option?"                                               # Collects operator input on $ManageAzVM option
            if ($ManageAzVM -eq 'exit') {                                                   # Exit if statement for this function
                Break ManageAzureVM                                                         # Ends :ManageAzureVM loop, leading to return statement
            }                                                                               # End if ($ManageAzVM -eq 'exit')
            elseif ($ManageAzVM -eq '1') {                                                  # Elseif statement for option 1
                Write-Host "Create New VM"                                                  # Write message to screen
                $VMObject = NewAzVM ($RGObject)                                             # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVM -eq '1')
            elseif ($ManageAzVM -eq '2') {                                                  # Elseif statement for option 2
                Write-Host "Get existing VM"                                                # Write message to screen
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVM -eq '2')
            elseif ($ManageAzVM -eq '3') {                                                  # Elseif statement for option 3
                Write-Host "Start VM"                                                       # Write message to screen
                StartAzVM ($VMObject)                                                       # Calls function
            }                                                                               # End elseif ($ManageAzVM -eq '3')
            elseif ($ManageAzVM -eq '4') {                                                  # Elseif statement for option 4
                Write-Host "Stop VM"                                                        # Write message to screen
                StopAzVM ($VMObject)                                                        # Calls function
            }                                                                               # End elseif ($ManageAzVM -eq '4')
            elseif ($ManageAzVM -eq '5') {                                                  # Elseif statement for option 5
                Write-Host "Reimage VM"                                                     # Write message to screen
                ReimageAzVM ($VMObject)                                                     # Calls function
            }                                                                               # End elseif ($ManageAzVM -eq '5')
            elseif ($ManageAzVM -eq '6') {                                                  # Elseif statement for option 6
                Write-Host "Remove VM"                                                      # Write message to screen
                RemoveAzVM ($VMObject)                                                      # Calls function
            }                                                                               # End elseif ($ManageAzVM -eq '6')
            elseif ($ManageAzVM -eq '0') {                                                  # Elseif statement for option 0
                Write-Host 'Clearing "$vars"'                                               # Write message to screen
                $RGObject = $null                                                           # Clears $var
                $LocationObject = $null                                                     # Clears $var
                $VMObject = $null                                                           # Clears $var
            }                                                                               # End elseif ($ManageAzVM -eq '0')
        }                                                                                   # End ManageAzureVM while ($true)
        Return                                                                              # Returns to calling function if no search option is used
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVM
function NewAzVM {                                                                          # Creates a new virtual machine
    Begin {                                                                                 # Begin function
        :NewAzureVM while ($true) {                                                         # Outer loop for managing function
            :SetAzureVMType while ($true) {                                                 # Inner loop for setting the VM type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the VM type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVM                                                        # Breaks :NewAzVM
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVMType                                                    # Breaks :SetAzureVMType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzVM'                                                # Sets $Calling function to 'NewAzVM'
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$RGObject) 
            }                                                                               # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.location -eq `
                $RGObject.location}                                                         # Sets $Location object to match $RGObject.location
            :SetAzureVMName while ($true) {                                                 # Inner loop for setting the VM name
                $VMNameObject = Read-Host "New VM Name"                                     # Operator input for the VM name
                if ($VMNameObject -eq 'exit') {                                             # If $VMNameObject equals $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMNameObject -eq 'exit')
                Write-Host $VMNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the VM name? [Y] or [N]"               # Operator confirmation of the VM name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMName                                                    # Breaks :SetAzureVMName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {                                             # Inner loop for setting the VM username
                $VMUserNameObject = Read-Host "VM Local username"                           # Operator input of the local admin user name
                if ($VMUserNameObject -eq 'exit') {                                         # If $VMUsernameObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMUserNameObject -eq 'exit')
                Write-Host $VMUserNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the VM username? [Y] or [N]"           # Operator confirmation of the local admin user name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMUserName                                                # Breaks :SetAzureVMUserName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMUserName while ($true)
            :SetAzureVMPassword while ($true) {                                             # Inner loop for setting the password
                $VMPasswordObject = Read-Host "VM Local password"                           # Operator input for the password
                if ($VMPasswordObject -eq 'exit') {                                         # If $VMPasswordObject equals 'exit'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMPasswordObject -eq 'exit')
                Write-Host $VMPasswordObject                                                # Write message to screen
                $OperatorConfirm = Read-Host "Use as the VM password? [Y] or [N]"           # Operator confirmation of the password
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject `
                        -AsPlainText -Force                                                 # Hashes $VMPasswordObject
                    Break SetAzureVMPassword                                                # Breaks :SetAzureVMPassword
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential `
                ($VMUserNameObject, $VMPasswordObject)                                      # Builds credential object using $VMUsernameObject and $VMPasswordObject
            if (!$VMSizeObject) {                                                           # If $VMSizeObject is $null
                $VMSizeObject = GetAzVMSize ($LocationObject)                               # Calls function and assigns output to $var
                if (!$VMSizeObject) {                                                       # If $VMSizeObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$VMSizeObject)
            }                                                                               # End if (!$VMSizeObject)
            $VMBuildObject = New-AzVMConfig -VMName $VMNameObject -VMSize `
                $VMSizeObject.Name                                                          # Starts $VMBuildObject
            if ($ImageTypeObject -eq '1') {                                                 # If $ImageTypeObject equals '1'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Windows `
                    -ComputerName $VMNameObject -Credential $VMCredObject -ProvisionVMAgent `
                    -EnableAutoUpdate                                                       # Adds VM info to $VMBuildObject
            }                                                                               # End if ($ImageTypeObject -eq '1') 
            elseif ($ImageTypeObject -eq '2') {                                             # If $ImageTypeObject equals '2'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Linux `
                    -ComputerName $VMNameObject -Credential $VMCredObject                   # Adds VM info to $VMBuildObject
            }                                                                               # End elseif ($ImageTypeObject -eq '2')
            :SetAzureNetwork while ($true) {                                                # Inner loop for creating or selecting NIC
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Write-Host "1. New NIC"                                                 # Write message to screen
                    Write-Host "2. Existing NIC"                                            # Write message to screen
                    $OperatorSelect = Read-Host "[1] or [2]"                                # Operator input for getting the NIC
                    if ($OperatorSelect -eq 'exit') {                                       # If $OperatorSelect equals exit
                        Break NewAzureVM                                                    # Breaks :NewAzureVM
                    }                                                                       # End if ($OperatorSelect -eq 'exit')
                    if ($OperatorSelect -eq '1') {                                          # If $OperatorSelect equals 1
                        $NicObject = NewAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End if ($OperatorSelect -eq '1')
                    elseif ($OperatorSelect -eq '2') {                                      # If $OperatorSelect equals 2
                        $NicObject = GetAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2')
                    else {                                                                  # All other inputs
                        Write-Host "Invalid selection"                                      # Write message to screen
                    }                                                                       # End else(if ($OperatorSelect -eq '1'))
                }                                                                           # End if (!$NicObject)
                Break SetAzureNetwork                                                       # Breaks :SetAzureNetwork
            }                                                                               # End :SetAzureNetwork while ($true)
            $VMBuildObject = Add-AzVMNetworkInterface -VM $VMBuildObject -Id $NicObject.Id  # Adds NIC info to $VMBuildObject
            if (!$VMImageObject) {                                                          # If $VMImageObject is $null
                $VMImageObject = SetAzVMOS ($LocationObject, $ImageTypeObject)              # Calls function and assigns output to $var
                if (!$VMImageObject){                                                       # If $VMImageObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$VMImageObject)
            }                                                                               # End if (!$VMImageObject)
            if ($VMImageObject.Version) {                                                   # If $VMImageObject.Version has a value
                $VMBuildObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $VMImageObject.PublisherName -Offer $VMImageObject.Offer -Skus `
                $VMImageObject.Skus -Version $VMImageObject.Version                         # Adds image setting to $VMBuildObject
            }                                                                               # End if ($VMImageObject.Version)
            else {                                                                          # If $VMImageObject.Version does not have a value
                $VMBuildObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $VMImageObject.PublisherName -Offer $VMImageObject.Offer -Skus `
                $VMImageObject.Skus -Version 'latest'                                       # Adds image setting to $VMBuildObject
            }                                                                               # End else (if ($VMImageObject.Version))
            Try {                                                                           # Try the following
            $VMObject = New-AzVM -ResourceGroupName $RGObject.ResourceGroupName `
                -Location $LocationObject.DisplayName -VM $VMBuildObject -Verbose           # Builds the new VM object
            }                                                                               # End Try
            Catch {                                                                         # If catch fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not created'
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End catch
            $VMObject = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName `
                -Name $VMNameObject                                                         # Pulls the VM Object prior to returning to calling function
            Return $VMObject                                                                # Returns to calling function with $VMObject
        }                                                                                   # End :NewAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVM                                                                                   # End function GetAzVMSize 
function GetAzVM {                                                                          # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' =  $_.ResourceGroupName; 'Status' = $_.PowerState                  # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VMList)
            Write-Host "Exit:    0"                                                         # Write message to screen
            Write-Host ""                                                                   # Write message to screen 
            foreach ($_ in $VMArray) {                                                      # Writes all VMs to screen
                Write-Host "Number: "$_.Number                                              # Write message to screen 
                Write-Host "Name:   "$_.Name                                                # Write message to screen 
                Write-Host "RG:     "$_.RG                                                  # Write message to screen
                Write-Host "Status: "$_.Status                                              # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            :GetAzureVMName while ($true) {                                                 # Inner loop for selecting VM from list
                $VMSelect = Read-Host "Please enter the number of the VM"                   # Operator input for the selection
                if ($VMSelect -eq '0') {                                                    # If $VMSelect is 0
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                $VMListSelect = $VMArray | Where-Object {$_.Number -eq $VMSelect}           # Isolates selected VM 
                if ($VMListSelect) {                                                        # If $VMListSelect has a valud
                    $VMObject = Get-AzVM -ResourceGroupName $VMListSelect.RG `
                        -Name $VMListSelect.Name                                            # Pulls full $VMObject
                    if ($VMObject) {                                                        # If $VMObject has a value
                        Return $VMObject                                                    # Returns to calling function with $VMObject
                    }                                                                       # End if ($VMObject)
                    else {                                                                  # If $VMObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVM                                                    # Breaks :GetAzureVM
                    }                                                                       # End else (if ($VMObject))
                }                                                                           # End if ($VMListSelect)
                Write-Host "That was not a valid selection"                                 # Write message to screen 
            }                                                                               # End :GetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzureVMName
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Power on "$VMObject.Name "[Y] or [N]"             # Operator confirmation to turn on the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to power on" $VMObject.Name                              # Write message to screen
            Start-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName      # Starts the selected VM
            Break StartAzureVM                                                              # Breaks :StartAzureVM
        }                                                                                   # End :StartAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Shutdown"$VMObject.Name "[Y] or [N]"              # Operator input to shutdown the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to shut off" $VMObject.Name                              # Write message to screen
            Stop-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force                                                                      # Stops the selected VM
            Break StopAzureVM                                                               # Breaks :StopAzureVM
        }                                                                                   # End :StopAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM
function ReimageAzVM {                                                                      # Function to remove a VM
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables powershell error reporting
        :ReimageAzVM while ($true) {                                                        # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break ReimageAzVM                                                       # Breaks :ReimageAzVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Reimage"$VMObject.Name "[Y] or [N]"               # Operator confirmation to reimage the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to reimage" $VMObject.Name                               # Write message to screen
            try {                                                                           # Try the following
                Invoke-AzVMReimage -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'stop'                         # Reimages the selected VM
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host ""                                                               # Write message to screen
                Write-Host "***An Error Has Occured***"                                     # Write message to screen
                Write-Host "Un-able to reimage the selected VM"                             # Write message to screen
                Write-Host "Auto OS upgrades may not be enabled"                            # Write message to screen
                Write-Host "You may not have permission to this VM"                         # Write message to screen
                Write-Host "The VM or group may be locked"                                  # Write message to screen
                Write-Host ""                                                               # Write message to screen
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End Catch
            Break ReimageAzVM                                                               # Breaks :ReimageAzVM
        }                                                                                   # End :ReimageAzVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ReimageAzVM
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables powershell reporting
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Remove"$VMObject.Name "[Y] or [N]"                # Operator confirmation to remove the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to remove" $VMObject.Name                                # Write message to screen
            Try {                                                                           # Try the following
            Remove-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force -ErrorAction 'Stop'                                                  # Removes the selected VM
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not removed'                                         # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host ''                                                               # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End catch
            Break RemoveAzureVM                                                             # Breaks :RemoveAzureVM
        }                                                                                   # End :RemoveAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM
# Functions for ManageAzVmss
function ManageAzVmss {                                                                     # Function to manage Vmss
    Begin {                                                                                 # Begin function
        :ManageAzureVmss while ($true) {                                                    # Outer loop for managing function
            if ($VmssObject) {                                                              # If $VmssObject has a value
                Write-Host "Currently selected Vmss is:" $VmssObject.Name                   # Write message to screen
            }                                                                               # End if ($VmssObject) 
            if ($VmssVMObject) {                                                            # If $VmssVMObject has a value
                Write-Host "Currently selected Vmss instance is :" $VmssVMObject.InstanceID # Write message to screen 
            }                                                                               # End if ($VmssVMObject) 
            Write-Host '[0] Clear current Vmss'                                             # Write message to screen
            Write-Host '[1] New Vmss'                                                       # Write message to screen
            Write-Host '[2] Get Vmss'                                                       # Write message to screen
            Write-Host '[3] Remove Vmss'                                                    # Write message to screen
            Write-Host '[4] Get Vmss Instance'                                              # Write message to screen
            Write-Host '[5] Start Vmss Instance'                                            # Write message to screen
            Write-Host '[6] Stop Vmss Instance'                                             # Write message to screen
            Write-Host '[Exit] Exit function'                                               # Write message to screen
            $OperatorSelect = Read-Host 'Option number'                                     # Operator input for function selection
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals 0
                if ($VmssObject -or $VmssVMObject) {                                        # If $VmssObject or $VmssVMObject has a value
                    if ($VmssObject) {                                                      # If $VmssObject has a value
                        Clear-Variable $VmssObject                                          # Clears $VmssObject
                        Write-Host '$VmssObject has been cleared'                           # Write message to screen
                    }                                                                       # End if ($VmssObject)
                    if ($VmssVMObject) {                                                    # If $VmssVMObject has a value
                        Clear-Variable $VmssVMObject                                        # Clears $VmssVMObject
                        Write-Host '$VmssVMObject has been cleared'                         # Write message to screen
                    }                                                                       # End if ($VmssVMObject)
                }                                                                           # End if ($VmssObject -or $VmssVMObject)
                else {                                                                      # If $VmssObject does not have a value
                    Write-Host 'Nothing to clear'                                           # Write message to screen
                }                                                                           # End else (if ($VmssObject))
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals 1
                Write-Host "New Vmss"                                                       # Write message to screen
                $VmssObject = NewAzVmss                                                     # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals 1
                Write-Host "Get Vmss"                                                       # Write message to screen
                $VmssObject = GetAzVmss                                                     # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            elseif ($OperatorSelect -eq '3') {                                              # Else if $OperatorSelect equals 3
                Write-Host "Remove Vmss"                                                    # Write message to screen
                RemoveAzVmss ($VmssObject)                                                  # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '3')
            elseif ($OperatorSelect -eq '4') {                                              # Else if $OperatorSelect equals 4
                Write-Host "Get Vmss Instance"                                              # Write message to screen
                GetAzVmssVM ($VmssObject)                                                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '4')
            elseif ($OperatorSelect -eq '5') {                                              # Else if $OperatorSelect equals 5
                Write-Host "Start Vmss Instance"                                            # Write message to screen
                StartAzVmss ($VmssObject)                                                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '5')
            elseif ($OperatorSelect -eq '6') {                                              # Else if $OperatorSelect equals 6
                Write-Host "Stop Vmss Instance"                                             # Write message to screen
                StopAzVmss ($VmssObject)                                                    # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '6')
            elseif ($OperatorSelect -eq 'exit') {                                           # Else if $OperatorSelect equals 'exit'
                Write-Host 'Leaving manage Vmss'                                            # Write message to screen
                Break ManageAzureVmss                                                       # Breaks :ManageAzureVmss
            }                                                                               # End elseif ($OperatorSelect -eq 'exit')
            else {                                                                          # All other inputs for $OperatorSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :ManageAzureVmss while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVmss
function NewAzVmss {                                                                        # Function to create a new virtual machine scale set
    Begin{                                                                                  # Begin function
        :NewAzureVmss while ($true) {                                                       # Outer loop for managing function
            :SetAzureVmssType while ($true) {                                               # Inner loop for setting the Vmss type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the VM type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVmss                                                      # Breaks :NewAzVmss
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVmssType                                                  # Breaks :SetAzureVmssType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            :GetAzureResourceGroup while ($true) {                                          # Inner loop for getting the resource group and location
                if (!$RGObject) {                                                           # If $RGObject is $null
                    $CallingFunction = 'NewAzVmss'                                          # $var used to list the calling function name in GetAzResourceGroup
                    $RGObject = GetAzResourceGroup ($CallingFunction)                       # Calls function and assigns output to $var
                    if (!$RGObject) {                                                       # If $RGObject is $null 
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End if (!$RGObject)
                $LocationObject = Get-AzLocation | Where-Object `
                    {$_.Location -eq $RGObject.Location}                                    # Creates $LocationObject
                if ($LocationObject) {                                                      # If $LocationObject has a value
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End ($LocationObject)
                else {                                                                      # If $LocationObject does not have a value
                    Write-Host "An error has occured"                                       # Write message to screen
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End else (if ($LocationObject))
            }                                                                               # End :GetAzureResourceGroup while ($true)    
            :SetAzureVmssSkuCapacity while ($true) {                                        # Inner loop for setting the max skus (VMs)
                Try {                                                                       # Try the following
                    [int]$VmssSkuCapacityObject = Read-Host "Enter the max number of VMs"   # Operator input for the max skus
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($VmssSkuCapacityObject -le 0) {                                         # If $VmssSkuCapacityObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($VmssSkuCapacityObject -le 0) 
                elseif ($VmssSkuCapacityObject -ge 1) {                                     # If $VmssSkuCapacityObject is greater than or equal to `
                    $OperatorConfirm = Read-Host `
                    "Confirm max"$VmssSkuCapacityObject" VMs [Y] or [N]"                    # Operator confirmation of the max skus
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVmssSkuCapacity                                       # Breaks :SetAzureVmssSkuCapacity        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($VmssSkuCapacityObject -ge 1)
            }                                                                               # End :SetAzureVmssSkuCapacity while ($true)
            :SetAzureVmssSkuConfig while ($true) {                                          # Inner loop for setting vmss profile configuration
                $VMSizeObject = GetAzVMSize ($LocationObject)                               # Calls function and assigns output to $var
                if (!$VMSizeObject) {                                                       # If $VMSizeObject has no value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VMSizeObject)
                :SetAzureVMSSSkuUpDate while ($true) {                                      # Inner loop for setting the OS update settings
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Automatic'                                              # Write message to screen
                    Write-Host '[2] Manual'                                                 # Write message to screen
                    $UpdateSetting = Read-Host '[0], [1], or [2]'                           # Operator input for the update setting
                    if ($UpdateSetting -eq '0') {                                           # If $Update setting equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($UpdateSetting -eq '0')
                    elseif ($UpdateSetting -eq '1') {                                       # If $Update setting equals '1'
                        $UpdateSetting = 'Automatic'                                        # Sets $UpdateSetting to 'Automatic' 
                        Break SetAzureVMSSSkuUpDate                                         # Breaks :SetAzureVMSSSkuUpDate
                    }                                                                       # End elseif ($UpdateSetting -eq '1')
                    elseif ($UpdateSetting -eq '2') {                                       # If $Update setting equals '2'
                        $UpdateSetting = 'Manual'                                           # Sets $UpdateSetting to 'Manual' 
                        Break SetAzureVMSSSkuUpDate                                         # Breaks :SetAzureVMSSSkuUpDate
                    }                                                                       # End elseif ($UpdateSetting -eq '2')
                    else {                                                                  # If $UpdateSetting not equal to 0, 1, or 2
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($UpdateSetting -eq '0'))
                }                                                                           # End :SetAzureVMSSSkuUpDate while ($true)
                $VmssConfigObject = New-AzVmssConfig -Location $LocationObject.Location `
                    -SkuCapacity $VmssSkuCapacityObject -SkuName $VMSizeObject.Name `
                    -UpgradePolicyMode $UpdateSetting                                       # Starts the Vmss config, loads location, VM settings, count, and update settings
                $VmssOSProfileObject = SetAzVmssOsProfile `
                    ($VmssConfigObject, $ImageTypeObject)                                   # Calls function and assigns output to $var
                if (!$VmssOSProfileObject) {                                                # If $VmssOSProfileObject does not have a value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VmssOSProfileObject)
                $VmssStorageProfileObject = SetAzVmssStorageProfile ($VmssConfigObject)     # Calls function and assigns output to $var
                if (!$VmssStorageProfileObject) {                                           # If $VmssStorageProfileObject does not have a value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VmssStorageProfileObject)
                Break SetAzureVmssSkuConfig                                                 # Breaks :SetAzureVmssSkuConfig
            }                                                                               # End :SetAzureVmssSkuConfig while ($true)
            :SetVmssIPConfig while ($true) {                                                # Inner loop for setting the network settings
                :SetVmssIPConfigName while ($true) {                                        # Inner loop for setting the IP config name
                    $VmssIPConfigName = Read-Host "Name of IP config"                       # Operator input for the IP config name
                    if ($VmssIPConfigName -eq 'exit') {                                     # If $VmssIPConfigName equals exit
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($VmssIPConfigName -eq 'exit')
                    $OperatorConfirm = Read-Host "Use" $VmssIPConfigName `
                    "as the IP config name"                                                 # Operator confirmation of the IP config name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetVmssIPConfigName                                           # Breaks :SetVmssIPConfigName
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
                }                                                                           # End :SetVmssIPConfigName while ($true)
                :GetAzureLoadBalancer while ($true) {                                       # Inner loop to get or create a load balancer
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New load balancer'                                      # Write message to screen
                    Write-Host '[2] Get load balancer'                                      # Write message to screen
                    $OperatorSelect = Read-Host '[0], [1], or [2]'                          # Operator input for getting or creating a load balancer
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -eq '1') {                                      # elseif $OperatorSelect equals '1'
                        $LoadBalancerObject = NewAzLoadBalancer                             # Calls function and assigns output to $var
                        if ($LoadBalancerObject) {                                          # If $LoadBalancerObject has a value
                            Break GetAzureLoadBalancer                                      # Breaks :GetAzureLoadBalancer
                        }                                                                   # End if ($LoadBalancerObject)
                        else {                                                              # If $LoadBalancerObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($LoadBalancerObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '1') 
                    elseif ($OperatorSelect -eq '2') {                                      # elseif $OperatorSelect equals '2'
                        $LoadBalancerObject = GetAzLoadBalancer                             # Calls function and assigns output to $var
                        if ($LoadBalancerObject) {                                          # If $LoadBalancerObject has a value
                            Break GetAzureLoadBalancer                                      # Breaks :GetAzureLoadBalancer
                        }                                                                   # End if ($LoadBalancerObject)
                        else {                                                              # If $LoadBalancerObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($LoadBalancerObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2') 
                }                                                                           # End :GetAzureLoadBalancer while ($true)
                :GetAzureSubnet while ($true) {                                             # Inner loop for setting the subnet
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New subnet'                                             # Write message to screen
                    Write-Host '[2] Get subnet'                                             # Write message to screen
                    $OperatorSelect = Read-Host '[0], [1], or [2]'                          # Operator input for getting or creating a subnet
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -eq '1') {                                      # elseif $OperatorSelect equals '1'
                        $SubnetObject = AddAzVNetSubnetConfig                               # Calls function and assigns output to $var
                        if ($SubnetObject) {                                                # If $SubnetObject has a value
                            Break GetAzureSubnet                                            # Breaks :GetAzureSubnet
                        }                                                                   # End if ($SubnetObject)
                        else {                                                              # If $SubnetObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($SubnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '1') 
                    elseif ($OperatorSelect -eq '2') {                                      # elseif $OperatorSelect equals '2'
                        $SubnetObject = GetAzVNetSubnetConfig                               # Calls function and assigns output to $var
                        if ($SubnetObject) {                                                # If $SubnetObject has a value
                            Break GetAzureSubnet                                            # Breaks :GetAzureSubnet
                        }                                                                   # End if ($SubnetObject)
                        else {                                                              # If $SubnetObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($SubnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2')                 
                }                                                                           # End :GetAzureSubnet while ($true)
                $VmssIPConfig = New-AzVmssIPConfig -Name $VmssIPConfigName `
                    -LoadBalancerInboundNatPoolsId `
                    $LoadBalancerObject.InboundNatPools[0].Id `
                    -LoadBalancerBackendAddressPoolsId `
                    $LoadBalancerObject.BackendAddressPools[0].Id `
                    -SubnetId $SubnetObject.id                                              # Creates the Vmss IP config
                if ($VmssIPConfig) {                                                        # If $VmssIPConfig has a value
                    $VmssConfigObject = Add-AzVmssNetworkInterfaceConfiguration -Name `
                        $VmssIPConfigName -Primary $true -IpConfiguration $VmssIPConfig `
                        -VirtualMachineScaleSet $VmssConfigObject                           # Adds the Vmss IP config to the Vmss config
                    Break SetVmssIPConfig                                                   # Breaks :SetVmssIPConfig
                }                                                                           # # End if ($VmssIPConfig)
                else {                                                                      # If $VmssIPConfig does not have a value
                    Write-Host "An error has occured"                                       # Write message to screen
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End else (if ($VmssIPConfig))
            }                                                                               # End :SetVmssIPConfig while ($true)
            :SetVmssName while ($true) {                                                    # Inner loop for setting the Vmss object name
                $VmssNameObject = Read-Host 'Enter the name of the new Vmss object'         # Operator input for the Vmss name
                if ($VmssNameObject -eq 'exit') {                                           # If $VmssNameObject equals 'exit'
                    Break NewAzVmss                                                         # Breaks :NewAzVmss
                }                                                                           # End if ($VmssNameObject -eq 'exit')
                if ($VmssNameObject) {                                                      # If $VmssNameObject has a value
                    Break SetVmssName                                                       # Breaks :SetVmssName
                }                                                                           # End if ($VmssNameObject)
                else {                                                                      # If $VmssNameObject does not have a value
                    Write-Host "No input detected"                                          # Write message to screen
                }                                                                           # End else (if ($VmssNameObject))
            }                                                                               # End :SetVmssName while ($true)
            $VmssObject = New-AzVmss -ResourceGroupName $RGObject.ResourceGroupName -Name `
                $VmssNameObject -VirtualMachineScaleSet $VmssConfigObject                   # Creates the Vmss object
            if ($VmssObject) {                                                              # If $VmssObject has a value 
                Return $VmssObject                                                          # Returns $VmssObject to calling function
            }                                                                               # End if ($VmssObject)
            else {                                                                          # If $VmssObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
            }                                                                               # End else (if ($VmssObject))
        }                                                                                   # End :NewAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with #null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVmss
function SetAzVmssOsProfile {                                                               # Function to set VMss OS profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssOSProfile while ($true) {                                              # Outer loop to manage function
            :SetAzureVmssOSProPrefix while ($true) {                                        # Inner loop for setting the VMss OS name prefix
                $VmssNamePrefixObject = Read-Host `
                "Please enter the Vmss computer name prefix [1-9] characters"               # Operator input for the VM name prefix
                if ($VmssNamePrefixObject -eq 'exit') {                                     # If $VmssNamePrefixObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssNamePrefixObject -eq 'exit')
                elseif ($VmssNamePrefixObject.Length -gt 9) {                               # If $VmssNamePrefixObject is greater than 15 characters
                    Write-Host `
                    "The input is to long, prefix is limited to 9 or less characters"       # Write message to screen
                    $VmssNamePrefixObject = $null                                           # Clears $var
                }                                                                           # End elseif ($VmssNamePrefixObject.Length -gt 15)
                else {                                                                      # All other input
                    Write-Host $VmssNamePrefixObject                                        # Write message to screen
                    $OperatorConfirm = Read-Host "Use this prefix [Y] or [N]"               # Operator confirmation of the name prefix
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssOSProPrefix                                       # Breaks :SetAzureVmssOSProPrefix 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssNamePrefixObject = $null                                       # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssNamePrefixObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssOSProPrefix while ($true)
            :SetAzureVmssProUserName while ($true) {                                        # Inner loop for setting the admin username
                $VmssAdminUserNameObject = Read-Host "Enter the user name"                  # Operator input for the admin username
                if ($VmssAdminUserNameObject -eq 'exit') {                                  # If $VmssAdminUserNameObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminUserNameObject -eq 'exit')
                elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject `
                    -eq '1') {                                                              # If $VmssAdminUserNameObject characters are greater than 20 and $ImageTypeObject equals '1'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 20 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject -eq '1')
                elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject `
                    -eq '2') {                                                              # If $VmssAdminUserNameObject characters are greater than 64 and $ImageTypeObject equals '2'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 64 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject -eq '2')
                else {                                                                      # All other inputs   
                    Write-Host $VmssAdminUserNameObject                                     # Write message to screen
                    $OperatorConfirm = Read-Host "Use this admin name [Y] or [N]"           # Operator confirmation of the admin username
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProUserName                                       # Breaks :SetAzureVmssProUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminUserNameObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminUserNameObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProUserName while ($true)
            :SetAzureVmssProPassword while ($true) {                                        # Inner loop for setting the admin password
                $VmssAdminPasswordObject = Read-Host "Enter the password"                   # Operator input for the admin password
                if ($VmssAdminPasswordObject -eq 'exit') {                                  # If $VmssAdminPasswordObject equals exit
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminPasswordObject -eq 'exit')
                else {                                                                      # All other inputs
                    Write-Host $VmssAdminPasswordObject                                     # Write message to screen   
                    $OperatorConfirm = Read-Host "Use this admin password [Y] or [N]"       # Operator confirmation of the admin password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProPassword                                       # Breaks :SetAzureVmssProPassword 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminPasswordObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminPasswordObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProPassword while ($true)
            $VmssOSProfileObject = Set-AzVmssOsProfile -VirtualMachineScaleSet `
            $VmssConfigObject -ComputerNamePrefix $VmssNamePrefixObject -AdminUsername `
            $VmssAdminUserNameObject -AdminPassword $VmssAdminPasswordObject                # Creates the VM scale set os profile
            if (!$VmssOSProfileObject) {                                                    # If $VmssOSProfileObject is $null
                Write-Host "An error has occured"
                Break SetAzureVmssOSProfile                                                 # Breaks :SetAzureVmssOSProfile
            }                                                                               # End if (!$VmssOSProfileObject)
            else {                                                                          # If $VmssOSProfileObject is not $null
                Return $VmssOSProfileObject                                                 # Returns to calling function with $VmssOSProfileObject
            }                                                                               # End else ((!$VmssOSProfileObject))
        }                                                                                   # End :SetAzureVmssOSProfile while ($true)     
        Return                                                                              # Returns to calling function with $null                                    
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVmssOsProfile 
function SetAzVmssStorageProfile {                                                          # Function to create a VM scale set operating system image and storage profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssStorageProfile while ($true) {                                         # Outer loop for managing function
            $VMImageObject = SetAzVMOS                                                      # Calls function and assigns output for $var
            if ($ImageTypeObject -eq '1') {                                                 # If $ImageTypeObject equals '1'
                $OSDiskType = 'Windows'                                                     # Sets $OSDiskType to 'Windows'
            }                                                                               # End if ($ImageTypeObject -eq '1')
            if ($ImageTypeObject -eq '2') {                                                 # If $ImageTypeObject equals '2'
                $OSDiskType = 'Linux'                                                       # Sets $OSDiskType to 'Linux'
            }                                                                               # End if ($ImageTypeObject -eq '2')
            if (!$VMImageObject) {                                                          # If $var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile 
            }                                                                               # End if (!$VMImageObject)
            :SetAzureDiskSku while ($true) {                                                # Inner loop for configuring the new disk sku
                [System.Collections.ArrayList]$ValidSku = @()                               # Creates the valid sku array
                $ValidSkuList = @('Standard_LRS','Premium_LRS','StandardSSD_LRS',`
                    'UltraSSD_LRS')                                                         # Creates a list of items to load into $ValidSku Array
                $SkuNumber = 1                                                              # Sets the base number for the valid sku array
                foreach ($_ in $ValidSkuList) {                                             # For each item in $ValidSkuList
                    $SkuInput = [PSCustomObject]@{'Name' = $_;'Number' = $SkuNumber}        # Creates the item to loaded into array
                    $ValidSku.Add($SkuInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $SkuNumber = $SkuNumber + 1                                             # Increments $SkuNumber up 1
                }                                                                           # End foreach ($_ in $ValidSkuList)
                foreach ($_ in $ValidSku) {                                                 # For each item in $ValidSkut
                    Write-Host $_.Number $_.Name                                            # Write message to screen
                }                                                                           # End foreach ($_ in $ValidSku)
                :SelectAzureDiskSku while ($true) {                                         # Inner loop for selecting object from list
                    $SkuObjectSelect = Read-Host "Please enter the number of the sku"       # Operator input for the selection
                    if ($SkuObjectSelect -eq '0') {                                         # If $$SkuObjectSelect is 0
                        Break SetAzureVmssStorageProfile                                    # Breaks :SetAzureVmssStorageProfile
                    }                                                                       # End if ($_Select -eq '0')
                    $SkuObject = $ValidSku | Where-Object {$_.Number -eq $SkuObjectSelect}  # Isolates selected object 
                    $SkuObject = $SkuObject.Name                                            # Pulls just the .name value
                    if ($SkuObject) {                                                       # If $SkuObject has a value
                        Break SetAzureDiskSku                                               # Breaks :SetAzureDiskSku
                    }                                                                       # End if ($SetAzureDiskSku)
                    Write-Host "That was not a valid selection"                             # Write message to screen 
                }                                                                           # End :SelectAzureDiskSku while ($true)
            }                                                                               # End :SetAzureDiskSku while ($true)
            if ($VMImageObject.Version) {                                                   # If $VMImageObject.Version has a value
                $VmssStorageProfileObject = Set-AzVmssStorageProfile `
                    -VirtualMachineScaleSet $VmssConfigObject  -OsDiskCreateOption `
                    "FromImage" -ImageReferencePublisher $VMImageObject.PublisherName `
                    -ImageReferenceOffer $VMImageObject.Offer -ImageReferenceSku `
                    $VMImageObject.Skus -ImageReferenceVersion $VMImageObject.Version `
                    -ManagedDisk $SkuObject -OsDiskOsType $OSDiskType                       # Creates the OS storage profile
            }                                                                               # # End if ($VMImageObject.Version)
            else {                                                                          # If $VMImageObject.Version does not have a value
                $VmssStorageProfileObject = Set-AzVmssStorageProfile `
                -VirtualMachineScaleSet $VmssConfigObject  -OsDiskCreateOption `
                "FromImage" -ImageReferencePublisher $VMImageObject.PublisherName `
                -ImageReferenceOffer $VMImageObject.Offer -ImageReferenceSku `
                $VMImageObject.Skus -ImageReferenceVersion 'latest' `
                -ManagedDisk $SkuObject -OsDiskOsType $OSDiskType                           # Creates the OS storage profile
            }                                                                               # End else (if ($VMImageObject.Version))
            if (!$VmssStorageProfileObject) {                                               # If $Var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile
            }                                                                               # End if (!$VmssStorageProfileObject)
            else {                                                                          # If $var has a value
                Return $VmssStorageProfileObject                                            # Returns to calling function
            }                                                                               # End else (if (!$VmssStorageProfileObject))
        }                                                                                   # End :SetAzureVmssStorageProfile while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVmssStorageProfile
function GetAzVmss {                                                                        # Function to get a Vmss
    Begin {                                                                                 # Begin function
        :GetAzureVmss while ($true) {                                                       # Outer loop for managing function
            $VmssList = Get-AzVmss                                                          # Gets a list of all Vmss's
            if (!$VmssList) {                                                               # If $VmssList is $null
                Write-Host '***No Vmss(s) exist***'                                         # Write message to screen
                Write-Host '***Returning to previous menu***'                               # Write message to screen
                Break GetAzureVmss                                                          # Breaks :GetAzureVmss
            }                                                                               # End if (!$VmssList)
            $VmssListNumber = 1                                                             # Creates the array selection number
            [System.Collections.ArrayList]$VmssArray = @()                                  # Creates the array used for selection
            foreach ($_ in $VmssList) {                                                     # For each item in $VmssList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $VmssListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName; 'Loc' = $_.Location; 'Sku' = $_.Sku.Name; `
                        'Cap' = $_.Sku.Capacity                                             # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $VmssArray.Add($ArrayInput) | Out-Null                                      # Adds the array input to array
                $VmssListNumber = $VmssListNumber + 1                                       # Increments $VmssListNumber by 1
            }                                                                               # End foreach ($_ in $VmssList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Foreach ($_ in $VmssArray) {
                Write-Host "["$_.Number']'                                                  # Write message to screen
                Write-Host 'Name: '$_.Name                                                  # Write message to screen
                Write-Host 'RG:   '$_.RG                                                    # Write message to screen
                Write-Host 'Loc:  '$_.Loc                                                   # Write message to screen
                Write-Host 'Sku:  '$_.Sku                                                   # Write message to screen
                Write-Host 'Cap:  '$_.Cap                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End Foreach ($_ in $VmssArray)
            :SelectAzureVmss while ($true) {                                                # Inner loop for selecting the Vmss
                $VmssSelect = Read-Host 'Vmss selection number'                             # Operator input for the vmss selection
                if ($VmssSelect -eq '0') {                                                  # If $VmssSelect equals 0
                    Break GetAzureVmss                                                      # Breaks :GetAzureVMSS
                }                                                                           # End if ($VmssSelect -eq '0')
                elseif ($VmssSelect -in $VmssArray.Number) {                                # If $VmssSelect is in $VmssArray.Number
                    $VmssSelect = $VmssArray | Where-Object {$_.Number -eq $VmssSelect}     # $VmssSelect is equal to the array item where $VmssSelect equals the array number
                    $VmssObject = Get-AzVmss -ResourceGroupName `
                        $VmssSelect.ResourceGroupName -VMScaleSetName $VmssSelect.name      # Pulls the full VmssObject
                    if ($VmssObject) {                                                      # If the vmss object is pulled
                        Return $VmssObject                                                  # Return to calling function with $VmssObject
                    }                                                                       # End if ($VmssObject)
                    else {                                                                  # If the vmss object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmss                                                  # Breaks :GetAzureVmss
                    }                                                                       # End else (if ($VmssObject))
                }                                                                           # End elseif ($VmssSelect -in $VmssArray.Number)
                else {                                                                      # If $VmssSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($VmssSelect -eq '0') )
            }                                                                               # End :SelectAzureVmss while ($true)
        }                                                                                   # End :GetAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmss
function RemoveAzVmss {
    Begin {
        :RemoveAzureVmss while ($true) {                                                    # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $VmssObject is $null
                $VmssObject = GetAzVmSS                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $VmssObject is $null
                    Break RemoveAzureVmss                                                   # Breaks :RemoveAzureVmss
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            Write-Host 'Remove' $VmssObject.name                                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for deletion
            if (!($OperatorConfirm -eq 'y')) {                                              # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            else {
                Try {                                                                       # Try the following
                    Remove-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                        -VMScaleSetName $VmssObject.name -Force                             # Removes the VMSS
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the required permissions'                  # Write message to screen
                }                                                                           # End catch
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End else (if (!($OperatorConfirm -eq 'y')))
        }                                                                                   # End :RemoveAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVmss
function GetAzVmssVM {                                                                      # Function for getting a vmss instance
    Begin {                                                                                 # Begin function
        :GetAzureVmssVM while ($true) {                                                     # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $var is $null
                $VmssObject = GetAzVmss                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $var is $null
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            $VmssVMList = Get-AzVmssVM -ResourceGroupName $VmssObject.ResourceGroupName `
                -VMScaleSetName $VmssObject.name                                            # Collects all instances and assigns to $var
            $ListNumber = 1                                                                 # List number creation
            [System.Collections.ArrayList]$VmssVMArray = @()                                # $VmssVMArray creation
            foreach ($_ in $VmssVMList) {                                                   # For each item in $var
                $VmssVMStatus = Get-AzVmssVM -ResourceGroupName `
                    $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.name `
                    -InstanceId $_.InstanceId -InstanceView                                 # Collects the Vmss Vm instance status
                $VmssVMStatus = ($VmssVMStatus.Statuses.Code).Split('/')[-1]                # Keeps the last portion of the Vmss VM instance status
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Instance' = $_.InstanceID; `
                    'State' = $VmssVMStatus                                                 # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VmssVMArray.Add($ArrayInput) | Out-Null                                    # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VmssVMList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen 
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $VmssVMArray) {                                                  # For each item in $var
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'InstanceID: '$_.Instance                                        # Write message to screen
                Write-Host 'State:      '$_.State                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VmssVMArray)
            :SelectAzureVmssVM while ($true) {                                              # Inner loop for selecting the Vmss VM instance
                $OperatorSelect = Read-Host 'Enter the [ # ] of the Vmss VM instance'       # Operator input for the selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $VmssVMArray.Number) {                          # Else if $OperatorSelect is in $VmssVMArray.Number
                    $OperatorSelect = $VmssVMArray | Where-Object `
                        {$_.Number -eq $OperatorSelect}                                     # $Operator select equals the item in $VmssVMArray where $OperatorSelect equals $VmssVMArray.Number
                    $VmssVMObject = Get-AzVmssVM -ResourceGroupName `
                        $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.Name `
                        -InstanceId $OperatorSelect.Instance                                # Pulls the full Vmss VM instance
                    if ($VmssVMObject) {                                                    # If $var is not $null
                        Return $VmssVMObject, $VmssObject                                   # Returns to calling function with $VmssVMObject and $VmssObject
                    }                                                                       # End if ($VmssVMObject) 
                    else {                                                                  # If $OperatorSelect did not meet any if or elseif statements
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmssVM                                                # Breaks :GetAzureVmssVM
                    }                                                                       # End else (if ($VmssVMObject))
                }                                                                           # End elseif ($OperatorSelect -in $VmssVMArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid entry'                                 # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureVmssVM while ($true)
        }                                                                                   # End :GetAzureVmssVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmssVM                                                                                        # End function GetAzVmssVM
function StartAzVmss {                                                                      # Function for starting vmss instances
    Begin {                                                                                 # Begin function
        :StartAzureVmssVM while ($true) {                                                   # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Start all instances in a Vmss'                                  # Write message to screen
            Write-Host '[2] Start a single instance in a Vmss'                              # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for selecting the instance start up option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssObject = GetAzVmss                                                 # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name                                        # Starts all instances for a Vmss
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   # Starts the specific instance of the Vmss
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # If $OperatorSelect did not meet any if or elseif statements
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StartAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVmss
function StopAzVmss {                                                                       # Function for Stoping vmss instances
    Begin {                                                                                 # Begin function
        :StopAzureVmssVM while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Stop all instances in a Vmss'                                   # Write message to screen
            Write-Host '[2] Stop a single instance in a Vmss'                               # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for selecting the instance stop option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssObject = GetAzVmss                                                 # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name                                        # Stops all instances of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   # Stops the specified instance of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # If $OperatorSelect did not meet any if or elseif statements
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StopAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVmss
# Functions for ManageAzContainerGroup
function ManageAzContainerGroup {                                                           # Function to manage container groups
    Begin {                                                                                 # Begin function
        :ManageAzureContainerGroup while ($true) {                                          # Outer loop for managing function
            if ($ContainerObject) {                                                         # If $ContainerObject has a value
                Write-Host 'The currently selected container object is' `
                    $ContainerObject.name                                                   # Write message to screen
            }                                                                               # End if ($ContainerObject)
            Write-Host "Azure Container Group Management"                                   # Write message to screen
            Write-Host '0 Clear "$ContainerObject"'                                         # Write message to screen
            Write-Host '1 New container group'                                              # Write message to screen
            Write-Host '2 Get container group'                                              # Write message to screen
            Write-Host '3 Remove container group'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzContainerGroup = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzContainerGroup -eq 'exit') {                                       # If $ManageAzContainerGroup equals 'exit'
                Break ManageAzureContainerGroup                                             # Breaks :ManageAzureContainerGroupr
            }                                                                               # End if ($ManageAzContainerGroup -eq 'exit')
            elseif ($ManageAzContainerGroup -eq '0') {                                      # Elseif $ManageAzContainerGroup equals 0
                if ($ContainerObject) {                                                     # If $ContainerObject has a value
                    Write-Host 'Clearing "$ContainerObject'                                 # Write message to screen
                    $ContainerObject = $null                                                # Clears $ContainerObject
                }                                                                           # End if ($ContainerObject)
                else {                                                                      # If $ContainerObject does not have a value
                    Write-Host '$ContainerObject is already clear'                          # Write message to screen
                }                                                                           # End else (if ($ContainerObject))
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '0')
            elseif ($ManageAzContainerGroup -eq '1') {                                      # Elseif $ManageAzContainerGroup equals 1
                Write-Host 'New container group'                                            # Write message to screen
                $ContainerObject = NewAzContainerGroup ($RGObject)                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '1')
            elseif ($ManageAzContainerGroup -eq '2') {                                      # Elseif $ManageAzContainerGroup equals 2
                Write-Host 'Get container group'                                            # Write message to screen
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '2')
            elseif ($ManageAzContainerGroup -eq '3') {                                      # Elseif $ManageAzContainerGroup equals 3
                Write-Host 'Remove container group'                                         # Write message to screen
                RemoveAzContainerGroup ($ContainerObject)                                   # Calls function
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '3')
            else {                                                                          # If $ManageAzContainerGroup do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzContainerGroup -eq 'exit'))
        }                                                                                   # End :ManageAzureContainerGroup while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzContainerGroup
function NewAzContainerGroup {                                                              # Function to create a new container
    Begin {                                                                                 # Begin function
        :NewAzureContainerGroup while ($true) {                                             # Outer loop for managing functions
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzContainerGroup'                                    # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetContainerName while ($true) {                                               # Inner loop for setting the container name
                $ContainerNameObject = Read-Host 'Container name'                           # Operator input for the container name
                if ($ContainerNameObject -eq 'exit') {                                      # If $ContainerName equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerNameObject -eq 'exit')
                $ContainerNameObject = $ContainerNameObject.ToLower()
                Write-Host 'Use' $ContainerNameObject 'as the container name'               # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the container name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetContainerName                                                  # Breaks :SetContainerName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetContainerName while ($true)  
            :SetAzureContainerType while ($true) {                                          # Inner loop for setting the container type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the container type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureContainerType                                             # Breaks :SetAzureContainerType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)    
            :SetAzureContainerImage while ($true) {                                         # Inner loop for setting the container image
                Write-Host 'Enter the URL of the container image'                           # Write message to screen
                Write-Host 'Short names of images on the '                                  # Write message to screen
                Write-Host 'azure marketplace may also be used'                             # Write message to screen
                Write-Host 'Type "Exit" to leave this function'                             # Write message to screen
                $ContainerImage = Read-Host 'Image info'                                    # Operator input for the image info
                Write-Host $ContainerImage                                                  # Write message to screen
                $OperatorConfirm = Read-Host 'Please confirm the image info [Y] or [N]'     # Operator confirmation of the image info
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerImage                                            # Breaks :SetAzureContainerImagr
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Writes message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerImage while ($true)
            :SetAzureContainerDNS while ($true) {                                           # Inner loop to set the container DNS
                $ContainerDNS = Read-Host 'Please create a DNS entry'                       # Operator input for the container DNS
                if ($ContainerDNS -eq 'exit') {                                             # If $ContainerDNS equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerDNS -eq 'exit')
                Write-Host 'Use' $ContainerDNS 'as the container DNS'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the DNS
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerDNS                                              # Breaks :SetAzureContainerDNS
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm not equal 'y'
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerDNS while ($true)
            Try {                                                                           # Try the following
                $ContainerObject = New-AzContainerGroup -ResourceGroupName `
                    $RGObject.ResourceGroupName -Name $ContainerNameObject -Image `
                    $ContainerImage -OsType $ImageTypeObject -DnsNameLabel $ContainerDNS    # Creates the new container group and assigns to $ContainerObject
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The defult resource may not be available at this time'          # Write message to screen
                Write-Host 'You may not have the permissions complete this action'          # Write message to screen
                Break NewAzureContainerGroup                                                # Breaks :NewAzureContainerGroup
            }                                                                               # End catch
            Return $ContainerObject                                                         # Returns to calling function with $ContainerObject
        }                                                                                   # End :NewAzureContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzContainerGroup
function GetAzContainerGroup {                                                              # Function to get a container
    Begin {                                                                                 # Begin function
        :GetAzureContainerGroup while ($true) {                                             # Outer loop to manage function
            $ContainerList = Get-AzContainerGroup                                           # Gets a list of all containers
            if (!$ContainerList) {                                                          # If $ContainerList has no value
                Write-Host 'No container groups found'                                      # Write message to screen
                Write-Host 'Returning to previous function'                                 # Write message to screen
                Break GetAzureContainerGroup                                                # Breaks :GetAzureContainerGroup
            }                                                                               # End if (!$ContainerList)
            $ContainerListNumber = 1                                                        # List number used for container selection
            [System.Collections.ArrayList]$ContainerArray = @()                             # Creates the array used for selection
            foreach ($_ in $ContainerList) {                                                # For each item in $ContainerList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $ContainerListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName                                                # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $ContainerArray.Add($ArrayInput) | Out-Null                                 # Adds the array input to array
                $ContainerListNumber = $ContainerListNumber + 1                             # Increments $ContainerListNumber by 1
            }                                                                               # End foreach ($_ in $ContainerList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ContainerArray) {                                               # For each item in $ContainerArray
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Container Name:'$_.name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ContainerArray)
            :SelectAzureContainer while ($true) {                                           # Inner loop for selecting the Container
                $ContainerSelect = Read-Host 'Container selection number'                   # Operator input for the Container selection
                if ($ContainerSelect -eq '0') {                                             # If $ContainerSelect equals 0
                    Break GetAzureContainerGroup                                            # Breaks :GetAzureContainer
                }                                                                           # End if ($ContainerSelect -eq '0')
                elseif ($ContainerSelect -in $ContainerArray.Number) {                      # If $ContainerSelect is in $ContainerArray.Number
                    $ContainerSelect = $ContainerArray | Where-Object `
                        {$_.Number -eq $ContainerSelect}                                    # $ContainerSelect is equal to the array item where $ContainerSelect equals the array number
                    $ContainerObject = Get-AzContainerGroup -ResourceGroupName `
                        $ContainerSelect.RG -Name $ContainerSelect.name                     # Pulls the full ContainerObject
                    if ($ContainerObject) {                                                 # If the Container object is pulled
                        Return $ContainerObject                                             # Return to calling function with $ContainerObject
                    }                                                                       # End if ($ContainerObject)
                    else {                                                                  # If the Container object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureContainer                                             # Breaks :GetAzureContainer
                    }                                                                       # End else (if ($ContainerObject))
                }                                                                           # End elseif ($ContainerSelect -in $ContainerArray.Number)
                else {                                                                      # If $ContainerSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($ContainerSelect -eq '0') )
            }                                                                               # End :SelectAzureContainer while ($true)
        }                                                                                   # End :GetAzureContainerGroup
    }                                                                                       # End Begin
}                                                                                           # End function GetAzContainerGroup
function RemoveAzContainerGroup {                                                           # Function to remove a container
    Begin{                                                                                  # Begin function
        :RemoveAzureContainerGroup while ($true) {                                          # Outer loop to manage function
            if (!$ContainerObject) {                                                        # If $ContainerObject is $null
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var 
                if (!$ContainerObject) {                                                    # If $ContainerObject is $null
                    Break RemoveAzureContainerGroup                                         # Breaks :RemoveAzureContainerGroup
                }                                                                           # End if (!$ContainerObject)
            }                                                                               # End if (!$ContainerObject)
            Write-Host 'Remove container ' $ContainerObject.name                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input to confirm removal
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Remove-AzContainerGroup -ResourceGroupName `
                    $ContainerObject.ResourceGroupName -Name $ContainerObject.Name          # Removes $ContainerObject 
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End if ($OperatorConfirm equals 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End else (if ($OperatorConfirm equals 'y'))
        }                                                                                   # End :RemoveAzContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzContainerGroup
# Functions for ManageAZAksCluster
function ManageAzAksCluster {                                                               # Function to manage Aks clusters
    Begin {                                                                                 # Begin function
        :ManageAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if ($AksObject) {                                                               # If $AksObject has a value
                Write-Host 'Current Aks cluster object is:'$AksObject.Name                  # Write message to screen
            }                                                                               # End if ($AksObject)
            Write-Host "Azure Kubernetes Service Cluster Management"                        # Write message to screen
            Write-Host '0 Clear "$AksObject"'                                               # Write message to screen
            Write-Host '1 New Aks cluster'                                                  # Write message to screen
            Write-Host '2 Get Aks cluster'                                                  # Write message to screen
            Write-Host '3 Remove Aks cluster'                                               # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzAksCluster = Read-Host "Option?"                                       # Collects operator input on $ManageAzAksCluster option
            if ($ManageAzAksCluster -eq 'exit') {                                           # If $ManageAzAksCluster equals 'exit'
                Break ManageAzureAksCluster                                                 # Breaks :ManageAzureAksCluster
            }                                                                               # End if ($ManageAzAksCluster -eq 'exit')
            elseif ($ManageAzAksCluster -eq '0') {                                          # Elseif $ManageAzAksCluster equals 0
                if ($AksObject) {                                                           # If $AksObject has a value
                    Write-Host 'Clearing "$AksObject'                                       # Write message to screen
                    $AksObject = $null                                                      # Clears $AksObject
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Write-Host '$AksObject is already clear'                                # Write message to screen
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End elseif ($ManageAzAksCluster -eq '0')
            elseif ($ManageAzAksCluster -eq '1') {                                          # Elseif $ManageAzAksCluster equals 1
                Write-Host 'New Aks cluster'                                                # Write message to screen
                $AksObject = NewAzAksCluster ($RGObject)                                    # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '1')
            elseif ($ManageAzAksCluster -eq '2') {                                          # Elseif $ManageAzAksCluster equals 2
                Write-Host 'Get Aks cluster'                                                # Write message to screen
                $AksObject = GetAzAksCluster                                                # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '2')
            elseif ($ManageAzAksCluster -eq '3') {                                          # Elseif $ManageAzAksCluster equals 3
                Write-Host 'Remove Aks cluster'                                             # Write message to screen
                RemoveAzAksCluster ($AksObject)                                             # Calls function
            }                                                                               # End elseif ($ManageAzAksCluster -eq '3')
            else {                                                                          # If $ManageAzAksCluster do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzAksCluster -eq 'exit'))
        }                                                                                   # End :ManageAzureAksCluster while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzAksCluster
function NewAzAksCluster {                                                                  # Function to create a new Aks Cluster
    Begin {                                                                                 # Begin function
        :NewAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzAksCluster'                                        # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAksClusterName while ($true) {                                              # Inner loop for setting the AksCluster name
                $AksClusterNameObject = Read-Host 'Aks cluster name'                        # Operator input for the AksCluster name
                if ($AksClusterNameObject -eq 'exit') {                                     # If $AksClusterName equals exit
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksClusterNameObject -eq 'exit')
                Write-Host 'Use' $AksClusterNameObject 'as the Aks cluster name'            # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the AksCluster name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetAksClusterName                                                 # Breaks :SetAksClusterName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAksClusterName while ($true)  
            :SetAzureAksClusterType while ($true) {                                         # Inner loop for setting the AksCluster type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the AksCluster type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureAksClusterType                                            # Breaks :SetAzureAksClusterType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureAksType while ($true)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag"                       # Operator input for a tag name
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Writes tag to screen
                $OperatorConfirm = Read-Host "Use this tag for the Aks Cluster [Y] or [N]"  # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If statement for $Tag being correct
                    break SetAzureTag                                                       # Ends :SetAzureTag while loop
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Write message to screen  
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureAksNodeCount while ($true) {                                           # Loop for setting the node count
                Write-Host '[0] to exit'                                                    # Write message to screen
                [int]$AksNodeObject = Read-Host 'Enter the number of nodes'                 # Operator input for the node count
                if ($AksNodeObject -eq '0') {                                               # If $AksNodeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksNodeObject -eq '0')
                elseif (!$AksNodeObject) {                                                  # Else if $AksNodeObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen   
                }                                                                           # End elseif (!$AksNodeObject)
                elseif ($AksNodeObject -lt 0) {
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }
                else {                                                                      # If $AksNodeObject has value
                    $OperatorConfirm = Read-Host 'This Aks cluster will have' `
                    $AksNodeObject 'node(s)? [Y] or [N]'                                    # Operator confirmation of the node count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksNodeCount                                          # Breaks :SetAzureAksNodeCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If OperatorConfirm does not equal 'y'
                        Clear-Variable $AksNodeObject                                       # Clears $AksNodeObject
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (End if ($AksNodeObject -eq '0'))
            }                                                                               # End :SetAzureAksNodeCount while ($true)
            if ($ImageTypeObject -eq 'Linux') {                                             # If $ImageTypeObject equals 'linux'
                Try {
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'             # Creates the Aks cluster for linux
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End if ($ImageTypeObject -eq 'Linux')
            else {                                                                          # If $ImageTypeObject does not equal linux  
                :SetAzureAksUserName while ($true) {                                        # Inner loop for setting the Aks username
                    $AksUserNameObject = Read-Host "Aks username"                           # Operator input of the Aks user name
                    if ($AksUserNameObject -eq 'exit') {                                    # If $AksUsernameObject is $null
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksUserNameObject -eq 'exit')
                    Write-Host $AksUserNameObject                                           # Writes message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks username? [Y] or [N]"      # Operator confirmation of the Aksuser name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksUserName                                           # Breaks :SetAzureAksUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksUserName while ($true)
                :SetAzureAksPassword while ($true) {                                        # Inner loop for setting the password
                    $AksPasswordObject = Read-Host "Aks password"                           # Operator input for the password
                    if ($AksPasswordObject -eq 'exit') {                                    # If $AksPasswordObject equals 'exit'
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksPasswordObject -eq 'exit')
                    Write-Host $AksPasswordObject                                           # Write message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks password? [Y] or [N]"      # Operator confirmation of the password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        $AksPasswordObject = ConvertTo-SecureString $AksPasswordObject `
                            -AsPlainText -Force                                             # Hashes $AksPasswordObject
                        Break SetAzureAksPassword                                           # Breaks :SetAzureAksPassword
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksPassword while ($true)
                Try {                                                                       # Try the following
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -WindowsProfileAdminUserName $AksUserNameObject `
                        -WindowsProfileAdminUserPassword $AksPasswordObject `
                        -NetworkPlugin azure -NodeVmSetType VirtualMachineScaleSets `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'              # Creates the Aks cluster
                    $AksNodeName = 'Nnamet'
                    New-AzAksNodePool -ResourceGroupName $RGObject.ResourceGroupName `
                        -ClusterName $AksClusterNameObject -Name $AksNodeName -OsType `
                        Windows -VmSetType VirtualMachineScaleSets                          # Adds additional windows parameters 
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End else (if ($ImageTypeObject -eq 'Linux'))
        }                                                                                   # End :NewAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzAksCluster
function GetAzAksCluster {                                                                  # Function to get an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :GetAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Getting a list of all Aks Clusters'                                 # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            $ObjectListNumber = 1                                                           # $var used as list number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the array that all objects will be loaded into
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $ObjectList = Get-AzAksCluster -ResourceGroupName $_.ResourceGroupName      # Gets a list of any AKS clusters
                if ($ObjectList) {                                                          # If $ObjectList has a value
                    $RGName = $_.ResourceGroupName                                          # $RGName is set to the current resource group name
                    foreach ($_ in $ObjectList) {                                           # For each item in $ObjectList
                        $ArrayInput = [PSCustomObject]@{'Name' = $_.Name; 'Number' = `
                            $ObjectListNumber; 'NRG' = $_.NodeResourceGroup; 'RG' =$RGName} # Creates $var to load items into array                
                        $ObjectArray.Add($ArrayInput) | Out-Null                            # Adds items to the array
                        $ObjectListNumber = $ObjectListNumber + 1                           # Increments $ObjectListNumber up by 1
                    }                                                                       # End foreach ($_ in $ObjectList)                                                 
                }                                                                           # End if ($ObjectList)
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $Object array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Aks Name:  '$_.Name                                             # Write message to screen
                Write-Host 'NodeRG:    '$_.NRG                                              # Write message to screen
                Write-Host 'Object RG: '$_.RG                                               # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureAksCluster while ($true) {                                          # Inner loop to select the Aks cluster
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host "You are selecting the Aks cluster for"$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the number of the Aks Cluster'           # Operator input for the Aks cluster
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureAksCluster                                                # Breaks :GetAzureAksCluster
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ObjectArray.Number) {                          # Else if $OperatorSelect equals $ObjectArray.Number
                    $AksObject = $ObjectArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $AksObject is equal to $ObjectArray where $OperatorSelect equals $ObjectArray.Number
                    Return $AksObject                                                       # Returns to calling function with $AksObject
                }                                                                           # End elseif ($OperatorSelect -eq $ObjectArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureAksCluster while ($true)
        }                                                                                   # End :GetAzureAksCluster while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAksCluster
function RemoveAzAksCluster {                                                               # Function to remove an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :RemoveAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if (!$AksObject) {                                                              # If $AksObject is $null
                $CallingFunction = 'RemoveAzAksCluster'                                     # Creates $Calling function $var
                $AksObject = GetAzAksCluster ($CallingFunction)                             # Calls function and assigns output to $var
                if (!$AksObject) {                                                          # If $AksObject is $null
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End if (!$AksObject)
            }                                                                               # End if (!$AksObject)
            Write-Host 'Remove Aks Cluster named:'$AksObject.Name'in RG:'$AksObject.RG       # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Aks cluster
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzAksCluster -ResourceGroupName $AksObject.RG `
                        -Name $AksObject.Name -Force -ErrorAction 'Stop'                    # Removes the Object
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to this resource'          # Write message to screen
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Catch
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Break RemoveAzureAksCluster                                                 # Breaks :RemoveAzureAksCluster
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzAksCluster
# Additional required functions specific to ManageAzCompute
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host "[0] Exit"                                                   # Write message to screen
                    Write-Host "[1] Windows"                                                # Write message to screen
                    Write-Host "[2] Linux"                                                  # Write message to screen
                    $ImageTypeObject = Read-Host '[0], [1], or [2]'                         # Operator input for the image type
                }                                                                           # End if (!$ImageTypeObject)
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break GetAzureVMImage                                                   # Breaks :GetAzureVMImage
                }                                                                           # End if ($ImageTypeObject -eq '0') 
                elseif ($ImageTypeObject -eq '1') {                                         # Else if $ImageTypeObject equals 1
                    $VMPublisherObject = 'MicrosoftWindowsServer'                           # Sets the Windows publisher
                    Break GetAzureImagePublisher                                            # Breaks :GetAzureImagePublisher
                }                                                                           # End elseif ($ImageTypeObject -eq '1')
                elseif ($ImageTypeObject -eq '2') {                                         # Else if $ImageTypeObject equals 2
                    :GetAzureLinuxPublisher while ($true) {                                 # Outer loop to manage function
                        [System.Collections.ArrayList]$ImagePublisherArray = @()            # Creates the valid Pub array
                        $ImagePublisherList = @('Ubuntu','RedHat','CentOS','SUSE','Debian', `
                            'Oracle','CoreOS')                                              # Creates a list of items to load into $ImagePublisherArray Array
                        $ImagePublisherNumber = 1                                           # Sets the base number for the valid Pub array
                        foreach ($_ in $ImagePublisherList) {                               # For each item in $ImagePublisherList
                            $ImagePublisherInput = [PSCustomObject]@{'Name' = $_;'Number' `
                                = $ImagePublisherNumber}                                    # Creates the item to loaded into array
                            $ImagePublisherArray.Add($ImagePublisherInput) | Out-Null       # Loads item into array, out-null removes write to screen
                            $ImagePublisherNumber = $ImagePublisherNumber + 1               # Increments $ImagePublisherNumber up 1
                        }                                                                   # End foreach ($_ in $ImagePublisherList)
                        Write-Host '0 Exit'                                                 # Write message to screen
                        foreach ($_ in $ImagePublisherArray) {                              # For each item in $ImagePublisherArray
                            Write-Host $_.Number $_.Name                                    # Write message to screen
                        }                                                                   # End foreach ($_ in $ImagePublisherArray)
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            $PublisherSelect = Read-Host "Publisher number"                 # Operator selection of the publisher
                            if ($PublisherSelect -eq '0') {                                 # If $Pubselect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($PublisherSelect -eq '0')
                            $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                {$_.Number -eq $PublisherSelect}                            # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $PublisherSelect
                            If ($VMPublisherObject) {                                       # If $VMPublisherObject has a value
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End If ($VMPublisherObject)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host "That was not a valid option"                    # Write message to screen
                            }                                                               # End else (# End If ($VMPublisherObject))
                        }                                                                   # End :SelectAzurePub while ($true)
                        if ($VMPublisherObject.Name -eq 'Ubuntu') {                         # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Canonical'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End ($VMPublisherObject.Name -eq 'Ubuntu')
                        elseif ($VMPublisherObject.Name -eq 'RedHat') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'RedHat'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'RedHat')
                        elseif ($VMPublisherObject.Name -eq 'CentOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'OpenLogic'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CentOS')
                        elseif ($VMPublisherObject.Name -eq 'SUSE') {                       # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'SUSE'                                     # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'SuSE')
                        elseif ($VMPublisherObject.Name -eq 'Debian') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'credativ'                                 # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Debian')
                        elseif ($VMPublisherObject.Name -eq 'Oracle') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Oracle-Linux'                             # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Oracle')
                        elseif ($VMPublisherObject.Name -eq 'CoreOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'CoreOS'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CoreOS')
                        Break GetAzureImagePublisher                                        # Breaks :GetAzureImagePublisher
                    }                                                                       # End GetAzureVMImage
                }                                                                           # End elseif ($ImageTypeObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {
                $ImageOfferList = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject                                       # Generates the image offer list
                $ImageOfferNumber = 1                                                       # Sets $ImageOfferNumber to 1
                [System.Collections.ArrayList]$ImageOfferArray = @()                        # Creates the valid Pub array
                foreach ($Offer in $ImageOfferList) {                                       # For each $Offer in $ImageOfferList
                    $ImageOfferInput = [PSCustomObject]@{'Name' = $Offer.Offer; `
                        'Number' = $ImageOfferNumber}                                       # Creates the item to loaded into array
                    $ImageOfferArray.Add($ImageOfferInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                    $ImageOfferNumber = $ImageOfferNumber + 1                               # Increments $ImageofferNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageOfferArray) {                                          # For each $_ in $ImageOfferArray
                    Write-Host $_.Number $_.Name                                            # Writes offer number and name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    $OfferSelect = Read-Host "Enter the offer number"                       # Operator input for the offer selection
                    if ($OfferSelect -eq '0') {                                             # If $OfferSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')
                    $VMOfferObject = $ImageOfferArray | Where-Object `
                        {$_.Number -eq $OfferSelect}                                        # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OfferSelect
                    if ($VMOfferObject) {                                                   # If $VMOfferObject has a value
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMOfferObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               #
                $VMOfferObject = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject | Where-Object {$_.Offer `
                    -eq $VMOfferObject.Name}                                                # Pulls the full $VMOfferObject
                $ImageSkuList = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                    -Location $LocationObject.DisplayName -PublisherName $VMPublisherObject # Generates the $ImageSkuList
                $ImageSkuNumber = 1                                                         # Sets $ImageSkuNumber to 1
                [System.Collections.ArrayList]$ImageSkuArray = @()                          # Creates the $ImageSkuArray     
                foreach ($Skus in $ImageSkuList) {                                          # For each Sku in $ImageSkuList
                    $ImageSkuInput = [PSCustomObject]@{'Name' = $Skus.Skus; `
                        'Number' = $ImageSkuNumber}                                         # Creates the item to loaded into array
                    $ImageSkuArray.Add($ImageSkuInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    $ImageSkuNumber = $ImageSkuNumber + 1                                   # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageSkuArray) {                                            # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    $SkuSelect = Read-Host "Enter the sku number"                           # Operator input for selecting the image sku
                    if ($SkuSelect -eq '0') {                                               # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0') 
                    $VMSkuObject = $ImageSkuArray | Where-Object {$_.Number -eq $SkuSelect} # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    $VMSkuObject = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                        -Location $LocationObject.DisplayName -PublisherName `
                        $VMPublisherObject | Where-Object {$_.Skus -eq $VMSkuObject.Name}   # Gets the Sku object                                      
                    if ($VMSkuObject) {                                                     # If $VMSkuObject has a value
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                :SelectAzureImageVerType while ($true) {                                    # Inner loop for chosing current or previous version of sku
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Use current version'                                    # Write message to screen
                    Write-Host '[2] Select version'                                         # Write message to screen
                    $ImageVersionOption = Read-Host '[0], [1], or [2]'                      # Operator input for version selection type
                    if ($ImageVersionOption -eq '0') {                                      # If $ImageVersionOption equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($ImageVersionOption -eq '0')            
                    elseif ($ImageVersionOption -eq '1' -or $ImageVersionOption -eq '2') {  # If $ImageVersionOption equals 1 or 2
                        Break SelectAzureImageVerType                                       # Breaks :SelectAzureImageVerType
                    }                                                                       # End elseif ($ImageVersionOption -eq '1' -or $ImageVersionOption -eq '2')
                    else {                                                                  # If $ImageVersionOption is not equal to 0, 1, or 2
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($ImageVersionOption -eq '0'))
                }                                                                           # End :SelectAzureImageVerType while ($true)
                if ($ImageVersionOption -eq '1') {                                          # If $ImageVersionOption equals 1
                    $VMImageObject = $VMSkuObject                                           # VMImageObject is equal to $VMSkuObject
                    Return $VMImageObject                                                   # Returns $VMImageObject to calling function
                }                                                                           # End if ($ImageVersionOption -eq '1')
                else {                                                                      # If $ImageVersionOption is not '1' (can only be '2')
                    $ImageVersionList =  Get-AzVMImage -Location `
                        $LocationObject.Location -PublisherName $VMPublisherObject `
                        -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus                 # Gets image version list and assigns to $var
                    $ImageVersionNumber = 1                                                 # Sets $ImageSkuNumber to 1
                    [System.Collections.ArrayList]$ImageVersionArray = @()                  # Creates the $ImageSkuArray     
                    foreach ($_ in $ImageVersionList) {                                     # For each Sku in $ImageSkuList
                        $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                            'Number' = $ImageVersionNumber}                                 # Creates the item to loaded into array
                        $ImageVersionArray.Add($ImageVersionInput) | Out-Null               # Loads item into array, out-null removes write to screen
                        $ImageVersionNumber = $ImageVersionNumber + 1                       # Increments $ImageSkuNumber by 1
                    }                                                                       # End foreach ($Offer in $ImageOfferList)
                    Write-Host "0 Exit"                                                     # Write message to screen
                    foreach ($_ in $ImageVersionArray) {                                    # For each $_ in $ImageSkuArray
                        Write-Host $_.Number $_.Name                                        # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                    }                                                                       # End foreach ($_ in $ImageVersionArray)
                    :SelectAzureImageVersion while ($true) {                                # Inner loop for selecting the image sku
                        $VersionSelect = Read-Host "Enter the Version number"               # Operator input for selecting the image sku
                        if ($VersionSelect -eq '0') {                                       # If $SkuSelect equals 0
                            Break GetAzureVMImage                                           # Breaks :GetAzureVMImage
                        }                                                                   # End if ($OfferSelect -eq '0')                                           
                        $VMVersionObject = $ImageVersionArray | `
                            Where-Object {$_.Number -eq $VersionSelect}                     # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                        if ($VMVersionObject) {                                             # If $VMSkuObject has a value
                            $VMImageObject = Get-AzVMImage -Location `
                            $LocationObject.Location -PublisherName $VMPublisherObject `
                            -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus -Version `
                            $VMVersionObject.Name                                           # If #VMVersionObject has a value, pull the full object and assign to $var
                            Break GetAzureImageVersion                                      # Break SelectAzureImageSku
                        }                                                                   # End if ($VMOfferObject)
                        else {                                                              # If $VMSkuObject does not have a value
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($VMOfferObject))
                    }                                                                       # End :SelectAzureImageVersion while ($true)
                }                                                                           # End else(if ($ImageVersionOption -eq '1'))
            }                                                                               # End :GetAzureImageVersion while ($true)
            Return $VMImageObject                                                           # Returns #VMImageObject
        }                                                                                   # End :GetAZVMImage while ($true)
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMOS
function GetAzVMSize {                                                                      # Function for setting the VM size
    Begin {                                                                                 # Begin function
        :GetAzureVMSize while ($true) {                                                     # Outer loop for managing function
            $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName                # Gets a list of all VM sizes in location
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $CoreCountList)
                foreach ($_ in $ValidCore) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Cores"                              # Write message to screen
                }                                                                           # End foreach ($_ in $ValidCore) 
                $CoreCount = Read-Host "Enter the list number for VM core count"            # Operator input for the core count value
                if ($CoreCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($CoreCount -eq '0')
                elseif ($CoreCount -in $ValidCore.Number) {                                 # If $CoreCoint in $ValidCore.Number list
                    $CoreCount = $ValidCore | Where-Object {$_.Number -eq $CoreCount}       # $CoreCount is equal to $ValidCore where $ValidCore.Number equals $CoreCount
                    $CoreCount = $CoreCount.Count                                           # CoreCount is equal to $CoreCount.Count
                    $OperatorConfirm = Read-Host "Confirm:"$CoreCount" cores? [Y] or [N]"   # Operator confirmation of core count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMCoreCount                                           # Breaks :SetAzureVMCoreCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
                }                                                                           # End elseif ($CoreCount -in $ValidCore.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($CoreCount -eq '0'))
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                foreach ($_ in $ValidRam) {                                                 # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"MB"                                 # Write message to screen
                }                                                                           # End foreach ($_ in $ValidRam)
                $RamCount = Read-Host "Enter the list number for VM Ram"                    # Operator input for the ram count selection
                if ($RamCount -eq '0') {                                                    # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($RamCount -eq '0')
                elseif ($RamCount -in $ValidRam.Number) {                                   # If $Ramcount is in $ValidRam.Number list
                    $RamCount = $ValidRam | Where-Object {$_.Number -eq $RamCount}          # $RamCount equals $ValidRam where $ValidRam.Number equals $RamCount 
                    $RamCount = $RamCount.Count                                             # $RamCount equals $RamCount.Count
                    $OperatorConfirm = Read-Host "Confirm:" `
                    $RamCount" MB of Ram? [Y] or [N]"                                       # Operator confirmation on ram count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMRamCount                                            # Breaks :SetAzureRamCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($RamCount -in $ValidRam.Number) 
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RamCount -eq '0'))
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                foreach ($_ in $ValidDisk) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Max disks"                          # Write message to screen
                }                                                                           # End foreach ($_ in $ValidDisk)
                $DiskCount = Read-Host "Enter the list number for VM max disks"             # Operator input for the max disk count
                if ($DiskCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($DiskCount -eq '0')
                elseif ($DiskCount -in $ValidDisk.Number) {                                 # Else if $DiskCount is in $ValidDisk.Number list
                    $DiskCount = $ValidDisk | Where-Object {$_.Number -eq $DiskCount}       # $DiskCount equals $ValidDisk where $ValidDisk.Number equals $DiskCount
                    $DiskCount = $DiskCount.Count                                           # $DiskCount equals $DiskCount.Count
                    $OperatorConfirm = Read-Host `
                    "Confirm"$DiskCount" max disks? [Y] or [N]"                             # Operator confirmation of the disk count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMDiskCount                                           # Breaks :SetAzureVMDiskCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($DiskCount -in $ValidDisk.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($DiskCount -eq '0'))
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to scrren
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                foreach ($_ in $ValidVMSize) {                                              # For each item in list
                    Write-Host "["$_.Number"]" $_.Name                                      # Write message to screen
                    Write-Host "OS disk size:"$_.OSDiskSize"MB"                             # Write message to screen
                    Write-Host "Resource Disk size:"$_.RSDiskSize"MB"                       # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ValidVMSize)
                $VMSizeCount = Read-Host "Enter the list number for VM size"                # Operator input for the VM size
                if ($VMSizeCount -eq '0') {                                                 # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($VMSizeCount -eq '0')
                elseif ($VMSizeCount -in $ValidVMSize.Number) {                             # If $VMSizeCoint is in $ValidVMSize.Number
                    $VMSizeCount = $ValidVMSize | Where-Object {$_.Number -eq $VMSizeCount} # $VMsizeCount is equal to $ValidVMSize where $ValidVMSize.Number equals $VMSizeCount
                    $VMSizeObject = Get-AzVMSize -Location $LocationObject.location | `
                        Where-Object {$_.Name -eq $VMSizeCount.Name}                        # $VMSizeNumber is pulled using $VMSizeCount.Name
                    if ($VMSizeObject) {                                                    # If $VMSizeObject exists
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End if ($VMSizeObject)
                }                                                                           # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($VMSizeCount -eq '0'))
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVMsize
# End Manage Compute
# Manage Network
# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Remove-AzVirtualNetwork:    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetwork?view=azps-5.4.0
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Remove-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Remove-AzNetworkInterface:  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    ManageAzVirtualNetwork:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/ManageAzVirtualNetwork.ps1       
        NewAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/NewAzVirtualNetwork.ps1
        ListAzVirtualNetwork:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/ListAzVirtualNetwork.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        RemoveAzVirtualNetwork:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/RemoveAzVirtualNetwork.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
        AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
    ManageAzVNetSubnetConfig:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/ManageAzVNetSubnetConfig.ps1
        AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        RemoveAzVNetSubnetConfig:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/RemoveAzVNetSubnetConfig.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    ManageAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ManageAzNetworkInterface.ps1
        NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
        GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
        RemoveAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNetworkInterface.ps1   
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    ManageAzNetwork:            Management function for azure networking
    ManageAzVirtualNetwork:     Management function for azure virtual networks
        NewAzVirtualNetwork:        Creates a new azure virtual network
        ListAzVirtualNetwork:       Lists all existing azure virtual networks
        GetAzVirtualNetwork:        Gets an existing azure virtual network
        RemoveAzVirtualNetwork:     Removes an azure virtual network
    ManageAzVNetSubnetConfig:   Management function for subnets    
        AddAzVNetSubnetConfig:      Adds an azure virtual network subnet
        GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
        RemoveAzVNetSubnetConfig:   Removes an azure virtual network subnet
    ManageAzNetworkInterface:   Management function for network interfaces
        NewAzNetworkInterface:      Creates new network interfaces
        GetAzNetworkInterface:      Gets an existing network interface
        RemoveAzNetworkInterface:   Removes a network interface   
    GetAzResourceGroup:         Gets a resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :ManageAzureNetwork         Outer loop for managing function
    $RGObject:                  Resource group object
    $VNetObject:                Virtual network object
    $ManageAzNetwork:           Operator input to select management function
    ManageAzVirtualNetwork{}    Gets $VnetObject
        NewAzVirtualNetwork{}       Creates $VNetObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
            AddAzVNetSubnetConfig{}     Adds subnets to $VNetObject
        ListAzVirtualNetwork{}      Lists Vnets
        GetAzVirtualNetwork{}       Gets $VNetObject
        RemoveAzVirtualNetwork{}   Removes $VnetObject
            GetAzVirtualNetwork{}       Gets $VNetObject
    ManageAzVNetSubnetConfig{}      Gets $SubnetObject
        AddAzVNetSubnetConfig{}     Creates $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
        RemoveAzVNetSubnetConfig{}  Removes $SubnetObject
            GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
    ManageAzNetworkInterface{}  Get $NicObject
        NewAzNetworkInterface{}     Creates $NicObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
            GetAzVNetSubnetConfig{}     Gets $SubnetObject
        GetAzNetworkInterface{}     Get $NicObject
        RemoveAzNetworkInterface{}  Removes $NicObject
            GetAzNetworkInterface{}     Get $NicObject
} #>
<# Process Flow {
    Function
        Call ManageAzNetwork > Get $null
            Call ManageAzVirtualNetwork > Get $VNetObject
                Call NewAzVirtualNetwork > Get $VNetObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzVirtualNetwork > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzVirtualNetwork > Send $LocationObject
                    Call AddAzVNetSubnetConfig > Get $VNetObject
                    End AddAzVNetSubnetConfig
                        Return NewAzVirtualNetwork > Send $VNetObject 
                End NewAzVirtualNetwork
                    Return Function > Send $VNetObject
                Call ListAzVirtualNetwork > Get $null 
                End ListAzVirtualNetwork
                    Return ManageAzVirtualNetwork > Send $null
                Call GetAzVirtualNetwork > Get $VNetObject
                End GetAzVirtualNetwork
                    Return ManageAzVirtualNetwork > Send $VNetObject
                Call RemoveAzVirtualNetwork > Get $null
                    Call GetAzVirtualNetwork > Get $VNetObject
                    End GetAzVirtualNetwork
                        Return RemoveAzVirtualNetwork > Send $VNetObject
                End RemoveAzVirtualNetwork
                    Return ManageAzVirtualNetwork > Send $null
            End ManageAzVirtualNetwork
                Return ManageAzNetwork > Send $VNetObject
            Call ManageAzVnetSubnetConfig > Get $SubnetObject
                Call AddAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $VNetObject
                    End GetAzVirtualNetwork
                        Return AddAzVNetSubnetConfig > Send $VNetObject
                End AddAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $SubnetObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                End GetAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $SubnetObject
                Call RemoveAzVNetSubnetConfig > Get $null
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                    End GetAzVNetSubnetConfig
                        Return RemoveAzVNetSubnetConfig > Send $SubnetObject
                End RemoveAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $null
            End ManageAzVnetSubnetConfig
                Return ManageAzNetwork > Send $SubnetObject 
            Call ManageAzNetworkInterface > Get $SubnetObject
                Call NewAzNetworkInterface > Get $NicObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzNetworkInterface > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzNetworkInterface > Send $LocationObject
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                    End GetAzVNetSubnetConfig
                        Return NewAzNetworkInterface > Send $SubnetObject
                    End NewAzNetworkInterface
                        Return ManageAzNetworkInterface > Send $NicObject
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $NicObject
                Call RemoveAzNetworkInterface > Get $null
                    Call GetAzNetworkInterface > Get $NicObject
                    End GetAzNetworkInterface
                        Return RemoveAzNetworkInterface > Send $NicObject
                End RemoveAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $null
            End ManageAzNetworkInterface
                Return ManageAzNetwork > Send $NicObject
        End ManageAzNetwork
            Return function > Send $Null
}#>
function ManageAzNetwork {                                                                  # Function for managing azure network resources
    Begin {                                                                                 # Begin function   
        :ManageAzureNetwork while ($true) {                                                 # Outer loop for managing function
            Write-Host "Azure Network Management"                                           # Write message to screen
            Write-Host '0 Clear "$vars"'                                                    # Write message to screen
            Write-Host '1 Manage virtual network'                                           # Write message to screen
            Write-Host '2 Manage subnets'                                                   # Write message to screen
            Write-Host '3 Manage network interfaces'                                        # Write message to screen
            Write-Host '4 Manage public IPs'                                                # Write message to screen
            Write-Host '5 Manage load balancers'                                            # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzNetwork = Read-Host "Option?"                                          # Collects operator input on $ManageAzNetwork option
            if ($ManageAzNetwork -eq 'exit') {                                              # If $ManageAzNetwork equals 'exit'
                Break ManageAzureAksCluster                                                 # Breaks :ManageAzureAksCluster
            }                                                                               # End if ($ManageAzNetwork -eq 'exit')
            elseif ($ManageAzNetwork -eq '0') {  #fix this                                           # Elseif $ManageAzNetwork equals 0
                if ($) {                                                           # If $ has a value
                    Write-Host 'Clearing "$'                                       # Write message to screen
                    $ = $null                                                      # Clears $
                }                                                                           # End if ($)
                else {                                                                      # If $ does not have a value
                    Write-Host '$ is already clear'                                         # Write message to screen
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End elseif ($ManageAzNetwork -eq '0')
            elseif ($ManageAzNetwork -eq '1') {                                             # Elseif $ManageAzNetwork equals 1
                Write-Host 'Manage virtual network'                                         # Write message to screen
                $VNetObject = ManageAzVirtualNetwork ($RGObject)                            # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNetwork -eq '1')
            elseif ($ManageAzNetwork -eq '2') {                                             # Elseif $ManageAzNetwork equals 2
                Write-Host 'Manage subnets'                                                 # Write message to screen
                $SubnetObject = ManageAzVNetSubnetConfig ($RGObject, $VnetObject)           # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNetwork -eq '2')
            elseif ($ManageAzNetwork -eq '3') {                                             # Elseif $ManageAzNetwork equals 3
                Write-Host 'Remove Aks cluster'                                             # Write message to screen
                RemoveAzAksCluster ($AksObject)                                             # Calls function
            }                                                                               # End elseif ($ManageAzNetwork -eq '3')
            else {                                                                          # If $ManageAzNetwork do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzNetwork -eq 'exit'))
        } # End :ManageAzureNetwork while ($true)
    } # End Begin
} # End function ManageAzNetwork
# Functions for ManageAzVirtualNetwork
function ManageAzVirtualNetwork {                                                           # Function for managing azure virtual networks
    Begin {                                                                                 # Begin function
        :ManageAzureVirtualNetwork while($true) {                                           # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The current RG is:' $RGObject.ResourceGroupName                 # Write message to screen
            }                                                                               # End if ($RGObject)
            if ($VNetObject) {                                                              # If $VNetObject has a value
                Write-Host 'The current Vnet is:' $VNetObject.name                          # Write message to screen
            }                                                                               # End if ($VNetObject)
            Write-Host "Azure Virtual Network Management"                                   # Write message to screen
            Write-Host '0 Clear "$VNetObject"'                                              # Write message to screen
            Write-Host '00 Clear $RGObject'                                                 # Write message to screen
            Write-Host '1 New virtual network'                                              # Write message to screen
            Write-Host '2 List virtual networks'                                            # Write message to screen
            Write-Host '3 Get virtual network'                                              # Write message to screen
            Write-Host '4 Remove virtual network'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzVirtualNetwork = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzVirtualNetwork -eq 'exit') {                                       # If $ManageAzureVirtualNetwork equals 'exit'
                Break ManageAzureVirtualNetwork                                             # End Break ManageAzureVirtualNetwork
            }                                                                               # End if ($ManageAzVirtualNetwork -eq 'exit')
            if ($ManageAzVirtualNetwork -eq '0') {                                          # If $ManageAzVirtualNetwork equals '0'
                if ($VNetObject) {                                                          # If $VNetObject has a value
                    $VNetObject = $null                                                     # Clears $VNetObject
                    Write-Host '"$VNetObject" has been cleared'                             # Write message to screen
                }                                                                           # End if ($VNetObject)
                else {                                                                      # If $VNetObject does not have a value
                    Write-Host '"$VNetObject is already $null'                              # Write message to screen
                }                                                                           # End else (if ($VNetObject))
            }                                                                               # End if ($ManageAzVirtualNetwork -eq '0')
            elseif ($ManageAzVirtualNetwork -eq '00') {                                     # Else if $ManageAzVirtualNetwork equals '00'
                if ($RGObject) {                                                            # If $RGObject has a value
                    $RGObject = $null                                                       # Clears $RGObject
                    Write-Host '"$RGObject" has been cleared'                               # Write message to screen
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '"$RGObject is already $null'                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '00')
            elseif ($ManageAzVirtualNetwork -eq '1') {                                      # Else if $ManageAzVirtualNetwork equals '1'
                Write-Host 'New virtual network'                                            # Write message to screen
                $VNetObject = NewAzVirtualNetwork ($RGObject)                               # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '1')
            elseif ($ManageAzVirtualNetwork -eq '2') {                                      # Else if $ManageAzVirtualNetwork equals '2'
                Write-Host 'List virtual networks'                                          # Write message to screen
                ListAzVirtualNetwork                                                        # Calls function
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '2')
            elseif ($ManageAzVirtualNetwork -eq '3') {                                      # Else if $ManageAzVirtualNetwork equals '3'
                Write-Host 'Get virtual network'                                            # Write message to screen
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '3')
            elseif ($ManageAzVirtualNetwork -eq '4') {                                      # Else if $ManageAzVirtualNetwork equals '4'
                Write-Host 'Remove virtual network'                                         # Write message to screen
                RemoveAzVirtualNetwork ($VNetObject)                                        # Calls function
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '4')
            else {                                                                          # Else for all other inputs for $ManageAzVirtualNetwork
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzVirtualNetwork -eq '0'))
        }                                                                                   # End :ManageAzureVirtualNetwork while($true)
        Return $VNetObject                                                                  # Returns to calling function with $VNetObject
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetwork
function NewAzVirtualNetwork {                                                              # Creates a new Vnet
    Begin {                                                                                 # Begin function
        :NewAzureVNet while ($true) {                                                       # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzVirtualNetwork'                                    # Creates $CallingFunction for network to display this functions name
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject is $null
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if (!$LocationObject)
            }                                                                               # End if (!$LocationObject)
            :SetAzureVNetName while ($true) {                                               # Inner loop for setting the vnet name
                $VNetName = Read-Host "Virtual network name"                                # Operator input for the vnet name
                if ($VNetName -eq 'exit') {                                                 # If $VnetName is 'exit'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($VNetName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $VNetName "as the VNet name [Y] or [N]"  # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVNetName                                                  # Breaks :SetAzureVNetName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVNetName while ($true)
            :SetAzureVnetAddress while ($true) {                                            # Inner loop for setting the vnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)"              # Operator input for the Vnet prefix
                $OperatorConfirm = Read-Host `
                    "Use" $AddressPrefix "as the Vnet address prefix [Y] or [N]"            # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVnetAddress                                               # Breaks :SetAzureVnetAddress
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVnetAddress while ($true)
            $VNetObject = New-AzVirtualNetwork -Name $VNetName -ResourceGroupName `
                $RGObject.ResourceGroupName -Location $LocationObject.location `
                -AddressPrefix $AddressPrefix                                               # Creats the new Vnet
            $OperatorSelect = Read-Host "Add subnets [Y] or [N]"                            # Operator prompt for creating subnets
            if ($OperatorSelect -eq 'y') {                                                  # If $OperatorSelect equals yes
                AddAzVNetSubnetConfig ($VNetObject, $RGObject, $LocationObject)             # Calls function and passes new $VNetObject
            }                                                                               # End if ($OperatorSelect -eq 'y')
            Return $VNetObject                                                              # Returns to calling function with $VNetObject
        }                                                                                   # End :NewAzureVNet while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVirtualNetwork
function ListAzVirtualNetwork {                                                             # Function to list all virtual networks
    Begin {                                                                                 # Begin function
        $VNetList = Get-AzVirtualNetwork                                                    # Gets a list of all virtual networks
        foreach ($_ in $VNetList) {                                                         # For each item in $VNetList
            Write-Host 'Name:    '$_.Name                                                   # Write message to screen
            Write-Host 'RG:      '$_.ResourceGroupName                                      # Write message to screen
            Write-Host 'Loc:     '$_.Location                                               # Write message to screen
            Write-Host 'A Space: '$_.AddressSpace.AddressPrefixes                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
        }                                                                                   # End foreach ($_ in $VNetList)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVirtualNetwork
function GetAzVirtualNetwork {                                                              # Function for getting an Azure virtual network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzVirtualNetwork                                              # pulls all items into list for selection
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' = $_.ResourceGroupName; 'Location' = $_.Location; 'ASpace' = `
                    $_.AddressSpace.AddressPrefixes}                                        # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0  ]    Exit'                                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each name in $ObjectList
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.RG                                                 # Write message to screen
                Write-Host 'Loc:     '$_.Location                                           # Write message to screen
                Write-Host 'A Space: '$_.ASpace                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($Name in $Array)
            :SelectAzureVNet while ($true) {                                                # Inner loop for selecting the Vnet
                $VNetSelect = Read-Host `
                    "Please enter the number of the virtual network"                        # Operator input for the VNet selection
                if ($VNetSelect -eq '0') {                                                  # If $VNetSelect equals 0
                    Break GetAzureVNet                                                      # Breaks :GetAzureVNet
                }                                                                           # End if ($VNetSelect -eq '0')
                elseif ($VNetSelect -in $ObjectArray.Number) {                              # Else if $VNetSelect is in $ObjectArray.Number
                    $VNetSelect = $ObjectArray | Where-Object {$_.Number -eq $VNetSelect}   # $VNetSelect is equal to $ObjectArray where $VNetSelect equals $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $VNetSelect.Name `
                        -ResourceGroupName $VNetSelect.RG                                   # Pulls the full object and assigns to $var
                        Return $VNetObject                                                  # Returns to calling function with $var
                }                                                                           # End elseif ($VNetSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $VNetSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($VNetSelect -eq '0'))
            }                                                                               # End :SelectAzureVNet while ($true)
        }                                                                                   # End :GetAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork
function RemoveAzVirtualNetwork {                                                           # Function to remove an Azure virtual network
    Begin {                                                                                 # Being function
        :RemoveAzureVnet while ($true) {                                                    # Outer loop for managing function
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
                if (!$VNetObject) {                                                         # If $VNetObject is $null
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            Write-Host 'Remove the virtual network named'$VNetObject.Name                   # Write message to screen
            Write-Host 'from the resource group'$VNetObject.ResourceGroupName               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the selected VNet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetwork -Name $VNetObject.Name -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Force -ErrorAction 'Stop'            # Removes the virtual network
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen 
                    Write-Host 'required permissions'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End catch
                Write-Host 'The selected virtual network has been removed'                  # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVirtualNetwork
# Functions for ManageAzVNetSubnetConfig
function ManageAzVNetSubnetConfig {                                                         # Function for managing azure Subnet resources
    Begin {                                                                                 # Begin function   
        :ManageAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if ($VNetObject) {                                                              # If $VnetObject has a value
                Write-Host 'The currently selected Vnet is:'$VNetObject.name                # Write message to screen
            }                                                                               # End if ($VNetObject)
            if ($SubnetObject) {                                                            # If $SubnetObject has a value
                Write-Host 'The currently selected Subnet is:'$SubnetObject.name            # Write message to screen
            }                                                                               # End if ($SubnetObject)
            Write-Host "Azure Subnet Management"                                            # Write message to screen
            Write-Host '0 Clear "$vars"'                                                    # Write message to screen
            Write-Host '1 Add subnet'                                                       # Write message to screen
            Write-Host '2 Get subnet'                                                       # Write message to screen
            Write-Host '3 Remove subnet'                                                    # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzSubnet = Read-Host "Option?"                                           # Collects operator input on $ManageAzSubnet option
            if ($ManageAzSubnet -eq 'exit') {                                               # If $ManageAzSubnet equals 'exit'
                Break ManageAzureSubnet                                                     # Breaks :ManageAzureSubnet
            }                                                                               # End if ($ManageAzSubnet -eq 'exit')
            elseif ($ManageAzSubnet -eq '0') {                                              # Elseif $ManageAzSubnet equals 0
                if ($VNetObject) {                                                          # If $VNetObject has a value
                    Write-Host 'Clearing "$VNetObject'                                      # Write message to screen
                    $VNetObject = $null                                                     # Clears $VNetObject
                }                                                                           # End if ($VNetObject)
                else {                                                                      # If $VNetObject does not have a value
                    Write-Host '$VNetObject is already clear'                               # Write message to screen
                }                                                                           # End else (if ($VnetObject))
                if ($SubnetObject) {                                                        # If $SubnetObject has a value
                    Write-Host 'Clearing "$SubnetObject'                                    # Write message to screen
                    $SubnetObject = $null                                                   # Clears $SubnetObject
                }                                                                           # End if ($SubnetObject)
                else {                                                                      # If $SubnetObject does not have a value
                    Write-Host '$SubnetObject is already clear'                             # Write message to screen
                }                                                                           # End else (if ($SubnetObject))
            }                                                                               # End elseif ($ManageAzSubnet -eq '0')
            elseif ($ManageAzSubnet -eq '1') {                                              # Elseif $ManageAzSubnet equals 1
                Write-Host 'Add subnet'                                                     # Write message to screen
                $SubnetObject = AddAzVNetSubnetConfig ($VNetObject)                         # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzSubnet -eq '1')
            elseif ($ManageAzSubnet -eq '2') {                                              # Elseif $ManageAzSubnet equals 2
                Write-Host 'Get subnet'                                                     # Write message to screen
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzSubnet -eq '2')
            elseif ($ManageAzSubnet -eq '3') {                                              # Elseif $ManageAzSubnet equals 3
                Write-Host 'Remove subnet'                                                  # Write message to screen
                RemoveAzVNetSubnetConfig ($SubnetObject, $VNetObject)                       # Calls function
            }                                                                               # End elseif ($ManageAzSubnet -eq '3')
            else {                                                                          # If $ManageAzSubnet do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzSubnet -eq 'exit'))
        }                                                                                   # End :ManageAzureSubnet while ($true)
        Return $VNetObject, $SubnetObject                                                   # Returns $vars to calling function
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNetSubnetConfig
function AddAzVNetSubnetConfig {                                                            # Function to create a subnet
    begin {                                                                                 # Begin function
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            if (!$VNetObject) {                                                             # if $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $Var
                if (!$VNetObject) {                                                         # if $VNetObject is $null
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                $SubnetName = Read-Host "Subnet name"                                       # Operator input for the subnet name
                if ($SubnetName -eq 'exit') {                                               # If $SubnetName is 'exit'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($SubnetName -eq 'exit')
                $OperatorConfirm = Read-Host `
                    "Set" $SubnetName "as the subnet name [Y] or [N]"                       # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.1.0/24)"              # Operator input for the subnet prefix
                if ($AddressPrefix -eq 'exit') {                                            # If $AddressPrefix equals 'exit'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($AddressPrefix -eq 'exit')
                $OperatorConfirm = Read-Host `
                    "Use" $AddressPrefix "as the subnet address prefix [Y] or [N]"          # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            try {                                                                           # Try the following
                $SubnetObject = Add-AzVirtualNetworkSubnetConfig -Name $SubnetName `
                    -VirtualNetwork $VNetObject -AddressPrefix $AddressPrefix | `
                    Set-AzVirtualNetwork -ErrorAction 'Stop'                                # Creates the new subnet config and adds to $VNetObject
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break AddAzVNetSubnetConfig                                                 # Breaks :AddAzVNetSubnetConfig
            }                                                                               # End catch
            Return $SubnetObject                                                            # Returns to calling function with $var
        }                                                                                   # End :AddAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig
function GetAzVNetSubnetConfig {                                                            # Function to get a subnet
    Begin{                                                                                  # Begin function
        :GetAzureSubnet while ($true) {                                                     # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ListArray = @()                                  # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each $_ in $RGListList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number' = $ListNumber; 'Vnet' = $VNet; 'PFX' = `
                            $_.AddressPrefix; 'VnetPFX' = $VnetPFX; 'RG' = $VNetRG}         # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                }                                                                           # End foreach ($_ in $SubnetList)                                        
            }                                                                               # End foreach ($_ in $VNetList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Sub Name:   '$_.name                                            # Write message to screen
                Write-Host 'Add Prefix: '$_.PFX                                             # Write message to screen
                Write-Host 'VNet Name:  '$_.Vnet                                            # Write message to screen
                Write-Host 'Vnet Prefix:'$_.VnetPFX                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureSubNet while ($true) {                                              # Inner loop for selecting the subnet
                if ($CallingFunction) {                                                     # If $Calling function exists
                    Write-Host 'You are selecting the subnet for'$CallingFunction           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $SubnetSelect = Read-Host 'Enter [#] of the subnet'                         # Operator input for the subnet selection
                if ($SubnetSelect -eq '0') {                                                # If $SubnetSelect equals '0'
                    Break GetAzureSubnet                                                    # Breaks :GetAzureSubnet   
                }                                                                           # End if ($SubnetSelect -eq '0')
                elseif ($SubnetSelect -in $ListArray.Number) {                              # If $SubnetSelect is in $ListArray.Number
                    $SubnetSelect = $ListArray | Where-Object {$_.Number -eq $SubnetSelect} # $Subnet select is equal to object in $ListArray
                    Try {                                                                   # Try the following
                        $VNetObject = Get-AzVirtualNetwork -Name $SubnetSelect.Vnet `
                            -ResourceGroupName $SubnetSelect.RG                             # Pulls the $VnetObject
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                            $VNetObject -Name $SubnetSelect.Name                            # Pulls the $SubnetObject
                    }                                                                       # End Try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureSubnet                                                # Breaks :GetAzureSubnet
                    }                                                                       # End catch   
                    Return $SubnetObject, $VNetObject                                       # Returns to calling function with $SubnetObject and $VNetObject
                }                                                                           # End elseif ($SubnetSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $SubnetSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($SubnetSelect -eq '0'))
            }                                                                               # End :SelectAzureSubNet while ($true)
        }                                                                                   # End :GetAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVNetSubnetConfig
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Call function and assign output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            Write-Host 'Remove the subnet'$SubnetObject.Name                                # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for removing the subnet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Write-Host 'The subnet has been removed'                                    # Write message to screen
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OperatorConfirm -eq 'y') 
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig
# Functions for ManageAzNetworkInterface
function ManageAzNetworkInterface {                                                         # Function for managing azure nic resources
    Begin {                                                                                 # Begin function   
        :ManageAzureNic while ($true) {                                                     # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The currently selected RG is:'$RGObject.ResourceGroupName       # Write message to screen
            }                                                                               # End if ($RGObject)
            if ($SubnetObject) {                                                            # If $SubnetObject has a value
                Write-Host 'The currently selected Subnet is:'$SubnetObject.name            # Write message to screen
            }                                                                               # End if ($SubnetObject)
            if ($NicObject) {                                                               # If $NicObject has a value
                Write-Host 'The currently selected Nic is:'$NicObject.name                  # Write message to screen
            }                                                                               # End if ($NicObject)
            Write-Host "Azure Nic Management"                                               # Write message to screen
            Write-Host '0 Clear "$vars"'                                                    # Write message to screen
            Write-Host '1 Add Nic'                                                          # Write message to screen
            Write-Host '2 Get Nic'                                                          # Write message to screen
            Write-Host '3 Remove Nic'                                                       # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzNic = Read-Host "Option?"                                              # Collects operator input on $ManageAzNic option
            if ($ManageAzNic -eq 'exit') {                                                  # If $ManageAzNic equals 'exit'
                Break ManageAzureNic                                                        # Breaks :ManageAzureNic
            }                                                                               # End if ($ManageAzNic -eq 'exit')
            elseif ($ManageAzNic -eq '0') {                                                 # Elseif $ManageAzNic equals 0
                if ($RGObject) {                                                            # If $RGObject has a value
                    Write-Host 'Clearing "$RGObject'                                        # Write message to screen
                    $RGObject = $null                                                       # Clears $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '$RGObject is already clear'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
                if ($SubnetObject) {                                                        # If $SubnetObject has a value
                    Write-Host 'Clearing "$SubnetObject'                                    # Write message to screen
                    $SubnetObject = $null                                                   # Clears $SubnetObject
                }                                                                           # End if ($SubnetObject)
                else {                                                                      # If $SubnetObject does not have a value
                    Write-Host '$SubnetObject is already clear'                             # Write message to screen
                }                                                                           # End else (if ($subnetObject))
                if ($NicObject) {                                                           # If $NicObject has a value
                    Write-Host 'Clearing "$NicObject'                                       # Write message to screen
                    $NicObject = $null                                                      # Clears $NicObject
                }                                                                           # End if ($NicObject)
                else {                                                                      # If $NicObject does not have a value
                    Write-Host '$NicObject is already clear'                                # Write message to screen
                }                                                                           # End else (if ($NicObject))
            }                                                                               # End elseif ($ManageAzNic -eq '0')
            elseif ($ManageAzNic -eq '1') {                                                 # Elseif $ManageAzNic equals 1
                Write-Host 'Add Nic'                                                        # Write message to screen
                $NicObject = NewAzNetworkInterface ($SubnetObject, $RGobject)               # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNic -eq '1')
            elseif ($ManageAzNic -eq '2') {                                                 # Elseif $ManageAzNic equals 2
                Write-Host 'Get Nic'                                                        # Write message to screen
                $NicObject = GetAzNetworkInterface                                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNic -eq '2')
            elseif ($ManageAzNic -eq '3') {                                                 # Elseif $ManageAzNic equals 3
                Write-Host 'Remove Nic'                                                     # Write message to screen
                RemoveAzNetworkInterface ($NicObject)                                       # Calls function
            }                                                                               # End elseif ($ManageAzNic -eq '3')
            else {                                                                          # If $ManageAzNic do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzNic -eq 'exit'))
        }                                                                                   # End :ManageAzureNic while ($true)
        Return $NicObject                                                                   # Returns $var to calling function
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetworkInterface
function NewAzNetworkInterface {                                                            # Creates a new network interface
    Begin {                                                                                 # Begin function
        :NewAzureNIC while ($true) {                                                        # Outer loop for managing function
            $CallingFunction = 'NewAzNetworkInterface'                                      # Creates $CallingFunction
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$LocationObject)
            }                                                                               # End if (!$LocationObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            :SetAzureNicName while ($true) {                                                # Inner loop for setting the nic name
                $NicName = Read-Host "Nic name"                                             # Operator input for the nic name
                if ($NicName -eq 'exit') {                                                  # If $NicName is 'exit'
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if ($NicName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $NicName "as the Nic name [Y] or [N]"    # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureNicName                                                   # Breaks :SetAzureNicName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureNicName while ($true)
            Try {                                                                           # Try the following
                $NICObject = New-AzNetworkInterface -Name $NicName -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $LocationObject.location `
                    -Subnet $SubnetObject  -ErrorAction 'Stop'                              # Creates the object and assigns to $var
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host "An error has occured"                                           # Write mesage to screen
                Write-Host "You may not have permissions to create this object"             # Write mesage to screen
                Write-Host "The resource group maybe locked"                                # Write mesage to screen
                Write-Host "The name provided may not be valid"                             # Write mesage to screen
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End Catch
            Return $NICObject                                                               # Returns NicObject to calling function
        }                                                                                   # End :NewAzureNIC while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End funciton NewAzNetworkInterface
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ListArray = @()                                  # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ListInput = [PSCustomObject]@{'Number'=$ListNumber;'NicName' `
                            =$_.Name;'NicRG'=$_.ResourceGroupName;'SubName'=$Subnetname; `
                            'SubPFX'=$SubnetPFX;'VNetName'=$VNet;'VnetPFX'=$VnetPFX; `
                            'VnetRG'= $VNetRG}                                              # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Write-Host '[ 0 ]'                                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each item in $List array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'NIC Name:     '$_.NicName                                       # Write message to screen
                Write-Host 'NIC RG:       '$_.NicRG                                         # Write message to screen
                Write-Host 'Subnet Name:  '$_.Subname                                       # Write message to screen
                Write-Host 'Subnet Prefix:'$_.SubPFX                                        # Write message to screen
                Write-Host 'VNet Name:    '$_.VnetName                                      # Write message to screen
                Write-Host 'VNet Prefix:  '$_.VnetPFX                                       # Write message to screen
                Write-Host 'VNet RG:      '$_.VnetRG                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for'$CallingFunction              # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the [#] of the NIC'                      # Operator input for selecting the nic
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ListArray.Number) {                            # If $OperatorSelect in $ListArray.Number
                    $OperatorSelect = $ListArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $OperatorSelect equals $ListArray where $OperatorSelect is equal to $ListArray.Number
                    Try {                                                                   # Try the following
                        $VNet = Get-AzVirtualNetwork -Name $OperatorSelect.VnetName `
                            -ResourceGroupName $OperatorSelect.VNetRG                       # Pulls the $Subnet Vnet
                        $Subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNet `
                            -Name $OperatorSelect.Subname                                   # Pulls the $NicObject subnet
                        $NicObject = Get-AzNetworkInterface -Name $OperatorSelect.NicName |`
                            Where-Object {$_.IpConfigurations.Subnet.ID -eq $Subnet.ID}     # Pulls the full $NicObject
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureNic                                                   # Breaks :GetAzureNic
                    }                                                                       # End Catch
                    Return $NicObject                                                       # Returns $NicObject to calling function
                }                                                                           # End elseif ($OperatorSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface
function RemoveAzNetworkInterface {                                                         # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureNic while ($true) {                                                     # Outer loop for managing function
            if (!$NicObject) {                                                              # If $NicObject does not have a value
                $CallingFunction = 'RemoveAzNetworkInterface'                               # Sets $CallingFunction
                $NicObject = GetAzNetworkInterface ($CallingFunction)                       # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject does not have a value
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End if (!$NicObject)
            }                                                                               # End if (!$NicObject)
            Write-Host 'Remove the network interface named:'$NicObject.name                 # Write message to screen
            Write-Host 'from the resource group:'$NicObject.ResourceGroupName               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Nic
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzNetworkInterface -Name $NicObject.Name -ResourceGroupName `
                        $NicObject.ResourceGroupName -Force -ErrorAction 'Stop'             # Removes the selected NIC
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End catch
                Write-Host 'The selected Nic has been removed'                              # Write message to screen
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # All other inputs for $OperatorConfirm
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End else (If ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNic while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNetworkInterface
# Additional functions required for ManageAzVirtualNetwork
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                          # Generates the load balancer list
            $LoadBalancerNumber = 1                                                         # Sets $LoadBalancerNumber to 1
            [System.Collections.ArrayList]$LoadBalancerArray = @()                          # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                             # For each $Offer in $LoadBalancerList
                $LoadBalancerInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $LoadBalancerNumber;'RGName'=$_.ResourceGroupName}           # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                $LoadBalancerNumber = $LoadBalancerNumber + 1                               # Increments $LoadBalancerNumber by 1
            }                                                                               # End foreach ($_ in $LoadBalancerList)
            Write-Host "0 Exit"                                                             # Write message to screen
            Write-Host ""                                                                   # Write message to screen
            foreach ($_ in $LoadBalancerArray) {                                            # For each $_ in $LoadBalancerArray
                Write-Host $_.Number                                                        # Write message to screen
                Write-Host $_.Name                                                          # Write message to screen
                Write-Host $_.RGName                                                        # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                $OperatorSelect = Read-Host "Enter the load balancer number"                # Operator input for the load balancer selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OperatorSelect -eq '0')
                $LoadBalancerObject = $LoadBalancerArray | Where-Object {$_.Number -eq `
                    $OperatorSelect}                                                        # $LoadBalancerObject is equal to $LoadBalancerArray where $LoadBalancerArray.Number equals $OperatorSelect
                if ($LoadBalancerObject) {                                                  # If $LoadBalancerObject has a value
                    $LoadBalancerObject = Get-AzLoadBalancer -Name `
                        $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.RGName                                          # Repulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End if ($LoadBalancerObject)
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LoadBalancerObject))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer            
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig                               # Calls function and assigns output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $BackEndIPConfigObject = NewAzLBBackendIpConfig                                 # Calls function and assigns output to $var
            if (!$BackEndIPConfigObject) {                                                  # If $BackEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$BackEndIPConfigObject)
            $HealthProbeObject = NewAzLBProbeConfig                                         # Calls function and assigns output to $var
            if (!$HealthProbeObject) {                                                      # If $HealthProbeObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$HealthProbeObject)
            $InboundNatPoolObject = NewAzLBIBNatPoolConfig ($FrontEndIPConfigObject)        # Calls function and assigns output to $var
            if (!$InboundNatPoolObject) {                                                   # If $InboundNatPoolObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$InboundNatPoolObject)
            $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                $BackEndIPConfigObject, $HealthProbeObject)                                 # Calls function and assigns output to $var
            if (!$LoadBalanceRule) {                                                        # If $LoadBalanceRule is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$LoadBalanceRule)
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                $LBNameObject = Read-Host "Load balancer Name"                              # Operator input for the balancer name
                if ($LBNameObject -eq 'exit') {                                             # If $LBNameObject equals $exit
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($LBNameObject -eq 'exit')
                Write-Host $LBNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the balancer name? [Y] or [N]"         # Operator confirmation of the balancer name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBName                                                    # Breaks :SetAzureLBName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBName while ($true)
            $LoadBalancerObject = New-AzLoadBalancer -Name $LBNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -FrontendIpConfiguration $FrontEndIPConfigObject `
                -BackendAddressPool $BackEndIPConfigObject -Probe $HealthProbeObject `
                -LoadBalancingRule $LBRule -InboundNatPool $InboundNatPoolObject            # Creates the load balancer
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                Return $LoadBalancerObject                                                  # Returns $LoadBalancerObject to calling function
            }                                                                               # End if ($LoadBalancerObject)
            else {                                                                          # If $LoadBalancerObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End else(if ($LoadBalancerObject))
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFrontendIpConfig {                                                          # Function to set up the front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :GetAzurePublicIP while ($true) {                                               # Inner loop for getting the public IP
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] New Public IP"                                              # Write message to screen
                Write-Host "[2] Existing public IP"                                         # Write message to screen
                $PublicIPType = Read-Host "[0], [1], or [2]"                                # Operator input for getting the public IP
                if ($PublicIPType -eq '0') {                                                # If $PublicIPType equals '0'
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if ($PublicIPType -eq '0')
                elseif ($PublicIPType -eq '1') {                                            # If $PublicIPType equals 1
                    $PublicIPObject = NewAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '1')
                elseif ($PublicIPType -eq '2') {                                            # If $PublicIPType equals 2
                    $PublicIPObject = GetAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else(if ($PublicIPType -eq '0'))
            }                                                                               # End :GetAzurePublicIP while ($true)
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                $FrontEndNameObject = Read-Host "Front end Name"                            # Operator input for the front end name
                if ($FrontEndNameObject -eq 'exit') {                                       # If $FrontEndNameObject equals $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLBFEIpConfig
                }                                                                           # End if ($FrontEndNameObject -eq 'exit')
                Write-Host $FrontEndNameObject                                              # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the front end name? [Y] or [N]"        # Operator confirmation of the front end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBFEName                                                  # Breaks :SetAzureLBFEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBFEName while ($true)
            $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                $FrontEndNameObject -PublicIpAddress $PublicIPObject                        # Creates the load balancer front end pool
            if ($FrontEndIPConfigObject) {                                                  # If $FrontEndIPConfigObject has a value
                Return $FrontEndIPConfigObject                                              # Returns to calling function with $
            }                                                                               # End if ($FrontEndIPConfigObject)
            else {                                                                          # If $FrontEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End else (if ($FrontEndIPConfigObject))
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFrontendIpConfig
function NewAzPublicIpAddress {                                                             # Creates a new public IP address
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                Try {                                                                       # Try the following
                    [ValidatePattern('^[a-z][a-z0-9-]{1,61}[a-z0-9]$')]$PublicIPNameObject `
                    = [string](Read-Host "Enter the public IP name").ToLower()              # Operator input for the public IP name
                }                                                                           # End try
                catch {                                                                     # Error reporting for try statement
                    Write-Host "! That enty was not valid"                                  # Write message to screen
                    Write-Host "! Valid entries are 1-61 characters"                        # Write message to screen
                    Write-Host "! The name must start with a letter"                        # Write message to screen
                    Write-Host "! Special charaters are not allowed"                        # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End catch
                if ($PublicIPNameObject) {
                    if ($PublicIPNameObject -eq 'exit') {                                   # IF $PublicIPNameObject equals 'exit'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($PublicIPNameObject -eq 'exit')
                    Write-Host $PublicIPNameObject                                          # Write message to screen
                    $OperatorConfirm = Read-Host "Use this name [Y] or [N]"                 # Operator confirmation of the name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If $OperatorConfirm does not equal 'y'
                        Remove-Variable PublicIPNameObject                                  # Removes $PublicIPNameObject
                    }                                                                       # End else if ($OperatorConfirm -eq 'y')
                }                                                                           # End if ($PublicIPNameObject) 
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $PublicIPAllocationObject = Read-Host "[0], [1], or [2]"                    # Operator input for the allocation method
                if ($PublicIPAllocationObject -eq '0') {                                    # If $PublicIPAllocationObject equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($PublicIPAllocationObject -eq '1') {                                # Elseif $PublicIPAllocationObject equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($PublicIPAllocationObject -eq '2') {                                # Elseif $PublicIPAllocationObject equals 2
                    $PublicIPAllocationObject = 'static'                                    # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            $PublicIPObject = New-AzPublicIpAddress -Name $PublicIPNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                -DomainNameLabel $PublicIPNameObject -Force                                 # Creates the new public IP address
            if ($PublicIPObject) {                                                          # If $PublicIPObject is not $null
                Return $PublicIPObject                                                      # Returns to calling function with $PublicIPObject
            }                                                                               # End if ($PublicIPObject)
            else {                                                                          # If $PublicIPObject is $null 
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End else (if ($PublicIPObject))
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for getting an existing public IP address
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            Write-Host "[ 0 ] to exit"                                                      # Write message to screen
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name;'Number' `
                    = $PublicIPNumber;'RG' = $_.ResourceGroupName;'Sku'=$_.Sku.Name `
                ;'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress}           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "["$_.Number"]"                                                  # Write message to screen
                Write-Host "Name "$_.Name                                                   # Write message to screen
                Write-Host "RG:  "$_.RG                                                     # Write message to screen
                Write-Host "Type:"$_.Allocation                                             # Write message to screen
                Write-Host "Add: "$_.address                                                # Write message to screen
                Write-Host "Sku: "$_.Sku                                                    # Write message to screen                            
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                $BackEndNameObject = Read-Host "Back end name"                              # Operator input for the back end name
                if ($BackEndNameObject -eq 'exit') {                                        # If $BackEndNameObject equals $null
                    Break NewAzureLBBEIpConfig                                              # Breaks :NewAzureLBBEIpConfig
                }                                                                           # End if ($BackEndNameObject -eq 'exit')
                Write-Host $BackEndNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the Back end name? [Y] or [N]"         # Operator confirmation of the back end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBBEName                                                  # Breaks :SetAzureLBBEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBBEName while ($true)
            $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                $BackEndNameObject                                                          # Creates the load balancer back end pool
            if ($BackEndIPConfigObject) {                                                   # If $BackEndIPConfigObject has a value
                Return $BackEndIPConfigObject                                               # Returns to calling function with $
            }                                                                               # End if ($BackEndIPConfigObject)
            else {                                                                          # If $BackEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End else (if ($BackEndIPConfigObject))
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {
        :NewAzureLBProbeConfig while ($true) {
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                $ProbeNameObject = Read-Host "Probe Name"                                   # Operator input for the probe name
                if ($ProbeNameObject -eq 'exit') {                                          # If $ProbeNameObject equals $null
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig
                }                                                                           # End if ($ProbeNameObject -eq 'exit')
                Write-Host $ProbeNameObject                                                 # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the probe name? [Y] or [N]"            # Operator confirmation of the probe name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureProbeName                                                 # Breaks :SetAzureProbeName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                $ProbeTypeObject = Read-Host '[0], [1], or [2]'                             # Operator input for the probe type object
                if ($ProbeTypeObject -eq '0') {                                             # If $ProbeTypeObject equals 0
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($ProbeTypeObject -eq '0')
                elseif ($ProbeTypeObject -eq '1') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '1')
                elseif ($ProbeTypeObject -eq '2') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '2')
                else {                                                                      # All other inputs 
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else 
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Try {                                                                       # Try the following
                    [int]$ProbeIntervalObject = Read-Host "Probe interval in seconds"       # Operator input for the probe interval
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeIntervalObject -le 0) {                                           # If $ProbeIntervalObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeIntervalObject -le 0) 
                elseif ($ProbeIntervalObject -ge 1) {                                       # If $ProbeIntervalObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe interval will be set at' `
                    $ProbeIntervalObject 'seconds [Y] or [N]'                               # Operator confirmation of the probe interval
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeIntervalObject -ge 1)
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Try {                                                                       # Try the following
                    [int]$ProbeCountObject = Read-Host "Probe count"                        # Operator input for the probe count
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeCountObject -le 0) {                                              # If $ProbeCountObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeCountObject -le 0) 
                elseif ($ProbeCountObject -ge 1) {                                          # If $ProbeCountObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe count will be set at' `
                    $ProbeCountObject  '[Y] or [N]'                                         # Operator confirmation of the probe count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeCountObject -ge 1)
            }                                                                               # End :SetAzureProbeCount while ($true)
            $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                -ProbeCount $ProbeCountObject                                               # Creates the Health probe object
            if ($HealthProbeObject) {                                                       # If $HealthProbeObject has a value
                Return $HealthProbeObject                                                   # Returns $HealthProbeObject to calling function
            }                                                                               # End if ($HealthProbeObject)
            else {                                                                          # If $HealthProbeObject does not have a value
                Write-Host "An error has occured while setting the probe"                   # Write message to screen
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End else (if ($HealthProbeObject))
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig
function NewAzLBIBNatPoolConfig {                                                           # Creates inbound pool configuration for load balancer
    begin {                                                                                 # Begin function
        :NewAzureLBIBNatPoolConfig while ($true) {                                          # Outer loop for managing function
            :NewAzureLBIBNatPoolName while ($true) {                                        # Inner loop for setting the nat pool name
                $NatPoolNameObject = Read-Host "Pool Name"                                  # Operator input for the pool name
                if ($NatPoolNameObject -eq 'exit') {                                        # If $NatPoolNameObject equals $null
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolNameObject -eq 'exit')
                Write-Host $NatPoolNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the pool name? [Y] or [N]"             # Operator confirmation of the pool name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBIBNatPoolName                                           # Breaks :NewAzureLBIBNatPoolName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBIBNatPoolName while ($true) {
            :NewAzureLBIBNPProtocol while ($true) {                                         # Inner loop for setting the nat pool protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $NatPoolProtocolObject = Read-Host '[0], [1], or [2]'                       # Operator input for the protocol object
                if ($NatPoolProtocolObject -eq '0') {                                       # If $NatPoolProtocolObject equals '0'
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolProtocolObject -eq '0')
                elseif ($NatPoolProtocolObject -eq '1') {                                   # If $NatPoolProtocolObject equals '1'
                    $NatPoolProtocolObject = 'TCP'                                          # Sets $NatPoolProtocolObject to 'TCP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '1')
                elseif ($NatPoolProtocolObject -eq '2') {                                   # If $NatPoolProtocolObject equals '2'
                    $NatPoolProtocolObject = 'UDP'                                          # Sets $NatPoolProtocolObject to 'UDP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($NatPoolProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBIBNPProtocol while ($true)
            :NewAzureLBFEPortStart while ($true) {                                          # Inner loop for setting the front end port range start
                Try {                                                                       # Try the following
                    [int]$FrontEndPortStart = Read-Host "Pool front end port start"         # Operator input for the front end port start
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortStart -le 0) {                                             # If $FrontEndPortStart is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortStart -le 0) 
                elseif ($FrontEndPortStart -ge 1) {                                         # If $FrontEndPortStart is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port start will be' `
                    $FrontEndPortStart '[Y], [N], or [E] to exit'                           # Operator confirmation of the front end port start
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortStart                                         # Breaks :NewAzureLBFEPortStart        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortStart -ge 1)
            }                                                                               # End :NewAzureLBFEPortStart while ($true)
            :NewAzureLBFEPortEnd while ($true) {                                            # Inner loop for setting the front end port range end
                Try {                                                                       # Try the following
                    [int]$FrontEndPortEnd = Read-Host "Pool front end port end"             # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortEnd -le 0) {                                               # If $FrontEndPortEnd is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortEnd -le 0) 
                elseif ($FrontEndPortEnd -ge 1) {                                           # If $FrontEndPortEnd is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port end will be' `
                    $FrontEndPortEnd '[Y], [N], or [E] to exit'                             # Operator confirmation of the front end port end
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortEnd                                           # Breaks :NewAzureLBFEPortEnd        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortEnd -ge 1)
            }                                                                               # End :NewAzureLBFEPortEnd while ($true)
            :NewAzureLBBEPort while ($true) {                                               # Inner loop for setting the back end port
                Try {                                                                       # Try the following
                    [int]$BackEndPort = Read-Host "Pool Back end port"                      # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($BackEndPort -le 0) {                                                   # If $BackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($BackEndPort -le 0) 
                elseif ($BackEndPort -ge 1) {                                               # If $BackEndPort is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $BackEndPort '[Y], [N], or [E] to exit'                                 # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBBEPort                                              # Breaks :NewAzureLBBEPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($BackEndPort -ge 1)
            }                                                                               # End :NewAzureLBBEPort while ($true)
            
            $InboundNatPoolObject = New-AzLoadBalancerInboundNatPoolConfig -Name `
                $NatPoolNameObject -FrontendIpConfigurationId $FrontEndIPConfigObject.ID `
                -Protocol $NatPoolProtocolObject -FrontendPortRangeStart $FrontEndPortStart `
                -FrontendPortRangeEnd $FrontEndPortEnd -BackendPort $BackEndPort            # Creates the inbound pool object
            if ($InboundNatPoolObject) {                                                    # If $InboundNatPoolObject has a value
                Return $InboundNatPoolObject                                                # Returns $InboundNatPoolObject to calling function
            }                                                                               # End if ($InboundNatPoolObject)
            else {                                                                          # If $InboundNatPoolObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBIBNatPoolConfig                                             # Breaks :NewAzureLBIBNatPoolConfig
            }                                                                               # End else (if ($InboundNatPoolObject))
        }                                                                                   # End :NewAzureLBIBNatPoolConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBInboundNatPoolConfig
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                $LBRuleNameObject = Read-Host "Rule Name"                                   # Operator input for the pool name
                if ($LBRuleNameObject -eq 'exit') {                                         # If $LBRuleNameObject equals $null
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleNameObject -eq 'exit')
                Write-Host $LBRuleNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the rule name? [Y] or [N]"             # Operator confirmation of the rule name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBRCName                                                  # Breaks :NewAzureLBRCName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $LBRuleProtocolObject = Read-Host '[0], [1], or [2]'                        # Operator input for the protocol object
                if ($LBRuleProtocolObject -eq '0') {                                        # If $LBRuleProtocolObject equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleProtocolObject -eq '0')
                elseif ($LBRuleProtocolObject -eq '1') {                                    # If $LBRuleProtocolObject equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '1')
                elseif ($LBRuleProtocolObject -eq '2') {                                    # If $LBRuleProtocolObject equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($LBRuleProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Try {                                                                       # Try the following
                    [int]$LBRuleFrontEndPort = Read-Host "Rule front end port"              # Operator input for the front end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleFrontEndPort -le 0) {                                            # If $LBRuleFrontEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleFrontEndPort -le 0) 
                elseif ($LBRuleFrontEndPort -ge 1) {                                        # If $LBRuleFrontEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Front end port will be' `
                    $LBRuleFrontEndPort '[Y], [N], or [E] to exit'                          # Operator confirmation of the front end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleFrontEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Try {                                                                       # Try the following
                    [int]$LBRuleBackEndPort = Read-Host "Rule back end port"                # Operator input for the back end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleBackEndPort -le 0) {                                             # If $LBRuleBackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleBackEndPort -le 0) 
                elseif ($LBRuleBackEndPort -ge 1) {                                         # If $LBRuleBackEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $LBRuleBackEndPort '[Y], [N], or [E] to exit'                           # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleBackEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Try {                                                                       # Try the following
                    [int]$LBRuleIdleTO = Read-Host "Rule idle time out"                     # Operator input for the rule idle timeout
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleIdleTO -le 0) {                                                  # If $LBRuleIdleTO is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleIdleTO -le 0) 
                elseif ($LBRuleIdleTO -ge 1) {                                              # If $LBRuleIdleTO is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Load balancer idle timeout will be' `
                    $LBRuleIdleTO '[Y], [N], or [E] to exit'                                # Operator confirmation of the rule idle timeout
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleIdleTO -ge 1)
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO -EnableFloatingIP `
                -LoadDistribution SourceIP                                                  # Creates the load balancer rule
            if ($LoadBalanceRule) {                                                         # If $LoadBalanceRule has a value
                Return $LoadBalanceRule                                                     # Returns to calling function with $LoadBalanceRule
            }                                                                               # End if ($LoadBalanceRule)
            else {                                                                          # If $LoadBalanceRule does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzLBRuleConfig                                                     # Breaks :NewAzLBRuleConfig     
            }                                                                               # End else (if ($LoadBalanceRule))
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig
# End Manage Network