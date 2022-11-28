# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.1.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBBEPoolVM:         Function to remove a VM from a back end pool
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :SetAzureLBBEPoolVM         Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         Nic IP configuration object
    $NicObject:                 Nic object
    $BackEndPoolID:             ID of the back end pool on $NicIPConfigObject
    $LBBackEndObject:           Load balancer back end pool object
    $LoadBalancerObject:        Load balancer object
    $VMName:                    VM name
    $OpConfirm:                 Operator confirmation to make this change
    GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBBEPoolVM > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
            End GetAzNICIpConfig
                Return GetAzLBBEPoolConfig > Send $NicIPConfigObject,$NicObject
        End RemoveAzLBBEPoolVM
            Return function > Send $null
}#>
function RemoveAzLBBEPoolVM {                                                               # Function to remove a VM from a back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'RemoveAzLBBEPoolVM'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBBEPoolVM while ($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicIPConfigObject.LoadBalancerBackendAddressPools.ID) {                   # If $NicIPConfigObject.LoadBalancerBackendAddressPools.ID is $null
                Write-Host 'The selected NIC config is not associated with a back end pool' # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject.LoadBalancerBackendAddressPools.ID)
            $BackEndPoolID = $NicIPConfigObject.LoadBalancerBackendAddressPools.ID          # Isolates the back end pool ID
            $LoadBalancerObject = Get-AzLoadBalancer | Where-Object `
                {$_.BackendAddressPools.ID -eq $BackEndPoolID}                              # Gets the load balancer object
            $LBBackEndObject = $BackEndPoolID.Split('/')[-1]                                # Isolates the back end pool name
            if ($NicObject.VirtualMachine.ID) {                                             # If $NicObject.VirtualMachine.ID has a value
                $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                       # Isloates the VM name
            }                                                                               # End if ($NicObject.VirtualMachine.ID)
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Remove:'                                                            # Write message to screen
            if ($VMName) {                                                                  # If $VMName has a value
                Write-Host 'VM Name:      '$VMName                                          # Write message to screen
            }                                                                               # End if ($VMName)
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'From:'                                                              # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'BE Pool:      '$LBBackEndObject                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the IP config from back end pool'                  # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerBackendAddressPoolId `
                        $null -ErrorAction 'Stop' | Out-Null                                # Removes the nic from load balancer back end pool
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBBEPoolVM                                                # Breaks :SetAzureLBBEPoolVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration, This may take a moment'               # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBBEPoolVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBBEPoolVM