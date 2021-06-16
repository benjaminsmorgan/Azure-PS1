# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzLoadBalancer:                      https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancer?view=azps-5.5.0  
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
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
    $VmssID:                    $LoadBalancerObject.BackendAddressPools.BackendIpConfigurations.id
    $VmssRG:                    Resource group of $VmssID
    $VmssName:                  Vmss name of $VmssID                   
    $CallingFunction:           Name of the current function
    $OpConfirm:                 Operator confirmation for removing the load balancer
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
function RemoveAzLoadBalancer {                                                             # Function to remove a load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLoadBalancer'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.BackendAddressPools.BackendIpConfigurations.id) {       # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                $VmssID = `
                    $LoadBalancerObject.BackendAddressPools.BackendIpConfigurations.id      # Isolates .BackendAddressPools.BackendIpConfigurations.id
                $VmssRG = $VmssID.Split('/')[4]                                             # Isolates the Vmss resource group
                $VmssName = $VmssID.Split('/')[8]                                           # Isolates the Vmss name
                Write-Host 'This load balancer is in use, disconnect'                       # Write message to screen
                Write-Host 'the following to remove the load balancer:'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Vmss name:'$VmssName                                            # Write message to screen
                Write-Host 'Vmss RG:  '$VmssRG                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer    
            }                                                                               # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing load balancer'
                    Remove-AzLoadBalancer -Name $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.ResourceGroupName -Force -ErrorAction 'Stop'    # Removes the selected load balancer
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The load balancer has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLoadBalancer