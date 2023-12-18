# Functions for ManageAzSubscription
function ManageAzSubscription {                                                             # Function to manage Azure subscriptions
    Begin {                                                                                 # Begin function
        :ManageAzureSubscription while($true) {                                             # Outer loop for managing function
            Write-Host 'Subscription Management'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Set Azure Subscription'                                         # Write message to screen
            Write-Host '[2] Enable Subscription'                                            # Write message to screen
            Write-Host '[3] List Subscriptions'                                             # Write message to screen
            Write-Host '[4] Rename Subscription'                                            # Write message to screen 
            Write-Host '[5] Cancel Subscription'                                            # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals 'exit'
                Break ManageAzureSubscription                                               # Breaks :ManageAzureSubscription
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Set Azure Subscription'                                         # Write message to screen
                SetAzSubscription                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Enable Subscription'                                            # Write message to screen
                #Functionnamegohere                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Subscriptions'                                             # Write message to screen
                ListAzSubscription                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Rename Subscription'                                            # Write message to screen
                RenameAzSubscription                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Cancel Subscription'                                            # Write message to screen
                #Functionnamegohere                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureSubscription while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzSubScription
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
function RenameAzSubscription {                                                             # Function to rename a subscription 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :RenameAzureSubscription while ($true) {                                            # Outer loop for managing function
            $SubObject = GetAzSubscription                                                  # Calls function and assigns output to $var
            if (!$SubObject) {                                                              # If $SubObject is null
                Break RenameAzureSubscription                                               # Breaks :SetAzureSubscription
            }                                                                               # End SetAzureSubscription
            $ExistingSubs = Get-AzSubscription                                              # Gets a list of existing subscriptions
            :RenameAzureSubscriptionName while ($true) {                                    # Inner loop for creating a new sub name
                Write-Host '[0] To exit'                                                    # Write message to screen
                $NewSubName = Read-Host 'Please enter the subs new name'                    # Operator input to select the sub new name
                Clear-Host                                                                  # Clears screen
                if (!$NewSubName) {                                                         # If $NewSubName is null
                    Write-Host 'That was not a valid entry'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$NewSubName)
                elseif ($NewSubName -eq '0') {                                              # Else if $NewSubName equals '0'
                    Break RenameAzureSubscription                                           # Breaks :RenameAzureSubscription
                }                                                                           # End elseif ($NewSubName -eq '0')
                else {                                                                      # All other inputs for $NewSubName
                    if ($NewSubName -iin $ExistingSubs.Name) {                              # If $NewSubName is in $ExistingSubs.Name
                        Write-Host 'The name '$NewSubName' is already in use'               # Write message to screen
                        Write-Host 'Please use a different name'                            # Write message to screen
                        write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if ($NewSubName -iin $ExistingSubs.Name)
                    else {                                                                  # Else if $NewSubName is not in $ExistingSubs.Name
                        Write-Host 'Rename: '$SubObject.Name' to '$NewSubName               # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [*] Select new name'                 # Operator input to confirm the name
                        Clear-Host                                                          # Clears screen
                        If ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break RenameAzureSubscriptionName                               # Breaks :RenameAzureSubscriptionName
                        }                                                                   # End If ($OpSelect -eq 'y')
                    }                                                                       # End else (if ($NewSubName -iin $ExistingSubs.Name))
                    $NewSubName = $null                                                     # Clears $Var
                }                                                                           # End if (!$NewSubName)
            }                                                                               # End :RenameAzureSubscriptionName while ($true)
            try {                                                                           # Try the following
                Write-Host 'Renaming the selected sub'                                      # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                Rename-AzSubscription -Id $SubObject.ID -SubscriptionName `
                    $NewSubName -ErrorAction 'Stop' | Out-Null                              # Renames the subscription
                Clear-Host                                                                  # Clears screen
                Write-Host 'The subscription has been renamed'                              # Write message to screen
                write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                $MSG = $Error[0]                                                            # Gets the error message
                $MSG = $MSG.Exception.InnerException.Body.Message                           # Isolates the error message
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Warning $MSG                                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End catch
            Break RenameAzureSubscription                                                   # Breaks :SetAzureSubscription
        }                                                                                   # End :RenameAzureSubscription while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RenameAzSubscription
# End ManageAzSubscription 