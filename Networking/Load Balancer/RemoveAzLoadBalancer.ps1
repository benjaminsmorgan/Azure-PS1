# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzLoadBalancer:      https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancer?view=azps-5.5.0  
    Get-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0  
} #>
<# Required Functions Links: {
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
} #>
<# Functions Description: {
    RemoveAzLoadBalancer:       Removes an existing load balancer
    GetAzLoadBalancer:          Gets an existing load balancer
} #>
<# Variables: {
    :RemoveAzureLoadBalancer    Outer loop for managing function
    $LoadBalancerObject:        Load balancer object
    $CallingFunction:           Name of the current function
    $OperatorConfirm:           Operator confirmation for removing the load balancer
    GetAzLoadBalancer{}         Get $LoadBalancerObject
} #>
<# Process Flow {
    Function
        Call RemoveAzLoadBalancer > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return RemoveAzLoadBalancer > Send $LoadBalancerObject
        End RemoveAzLoadBalancer
            Return function > Send $null
}#>
function RemoveAzLoadBalancer {                                                             # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                $CallingFunction = 'RemoveAzLoadBalancer'                                   # Sets $CallingFunction
                $LoadBalancerObject=GetAzLoadBalancer ($CallingFunction)                    # Calls function and assigns output to $var
                if (!$LoadBalancerObject) {                                                 # If $LoadBalancerObject does not have a value
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End if (!$LoadBalancerObject)
            }                                                                               # End if (!$LoadBalancerObject)
            Write-Host 'Remove the load balancer named:'$LoadBalancerObject.name            # Write message to screen
            Write-Host 'from the resource group:'$LoadBalancerObject.ResourceGroupName      # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Nic
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzLoadBalancer -Name $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.ResourceGroupName -Force -ErrorAction 'Stop'    # Removes the selected load balancer
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End catch
                Write-Host 'The selected load balancer has been removed'                    # Write message to screen
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # All other inputs for $OperatorConfirm
                Break RemoveAzureLoadBalancer                                                        # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End else (If ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLoadBalancer