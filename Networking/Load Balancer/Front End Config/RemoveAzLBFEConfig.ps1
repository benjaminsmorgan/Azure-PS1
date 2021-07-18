# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzLoadBalancerFrontendIpConfig:      https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-6.1.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    GetAzLBFEConfig:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Front%20End%20Config/GetAzLBFEConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBFEConfig:         Removes a front end configurations from a load balancer
    GetAzLBFEConfig:            Gets a front end configuration for a load balancer  
} #>
<# Variables: {      
    :RemoveAzureLBFEConfig      Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $LoadBalancerObject:        Load balancer object
    $LBFEObject:                Front end configuration object    
    $OpConfirm:                 Operator confirmation to remove the configuration
    GetAzLBFEConfig{}           Gets $LBFEObject,$LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBFEConfig > Get $null
            Call GetAzLBFEConfig > Get $LBFEObject,$LoadBalancerObject
            End GetAzLBFEConfig
                Return RemoveAzLBFEConfig > Send $LBFEObject,$LoadBalancerObject
        End RemoveAzLBFEConfig
            Return function > Send $null
}#>
function RemoveAzLBFEConfig {                                                               # Function to remove a load balancer front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBFEConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBFEConfig while ($true) {                                              # Outer loop for managing function
            $LBFEObject,$LoadBalancerObject = GetAzLBFEConfig ($CallingFunction)            # Calls function and assigns output to $var
            if (!$LBFEObject) {                                                             # If $LBFEObject is $null
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if (!$LBFEObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'Config Name:'$LBFEObject.Name                                       # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'                                        # Write message to screen
                    Remove-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBFEObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBFEConfig                                             # Breaks :RemoveAzureLBFEConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBFEConfig