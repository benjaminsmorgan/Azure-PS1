# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.1.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.1.0
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/gew-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-6.0.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/GetAzLBNatRuleConfig.ps1
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
} #>
<# Functions Description: {
    SetAzLBNatRuleVM:           Function to associate a VM to a nat rule
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :SetAzureLBNatRuleVM        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Load balancer nat rule
    $LoadBalancerObject:        Load balancer object
    $NicIPConfigObject:         Nic IP configuration object
    $NicObject:                 Nic object
    $VMName:                    VM name attached to $NicObject
    $OpConfirm:                 Operator confirmation to complete this action
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
    GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleVM > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleVM > Send $LBNatRule, $LoadBalancerObject
            Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObjectt
            End GetAzNICIpConfig
                Return SetAzLBNatRuleVM > Send $NicIPConfigObject,$NicObject
        End SetAzLBNatRuleVM
            Return function > Send $null
}#>
function SetAzLBNatRuleVM {                                                                 # Function to associate a VM to a nat rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'SetAzLBNatRuleVM'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRuleVM while ($true) {                                                # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$LBNatRule)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicObject.VirtualMachine.ID) {                                            # If $NicObject.VirtualMachine.ID is $null
                Write-Host 'The selecting NIC config does not have an associated VM'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$NicObject.VirtualMachine.ID)
            if ($NicIPConfigObject.ID -in $LBNatRule.BackendIPConfiguration.ID) {           # If ($NicIPConfigObject.ID is in $LBNatRule.BackendIPConfiguration.ID
                Write-Host 'That IP config is already associated to this rule'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM    
            }                                                                               # End if ($NicIPConfigObject.ID -in $LBNatRule.BackendIPConfiguration.ID)
            $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                           # Isloates the VM name
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Add'                                                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'VM Name:      '$VMName                                              # Write message to screen
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To'                                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'Nat Rule:     '$LBNatRule.name                                      # Write message to screen
            Write-Host 'Nat Protocol: '$LBNatRule.Protocol                                  # Write message to screen
            Write-Host 'Nat FE Port:  '$LBNatRule.FrontendPort                              # Write message to screen
            Write-Host 'Nat BE Port:  '$LBNatRule.BackendPort                               # Write message to screen
            Write-Host 'Nat Idle TO:  '$LBNatRule.IdleTimeoutInMinutes                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding the IP config to nat rule'                           # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerInboundNatRuleId `
                        $LBNatRule.ID -ErrorAction 'Stop' | Out-Null                        # Adds the load balancer inbound nat rule
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRuleVM                                               # Breaks :SetAzureLBNatRuleVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration'                                       # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBNatRuleVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleVM