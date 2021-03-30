# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceLoc:        Searchs for resource using location matches on a resource
} #>
<# Variables: {
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
} #>
<# Process Flow {
    Function               
        Call SearchAzResourceLoc  > Get $RSObject
        End SearchAzResourceLoc
            Return Function > Send $RSObject
}#>
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