function SetAzFWPRuleCollPri {                                                              # Function to set a firewall policy rule collection priority
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzFWPRuleCollPri'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPRuleCollection while ($true) {                                          # Outer loop for managing function
            $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject = `
                GetAzFWPRuleCollection ($CallingFunction)                                   # Calls function and assigns output to $var
            if (!$FWPRuleCObject) {                                                         # If $FWPolicyRCGObject does not have a value
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if (!$FWPolicyRCGObject) 
            $ObjectArray = @()                                                              # Creates $ObjectArray
            foreach ($Pri in $FWPolicyRCGObject.Properties.RuleCollection.Priority) {       # For each item in $FWPolicyRCGObject.Properties.RuleCollection.Priority
                $ObjectArray += $Pri                                                        # Adds current item to $ObjectArray
            }                                                                               # End foreach ($Pri in $FWPolicyRCGObject.Properties.RuleCollection.Priority)
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPRuleCollPri while ($true) {                                         # Inner loop for setting the policy rule collection priority
                Write-Host 'Please enter the rule collection priority'                      # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The following priorities are already in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    Write-Host $_                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host ''                                                               # Write message to screen
                $RuleCollectionPri = Read-Host 'Priority [#]'                               # Operator input for the rule collection priority
                Clear-Host                                                                  # Clears screen
                if ($RuleCollectionPri -in $ObjectArray) {                                  # If $RuleCollectionPri in $ObjectArray
                    $RuleCollectionPri = $null                                              # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($RuleCollectionPri -in $ObjectArray)
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    $RuleCPriArray = $RuleCollectionPri.ToCharArray()                       # Converts $RuleCollectionPri to array
                    foreach ($_ in $RuleCPriArray) {                                        # For each item in $RuleCPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $RuleCollectionPri = $null                                      # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $RuleCPriArray) 
                }                                                                           # End if ($RuleCollectionPri)                                                                     
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    $RuleCPriInt = [Int]$RuleCollectionPri                                  # Converts $RuleCollectionPri to Int
                    if ($RuleCPriInt -lt 100 -or $RuleCPriInt -gt 65000) {                  # If $RuleCPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $RuleCollectionPri = $null                                          # Clears $var
                    }                                                                       # End if ($RuleCPriInt -lt 100 -or $RuleCPriInt -gt 65000)            
                    $RuleCPriInt = $null                                                    # Clears $var
                }                                                                           # End if ($RuleCollectionPri)
                if ($RuleCollectionPri) {                                                   # If $RuleCollectionPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Rule Col Name:   '$FWPRuleCObject.Name                  # Write message to screen
                        Write-Host 'Current priority:'$FWPRuleCObject.priority              # Write message to screen
                        Write-Host 'New priority:    '$RuleCollectionPri                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Make this change'                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPRuleCollPri                                    # Breaks SetAzureFWPRuleCollPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $RuleCollectionPri = $null                                      # Clears $var
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
                }                                                                           # End if ($RuleCollectionPri)
                else {                                                                      # Else if $RuleCollectionPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($RuleCollectionPri))
            }                                                                               # End :SetAzureFWPRuleCollPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Updating the rule collection priority'                          # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                $FWPRuleCObject.Priority = $RuleCollectionPri                               # Updates the rule collection priority
                $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup -ErrorAction `
                    'Stop' | Out-Null                                                       # Saves the changes to the RCG
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
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
                Break SetAzureFWPRuleCollection                                                   # Breaks :SetAzureFWPRuleCollection    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection has been updated'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureFWPRuleCollection                                                       # Breaks :SetAzureFWPRuleCollection
        }                                                                                   # End :SetAzureFWPRuleCollection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzFWPRuleCollPri