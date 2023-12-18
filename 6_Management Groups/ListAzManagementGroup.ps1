function ListAzManagementGroup {                                                            # Function to get list all management groups 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :ListAzureManagementGroup while ($true) {                                            # Outer loop for managing function
            Write-Host 'Gathering Azure Management Groups'                                  # Write message to screen
            Write-Host 'This might take a moment'                                           # Write message to screen
            $ObjectList = Get-AzManagementGroup                                             # Gets all management groups and assigns to $ObjectList
            Clear-Host                                                                      # Clears screen
            If (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No management groups found in this tenant'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureManagementGroup                                              # Breaks :ListAzureManagementGroup
            }                                                                               # End If (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'Name' = $_.Name;                                                       # Management group name
                    'ID' = $_.ID;                                                           # Management group ID
                    'DName' = $_.DisplayName                                                # Management group state
                }                                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host 'Groups listed below may not be up to date'                          # Write message to screen
            Write-Host 'Changes may take up to 15 minutes to take effect'                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host ''                                                               # Write message to screen
                Write-Host "Dis Name: "$_.DName                                             # Write message to screen
                Write-Host "Name:     "$_.Name                                              # Write message to screen
                Write-Host "ID:       "$_.ID                                                # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureManagementGroup                                                  # Breaks :ListAzureManagementGroup
        }                                                                                   # End :GetAzureManagementGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzManagementGroup