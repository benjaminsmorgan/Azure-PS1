# Benjamin Morgan benjamin.s.morgan@outlook.com 
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
    GetAzResourceGroupResources:TBD        
    RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/RemoveAzResourceGroup.ps1
        GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1  
    RemoveAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/RemoveAzResource.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        SearchAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResource.ps1
            SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
            SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
            SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
            SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
        GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1   
    SearchAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResource.ps1
        SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
        SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
    ManageAzResourceGroupLocks: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/ManageAzResourceGroupLocks.ps1
        NewAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/NewAzResourceGroupLock.ps1
        NewAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/NewAzResourceLock.ps1
        GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLocksAll.ps1
        GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLockNamed.ps1
        GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
        GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLockNamed.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    ManageAzResourceGroupTags:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/ManageAzResourceGroupTags.ps1    
        SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/SetAzTagPair.ps1
        AddAzResourceGroupTag:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/AddAzResourceGroupTag.ps1
        AddAzResourceTag:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/AddAzResourceTag.ps1
        GetAzResourceGroupTags:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/GetAzResourceGroupTags.ps1
        GetAzResourceTags:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/GetAzResourceTags.ps1
        RemoveAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/RemoveAzResourceGroupTag.ps1
        RemoveAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/RemoveAzResourceTag.ps1
        RemoveAzResourceGroupTags:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/RemoveAzResourceGroupTags.ps1
        RemoveAzResourceTags:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Tags/RemoveAzResourceTags.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
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
    ManageAzResourceGroupLocks: Manages all functions related to Lock objects
    RemoveAzResourceGroup:      Removes a resource group object
        GetAzResourceGroupLocksAll: Collects resource locks
        RemoveAzResourceLocks:      Removes resource locks passed in $Locks
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
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup*
        SearchAzResourceName:       Searchs for resource using partial name matches on a resource name
        SearchAzResourceType:       Searchs for resource using resource provider or type on a resource or resource
        SearchAzResourceLoc:        Searchs for resource using location matches on a resource
        SearchAzResourceTag:        Searchs for resource using tag matches on a resource
    ManageAzResourceGroupLocks: Management function for Locks functions
        NewAzResourceGroupLock:     Create a new resource lock on a resource group
        GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
        GetAzResourceGroupLockNamed:Collects a named locks on a resource group
        GetAzResourceLocksAll:      Collects all locks on a resource
        GetAzResourceLockNamed:     Collects a named lock on a resource
        GetAzResourceGroup:         Collects resource group object
        GetAzResource:              Collects resources within a resource group  
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
        GetAzResourceGroup:         Collects resource group object
        GetAzResource:              Collects resources within a resource group    
} #>
<# Variables: {
    ManageAzResourceGroup {
        $OperatorSearchOption:  Operator input for search option
        :ManageAzureRG          Named loop for selecting the management option
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
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
        :GetAzureResourceGroup  Named loop for getting the resource group object
    }
    NewAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $OperatorConfirm:       Operator confirmation info is correctly input
        $TagNameInput:          Operator input for a tag name
        $TagValueInput:         Operator input for the tag value
        $Tag:                   Full tag to be applied to the resource group creation
        $ValidLocation:         Collection of all Azure locations
        $LocationInput:         Operator input for the location
        :NewAzureRGObject       Named outer loop for creating a new resource group
        :SetTag                 Named inner loop for setting tag
        :SetName                Named inner loop for setting name
        :SetLocation            Named inner loop for setting location
    }
    RemoveAzResourceGroup {
        $RGObject:              Resource group object, used for all actions
        $RGObjectName:          Name of the resource group object, used only in confirmation
        $RGObjectVerify:        Resource group object pulled again using $RGObjectName to check if existing
        $OperatorSearchOption:  Operator input for how to get $RGObject
        $OperatorConfirm:       Operator confirmation info is correctly input
        $Locks:                 All lock objects if existing
        :RemoveAzureRGObject    Named outer loop for running all commands in function
        :GetAzureRGObject       Named inner loop for setting and confirming the resource group object
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
        }
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
            $OperatorConfirm:       Operator input what locks to collect
        }
    } End RemoveAzResourceGroup
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
    ManageAzResourceGroupLocks {
        :ManageAzureRGLocks     Outer loop for function
        $OperatorManageOption:  Operator input for management option
        $OperatorSelect:        Operator input for clearing $Vars
        $ForEachCount:          Number used in foreach statement for each found resource
        NewAzResourceGroupLock {
            $RGObject:              Resource group object
            $LockName:              Operator input for the lock name
            $LockLevel:             Operator input for the lock level
            $LockNotes:             Optional operator input for the lock notes
            $Locks:                 Locks object
            :NewAzureRGLock         Outer loop for function
            :GetAzureLockName       Inner loop for getting lock name
            :GetAzureLockLevel      Inner loop for getting lock level
        }
        NewAzResourceLock {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $LockName:              Operator input for the lock name
            $LockLevel:             Operator input for the lock level
            $LockNotes:             Optional operator input for the lock notes
            $Locks:                 Locks object
            :NewAzureRSLock         Outer loop for function
            :GetAzureLockName       Inner loop for getting lock name
            :GetAzureLockLevel      Inner loop for getting lock level
        }
        GetAzResourceGroupLocksAll {
            $RGObject:              Resource group object
            $Locks:                 Locks object
        }
        GetAzResourceGroupLockNamed {
            $RGObject:              Resource group object
            $Locks:                 Locks object
            $LocksInput:            Input to collect a named lock
            $LocksList:             Object containing all locks within the resource group
            $OperatorConfirm:       Operator confirmation that the lock found was the intended 
        }
        GetAzResourceLocksAll {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Locks object
        }
        GetAzResourceLockNamed {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Lock objects
            $OperatorConfirm:       Operator input that the correct object has been found
        }
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
        }    
        GetAzResourceGroup {
            $RGObject:              Resource group object
            $RGObjectInput:         Operator input for the resource group name
            $RGList:                Variable used for printing all resource groups to screen if needed
        }
        GetAzResource {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name
            $RSList:                Variable used for printing all resources to screen if needed
        }
    } End ManageAzResourceGroupLocks
    ManageAzResourceGroupTags { 
        :ManageAzureRGTag           Outer loop for function
        $OperatorManageOption:      Operator input for the management function
        $TagNameInput:              Operator input for the tag name
        $TagValueInput:             Operator input for the tag value
        $TagsList:                  Write-Host writable tag name and value list
        $RGObject:                  Resource group object
        $RSObject:                  Resource object
        SetAzTagPair { 
            :SetAzureTagPair            Outer loop for function
            :SetAzureTagName            Inner loop for setting the tag name
            :SetAzureTagValue           Inner loop for setting the tag value
            $TagNameInput:              Operator input for the tag name
            $TagValueInput:             Operator input for the tag value 
            $OperatorConfirm:           Operator confirmation on tag name and value 
        }  End SetAzTagPair    
        AddAzResourceGroupTag {
            :AddAzureRGTag              Outer loop for function
            :SetAzureTagArray           Inner loop for setting the tag name and value 
            $RGObject:                  Resource group object
            $TagNameInput:              Operator input for the tag name
            $TagValueInput:             Operator input for the tag value
            $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
            $TagsList:                  Write-Host writable tag name and value list
        } End AddAzResourceGroupTag 
        AddAzResourceTag {
            :AddAzureRSTag              Outer loop for function
            :SetAzureTagArray           Inner loop for setting the tag name and value
            $RGObject:                  Resource group object
            $RSObject:                  Resource object
            $TagNameInput:              Operator input for the tag name
            $TagValueInput:             Operator input for the tag value
            $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
            $TagsList:                  Write-Host writable tag name and value list
        } End AddAzResourceTag
        GetAzResourceGroupTags { 
            :GetAzureRGTag              Outer loop for function
            $RGObject:                  Resource group object
            $TagsList:                  Write-Host writable tag name and value list
        } End GetAzResourceGroupTags
        GetAzResourceTags {
            :GetAzureRSTag              Outer loop for function
            $RGObject:                  Resource group object
            $RSObject:                  Resource object
            $TagsList:                  Write-Host writable tag name and value list
        } End GetAzResourceTags    
        RemoveAzResourceGroupTag { 
            :RemoveAzureRGTag           Outer loop for function
            :SetAzureTagArray           Inner loop for setting the tag name and value 
            $RGObject:                  Resource group object
            $ValidTagName:              List of all tag names on resource group
            $TagNameInput:              Operator input for the tag name
            $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
            $TagsList:                  Write-Host writable tag name and value list
        } End RemoveAzResouceGroupTag 
        RemoveAzResourceTag { 
            :RemoveAzureRSTag           Outer loop for function
            :SetAzureTagArray           Inner loop for setting the tag name and value
            $RGObject:                  Resource group object
            $RSObject:                  Resource object
            $ValidTagName:              List of all tag names on resource
            $TagNameInput:              Operator input for the tag name
            $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
            $TagsList:                  Write-Host writable tag name and value list
        } End RemoveAzResouceTag    
        RemoveAzResourceGroupTags {
            :RemoveAzureRGTags          Outer loop for function
            $RGObject:                  Resource group object
            $TagsList:                  Write-Host writable tag name and value list
        } End RemoveAzResourceGroupTags 
        RemoveAzResourceTags {
            :RemoveAzureRSTags          Outer loop for function
            $RGObject:                  Resource group object
            $RSObject:                  Resource object
            $TagsList:                  Write-Host writable tag name and value list
        } End RemoveAzResourceTags
        GetAzResourceGroup { 
            :GetAzureResourceGroup      Outer loop for function
            $RGObject:                  Resource group object 
            $RGObjectInput:             Resource group object input
            $RGList:                    List of all availiable resource groups
        } End GetAzResourceGroup 
        GetAzResource { 
            $RSObject:                  Resource object
            $RGObject:                  Resource group object
            $RSObjectInput:             Resource object input
            $RSList:                    List of all availiable resources
        } End GetAzResource 
    } End ManageAzResourceGroupTags 
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
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        :GetAzureResourceGroup while ($true) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Break GetAzureResourceGroup # Ends :GetAzureResourceGroup loop
            } # End if statement
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
                Return $RGObject
            } # End of else statement
        } # End of while statement
        Return # Returns to calling function
    } # End of begin statement
} # End of function
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