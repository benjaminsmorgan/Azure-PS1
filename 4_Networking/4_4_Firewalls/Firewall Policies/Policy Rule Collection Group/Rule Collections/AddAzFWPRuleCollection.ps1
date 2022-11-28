# Warning: At this time, this function does not work
# Pending support from MS on adding multiple rule collections to a group through powershell
function AddAzFWPRuleCollection {                                                           # Function to create a firewall policy rule collection
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzFWPRuleCollection'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPRuleCollection while ($true) {                                          # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if (!$FWPolicyRCGObject) 
            if ($FWPolicyRCGObject.Properties.RuleCollection) {                             # If $FWPolicyRCGObject.Properties.RuleCollection has a value
                Write-Host 'This function does not currently support'                       # Write message to screen
                Write-Host 'adding additional rule collections to a'                        # Write message to screen
                Write-Host 'rule collection group where a rule'                             # Write message to screen
                Write-Host 'collection currently exists'                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'To add another rule collection to this group'                   # Write message to screen
                Write-Host 'Please visit the azure portal'                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureFWPolicyRCG                                                   # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if ($FWPolicyRCGObject.Properties.RuleCollection)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureFWPRuleColName while ($true) {
                Write-Host 'Enter the policy rule collection name'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $PolicyRuleColName = Read-Host 'Name'                                       # Operator input for the firewall policy name
                $PolicyRuleColNameArray = $PolicyRuleColName.ToCharArray()                  # Loads $PolicyRuleColName into array
                Clear-Host                                                                  # Clears screen
                if ($PolicyRuleColNameArray[0] -notin $Valid1stChar) {                      # If 0 position of $PolicyRuleColNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRuleColName = $null                                              # Clears $PolicyRuleColName
                }                                                                           # End if ($PolicyRuleColNameArray[0] -notin $Valid1stChar)
                if ($PolicyRuleColNameArray[-1] -notin $ValidLastChar) {                    # If last position of $PolicyRuleColNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRuleColName = $null                                              # Clears $PolicyRuleColName
                }                                                                           # End if ($PolicyRuleColNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PolicyRuleColNameArray) {                                   # For each item in $PolicyRuleColNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule collection name cannot include any spaces'     # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PolicyRuleColName = $null                                          # Clears $PolicyRuleColName
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PolicyRuleColNameArray)
                if ($PolicyRuleColName) {                                                   # If $PolicyRuleColName has a value
                    Write-Host 'Use:'$PolicyRuleColName' as the rule collection name'       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the firewall name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureFWPRuleCollection                                     # Breaks :SetAzureFWPRuleCollection
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureFWPRuleColName                                        # Breaks :SetAzureFWPRuleColName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PolicyRuleColName)
                else {                                                                      # If $PolicyRuleColName does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRuleColName))
            }                                                                               # End :SetAzureFWPRuleColName while ($true)
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPRuleColPri while ($true) {                                          # Inner loop for setting the policy rule collection priority
                Write-Host 'Please enter the rule collection priority'                      # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $PolicyRuleColPri = Read-Host 'Priority [#]'                                # Operator input for the rule collection priority
                Clear-Host                                                                  # Clears screen
                if ($PolicyRuleColPri) {                                                    # If $PolicyRuleColPri has a value
                    $PolicyRuleColPriArray = $PolicyRuleColPri.ToCharArray()                # Converts $PolicyRuleColPri to array
                    foreach ($_ in $PolicyRuleColPriArray) {                                # For each item in $PolicyRuleColPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $PolicyRuleColPri = $null                                       # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $PolicyRuleColPriArray) 
                }                                                                           # End if ($PolicyRuleColPri)                                                                     
                if ($PolicyRuleColPri) {                                                    # If $PolicyRuleColPri has a value
                    $PolicyRuleColPriInt = [Int]$PolicyRuleColPri                           # Converts $PolicyRuleColPri to Int
                    if ($PolicyRuleColPriInt -lt 100 -or $PolicyRuleColPriInt -gt 65000) {  # If $PolicyRuleColPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $PolicyRuleColPri = $null                                           # Clears $var
                    }                                                                       # End if ($PolicyRuleColPriInt -lt 100 -or $PolicyRuleColPriInt -gt 65000)            
                    $PolicyRuleColPriInt = $null                                            # Clears $var
                }                                                                           # End if ($PolicyRuleColPri)
                if ($PolicyRuleColPri) {                                                    # If $PolicyRuleColPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host `
                            'Use:'$PolicyRuleColPri' as the rule collection priority'       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPRuleColPri                                     # Breaks SetAzureFWPRuleColPri
                         }                                                                  # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $PolicyRuleColPri = $null                                       # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureFWPRuleCollection                                 # Breaks :SetAzureFWPRuleCollection
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($PolicyRuleColPri)
                else {                                                                      # Else if $PolicyRuleColPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRuleColPri))
            }                                                                               # End :SetAzureFWPRuleColPri while ($true) 
            :SetAzureFWPRuleColType while ($true) {                                         # Inner loop for selecting the rule collection type
                Write-Host 'Rule collection type'                                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Application/Network'                                        # Write message to screen
                Write-Host '[2] NAT'                                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the rule collection type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureFWPRuleCollection                                         # Break s:SetAzureFWPRuleCollection
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $PolicyRuleColType = 'FirewallPolicyFilterRuleCollection'               # Sets $PolicyRuleColType
                    Break SetAzureFWPRuleColType                                            # Breaks :SetAzureFWPRuleColType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $PolicyRuleColType = 'FirewallPolicyNatRuleCollection'                  # Sets $PolicyRuleColType
                    Break SetAzureFWPRuleColType                                            # Breaks :SetAzureFWPRuleColType
                }                                                                           # End elseif ($OpSelect -eq '2')
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen          
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureFWPRuleColType while ($true)
            if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection') {              # If $PolicyRuleColType equals 'FirewallPolicyFilterRuleCollection'
                :SetAzureFWPRuleColAType while ($true) {                                    # Inner loop for selecting the rule collection action type
                    Write-Host 'Rule collection action type'                                # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Allow'                                                  # Write message to screen
                    Write-Host '[2] Deny'                                                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the rule collection type
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break SetAzureFWPRuleCollection                                     # Break s:SetAzureFWPRuleCollection
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Else if $OpSelect equals '1' 
                        $PolicyRuleColAType = 'Allow'                                       # Sets $PolicyRuleColType
                        Break SetAzureFWPRuleColAType                                       # Breaks :SetAzureFWPRuleColAType
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect equals '3'
                        $PolicyRuleColAType = 'Deny'                                        # Sets $PolicyRuleColType
                        Break SetAzureFWPRuleColAType                                       # Breaks :SetAzureFWPRuleColAType
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else  {                                                                 # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen          
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SetAzureFWPRuleColType while ($true)          
            }                                                                               # End if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection')
            Write-Host 'Build the following rule collection'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Name:               '$PolicyRuleColName                             # Write message to screen
            Write-Host 'Priority:           '$PolicyRuleColPri                              # Write message to screen
            Write-Host 'Type:               '$PolicyRuleColType                             # Write message to screen
            if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection') {              # If $PolicyRuleColType equals 'FirewallPolicyFilterRuleCollection'
                Write-Host 'Action:             '$PolicyRuleColAType                        # Write message to screen
            }                                                                               # End if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection')
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Firewall Policy RCG:'$FWPolicyRCGObject.Name                        # Write message to screen
            Write-Host 'Firewall Policy:    '$FWPolicyObject.Name                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the firewall rule collection
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                #Try {                                                                       # Try the following
                    $Rules = @()                                                            # Creates an empty rule array
                    Write-Host 'Creating the rule collection '                              # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection') {      # If $PolicyRuleColType equals 'FirewallPolicyFilterRuleCollection'
                        New-AzFirewallPolicyFilterRuleCollection -Name $PolicyRuleColName `
                            -Priority $PolicyRuleColPri -Rule $Rules -ActionType `
                            $PolicyRuleColAType -ErrorAction 'Stop' | Out-Null
                    }                                                                       # End if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection')
                    else {                                                                  # Else if $PolicyRuleColType does not equal 'FirewallPolicyFilterRuleCollection'
                        $rule = New-AzFirewallNatRule -Name 'Temp' -Protocol 'TCP' `
                            -SourceAddress '*' -DestinationAddress '10.0.0.1' `
                            -DestinationPort '80' -TranslatedAddress '10.0.0.2' `
                            -TranslatedPort '8080'                                          # Creates a temp rule
                        $RuleCollection = New-AzFirewallNatRuleCollection -Name `
                            $PolicyRuleColName -Priority $PolicyRuleColPri -Rule $Rule `
                            -ErrorAction 'Stop' #| Out-Null                                 # Creates the rule collection
                    }                                                                       # End else (if ($PolicyRuleColType -eq 'FirewallPolicyFilterRuleCollection'))
                    $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup `
                        -RuleCollection $RuleCollection -ErrorAction 'Stop' | Out-Null      # Saves the changes to the RCG
                
                #}                                                                           # End Try
                #Catch {                                                                     # If Try fails
                #    Clear-Host                                                              # Clears screen
                #    $MSG = $Error[0]                                                        # Gets the error message
                #    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                #    Write-Host 'An error has occured'                                       # Write message to screen
                #    Write-Host ''                                                           # Write message to screen
                #    Write-Warning $MSG                                                      # Write message to screen
                #    Write-Host ''                                                           # Write message to screen
                #    Write-Host 'No changes have been made'                                  # Write message to screen
                #    Write-Host ''                                                           # Write message to screen
                #    Pause                                                                   # Pauses all actions for operator input
                #    Break SetAzureFWPRuleCollection                                         # Breaks :SetAzureFWPRuleCollection    
                #}                                                                           # End Catch
                #Clear-Host                                                                  # Clears screen
                Write-Host 'The policy rule collection has been created'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureFWPRuleCollection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzFWPRuleCollection