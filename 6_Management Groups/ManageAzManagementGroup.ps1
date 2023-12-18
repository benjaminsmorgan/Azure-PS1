# Functions for ManageAzManagementGroup
function ManageAzManagementGroup {                                                          # Function to manage Azure management groups
    Begin {                                                                                 # Begin function
        :ManageAzureManagementGroup  while($true) {                                         # Outer loop for managing function
            Write-Host 'Management Group Management'                                        # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Azure Management Group'                                     # Write message to screen
            Write-Host '[2] List Management Groups'                                         # Write message to screen
            Write-Host '[3] Delete Management Group'                                        # Write message to screen 
            Write-Host '[4] Move Sub in Management Group'                                   # Write message to screen 
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals 'exit'
                Break ManageAzureManagementGroup                                            # Breaks :ManageAzureManagementGroup
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Azure Management Group'                                     # Write message to screen
                NewAzManagementGroup                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Management Groups'                                         # Write message to screen
                ListAzManagementGroup                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Delete Management Group'                                        # Write message to screen
                RemoveAzManagementGroup                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Move Sub in Management Group'                                   # Write message to screen
                SetAzManagementGroupSubscription                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureManagementGroup while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzManagementGroup
function NewAzManagementGroup {                                                             # Function to create a new management group
    Begin {                                                                                 # Begin function
        :NewAzureManagementGroup while($true) {                                             # Outer loop to manage function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last charac
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureManagementGroupName while($true) {                                     # Inner loop to set the management group name
                Write-Host 'Please enter the management group name'                         # Write message to screen
                Write-Host '[0] to exit'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $GroupName = Read-Host 'Name'                                               # Operator input for the management group name
                if ($GroupName -eq '0') {                                                   # If $GroupName equals '0'
                    Break NewAzureManagementGroup                                           # Breaks :NewAzureManagementGroup
                }                                                                           # End if ($GroupName = '0')
                else {                                                                      # All other inputs for $GroupName
                    $MGNNameArray = $GroupName.ToCharArray()                                # Loads $GroupName into array
                    Clear-Host                                                              # Clears screen
                    if ($MGNNameArray[-1] -notin $ValidLastChar) {                          # If last position of $MGNNameArray is not in $ValidLastChar
                        Write-Host `
                            'The last character of the name must be a letter, number or _ ' # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $GroupName = $null                                                  # Clears $GroupName
                    }                                                                       # End if ($MGNNameArray[0] -notin $Valid1stChar)
                    foreach ($_ in $MGNNameArray) {                                         # For each item in $MGNNameArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            if ($_ -eq ' ') {                                               # If current item equals 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host 'Management group name cannot include any spaces'# Write message to screen
                            }                                                               # End if ($_ -eq ' ')
                            else {                                                          # If current item is not equal to 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host $_' is not a valid character'                    # Write message to screen
                            }                                                               # End else (if ($_ -eq ' '))
                            $GroupName = $null                                              # Clears $GroupName
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $MGNNameArray)
                    if ($GroupName) {                                                       # If $GroupName has a value
                        Write-Host 'Use:'$GroupName' as the management group name'          # Writes message to screen
                        Write-Host ''                                                       # Writes message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the management group name
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break NewAzureManagementGroup                                   # Breaks :NewAzureManagementGroup
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break NewAzureManagementGroupName                               # Breaks :NewAzureManagementGroupName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End if ($GroupName)
                    else {                                                                  # If $GroupName does not have a value
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($GroupName))
                }                                                                           # End else (if ($GroupName = '0'))
            }                                                                               # End :NewAzureManagementGroupName while($true)
            :NewAzureManagementGroupDisplayName while($true) {                              # Inner loop to set the management group name
                Write-Host 'Please enter the management group display name'                 # Write message to screen
                Write-Host '[0] to exit'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $GroupDisplayName = Read-Host 'Name'                                        # Operator input for the management group display name
                if ($GroupDisplayName -eq '0') {                                                     # If $GroupDisplayName equals '0'
                    Break NewAzureManagementGroup                                           # Breaks :NewAzureManagementGroup
                }                                                                           # End if ($GroupName = '0')
                elseif (!$GroupDisplayName) {                                               # Else if $GroupDisplayName is $null
                    Write-Host 'The management group display name must have a value'        # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen  
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End elseif (!$GroupDisplayName)
                else {                                                                      # All other inputs for $GroupName
                    Write-Host `
                        'Use:'$GroupDisplayName' as the management group display name'      # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the management group display name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureManagementGroup                                       # Breaks :NewAzureManagementGroup
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureManagementGroupDisplayName                            # Breaks :NewAzureManagementGroupDisplayName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($GroupDisplayName = '0'))
            }                                                                               # End :NewAzureManagementGroupDisplayName while($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the new management group'                              # Write message to screen
                New-AzManagementGroup -GroupName $GroupName -DisplayName $GroupDisplayName `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the management group
                Write-Host 'The management group has been created'                          # Write message to screen
            }                                                                               # End try
            Catch {                                                                         # If Try fails
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
            }                                                                               # End catch
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureManagementGroup                                                   # Breaks :NewAzureManagementGroup
        }                                                                                   # End :NewAzureManagementGroup while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzManagementGroup
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
function RemoveAzManagementGroup {                                                          # Function to remove a management group
    Begin {                                                                                 # Begin funciton
        :RemoveAzureManagementGroup while ($true) {                                         # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            if (!$MGObject) {                                                               # If $MGObject does not have a value
                $CallingFunction = 'RemoveAzManagementGroup'                                # Creates $CallingFunction
                $MGObject = GetAzManagementGroup ($CallingFunction)                         # Calls function and assigns output to $var
                if (!$MGObject) {                                                           # If $MGObject does not have a value
                    Break RemoveAzureManagementGroup                                        # Breaks :RemoveAzureManagementGroup
                }                                                                           # End if (!$MGObject) | Inner
            }                                                                               # End if (!$MGObject) | Outer
            Write-Host '////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host ' This will delete:'$MGObject.Name                                   # Write message to screen
            Write-Host ' Display name:    '$MGObject.DisplayName                            # Write message to screen
            Write-Host ' This action cannot be undone once completed'                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this management group'                                       # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator input on confirming deletion of the managment group
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                $MGObjectName = $MGObject.DisplayName                                       # Creates $MGObjectName
                Write-Host $MGObject.DisplayName'is being removed'                          # Write message to screen
                Write-Host 'this may take a while'                                          # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzManagementGroup -GroupName $MGObject.Name `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the management group
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
                    Break RemoveAzureManagementGroup                                        # Breaks :RemoveAzureMGObject    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host $MGObjectName'has been removed'                                  # Write message to screen
                Write-Host 'It may take up to 15 minutes for this'                          # Write message to screen
                Write-Host 'change to sync in Azure PowerShell'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureManagementGroup                                            # Break RemoveAzureMGObject
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureManagementGroup                                            # Breaks :RemoveAzureMGObject
            }                                                                               # End else (if ($OpConfirm -eq 'y')
        }                                                                                   # End :RemoveAzureMGObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzManagmentGroup
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
# End ManageAzManagementGroup
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