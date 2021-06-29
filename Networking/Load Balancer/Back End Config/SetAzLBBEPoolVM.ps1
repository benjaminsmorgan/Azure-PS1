# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.1.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBBEPoolConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Back%20End%20Config/GetAzLBBEPoolConfig.ps1
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
} #>
<# Functions Description: {
    SetAzLBBEPoolVM:            Function to associate a VM to a back end pool
    GetAzLBBEPoolConfig:        Function to get an existing load balancer back end pool config
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :SetAzureLBBEPoolVM         Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBBackEndObject:           Load balancer back end pool object
    $LoadBalancerObject:        Load balancer object
    $NicIPConfigObject:         Nic IP configuration object
    $NicObject:                 Nic object
    $VMName:                    VM name
    $OpConfirm:                 Operator confirmation to make this change
    GetAzLBBEPoolConfig{}       Gets $LBBackEndObject, $LoadBalancerObject
    GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
} #>
<# Process Flow {
    function
        Call SetAzLBBEPoolVM > Get $null
            Call GetAzLBBEPoolConfig > Get $LBBackEndObject, $LoadBalancerObject
            End GetAzLBBEPoolConfig
                Return SetAzLBBEPoolVM > Send $LBBackEndObject, $LoadBalancerObject
            Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
            End GetAzNICIpConfig
                Return GetAzLBBEPoolConfig > Send $NicIPConfigObject,$NicObject
        End GetAzLBBEPoolConfig
            Return function > Send $null
}#>
function SetAzLBBEPoolVM {                                                                  # Function to associate a VM to a back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'SetAzLBBEPoolVM'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBBEPoolVM while ($true) {                                                 # Outer loop for managing function
            $LBBackEndObject, $LoadBalancerObject = GetAzLBBEPoolConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$LBBackEndObject) {                                                        # If $LBBackEndObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$LBBackEndObject)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicObject.VirtualMachine.ID) {                                            # If $NicObject.VirtualMachine.ID is $null
                Write-Host 'The selecting NIC config does not have an associated VM'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicObject.VirtualMachine.ID)
            if ($NicIPConfigObject.ID -in $LBBackEndObject.BackendIpConfigurations.ID) {    # If ($NicIPConfigObject.ID is in $LBBackEndObject.BackendIpConfigurations.ID 
                Write-Host 'That IP config is already associated to this pool'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM    
            }                                                                               # End if ($NicIPConfigObject.ID -in $LBBackEndObject.BackendIpConfigurations.ID)
            $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                           # Isloates the VM name
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Add:'                                                               # Write message to screen
            Write-Host 'VM Name:      '$VMName                                              # Write message to screen
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To:'                                                                # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'BE Pool:      '$LBBackEndObject.name                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding the IP config to back end pool'                      # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerBackendAddressPoolId `
                        $LBBackEndObject.ID -ErrorAction 'Stop' | Out-Null                  # Adds the load balancer back end pool
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
}                                                                                           # End function SetAzLBBEPoolVM