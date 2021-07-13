# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.0
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.2.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.0
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/gew-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/GetAzLBNatRuleConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBNatRuleVM:        Function to change to remove a VM from exist nat rule
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    $CallingFunction:           Name of this function or the on that called it
    $LBNatRule:                 Load balancer nat rule object
    $LoadBalancerObject:        Load balancer object
    $NicIPConfigID:             $LBNatRule.BackendIPConfiguration.ID 
    $NicIPConfigName:           Nic IP config object name
    $NicName:                   Nic object name
    $NicObject:                 Nic object
    $NicIPConfigObject:         Nic IP config object
    $VMObject:                  VM object
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBNatRuleVM > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return RemoveAzLBNatRuleVM > Send $LBNatRule, $LoadBalancerObject
        End RemoveAzLBNatRuleVM
            Return function > Send $null
}#>
function RemoveAzLBNatRuleVM {                                                              # Function to change to remove a VM from exist nat rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBNatRuleVM'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            if (!$LBNatRule.BackendIPConfiguration.ID) {                                    # If $LBNatRule.BackendIPConfiguration.ID is $null
                Write-Host 'No target VM is associated to this nat rule'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule.BackendIPConfiguration.ID) 
            Write-Host 'Gathering additional information'                                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $NicIPConfigID = $LBNatRule.BackendIPConfiguration.ID                           # Isolates $LBNatRule.BackendIPConfiguration.ID
            $NicIPConfigName = $NicIPConfigID.Split('/')[-1]                                # Isolates the nic IP config name
            $NicName = $NicIPConfigID.Split('/')[8]                                         # Isolates the nic name
            $NicObject = Get-AzNetworkInterface -Name $NicName                              # Gets the network interface
            $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                $NicObject -Name $NicIPConfigName                                           # Gets the nic ip configuration
            $VMObject = Get-AzVM | Where-Object `
                {$_.NetworkProfile.NetworkInterfaces.ID -eq $NicObject.ID}                  # Gets the target VM
            Clear-Host                                                                      # Clears screen
            Write-Host 'Remove'                                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'VM name:  '$VMObject.Name                                           # Write message to screen
            if ($VMObject.OSProfile.LinuxConfiguration) {                                   # If $VMObject.OSProfile.LinuxConfiguration has a value
                Write-Host 'VM OS:     Linux'                                               # Write message to screen
            }                                                                               # End if ($VMObject.OSProfile.LinuxConfiguration)
            else {                                                                          # Else if $VMObject.OSProfile.LinuxConfiguration is $null
                Write-Host 'VM OS:     Windows'                                             # Write message to screen
            }                                                                               # End else (if ($VMObject.OSProfile.LinuxConfiguration))
            Write-Host 'Nic name: '$NicObject.Name                                          # Write message to screen
            Write-Host 'IP Config:'$NicIPConfigObject.Name                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'From'                                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Nat Rule: '$LBNatRule.Name                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the nat rule target VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'    
                Write-Host 'Removing the VM from nat rule'                                  # Write message to screen
                Try {                                                                       # Try the following
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                    $NicIPConfigObject.Name -LoadBalancerInboundNatRuleId `
                    $null -ErrorAction 'Stop' | Out-Null                                    # Adds the load balancer inbound nat rule
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRule                                                 # Breaks :SetAzureLBNatRule
                }                                                                           # End catch
                Write-Host 'Saving nic configuration'                                       # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                    
        }                                                                                   # End :SetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBNatRuleVM