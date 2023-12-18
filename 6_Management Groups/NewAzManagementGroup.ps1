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