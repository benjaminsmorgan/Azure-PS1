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