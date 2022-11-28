# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/set-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    Get-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicyrulecollectiongroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFWPolicyRCG:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/Policy%20Rule%20Collection%20Group/GetAzFWPolicyRCG.ps1
} #>
<# Functions Description: {
    SetAzFWPolicyRCGPri:        Function to set a firewall policy rule collection group priority
    GetAzFWPolicyRCG:           Function to get firewall policy rule collection group
} #>
<# Variables: {      
    :SetAzureFWPolicyRCG        Outer loop for managing function
    :SetAzureFWPolicyRCGPri     Inner loop for setting the rule collection group priority
    :ConfirmSetting             Inner loop for confirming the RCG priority
    $CallingFunction:           Name of this function or the one that called it
    $FWPolicyObject:            Firewall policy object
    $ObjectArray:               Array of rule collection group priorities
    $RuleCollectGroups:         $FWPolicyObject.RuleCollectionGroups  
    $RCGObject:                 Current item RCG object
    $RCGPriority:               $RCGObject.Properties.Priority             
    $ValidArray:                Array of characters for $PolicyRCGPri
    $PolicyRCGPri:              Operator input for the RCG priority
    $PolicyRCGPriArray:         $PolicyRCGPri converted to array
    $PolicyRCGPriInt:           $PolicyRCGPri converted to integer
    $OpConfirm:                 Operator confirmation on the RCG priority
    $MSG:                       Last powershell error message
    GetAzFWPolicyRCG{}          Gets $FWPolicyRCGObject, $FWPolicyObject
} #>
<# Process Flow {
    function
        Call SetAzFWPolicyRCGPri > Get $null
            Call GetAzFWPolicyRCG > Get $FWPolicyRCGObject, $FWPolicyObject           
            End GetAzFWPolicyRCG
                Return SetAzFWPolicyRCGPri > Send $FWPolicyRCGObject, $FWPolicyObject 
        End SetAzFWPolicyRCGPri
            Return function > Send $null
}#>
function SetAzFWPolicyRCGPri {                                                              # Function to set a firewall policy rule collection group priority
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzFWPolicyRCGPri'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break SetAzureFWPolicyRCG                                                   # Breaks :SetAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyRCGObject) 
            if ($FWPolicyObject.RuleCollectionGroups) {                                     # If $FWPolicyObject.RuleCollectionGroups has a value
                $ObjectArray = @()                                                          # Creates $ObjectArray
                $RuleCollectGroups = $FWPolicyObject.RuleCollectionGroups                   # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $RCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicyObject.Name                       # Gets current item RCGObject
                    $RCGPriority = $RCGObject.Properties.Priority                           # Gets the $RCGObject priority
                    $ObjectArray += $RCGPriority                                            # Adds $RCGPriority to $ObjectArray
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
            }                                                                               # End if ($FWPolicyObject.RuleCollectionGroups)
            $CurrentPriority = $FWPolicyRCGObject.Properties.Priority
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPolicyRCGPri while ($true) {                                         # Inner loop for setting the policy rule collection group priority
                Write-Host 'Please enter the rule collection group priority'                # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following priorities are already in use'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                }                                                                           # End if ($ObjectArray)
                Write-Host ''                                                               # Write message to screen
                $PolicyRCGPri = Read-Host 'Priority [#]'                                    # Operator input for the RCG priority
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGPri -in $ObjectArray) {                                       # If $PolicyRCGPri in $ObjectArray
                    $PolicyRCGPri = $null                                                   # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PolicyRCGPri -in $ObjectArray)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriArray = $PolicyRCGPri.ToCharArray()                        # Converts $PolicyRCGPri to array
                    foreach ($_ in $PolicyRCGPriArray) {                                    # For each item in $PolicyRCGPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $PolicyRCGPri = $null                                           # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $PolicyRCGPriArray) 
                }                                                                           # End if ($PolicyRCGPri)                                                                     
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriInt = [Int]$PolicyRCGPri                                   # Converts $PolicyRCGPri to Int
                    if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000) {          # If $PolicyRCGPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $PolicyRCGPri = $null                                               # Clears $var
                    }                                                                       # End if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000)            
                    $PolicyRCGPriInt = $null                                                # Clears $var
                }                                                                           # End if ($PolicyRCGPri)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Current priority:'$CurrentPriority                      # Write message to screen
                        Write-Host 'New priority:    '$PolicyRCGPri                         # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Make this change'                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPolicyRCGPri                                    # Breaks SetAzureFWPolicyRCGPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $PolicyRCGPri = $null                                           # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureFWPolicyRCG                                       # Breaks :SetAzureFWPolicyRCG
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($PolicyRCGPri)
                else {                                                                      # Else if $PolicyRCGPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGPri))
            }                                                                               # End :SetAzureFWPolicyRCGPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Updating the policy rule collection group'                      # Write message to screen   
                Write-Host 'This may take a moment'                                         # Write message to screen
                $FWPolicyRCGObject.Properties.Priority = $PolicyRCGPri
                $FWPolicyRCGObject | Set-AzFirewallPolicyRuleCollectionGroup `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the policy rule collection group
            }                                                                               # End try
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
                Break SetAzureFWPolicyRCG                                                   # Breaks :SetAzureFWPolicyRCG    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection group has been updated'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureFWPolicyRCG                                                       # Breaks :SetAzureFWPolicyRCG
        }                                                                                   # End :SetAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzFWPolicyRCGPri  