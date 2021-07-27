# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceName:       Searchs for resource using partial name matches on a resource name
} #>
<# Variables: {     
    SearchAzResourceName {
        :SearchAzureRSByName    Outer loop for function
        :SearchAzureRSName      Inner loop for finding resource by name
        $RSObjectInput:         Operator input for the resource name
        $RSObject:              Resource object
        $RGObjectInput:         Operator input for the resource group name
        $ForEachCount:          Number used in foreach statement for each found resource
    } End SearchAzResourceName
} #>
<# Process Flow {
    Function
        Call SearchAzResourceName > Get $RSObject
        End  SearchAzResourceName
            Return Function > Send $RSObject
}#> 
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
