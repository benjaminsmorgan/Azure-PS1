# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.1.0
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
} #>
<# Required Functions Links: {
    ManageAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ManageAzResourceGroup.ps1
        NewAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/NewAzResourceGroup.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        ListAzRGResources:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ListAzRGResources.ps1
        RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/RemoveAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
        GetAzRGLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRGLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    SearchAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroup.ps1
        SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupName.ps1
        SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupType.ps1
        SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupLoc.ps1
        SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupTag.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
        SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceLoc.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceTag.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceType.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    ManageAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/ManageAzResource.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
        ListAzResources:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/ListAzResources.ps1
        RemoveAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/RemoveAzResource.ps1
        GetAzRSLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRSLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    SearchAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResource.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
        SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    ManageAzLocks:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ManageAzLocks.ps1
        NewAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceGroupLock.ps1
        GetAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLock.ps1
        ListAzResourceGroupLocks:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ListAzResourceGroupLocks.ps1
        RemoveAzResourceGroupLock:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceGroupLock.ps1
        NewAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceLock.ps1
        GetAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLock.ps1  
        ListAzResourceLocks:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ListAzResourceLocks.ps1
        RemoveAzResourceLock:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLock.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
    ManageAZTags:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ManageAzTags.ps1
        AddAzRGTag:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzRGTag.ps1
        AddAzRSTag:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzRSTag.ps1
        ListAzRGTags:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ListAzRGTags.ps1
        ListAzRSTags:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ListAzRSTags.ps1
        RemoveAzRGTag:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRGTag.ps1
        RemoveAzRSTag:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRSTag.ps1
        RemoveAzRGTags:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRGTags.ps1
        RemoveAzRSTags:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRSTags.ps1
        SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    ManageAzResourceGroup:      Manages a resource group 
        NewAzResourceGroup:         Creates a resource group object
        GetAzResourceGroup:         Gets resource group from full name match
        ListAzRGResources:          Lists all resources within a resource group    
        RemoveAzResourceGroup:      Removes a resource group object
        GetRGLocksAll:              Gets all locks on a resource group 
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup functions
        SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
        SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
        SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
        SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
    ManageAzResource:           Manages a resource 
        GetAzResource:              Gets resource
        ListAzResources:            Lists all resources within a resource group    
        RemoveAzResource:           Removes a resource object
        GetRSLocksAll:              Gets all locks on a resource
    SearchAzResource:           Management function for all SearchAzResource functions
        SearchAzResource:           Management function for all SearchAzResource functions
        SearchAzResourceType:       Searches for resource using resource provider or type on a resource or resource
        SearchAzResourceLoc:        Searches for resource using location matches on a resource
        SearchAzResourceTag:        Searches for resource using tag matches on a resource
    ManageAzLocks:              Management function for Locks functions
        NewAzResourceGroupLock:     Create a new resource lock on a resource group
        GetAzResourceGroupLock:     Collects a lock on a resource group
        ListAzResourceGroupLocks:   Lists all locks on a resource group
        RemoveAzResourceGroupLock:  Gets a resource group lock and sends it to RemoveAzResourceLocks
        NewAzResourceLock:          Create a new resource lock on a resource
        GetAzResourceLock:          Collects a lock on a resource   
        ListAzResourceLocks:        Lists all locks on a resource
        RemoveAzResourceLock:       Gets a resource lock and sends it to RemoveAzResourceLocks
        RemoveAzResourceLocks:      Removes all $Locks 
    ManageAZTags:               Management function for all tags
        AddAzRGTag:                 Adds a new tag to a resource group
        AddAzRSTag:                 Adds a new tag to a resource 
        ListAzRGTags:               Lists all tags on a resource group
        ListAzRSTags:               Lists all tags on a resource
        RemoveAzRGTag:              Removes a tag on a resource group
        RemoveAzRSTag:              Removes a tag on a resource
        RemoveAzRGTags:             Removes all tags on a resource group
        RemoveAzRSTags:             Removes all tags on a resource 
        SetAzTagPair:               Creates a list of tags to apply to a resource or group
        GetAzResourceGroup:         Collects a resource group
        GetAzResource:              Collects a resource
    GetAzLocation:              Gets a list of azure locations
} #>
<# Variables: {
    :ManageAzureRG              Outer loop for managing function
    $RGObject:                  Resource group object
    $RSObject:                  Resource object
    $OpSelect:                Operator input for search option
    ManagageAzResourceGroup{}   Manages $RGObject
        NewAzResourceGroup{}            Creates $RGObject
            GetAzLocation{}                 Gets $LocationObject
        GetAzResourceGroup{}            Gets $RGObject
        ListAzRGResources{}             Lists $RSObjects
            GetAzResourceGroup{}            Gets $RGObject
        RemoveAzResourceGroup{}         Removes $RGObject
            GetAzResourceGroup{}            Gets $RGObject
            GetAzRGLocksAll{}               Gets $Locks
            RemoveAzResourceLocks{}         Gets $LocksRemoved
    SearchAzResourceGroup{}     Gets $RGObject
        SearchAzResourceGroupName{} Gets $RGObject
            GetAzResource{}             Gets $RSObject
            GetAzResourceGroup{}        Gets $RGObject
        SearchAzResourceGroupType{} Gets $RGObject
            SearchAzResourceType{}      Gets $RSObject
        SearchAzResourceGroupLoc{}  Gets $RGObject
            SearchAzResourceLoc{}       Gets $RSObject
                GetAzLocation{}             Gets $LocationObject
            GetAzLocation{}             Gets $LocationObject
        SearchAzResourceGroupTag{}  Gets $RGObject
            SearchAzResourceTag{}       Gets $RSObject
    ManageAzResource{}          Manages $RSObject
        GetAzResource{}            Gets $RSObject
        ListAzResources{}             Lists $RSObjects
        RemoveAzResource{}         Removes $RSObject
            GetAzResource{}            Gets $RSObject
            GetAzRGLocksAll{}               Gets $Locks
            RemoveAzResourceLocks{}         Gets $LocksRemoved
    SearchAzResource{}          Gets $RSObject
        SearchAzResourceType{}      Gets $RSObject
        SearchAzResourceLoc{}       Gets $RSObject
            GetAzLocation{}             Gets $LocationObject
        SearchAzResourceTag{}       Gets $RSObject
    ManageAzLocks{}             Manages $Locks
        NewAzResourceGroupLock{}    Gets $Locks
            GetAzResourceGroup{}        Gets $RGObject
        GetAzResourceGroupLock{}    Gets $Locks
            GetAzResourceGroup{}        Gets $RGObject
        ListAzResourceGroupLocks{}  Gets $null
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzResourceGroupLock{} Gets $null
            GetAzResourceGroupLock{}    Gets $Locks
                GetAzResourceGroup{}        Gets $RGObject
            RemoveAzResourceLocks{}     Gets $LocksRemoved
        NewAzResourceLock{}         Gets $Locks
            GetAzResource{}             Gets RSObject
        GetAzResourceLock{}         Gets $Locks
            GetAzResource{}             Gets $RSObject
        ListAzResourceLocks{}       Gets $null
            GetAzResource{}             Gets $RSObject
        RemoveAzResourceLock{}      Gets $null
            GetAzResourceLock{}         Gets $Locks
            RemoveAzResourceLocks{}         Gets $LocksRemoved
    ManageAzTags{}              Manages Tags
        AddAzRGTag{}                Gets $null
            GetAzResourceGroup{}        Gets $RGObject
            SetAzTagPair                Gets $TagArray
        AddAzRSTag{}                Gets $null
            GetAzResource{}             Gets $RSObject
            SetAzTagPair                Gets $TagArray
        ListAzRGTags{}              Gets $null
            GetAzResourceGroup{}        Gets $RGObject
        ListAzRSTags{}              Gets $null
            GetAzResource{}             Gets $RSObject
        RemoveAzRGTag{}             Gets $null
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzRSTag{}             Gets $null
            GetAzResource{}             Gets $RSObject
        RemoveAzRGTags{}            Gets $null
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzRSTags{}            Gets $null
            GetAzResource{}             Gets $RSObject        
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroups > Get $null
            Call ManageAzResourceGroup > Get $RGObject
                Call NewAzResourceGroup > Get $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzResourceGroup > Send $LocationObject
                End NewAzResourceGroup
                    Return ManageAzResourceGroup > Send $RGObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return ManageAzResourceGroup > Send $RGObject
                Call ListAzRGResources > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return ListAzRGResources > Send $RGObject
                End ListAzRGResources
                    Return ManageAzResourceGroup > Send $null
                Call RemoveAzResourceGroup > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return RemoveAzResourceGroup > Send $RGObject
                    Call function GetAzRGLocksAll > Get $Locks
                    End GetAzRGLocksAll
                        Return RemoveAzResourceGroup > Send $Locks
                    Call Function RemoveAzResourceLocks > Get $LocksRemoved
                    End RemoveAzResourceLocks
                        Return RemoveAzResourceGroup > Send $LocksRemoved
                End RemoveAzResourceGroup
                    Return ManageAzResourceGroup > Send $null
            End Function ManageAzResourceGroup
                    Return ManageAzResourceGroups > Send $RGObject 
            Call SearchAzResourceGroup > Get $RGObject
                Call SearchAzResourceGroupName > Get $RGObject
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return SearchAzResourceGroupName > Send $RSObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup    
                        Return SearchAzResourceGroupName > Send $RGObject
                End SearchAzResourceGroupName
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupType > Get $RGObject
                    Call SearchAzResourceType > Get $RSObject
                    End SearchAzResourceType
                        Return SearchAzResourceGroupType > Send $RSObject
                End SearchAzResourceGroupType
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupLoc > Get $RGObject
                    Call SearchAzResourceLoc > Get $RSObject
                        Call GetAzLocation > Get $LocationObject
                        End GetAzLocation
                            Return SearchAzResourceLoc > Send $LocationObject
                    End SearchAzResourcLoc
                        Return SearchAzResourceGroupLoc > Send $RSObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return SearchAzResourceGroupLoc > Send $LocationObject
                End SearchAzResourceGroupLoc
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupTag > Get $RGObject
                    Call SearchAzResourceTag  > Get $RSObject
                    End SearchAzResourceTag
                        Return SearchAzResourceGroupTag > Send $RSObject
                End SearchAzResourceGroupTag
                    Return SearchAzResourceGroup > Send $RGObject
            End SearchAzResourceGroup
                Return ManageAzResourceGroups > Send $RGObject    
            Call ManageAzResource
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return ManageAzResource > Send $RSObject
                Call ListAzResources > Get $null
                End ListAzResources
                    Return ManageAzResource > Send $null
                Call RemoveAzResource > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return RemoveAzResource > Send $RSObject
                    Call GetAzRGLocksAll > Get $Locks
                    End GetAzRGLocksAll
                        Return RemoveAzResource > Send $Locks
                    Call RemoveAzResourceLocks > Get $LocksRemoved
                    End RemoveAzResourceLocks
                        Return RemoveAzResource > Send $LocksRemoved
                End RemoveAzResource
                    Return ManageAzResource > Send $null
            End  ManageAzResource
                    Return ManageAzResourceGroups > Send $RSObject  
            Call SearchAzResource > Get $RSObject
                Call SearchAzResourceType > Get $RSObject
                End SearchAzResourceType
                    Return SearchAzResource > Send $RSObject                
                Call SearchAzResourceLoc  > Get $RSObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return SearchAzResourceLoc > Send $LocationObject
                End SearchAzResourceLoc
                    Return SearchAzResource > Send $RSObject
                Call SearchAzResourceTag  > Get $RSObject
                End SearchAzResourceTag
                    Return SearchAzResource > Send $RSObject
            End SearchAzResource
                Return ManageAzResourceGroups > Send $RSObject
            Call ManageAzLocks > Get $Locks
                Call NewAzResourceGroupLock > Get $Locks
                    Call GetAzResourceGroup > Get RGObject
                    End GetAzResourceGroup
                        Return NewAzResourceGroupLock > Send $RGObject
                    End NewAzResourceGroupLock
                        Return ManageAzLocks > Send $Locks
                Call GetAzResourceGroupLock > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzResourceGroupLock > Send $RGObject
                End GetAzResourceGroupLock
                    Return ManageAzLocks > Send $Locks 
                Call ListAzResourceGroupLocks > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return ListAzResourceGroupLocks > Send $RGObject
                End ListAzResourceGroupLocks
                    Return ManageAzLocks > Send $null    
                Call RemoveAzResourceGroupLock > Get $null
                    Call GetAzResourceGroupLock > Get $Locks
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzResourceGroupLock > Send $RGObject
                    End GetAzResourceGroupLock
                        Return RemoveAzResourceGroupLock > Send $Locks 
                    Call RemoveAzResourceLocks > Get $LocksRemoved
                    End RemoveAzResourceLocks
                        Return RemoveAzResourceGroupLock > Send $LocksRemoved
                End RemoveAzResourceGroupLock
                    Return ManageAzLocks > Send $null
                Call NewAzResourceLock > Get $Locks
                    Call GetAzResource > Get RSObject
                    End GetAzResource
                        Return NewAzResourceLock > Send $RSObject    
                End NewAzResourceLock
                        Return ManageAzLocks > Send $Locks
                Call GetAzResourceLock > Get $Locks
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return GetAzResourceLock > Send $RSObject
                End GetAzResourceLock
                    Return ManageAzLocks > Send $Locks
                Call ListAzResourceLocks > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return ListAzResourceLocks > Send $RSObject
                End ListAzResourceLocks
                    Return ManageAzLocks > Send $null
                Call RemoveAzResourceLock > Get $null
                    Call GetAzResourceLock > Get $Locks
                        Call GetAzResource > Get $RSObject
                        End GetAzResource
                            Return GetAzResourceLock > Send $RSObject
                    End GetAzResourceLock
                        Return RemoveAzResourceLock > Send $Locks 
                    Call RemoveAzResourceLocks > Get $LocksRemoved
                    End RemoveAzResourceLocks
                        Return RemoveAzResourceLock > Send $LocksRemoved
                End RemoveAzResourceLock
                    Return ManageAzLocks > Send $null
            End ManageAzLocks
                Return function > Send $Locks
            Call ManageAzTags > Get $null
                Call AddAzRGTag > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return AddAzRGTag > Send $RGObject
                    Call SetAzTagPair > Get $TagArray
                    End SetAzTagPair
                        Return AddAzRGTag > Send $TagArray
                End AddAzRGTag
                    Return ManageAzTags > Send $null
                Call AddAzRSTag > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return AddAzRSTag > Send $RSObject
                    Call SetAzTagPair > Get $TagArray
                    End SetAzTagPair
                        Return AddAzRSTag > Send $TagArray
                End AddAzRSTag
                    Return ManageAzTags > Send $null
                Call ListAzRGTags > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return ListAzRGTags > Send $RGObject
                End ListAzRGTags
                    Return ManageAzTags > Send $null
                Call ListAzRSTags > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return ListAzRSTags > Send $RSObject
                End ListAzRSTags
                    Return ManageAzTags > Send $null                
                Call RemoveAzRGTag > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return RemoveAzRGTag > Send $RGObject
                End RemoveAzRGTag
                    Return ManageAzTags > Send $null
                Call RemoveAzRSTag > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return RemoveAzRSTag > Send $RSObject
                End RemoveAzRSTag
                    Return ManageAzTags > Send $null
                Call RemoveAzRGTags > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return RemoveAzRGTags > Send $RGObject
                End RemoveAzRGTags
                    Return ManageAzTags > Send $null
                Call RemoveAzRSTags > Get $null
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return RemoveAzRSTags > Send $RSObject
                End RemoveAzRSTags
                    Return ManageAzTags > Send $null
            End ManageAzTags
                Return Function > Send $null                
        End ManageAzResourceGroups
            Return function > Send $null
}#> 
function ManageAzResourceGroups {                                                           # Function to manage resource groups
    Begin {                                                                                 # Begin function
        :ManageAzureRG while($true) {                                                       # Outer loop for managing function
            Write-Host 'Resource Group Management'                                          # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Manage Resource Group'                                          # Write message to screen
            Write-Host '[2] Search For Resource Group'                                      # Write message to screen
            Write-Host '[3] Manage Resource'                                                # Write message to screen 
            Write-Host '[4] Search For Resource'                                            # Write message to screen
            Write-Host '[5] Manage Locks'                                                   # Write message to screen
            Write-Host '[6] Manage Tags'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals 'exit'
                Break ManageAzureRG                                                         # Breaks :ManageAzureRG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Manage Resource Group'                                          # Write message to screen
                ManageAzResourceGroup                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Search For Resource Group'                                      # Write message to screen
                SearchAzResourceGroup                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Manage Resource'                                                # Write message to screen
                ManageAzResource                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Search For Resource'                                            # Write message to screen
                SearchAzResource                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Locks'                                                   # Write message to screen
                ManageAzLocks                                                               # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Manage Tags'                                                    # Write message to screen    
                ManageAzTags                                                                # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for ManageAzRG
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzResourceGroup while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResourceGroups

# 1_1_0_0 Manage Resource Groups 28NOV22
function ManageAzResourceGroup {                                                            # Function to manage resource groups
    Begin {                                                                                 # Begin function
        :ManageAzureRG while($true) {                                                       # Outer loop for managing function
            Write-Host 'Manage A Resource Group'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Resource Group'                                             # Write message to screen
            Write-Host '[2] List Resource Groups'                                           # Write message to screen
            Write-Host '[3] List Resources in Group'                                        # Write message to screen
            Write-Host '[4] Remove Resource Group'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureRG                                                         # Breaks :ManageAzureRG
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Resource Group'                                             # Write message to screen
                NewAzResourceGroup                                                          # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Resource Groups'                                           # Write message to screen
                ListAzResourceGroup                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Resources in Group'                                        # Write message to screen
                ListAzRGResources                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Resource Group'                                          # Write message to screen
                RemoveAzResourceGroup                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for ManageAzRG
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResourceGroup
# 1_1_1_0 NewAzResourceGroup 28NOV22
function NewAzResourceGroup {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzResourceGroup'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureRGObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $CurrentRGNames = Get-AzResourceGroup | Select-Object ResourceGroupName         # Gets a list of all currently existing names
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                Write-Host 'Enter a resource group name'                                    # Write message to screen
                $RGObjectInput = Read-Host 'Name'                                           # Operator input for the resource group name
                Clear-Host                                                                  # Clears screen
                if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName) {                 # If $RGObjectInput is in $CurrentRGNames.ResourceGroupName
                    Write-Host $RGObjectInput 'is currently in use'                         # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $RGObjectInput = $null                                                  # Clears $RGObjectInput
                }                                                                           # End if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName)
                if ($RGObjectInput -eq 'exit') {                                            # If $RGObjectInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($RGObjectInput -eq 'exit') 
                if ($RGObjectInput) {                                                       # If $RGObjectInput has a value
                    Write-Host 'The new resource group will be called:'$RGObjectInput       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation that the name is correct
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureName                                                  # Break :SetAzureName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureRGObject                                              # Breaks :NewAzrueRGObject
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($RGObjectInput)
            }                                                                               # End :SetAzureName while ($true)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject
            }                                                                               # End if (!$LocationObject)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                Write-Host 'Enter a tag name'                                               # Write message to screen
                Write-Host 'Leave blank to create the'                                      # Write message to screen
                Write-Host 'resource group without tags'                                    # Write message to screen
                $TagNameInput = Read-Host 'Tag name'                                        # Operator input for a tag name
                Clear-Host                                                                  # Clears screen
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                Write-Host 'Enter the tag value for:'$TagNameInput                          # Write message to screen
                $TagValueInput = Read-Host 'Tag value'                                      # Operator input for the tag value
                Clear-Host                                                                  # Clears screen
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource group'                       # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation that tag info is correct
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureTag while ($true)
            Try {                                                                           # Try the following
                if ($Tag) {                                                                 # If $Tag has a value        
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End if ($Tag)
                else {                                                                      # If $Tag is $null
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End else (if ($Tag))
            }                                                                               # End Try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears Screen
            Write-Host 'The resource group has been created'                                # Write message to screen
            Pause                                                                           # Pauses all actions for operator input 
            Break NewAzureRGObject                                                          # Breaks :NewAzureRGObject  
        }                                                                                   # End :NewAzureRGObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup
# 1_1_2_0 ListAzResourceGroup 28NOV22
function ListAzResourceGroup {                                                              # Function to list all resource groups
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :ListAzureResourceGroup while ($true) {                                             # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No resource groups in this subscription'                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureResourceGroup                                                # Breaks :ListAzureResourceGroup    
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectListArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # PSCustom object to load items into array
                    'Name'=$_.ResourceGroupName;'Location'=$_.Location;'Tags'=$_.Tags}      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Name:      '$_.Name                                             # Write message to screen
                Write-Host 'Location   '$_.Location                                         # Write message to screen
                Write-Host 'Tag Names: '$_.Tags.Keys                                        # Write message to screen
                Write-Host 'Tag Values:'$_.Tags.Values                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureResourceGroup                                                    # Breaks :ListAzureResourceGroup
        }                                                                                   # End :ListAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroup
# 1_1_3_0 ListAzRGResources 28NOV22
function ListAzRGResources {                                                                # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureRGResources while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'ListAzRGResources'                                      # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break ListAzureRGResources                                              # Breaks :ListAzureRGResources
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $RSList = Get-AzResource | Where-Object `
                {$_.ResourceGroupName -eq $RGObject.ResourceGroupName}                      # Creates a list of all resources within $RGObject
            if (!$RSList) {                                                                 # If $RSList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No resources in resource group'$RGObject.ResourceGroupName      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End if (!$RSList)
            else {                                                                          # If $RSList has a value
                Write-Host ''                                                               # Write message to screen
                Write-Host `
                    'There are'$RSList.Count'resources in'$RGObject.ResourceGroupName       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $RSList) {                                                   # For each item in $RSList
                    Write-Host 'Name:'$_.Name                                               # Write message to screen
                    Write-Host 'Loc: '$_.Location                                           # Write message to screen
                    Write-Host 'Type:'$_.ResourceType                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $RSList)
                Pause                                                                       # Pauses for operator input
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End else (End if (!$RSList))
        }                                                                                   # End :ListAzureRGResources while ($true)
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzRGResources
# 1_1_4_0 RemoveAzResourceGroup 28NOV22
function RemoveAzResourceGroup {                                                            # Function to remove a resource group
    Begin {                                                                                 # Begin funciton
        :RemoveAzureRGObject while ($true) {                                                # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'RemoveAzResourceGroup'                                  # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            Write-Host '////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host ' This will delete:'$RGObject.ResourceGroupName                      # Write message to screen
            Write-Host ' This action cannot be undone once completed'                       # Write message to screen
            Write-Host ' All resource locks will be removed automatically if confirmed '    # Write message to screen
            Write-Host ' All resources within the resource group will also be deleted  '    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource group'                                         # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator input on confirming deletion of the resource group
            Clear-Host                                                                      # Clears screen
            $RGObjectName = $RGObject.ResourceGroupName                                     # Collects the name of the resource group for later use
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                    Write-Host 'Checking for locks on:'$RGObjectName                        # Write message to screen
                $Locks = GetAzRGLocksAll ($RGObject)                                        # Calls function and assigns output to $vat
                if ($Locks) {                                                               # If $Locks has a value
                    Write-Host 'Removing all locks'                                         # Write message to screen
                    $LocksRemoved = RemoveAzResourceLocks ($Locks)                          # Calls function and assigns output to $var
                    if ($LocksRemoved -eq 'n') {                                            # If $LocksRemoved equals 'n'
                        Break RemoveAzureRGObject                                           # Breaks :RemoveAzureRGObject
                    }                                                                       # End if ($LocksRemoved -eq 'n')
                    Write-Host 'All Locks removed'                                          # Write message to screen
                }                                                                           # End if ($Locks)
                else {                                                                      # If $Locks does not have a value
                    Write-Host 'No locks on this resource group'                            # Write message to screen
                }                                                                           # End if ($Locks)
                Write-Host $RGObject.ResourceGroupName'is being removed'                    # Write message to screen
                Write-Host 'this may take a while'                                          # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the resource group
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject    
                }                                                                           # End Catch
                Write-Host $RGObjectName'has been removed'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Break RemoveAzureRGObject
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Breaks :RemoveAzureRGObject
            }                                                                               # End else (if ($OpConfirm -eq 'y')
            
        }                                                                                   # End :RemoveAzureRGObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup
# 1_1_G_0 GetAzResourceGroup 28NOV22
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
# End 1_1_0_0 Manage Resource Groups
# 1_2_0_0 Manage Resources 28NOV22
function ManageAzResource {                                                                 # Function to manage resource
    Begin {                                                                                 # Begin function
        :ManageAzureSG while($true) {                                                       # Outer loop for managing function
            Write-Host 'Manage Resources'                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] List Resources by Group'                                        # Write message to screen
            Write-Host '[2] Remove Resource'                                                # Write message to screen
            $ManageAzRS = Read-Host 'Option [#]'                                            # Operator input for selecting management function
            if ($ManageAzRS -eq '0') {                                                      # If $ManageAzRS equals '0'
                Break ManageAzureSG                                                         # Breaks :ManageAzureSG
            }                                                                               # End if ($ManageAzRS -eq '0')                                                                     
            elseif ($ManageAzRS -eq '1') {                                                  # else if $ManageAzRS equals '1'
                Write-Host "List Resources By Group"                                        # Write message to screen
                ListAzResources ($RSObject)                                                 # Calls function
            }                                                                               # End elseif ($ManageAzRS -eq '1')
            elseif ($ManageAzRS -eq '2') {                                                  # else if $ManageAzRS equals '2'
                Write-Host "Remove Resource"                                                # Write message to screen
                RemoveAzResource ($RSObject)                                                # Calls function 
            }                                                                               # End elseif ($ManageAzRS -eq '2')
            else {                                                                          # All other inputs for ManageAzRS
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($ManageAzRS -eq '0'))
        }                                                                                   # End :ManageAzResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return $RSObject                                                                    # Returns $vars to calling function
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResource
# 1_2_1_0 ListAzResources 28NOV22
function ListAzResources {                                                                  # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureResources while ($true) {                                                 # Outer loop for managing function
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_                                                              # Isolates the current item
                $RGName = $RGObject.ResourceGroupName                                       # Isolates the resource group name
                $ListObject = Get-AzResource | Where-Object `
                    {$_.ResourceGroupName -eq $RGName}                                      # Creates a list of all resources within $RGObject
                foreach ($_ in $ListObject) {                                               # For each $_ in $ListObject
                    $ListInput = [PSCustomObject]@{'Name'=$_.Name;'RG' = $RGName;`
                        'Location'=$_.Location;'Type'=$_.ResourceType}                      # Creates the item to loaded into array
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ListObject)    
            }                                                                               # End foreach ($_ in $RGList)
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                Write-Host 'Name:'$_.Name                                                   # Write message to screen
                Write-Host 'RG:  '$_.RG                                                     # Write message to screen
                Write-Host 'Loc: '$_.Location                                               # Write message to screen
                Write-Host 'Type:'$_.Type                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Break ListAzureResources                                                        # Breaks :ListAzureResources
        }                                                                                   # End :ListAzureResources while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzResources
# 1_2_2_0 RemoveAzResource 28NOV22
function RemoveAzResource {                                                                 # Removes a selected resource
    Begin {                                                                                 # Begin function
        :RemoveAzureRSObject while ($true) {                                                # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                $CallingFunction = 'RemoveAzResource'                                       # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break RemoveAzureRSObject                                               # Breaks :GetAzureRSObject
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RGLocks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName `
                -AtScope                                                                    # Collects all locks on $RSObject group and assigns to $RGLocks
            if ($RGLocks) {                                                                 # If $RGLocks is not empty
                Write-Host 'Locks exist on the resource group'$RSObject.ResourceGroupName   # Write message to screen
                Write-Host 'Locks muse be removed before this resource can be removed'      # Write message to screen
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End if ($RGLocks)
            Write-Host "////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\"    # Write message to screen
            Write-Host ""$RSObject.Name "will be deleted, this cannot be undone"            # Write message to screen
            Write-Host " All resource locks will be removed automatically if confirmed "    # Write message to screen
            Write-Host " This option can be exited by typing 'Exit'                    "    # Write message to screen
            Write-Host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////"    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource'                                               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input on confirming deletion of the resource
            if ($OperatorConfirm -eq 'Y') {                                                 # If $OperatorConfirm equals 'Y' 
                Write-Host "This resource has been approved for deletion"                   # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # If $OperatorConfirm does not equal 'Y'
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y'))
            $Locks = GetAzRSLocksAll ($RSObject)                                            # Calls function function and assigns output to $var
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Message write to screen
                $LocksRemoved = RemoveAzResourceLocks ($Locks)                              # Calls function RemoveAzResourceLocks
                if ($LocksRemoved -eq 'n') {                                                # If $LocksRemoved equals 'n' 
                    Write-Host 'Locks must be removed before'                               # Write message to screen
                    Write-Host 'this resource can be removed'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureRSObject                                               # End Break RemoveAzureRSObject   
                }                                                                           # End if ($LocksRemoved -eq 'n') 
                Write-Host "Locks removed"                                                  # Message write to screen
            }                                                                               # End if ($Locks)
            Write-Host $RSObject.Name"is being removed, this may take a while"              # Message write to screen
            Try {                                                                           # Try the following
            Remove-AzResource -Name $RSObject.Name -ResourceGroup `
                $RSObject.ResourceGroupName -ResourceType $RSObject.ResourceType -Force     # Removes the resource assigned to $RSObject, -force removes confirmation
            }                                                                               # End try
            Catch {                                                                         # If try fauls 
                Write-Host `
                    $RSObjectName "was not deleted, you may not have correct permissions"   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End Catch
            Write-Host 'The selected resource has been removed'                             # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureRSObject                                                       # Breaks :RemoveAzureRSObject
        }                                                                                   # End :RemoveAzureRSObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzResource
# 1_2_G_0 GetAzResource 28NOV22
function GetAzResource {                                                                    # Function to get a resource 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResource while ($true) {                                                   # Outer loop for managing function
            $RSList = Get-AzResource                                                        # Gets all resources and assigns to $RSList
            $ListNumber = 1                                                                 # Sets $ListNumber to 1
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $RSList) {                                                       # For each $_ in $RSListList
                $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                'RG' = $_.ResourceGroupName;'Number' = $ListNumber; `
                'Location' = $_.Location}                                                   # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $RSList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                $Number = $_.Number                                                         # Sets $Number to current item .Number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9)
                else {                                                                      # If current item .number is more than 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'RG: '$_.RG                                                      # Write message to screen
                Write-Host 'Loc:'$_.Location                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureResource while ($true) {                                            # Inner loop to select the resource 
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RSSelect = Read-Host "Enter the resource [#]"                              # Operator input for the resource selection
                if ($RSSelect -eq '0') {                                                    # If $RSSelect equals 0
                    Break GetAzureResource                                                  # Breaks :GetAzureResource
                }                                                                           # End if ($RSSelect -eq '0')
                if ($RSSelect -in $ListArray.Number) {                                      # If $RSSelect is in $ListArray
                    $RSSelect = $ListArray | Where-Object {$_.Number -eq $RSSelect}         # $RSSelect is equal to $ListArray where $ListArray.Number is equal to $RSSelect                                  
                    $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                        | Where-Object {$_.Name -eq $RSSelect.Name}                         # Pulls the full resource object
                    Clear-Host                                                              # Clears screen
                    Return $RSObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RSSelect -in $ListArray)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureResource while ($true)
        }                                                                                   # End :GetAzureResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResource
# End 1_2_0_0 Manage Resources 
# 1_3_0_0 Manage Resource Locks 28NOV22
function ManageAzLocks {                                                                    # Function for managing resource locks
    Begin {                                                                                 # Begin function
        :ManageAzureLocks while($true) {                                                    # Outer loop for managing function 
            Write-Host 'Resource Group Lock Management'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Resource Group Lock'                                        # Write message to screen
            Write-Host '[2] List Resource Group Locks'                                      # Write message to screen
            Write-Host '[3] Remove Resource Group Lock'                                     # Write message to screen
            Write-Host '[4] New Resource Lock'                                              # Write message to screen
            Write-Host '[5] List Resource Locks'                                            # Write message to screen
            Write-Host '[6] Remove Resource Lock'                                           # Write message to screen
            $OPSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OPSelect -eq '0') {                                                        # If $OPSelect equals '0'
                Break ManageAzureLocks                                                      # Breaks :ManageAzureLocks 
            }                                                                               # End if ($OPSelect -eq 'exit')
            elseif ($OPSelect -eq '1') {                                                    # Else if $OPSelect equals '1'
                Write-Host 'New Resource Group Lock'                                        # Write message to screen
                NewAzResourceGroupLock                                                      # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '1')
            elseif ($OPSelect -eq '2') {                                                    # Else if $OPSelect equals '2'
                Write-Host 'List Resource Group Locks'                                      # Write message to screen
                ListAzResourceGroupLocks                                                    # Calls function 
            }                                                                               # End elseif ($OPSelect -eq '2')
            elseif ($OPSelect -eq '3') {                                                    # Else if $OPSelect equals '3'
                Write-Host 'Remove Resource Group Lock'                                     # Write message to screen
                RemoveAzResourceGroupLock                                                   # Calls function
            }                                                                               # End elseif ($OPSelect -eq '3')
            elseif ($OPSelect -eq '4') {                                                    # Else if $OPSelect equals '4'
                Write-Host 'New Resource Lock'                                              # Write message to screen
                NewAzResourceLock                                                           # Calls function and assigns output to $var
        }                                                                                   # End elseif ($OPSelect -eq '4')
            elseif ($OPSelect -eq '5') {                                                    # Else if $OPSelect equals '5'
                Write-Host 'List Resource Locks'                                            # Write message to screen
                ListAzResourceLocks                                                         # Calls function
            }                                                                               # End elseif ($OPSelect -eq '5')
            elseif ($OPSelect -eq '6') {                                                    # Else if $OPSelect equals '6'
                Write-Host 'Remove Resource Lock'                                           # Write message to screen
                RemoveAzResourceLock                                                        # Calls function
            }                                                                               # End elseif ($OPSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect-eq '0'))
        }                                                                                   # End :ManageAzureLocks while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzLocks
# 1_3_1_0 NewAzResourceGroupLock 28NOV22
function NewAzResourceGroupLock {                                                           # Function to create a new resource lock on a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRGLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzResourceGroupLock'                                 # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var                                         
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host "Lock Name?"                                          # Operator input for the lock name
                if ($LockName -eq '0') {                                                    # If $LockName equals '0'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockName -eq '0')
                Write-Host "The lock name will be" $LockName                                # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq '0') {                                                   # If $OpConfirm equals '0' 
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($OpConfirm -eq '0')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen        
                }                                                                           # End else (if ($OpConfirm -eq 'exit'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq '0') {                                                   # If $LockLevel equals '0'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockLevel -eq '0')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockLevel -eq '0'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceGroupName `
                        $RGObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource group (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch                
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceGroupName $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource group   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceGroupLock
# 1_3_2_0 ListAzResourceGroupLocks 28NOV22
function ListAzResourceGroupLocks {                                                         # Function to list locks assigned to a resource group
    Begin {                                                                                 # Begin function
        :GetAzureRGLock while ($true) {                                                     # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'ListAzResourceGroupLocks'                           # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End (!$RGObject) | Outer
            $ObjectList = Get-AzResourceLock -ResourceGroupName `
                $RGObject.ResourceGroupName -AtScope                                        # Collects all locks on $RGObject
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Properties'=$_.Properties} # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No locks are present on this resource group'                    # Write message to screen
                Break GetAzureRGLock                                                        # Breaks :GetAzureRGLock
            }                                                                               # End if (!$ObjectArray)
            else {                                                                          # If $ObjectArray has a value
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    Write-Host 'Name: '$_.Name                                              # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Break GetAzureRGLock                                                        # Breaks :GetAzureRGLock
            }                                                                               # End else (if (!$ObjectArray))
        }                                                                                   # End :GetAzureRGLock while ($true)
        Pause                                                                               # Pauses all actions for operator input
        Clear-Host                                                                          # Clears the screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroupLocks
# 1_3_3_0 RemoveAzResourceGroupLock 28NOV22
function RemoveAzResourceGroupLock {                                                        # Function to remove a single resource group lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRGLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceGroupLock'                              # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            $Locks = GetAzResourceGroupLock ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$Locks) {                                                                  # If $Locks is $null
                Break RemoveAzureRGLock                                                     # Breaks :RemoveAzureRGLock
            }                                                                               # End if (!$Locks) 
            RemoveAzResourceLocks ($Locks)                                                  # Calls function and assigns output to $var
            Break RemoveAzureRGLock                                                         # Breaks :RemoveAzureRGLock
        }                                                                                   # End :RemoveAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceGroupLock
# 1_3_3_1 RemoveAzResourceLocks 28NOV22
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host 'No locks were passed to this function'                          # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLocks                                                      # Breaks :RemoveAzureLocks
            }                                                                               # End if(!$Locks) 
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            if ($Locks.Count -gt 1) {                                                       # If $Locks.Count greater than 1
                Write-Host 'Remove these locks'                                             # Write message to screen
            }                                                                               # End if ($Locks.Count -gt 1)
            else {                                                                          # If $Locks.Count is not greater than 1
                Write-Host 'Remove this lock'                                               # Write message to screen
            }                                                                               # End else (if ($Locks.Count -gt 1))
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the locks
            if ($OperatorConfirm -eq 'Y') {                                                 # If $Operatorconfirm equals 'y' 
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    Try {                                                                   # Try the following
                        Write-Host 'Removing'$_.name                                        # Write message to screen
                        $Temp = Remove-AzResourceLock -LockId $_.LockId -force `
                            -ErrorAction 'Stop'                                             # Removes the current item in $Locks, $temp removes $True/$False from return
                    }                                                                       # End try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break RemoveAzureLocks                                              # Breaks :RemoveAzureLocks
                    }                                                                       # End catch
                }                                                                           # End foreach ($_ in $Locks)
                if ($Locks.Count -gt 1) {                                                   # If $Locks.Count greater than 1
                    Write-Host 'Locks removed'                                              # Write message to screen
                }                                                                           # End if ($Locks.Count -gt 1)
                else {                                                                      # If $Locks.Count is not greater than 1
                    Write-Host 'Lock removed'                                               # Write message to screen
                }                                                                           # End else (if ($Locks.Count -gt 1))
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLocks                                                      # Breaks :RemoveAzureLocks
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLocks                                                      # Breaks :RemoveAzureLocks
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks
# 1_3_4_0 NewAzResourceLock 28NOV22
function NewAzResourceLock {                                                                # Function to create a new resource lock on a resource
    Begin {                                                                                 # Begin function
        :NewAzureRSLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'NewAzResourceLock'                                      # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var                                         
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host 'Lock Name?'                                          # Operator input for the lock name
                if ($LockName -eq '0') {                                                    # If $LockName equals '0'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockName -eq '0')
                Write-Host 'The lock name will be:' $LockName                               # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq '0') {                                                   # If $OpConfirm equals '0' 
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($OpConfirm -eq '0')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq '0'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq '0') {                                                   # If $LockLevel equals '0'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockLevel -eq '0')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockLevel -eq '0'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceName $RSObject.Name `
                        -ResourceType $RSObject.ResourceType -ResourceGroupName `
                        $RSObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears the screen
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End catch
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType `
                        -ResourceGroupName $RSObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End catch
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceLock
# 1_3_5_0 ListAzResourceLocks 28NOV22
function ListAzResourceLocks {                                                              # Function to list locks assigned to a resource 
    Begin {                                                                                 # Begin function
        :GetAzureRSLock while ($true) {                                                     # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'ListAzResourceLocks'                                # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End (!$RSObject) | Outer
            $ObjectList = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $RSObject.Name}                                        # Collects all locks on $RSObject
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Properties'=$_.Properties} # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No locks are present on this resource'                          # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End if (!$ObjectArray)
            else {                                                                          # If $ObjectArray has a value
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    Write-Host 'Name: '$_.Name                                              # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End else (if (!$ObjectArray))
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRSLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceLocks
# 1_3_6_0 RemoveAzResourceLock 28NOV22
function RemoveAzResourceLock {                                                             # Function to remove a single resource lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRSLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceLock'                                   # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLock ($CallingFunction)                               # Calls function and assigns output to $var
                if (!$Locks) {                                                              # If $Locks is $null
                    Break RemoveAzureRSLock                                                 # Breaks :RemoveAzureRSLock
                }                                                                           # End if (!$Locks) | Inner
            }                                                                               # End if (!$Locks) | Outer
            RemoveAzResourceLocks ($Locks)                                                  # Calls function and assigns output to $var
            Break RemoveAzureRSLock                                                         # Breaks :RemoveAzureRSLock
        }                                                                                   # End :RemoveAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceLock
# 1_3_G_1 GetAzResourceGroupLock 28NOV22
function GetAzResourceGroupLock {                                                           # Function to get a lock assigned to a resource group
    Begin {                                                                                 # Begin function
        :GetAzureRGLock while ($true) {                                                     # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'GetAzResourceGroupLock'                             # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End (!$RGObject) | Outer
            $ObjectList = Get-AzResourceLock -ResourceGroupName `
                $RGObject.ResourceGroupName -AtScope                                        # Collects all locks on $RGObject
            if (!$ObjectList) {                                                             # If $ObjectList does not have a value
                Write-Host 'No locks on'$RGObject.ResourceGroupName                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRGLock                                                        # Breaks :GetAzureRGLock
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'Properties'=$_.Properties}                                             # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the lock
                if ($CallingFunction -ne 'GetAzResourceGroupLock') {                        # If $CallingFunction does not equal 'GetAzResourceGroupLock'
                    Write-Host "You are selecting the lock for"$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LockSelect = Read-Host "Enter the lock [#]"                                # Operator input for the lock selection
                if ($LockSelect -eq '0') {                                                  # If $LockSelect equals 0
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if ($LockSelect -eq '0')
                elseif ($LockSelect -in $ObjectArray.Number) {                              # If $LockSelect in $ObjectArray.Number
                    $LockSelect = $ObjectArray | Where-Object {$_.Number -eq $LockSelect}   # $LockSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $LockSelect                                  
                    $Locks = Get-AzResourceLock -Name $LockSelect.Name -ResourceGroupName `
                        $RGObject.ResourceGroupName                                         # Pulls the full lock object
                    Clear-Host                                                              # Clears screen
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End elseif ($LockSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $LockSelect
                    Write-Host "That was not a valid option"                                # Write message to screen 
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockSelect))
            }                                                                               # End :SelectAzureObjectList while ($true)
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRGLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroupLock
# 1_3_G_2 GetAzResourceLock 28NOV22
function GetAzResourceLock {                                                                # Function to get a lock assigned to a resource
    Begin {                                                                                 # Begin function
        :GetAzureRSLock while ($true) {                                                     # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'GetAzResourceLock'                                  # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End (!$RSObject) | Outer
            $ObjectList = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $RSObject.Name}                                        # Collects all locks on $RSObject
            if (!$ObjectList) {                                                             # If $ObjectList does not have a value
                Write-Host 'No locks on'$RSObject.Name                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRSLock                                                        # Breaks :GetAzureRGLock
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'Properties'=$_.Properties}                                             # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the lock
                if ($CallingFunction -ne 'GetAzResourceLock') {                             # If $CallingFunction does not equal 'GetAzResourceLock'
                    Write-Host "You are selecting the lock for"$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LockSelect = Read-Host "Enter the lock [#]"                                # Operator input for the lock selection
                if ($LockSelect -eq '0') {                                                  # If $LockSelect equals 0
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if ($LockSelect -eq '0')
                elseif ($LockSelect -in $ObjectArray.Number) {                              # If $LockSelect in $ObjectArray.Number
                    $LockSelect = $ObjectArray | Where-Object {$_.Number -eq $LockSelect}   # $LockSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $LockSelect                                  
                    $Locks = Get-AzResourceLock -Name $LockSelect.Name -ResourceGroupName `
                        $RSObject.ResourceGroupName -ResourceName $RSObject.Name `
                        -ResourceType $RSObject.ResourceType                                # Pulls the full lock object
                    Clear-Host                                                              # Clears screen
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End elseif ($LockSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $LockSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockSelect))
            }                                                                               # End :SelectAzureObjectList while ($true)
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRSLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceLock
# 1_3_G_3 GetAzRGLocksAll 28NOV222
function GetAzRGLocksAll {                                                                  # Function to get all locks assigned to a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRGLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'GetAzRGLocksAll'                                        # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLocksAll                                                # Breaks :GetAzureRGLocksAll
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName      # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource group"                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRGLocksAll                                                    # Breaks :GetAzureRGLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRGLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRGLocksAll
# 1_3_G_4 GetAzRSLocksAll 28NOV22
function GetAzRSLocksAll {                                                                  # Function to get all locks assigned to a resource
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRSLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'GetAzRSLocksAll'                                        # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLocksAll                                                # Breaks :GetAzureRSLocksAll
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RSID = $RSObject.ResourceID                                                    # Isolates the resource ID
            $RSID = $RSID+'/*'                                                              # Adds a wildcard to the resource ID
            $Locks = Get-AzResourceLock | Where-Object {$_.ResourceID -like $RSID}          # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource "                                 # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRSLocksAll                                                    # Breaks :GetAzureRSLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRSLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRSLocksAll
# End 1_3_0_0 Manage Resource Locks
# Functions for ManageAzTags
function ManageAzTags {                                                                     # Management function for tags
    Begin {                                                                                 # Begin function
        :ManageAzureTag while($true) {                                                      # Outer loop for managing function
            Write-Host 'Resource Group Tag Management'                                      # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Resource Group Tag'                                         # Write message to screen
            Write-Host '[2] Add Resource Tag'                                               # Write message to screen
            Write-Host '[3] List All Resource Group Tags'                                   # Write message to screen
            Write-Host '[4] List All Resource Tags'                                         # Write message to screen
            Write-Host '[5] Remove Resource Group Tag'                                      # Write message to screen
            Write-Host '[6] Remove Resource Tag'                                            # Write message to screen
            Write-Host '[7] Remove All Resource Group Tags'                                 # Write message to screen
            Write-Host '[8] Remove All Resource Tags'                                       # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureTag                                                        # Breaks :ManageAzureTag  
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Resource Group Tag'                                         # Write message to screen
                AddAzRGTag                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Add Resource Tag'                                               # Write message to screen
                AddAzRSTag                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Resource Group Tag'                                        # Write message to screen
                ListAzRGTags                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'List Resource Tag'                                              # Write message to screen
                ListAzRSTags                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Remove Resource Group Tag'                                      # Write message to screen
                RemoveAzRGTag                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Remove Resource Tag'                                            # Write message to screen
                RemoveAzRSTag                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Remove All Resource Group Tags'                                 # Write message to screen
                RemoveAzRGTags                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Remove All Resource Tags'                                       # Write message to screen
                RemoveAzRSTags                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '8')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureTag while loop
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzTags
function AddAzRGTag {                                                                       # Function to add a new tag to a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRGTag'                                                     # Creates $CallingFunction
        :AddAzureRGTag while ($true) {                                                      # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRGTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
                    Write-Host 'The following tags are currently set on'`
                        $RGObject.ResourceGroupName                                         # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRGTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRGTag                                                             # Breaks :AddAzureRGTag
        }                                                                                   # End :AddAzureRGTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRGTag
function AddAzRSTag {                                                                       # Function to add a new tag to a resource grop
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRSTag'                                                     # Creates $CallingFunction
        :AddAzureRSTag while ($true) {                                                      # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRSTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            Write-Host 'Adding the selected tags'                                           # Write message to screen
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
                    Write-Host 'The following tags are currently set on'$RSObject.name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRSTag                                                             # Breaks :AddAzureRSTag
        }                                                                                   # End :AddAzureRSTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRSTag
function ListAzRGTags {                                                                     # Gets all resource group tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRGTags'                                                   # Creates $CallingFunction
        :GetAzureRGTag while ($true) {                                                      # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break GetAzureRGTag                                                         # Breaks :GetAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRGTag                                                             # Breaks :GetAzureRGTag 
        }                                                                                   # End :GetAzureRGTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRGTags
function ListAzRSTags {                                                                     # Gets all resource tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRSTags'                                                   # Creates $CallingFunction
        :GetAzureRSTag while ($true) {                                                      # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject is $null
                Break GetAzureRSTag                                                         # Breaks :GetAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.Name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRSTag                                                             # Breaks :GetAzureRSTag 
        }                                                                                   # End :GetAzureRSTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRSTags
function RemoveAzRGTag {                                                                    # Function to remove tags from a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRGTag'                                                  # Creates calling function
        :RemoveAzureRGTag while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RGObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RGObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource group does not have any tags'                      # Write message to screen
                Pause                                                                       # Pauses for user input to continue
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$TagsNames)
            else {                                                                          # If $TagsNames does have a value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ValueArray = @()                             # Creates the values list array
                foreach ($_ in $TagsValues) {                                               # For each $_ in $TagValues
                    $ObjectInput = [PSCustomObject]@{'Value' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ValueArray.Add($ObjectInput) | Out-Null                                # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagValues)
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$NameArray = @()                              # Creates the name list array
                foreach ($_ in $TagsNames) {                                                # For each $_ in $TagsNames
                    $TagValue = $ValueArray | Where-Object {$_.Number -eq $ObjectNumber}    # Selects the matching tag value from $ValueArray
                    $TagValue = $TagValue.Value                                             # Isolates the tag value
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber;'Value'=$TagValue}                         # Creates the item to loaded into array
                    $NameArray.Add($ObjectInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagNames)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $NameArray) {                                                # For each $_ in $NameArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $NameArray)
                :SelectAzureObjectList while ($true) {                                      # Inner loop to select the tag
                    $TagSelect = Read-Host "Enter the tag group number"                     # Operator input for the RG selection
                    if ($TagSelect -eq '0') {                                               # If $TagSelect equals 0
                        Break RemoveAzureRGTag                                              # Breaks :RemoveAzureRGTag
                    }                                                                       # End if ($TagSelect -eq '0')
                    elseif ($TagSelect -in $NameArray.Number) {                             # If $TagSelect in $NameArray.Number
                        $TagName = $NameArray | Where-Object {$_.Number -eq $TagSelect}     # Selects the matching tag name from $NameArray                                  
                        $TagName = $TagName.name                                            # Isolates the tag name
                        $TagValue = $NameArray | Where-Object {$_.Number -eq $TagSelect}    # Selects the matching tag value from $NameArray
                        $TagValue = $TagValue.Value                                         # Isolates the tag value
                        $TagsArray =@{$TagName=$TagValue}                                   # Creates the tag array to be removed
                        Break SelectAzureObjectList                                         # Breaks :SelectAzureObjectList
                    }                                                                       # End elseif ($RGSelect -in $ListArray.Number)
                    else {                                                                  # All other entries for $TagSelect 
                        Write-Host "That was not a valid option"                            # Write message to screen
                        Pause                                                               # Pauses for user input to continue
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($TagSelect -eq '0') )
                }                                                                           # End :SelectAzureObjectList while ($true)
            }                                                                               # End else (if (!$TagsNames))
            try {                                                                           # Try the following
                $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                'Delete' -Tag $TagsArray                                                    # Removes the named tag from the resource group 
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'There maybe a policy that'                                      # Write message to screen
                Write-Host 'prevents the removal of this tag'                               # Write message to screen
                Pause                                                                       # Pauses for user input to continue
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End catch    
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break RemoveAzureRGTag                                                          # Breaks :RemoveAzureRGTag
        }                                                                                   # End :RemoveAzureRGTag while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResouceGroupTag
function RemoveAzRSTag {                                                                    # Function to remove tags from a resource 
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRSTag'                                                  # Creates calling function
        :RemoveAzureRSTag while ($true) {                                                   # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RSObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RSObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource does not have any tags'                            # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$TagsNames)
            else {                                                                          # If $TagsNames does have a value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ValueArray = @()                             # Creates the values list array
                foreach ($_ in $TagsValues) {                                               # For each $_ in $TagValues
                    $ObjectInput = [PSCustomObject]@{'Value' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ValueArray.Add($ObjectInput) | Out-Null                                # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagValues)
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$NameArray = @()                              # Creates the name list array
                foreach ($_ in $TagsNames) {                                                # For each $_ in $TagsNames
                    $TagValue = $ValueArray | Where-Object {$_.Number -eq $ObjectNumber}    # Selects the matching tag value from $ValueArray
                    $TagValue = $TagValue.Value                                             # Isolates the tag value
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber;'Value'=$TagValue}                         # Creates the item to loaded into array
                    $NameArray.Add($ObjectInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagNames)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $NameArray) {                                                # For each $_ in $NameArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $NameArray)
                :SelectAzureObjectList while ($true) {                                      # Inner loop to select the tag
                    $TagSelect = Read-Host "Enter the tag group number"                     # Operator input for the RG selection
                    if ($TagSelect -eq '0') {                                               # If $TagSelect equals 0
                        Break RemoveAzureRSTag                                              # Breaks :RemoveAzureRSTag
                    }                                                                       # End if ($TagSelect -eq '0')
                    elseif ($TagSelect -in $NameArray.Number) {                             # If $TagSelect in $NameArray.Number
                        $TagName = $NameArray | Where-Object {$_.Number -eq $TagSelect}     # Selects the matching tag name from $NameArray                                  
                        $TagName = $TagName.name                                            # Isolates the tag name
                        $TagValue = $NameArray | Where-Object {$_.Number -eq $TagSelect}    # Selects the matching tag value from $NameArray
                        $TagValue = $TagValue.Value                                         # Isolates the tag value
                        $TagsArray =@{$TagName=$TagValue}                                   # Creates the tag array to be removed
                        Break SelectAzureObjectList                                         # Breaks :SelectAzureObjectList
                    }                                                                       # End elseif ($RGSelect -in $ListArray.Number)
                    else {                                                                  # All other entries for $TagSelect 
                        Write-Host "That was not a valid option"                            # Write message to screen                        
                        Pause                                                               # Pauses for user input to continue
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($TagSelect -eq '0') )
                }                                                                           # End :SelectAzureObjectList while ($true)
            }                                                                               # End else (if (!$TagsNames))
            try {                                                                           # Try the following
                $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                'Delete' -Tag $TagsArray                                                    # Removes the named tag from the resource group 
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'There maybe a policy that'                                      # Write message to screen
                Write-Host 'prevents the removal of this tag'                               # Write message to screen           
                Pause                                                                       # Pauses for user input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End catch    
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.Name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen           
            Pause                                                                           # Pauses for user input to continue
            Break RemoveAzureRSTag                                                          # Breaks :RemoveAzureRSTag
        }                                                                                   # End :RemoveAzureRSTag while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResouceTag
function RemoveAzRGTags {                                                                   # Function to remove all tags on a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRGTags'                                                 # Creates $CallingFunction
        :RemoveAzureRGTag while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RGObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RGObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource group does not have any tags'                      # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$TagsNames)
            else {                                                                          # If $TagsNames does have a value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ValueArray = @()                             # Creates the values list array
                foreach ($_ in $TagsValues) {                                               # For each $_ in $TagValues
                    $ObjectInput = [PSCustomObject]@{'Value' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ValueArray.Add($ObjectInput) | Out-Null                                # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagValues)
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$NameArray = @()                              # Creates the name list array
                foreach ($_ in $TagsNames) {                                                # For each $_ in $TagsNames
                    $TagValue = $ValueArray | Where-Object {$_.Number -eq $ObjectNumber}    # Selects the matching tag value from $ValueArray
                    $TagValue = $TagValue.Value                                             # Isolates the tag value
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber;'Value'=$TagValue}                         # Creates the item to loaded into array
                    $NameArray.Add($ObjectInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagNames)
            }                                                                               # End else (if (!$TagsNames))
            Write-Host 'Removing tags'                                                      # Write message to screen
            foreach ($_ in $NameArray) {                                                    # For each item in $TagsNames
                $TagsArray = @{$_.Name=$_.Value}                                            # Creates $TagArray
                try {                                                                       # Try the following
                    $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                    'Delete' -Tag $TagsArray -ErrorAction 'Stop'                            # Removes the named tag from the resource group 
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'There maybe a policy that'                                  # Write message to screen
                    Write-Host 'prevents the removal of the tags'                           # Write message to screen
                    $TagsList = `
                        (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The following tags are currently set on'$RGObject.Name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input to continue
                    Break RemoveAzureRGTag                                                  # Breaks :RemoveAzureRGTag
                }                                                                           # End catch   
            } 
            Write-Host 'All tags removed from'$RGObject.Name                                # Write message to screen
            Pause                                                                           # Pauses for operator input to continue
            Break RemoveAzureRGTag                                                          # Breaks :RemoveAzureRGTag
        }                                                                                   # End :RemoveAzureRGTags while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzRGTags
function RemoveAzRSTags {                                                                   # Function to remove all tags on a resource
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRSTags'                                                 # Creates $CallingFunction
        :RemoveAzureRSTag while ($true) {                                                   # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RSObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RSObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource does not have any tags'                            # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$TagsNames)
            else {                                                                          # If $TagsNames does have a value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ValueArray = @()                             # Creates the values list array
                foreach ($_ in $TagsValues) {                                               # For each $_ in $TagValues
                    $ObjectInput = [PSCustomObject]@{'Value' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ValueArray.Add($ObjectInput) | Out-Null                                # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagValues)
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$NameArray = @()                              # Creates the name list array
                foreach ($_ in $TagsNames) {                                                # For each $_ in $TagsNames
                    $TagValue = $ValueArray | Where-Object {$_.Number -eq $ObjectNumber}    # Selects the matching tag value from $ValueArray
                    $TagValue = $TagValue.Value                                             # Isolates the tag value
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber;'Value'=$TagValue}                         # Creates the item to loaded into array
                    $NameArray.Add($ObjectInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagNames)
            }                                                                               # End else (if (!$TagsNames))
            Write-Host 'Removing tags'                                                      # Write message to screen
            foreach ($_ in $NameArray) {                                                    # For each item in $TagsNames
                $TagsArray = @{$_.Name=$_.Value}                                            # Creates $TagArray
                try {                                                                       # Try the following
                    $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                    'Delete' -Tag $TagsArray -ErrorAction 'Stop'                            # Removes the named tag from the resource group 
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'There maybe a policy that'                                  # Write message to screen
                    Write-Host 'prevents the removal of the tags'                           # Write message to screen
                    $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable # Gets the current tags assigned to $RSObject
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The following tags are currently set on'$RSObject.Name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input to continue
                    Break RemoveAzureRSTag                                                  # Breaks :RemoveAzureRSTag
                }                                                                           # End catch   
            } 
            Write-Host 'All tags removed from'$RSObject.Name                                # Write message to screen
            Pause                                                                           # Pauses for operator input to continue
            Break RemoveAzureRSTag                                                          # Breaks :RemoveAzureRSTag
        }                                                                                   # End :RemoveAzureRSTags while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzRSTags
function SetAzTagPair {                                                                     # Function for setting the tag name and value pair
    Begin {                                                                                 # Being function
        [System.Collections.ArrayList]$TagArray = @()                                       # Creates the blank tag array
        :SetAzureTagPair while ($true) {                                                    # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-host 'You are setting the tag for'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            :SetAzureTagName while ($true) {                                                # Inner loop for setting the tag name
                $TagNameInput = Read-Host "Tag Name"                                        # Operator input for the tag name
                if ($TagNameInput -eq '0') {                                                # If $TagNameInput equals '0'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagNameInput -eq '0')
                Write-Host 'Use'$TagNameInput 'as the tag name'                             # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagName                                                   # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) {                                               # Inner loop for setting the tag value
                $TagValueInput = Read-Host "Tag Value"                                      # Operator input for the tag value
                if ($TagValueInput -eq '0') {                                               # If $TagValueInput equals '0'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagVlaueInput -eq '0')
                if (!$TagValueInput) {                                                      # If $TagValueInput is $null
                    Write-Host 'Use a blank tag value'                                      # Write message to screen
                }                                                                           # End if (!$TagValueInput)
                else {                                                                      # If $TagValueInput has a value
                    Write-Host 'Use'$TagValueInput 'as the tag value'                       # Write message to screen
                }                                                                           # End else (if (!$TagValueInput))
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagValue                                                  # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagValue while ($true)
            $ArrayInput = [PSCustomObject]@{'Name'=$TagNameInput;'Value'=$TagValueInput}    # Creates the item to loaded into array
            $TagArray.Add($ArrayInput) | Out-Null                                           # Loads item into array, out-null removes write to screen
            Write-Host 'Add another pair'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confirmation to add another tag
            if ($OpConfirm -eq 'n') {                                                       # If $OpConfirm equals 'n'
                Break SetAzureTagPair                                                       # Breaks :SetAzureTagPair
            }                                                                               # End if ($OpConfirm -eq 'n')
            Clear-Host                                                                      # Clear the screen 
        }                                                                                   # End :SetAzureTagPair while ($true)
        Clear-Host                                                                          # Clear the screen
        if ($TagArray) {                                                                    # If $TagArray has a value
            Return $TagArray                                                                # Returns to calling function with $var
        }                                                                                   # End if ($TagArray)
        else {                                                                              # If $TagArray does not have a value
            Return                                                                          # Returns to calling function with $null
        }                                                                                   # End else (if ($TagArray))
    }                                                                                       # End begin
}                                                                                           # End function SetAzTagPair
# End ManageAzTags
# Additional functions required for ManageAzResourceGroup
function GetAzRGLocksAll {                                                                  # Function to get all locks assigned to a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRGLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'GetAzRGLocksAll'                                        # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLocksAll                                                # Breaks :GetAzureRGLocksAll
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName      # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource group"                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRGLocksAll                                                    # Breaks :GetAzureRGLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRGLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRGLocksAll
function GetAzRSLocksAll {                                                                  # Function to get all locks assigned to a resource
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRSLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'GetAzRSLocksAll'                                        # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLocksAll                                                # Breaks :GetAzureRSLocksAll
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RSID = $RSObject.ResourceID                                                    # Isolates the resource ID
            $RSID = $RSID+'/*'                                                              # Adds a wildcard to the resource ID
            $Locks = Get-AzResourceLock | Where-Object {$_.ResourceID -like $RSID}          # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource "                                 # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRSLocksAll                                                    # Breaks :GetAzureRSLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRSLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRSLocksAll
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
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                Write-Host '[0]   Exit'                                                     # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each $_ in $ListArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]  "$_.Location                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number] "$_.Location                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                }                                                                           # End foreach ($_ in $ListArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the location for:'$CallingFunction        # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is '0'
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ListArray.Number) {                                  # If $OpSelect in $ListArray.Number
                    $OpSelect = $ListArray | Where-Object {$_.Number -eq $OpSelect}         # OpSelect is equal to $ListArray where $OpSelect equals $ListArray.Number
                    $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                        -eq $OpSelect.Location} -ErrorAction 'Stop'                         # Pulls the full $LocationObject
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen   
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
# End ManageAzResourceGroups