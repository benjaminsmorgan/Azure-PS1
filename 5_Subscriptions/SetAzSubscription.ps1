function SetAzSubscription {                                                                # Function to set the current subscription 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :SetAzureSubscription while ($true) {                                               # Outer loop for managing function
            $SubObject = GetAzSubscription                                                  # Calls function and assigns output to $var
            if (!$SubObject) {                                                              # If $SubObject is null
                Break SetAzureSubscription                                                  # Breaks :SetAzureSubscription
            }                                                                               # End SetAzureSubscription
            Set-AzContext -SubscriptionId $SubObject.ID                                     # Sets the selected subscription
            Break SetAzureSubscription                                                      # Breaks :SetAzureSubscription
        }                                                                                   # End :ListAzureSubscription while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzSubscription
function GetAzSubscription {                                                                # Function to get a subscription 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureSubscription while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering Azure subscriptions'                                      # Write message to screen
            Write-Host 'This might take a moment'                                           # Write message to screen
            $ObjectList = Get-AzSubscription                                                # Gets all subscriptions and assigns to $ObjectList
            Clear-Host                                                                      # Clears screen
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'Number' = $ObjectNumber;                                               # Object number
                    'Name' = $_.Name;                                                       # Subscription name
                    'ID' = $_.ID;                                                           # Subscription ID
                    'State' = $_.State                                                      # Subscription state
                }                                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the subscription
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.ID '|' $_.State               # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.ID '|' $_.State                # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the subsciption for:'$CallingFunction     # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureSubscription                                              # Breaks :GetAzureSubscription
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $SubObject = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}      # $SubObject is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    Clear-Host                                                              # Clears screen
                    Return $SubObject                                                       # Returns to calling function with $SubObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $SubObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureSubscription while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzSubscription