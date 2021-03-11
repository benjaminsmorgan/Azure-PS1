# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVmssConfig:           https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssconfig
    New-AzVmssIPConfig:         https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssipconfig
    Add-AzVmssNetworkInterfaceConfiguration: https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmssnetworkinterfaceconfiguration
    New-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmss
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.5.0
    Set-AzVmssOsProfile:        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssosprofile
    Set-AzVmssStorageProfile:   https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssstorageprofile
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup
    Get-AzVMImageOffer:         https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimageoffer
    Get-AzVMImageSku:           https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku
    Get-AzVMImage:              https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimage
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize
    Get-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer
    New-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer
    New-AzLoadBalancerFrontendIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig
    New-AzLoadBalancerProbeConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerprobeconfig
    New-AzLoadBalancerInboundNatPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerinboundnatpoolconfig
    New-AzLoadBalancerRuleConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.6.0
    Get-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Remove-AzVmss:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmss?view=azps-5.6.0
    Get-AzVmssVM:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmssvm?view=azps-5.6.0
    Start-AzVmss:               https://docs.microsoft.com/en-us/powershell/module/az.compute/start-azvmss?view=azps-5.6.0
    Stop-AzVmss:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Stop-azvmss?view=azps-5.6.0
} #>
<# Required Functions Links: {
    SetAzVmssOsProfile:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssOsProfile.ps1
    SetAzVmssStorageProfile:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssStorageProfile.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
    GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
    NewAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLoadBalancer.ps1
    NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
    NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
    NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
    NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
    NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
    GetAzVmss:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmSS.ps1
    RemoveAzVmss:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/RemoveAzVmss.ps1
    GetAzVmssVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmssVM.ps1
    StartAzVmss:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/StartAzVmss.ps1
    StopAzVmss:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/StopAzVmss.ps1
} #>
<# Functions Description: {
    GetAzVMSize:                Function for setting the VM size
    NewAzVmss:                  Function for creating a new Vmss
    SetAzVmssOsProfile:         Function for setting Vmss username and password
    SetAzVmssStorageProfile:    Function for setting up Vmss storage for new instances
    GetAzVirtualNetwork:        Gets an existing virtual network
    AddAzVNetSubnetConfig:      Adds a new subnet
    GetAzVNetSubnetConfig:      Gets an existing subnet
    GetAzResourceGroup:         Gets an existing resource group
    SetAzVMOS:                  Gets an Azure OS image config
    GetAzVMSize:                Gets an Azure VM sku
    GetAzLoadBalancer:          Gets an existing load balancer
    NewAzLoadBalancer:          Creates a new load balancer
    NewAzLBFrontendIpConfig:    Creates a load balancer front end config 
    NewAzPublicIpAddress:       Creates a new public ip sku
    GetAzPublicIpAddress:       Gets an existing public ip sku
    NewAzLBBackendIpConfig:     Creates a load balancer back end IP config
    NewAzLBProbeConfig:         Creates a load balancer health probe
    NewAzLBIBNatPoolConfig:     Creates a load balancer inbound nat pool
    NewAzLBRuleConfig:          Creates a load balancer rule
    RemoveAzVmss:               Removes a Vmss
    GetAzVmss:                  Gets a Vmss
    GetAzVmssVM:                Gets a Vmss instance
    StartAzVmss:                Starts instances of a Vmss
    StopAzVmss:                 Stops instances of a Vmss
} #>
<# Variables: {      
    :ManageAzureVmss            Outer loop for managing function
    $VmssObject:                Vmss object
    $VmssVMObject:              Vmms instance object
    $OperatorSelect:            Operator input for function selection
    NewAzVmss{}                 Creates $VmssObject    
        GetAzResourceGroup{}        Gets $RGObject
        GetAzVMSize{}               Gets $VMSizeObject
        SetAzVmssOsProfile{}        Gets $VmssOSProfileObject
            SetAzVMOS{}                 Gets $VMImageObject
        SetAzVmssStorageProfile{}   Gets $VmssStorageProfileObject
        NewAzLoadBalancer{}         Creates $LoadBalancerObject
            GetAzResourceGroup{}        Gets $RGObject
            NewAzLBFrontendIpConfig{}   Creates $FrontEndIPConfigObject
                NewAzPublicIpAddress{}      Creates $PublicIPObject
                    GetAzResourceGroup{}        Gets $RGObject
                GetAzPublicIpAddress{}      Gets $PublicIPObject
            NewAzLBBackendIpConfig{}    Creates $BackEndIPConfigObject
            NewAzLBProbeConfig{}        Creates $HealthProbeObject
            NewAzLBIBNatPoolConfig{}    Creates $InboundNatPoolObject
            NewAzLBRuleConfig{}         Creates $LoadBalanceRule
        GetAzLoadBalancer{}         Gets $LoadBalancerObject
        AddAzVNetSubnetConfig{}     Creates $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
    GetAzVmssObject{}           Gets $VmssObject
    RemoveAzVmssObject{}        Removes $VmssObject
        GetAzVmssObject{}           Gets $VmssObject
    GetAzVmssVMObject{}         Gets $VmssVMObject
        GetAzVmmsObject{}           Gets $VmssObject
    StartAzVmss{}               Starts $VmssVMObject(s)
        GetAzVmssVMObject{}         Gets $VmssVMObject
            GetAzVmmsObject{}           Gets $VmssObject
        GetAzVmmsObject{}           Gets $VmssObject
    StopAzVmss{}                Stops $VmssVMObject(s)
        GetAzVmssVMObject{}         Gets $VmssVMObject
            GetAzVmmsObject{}           Gets $VmssObject
        GetAzVmmsObject{}           Gets $VmssObject        
} #>
<# Process Flow {
    function 
        Call ManageAzVmss > Get $null
            Call NewAzVmss > Get $VmssObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzVmss > Send $RGObject
                Call GetAzVMSize > Get $VMSizeObject
                End GetAzVMSize
                    Return NewAzVmss > Send $VMSizeObject
                Call SetAzVmssOsProfile > Get $VmssOSProfileObject
                    Call SetAzVMOS > Get $VMImageObject
                    End SetAzVMOS
                End SetAzVmssOsProfile
                    Return NewAzVmss > Send $VmssOSProfileObject
                Call SetAzVmssStorageProfile > Get $VmssStorageProfileObject
                End SetAzVmssStorageProfile
                    Return NewAzVmss > Send $VmssStorageProfileObject
                Call NewAzLoadBalancer > Get $LoadBalancerObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzLoadBalancer > Send $RGObject
                    Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
                        Call NewAzPublicIpAddress > Get $PublicIPObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return NewAzPublicIpAddress > Send $RGObject
                        End NewAzPublicIpAddress
                            Return NewAzLBFrontendIpConfig > Send $PublicIPObject
                        Call GetAzPublicIpAddress > Get $PublicIPObject
                        End GetAzPublicIpAddress
                            Return NewAzLBFrontendIpConfig > Send $PublicIPObject
                    End NewAzLBFrontendIpConfig
                        Return NewAzLoadBalancer > Send $FrontEndIPConfigObject 
                    Call NewAzLBBackendIpConfig > Get $BackEndIPConfigObject
                    End NewAzLBBackendIpConfig
                        Return NewAzLoadBalancer > Send $BackEndIPConfigObject
                    Call NewAzLBProbeConfig > Get $HealthProbeObject
                    End NewAzLBProbeConfig
                        Return NewAzLoadBalancer > Send $HealthProbeObject
                    Call NewAzLBIBNatPoolConfig > Get $InboundNatPoolObject
                    End NewAzLBIBNatPoolConfig
                        Return NewAzLoadBalancer > Send $InboundNatPoolObject
                    Call NewAzLBRuleConfig > Get $LoadBalanceRule
                    End NewAzLBRuleConfig
                        Return NewAzLoadBalancer > Send $LoadBalanceRule
                End NewAzLoadBalancer
                    Return NewAzVmss > Send $LoadBalancerObject
                Call GetAzLoadBalancer > Get $LoadBalancerObject
                End GetAzLoadBalancer
                    Return NewAzVmss > Send $LoadBalancerObject
                Call AddAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $VnetObject
                    End GetAzVirtualNetwork
                        Return AddAzVNetSubnetConfig > Send $VnetObject
                End AddAzVNetSubnetConfig
                    Return NewAzVmss > Send $SubnetObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $VnetObject
                    End GetAzVirtualNetwork
                        Return GetAzVNetSubnetConfig > Send $VnetObject
                End GetAzVNetSubnetConfig
                    Return NewAzVmss > Send $SubnetObject
            End NewAzVmss
                Return ManageAzVmss > Send $VmssObject
            Call GetAzVmss > Get $VmssObject
            End GetAzVmss
                Return ManageAzVmss > Send $VmssObject
            Call RemoveAzVmss > Get $null
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return RemoveAzVmss > Send $VmssObject
            End RemoveAzVmss
                Return ManageAzVmss > Send $null
            Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return GetAzVmssVM > Send $VmssObject
            End GetAzVmssVM
                Return ManageAzVmss > Send $VmssVMObject, $VmssObject
            Call StartAzVmss > Get $null
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return StartAzVmss > Send $VmssObject   
                Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return GetAzVmssVM > Send $VmssObject
                End GetAzVmssVM
                    Return StartAzVmss > Send $VmssVMObject, $VmssObject
            End StartAzVmss
                Return ManageAzVmss > Send $null
            Call StopAzVmss > Get $null
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return StopAzVmss > Send $VmssObject   
                Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                    Call GetAzVmss > Get $VmssObject
                    End GetAzVmss
                        Return GetAzVmssVM > Send $VmssObject
                End GetAzVmssVM
                    Return StopAzVmss > Send $VmssVMObject, $VmssObject
            End StopAzVmss
                Return ManageAzVmss > Send $null
        End ManageAzVmss
            Return function > Send $VmssObject
}#>
function ManageAzVmss {                                                                     # Function to manage Vmss
    Begin {                                                                                 # Begin function
        :ManageAzureVmss while ($true) {                                                    # Outer loop for managing function
            if ($VmssObject) {                                                              # If $VmssObject has a value
                Write-Host "Currently selected Vmss is:" $VmssObject.Name                   # Write message to screen
            }                                                                               # End if ($VmssObject) 
            if ($VmssVMObject) {                                                            # If $VmssVMObject has a value
                Write-Host "Currently selected Vmss instance is :" $VmssVMObject.InstanceID # Write message to screen 
            }                                                                               # End if ($VmssVMObject) 
            Write-Host '[0] Clear current Vmss'                                             # Write message to screen
            Write-Host '[1] New Vmss'                                                       # Write message to screen
            Write-Host '[2] Get Vmss'                                                       # Write message to screen
            Write-Host '[3] Remove Vmss'                                                    # Write message to screen
            Write-Host '[4] Get Vmss Instance'                                              # Write message to screen
            Write-Host '[5] Start Vmss Instance'                                            # Write message to screen
            Write-Host '[6] Stop Vmss Instance'                                             # Write message to screen
            Write-Host '[Exit] Exit function'                                               # Write message to screen
            $OperatorSelect = Read-Host 'Option number'                                     # Operator input for function selection
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals 0
                if ($VmssObject -or $VmssVMObject) {                                        # If $VmssObject or $VmssVMObject has a value
                    if ($VmssObject) {                                                      # If $VmssObject has a value
                        Clear-Variable $VmssObject                                          # Clears $VmssObject
                        Write-Host '$VmssObject has been cleared'                           # Write message to screen
                    }                                                                       # End if ($VmssObject)
                    if ($VmssVMObject) {                                                    # If $VmssVMObject has a value
                        Clear-Variable $VmssVMObject                                        # Clears $VmssVMObject
                        Write-Host '$VmssVMObject has been cleared'                         # Write message to screen
                    }                                                                       # End if ($VmssVMObject)
                }                                                                           # End if ($VmssObject -or $VmssVMObject)
                else {                                                                      # If $VmssObject does not have a value
                    Write-Host 'Nothing to clear'                                           # Write message to screen
                }                                                                           # End else (if ($VmssObject))
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals 1
                Write-Host "New Vmss"                                                       # Write message to screen
                $VmssObject = NewAzVmss                                                     # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals 1
                Write-Host "Get Vmss"                                                       # Write message to screen
                $VmssObject = GetAzVmss                                                     # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            elseif ($OperatorSelect -eq '3') {                                              # Else if $OperatorSelect equals 3
                Write-Host "Remove Vmss"                                                    # Write message to screen
                RemoveAzVmss ($VmssObject)                                                  # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '3')
            elseif ($OperatorSelect -eq '4') {                                              # Else if $OperatorSelect equals 4
                Write-Host "Get Vmss Instance"                                              # Write message to screen
                GetAzVmssVM ($VmssObject)                                                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '4')
            elseif ($OperatorSelect -eq '5') {                                              # Else if $OperatorSelect equals 5
                Write-Host "Start Vmss Instance"                                            # Write message to screen
                StartAzVmss ($VmssObject)                                                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '5')
            elseif ($OperatorSelect -eq '6') {                                              # Else if $OperatorSelect equals 6
                Write-Host "Stop Vmss Instance"                                             # Write message to screen
                StopAzVmss ($VmssObject)                                                    # Calls function and assigns output to $var
            }                                                                               # End elseif ($OperatorSelect -eq '6')
            elseif ($OperatorSelect -eq 'exit') {                                           # Else if $OperatorSelect equals 'exit'
                Write-Host 'Leaving manage Vmss'                                            # Write message to screen
                Break ManageAzureVmss                                                       # Breaks :ManageAzureVmss
            }                                                                               # End elseif ($OperatorSelect -eq 'exit')
            else {                                                                          # All other inputs for $OperatorSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :ManageAzureVmss while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVmss
function NewAzVmss {                                                                        # Function to create a new virtual machine scale set
    Begin{                                                                                  # Begin function
        :NewAzureVmss while ($true) {                                                       # Outer loop for managing function
            :SetAzureVmssType while ($true) {                                               # Inner loop for setting the Vmss type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the VM type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVmss                                                      # Breaks :NewAzVmss
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVmssType                                                  # Breaks :SetAzureVmssType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            :GetAzureResourceGroup while ($true) {                                          # Inner loop for getting the resource group and location
                if (!$RGObject) {                                                           # If $RGObject is $null
                    $CallingFunction = 'NewAzVmss'                                          # $var used to list the calling function name in GetAzResourceGroup
                    $RGObject = GetAzResourceGroup ($CallingFunction)                       # Calls function and assigns output to $var
                    if (!$RGObject) {                                                       # If $RGObject is $null 
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End if (!$RGObject)
                $LocationObject = Get-AzLocation | Where-Object `
                    {$_.Location -eq $RGObject.Location}                                    # Creates $LocationObject
                if ($LocationObject) {                                                      # If $LocationObject has a value
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End ($LocationObject)
                else {                                                                      # If $LocationObject does not have a value
                    Write-Host "An error has occured"                                       # Write message to screen
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End else (if ($LocationObject))
            }                                                                               # End :GetAzureResourceGroup while ($true)    
            :SetAzureVmssSkuCapacity while ($true) {                                        # Inner loop for setting the max skus (VMs)
                Try {                                                                       # Try the following
                    [int]$VmssSkuCapacityObject = Read-Host "Enter the max number of VMs"   # Operator input for the max skus
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($VmssSkuCapacityObject -le 0) {                                         # If $VmssSkuCapacityObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($VmssSkuCapacityObject -le 0) 
                elseif ($VmssSkuCapacityObject -ge 1) {                                     # If $VmssSkuCapacityObject is greater than or equal to `
                    $OperatorConfirm = Read-Host `
                    "Confirm max"$VmssSkuCapacityObject" VMs [Y] or [N]"                    # Operator confirmation of the max skus
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVmssSkuCapacity                                       # Breaks :SetAzureVmssSkuCapacity        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($VmssSkuCapacityObject -ge 1)
            }                                                                               # End :SetAzureVmssSkuCapacity while ($true)
            :SetAzureVmssSkuConfig while ($true) {                                          # Inner loop for setting vmss profile configuration
                $VMSizeObject = GetAzVMSize ($LocationObject)                               # Calls function and assigns output to $var
                if (!$VMSizeObject) {                                                       # If $VMSizeObject has no value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VMSizeObject)
                :SetAzureVMSSSkuUpDate while ($true) {                                      # Inner loop for setting the OS update settings
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Automatic'                                              # Write message to screen
                    Write-Host '[2] Manual'                                                 # Write message to screen
                    $UpdateSetting = Read-Host '[0], [1], or [2]'                           # Operator input for the update setting
                    if ($UpdateSetting -eq '0') {                                           # If $Update setting equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($UpdateSetting -eq '0')
                    elseif ($UpdateSetting -eq '1') {                                       # If $Update setting equals '1'
                        $UpdateSetting = 'Automatic'                                        # Sets $UpdateSetting to 'Automatic' 
                        Break SetAzureVMSSSkuUpDate                                         # Breaks :SetAzureVMSSSkuUpDate
                    }                                                                       # End elseif ($UpdateSetting -eq '1')
                    elseif ($UpdateSetting -eq '2') {                                       # If $Update setting equals '2'
                        $UpdateSetting = 'Manual'                                           # Sets $UpdateSetting to 'Manual' 
                        Break SetAzureVMSSSkuUpDate                                         # Breaks :SetAzureVMSSSkuUpDate
                    }                                                                       # End elseif ($UpdateSetting -eq '2')
                    else {                                                                  # If $UpdateSetting not equal to 0, 1, or 2
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($UpdateSetting -eq '0'))
                }                                                                           # End :SetAzureVMSSSkuUpDate while ($true)
                $VmssConfigObject = New-AzVmssConfig -Location $LocationObject.Location `
                    -SkuCapacity $VmssSkuCapacityObject -SkuName $VMSizeObject.Name `
                    -UpgradePolicyMode $UpdateSetting                                       # Starts the Vmss config, loads location, VM settings, count, and update settings
                $VmssOSProfileObject = SetAzVmssOsProfile `
                    ($VmssConfigObject, $ImageTypeObject)                                   # Calls function and assigns output to $var
                if (!$VmssOSProfileObject) {                                                # If $VmssOSProfileObject does not have a value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VmssOSProfileObject)
                $VmssStorageProfileObject = SetAzVmssStorageProfile ($VmssConfigObject)     # Calls function and assigns output to $var
                if (!$VmssStorageProfileObject) {                                           # If $VmssStorageProfileObject does not have a value
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$VmssStorageProfileObject)
                Break SetAzureVmssSkuConfig                                                 # Breaks :SetAzureVmssSkuConfig
            }                                                                               # End :SetAzureVmssSkuConfig while ($true)
            :SetVmssIPConfig while ($true) {                                                # Inner loop for setting the network settings
                :SetVmssIPConfigName while ($true) {                                        # Inner loop for setting the IP config name
                    $VmssIPConfigName = Read-Host "Name of IP config"                       # Operator input for the IP config name
                    if ($VmssIPConfigName -eq 'exit') {                                     # If $VmssIPConfigName equals exit
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($VmssIPConfigName -eq 'exit')
                    $OperatorConfirm = Read-Host "Use" $VmssIPConfigName `
                    "as the IP config name"                                                 # Operator confirmation of the IP config name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetVmssIPConfigName                                           # Breaks :SetVmssIPConfigName
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
                }                                                                           # End :SetVmssIPConfigName while ($true)
                :GetAzureLoadBalancer while ($true) {                                       # Inner loop to get or create a load balancer
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New load balancer'                                      # Write message to screen
                    Write-Host '[2] Get load balancer'                                      # Write message to screen
                    $OperatorSelect = Read-Host '[0], [1], or [2]'                          # Operator input for getting or creating a load balancer
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -eq '1') {                                      # elseif $OperatorSelect equals '1'
                        $LoadBalancerObject = NewAzLoadBalancer                             # Calls function and assigns output to $var
                        if ($LoadBalancerObject) {                                          # If $LoadBalancerObject has a value
                            Break GetAzureLoadBalancer                                      # Breaks :GetAzureLoadBalancer
                        }                                                                   # End if ($LoadBalancerObject)
                        else {                                                              # If $LoadBalancerObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($LoadBalancerObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '1') 
                    elseif ($OperatorSelect -eq '2') {                                      # elseif $OperatorSelect equals '2'
                        $LoadBalancerObject = GetAzLoadBalancer                             # Calls function and assigns output to $var
                        if ($LoadBalancerObject) {                                          # If $LoadBalancerObject has a value
                            Break GetAzureLoadBalancer                                      # Breaks :GetAzureLoadBalancer
                        }                                                                   # End if ($LoadBalancerObject)
                        else {                                                              # If $LoadBalancerObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($LoadBalancerObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2') 
                }                                                                           # End :GetAzureLoadBalancer while ($true)
                :GetAzureSubnet while ($true) {                                             # Inner loop for setting the subnet
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New subnet'                                             # Write message to screen
                    Write-Host '[2] Get subnet'                                             # Write message to screen
                    $OperatorSelect = Read-Host '[0], [1], or [2]'                          # Operator input for getting or creating a subnet
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break NewAzureVmss                                                  # Breaks :NewAzureVmss
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -eq '1') {                                      # elseif $OperatorSelect equals '1'
                        $SubnetObject = AddAzVNetSubnetConfig                               # Calls function and assigns output to $var
                        if ($SubnetObject) {                                                # If $SubnetObject has a value
                            Break GetAzureSubnet                                            # Breaks :GetAzureSubnet
                        }                                                                   # End if ($SubnetObject)
                        else {                                                              # If $SubnetObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($SubnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '1') 
                    elseif ($OperatorSelect -eq '2') {                                      # elseif $OperatorSelect equals '2'
                        $SubnetObject = GetAzVNetSubnetConfig                               # Calls function and assigns output to $var
                        if ($SubnetObject) {                                                # If $SubnetObject has a value
                            Break GetAzureSubnet                                            # Breaks :GetAzureSubnet
                        }                                                                   # End if ($SubnetObject)
                        else {                                                              # If $SubnetObject does not have a value
                            Break NewAzureVmss                                              # Breaks :NewAzureVmss
                        }                                                                   # End else (if ($SubnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2')                 
                }                                                                           # End :GetAzureSubnet while ($true)
                $VmssIPConfig = New-AzVmssIPConfig -Name $VmssIPConfigName `
                    -LoadBalancerInboundNatPoolsId `
                    $LoadBalancerObject.InboundNatPools[0].Id `
                    -LoadBalancerBackendAddressPoolsId `
                    $LoadBalancerObject.BackendAddressPools[0].Id `
                    -SubnetId $SubnetObject.id                                              # Creates the Vmss IP config
                if ($VmssIPConfig) {                                                        # If $VmssIPConfig has a value
                    $VmssConfigObject = Add-AzVmssNetworkInterfaceConfiguration -Name `
                        $VmssIPConfigName -Primary $true -IpConfiguration $VmssIPConfig `
                        -VirtualMachineScaleSet $VmssConfigObject                           # Adds the Vmss IP config to the Vmss config
                    Break SetVmssIPConfig                                                   # Breaks :SetVmssIPConfig
                }                                                                           # # End if ($VmssIPConfig)
                else {                                                                      # If $VmssIPConfig does not have a value
                    Write-Host "An error has occured"                                       # Write message to screen
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End else (if ($VmssIPConfig))
            }                                                                               # End :SetVmssIPConfig while ($true)
            :SetVmssName while ($true) {                                                    # Inner loop for setting the Vmss object name
                $VmssNameObject = Read-Host 'Enter the name of the new Vmss object'         # Operator input for the Vmss name
                if ($VmssNameObject -eq 'exit') {                                           # If $VmssNameObject equals 'exit'
                    Break NewAzVmss                                                         # Breaks :NewAzVmss
                }                                                                           # End if ($VmssNameObject -eq 'exit')
                if ($VmssNameObject) {                                                      # If $VmssNameObject has a value
                    Break SetVmssName                                                       # Breaks :SetVmssName
                }                                                                           # End if ($VmssNameObject)
                else {                                                                      # If $VmssNameObject does not have a value
                    Write-Host "No input detected"                                          # Write message to screen
                }                                                                           # End else (if ($VmssNameObject))
            }                                                                               # End :SetVmssName while ($true)
            $VmssObject = New-AzVmss -ResourceGroupName $RGObject.ResourceGroupName -Name `
                $VmssNameObject -VirtualMachineScaleSet $VmssConfigObject                   # Creates the Vmss object
            if ($VmssObject) {                                                              # If $VmssObject has a value 
                Return $VmssObject                                                          # Returns $VmssObject to calling function
            }                                                                               # End if ($VmssObject)
            else {                                                                          # If $VmssObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
            }                                                                               # End else (if ($VmssObject))
        }                                                                                   # End :NewAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with #null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVmss
function SetAzVmssOsProfile {                                                               # Function to set VMss OS profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssOSProfile while ($true) {                                              # Outer loop to manage function
            :SetAzureVmssOSProPrefix while ($true) {                                        # Inner loop for setting the VMss OS name prefix
                $VmssNamePrefixObject = Read-Host `
                "Please enter the Vmss computer name prefix [1-9] characters"               # Operator input for the VM name prefix
                if ($VmssNamePrefixObject -eq 'exit') {                                     # If $VmssNamePrefixObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssNamePrefixObject -eq 'exit')
                elseif ($VmssNamePrefixObject.Length -gt 9) {                               # If $VmssNamePrefixObject is greater than 15 characters
                    Write-Host `
                    "The input is to long, prefix is limited to 9 or less characters"       # Write message to screen
                    $VmssNamePrefixObject = $null                                           # Clears $var
                }                                                                           # End elseif ($VmssNamePrefixObject.Length -gt 15)
                else {                                                                      # All other input
                    Write-Host $VmssNamePrefixObject                                        # Write message to screen
                    $OperatorConfirm = Read-Host "Use this prefix [Y] or [N]"               # Operator confirmation of the name prefix
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssOSProPrefix                                       # Breaks :SetAzureVmssOSProPrefix 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssNamePrefixObject = $null                                       # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssNamePrefixObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssOSProPrefix while ($true)
            :SetAzureVmssProUserName while ($true) {                                        # Inner loop for setting the admin username
                $VmssAdminUserNameObject = Read-Host "Enter the user name"                  # Operator input for the admin username
                if ($VmssAdminUserNameObject -eq 'exit') {                                  # If $VmssAdminUserNameObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminUserNameObject -eq 'exit')
                elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject `
                    -eq '1') {                                                              # If $VmssAdminUserNameObject characters are greater than 20 and $ImageTypeObject equals '1'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 20 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject -eq '1')
                elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject `
                    -eq '2') {                                                              # If $VmssAdminUserNameObject characters are greater than 64 and $ImageTypeObject equals '2'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 64 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject -eq '2')
                else {                                                                      # All other inputs   
                    Write-Host $VmssAdminUserNameObject                                     # Write message to screen
                    $OperatorConfirm = Read-Host "Use this admin name [Y] or [N]"           # Operator confirmation of the admin username
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProUserName                                       # Breaks :SetAzureVmssProUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminUserNameObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminUserNameObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProUserName while ($true)
            :SetAzureVmssProPassword while ($true) {                                        # Inner loop for setting the admin password
                $VmssAdminPasswordObject = Read-Host "Enter the password"                   # Operator input for the admin password
                if ($VmssAdminPasswordObject -eq 'exit') {                                  # If $VmssAdminPasswordObject equals exit
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminPasswordObject -eq 'exit')
                else {                                                                      # All other inputs
                    Write-Host $VmssAdminPasswordObject                                     # Write message to screen   
                    $OperatorConfirm = Read-Host "Use this admin password [Y] or [N]"       # Operator confirmation of the admin password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProPassword                                       # Breaks :SetAzureVmssProPassword 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminPasswordObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminPasswordObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProPassword while ($true)
            $VmssOSProfileObject = Set-AzVmssOsProfile -VirtualMachineScaleSet `
            $VmssConfigObject -ComputerNamePrefix $VmssNamePrefixObject -AdminUsername `
            $VmssAdminUserNameObject -AdminPassword $VmssAdminPasswordObject                # Creates the VM scale set os profile
            if (!$VmssOSProfileObject) {                                                    # If $VmssOSProfileObject is $null
                Write-Host "An error has occured"
                Break SetAzureVmssOSProfile                                                 # Breaks :SetAzureVmssOSProfile
            }                                                                               # End if (!$VmssOSProfileObject)
            else {                                                                          # If $VmssOSProfileObject is not $null
                Return $VmssOSProfileObject                                                 # Returns to calling function with $VmssOSProfileObject
            }                                                                               # End else ((!$VmssOSProfileObject))
        }                                                                                   # End :SetAzureVmssOSProfile while ($true)     
        Return                                                                              # Returns to calling function with $null                                    
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVmssOsProfile 
function SetAzVmssStorageProfile {                                                          # Function to create a VM scale set operating system image and storage profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssStorageProfile while ($true) {                                         # Outer loop for managing function
            $VMImageObject = SetAzVMOS                                                      # Calls function and assigns output for $var
            if ($ImageTypeObject -eq '1') {                                                 # If $ImageTypeObject equals '1'
                $OSDiskType = 'Windows'                                                     # Sets $OSDiskType to 'Windows'
            }                                                                               # End if ($ImageTypeObject -eq '1')
            if ($ImageTypeObject -eq '2') {                                                 # If $ImageTypeObject equals '2'
                $OSDiskType = 'Linux'                                                       # Sets $OSDiskType to 'Linux'
            }                                                                               # End if ($ImageTypeObject -eq '2')
            if (!$VMImageObject) {                                                          # If $var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile 
            }                                                                               # End if (!$VMImageObject)
            :SetAzureDiskSku while ($true) {                                                # Inner loop for configuring the new disk sku
                [System.Collections.ArrayList]$ValidSku = @()                               # Creates the valid sku array
                $ValidSkuList = @('Standard_LRS','Premium_LRS','StandardSSD_LRS',`
                    'UltraSSD_LRS')                                                         # Creates a list of items to load into $ValidSku Array
                $SkuNumber = 1                                                              # Sets the base number for the valid sku array
                foreach ($_ in $ValidSkuList) {                                             # For each item in $ValidSkuList
                    $SkuInput = [PSCustomObject]@{'Name' = $_;'Number' = $SkuNumber}        # Creates the item to loaded into array
                    $ValidSku.Add($SkuInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $SkuNumber = $SkuNumber + 1                                             # Increments $SkuNumber up 1
                }                                                                           # End foreach ($_ in $ValidSkuList)
                foreach ($_ in $ValidSku) {                                                 # For each item in $ValidSkut
                    Write-Host $_.Number $_.Name                                            # Write message to screen
                }                                                                           # End foreach ($_ in $ValidSku)
                :SelectAzureDiskSku while ($true) {                                         # Inner loop for selecting object from list
                    $SkuObjectSelect = Read-Host "Please enter the number of the sku"       # Operator input for the selection
                    if ($SkuObjectSelect -eq '0') {                                         # If $$SkuObjectSelect is 0
                        Break SetAzureVmssStorageProfile                                    # Breaks :SetAzureVmssStorageProfile
                    }                                                                       # End if ($_Select -eq '0')
                    $SkuObject = $ValidSku | Where-Object {$_.Number -eq $SkuObjectSelect}  # Isolates selected object 
                    $SkuObject = $SkuObject.Name                                            # Pulls just the .name value
                    if ($SkuObject) {                                                       # If $SkuObject has a value
                        Break SetAzureDiskSku                                               # Breaks :SetAzureDiskSku
                    }                                                                       # End if ($SetAzureDiskSku)
                    Write-Host "That was not a valid selection"                             # Write message to screen 
                }                                                                           # End :SelectAzureDiskSku while ($true)
            }                                                                               # End :SetAzureDiskSku while ($true)
            if ($VMImageObject.Version) {                                                   # If $VMImageObject.Version has a value
                $VmssStorageProfileObject = Set-AzVmssStorageProfile `
                    -VirtualMachineScaleSet $VmssConfigObject  -OsDiskCreateOption `
                    "FromImage" -ImageReferencePublisher $VMImageObject.PublisherName `
                    -ImageReferenceOffer $VMImageObject.Offer -ImageReferenceSku `
                    $VMImageObject.Skus -ImageReferenceVersion $VMImageObject.Version `
                    -ManagedDisk $SkuObject -OsDiskOsType $OSDiskType                       # Creates the OS storage profile
            }                                                                               # # End if ($VMImageObject.Version)
            else {                                                                          # If $VMImageObject.Version does not have a value
                $VmssStorageProfileObject = Set-AzVmssStorageProfile `
                -VirtualMachineScaleSet $VmssConfigObject  -OsDiskCreateOption `
                "FromImage" -ImageReferencePublisher $VMImageObject.PublisherName `
                -ImageReferenceOffer $VMImageObject.Offer -ImageReferenceSku `
                $VMImageObject.Skus -ImageReferenceVersion 'latest' `
                -ManagedDisk $SkuObject -OsDiskOsType $OSDiskType                           # Creates the OS storage profile
            }                                                                               # End else (if ($VMImageObject.Version))
            if (!$VmssStorageProfileObject) {                                               # If $Var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile
            }                                                                               # End if (!$VmssStorageProfileObject)
            else {                                                                          # If $var has a value
                Return $VmssStorageProfileObject                                            # Returns to calling function
            }                                                                               # End else (if (!$VmssStorageProfileObject))
        }                                                                                   # End :SetAzureVmssStorageProfile while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVmssStorageProfile
function GetAzVmss {                                                                        # Function to get a Vmss
    Begin {                                                                                 # Begin function
        :GetAzureVmss while ($true) {                                                       # Outer loop for managing function
            $VmssList = Get-AzVmss                                                          # Gets a list of all Vmss's
            if (!$VmssList) {                                                               # If $VmssList is $null
                Write-Host '***No Vmss(s) exist***'                                         # Write message to screen
                Write-Host '***Returning to previous menu***'                               # Write message to screen
                Break GetAzureVmss                                                          # Breaks :GetAzureVmss
            }                                                                               # End if (!$VmssList)
            $VmssListNumber = 1                                                             # Creates the array selection number
            [System.Collections.ArrayList]$VmssArray = @()                                  # Creates the array used for selection
            foreach ($_ in $VmssList) {                                                     # For each item in $VmssList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $VmssListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName; 'Loc' = $_.Location; 'Sku' = $_.Sku.Name; `
                        'Cap' = $_.Sku.Capacity                                             # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $VmssArray.Add($ArrayInput) | Out-Null                                      # Adds the array input to array
                $VmssListNumber = $VmssListNumber + 1                                       # Increments $VmssListNumber by 1
            }                                                                               # End foreach ($_ in $VmssList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Foreach ($_ in $VmssArray) {
                Write-Host "["$_.Number']'                                                  # Write message to screen
                Write-Host 'Name: '$_.Name                                                  # Write message to screen
                Write-Host 'RG:   '$_.RG                                                    # Write message to screen
                Write-Host 'Loc:  '$_.Loc                                                   # Write message to screen
                Write-Host 'Sku:  '$_.Sku                                                   # Write message to screen
                Write-Host 'Cap:  '$_.Cap                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End Foreach ($_ in $VmssArray)
            :SelectAzureVmss while ($true) {                                                # Inner loop for selecting the Vmss
                $VmssSelect = Read-Host 'Vmss selection number'                             # Operator input for the vmss selection
                if ($VmssSelect -eq '0') {                                                  # If $VmssSelect equals 0
                    Break GetAzureVmss                                                      # Breaks :GetAzureVMSS
                }                                                                           # End if ($VmssSelect -eq '0')
                elseif ($VmssSelect -in $VmssArray.Number) {                                # If $VmssSelect is in $VmssArray.Number
                    $VmssSelect = $VmssArray | Where-Object {$_.Number -eq $VmssSelect}     # $VmssSelect is equal to the array item where $VmssSelect equals the array number
                    $VmssObject = Get-AzVmss -ResourceGroupName `
                        $VmssSelect.ResourceGroupName -VMScaleSetName $VmssSelect.name      # Pulls the full VmssObject
                    if ($VmssObject) {                                                      # If the vmss object is pulled
                        Return $VmssObject                                                  # Return to calling function with $VmssObject
                    }                                                                       # End if ($VmssObject)
                    else {                                                                  # If the vmss object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmss                                                  # Breaks :GetAzureVmss
                    }                                                                       # End else (if ($VmssObject))
                }                                                                           # End elseif ($VmssSelect -in $VmssArray.Number)
                else {                                                                      # If $VmssSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($VmssSelect -eq '0') )
            }                                                                               # End :SelectAzureVmss while ($true)
        }                                                                                   # End :GetAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmss
function RemoveAzVmss {
    Begin {
        :RemoveAzureVmss while ($true) {                                                    # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $VmssObject is $null
                $VmssObject = GetAzVmSS                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $VmssObject is $null
                    Break RemoveAzureVmss                                                   # Breaks :RemoveAzureVmss
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            Write-Host 'Remove' $VmssObject.name                                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for deletion
            if (!($OperatorConfirm -eq 'y')) {                                              # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            else {
                Try {                                                                       # Try the following
                    Remove-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                        -VMScaleSetName $VmssObject.name -Force                             # Removes the VMSS
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the required permissions'                  # Write message to screen
                }                                                                           # End catch
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End else (if (!($OperatorConfirm -eq 'y')))
        }                                                                                   # End :RemoveAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVmss
function GetAzVmssVM {                                                                      # Function for getting a vmss instance
    Begin {                                                                                 # Begin function
        :GetAzureVmssVM while ($true) {                                                     # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $var is $null
                $VmssObject = GetAzVmss                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $var is $null
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            $VmssVMList = Get-AzVmssVM -ResourceGroupName $VmssObject.ResourceGroupName `
                -VMScaleSetName $VmssObject.name                                            # Collects all instances and assigns to $var
            $ListNumber = 1                                                                 # List number creation
            [System.Collections.ArrayList]$VmssVMArray = @()                                # $VmssVMArray creation
            foreach ($_ in $VmssVMList) {                                                   # For each item in $var
                $VmssVMStatus = Get-AzVmssVM -ResourceGroupName `
                    $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.name `
                    -InstanceId $_.InstanceId -InstanceView                                 # Collects the Vmss Vm instance status
                $VmssVMStatus = ($VmssVMStatus.Statuses.Code).Split('/')[-1]                # Keeps the last portion of the Vmss VM instance status
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Instance' = $_.InstanceID; `
                    'State' = $VmssVMStatus                                                 # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VmssVMArray.Add($ArrayInput) | Out-Null                                    # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VmssVMList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen 
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $VmssVMArray) {                                                  # For each item in $var
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'InstanceID: '$_.Instance                                        # Write message to screen
                Write-Host 'State:      '$_.State                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VmssVMArray)
            :SelectAzureVmssVM while ($true) {                                              # Inner loop for selecting the Vmss VM instance
                $OperatorSelect = Read-Host 'Enter the [ # ] of the Vmss VM instance'       # Operator input for the selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $VmssVMArray.Number) {                          # Else if $OperatorSelect is in $VmssVMArray.Number
                    $OperatorSelect = $VmssVMArray | Where-Object `
                        {$_.Number -eq $OperatorSelect}                                     # $Operator select equals the item in $VmssVMArray where $OperatorSelect equals $VmssVMArray.Number
                    $VmssVMObject = Get-AzVmssVM -ResourceGroupName `
                        $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.Name `
                        -InstanceId $OperatorSelect.Instance                                # Pulls the full Vmss VM instance
                    if ($VmssVMObject) {                                                    # If $var is not $null
                        Return $VmssVMObject, $VmssObject                                   # Returns to calling function with $VmssVMObject and $VmssObject
                    }                                                                       # End if ($VmssVMObject) 
                    else {                                                                  # If $OperatorSelect did not meet any if or elseif statements
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmssVM                                                # Breaks :GetAzureVmssVM
                    }                                                                       # End else (if ($VmssVMObject))
                }                                                                           # End elseif ($OperatorSelect -in $VmssVMArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid entry'                                 # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureVmssVM while ($true)
        }                                                                                   # End :GetAzureVmssVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmssVM                                                                                        # End function GetAzVmssVM
function StartAzVmss {                                                                      # Function for starting vmss instances
    Begin {                                                                                 # Begin function
        :StartAzureVmssVM while ($true) {                                                   # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Start all instances in a Vmss'                                  # Write message to screen
            Write-Host '[2] Start a single instance in a Vmss'                              # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for selecting the instance start up option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssObject = GetAzVmss                                                 # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name                                        # Starts all instances for a Vmss
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StartAzureVmssVM                                              # Breaks :StartAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Start-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   # Starts the specific instance of the Vmss
                Break StartAzureVmssVM                                                      # Breaks :StartAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # If $OperatorSelect did not meet any if or elseif statements
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StartAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVmss
function StopAzVmss {                                                                       # Function for Stoping vmss instances
    Begin {                                                                                 # Begin function
        :StopAzureVmssVM while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Stop all instances in a Vmss'                                   # Write message to screen
            Write-Host '[2] Stop a single instance in a Vmss'                               # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for selecting the instance stop option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssObject = GetAzVmss                                                 # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name                                        # Stops all instances of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   # Stops the specified instance of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # If $OperatorSelect did not meet any if or elseif statements
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StopAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVmss
function GetAzVirtualNetwork {                                                              # Function to get an existing virutal network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # pulls all items into list for selection
            $VNetListNumber = 1                                                             # $var used for selecting the virtual network
            foreach ($Name in $VNetList) {                                                  # For each name in $VNetList
                Write-Host $VNetListNumber"." $Name.Name $Name.AddressSpace.AddressPrefixes # Writes items from list to screen
                $VNetListNumber = $VNetListNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($Name in $VNetList)
            :GetAzureVNetName while ($true) {                                               # Inner loop for selecting the Vnet
                $VNetListNumber = 1                                                         # Resets $VNetListNumber
                $VNetListSelect = Read-Host `
                    "Please enter the number of the virtual network"                        # Operator input for the VNet selection
                foreach ($Name in $VNetList) {                                              # For each name in $VnetList
                    if ($VNetListSelect -eq $VNetListNumber) {                              # If $VnetListSelect equals current $VnetListNumber
                        $VNetObject = Get-AzVirtualNetwork -Name $Name.Name                 # Pulls the selected object and assigns to $var
                        Break GetAzureVnetName                                              # Breaks :GetAzureVnetName
                    }                                                                       # End if ($VNetListSelect -eq $VNetListNumber)
                    else {                                                                  # If $VnetListSelect does not equal the current $VnetListNumber
                        $VNetListNumber = $VNetListNumber + 1                               # Increments $var up by 1
                    }                                                                       # End else (if ($VNetListSelect -eq $VNetListNumber))
                }                                                                           # End foreach ($Name in $VNetList)
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End :GetAzureVNetName while ($true)
            Return $VNetObject                                                              # Returns to calling function with $var
        }                                                                                   # End :GetAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork
function AddAzVNetSubnetConfig {                                                            # Function to add a subnet
    begin {                                                                                 # Begin function
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $Var
                if (!$VNetObject) {                                                         # If $VNetObject is $null
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                $SubnetName = Read-Host "Subnet name"                                       # Operator input for the subnet name
                if ($SubnetName -eq 'exit') {                                               # If $SubnetName is 'exit'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($SubnetName -eq 'exit')
                $OperatorConfirm = Read-Host `
                    "Set" $SubnetName "as the subnet name [Y] or [N]"                       # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)"              # Operator input for the subnet prefix
                $OperatorConfirm = Read-Host `
                    "Use" $AddressPrefix "as the subnet address prefix [Y] or [N]"          # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            $SubnetObject = Add-AzVirtualNetworkSubnetConfig -Name $SubnetName `
                -VirtualNetwork $VNetObject -AddressPrefix $AddressPrefix | `
                Set-AzVirtualNetwork                                                        # Creates the new subnet config and adds to $VNetObject
            $OperatorSelect = Read-Host "Add another subnet"                                # Operator input to add more subnets
            if (!($OperatorSelect -eq 'y')) {                                               # if $OperatorSelect does not equal 'y'
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnetAgain
            }                                                                               # End if (!($OperatorSelect -eq 'y'))
            if ($SubnetObject) {                                                            # If $SubnetObject has a value
                Return $SubnetObject                                                        # Returns $SubnetObject to calling function
            }                                                                               # End if ($SubnetObject)
            else {                                                                          # If $SubnetObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End else (if ($SubnetObject))
        }                                                                                   # End :AddAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig
function GetAzVNetSubnetConfig {                                                            # Function to get an existing subnet
    Begin {                                                                                 # Begin function
        :GetAzureSubnet while ($true) {                                                     # Outer loop for managing function
            if (!$VnetObject) {                                                             # If $VnetObject is $null
                $VnetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
                if (!$VnetObject) {                                                         # If $VnetObject is $null
                    Break GetAzureSubnet                                                    # Breaks :GetAzureSubnet
                }                                                                           # End if (!$VnetObject)
            }                                                                               # End if (!$VnetObject)
            $SubNetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VnetObject      # pulls all items into list for selection
            $SubNetListNumber = 1                                                           # $var used for selecting the subnet
            foreach ($Name in $SubNetList) {                                                # For each name in $SubNetList
                Write-Host $SubNetListNumber"." $Name.Name $Name.AddressPrefix              # Writes items from list to screen
                $SubNetListNumber = $SubNetListNumber + 1                                   # Increments $var up by 1
            }                                                                               # End foreach ($Name in $SubNetList)
            :GetAzureSubnetName while ($true) {                                             # Inner loop for selecting the Subnet
                $SubNetListNumber = 1                                                       # Resets $SubNetListNumber
                $SubNetListSelect = Read-Host "Please enter the number of the subnet"       # Operator input for the Subnet selection
                foreach ($Name in $SubNetList) {                                            # For each name in $SubnetList
                    if ($SubNetListSelect -eq $SubNetListNumber) {                          # If $SubnetListSelect equals current $SubnetListNumber
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                            $VnetObject -Name $Name.Name                                    # Pulls the selected object and assigns to $var
                        Break GetAzureSubnetName                                            # Breaks :GetAzureSubnetName
                    }                                                                       # End if ($SubNetListSelect -eq $SubNetListNumber)
                    else {                                                                  # If $SubnetListSelect does not equal the current $SubnetListNumber
                        $SubNetListNumber = $SubNetListNumber + 1                           # Increments $var up by 1
                    }                                                                       # End else (if ($SubNetListSelect -eq $SubNetListNumber))
                }                                                                           # End foreach ($Name in $SubNetList)
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End :GetAzureSubnetName while ($true)
            Return $SubnetObject                                                            # Returns to calling function with $var
        }                                                                                   # End :GetAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVNetSubnetConfig
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                    # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host "[0] Exit"                                                   # Write message to screen
                    Write-Host "[1] Windows"                                                # Write message to screen
                    Write-Host "[2] Linux"                                                  # Write message to screen
                    $ImageTypeObject = Read-Host '[0], [1], or [2]'                         # Operator input for the image type
                }                                                                           # End if (!$ImageTypeObject)
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break GetAzureVMImage                                                   # Breaks :GetAzureVMImage
                }                                                                           # End if ($ImageTypeObject -eq '0') 
                elseif ($ImageTypeObject -eq '1') {                                         # Else if $ImageTypeObject equals 1
                    $VMPublisherObject = 'MicrosoftWindowsServer'                           # Sets the Windows publisher
                    Break GetAzureImagePublisher                                            # Breaks :GetAzureImagePublisher
                }                                                                           # End elseif ($ImageTypeObject -eq '1')
                elseif ($ImageTypeObject -eq '2') {                                         # Else if $ImageTypeObject equals 2
                    :GetAzureLinuxPublisher while ($true) {                                 # Outer loop to manage function
                        [System.Collections.ArrayList]$ImagePublisherArray = @()            # Creates the valid Pub array
                        $ImagePublisherList = @('Ubuntu','RedHat','CentOS','SUSE','Debian', `
                            'Oracle','CoreOS')                                              # Creates a list of items to load into $ImagePublisherArray Array
                        $ImagePublisherNumber = 1                                           # Sets the base number for the valid Pub array
                        foreach ($_ in $ImagePublisherList) {                               # For each item in $ImagePublisherList
                            $ImagePublisherInput = [PSCustomObject]@{'Name' = $_;'Number' `
                                = $ImagePublisherNumber}                                    # Creates the item to loaded into array
                            $ImagePublisherArray.Add($ImagePublisherInput) | Out-Null       # Loads item into array, out-null removes write to screen
                            $ImagePublisherNumber = $ImagePublisherNumber + 1               # Increments $ImagePublisherNumber up 1
                        }                                                                   # End foreach ($_ in $ImagePublisherList)
                        Write-Host '0 Exit'                                                 # Write message to screen
                        foreach ($_ in $ImagePublisherArray) {                              # For each item in $ImagePublisherArray
                            Write-Host $_.Number $_.Name                                    # Write message to screen
                        }                                                                   # End foreach ($_ in $ImagePublisherArray)
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            $PublisherSelect = Read-Host "Publisher number"                 # Operator selection of the publisher
                            if ($PublisherSelect -eq '0') {                                 # If $Pubselect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($PublisherSelect -eq '0')
                            $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                {$_.Number -eq $PublisherSelect}                            # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $PublisherSelect
                            If ($VMPublisherObject) {                                       # If $VMPublisherObject has a value
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End If ($VMPublisherObject)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host "That was not a valid option"                    # Write message to screen
                            }                                                               # End else (# End If ($VMPublisherObject))
                        }                                                                   # End :SelectAzurePub while ($true)
                        if ($VMPublisherObject.Name -eq 'Ubuntu') {                         # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Canonical'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End ($VMPublisherObject.Name -eq 'Ubuntu')
                        elseif ($VMPublisherObject.Name -eq 'RedHat') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'RedHat'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'RedHat')
                        elseif ($VMPublisherObject.Name -eq 'CentOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'OpenLogic'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CentOS')
                        elseif ($VMPublisherObject.Name -eq 'SUSE') {                       # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'SUSE'                                     # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'SuSE')
                        elseif ($VMPublisherObject.Name -eq 'Debian') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'credativ'                                 # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Debian')
                        elseif ($VMPublisherObject.Name -eq 'Oracle') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Oracle-Linux'                             # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Oracle')
                        elseif ($VMPublisherObject.Name -eq 'CoreOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'CoreOS'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CoreOS')
                        Break GetAzureImagePublisher                                        # Breaks :GetAzureImagePublisher
                    }                                                                       # End GetAzureVMImage
                }                                                                           # End elseif ($ImageTypeObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {
                $ImageOfferList = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject                                       # Generates the image offer list
                $ImageOfferNumber = 1                                                       # Sets $ImageOfferNumber to 1
                [System.Collections.ArrayList]$ImageOfferArray = @()                        # Creates the valid Pub array
                foreach ($Offer in $ImageOfferList) {                                       # For each $Offer in $ImageOfferList
                    $ImageOfferInput = [PSCustomObject]@{'Name' = $Offer.Offer; `
                        'Number' = $ImageOfferNumber}                                       # Creates the item to loaded into array
                    $ImageOfferArray.Add($ImageOfferInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                    $ImageOfferNumber = $ImageOfferNumber + 1                               # Increments $ImageofferNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageOfferArray) {                                          # For each $_ in $ImageOfferArray
                    Write-Host $_.Number $_.Name                                            # Writes offer number and name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    $OfferSelect = Read-Host "Enter the offer number"                       # Operator input for the offer selection
                    if ($OfferSelect -eq '0') {                                             # If $OfferSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')
                    $VMOfferObject = $ImageOfferArray | Where-Object `
                        {$_.Number -eq $OfferSelect}                                        # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OfferSelect
                    if ($VMOfferObject) {                                                   # If $VMOfferObject has a value
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMOfferObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               #
                $VMOfferObject = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject | Where-Object {$_.Offer `
                    -eq $VMOfferObject.Name}                                                # Pulls the full $VMOfferObject
                $ImageSkuList = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                    -Location $LocationObject.DisplayName -PublisherName $VMPublisherObject # Generates the $ImageSkuList
                $ImageSkuNumber = 1                                                         # Sets $ImageSkuNumber to 1
                [System.Collections.ArrayList]$ImageSkuArray = @()                          # Creates the $ImageSkuArray     
                foreach ($Skus in $ImageSkuList) {                                          # For each Sku in $ImageSkuList
                    $ImageSkuInput = [PSCustomObject]@{'Name' = $Skus.Skus; `
                        'Number' = $ImageSkuNumber}                                         # Creates the item to loaded into array
                    $ImageSkuArray.Add($ImageSkuInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    $ImageSkuNumber = $ImageSkuNumber + 1                                   # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageSkuArray) {                                            # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    $SkuSelect = Read-Host "Enter the sku number"                           # Operator input for selecting the image sku
                    if ($SkuSelect -eq '0') {                                               # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0') 
                    $VMSkuObject = $ImageSkuArray | Where-Object {$_.Number -eq $SkuSelect} # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    $VMSkuObject = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                        -Location $LocationObject.DisplayName -PublisherName `
                        $VMPublisherObject | Where-Object {$_.Skus -eq $VMSkuObject.Name}   #                                       
                    if ($VMSkuObject) {                                                     # If $VMSkuObject has a value
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                :SelectAzureImageVerType while ($true) {                                    # Inner loop for chosing current or previous version of sku
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Use current version'                                    # Write message to screen
                    Write-Host '[2] Select version'                                         # Write message to screen
                    $ImageVersionOption = Read-Host '[0], [1], or [2]'                      # Operator input for version selection type
                    if ($ImageVersionOption -eq '0') {                                      # If $ImageVersionOption equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($ImageVersionOption -eq '0')            
                    elseif ($ImageVersionOption -eq '1' -or $ImageVersionOption -eq '2') {  # If $ImageVersionOption equals 1 or 2
                        Break SelectAzureImageVerType                                       # Breaks :SelectAzureImageVerType
                    }                                                                       # End elseif ($ImageVersionOption -eq '1' -or $ImageVersionOption -eq '2')
                    else {                                                                  # If $ImageVersionOption is not equal to 0, 1, or 2
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($ImageVersionOption -eq '0'))
                }                                                                           # End :SelectAzureImageVerType while ($true)
                if ($ImageVersionOption -eq '1') {                                          # If $ImageVersionOption equals 1
                    $VMImageObject = $VMSkuObject                                           # VMImageObject is equal to $VMSkuObject
                    Return $VMImageObject                                                   # Returns $VMImageObject to calling function
                }                                                                           # End if ($ImageVersionOption -eq '1')
                else {                                                                      # If $ImageVersionOption is not '1' (can only be '2')
                    $ImageVersionList =  Get-AzVMImage -Location `
                        $LocationObject.Location -PublisherName $VMPublisherObject `
                        -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus                 # Gets image version list and assigns to $var
                    $ImageVersionNumber = 1                                                 # Sets $ImageSkuNumber to 1
                    [System.Collections.ArrayList]$ImageVersionArray = @()                  # Creates the $ImageSkuArray     
                    foreach ($_ in $ImageVersionList) {                                     # For each Sku in $ImageSkuList
                        $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                            'Number' = $ImageVersionNumber}                                 # Creates the item to loaded into array
                        $ImageVersionArray.Add($ImageVersionInput) | Out-Null               # Loads item into array, out-null removes write to screen
                        $ImageVersionNumber = $ImageVersionNumber + 1                       # Increments $ImageSkuNumber by 1
                    }                                                                       # End foreach ($Offer in $ImageOfferList)
                    Write-Host "0 Exit"                                                     # Write message to screen
                    foreach ($_ in $ImageVersionArray) {                                    # For each $_ in $ImageSkuArray
                        Write-Host $_.Number $_.Name                                        # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                    }                                                                       # End foreach ($_ in $ImageVersionArray)
                    :SelectAzureImageVersion while ($true) {                                # Inner loop for selecting the image sku
                        $VersionSelect = Read-Host "Enter the Version number"               # Operator input for selecting the image sku
                        if ($VersionSelect -eq '0') {                                       # If $SkuSelect equals 0
                            Break GetAzureVMImage                                           # Breaks :GetAzureVMImage
                        }                                                                   # End if ($OfferSelect -eq '0')                                           
                        $VMVersionObject = $ImageVersionArray | `
                            Where-Object {$_.Number -eq $VersionSelect}                     # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                        if ($VMVersionObject) {                                             # If $VMSkuObject has a value
                            $VMImageObject = Get-AzVMImage -Location `
                            $LocationObject.Location -PublisherName $VMPublisherObject `
                            -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus -Version `
                            $VMVersionObject.Name                                           # If #VMVersionObject has a value, pull the full object and assign to $var
                            Break GetAzureImageVersion                                      # Break SelectAzureImageSku
                        }                                                                   # End if ($VMOfferObject)
                        else {                                                              # If $VMSkuObject does not have a value
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($VMOfferObject))
                    }                                                                       # End :SelectAzureImageVersion while ($true)
                }                                                                           # End else(if ($ImageVersionOption -eq '1'))
            }                                                                               # End :GetAzureImageVersion while ($true)
            Return $VMImageObject                                                           # Returns #VMImageObject
        }                                                                                   # End :GetAZVMImage while ($true)
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMOS
function GetAzVMSize {                                                                      # Function for setting the VM size
    Begin {                                                                                 # Begin function
        :GetAzureVMSize while ($true) {                                                     # Outer loop for managing function
            $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName                # Gets a list of all VM sizes in location
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $CoreCountList)
                foreach ($_ in $ValidCore) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Cores"                              # Write message to screen
                }                                                                           # End foreach ($_ in $ValidCore) 
                $CoreCount = Read-Host "Enter the list number for VM core count"            # Operator input for the core count value
                if ($CoreCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($CoreCount -eq '0')
                elseif ($CoreCount -in $ValidCore.Number) {                                 # If $CoreCoint in $ValidCore.Number list
                    $CoreCount = $ValidCore | Where-Object {$_.Number -eq $CoreCount}       # $CoreCount is equal to $ValidCore where $ValidCore.Number equals $CoreCount
                    $CoreCount = $CoreCount.Count                                           # CoreCount is equal to $CoreCount.Count
                    $OperatorConfirm = Read-Host "Confirm:"$CoreCount" cores? [Y] or [N]"   # Operator confirmation of core count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMCoreCount                                           # Breaks :SetAzureVMCoreCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
                }                                                                           # End elseif ($CoreCount -in $ValidCore.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($CoreCount -eq '0'))
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                foreach ($_ in $ValidRam) {                                                 # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"MB"                                 # Write message to screen
                }                                                                           # End foreach ($_ in $ValidRam)
                $RamCount = Read-Host "Enter the list number for VM Ram"                    # Operator input for the ram count selection
                if ($RamCount -eq '0') {                                                    # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($RamCount -eq '0')
                elseif ($RamCount -in $ValidRam.Number) {                                   # If $Ramcount is in $ValidRam.Number list
                    $RamCount = $ValidRam | Where-Object {$_.Number -eq $RamCount}          # $RamCount equals $ValidRam where $ValidRam.Number equals $RamCount 
                    $RamCount = $RamCount.Count                                             # $RamCount equals $RamCount.Count
                    $OperatorConfirm = Read-Host "Confirm:" `
                    $RamCount" MB of Ram? [Y] or [N]"                                       # Operator confirmation on ram count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMRamCount                                            # Breaks :SetAzureRamCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($RamCount -in $ValidRam.Number) 
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RamCount -eq '0'))
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                foreach ($_ in $ValidDisk) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Max disks"                          # Write message to screen
                }                                                                           # End foreach ($_ in $ValidDisk)
                $DiskCount = Read-Host "Enter the list number for VM max disks"             # Operator input for the max disk count
                if ($DiskCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($DiskCount -eq '0')
                elseif ($DiskCount -in $ValidDisk.Number) {                                 # Else if $DiskCount is in $ValidDisk.Number list
                    $DiskCount = $ValidDisk | Where-Object {$_.Number -eq $DiskCount}       # $DiskCount equals $ValidDisk where $ValidDisk.Number equals $DiskCount
                    $DiskCount = $DiskCount.Count                                           # $DiskCount equals $DiskCount.Count
                    $OperatorConfirm = Read-Host `
                    "Confirm"$DiskCount" max disks? [Y] or [N]"                             # Operator confirmation of the disk count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMDiskCount                                           # Breaks :SetAzureVMDiskCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($DiskCount -in $ValidDisk.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($DiskCount -eq '0'))
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to scrren
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                foreach ($_ in $ValidVMSize) {                                              # For each item in list
                    Write-Host "["$_.Number"]" $_.Name                                      # Write message to screen
                    Write-Host "OS disk size:"$_.OSDiskSize"MB"                             # Write message to screen
                    Write-Host "Resource Disk size:"$_.RSDiskSize"MB"                       # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ValidVMSize)
                $VMSizeCount = Read-Host "Enter the list number for VM size"                # Operator input for the VM size
                if ($VMSizeCount -eq '0') {                                                 # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($VMSizeCount -eq '0')
                elseif ($VMSizeCount -in $ValidVMSize.Number) {                             # If $VMSizeCoint is in $ValidVMSize.Number
                    $VMSizeCount = $ValidVMSize | Where-Object {$_.Number -eq $VMSizeCount} # $VMsizeCount is equal to $ValidVMSize where $ValidVMSize.Number equals $VMSizeCount
                    $VMSizeObject = Get-AzVMSize -Location $LocationObject.location | `
                        Where-Object {$_.Name -eq $VMSizeCount.Name}                        # $VMSizeNumber is pulled using $VMSizeCount.Name
                    if ($VMSizeObject) {                                                    # If $VMSizeObject exists
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End if ($VMSizeObject)
                }                                                                           # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($VMSizeCount -eq '0'))
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                          # Generates the load balancer list
            $LoadBalancerNumber = 1                                                         # Sets $LoadBalancerNumber to 1
            [System.Collections.ArrayList]$LoadBalancerArray = @()                          # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                             # For each $Offer in $LoadBalancerList
                $LoadBalancerInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $LoadBalancerNumber;'RGName'=$_.ResourceGroupName}           # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                $LoadBalancerNumber = $LoadBalancerNumber + 1                               # Increments $LoadBalancerNumber by 1
            }                                                                               # End foreach ($_ in $LoadBalancerList)
            Write-Host "0 Exit"                                                             # Write message to screen
            Write-Host ""                                                                   # Write message to screen
            foreach ($_ in $LoadBalancerArray) {                                            # For each $_ in $LoadBalancerArray
                Write-Host $_.Number                                                        # Write message to screen
                Write-Host $_.Name                                                          # Write message to screen
                Write-Host $_.RGName                                                        # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                $OperatorSelect = Read-Host "Enter the load balancer number"                # Operator input for the load balancer selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OperatorSelect -eq '0')
                $LoadBalancerObject = $LoadBalancerArray | Where-Object {$_.Number -eq `
                    $OperatorSelect}                                                        # $LoadBalancerObject is equal to $LoadBalancerArray where $LoadBalancerArray.Number equals $OperatorSelect
                if ($LoadBalancerObject) {                                                  # If $LoadBalancerObject has a value
                    $LoadBalancerObject = Get-AzLoadBalancer -Name `
                        $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.RGName                                          # Repulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End if ($LoadBalancerObject)
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LoadBalancerObject))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer            
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig                               # Calls function and assigns output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $BackEndIPConfigObject = NewAzLBBackendIpConfig                                 # Calls function and assigns output to $var
            if (!$BackEndIPConfigObject) {                                                  # If $BackEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$BackEndIPConfigObject)
            $HealthProbeObject = NewAzLBProbeConfig                                         # Calls function and assigns output to $var
            if (!$HealthProbeObject) {                                                      # If $HealthProbeObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$HealthProbeObject)
            $InboundNatPoolObject = NewAzLBIBNatPoolConfig ($FrontEndIPConfigObject)        # Calls function and assigns output to $var
            if (!$InboundNatPoolObject) {                                                   # If $InboundNatPoolObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$InboundNatPoolObject)
            $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                $BackEndIPConfigObject, $HealthProbeObject)                                 # Calls function and assigns output to $var
            if (!$LoadBalanceRule) {                                                        # If $LoadBalanceRule is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$LoadBalanceRule)
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                $LBNameObject = Read-Host "Load balancer Name"                              # Operator input for the balancer name
                if ($LBNameObject -eq 'exit') {                                             # If $LBNameObject equals $exit
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($LBNameObject -eq 'exit')
                Write-Host $LBNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the balancer name? [Y] or [N]"         # Operator confirmation of the balancer name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBName                                                    # Breaks :SetAzureLBName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBName while ($true)
            $LoadBalancerObject = New-AzLoadBalancer -Name $LBNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -FrontendIpConfiguration $FrontEndIPConfigObject `
                -BackendAddressPool $BackEndIPConfigObject -Probe $HealthProbeObject `
                -LoadBalancingRule $LBRule -InboundNatPool $InboundNatPoolObject            # Creates the load balancer
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                Return $LoadBalancerObject                                                  # Returns $LoadBalancerObject to calling function
            }                                                                               # End if ($LoadBalancerObject)
            else {                                                                          # If $LoadBalancerObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End else(if ($LoadBalancerObject))
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFrontendIpConfig {                                                          # Function to set up the front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :GetAzurePublicIP while ($true) {                                               # Inner loop for getting the public IP
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] New Public IP"                                              # Write message to screen
                Write-Host "[2] Existing public IP"                                         # Write message to screen
                $PublicIPType = Read-Host "[0], [1], or [2]"                                # Operator input for getting the public IP
                if ($PublicIPType -eq '0') {                                                # If $PublicIPType equals '0'
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if ($PublicIPType -eq '0')
                elseif ($PublicIPType -eq '1') {                                            # If $PublicIPType equals 1
                    $PublicIPObject = NewAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '1')
                elseif ($PublicIPType -eq '2') {                                            # If $PublicIPType equals 2
                    $PublicIPObject = GetAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else(if ($PublicIPType -eq '0'))
            }                                                                               # End :GetAzurePublicIP while ($true)
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                $FrontEndNameObject = Read-Host "Front end Name"                            # Operator input for the front end name
                if ($FrontEndNameObject -eq 'exit') {                                       # If $FrontEndNameObject equals $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLBFEIpConfig
                }                                                                           # End if ($FrontEndNameObject -eq 'exit')
                Write-Host $FrontEndNameObject                                              # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the front end name? [Y] or [N]"        # Operator confirmation of the front end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBFEName                                                  # Breaks :SetAzureLBFEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBFEName while ($true)
            $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                $FrontEndNameObject -PublicIpAddress $PublicIPObject                        # Creates the load balancer front end pool
            if ($FrontEndIPConfigObject) {                                                  # If $FrontEndIPConfigObject has a value
                Return $FrontEndIPConfigObject                                              # Returns to calling function with $
            }                                                                               # End if ($FrontEndIPConfigObject)
            else {                                                                          # If $FrontEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End else (if ($FrontEndIPConfigObject))
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFrontendIpConfig
function NewAzPublicIpAddress {                                                             # Creates a new public IP address
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                Try {                                                                       # Try the following
                    [ValidatePattern('^[a-z][a-z0-9-]{1,61}[a-z0-9]$')]$PublicIPNameObject `
                    = [string](Read-Host "Enter the public IP name").ToLower()              # Operator input for the public IP name
                }                                                                           # End try
                catch {                                                                     # Error reporting for try statement
                    Write-Host "! That enty was not valid"                                  # Write message to screen
                    Write-Host "! Valid entries are 1-61 characters"                        # Write message to screen
                    Write-Host "! The name must start with a letter"                        # Write message to screen
                    Write-Host "! Special charaters are not allowed"                        # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End catch
                if ($PublicIPNameObject) {
                    if ($PublicIPNameObject -eq 'exit') {                                   # IF $PublicIPNameObject equals 'exit'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($PublicIPNameObject -eq 'exit')
                    Write-Host $PublicIPNameObject                                          # Write message to screen
                    $OperatorConfirm = Read-Host "Use this name [Y] or [N]"                 # Operator confirmation of the name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If $OperatorConfirm does not equal 'y'
                        Remove-Variable PublicIPNameObject                                  # Removes $PublicIPNameObject
                    }                                                                       # End else if ($OperatorConfirm -eq 'y')
                }                                                                           # End if ($PublicIPNameObject) 
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $PublicIPAllocationObject = Read-Host "[0], [1], or [2]"                    # Operator input for the allocation method
                if ($PublicIPAllocationObject -eq '0') {                                    # If $PublicIPAllocationObject equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($PublicIPAllocationObject -eq '1') {                                # Elseif $PublicIPAllocationObject equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($PublicIPAllocationObject -eq '2') {                                # Elseif $PublicIPAllocationObject equals 2
                    $PublicIPAllocationObject = 'static'                                    # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            $PublicIPObject = New-AzPublicIpAddress -Name $PublicIPNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                -DomainNameLabel $PublicIPNameObject -Force                                 # Creates the new public IP address
            if ($PublicIPObject) {                                                          # If $PublicIPObject is not $null
                Return $PublicIPObject                                                      # Returns to calling function with $PublicIPObject
            }                                                                               # End if ($PublicIPObject)
            else {                                                                          # If $PublicIPObject is $null 
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End else (if ($PublicIPObject))
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for getting an existing public IP address
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            Write-Host "[ 0 ] to exit"                                                      # Write message to screen
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name;'Number' `
                    = $PublicIPNumber;'RG' = $_.ResourceGroupName;'Sku'=$_.Sku.Name `
                ;'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress}           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "["$_.Number"]"                                                  # Write message to screen
                Write-Host "Name "$_.Name                                                   # Write message to screen
                Write-Host "RG:  "$_.RG                                                     # Write message to screen
                Write-Host "Type:"$_.Allocation                                             # Write message to screen
                Write-Host "Add: "$_.address                                                # Write message to screen
                Write-Host "Sku: "$_.Sku                                                    # Write message to screen                            
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                $BackEndNameObject = Read-Host "Back end name"                              # Operator input for the back end name
                if ($BackEndNameObject -eq 'exit') {                                        # If $BackEndNameObject equals $null
                    Break NewAzureLBBEIpConfig                                              # Breaks :NewAzureLBBEIpConfig
                }                                                                           # End if ($BackEndNameObject -eq 'exit')
                Write-Host $BackEndNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the Back end name? [Y] or [N]"         # Operator confirmation of the back end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBBEName                                                  # Breaks :SetAzureLBBEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBBEName while ($true)
            $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                $BackEndNameObject                                                          # Creates the load balancer back end pool
            if ($BackEndIPConfigObject) {                                                   # If $BackEndIPConfigObject has a value
                Return $BackEndIPConfigObject                                               # Returns to calling function with $
            }                                                                               # End if ($BackEndIPConfigObject)
            else {                                                                          # If $BackEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End else (if ($BackEndIPConfigObject))
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {
        :NewAzureLBProbeConfig while ($true) {
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                $ProbeNameObject = Read-Host "Probe Name"                                   # Operator input for the probe name
                if ($ProbeNameObject -eq 'exit') {                                          # If $ProbeNameObject equals $null
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig
                }                                                                           # End if ($ProbeNameObject -eq 'exit')
                Write-Host $ProbeNameObject                                                 # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the probe name? [Y] or [N]"            # Operator confirmation of the probe name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureProbeName                                                 # Breaks :SetAzureProbeName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                $ProbeTypeObject = Read-Host '[0], [1], or [2]'                             # Operator input for the probe type object
                if ($ProbeTypeObject -eq '0') {                                             # If $ProbeTypeObject equals 0
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($ProbeTypeObject -eq '0')
                elseif ($ProbeTypeObject -eq '1') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '1')
                elseif ($ProbeTypeObject -eq '2') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '2')
                else {                                                                      # All other inputs 
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else 
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Try {                                                                       # Try the following
                    [int]$ProbeIntervalObject = Read-Host "Probe interval in seconds"       # Operator input for the probe interval
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeIntervalObject -le 0) {                                           # If $ProbeIntervalObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeIntervalObject -le 0) 
                elseif ($ProbeIntervalObject -ge 1) {                                       # If $ProbeIntervalObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe interval will be set at' `
                    $ProbeIntervalObject 'seconds [Y] or [N]'                               # Operator confirmation of the probe interval
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeIntervalObject -ge 1)
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Try {                                                                       # Try the following
                    [int]$ProbeCountObject = Read-Host "Probe count"                        # Operator input for the probe count
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeCountObject -le 0) {                                              # If $ProbeCountObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeCountObject -le 0) 
                elseif ($ProbeCountObject -ge 1) {                                          # If $ProbeCountObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe count will be set at' `
                    $ProbeCountObject  '[Y] or [N]'                                         # Operator confirmation of the probe count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeCountObject -ge 1)
            }                                                                               # End :SetAzureProbeCount while ($true)
            $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                -ProbeCount $ProbeCountObject                                               # Creates the Health probe object
            if ($HealthProbeObject) {                                                       # If $HealthProbeObject has a value
                Return $HealthProbeObject                                                   # Returns $HealthProbeObject to calling function
            }                                                                               # End if ($HealthProbeObject)
            else {                                                                          # If $HealthProbeObject does not have a value
                Write-Host "An error has occured while setting the probe"                   # Write message to screen
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End else (if ($HealthProbeObject))
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig
function NewAzLBIBNatPoolConfig {                                                           # Creates inbound pool configuration for load balancer
    begin {                                                                                 # Begin function
        :NewAzureLBIBNatPoolConfig while ($true) {                                          # Outer loop for managing function
            :NewAzureLBIBNatPoolName while ($true) {                                        # Inner loop for setting the nat pool name
                $NatPoolNameObject = Read-Host "Pool Name"                                  # Operator input for the pool name
                if ($NatPoolNameObject -eq 'exit') {                                        # If $NatPoolNameObject equals $null
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolNameObject -eq 'exit')
                Write-Host $NatPoolNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the pool name? [Y] or [N]"             # Operator confirmation of the pool name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBIBNatPoolName                                           # Breaks :NewAzureLBIBNatPoolName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBIBNatPoolName while ($true) {
            :NewAzureLBIBNPProtocol while ($true) {                                         # Inner loop for setting the nat pool protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $NatPoolProtocolObject = Read-Host '[0], [1], or [2]'                       # Operator input for the protocol object
                if ($NatPoolProtocolObject -eq '0') {                                       # If $NatPoolProtocolObject equals '0'
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolProtocolObject -eq '0')
                elseif ($NatPoolProtocolObject -eq '1') {                                   # If $NatPoolProtocolObject equals '1'
                    $NatPoolProtocolObject = 'TCP'                                          # Sets $NatPoolProtocolObject to 'TCP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '1')
                elseif ($NatPoolProtocolObject -eq '2') {                                   # If $NatPoolProtocolObject equals '2'
                    $NatPoolProtocolObject = 'UDP'                                          # Sets $NatPoolProtocolObject to 'UDP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($NatPoolProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBIBNPProtocol while ($true)
            :NewAzureLBFEPortStart while ($true) {                                          # Inner loop for setting the front end port range start
                Try {                                                                       # Try the following
                    [int]$FrontEndPortStart = Read-Host "Pool front end port start"         # Operator input for the front end port start
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortStart -le 0) {                                             # If $FrontEndPortStart is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortStart -le 0) 
                elseif ($FrontEndPortStart -ge 1) {                                         # If $FrontEndPortStart is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port start will be' `
                    $FrontEndPortStart '[Y], [N], or [E] to exit'                           # Operator confirmation of the front end port start
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortStart                                         # Breaks :NewAzureLBFEPortStart        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortStart -ge 1)
            }                                                                               # End :NewAzureLBFEPortStart while ($true)
            :NewAzureLBFEPortEnd while ($true) {                                            # Inner loop for setting the front end port range end
                Try {                                                                       # Try the following
                    [int]$FrontEndPortEnd = Read-Host "Pool front end port end"             # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortEnd -le 0) {                                               # If $FrontEndPortEnd is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortEnd -le 0) 
                elseif ($FrontEndPortEnd -ge 1) {                                           # If $FrontEndPortEnd is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port end will be' `
                    $FrontEndPortEnd '[Y], [N], or [E] to exit'                             # Operator confirmation of the front end port end
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortEnd                                           # Breaks :NewAzureLBFEPortEnd        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortEnd -ge 1)
            }                                                                               # End :NewAzureLBFEPortEnd while ($true)
            :NewAzureLBBEPort while ($true) {                                               # Inner loop for setting the back end port
                Try {                                                                       # Try the following
                    [int]$BackEndPort = Read-Host "Pool Back end port"                      # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($BackEndPort -le 0) {                                                   # If $BackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($BackEndPort -le 0) 
                elseif ($BackEndPort -ge 1) {                                               # If $BackEndPort is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $BackEndPort '[Y], [N], or [E] to exit'                                 # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBBEPort                                              # Breaks :NewAzureLBBEPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($BackEndPort -ge 1)
            }                                                                               # End :NewAzureLBBEPort while ($true)
            
            $InboundNatPoolObject = New-AzLoadBalancerInboundNatPoolConfig -Name `
                $NatPoolNameObject -FrontendIpConfigurationId $FrontEndIPConfigObject.ID `
                -Protocol $NatPoolProtocolObject -FrontendPortRangeStart $FrontEndPortStart `
                -FrontendPortRangeEnd $FrontEndPortEnd -BackendPort $BackEndPort            # Creates the inbound pool object
            if ($InboundNatPoolObject) {                                                    # If $InboundNatPoolObject has a value
                Return $InboundNatPoolObject                                                # Returns $InboundNatPoolObject to calling function
            }                                                                               # End if ($InboundNatPoolObject)
            else {                                                                          # If $InboundNatPoolObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBIBNatPoolConfig                                             # Breaks :NewAzureLBIBNatPoolConfig
            }                                                                               # End else (if ($InboundNatPoolObject))
        }                                                                                   # End :NewAzureLBIBNatPoolConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBInboundNatPoolConfig
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                $LBRuleNameObject = Read-Host "Rule Name"                                   # Operator input for the pool name
                if ($LBRuleNameObject -eq 'exit') {                                         # If $LBRuleNameObject equals $null
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleNameObject -eq 'exit')
                Write-Host $LBRuleNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the rule name? [Y] or [N]"             # Operator confirmation of the rule name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBRCName                                                  # Breaks :NewAzureLBRCName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $LBRuleProtocolObject = Read-Host '[0], [1], or [2]'                        # Operator input for the protocol object
                if ($LBRuleProtocolObject -eq '0') {                                        # If $LBRuleProtocolObject equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleProtocolObject -eq '0')
                elseif ($LBRuleProtocolObject -eq '1') {                                    # If $LBRuleProtocolObject equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '1')
                elseif ($LBRuleProtocolObject -eq '2') {                                    # If $LBRuleProtocolObject equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($LBRuleProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Try {                                                                       # Try the following
                    [int]$LBRuleFrontEndPort = Read-Host "Rule front end port"              # Operator input for the front end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleFrontEndPort -le 0) {                                            # If $LBRuleFrontEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleFrontEndPort -le 0) 
                elseif ($LBRuleFrontEndPort -ge 1) {                                        # If $LBRuleFrontEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Front end port will be' `
                    $LBRuleFrontEndPort '[Y], [N], or [E] to exit'                          # Operator confirmation of the front end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleFrontEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Try {                                                                       # Try the following
                    [int]$LBRuleBackEndPort = Read-Host "Rule back end port"                # Operator input for the back end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleBackEndPort -le 0) {                                             # If $LBRuleBackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleBackEndPort -le 0) 
                elseif ($LBRuleBackEndPort -ge 1) {                                         # If $LBRuleBackEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $LBRuleBackEndPort '[Y], [N], or [E] to exit'                           # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleBackEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Try {                                                                       # Try the following
                    [int]$LBRuleIdleTO = Read-Host "Rule idle time out"                     # Operator input for the rule idle timeout
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleIdleTO -le 0) {                                                  # If $LBRuleIdleTO is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleIdleTO -le 0) 
                elseif ($LBRuleIdleTO -ge 1) {                                              # If $LBRuleIdleTO is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Load balancer idle timeout will be' `
                    $LBRuleIdleTO '[Y], [N], or [E] to exit'                                # Operator confirmation of the rule idle timeout
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleIdleTO -ge 1)
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO -EnableFloatingIP `
                -LoadDistribution SourceIP                                                  # Creates the load balancer rule
            if ($LoadBalanceRule) {                                                         # If $LoadBalanceRule has a value
                Return $LoadBalanceRule                                                     # Returns to calling function with $LoadBalanceRule
            }                                                                               # End if ($LoadBalanceRule)
            else {                                                                          # If $LoadBalanceRule does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzLBRuleConfig                                                     # Breaks :NewAzLBRuleConfig     
            }                                                                               # End else (if ($LoadBalanceRule))
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig