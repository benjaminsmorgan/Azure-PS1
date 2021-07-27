# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzLoadBalancerRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBRuleConfig:       Function to remove a load balancer rule config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :RemoveAzureLBRuleConfig    Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $LoadBalancerObject:        Load balancer object
    $LBRuleObject:              Rule object    
    $OpConfirm:                 Operator confirmation to remove the configuration
    GetAzLBRuleConfig{}         Gets $LBRuleObject,$LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBRuleConfig > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject,$LoadBalancerObject
            End GetAzLBRuleConfig
                Return RemoveAzLBRuleConfig > Send $LBRuleObject,$LoadBalancerObject
        End RemoveAzLBRuleConfig
            Return function > Send $null
}#>
function RemoveAzLBRuleConfig {                                                             # Function to remove a load balancer rule config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBRuleConfig'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBRuleConfig while ($true) {                                            # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End if (!$LBRuleObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Config Name:'$LBRuleObject.Name                                     # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'                                        # Write message to screen
                    Remove-AzLoadBalancerRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBRuleObject.name `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                    Write-Host 'Saving changes'                                             # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'            # Saves the updated load balancer config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBRuleConfig                                           # Breaks :RemoveAzureLBRuleConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBRuleConfig