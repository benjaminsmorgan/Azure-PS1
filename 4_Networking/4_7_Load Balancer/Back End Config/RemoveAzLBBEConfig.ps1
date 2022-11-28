# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzLoadBalancerBackendAddressPool:    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBBEPoolConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Back%20End%20Config/GetAzLBBEPoolConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBBEConfig:         Function to remove a load balancer back end pool config
    GetAzLBBEPoolConfig:        Function to get an existing load balancer back end pool config 
} #>
<# Variables: {      
    :RemoveAzureLBBEConfig      Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $LoadBalancerObject:        Load balancer object
    $LBBackEndObject:           Back end pool object    
    $OpConfirm:                 Operator confirmation to remove the configuration
    GetAzLBBEPoolConfig{}       Gets $LBBackEndObject,$LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBBEConfig > Get $null
            Call GetAzLBBEPoolConfig > Get $LBBackEndObject, $LoadBalancerObject
            End GetAzLBBEPoolConfig
                Return RemoveAzLBBEConfig > Send $LBBackEndObject, $LoadBalancerObject
        End RemoveAzLBBEConfig
            Return function > Send $null
}#>
function RemoveAzLBBEConfig {                                                               # Function to remove a load balancer back end pool config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBBEConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBBEConfig while ($true) {                                              # Outer loop for managing function
            $LBBackEndObject, $LoadBalancerObject = GetAzLBBEPoolConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$LBBackEndObject) {                                                        # If $LBBackEndObject is $null
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End if (!$LBBackEndObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'Config Name:'$LBBackEndObject.Name                                  # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'
                    Remove-AzLoadBalancerBackendAddressPool -LoadBalancer `
                        $LoadBalancerObject -Name $LBBackEndObject.name `
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
                    Break RemoveAzureLBBEConfig                                             # Breaks :RemoveAzureLBBEConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBBEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBBEConfig