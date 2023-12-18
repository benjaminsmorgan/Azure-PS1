function SetAzManagementGroupSubscription {                                                 # Function to move a subscription to a management group
    Begin {                                                                                 # Begin function
        :SetAzureManagementGroupSubscription while($true) {                                 # Outer loop for managing function
            $MGObject = GetAzManagementGroup                                                # Calls function and assigns output to $var
            if (!$MGObject) {                                                               # If $MGObject is $null
                Break SetAzureManagementGroupSubscription                                   # Breaks :SetAzureManagementGroupSubscription
            }                                                                               # End if (!$MGObject)
            $SubObject = GetAzSubscription                                                  # Calls function and assigns output to $var
            if (!$SubObject) {                                                              # If $SubObject is $null
                Break SetAzureManagementGroupSubscription                                   # Breaks :SetAzureManagementGroupSubscription
            }                                                                               # End if (!$SubObject)
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host 'Move Subscription:   '$SubObject.Name                               # Write message to screen
            Write-Host 'to Management Group: '$MGObject.Name                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host '[Y] or [N]'                                              # Operator input for confirming the change
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                Try {                                                                       # Try the following
                    New-AzManagementGroupSubscription -GroupName $MGObject.Name `
                      -SubscriptionId $SubObject.ID  -ErrorAction 'Stop' | Out-Null         # Moves the subscription to the management group
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
                    Break SetAzureManagementGroupSubscription                               # Breaks :SetAzureManagementGroupSubscription    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host $SubObject.Name 'has been moved'                                 # Write message to screen
                Write-Host 'It may take up to 15 minutes for this'                          # Write message to screen
                Write-Host 'change to sync in Azure PowerShell'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureManagementGroup                                            # Break RemoveAzureMGObject
            }                                                                               # End if ($OpSelect -eq 'y')
            else {                                                                          # All other inputs for $OpSelect
                Break SetAzureManagementGroupSubscription                                   # Breaks :SetAzureManagementGroupSubscription
            }                                                                               # End else (if ($OpSelect -eq 'y'))
        }                                                                                   # End :SetAzureManagementGroupSubscription while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzManagementGroupSubscription
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
function GetAzManagementGroup {                                                             # Function to get a management group 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureManagementGroup while ($true) {                                            # Outer loop for managing function
            Write-Host 'Gathering Azure Management Groups'                                  # Write message to screen
            Write-Host 'This might take a moment'                                           # Write message to screen
            $ObjectList = Get-AzManagementGroup                                             # Gets all management groups and assigns to $ObjectList
            Clear-Host                                                                      # Clears screen
            If (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No management groups found in this tenant'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureManagementGroup                                               # Breaks :GetAzureManagementGroup
            }                                                                               # End If (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'Number' = $ObjectNumber;                                               # Object number
                    'Name' = $_.Name;                                                       # Management group name
                    'ID' = $_.ID;                                                           # Management group ID
                    'DName' = $_.DisplayName                                                # Management group state
                }                                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the subscription
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    Write-Host ''                                                           # Write message to screen
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number]   "$_.DName                                   # Write message to screen
                        Write-Host "Name: "$_.Name                                          # Write message to screen
                        Write-Host "ID:   "$_.ID                                            # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]  "$_.Name                                     # Write message to screen
                        Write-Host "Name: "$_.DName                                         # Write message to screen
                        Write-Host "ID:   "$_.ID                                            # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host ''                                                           # Write message to screen
                    Write-Host `
                        'You are selecting the management group for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureManagementGroup                                           # Breaks :GetAzureManagementGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect       
                    $MGObject = Get-AzManagementGroup -GroupName $OpSelect.Name             # Gets $MGObject                           
                    Clear-Host                                                              # Clears screen
                    Return $MGObject                                                        # Returns to calling function with $MGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $OPSelect is not in $ObjectArray
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureManagementGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzManagementGroup