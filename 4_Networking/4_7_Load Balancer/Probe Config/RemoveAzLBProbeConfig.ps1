# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzLoadBalancerProbeConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerprobeconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/GetAzLBProbeConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBProbeConfig:      Function to remove a load balancer probe config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
} #>
<# Variables: {      
    :RemoveAzureLBProbeConfig   Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $LoadBalancerObject:        Load balancer object
    $LBProbeObject:             Probe object    
    $OpConfirm:                 Operator confirmation to remove the configuration
    GetAzLBProbeConfig{}        Gets $LBProbeObject,$LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBProbeConfig > Get $null
            Call GetAzLBProbeConfig > Get $LBProbeObject,$LoadBalancerObject
            End GetAzLBProbeConfig
                Return RemoveAzLBProbeConfig > Send $LBProbeObject,$LoadBalancerObject
        End RemoveAzLBProbeConfig
            Return function > Send $null
}#>
function RemoveAzLBProbeConfig {                                                            # Function to remove a load balancer probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBProbeConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBProbeConfig while ($true) {                                           # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            if ($LBProbeObject.LoadBalancingRules.ID) {                                     # If $LBProbeObject.LoadBalancingRules.ID
                Write-Host 'This probe config must be removed from the'                     # Write message to screen
                Write-Host 'following rules before it can be removed:'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $LBProbeObject.LoadBalancingRules.ID) {                      # For each item in $LBProbeObject.LoadBalancingRules.ID
                    $RuleName = $_                                                          # Isolates the current item
                    $RuleName = $RuleName.Split('/')[-1]                                    # Isolates the rule name
                    Write-Host $RuleName                                                    # Write message to screen
                }                                                                           # End foreach ($_ in $LBProbeObject.LoadBalancingRules.ID)
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig    
            }                                                                               # End if ($LBProbeObject.LoadBalancingRules.ID)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Config Name:'$LBProbeObject.Name                                    # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'                                        # Write message to screen
                    Remove-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBProbeObject.name `
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
                    Break RemoveAzureLBProbeConfig                                          # Breaks :RemoveAzureLBProbeConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBProbeConfig                                              # Breaks :RemoveAzureLBProbeConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBProbeConfig