function RemoveAzFWPRuleCollection {                                                        # Function to remove a firewall policy rule collection
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPRuleCollection'                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPRuleCollection while ($true) {                                          # Outer loop for managing function
            $FWPRuleCObject, $FWPolicyRCGObject, $FWPolicyObject = `
                GetAzFWPRuleCollection ($CallingFunction)                                   # Calls function and assigns output to $var
            if (!$FWPRuleCObject) {                                                         # If $FWPRuleCObject does not have a value
                Break SetAzureFWPRuleCollection                                             # Breaks :SetAzureFWPRuleCollection
            }                                                                               # End if (!$FWPRuleCObject) 
            Write-Host 'Remove Rule Collection:  '$FWPRuleCObject.Name                      # Write message to screen
            Write-Host 'From Firewall Policy RCG:'$FWPolicyRCGObject.Name                   # Write message to screen
            Write-Host 'On Firewall Policy:      '$FWPolicyObject.Name                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the firewall rule collection
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
            #    Try {                                                                       # Try the following
                    Write-Host 'Updating the rule collection priority'                      # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    $ObjectArray = @()                                                      # Creates $ObjectArray
                    foreach ($RuleC in $FWPolicyRCGObject.Properties.RuleCollection) {      # For each item in $FWPolicyRCGObject.Properties.RuleCollection
                        if ($RuleC.Name -ne $FWPRuleCObject.Name) {                         # If current item .name does not equal $FWPRuleCObject.Name
                            $CurrentRule = New-AzFirewallPolicyFilterRuleCollection -Name `
                            $RuleC.name -Priority $RuleC.Priority -Rule $RuleC.Rules `
                            -ActionType $RuleC.Action.Type
                            $ObjectArray += $CurrentRule                                    # Adds current item to $ObjectArray
                        }                                                                   # End if ($RuleC.Name -ne $FWPRuleCObject.Name)
                    }                                                                       # End foreach ($Name in $FWPolicyRCGObject.Properties.RuleCollection)
                    $FWPolicyRCGObject.Properties.RuleCollection = $ObjectArray             # Replaces the rule collection list with $ObjectArray
                    $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the changes to the RCG
            #    }                                                                           # End Try
            #    Catch {                                                                     # If Try fails
            #        Clear-Host                                                              # Clears screen
            #        $MSG = $Error[0]                                                        # Gets the error message
            #        $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
            #        Write-Host 'An error has occured'                                       # Write message to screen
            #        Write-Host ''                                                           # Write message to screen
            #        Write-Warning $MSG                                                      # Write message to screen
            #        Write-Host ''                                                           # Write message to screen
            #        Write-Host 'No changes have been made'                                  # Write message to screen
            #        Write-Host ''                                                           # Write message to screen
            #        Pause                                                                   # Pauses all actions for operator input
            #        Break SetAzureFWPRuleCollection                                         # Breaks :SetAzureFWPRuleCollection    
            #    }                                                                           # End Catch
            #    Clear-Host                                                                  # Clears screen
                Write-Host 'The policy rule collection has been removed'                    # Write message to screen
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
}                                                                                           # End function RemoveAzFWPRuleCollection