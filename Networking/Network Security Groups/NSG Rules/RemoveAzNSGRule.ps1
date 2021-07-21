# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzNetworkSecurityRuleConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
    GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
} #>
<# Functions Description: {
    RemoveAzNSGRule:            Function to remove a network security group rule
    GetAzAllNSGsRule:           Function to get a rule from all network security groups
    GetAzNSGRule:               Function to get a network security group rule
    GetAzNSG:                   Function to get a network security group
} #>
<# Variables: {      
    :RemoveAzureNSGRule         Outer loop for managing function
    :GetAzureNSGRule            Inner loop for selecting the rule
    $CallingFunction:           Name of this function or the one that called it
    $OpSelect:                  Operator input to select how to get the rule
    $NSGRuleObject:             NSG rule object
    $NSGObject:                 Network security group object
    $OpConfirm:                 Operator confirmation to remove the rule
    GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
    GetAzNSG{}                  Gets $NSGObject
    GetAzNSGRule{}              Gets $NSGRuleObject
} #>
<# Process Flow {
    function
        Call RemoveAzNSGRule > Get $null
            Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
            End GetAzAllNSGsRule
                Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
            Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return GetAzNSGRule > Send $NSGObject
            End GetAzNSGRule
                Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
        End RemoveAzNSGRule
            Return function > Send $null
}#>

function RemoveAzNSGRule {                                                                  # Function to remove a network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'RemoveAzNSGRule'                                            # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNSGRule while ($true) {                                                 # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:       '$NSGRuleObject.Name                               # Write message to screen
            Write-Host 'Access:          '$NSGRuleObject.Access                             # Write message to screen
            Write-Host 'Protocol:        '$NSGRuleObject.Protocol                           # Write message to screen
            Write-Host 'Priority:        '$NSGRuleObject.Priority                           # Write message to screen
            Write-Host 'Direction:       '$NSGRuleObject.Direction                          # Write message to screen
            Write-Host 'Source Port:     '$NSGRuleObject.SourcePortRange                    # Write message to screen
            Write-Host 'Destination Port:'$NSGRuleObject.DestinationPortRange               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing network security group rule'                           # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleObject.Name -ErrorAction 'Stop' | Out-Null            # Removes the network security group rule
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen   
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule
                }                                                                           # End catch
                Write-Host 'Saving network security group config'                           # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves the updated network security group
                Clear-Host                                                                  # Clears screen
                Write-Host 'The network security group rule has been removed'               # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {
                Write-Host 'No changes have been made'
                Write-Host ''
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :RemoveAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGRule