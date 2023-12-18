function ListAzSubscription {                                                               # Function to list all subscriptions 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :ListAzureSubscription while ($true) {                                              # Outer loop for managing function
            Write-Host 'Gathering Azure subscriptions'                                      # Write message to screen
            Write-Host 'This might take a moment'                                           # Write message to screen
            $ObjectList = Get-AzSubscription                                                # Gets all subscriptions and assigns to $ObjectList
            Clear-Host                                                                      # Clears screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'Name' = $_.Name;                                                       # Subscription name
                    'ID' = $_.ID;                                                           # Subscription ID
                    'State' = $_.State                                                      # Subscription state
                }                                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host $_.Name '|' $_.ID '|' $_.State                                   # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for user input
            Break ListAzureSubscription                                                     # Breaks :ListAzureSubscription 
        }                                                                                   # End :ListAzureSubscription while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzSubscription