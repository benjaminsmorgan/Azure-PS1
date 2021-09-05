# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-Object:                                 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object?view=powershell-7.1
    Get-AzVMSize:                               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.4.0
    New-AzVMConfig:                             https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmconfig?view=azps-5.4.0
    Set-AzVMOperatingSystem:                    https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmoperatingsystem?view=azps-5.4.0
    Add-AzVMNetworkInterface:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-5.4.0
    Set-AzVMSourceImage:                        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmsourceimage?view=azps-5.4.0
    New-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm?view=azps-5.4.0     
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Start-AzVM:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Stop-AzVM:                                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Invoke-AzVMReimage:                         https://docs.microsoft.com/en-us/powershell/module/az.compute/Invoke-AzVMReimage?view=azps-5.4.0
    Remove-AzVM:                                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    New-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.4.0
    New-AzVmssConfig:                           https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssconfig
    New-AzVmssIPConfig:                         https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmssipconfig
    Add-AzVmssNetworkInterfaceConfiguration:    https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmssnetworkinterfaceconfiguration
    New-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmss
    Set-AzVmssOsProfile:                        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssosprofile
    Set-AzVmssStorageProfile:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmssstorageprofile
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzVMImageOffer:                         https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimageoffer
    Get-AzVMImageSku:                           https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku
    Get-AzVMImage:                              https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimage
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Remove-AzVmss:                              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmss?view=azps-5.6.0
    Get-AzVmssVM:                               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmssvm?view=azps-5.6.0
    Start-AzVmss:                               https://docs.microsoft.com/en-us/powershell/module/az.compute/start-azvmss?view=azps-5.6.0
    Stop-AzVmss:                                https://docs.microsoft.com/en-us/powershell/module/az.compute/Stop-azvmss?view=azps-5.6.0
    New-AzContainerGroup:                       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.6.0
    Get-AzContainerGroup:                       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0
    Remove-AzContainerGroup:                    https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/remove-azcontainergroup?view=azps-5.6.0
    New-AzAksCluster:                           https://docs.microsoft.com/en-us/powershell/module/az.aks/new-azakscluster?view=azps-5.6.0
    Get-AzAksCluster:                           https://docs.microsoft.com/en-us/powershell/module/az.aks/get-azakscluster?view=azps-5.6.0
    Remove-AzAksCluster:                        https://docs.microsoft.com/en-us/powershell/module/az.aks/remove-azakscluster?view=azps-5.6.0
    New-AzDisk:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Get-AzDisk:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
    Remove-AzDisk:                              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-5.4.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    ManageAzVM:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/ManageAzVM.ps1
        NewAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/NewAzVM.ps1
        GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1                    
        StartAzVM:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StartAzVM.ps1
        StopAzVM:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StopAzVM.ps1
        ReImageAzVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/ReimageAzVM.ps1
        RemoveAzVM:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/RemoveAzVM.ps1
        SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
        GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
        NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzVmss:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/ManageAzVmss.ps1
        SetAzVmssOsProfile:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssOsProfile.ps1
        SetAzVmssStorageProfile:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/SetAzVmssStorageProfile.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
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
    ManageAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/ManageAzContainerGroup.ps1
        NewAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/NewAzContainerGroup.ps1
        GetAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/GetAzContainerGroup.ps1
        RemoveAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/RemoveAzContainerGroup.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzAksCluster:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/ManageAzAksCluster.ps1
        GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/NewAzAksCluster.ps1 
        GetAzAksCluster:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/GetAzAksCluster.ps1 
        RemoveAzAksCluster:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Kubernetes/RemoveAzAksCluster.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1 
    ManageAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/ManageAzDisk.ps1
        NewAzDisk:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/NewAzDisk.ps1
        ListAzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/ListAzDisk.ps1
        Get-AzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/GetAzDisk.ps1
        RemoveAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/RemoveAzDisk.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
        GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    ManageAzCompute:            Management function for computer object
    ManageAzVM:                 Management function for VMs
        NewAzVM:                    Creates a new virtual machine
        GetAzVM:                    Gets an existing VM                    
        StartAzVM:                  Starts a selected VM
        StopAzVM:                   Stops a selected VM
        ReImageAzVM:                Reimages a selected VM
        RemoveAzVM:                 hRemoves a selected VM
        SetAzVMOS:                  Selects a market place image
        GetAzVMSize:                Gets a VM size
        NewAzNetworkInterface:      Creates a new network interface
        GetAzVNetSubnetConfig:      Gets a vnet subnet
        GetAzVirtualNetwork:        Gets a virtual network
        GetAzNetworkInterface:      Gets a network interface
        GetAzResourceGroup:         Gets a resource group
    ManageAzVmss:               Management function for Vmss(s)
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
    ManageAzContainerGroup:     Management function for container groups
        NewAzContainerGroup:        Creates a container group
        GetAzContainerGroup:        Gets a container group
        RemoveAzContainerGroup:     Removes a container group
        GetAzResourceGroup:         Gets a resource group
    ManageAzAksCluster:         Management function for Aks clusters
        NewAzAksCluster:            Creates an Aks cluster
        GetAzAksCluster:            Gets an Aks cluster
        RemoveAzAksCluster:         Removes a selected Aks cluster
        GetAzResourceGroup:         Gets a resource group
    ManageAzDisk:               Management function for disks
        ManageAzDisk:               Management function for disks
        NewAzDisk:                  Creates a new disk
        ListAzDisk:                 Lists all disks
        GetAzDisk:                  Gets a disk
        RemoveAzDisk:               Removes a selected disk

} #>
<# Variables: {
    :ManageAzCompute         Outer loop for managing function
    ManageAzVM{}                Manages $VMObject
        NewAzVM{}                   Creates $VMObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzVMSize{}               Gets $VMSizeObject
            NewAzNetworkInterface{}     Gets $NicObject
                GetAzVNetSubnetConfig{} Gets $SubnetObject
                    GetAzVirtualNetwork{}       Gets $VnetObject
            GetAzNetworkInterface{}     Gets $NicObject 
                GetAzVNetSubnetConfig{} Gets $SubnetObject
                    GetAzVirtualNetwork{}       Gets $VnetObject
            SetAzVMOS{}                 Gets $VMImageObject
        GetAzVM{}                   Gets $VMObject
        StartAzVM{}                 Starts $VMObject
            GetAzVM{}                   Gets $VMObject
        StopAzVM{}                  Stopss $VMObject
            GetAzVM{}                   Gets $VMObject
        ReimageAzVM{}               Reimages $VMObject
            GetAzVM{}                   Gets $VMObject
        RemoveAzVM{}                Removes $VMObject
            GetAzVM{}                   Gets $VMObject
    ManageAzVmss{}              Manages $VmssObject
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
    ManageAzContainerGroup{}    Manages $ContainerObject
        NewAzContainerGroup{}       Creates $ContainerGroup
        GetAzContainerGroup{}       Gets $ContainerGroup
        RemoveAzContainerGroup{}    Removes $ContainerGroup
            GetAzContainerGroup{}       Gets $ContainerGroup
    ManageAzAksCluster{}        Manages $AksObject
        NewAzAksCluster{}           Creates $AksObject
            GetAzResourceGroup{}        Gets $RGObject
        GetAzAksCluster{}           Gets $AksObject
        RemoveAzAksCluster          Removes $AksObject
            GetAzAksCluster{}           Gets $AksObject
    ManageAzDisk{}              Manages $DiskObject
        NewAzDisk{}                 Creates $DiskObject           
            GetAzResourceGroup{}        Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        ListAzDisk{}                Lists disks
        GetAzDisk{}                 Gets $DiskObject
        RemoveAzDisk{}              Removes $DiskObject
            GetAzDisk{}                 Gets $DiskObject
} #>
<# Process Flow {
    function
        Call ManageAzCompute > Get $null
            Call ManageAzVM > Get $null
                Call NewAzVMWin > Get $WinVMObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzVMWin > Send $RGObject
                    Call GetAzVMSize > Get $VMSizeObject
                    End GetAzVMSize
                        Return NewAzVMWin > Send $VMSizeObject
                    Call NewAzNetworkInterface > Get $NicObject
                        Call GetAzVNetSubnetConfig > Get $SubnetObject
                            Call GetAzVirtualNetwork > Get $Vnet
                            End GetAzVirtualNetwork
                                Return GetAzVNetSubnetConfig > Send $Vnet
                        End GetAzVNetSubnetConfig
                            Return NewAzNetworkInterface > Send $SubnetObject
                    End NewAzNetworkInterface
                        Return NewAzVMWin > Send $ NicObject
                    Call GetAzNetworkInterface > Get $NicObject
                        Call GetAzVNetSubnetConfig > Get $SubnetObject
                            Call GetAzVirtualNetwork > Get $Vnet
                            End GetAzVirtualNetwork
                                Return GetAzVNetSubnetConfig > Send $Vnet
                        End GetAzVNetSubnetConfig
                            Return NewAzNetworkInterface > Send $SubnetObject
                    End GetAzNetworkInterface
                        Return NewAzVMWin > Send $NicObject
                    Call GetAzVMSize > Get $VMImageObject
                    End GetAzVMSize
                        Return NewAzVMWin > Send $VMImageObject
                End NewAzVMWin
                    Return ManageAzVM > Send $VMObject
                Call GetAzVM > Get $VMObject
                End GetAzVM
                    Return ManageAzVM > Send $VMObject
                Call StartAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return StartAzVM > Send $VMObject
                End StartAzVM
                    Return ManageAzVM > Send $null
                Call StopAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return StopAzVM > Send $VMObject
                End StopAzVM
                    Return ManageAzVM > Send $null
                Call ReimageAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return ReimageAzVM > Send $VMObject
                End ReimageAzVM
                    Return ManageAzVM > Send $null
                Call RemoveAzVM > Get $null
                    Call GetAzVM > Get $VMObject
                    End GetAzVM
                        Return RemoveAzVM > Send $VMObject
                End RemoveAzVM
                    Return ManageAzVM > Send $null
            End ManageAzVM
                Return ManageAzCompute > Send $null
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
                Return ManageAzCompute > Send $null
            Call ManageAzContainerGroup > Get $null
                Call NewAzContainerGroup > Get $ContainerObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup 
                    Return NewAzContainerGroup > Send $RGObject
                End NewAzContainerGroup
                    Return ManageAzContainerGroup > Send $ContainerObject
                Call GetAzContainerGroup > Get $ContainerObject
                End GetAzContainerGroup
                        Return ManageAzContainerGroup > Send $ContainerObject
                Call RemoveAzContainerGroup > Get $null
                    Call GetAzContainerGroup > Get $ContainerObject
                    End GetAzContainerGroup
                        Return RemoveAzContainerGroup > Send $ContainerObject
                End RemoveAzContainerGroup
                    Return ManageAzContainerGroup > Send $null
            End ManageAzContainerGroup
                Return ManageAzCompute > Send $null
            Call ManageAzAksCluster > Get $null
                Call NewAzAksCluster > Get $AksObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup 
                        Return NewAzAksCluster > Send $RGObject
                End NewAzAksCluster
                    Return ManageAzAksCluster > Send $AksObject
                Call GetAzAksCluster > Get $AksObject
                End GetAzAksCluster
                    Return ManageAzAksCluster > Send $AksObject
                Call RemoveAzAksCluster > Get $null
                    Call GetAzAksCluster > Get $AksObject
                    End GetAzAksCluster
                        Return RemoveAzAksCluster > Send $AksObject
                End RemoveAzAksCluster
                    Return ManageAzAksCluster > Send $null
            End ManageAzAksCluster
                Return ManageAzCompute > Send $null
            Call ManageAzDisk > Get $null
                Call NewAzDisk > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzDisk > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzDisk > Send $LocationObject
                    Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultKey > Send $KeyVaultObject
                    End GetAzKeyVaultKey
                        Return NewAzDisk > Send $KeyVaultKeyObject, $KeyVaultObject
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret
                        Return NewAzDisk > Send $KeyVaultSecretObject, $KeyVaultObject
                End NewAzDisk
                    Return ManageAzDisk > Send $null
                Call ListAzDisk > Get $null
                End ListAzDisk
                    Return ManageAzDisk > Return $null
                Call RemoveAzDisk > Get $null
                    Call GetAzDisk > Get $DiskObject
                    End GetAzDisk
                        Return RemoveAzDisk > Send $DiskObject
                End RemoveAzDisk
                    Return ManageAzDisk > Return $null
            End ManageAzDisk
                Return ManageAzCompute > Send $null
        End ManageAzCompute
            Return Function > Send $null
}#>
function ManageAzCompute {                                                                  # Function to manage azure compute
    Begin {                                                                                 # Begin function
        :ManageAzureCompute while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Azure Compute Management'                                           # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Manage VMs'                                                     # Write message to screen
            Write-Host '[2] Manage Vmss'                                                    # Write message to screen
            Write-Host '[3] Manage compute containers'                                      # Write message to screen
            Write-Host '[4] Manage Kubernetes'                                              # Write message to screen
            Write-Host '[5] Manage Disks'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Collects operator input on $OpSelect option
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureCompute                                                    # Breaks :ManageAzureCompute
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Manage VMs'                                                     # Write message to screen
                ManageAzVM ($RGObject, $RSObject)                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals 2
                Write-Host 'Manage Vmss'                                                    # Write message to screen
                ManageAzVmss                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals 3
                Write-Host 'Manage compute containers'                                      # Write message to screen
                ManageAzContainerGroup                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals 4
                Write-Host "Manage Kubernetes"                                              # Write message to screen
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals 5
                Write-Host 'Manage Disks'                                                   # Write message to screen
                ManageAzDisk                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # If $OpSelect do not match any if or elseif     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End ManageAzCompute while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzCompute
# Functions for ManageAzVM
function ManageAzVM {                                                                       # Function to manage VMs
    Begin {                                                                                 # Begin function
        :ManageAzureVM while ($true) {                                                      # Outer loop for managing function
            Write-Host 'Azure VM Management'                                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Create New VM'                                                  # Write message to screen
            Write-Host '[2] List VMs'                                                       # Write message to screen
            Write-Host '[3] Start VM'                                                       # Write message to screen
            Write-Host '[4] Stop VM'                                                        # Write message to screen
            Write-Host '[5] Reimage VM'                                                     # Write message to screen
            Write-Host '[6] Remove VM'                                                      # Write message to screen
            Write-Host '[7] Add NIC to VM'                                                  # Write message to screen
            Write-Host '[8] Remove NIC from VM'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input on management option
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureVM                                                         # Breaks :ManageAzureVM 
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $Opselect equals '1'
                Write-Host 'Create New VM'                                                  # Write message to screen
                NewAzVM                                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $Opselect equals '2'
                Write-Host 'List VMs'                                                       # Write message to screen
                ListAzVM                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $Opselect equals '3'
                Write-Host 'Start VM'                                                       # Write message to screen
                StartAzVM                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $Opselect equals '4'
                Write-Host 'Stop VM'                                                        # Write message to screen
                StopAzVM                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $Opselect equals '5'
                Write-Host 'Reimage VM'                                                     # Write message to screen
                ReimageAzVM                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $Opselect equals '6'
                Write-Host 'Remove VM'                                                      # Write message to screen
                RemoveAzVM                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $Opselect equals '7'
                Write-Host 'Add NIC to VM'                                                  # Write message to screen
                AddAzVMNic                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $Opselect equals '8'
                Write-Host 'Remove NIC from VM'                                             # Write message to screen
                RemoveAzVMNic                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '8')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else(if ($OpSelect -eq '0'))
        }                                                                                   # End ManageAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVM
function NewAzVM {                                                                          # Function to create a new virtual machine
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzVM'                                                    # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureVM while ($true) {                                                         # Outer loop for managing function
            :SetAzureVMType while ($true) {                                                 # Inner loop for setting the VM type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Windows'                                                    # Write message to screen
                Write-Host '[2] Linux'                                                      # Write message to screen
                $ImageTypeObject = Read-Host 'Option [#]'                                   # Operator input for the VM type
                Clear-Host                                                                  # Clears screen
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVM                                                        # Breaks :NewAzVM
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVMType                                                    # Breaks :SetAzureVMType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls (Function) GetAzResourceGroup to get $RGObject
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$RGObject) 
            $LocationObject = Get-AzLocation | Where-Object {$_.location -eq `
                $RGObject.location}                                                         # Sets $Location object to match $RGObject.location
            Write-Host $LocationObject.Location
            :SetAzureVMName while ($true) {                                                 # Inner loop for setting the VM name
                $VMNameObject = Read-Host 'New VM Name'                                     # Operator input for the VM name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMNameObject' as the VM name'                             # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the VM name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVMName                                                    # Breaks :SetAzureVMName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {                                             # Inner loop for setting the VM username
                $VMUserNameObject = Read-Host 'VM Local username'                           # Operator input of the local admin user name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMUserNameObject' as the local username'                  # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the local admin user name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVMUserName                                                # Breaks :SetAzureVMUserName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMUserName while ($true)
            :SetAzureVMPassword while ($true) {                                             # Inner loop for setting the password
                $VMPasswordObject = Read-Host 'VM Local password'                           # Operator input for the password
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMPasswordObject' as the local username password'         # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the password
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject `
                        -AsPlainText -Force                                                 # Hashes $VMPasswordObject
                    Break SetAzureVMPassword                                                # Breaks :SetAzureVMPassword
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential `
                ($VMUserNameObject, $VMPasswordObject)                                      # Builds credential object using $VMUsernameObject and $VMPasswordObject
            $VMImageObject = SetAzVMOS ($CallingFunction, $LocationObject, $ImageTypeObject)# Calls function and assigns output to $var
            if (!$VMImageObject){                                                           # If $VMImageObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$VMImageObject)
            $HVGen = $VMImageObject.HyperVGeneration
            $HVGen = '*'+$HVGen+'*'
            $VMSizeObject = GetAzVMSize ($CallingFunction, $LocationObject, $HVGen)         # Calls function and assigns output to $var
            if (!$VMSizeObject) {                                                           # If $VMSizeObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$VMSizeObject)
            $VMBuildObject = New-AzVMConfig -VMName $VMNameObject -VMSize `
                $VMSizeObject.Name                                                          # Starts $VMBuildObject
            if ($ImageTypeObject -eq '1') {                                                 # If $ImageTypeObject equals '1'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Windows `
                    -ComputerName $VMNameObject -Credential $VMCredObject -ProvisionVMAgent `
                    -EnableAutoUpdate                                                       # Adds VM info to $VMBuildObject
            }                                                                               # End if ($ImageTypeObject -eq '1') 
            elseif ($ImageTypeObject -eq '2') {                                             # If $ImageTypeObject equals '2'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Linux `
                    -ComputerName $VMNameObject -Credential $VMCredObject                   # Adds VM info to $VMBuildObject
            }                                                                               # End elseif ($ImageTypeObject -eq '2')
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface `
                ($CallingFunction, $LocationObject)                                         # Calls function and assigns output for $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$NicObject)
            $VMBuildObject = Add-AzVMNetworkInterface -VM $VMBuildObject -Id $NicObject.Id  # Adds NIC info to $VMBuildObject
            $VMBuildObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $VMImageObject.PublisherName -Offer $VMImageObject.Offer -Skus `
                $VMImageObject.Skus -Version $VMImageObject.Version                         # Adds image setting to $VMBuildObject
            Try {                                                                           # Try the following
                Write-Host 'Attempting to build the VM'                                     # Write message to screen
                Write-Host 'This may take a few minutes'                                    # Write message to screen
                New-AzVM -ResourceGroupName $RGObject.ResourceGroupName -VM $VMBuildObject `
                    -Location $LocationObject.Location -Verbose -ErrorAction 'Stop'         # Builds the new VM object
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not created'                                         # Write message to screen
                Write-Host 'The image and VM may'                                           # Write message to screen
                Write-host 'be different generations'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End catch
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'The VM has been created'                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVM                                                                # Breaks :NewAzureVM
        }                                                                                   # End :NewAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVM                                                                                   # End function GetAzVMSize 
function GetAzVM {                                                                          # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVM                                                            # Breaks :GetAzureVM
            }                                                                               # End if (!$VMList)
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $NicArray = @()                                                             # Creates $NicArray
                $NicIDs = $_.NetworkProfile.NetworkInterfaces.ID                            # Isolates the IDs
                foreach ($ID in $NicIDs) {                                                  # For each item in $NicIDs
                    $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}      # Pulls the full NIC object
                    $NicArray += $NicObject                                                 # Adds $NicObject to $NicArray
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($ID in $NicIDs) 
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'Name'=$_.Name;                                                         # VM name
                    'RG'=$_.ResourceGroupName;                                              # Resource group name
                    'Status' = $_.PowerState;                                               # VM power state
                    'LOC'=$_.Location;                                                      # VM location
                    'OS'=$_.OsProfile;                                                      # Os profile
                    'NIC'=$NicArray                                                         # VM Nic info
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
                $NicArray = $null                                                           # Clears $var
                $NicIDs = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $VMList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureVM while ($true) {                                                  # Inner loop for selecting VM from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $VMArray) {                                                  # For each item in $VMArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))                     
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Location:'$_.LOC                                            # Write message to screen
                    if ($_.OS.WindowsConfiguration) {                                       # If current item .OS.WindowsConfiguration has a value
                        Write-Host 'OS Type:  Windows'                                      # Write message to screen
                    }                                                                       # End if ($_.OS.WindowsConfiguration)
                    elseif ($_.OS.LinuxConfiguration) {                                     # If current item .OS.LinuxConfiguration has a value
                        Write-Host 'OS Type:  Linux'                                        # Write message to screen
                    }                                                                       # End elseif ($_.OS.LinuxConfiguration)
                    Write-Host 'Status:  '$_.Status                                         # Write message to screen
                    foreach ($NIC in $_.Nic) {                                              # For each item in current item .nic
                        Write-Host 'Nic Name:'$NIC.Name                                     # Write message to screen
                        if ($NIC.IPConfigurations.Count -gt 1) {                            # If $NIC.IPConfigurations.Count is greater than 1
                            $PriIP = $NIC.IpConfigurations.PrivateIpAddress[0]              # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress 1st value
                            $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod[0]  # $PriIPAll is equal $NIC.IpConfigurations.PrivateIpAllocationMethod 1st value
                            Write-Host '  Pri IP:  '$PriIP                                  # Write message to screen
                            Write-Host '  Pri Allo:'$PriIPAll                               # Write message to screen
                        }                                                                   # End if ($NIC.IPConfigurations.Count -gt 1)
                        else {                                                              # Else If $NIC.IPConfigurations.Count is 1 or less
                            $PriIP = $NIC.IpConfigurations.PrivateIpAddress                 # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress
                            $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod     # $PriIPAll is equal to $NIC.IpConfigurations.PrivateIpAllocationMethod 
                            Write-Host '  Pri IP:  '$PriIP                                  # Write message to screen
                            Write-Host '  Pri Allo:'$PriIPAll                               # Write message to screen
                        }                                                                   # End else (if ($NIC.IPConfigurations.Count -gt 1))
                    }                                                                       # End foreach ($NIC in $_.Nic)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $VMList)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the VM for:'$CallingFunction              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                elseif ($OpSelect -in $VMArray.Number) {
                    $OpSelect = $VMArray | Where-Object {$_.Number -eq $OpSelect}           # $OpSelect equals $VMArray where $VMArray.Number equals $OpSelect
                    $VMObject = Get-AzVM -ResourceGroupName $OpSelect.RG `
                        -Name $OpSelect.Name                                                # Pulls full $VMObject
                    Return $VMObject                                                        # Returns to calling function with $VMObject
                }                                                                           # End elseif ($OpSelect -in $VMArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVM while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVM
function ListAzVM {                                                                         # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :ListAzureVM while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVM                                                           # Breaks :ListAzureVM
            }                                                                               # End if (!$VMList)
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $NicArray = @()                                                             # Creates $NicArray
                $NicIDs = $_.NetworkProfile.NetworkInterfaces.ID                            # Isolates the IDs
                foreach ($ID in $NicIDs) {                                                  # For each item in $NicIDs
                    $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}      # Pulls the full NIC object
                    $NicArray += $NicObject                                                 # Adds $NicObject to $NicArray
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($ID in $NicIDs) 
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Name'=$_.Name;                                                         # VM name
                    'RG'=$_.ResourceGroupName;                                              # Resource group name
                    'Status' = $_.PowerState;                                               # VM power state
                    'LOC'=$_.Location;                                                      # VM location
                    'OS'=$_.OsProfile;                                                      # Os profile
                    'NIC'=$NicArray                                                         # VM Nic info
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $NicArray = $null                                                           # Clears $var
                $NicIDs = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $VMList)
            Clear-Host                                                                      # Clears screen
            Write-Host 'Name:    '$_.Name                                                   # Write message to screen
            Write-Host 'RG:      '$_.RG                                                     # Write message to screen
            Write-Host 'Location:'$_.LOC                                                    # Write message to screen
            if ($_.OS.WindowsConfiguration) {                                               # If current item .OS.WindowsConfiguration has a value
                Write-Host 'OS Type:  Windows'                                              # Write message to screen
            }                                                                               # End if ($_.OS.WindowsConfiguration)
            elseif ($_.OS.LinuxConfiguration) {                                             # If current item .OS.LinuxConfiguration has a value
                Write-Host 'OS Type:  Linux'                                                # Write message to screen
            }                                                                               # End elseif ($_.OS.LinuxConfiguration)
            Write-Host 'Status:  '$_.Status                                                 # Write message to screen
            foreach ($NIC in $_.Nic) {                                                      # For each item in current item .nic
                Write-Host 'Nic Name:'$NIC.Name                                             # Write message to screen
                if ($NIC.IPConfigurations.Count -gt 1) {                                    # If $NIC.IPConfigurations.Count is greater than 1
                    $PriIP = $NIC.IpConfigurations.PrivateIpAddress[0]                      # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress 1st value
                    $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod[0]          # $PriIPAll is equal $NIC.IpConfigurations.PrivateIpAllocationMethod 1st value
                    Write-Host '  Pri IP:  '$PriIP                                          # Write message to screen
                    Write-Host '  Pri Allo:'$PriIPAll                                       # Write message to screen
                }                                                                           # End if ($NIC.IPConfigurations.Count -gt 1)
                else {                                                                      # Else If $NIC.IPConfigurations.Count is 1 or less
                    $PriIP = $NIC.IpConfigurations.PrivateIpAddress                         # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress
                    $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod             # $PriIPAll is equal to $NIC.IpConfigurations.PrivateIpAllocationMethod 
                    Write-Host '  Pri IP:  '$PriIP                                          # Write message to screen
                    Write-Host '  Pri Allo:'$PriIPAll                                       # Write message to screen
                }                                                                           # End else (if ($NIC.IPConfigurations.Count -gt 1))
            }                                                                               # End foreach ($NIC in $_.Nic)
            Write-Host ''                                                                   # Write message to screen
        }                                                                                   # End :ListAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVM
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StartAzVM'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM is already powered on (Allocated)'                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'No changes have been made'                                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            Write-Host 'Power on:'$VMObject.name                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power on:'$VMObject.Name                      # Write message to screen
                    Start-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'Stop' | Out-Null              # Starts the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host $VMObject.Name 'has been powered on'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :StartAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StopAzVM'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -eq 'PowerState/deallocated') {                                   # If $VMStatus equals 'PowerState/deallocated'
                Write-Host 'This VM is already powered off (Deallocated)'                   # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'No changes have been made'                                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM        
            }                                                                               # End if ($VMStatus -eq 'PowerState/deallocated')
            Write-Host 'Power off:'$VMObject.name                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn off the VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power off:'$VMObject.Name                     # Write message to screen
                    Stop-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -force -ErrorAction 'Stop' | Out-Null       # Stops the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered off'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :StopAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM
function ReimageAzVM {                                                                      # Function to reimage a VM
    Begin {                                                                                 # Begin function
        #$ErrorActionPreference='silentlyContinue'                                           # Disables powershell error reporting
        :ReimageAzVM while ($true) {                                                        # Outer loop for managing function
            $VMObject = GetAzVM                                                             # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Reimage:'$VMObject.name
            Write-Host 'RG:     '$VMObject.ResourceGroupName
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to reimage the VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {
                Write-Host "Attempting to reimage" $VMObject.Name                               # Write message to screen
                #try {                                                                           # Try the following
                    Invoke-AzVMReimage -Name $VMObject.Name -ResourceGroup `
                        $VMObject.ResourceGroupName -ErrorAction 'stop'                         # Reimages the selected VM
                #}                                                                               # End Try
                #catch {                                                                         # If try fails
                #    Write-Host ""                                                               # Write message to screen
                #    Write-Host "***An Error Has Occured***"                                     # Write message to screen
                #    Write-Host "Un-able to reimage the selected VM"                             # Write message to screen
                #    Write-Host "Auto OS upgrades may not be enabled"                            # Write message to screen
                #    Write-Host "You may not have permission to this VM"                         # Write message to screen
                #    Write-Host "The VM or group may be locked"                                  # Write message to screen
                #    Write-Host ""                                                               # Write message to screen
                #    Break ReimageAzVM                                                           # Breaks :ReimageAzVM
                #}                                                                               # End Catch
                Pause
                Break ReimageAzVM                                                               # Breaks :ReimageAzVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # If OpConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                pause                                                                       # Pauses all actions for operator input
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
            
        }                                                                                   # End :ReimageAzVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ReimageAzVM
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVM'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Remove:'$VMObject.name                                              # Write message to screen
            Write-Host ''                                                                   # Writes message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to remove:'$VMObject.Name                        # Write message to screen
                    Remove-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -Force -ErrorAction 'Stop' | Out-Null       # Removes the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been removed'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :RemoveAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM
function AddAzVMNic {                                                                       # Function to add a NIC to an existing VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVMNic'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureVMNic while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic
            }                                                                               # End if (!$VMObject)
            $VMSize = Get-AzComputeResourceSku -Location $VMObject.Location  | `
                Where-Object {$_.Name -eq $VMObject.HardwareProfile.VmSize}                 # Gets the VM size
            $MaxNics = $VMSize.Capabilities[26].value                                       # Isolates the max number of nics available for VM size
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics) {         # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count -equals $MaxNics
                Write-Host 'This VM already has the max number'                             # Write message ot screen
                Write-Host 'of NICs supported by the VM size'                               # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please remove an existing nic '                                 # Write message ot screen
                Write-Host 'before adding a new one, or please'                             # Write message ot screen
                Write-Host 'change the VM size'                                             # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1) {                # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count is greater than 1
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID[0]                 # Isloates the first NIC ID
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1)
            else {                                                                          # Else If$VMObject.NetworkProfile.NetworkInterfaces.ID.Count is 1 or less
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID                    # Isolates the NIC ID
            }                                                                               # End else (if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1))
            $ExistingNic = Get-AzNetworkInterface | Where-Object {$_.ID -eq $VMSubID}       # Pulls the existing primary Nic object
            if ($ExistingNic.IpConfigurations.Count -gt 1) {                                # If $ExistingNic.IpConfigurations.Count greater than 1 
                $SubnetID = $ExistingNic.IpConfigurations[0].Subnet.ID                      # Isolates the subnet ID    
            }                                                                               # End if ($ExistingNic.IpConfigurations.Count -gt 1) 
            else {                                                                          # Else if $ExistingNic.IpConfigurations.Count equals 1 
                $SubnetID = $ExistingNic.IpConfigurations.Subnet.ID                         # Isolates the subnet ID
            }                                                                               # End else (if ($ExistingNic.IpConfigurations.Count -gt 1) )
            :SelectAzureNIC while ($true) {                                                 # Inner loop for selecting the additional nic
                $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface `
                    ($CallingFunction)                                                      # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End if (!$NicObject)
                if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) {                  # If $NicObject.IpConfigurations.Subnet.ID does not equal $SubnetID 
                    Write-Host 'The selected NIC is on a different subnet'                  # Write message to screen
                    Write-Host 'Please chose a different NIC'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) 
                else {                                                                      # Else if $NicObject.IpConfigurations.Subnet.ID equals $SubnetID
                    Break SelectAzureNIC                                                    # Breaks :SelectAzureNIC
                }                                                                           # End else (if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID))
            }                                                                               # End :SelectAzureNIC while ($true)
            :Confirm while ($true) {                                                        # Inner loop for confirming change
                Write-Host 'Add the following'                                              # Write message to screen
                Write-Host 'Name:      '$NicObject.Name                                     # Write message to screen
                if ($NicObject.IpConfigurations.Count -gt 1) {                              # If $NicObject.IpConfigurations.Count is greater than 1
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress[0]                # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod[0]    # Isolates the private IP allocation method
                }                                                                           # End if ($NicObject.IpConfigurations.Count -gt 1)
                else {                                                                      # Else if $NicObject.IpConfigurations.Count is 1 or less
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress                   # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod       # Isolates the private IP allocation method
                }                                                                           # End else (if ($NicObject.IpConfigurations.Count -gt 1))
                Write-Host 'Private IP:'$PriIP                                              # Write message to screen
                Write-Host 'Allocation:'$PriIPAll                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'To the following VM'                                            # Write message to screen
                Write-Host 'Name:      '$VMObject.Name                                      # Write message to screen
                Write-Host 'RG:        '$VMObject.ResourceGroupName                         # Write message to screen
                if ($VMObject.OS.WindowsConfiguration) {                                    # If $VMObject.OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:    Windows'                                        # Write message to screen
                }                                                                           # End if ($VMObject.OS.WindowsConfiguration)
                elseif ($VMObject.OS.LinuxConfiguration) {                                  # If $VMObject.OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:    Linux'                                          # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to make the change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End elseif ($OpConfirm -eq 'n') 
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen 
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Making the requested changes'                                   # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary) {               # If the first interface is not flagged as primary
                    $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $true           # Sets the first interface primary flag to $true
                }                                                                           # End if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary)
                $VMNicCount = $VMObject.NetworkProfile.NetworkInterfaces.count              # Gets the current number of interfaces
                #$VMNicCount = $VMNicCount -1                                                # Matches the count with interface IDs
                Add-AzVMNetworkInterface -VM $VMObject -NetworkInterface $NicObject  `
                    -ErrorAction 'Stop' | Out-Null                                          # Adds the additional interface
                $VMObject.NetworkProfile.NetworkInterfaces[$VMNicCount].Primary = $false
                Update-AzVM -VM $VMObject -ResourceGroupName $VMObject.ResourceGroupName `
                    -ErrorAction 'Stop'  | Out-Null
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The selected NIC has been added to the VM'                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureVMNic                                                             # Breaks :AddAzureVMNic    
        }                                                                                   # End :AddAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVMNic
function RemoveAzVMNic {                                                                    # Function to remove a NIC to an existing VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVMNic'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVMNic while ($true) {                                                   # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1) {                # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count is greater than 1
                $VMNicID = $VMObject.NetworkProfile.NetworkInterfaces.ID                    # Isloates the NIC IDs
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1)
            else {                                                                          # Else If$VMObject.NetworkProfile.NetworkInterfaces.ID.Count is 1 or less
                Write-Host 'Only one NIC exists on this VM'                                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to remove this'                              # Write message to screen
                Write-Host 'NIC unless another one is added first'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic                        
            }                                                                               # End else (if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1))
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$ObjectArray = @()                                # $ObjectArray creation
            foreach ($_ in $VMNicID) {                                                      # For each item in $VMNicID
                $CID = $_                                                                   # Assigns current item to $CID
                $CurrentNic = Get-AzNetworkInterface | Where-Object {$_.ID -eq $CID}        # Gets the current network interface
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'Name'=$CurrentNic.Name;                                                # Nic name
                    'IPCon'=$CurrentNic.IpConfigurations;                                   # Ip configuration
                    'NICID'=$CurrentNic.ID                                                  # Nic ID
                }                                                                           # End creating $ArrayInput
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
                $CurrentNic = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $VMNicID)
            :SelectAzureNIC while ($true) {
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    foreach ($IP in $_.IPCon) {                                             # For each item in .IPCon
                        Write-Host 'IP Config Name: '$IP.Name                               # Write message to screen
                        Write-Host 'Private Address:'$IP.PrivateIpAddress                   # Write message to screen
                        if ($IP.publicIPAddress) {                                          # If current item .PublicAddres has a value
                            $PubID = $IP.publicIPAddress.ID                                 # Isolates the public IP sku ID
                            $PubIP = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubID}                                          # Gets the public IP sku
                            Write-Host 'Public Address: '$PubIP.IpAddress                   # Write message to screen
                        }                                                                   # End if ($IP.PublicAddress)
                    }                                                                       # End foreach ($IP in $_.IPCon)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break RemoveAzureVMNic                                                  # Breaks :RemoveAzureVMNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $NicObject = Get-AzNetworkInterface | Where-Object `
                        {$_.ID -eq $OpSelect.NICID}                                         # Pulls the full $NicObject
                    Break SelectAzureNIC                                                    # Breaks :SelectAzureNIC
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNIC while ($true)
            :Confirm while ($true) {                                                        # Inner loop for confirming change
                Write-Host 'Remove the following'                                           # Write message to screen
                Write-Host 'Name:      '$NicObject.Name                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'From the following VM'                                          # Write message to screen
                Write-Host 'Name:      '$VMObject.Name                                      # Write message to screen
                Write-Host 'RG:        '$VMObject.ResourceGroupName                         # Write message to screen
                if ($VMObject.OS.WindowsConfiguration) {                                    # If $VMObject.OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:    Windows'                                        # Write message to screen
                }                                                                           # End if ($VMObject.OS.WindowsConfiguration)
                elseif ($VMObject.OS.LinuxConfiguration) {                                  # If $VMObject.OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:    Linux'                                          # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to make the change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break RemoveAzureVMNic                                                  # Breaks :RemoveAzureVMNic
                }                                                                           # End elseif ($OpConfirm -eq 'n') 
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen 
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Making the requested changes'                                   # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                $PrimaryNIC = $VMObject.NetworkProfile.NetworkInterfaces | `
                    Where-Object {$_.Primary -eq $true}                                     # Isolates the primary Nic object
                $PrimaryNIC = $PrimaryNIC.ID                                                # Isolates the primary Nic ID
                $PrimaryNIC = Get-AzNetworkInterface | Where-Object {$_.ID -eq $PrimaryNIC} # Pulls the full primary Nic Object
                if ($NicObject.Name -eq $PrimaryNIC.Name) {                                 # If $NicObject.Name equals $PrimaryNic.Name
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'This Nic is the primary nic,'                               # Write message to screen
                    Write-Host 'reassing primary to next available NIC'                     # Write message to screen
                    if ($PrimaryNIC.ID -eq `
                        $VMObject.NetworkProfile.NetworkInterfaces[0].ID) {                 # If $PrimaryNIC.ID equals $VMObject.NetworkProfile.NetworkInterfaces[0].ID
                        $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $false      # Sets the 0 position network interface primary setting to false
                        $VMObject.NetworkProfile.NetworkInterfaces[1].Primary = $true       # Sets the 1 position network interface primary setting to true
                    }                                                                       # End if ($PrimaryNIC.ID -eq $VMObject.NetworkProfile.NetworkInterfaces[0].ID)
                    else {                                                                  # Else if $PrimaryNIC.ID does not equal $VMObject.NetworkProfile.NetworkInterfaces[0].ID
                        $Number = 0                                                         # Sets $Number to '0'
                        foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces) {                                                             
                            $VMObject.NetworkProfile.NetworkInterfaces[$Number].Primary `
                                = $false                                                    # Sets all network interfaces primary to $false   
                            $Number = $Number + 1                                           # Increments $Number up by '1'
                        }                                                                   # End foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces)
                        $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $true       # Sets the 0 position network interface to primary
                    }                                                                       # End else (if ($PrimaryNIC.ID -eq $VMObject.NetworkProfile.NetworkInterfaces[0].ID))
                    Update-AzVM -VM $VMObject -ResourceGroupName `
                        $VMObject.ResourceGroupName -ErrorAction 'Stop' | Out-Null          # Updates the VM Nic primary configs                                      
                    Clear-Host
                }                                                                           # End if ($NicObject.Name -eq $PrimaryNIC.Name)
                Remove-AzVMNetworkInterface -VM $VMObject -NetworkInterfaceIDs `
                    $NicObject.ID -ErrorAction 'Stop' | Out-Null                            # Removes the network interface
                Update-AzVM -VM $VMObject -ResourceGroupName $VMObject.ResourceGroupName `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic    
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The selected NIC has been removed from the VM'                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureVMNic                                                          # Breaks :RemoveAzureVMNic    
        }                                                                                   # End :RemoveAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVMNic
# End ManageAzVM
# Functions for ManageAzVmss
function ManageAzVmss {                                                                     # Function to manage Vmss
    Begin {                                                                                 # Begin function
        :ManageAzureVmss while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Vmss'                                                       # Write message to screen
            Write-Host '[2] List Vmss'                                                      # Write message to screen
            Write-Host '[3] Remove Vmss'                                                    # Write message to screen
            Write-Host '[4] List Vmss Instances'                                            # Write message to screen
            Write-Host '[5] Start Vmss Instance'                                            # Write message to screen
            Write-Host '[6] Stop Vmss Instance'                                             # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for function selection
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureVmss                                                       # Breaks :ManageAzureVmss
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals 1
                Write-Host 'New Vmss'                                                       # Write message to screen
                NewAzVmss                                                                   # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Vmss'                                                      # Write message to screen
                ListAzVmss                                                                  # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Vmss'                                                    # Write message to screen
                RemoveAzVmss                                                                # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'List Vmss Instance'                                             # Write message to screen
                ListAzVmssVM                                                                # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Start Vmss Instance'                                            # Write message to screen
                StartAzVmss                                                                 # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Stop Vmss Instance'                                             # Write message to screen
                StopAzVmss                                                                  # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureVmss while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
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
# End ManageAzVmss
# Functions for ManageAzContainerGroup
function ManageAzContainerGroup {                                                           # Function to manage container groups
    Begin {                                                                                 # Begin function
        :ManageAzureContainerGroup while ($true) {                                          # Outer loop for managing function
            if ($ContainerObject) {                                                         # If $ContainerObject has a value
                Write-Host 'The currently selected container object is' `
                    $ContainerObject.name                                                   # Write message to screen
            }                                                                               # End if ($ContainerObject)
            Write-Host "Azure Container Group Management"                                   # Write message to screen
            Write-Host '0 Clear "$ContainerObject"'                                         # Write message to screen
            Write-Host '1 New container group'                                              # Write message to screen
            Write-Host '2 Get container group'                                              # Write message to screen
            Write-Host '3 Remove container group'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzContainerGroup = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzContainerGroup -eq 'exit') {                                       # If $ManageAzContainerGroup equals 'exit'
                Break ManageAzureContainerGroup                                             # Breaks :ManageAzureContainerGroupr
            }                                                                               # End if ($ManageAzContainerGroup -eq 'exit')
            elseif ($ManageAzContainerGroup -eq '0') {                                      # Elseif $ManageAzContainerGroup equals 0
                if ($ContainerObject) {                                                     # If $ContainerObject has a value
                    Write-Host 'Clearing "$ContainerObject'                                 # Write message to screen
                    $ContainerObject = $null                                                # Clears $ContainerObject
                }                                                                           # End if ($ContainerObject)
                else {                                                                      # If $ContainerObject does not have a value
                    Write-Host '$ContainerObject is already clear'                          # Write message to screen
                }                                                                           # End else (if ($ContainerObject))
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '0')
            elseif ($ManageAzContainerGroup -eq '1') {                                      # Elseif $ManageAzContainerGroup equals 1
                Write-Host 'New container group'                                            # Write message to screen
                $ContainerObject = NewAzContainerGroup ($RGObject)                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '1')
            elseif ($ManageAzContainerGroup -eq '2') {                                      # Elseif $ManageAzContainerGroup equals 2
                Write-Host 'Get container group'                                            # Write message to screen
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '2')
            elseif ($ManageAzContainerGroup -eq '3') {                                      # Elseif $ManageAzContainerGroup equals 3
                Write-Host 'Remove container group'                                         # Write message to screen
                RemoveAzContainerGroup ($ContainerObject)                                   # Calls function
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '3')
            else {                                                                          # If $ManageAzContainerGroup do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzContainerGroup -eq 'exit'))
        }                                                                                   # End :ManageAzureContainerGroup while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzContainerGroup
function NewAzContainerGroup {                                                              # Function to create a new container
    Begin {                                                                                 # Begin function
        :NewAzureContainerGroup while ($true) {                                             # Outer loop for managing functions
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzContainerGroup'                                    # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetContainerName while ($true) {                                               # Inner loop for setting the container name
                $ContainerNameObject = Read-Host 'Container name'                           # Operator input for the container name
                if ($ContainerNameObject -eq 'exit') {                                      # If $ContainerName equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerNameObject -eq 'exit')
                $ContainerNameObject = $ContainerNameObject.ToLower()
                Write-Host 'Use' $ContainerNameObject 'as the container name'               # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the container name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetContainerName                                                  # Breaks :SetContainerName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetContainerName while ($true)  
            :SetAzureContainerType while ($true) {                                          # Inner loop for setting the container type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the container type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureContainerType                                             # Breaks :SetAzureContainerType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)    
            :SetAzureContainerImage while ($true) {                                         # Inner loop for setting the container image
                Write-Host 'Enter the URL of the container image'                           # Write message to screen
                Write-Host 'Short names of images on the '                                  # Write message to screen
                Write-Host 'azure marketplace may also be used'                             # Write message to screen
                Write-Host 'Type "Exit" to leave this function'                             # Write message to screen
                $ContainerImage = Read-Host 'Image info'                                    # Operator input for the image info
                Write-Host $ContainerImage                                                  # Write message to screen
                $OperatorConfirm = Read-Host 'Please confirm the image info [Y] or [N]'     # Operator confirmation of the image info
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerImage                                            # Breaks :SetAzureContainerImagr
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Writes message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerImage while ($true)
            :SetAzureContainerDNS while ($true) {                                           # Inner loop to set the container DNS
                $ContainerDNS = Read-Host 'Please create a DNS entry'                       # Operator input for the container DNS
                if ($ContainerDNS -eq 'exit') {                                             # If $ContainerDNS equals exit
                    Break NewAzureContainerGroup                                            # Breaks :NewAzureContainerGroup
                }                                                                           # End if ($ContainerDNS -eq 'exit')
                Write-Host 'Use' $ContainerDNS 'as the container DNS'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the DNS
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureContainerDNS                                              # Breaks :SetAzureContainerDNS
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm not equal 'y'
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureContainerDNS while ($true)
            Try {                                                                           # Try the following
                $ContainerObject = New-AzContainerGroup -ResourceGroupName `
                    $RGObject.ResourceGroupName -Name $ContainerNameObject -Image `
                    $ContainerImage -OsType $ImageTypeObject -DnsNameLabel $ContainerDNS    # Creates the new container group and assigns to $ContainerObject
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The defult resource may not be available at this time'          # Write message to screen
                Write-Host 'You may not have the permissions complete this action'          # Write message to screen
                Break NewAzureContainerGroup                                                # Breaks :NewAzureContainerGroup
            }                                                                               # End catch
            Return $ContainerObject                                                         # Returns to calling function with $ContainerObject
        }                                                                                   # End :NewAzureContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzContainerGroup
function GetAzContainerGroup {                                                              # Function to get a container
    Begin {                                                                                 # Begin function
        :GetAzureContainerGroup while ($true) {                                             # Outer loop to manage function
            $ContainerList = Get-AzContainerGroup                                           # Gets a list of all containers
            if (!$ContainerList) {                                                          # If $ContainerList has no value
                Write-Host 'No container groups found'                                      # Write message to screen
                Write-Host 'Returning to previous function'                                 # Write message to screen
                Break GetAzureContainerGroup                                                # Breaks :GetAzureContainerGroup
            }                                                                               # End if (!$ContainerList)
            $ContainerListNumber = 1                                                        # List number used for container selection
            [System.Collections.ArrayList]$ContainerArray = @()                             # Creates the array used for selection
            foreach ($_ in $ContainerList) {                                                # For each item in $ContainerList
                $ArrayInput = [PSCustomObject]@{                                            # Creates the array input
                    'Number' = $ContainerListNumber; 'Name' = $_.Name; 'RG' = `
                        $_.ResourceGroupName                                                # Adds items to the array input
                }                                                                           # End $ArrayInput = [PSCustomObject]
                $ContainerArray.Add($ArrayInput) | Out-Null                                 # Adds the array input to array
                $ContainerListNumber = $ContainerListNumber + 1                             # Increments $ContainerListNumber by 1
            }                                                                               # End foreach ($_ in $ContainerList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ContainerArray) {                                               # For each item in $ContainerArray
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Container Name:'$_.name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ContainerArray)
            :SelectAzureContainer while ($true) {                                           # Inner loop for selecting the Container
                $ContainerSelect = Read-Host 'Container selection number'                   # Operator input for the Container selection
                if ($ContainerSelect -eq '0') {                                             # If $ContainerSelect equals 0
                    Break GetAzureContainerGroup                                            # Breaks :GetAzureContainer
                }                                                                           # End if ($ContainerSelect -eq '0')
                elseif ($ContainerSelect -in $ContainerArray.Number) {                      # If $ContainerSelect is in $ContainerArray.Number
                    $ContainerSelect = $ContainerArray | Where-Object `
                        {$_.Number -eq $ContainerSelect}                                    # $ContainerSelect is equal to the array item where $ContainerSelect equals the array number
                    $ContainerObject = Get-AzContainerGroup -ResourceGroupName `
                        $ContainerSelect.RG -Name $ContainerSelect.name                     # Pulls the full ContainerObject
                    if ($ContainerObject) {                                                 # If the Container object is pulled
                        Return $ContainerObject                                             # Return to calling function with $ContainerObject
                    }                                                                       # End if ($ContainerObject)
                    else {                                                                  # If the Container object not pulled
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureContainer                                             # Breaks :GetAzureContainer
                    }                                                                       # End else (if ($ContainerObject))
                }                                                                           # End elseif ($ContainerSelect -in $ContainerArray.Number)
                else {                                                                      # If $ContainerSelect is not 0 or in the array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($ContainerSelect -eq '0') )
            }                                                                               # End :SelectAzureContainer while ($true)
        }                                                                                   # End :GetAzureContainerGroup
    }                                                                                       # End Begin
}                                                                                           # End function GetAzContainerGroup
function RemoveAzContainerGroup {                                                           # Function to remove a container
    Begin{                                                                                  # Begin function
        :RemoveAzureContainerGroup while ($true) {                                          # Outer loop to manage function
            if (!$ContainerObject) {                                                        # If $ContainerObject is $null
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var 
                if (!$ContainerObject) {                                                    # If $ContainerObject is $null
                    Break RemoveAzureContainerGroup                                         # Breaks :RemoveAzureContainerGroup
                }                                                                           # End if (!$ContainerObject)
            }                                                                               # End if (!$ContainerObject)
            Write-Host 'Remove container ' $ContainerObject.name                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input to confirm removal
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Remove-AzContainerGroup -ResourceGroupName `
                    $ContainerObject.ResourceGroupName -Name $ContainerObject.Name          # Removes $ContainerObject 
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End if ($OperatorConfirm equals 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End else (if ($OperatorConfirm equals 'y'))
        }                                                                                   # End :RemoveAzContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzContainerGroup
# End ManageAzContainerGroup
# Functions for ManageAZAksCluster
function ManageAzAksCluster {                                                               # Function to manage Aks clusters
    Begin {                                                                                 # Begin function
        :ManageAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if ($AksObject) {                                                               # If $AksObject has a value
                Write-Host 'Current Aks cluster object is:'$AksObject.Name                  # Write message to screen
            }                                                                               # End if ($AksObject)
            Write-Host "Azure Kubernetes Service Cluster Management"                        # Write message to screen
            Write-Host '0 Clear "$AksObject"'                                               # Write message to screen
            Write-Host '1 New Aks cluster'                                                  # Write message to screen
            Write-Host '2 Get Aks cluster'                                                  # Write message to screen
            Write-Host '3 Remove Aks cluster'                                               # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzAksCluster = Read-Host "Option?"                                       # Collects operator input on $ManageAzAksCluster option
            if ($ManageAzAksCluster -eq 'exit') {                                           # If $ManageAzAksCluster equals 'exit'
                Break ManageAzureAksCluster                                                 # Breaks :ManageAzureAksCluster
            }                                                                               # End if ($ManageAzAksCluster -eq 'exit')
            elseif ($ManageAzAksCluster -eq '0') {                                          # Elseif $ManageAzAksCluster equals 0
                if ($AksObject) {                                                           # If $AksObject has a value
                    Write-Host 'Clearing "$AksObject'                                       # Write message to screen
                    $AksObject = $null                                                      # Clears $AksObject
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Write-Host '$AksObject is already clear'                                # Write message to screen
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End elseif ($ManageAzAksCluster -eq '0')
            elseif ($ManageAzAksCluster -eq '1') {                                          # Elseif $ManageAzAksCluster equals 1
                Write-Host 'New Aks cluster'                                                # Write message to screen
                $AksObject = NewAzAksCluster ($RGObject)                                    # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '1')
            elseif ($ManageAzAksCluster -eq '2') {                                          # Elseif $ManageAzAksCluster equals 2
                Write-Host 'Get Aks cluster'                                                # Write message to screen
                $AksObject = GetAzAksCluster                                                # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzAksCluster -eq '2')
            elseif ($ManageAzAksCluster -eq '3') {                                          # Elseif $ManageAzAksCluster equals 3
                Write-Host 'Remove Aks cluster'                                             # Write message to screen
                RemoveAzAksCluster ($AksObject)                                             # Calls function
            }                                                                               # End elseif ($ManageAzAksCluster -eq '3')
            else {                                                                          # If $ManageAzAksCluster do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzAksCluster -eq 'exit'))
        }                                                                                   # End :ManageAzureAksCluster while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzAksCluster
function NewAzAksCluster {                                                                  # Function to create a new Aks Cluster
    Begin {                                                                                 # Begin function
        :NewAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzAksCluster'                                        # Sets $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAksClusterName while ($true) {                                              # Inner loop for setting the AksCluster name
                $AksClusterNameObject = Read-Host 'Aks cluster name'                        # Operator input for the AksCluster name
                if ($AksClusterNameObject -eq 'exit') {                                     # If $AksClusterName equals exit
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksClusterNameObject -eq 'exit')
                Write-Host 'Use' $AksClusterNameObject 'as the Aks cluster name'            # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the AksCluster name
                if ($OperatorConfirm -eq 'y') {                                             # If OperatorConfirm equals 'y'
                    Break SetAksClusterName                                                 # Breaks :SetAksClusterName    
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAksClusterName while ($true)  
            :SetAzureAksClusterType while ($true) {                                         # Inner loop for setting the AksCluster type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the AksCluster type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($ImageType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    if ($ImageTypeObject -eq '1') {                                         # If $ImageTypeObject equals '1'
                        $ImageTypeObject = 'Windows'                                        # Sets $ImageTypeObject to 'Windows'
                    }                                                                       # End if ($ImageTypeObject -eq '1')
                    if ($ImageTypeObject -eq '2') {                                         # If $ImageTypeObject equals '2'
                    $ImageTypeObject = 'Linux'                                              # Sets $ImageTypeObject to 'Linux'
                    }                                                                       # End if ($ImageTypeObject -eq '2')
                    Break SetAzureAksClusterType                                            # Breaks :SetAzureAksClusterType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq 'exit') )
            }                                                                               # End :SetAzureAksType while ($true)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host "Enter the name of the tag"                       # Operator input for a tag name
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Writes tag to screen
                $OperatorConfirm = Read-Host "Use this tag for the Aks Cluster [Y] or [N]"  # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If statement for $Tag being correct
                    break SetAzureTag                                                       # Ends :SetAzureTag while loop
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Write-Host ''                                                           # Write message to screen  
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureAksNodeCount while ($true) {                                           # Loop for setting the node count
                Write-Host '[0] to exit'                                                    # Write message to screen
                [int]$AksNodeObject = Read-Host 'Enter the number of nodes'                 # Operator input for the node count
                if ($AksNodeObject -eq '0') {                                               # If $AksNodeObject equals 0
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAksCluster
                }                                                                           # End if ($AksNodeObject -eq '0')
                elseif (!$AksNodeObject) {                                                  # Else if $AksNodeObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen   
                }                                                                           # End elseif (!$AksNodeObject)
                elseif ($AksNodeObject -lt 0) {
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }
                else {                                                                      # If $AksNodeObject has value
                    $OperatorConfirm = Read-Host 'This Aks cluster will have' `
                    $AksNodeObject 'node(s)? [Y] or [N]'                                    # Operator confirmation of the node count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksNodeCount                                          # Breaks :SetAzureAksNodeCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If OperatorConfirm does not equal 'y'
                        Clear-Variable $AksNodeObject                                       # Clears $AksNodeObject
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (End if ($AksNodeObject -eq '0'))
            }                                                                               # End :SetAzureAksNodeCount while ($true)
            if ($ImageTypeObject -eq 'Linux') {                                             # If $ImageTypeObject equals 'linux'
                Try {
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'             # Creates the Aks cluster for linux
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End if ($ImageTypeObject -eq 'Linux')
            else {                                                                          # If $ImageTypeObject does not equal linux  
                :SetAzureAksUserName while ($true) {                                        # Inner loop for setting the Aks username
                    $AksUserNameObject = Read-Host "Aks username"                           # Operator input of the Aks user name
                    if ($AksUserNameObject -eq 'exit') {                                    # If $AksUsernameObject is $null
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksUserNameObject -eq 'exit')
                    Write-Host $AksUserNameObject                                           # Writes message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks username? [Y] or [N]"      # Operator confirmation of the Aksuser name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureAksUserName                                           # Breaks :SetAzureAksUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksUserName while ($true)
                :SetAzureAksPassword while ($true) {                                        # Inner loop for setting the password
                    $AksPasswordObject = Read-Host "Aks password"                           # Operator input for the password
                    if ($AksPasswordObject -eq 'exit') {                                    # If $AksPasswordObject equals 'exit'
                        Break NewAzureAksCluster                                            # Breaks :NewAzureAks Cluster
                    }                                                                       # End if ($AksPasswordObject -eq 'exit')
                    Write-Host $AksPasswordObject                                           # Write message to screen
                    $OperatorConfirm = Read-Host "Use as the Aks password? [Y] or [N]"      # Operator confirmation of the password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        $AksPasswordObject = ConvertTo-SecureString $AksPasswordObject `
                            -AsPlainText -Force                                             # Hashes $AksPasswordObject
                        Break SetAzureAksPassword                                           # Breaks :SetAzureAksPassword
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End :SetAzureAksPassword while ($true)
                Try {                                                                       # Try the following
                    $AksObject = New-AzAksCluster -ResourceGroupName `
                        $RGObject.ResourceGroupName -Name $AksClusterNameObject `
                        -WindowsProfileAdminUserName $AksUserNameObject `
                        -WindowsProfileAdminUserPassword $AksPasswordObject `
                        -NetworkPlugin azure -NodeVmSetType VirtualMachineScaleSets `
                        -Tag $Tag -NodeCount $AksNodeObject -ErrorAction 'Stop'              # Creates the Aks cluster
                    $AksNodeName = 'Nnamet'
                    New-AzAksNodePool -ResourceGroupName $RGObject.ResourceGroupName `
                        -ClusterName $AksClusterNameObject -Name $AksNodeName -OsType `
                        Windows -VmSetType VirtualMachineScaleSets                          # Adds additional windows parameters 
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                }                                                                           # End catch
                if ($AksObject) {                                                           # If $AksObject has a value
                    Return $AksObject                                                       # Returns $AksObject to calling function 
                }                                                                           # End if ($AksObject)
                else {                                                                      # If $AksObject does not have a value
                    Break NewAzureAksCluster                                                # Breaks :NewAzureAks Cluster
                }                                                                           # End else (if ($AksObject))
            }                                                                               # End else (if ($ImageTypeObject -eq 'Linux'))
        }                                                                                   # End :NewAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzAksCluster
function GetAzAksCluster {                                                                  # Function to get an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :GetAzureAksCluster while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Getting a list of all Aks Clusters'                                 # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            $ObjectListNumber = 1                                                           # $var used as list number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the array that all objects will be loaded into
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $ObjectList = Get-AzAksCluster -ResourceGroupName $_.ResourceGroupName      # Gets a list of any AKS clusters
                if ($ObjectList) {                                                          # If $ObjectList has a value
                    $RGName = $_.ResourceGroupName                                          # $RGName is set to the current resource group name
                    foreach ($_ in $ObjectList) {                                           # For each item in $ObjectList
                        $ArrayInput = [PSCustomObject]@{'Name' = $_.Name; 'Number' = `
                            $ObjectListNumber; 'NRG' = $_.NodeResourceGroup; 'RG' =$RGName} # Creates $var to load items into array                
                        $ObjectArray.Add($ArrayInput) | Out-Null                            # Adds items to the array
                        $ObjectListNumber = $ObjectListNumber + 1                           # Increments $ObjectListNumber up by 1
                    }                                                                       # End foreach ($_ in $ObjectList)                                                 
                }                                                                           # End if ($ObjectList)
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $Object array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Aks Name:  '$_.Name                                             # Write message to screen
                Write-Host 'NodeRG:    '$_.NRG                                              # Write message to screen
                Write-Host 'Object RG: '$_.RG                                               # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureAksCluster while ($true) {                                          # Inner loop to select the Aks cluster
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host "You are selecting the Aks cluster for"$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the number of the Aks Cluster'           # Operator input for the Aks cluster
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureAksCluster                                                # Breaks :GetAzureAksCluster
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ObjectArray.Number) {                          # Else if $OperatorSelect equals $ObjectArray.Number
                    $AksObject = $ObjectArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $AksObject is equal to $ObjectArray where $OperatorSelect equals $ObjectArray.Number
                    Return $AksObject                                                       # Returns to calling function with $AksObject
                }                                                                           # End elseif ($OperatorSelect -eq $ObjectArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureAksCluster while ($true)
        }                                                                                   # End :GetAzureAksCluster while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAksCluster
function RemoveAzAksCluster {                                                               # Function to remove an Aks cluster
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Turns of warning messages
        :RemoveAzureAksCluster while ($true) {                                              # Outer loop for managing function
            if (!$AksObject) {                                                              # If $AksObject is $null
                $CallingFunction = 'RemoveAzAksCluster'                                     # Creates $Calling function $var
                $AksObject = GetAzAksCluster ($CallingFunction)                             # Calls function and assigns output to $var
                if (!$AksObject) {                                                          # If $AksObject is $null
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End if (!$AksObject)
            }                                                                               # End if (!$AksObject)
            Write-Host 'Remove Aks Cluster named:'$AksObject.Name'in RG:'$AksObject.RG       # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Aks cluster
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzAksCluster -ResourceGroupName $AksObject.RG `
                        -Name $AksObject.Name -Force -ErrorAction 'Stop'                    # Removes the Object
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to this resource'          # Write message to screen
                    Break RemoveAzureAksCluster                                             # Breaks :RemoveAzureAksCluster
                }                                                                           # End Catch
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Break RemoveAzureAksCluster                                                 # Breaks :RemoveAzureAksCluster
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureAksCluster while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzAksCluster
# End ManageAZAksCluster
# Functions for ManageAzDisk
function ManageAzDisk {                                                                     # Function for managing azure disks
    Begin {                                                                                 # Begin function
        :ManageAzureDisk while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Manage Disks'                                                       # Write message to screen
            Write-Host '[0] Exit this function'                                             # Write message to screen
            Write-Host '[1] New Disk'                                                       # Write message to screen
            Write-Host '[2] List All Disks'                                                 # Write message to screen
            Write-Host '[3] Remove Disk'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option'                                                  # Operator input for selecting function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureDisk                                                       # Breaks :ManageAzureDisk
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Disk'                                                       # Write message to screen
                NewAzDisk                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List All Disks'                                                 # Write message to screen
                ListAzDisk                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Disk'                                                    # Write message to screen
                RemoveAzDisk                                                                # Calls function RemoveAzDisk
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzDisk
function NewAzDisk {                                                                        # Function for creating a new disk
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzDisk'                                                  # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureDisk while ($true) {                                                       # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End if (!$RGObject) 
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk    
            }                                                                               # End if (!$LocationObject)
            :SetAzureDiskName while ($true) {                                               # Inner loop for setting the disk name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage Disk name must be atleast 3 characters'                 # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $DiskNameArray = $null                                                      # Clears $DiskNameArray
                $DiskNameInput = Read-Host 'Disk name'                                      # Operator input for the Disk name
                $DiskNameInput = $DiskNameInput.ToLower()                                   # Recreates $DiskNameInput in lower
                $DiskNameArray = $DiskNameInput.ToCharArray()                               # Creates $DiskNameInput
                foreach ($_ in $DiskNameArray) {                                            # For each item in $DiskNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Disk name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $DiskNameInput = $null                                              # Clears $DiskNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $DiskNameArray)
                if (!$DiskNameInput) {                                                      # If $DiskNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($DiskNameInput -eq '0')
                else {                                                                      # If $DiskNameInput not equal to '0'
                    Write-Host $DiskNameInput 'is correct'                                  # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of Disk name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureDisk                                                  # Breaks NewAzureDisk
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureDiskName                                              # Breaks :SetAzureDiskName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$DiskNameInput))
            }                                                                               # End :SetAzureDiskName while ($true)
            :SetAzureDiskSku while ($true) {                                                # Inner loop for configuring the new disk sku
                Write-Host 'Available disk skus'                                            # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Standard_LRS'                                               # Write message to screen
                Write-Host '[2] Premium_LRS'                                                # Write message to screen
                Write-Host '[3] StandardSSD_LRS'                                            # Write message to screen
                Write-Host '[4] UltraSSD_LRS'                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the sku
                Clear-Host                                                                  # Clear host
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureDisk                                                      # Breaks NewAzureDisk
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SkuObject = 'Standard_LRS'                                             # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $SkuObject = 'Premium_LRS'                                              # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $SkuObject = 'StandardSSD_LRS'                                          # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $SkuObject = 'UltraSSD_LRS'                                             # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($SkuObject) {                                                           # If $SkuObject has a value
                    Break SetAzureDiskSku                                                   # Breaks :SetAzureDiskSku
                }                                                                           # End if ($SkuObject)
            }                                                                               # End :SetAzureDiskSku while ($true)
            :SetAzureDiskSize while ($true) {                                               # Inner loop for configuring the new disk size
                $DiskSizeObject = -1                                                        # Sets $var to non-break value
                Try{                                                                        # Try the following
                    Write-Host 'Enter the requested size of the disk in GB'                 # Write message to screen
                    Write-Host 'Enter "0" to exit this function'                            # Write message to screen
                    [int]$DiskSizeObject = Read-Host 'Disk size'                            # Operator input for the disk size
                    Clear-Host                                                              # Clears screen
                }                                                                           # End Try
                catch {                                                                     # End catch
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # If Try fails
                if ($DiskSizeObject -eq 0) {                                                # If $DiskSizeObject equals '0'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($DiskSizeObject -eq 0)
                if ($DiskSizeObject -ge 1) {                                                # If $DiskSizeObject has a value greater than 1
                    Break SetAzureDiskSize                                                  # Breaks :SetAzureDiskSize
                }                                                                           # End if ($DiskSizeObject)
                else {                                                                      # All other inputs for $DiskSizeNumber
                    Write-Host 'Please enter a positive number'                             # Write message to screen
                }                                                                           # End else (if ($DiskSizeObject -ge 1))
            }                                                                               # End :SetAzureDiskSize while ($true)
            :SetAzureDiskOSType while ($true) {                                             # Inner loop for setting the disk OS
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Windows'                                                    # Write message to screen
                Write-Host '[2] Linux'                                                      # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the disk os
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($OpSelect -eq '0') 
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $DiskOSObject = 'Windows'                                               # Sets $DiskOSObject to 'Windows'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $DiskOSObject = 'Linux'                                                 # Sets $DiskOSObject to 'Linux'
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($DiskOSObject) {                                                        # If $DiskOSObject has a value
                    Break SetAzureDiskOSType                                                # Breaks :SetAzureDiskOSType
                }                                                                           # End if ($DiskOSObject)
            }                                                                               # End :SetAzureDiskOSType while ($true)
            :EnableAzureDiskEncrypt while ($true) {                                         # Inner loop for configuring the new disk encyption
                Write-Host 'Encrypt this disk'                                              # Write message to screen
                $UseEncryptOption = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input for adding disk encyption
                Clear-Host                                                                  # Clears screen
                if ($UseEncryptOption -eq 'e') {                                            # If $UseEncyptOption equals 'e'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($UseEncryptOption -eq 'e')
                elseif ($UseEncryptOption -eq 'n') {                                        # If $UseEncyptOption equals 'n'
                    Break EnableAzureDiskEncrypt                                            # Breaks :EnableAzureDiskEncrypt 
                }                                                                           # End elseif ($UseEncryptOption -eq 'n')
                elseif ($UseEncryptOption -eq 'y') {                                        # If $UseEncyptOption equals 'y'
                    $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$KeyVaultKeyObject) {                                              # If $KeyVaultKeyObject has no value
                        Write-Host 'No key selected'                                        # Write messsage to screen
                        Write-Host 'Continue building disk without encryption?'             # Write messsage to screen
                        $OpSelect = Read-Host '[Y] Yes [N]'                                 # Operator input to continue without encryption
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            $UseEncryptOption = 'n'                                         # Sets $UseEncryptOption to 'n'
                            Break EnableAzureDiskEncrypt                                    # Breaks :EnableAzureDiskEncrypt 
                        }                                                                   # End if ($OpSelect -eq 'y')
                        else {                                                              # All other inputs for $OpSelect
                            Break NewAzureDisk                                              # Breaks :NewAzureDisk
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End if (!$KeyVaultKeyObject)
                    $KeyVaultObject2 = $KeyVaultObject                                      # Moves vault object holding $KeyVaultObject to $KeyVaultObject2
                    $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$KeyVaultSecretObject) {                                           # If $KeyVaultSecretObject has no value
                        Write-Host 'No secret selected'                                     # Write messsage to screen
                        Write-Host 'Continue building disk without encryption?'             # Write messsage to screen
                        $OpSelect = Read-Host '[Y] Yes [N]'                                 # Operator input to continue without encryption
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            $UseEncryptOption = 'n'                                         # Sets $UseEncryptOption to 'n'
                            Break EnableAzureDiskEncrypt                                    # Breaks :EnableAzureDiskEncrypt 
                        }                                                                   # End if ($OpSelect -eq 'y')
                        else {                                                              # All other inputs for $OpSelect
                            Break NewAzureDisk                                              # Breaks :NewAzureDisk
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End if (!$KeyVaultSecretObject)
                    if ($KeyVaultObject.ResourceID -ne $KeyVaultObject2.ResourceID) {       # If $KeyVaultObject.ResourceID not equal KeyVaultObject2.ResourceID
                        :EncryptError while ($true) {                                       # Inner loop for dealing with 2 vaults
                            Write-Host 'The key and secret used to encypt'                  # Write message to screen
                            Write-Host 'this drive must reside in the same vault'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host '[1] Select new key and secret'                      # Write message to screen
                            Write-Host '[2] Continue without encyption'                     # Write message to screen
                            $OpSelect = Read-Host 'Option [#]'                              # Operator input for selecting next action
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq '0') {                                        # If $OpSelect equals '0'
                                Break NewAzureDisk                                          # Breaks :NewAzureDisk
                            }                                                               # End if ($OpSelect -eq '0')
                            elseif ($OpSelect -eq '1') {                                    # Else if $OpSelect equals '1'
                                Break EncryptError                                          # Breaks :EncryptError  
                            }                                                               # End elseif ($OpSelect -eq '1')
                            elseif ($OpSelect -eq '2') {                                    # Else if $OpSelect equals '2'
                                $UseEncryptOption = 'n'                                     # Sets $UseEncryptOption to 'n'
                                Break EnableAzureDiskEncrypt                                # Breaks :EnableAzureDiskEncrypt 
                            }                                                               # End elseif ($OpSelect -eq '2')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq '0'))
                        }                                                                   # End :EncryptError while ($true)
                    }                                                                       # End if ($KeyVaultObject -ne $KeyVaultObject2)
                    else {
                        Break EnableAzureDiskEncrypt                                        # Breaks :EnableAzureDiskEncrypt
                    }
                }                                                                           # End elseif ($UseEncryptOption -eq 'y')
                else {                                                                      # All other options for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($UseEncryptOption -eq 'e'))
            }                                                                               # End :EnableAzureDiskEncrypt while ($true)
            Write-Host 'Building disk'                                                      # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if ($UseEncryptOption -eq 'y') {                                                # If $UseEncyptOption equals 'y'
                Try {                                                                       # Try the following
                    $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName `
                        -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType `
                        $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $true  # Starts the disk configuration
                    $KeyVaultSecretUrl = $KeyVaultSecretObject.ID                           # Assigns secret URL
                    $KeyVaultKeyUrl = $KeyVaultKeyObject.ID                                 # Assigns key URL 
                    $KeyVaultID = $KeyVaultObject.ResourceID                                # Assigns key vault ID 
                    $DiskConfig = Set-AzDiskDiskEncryptionKey -Disk $DiskConfig -SecretUrl `
                        $KeyVaultSecretUrl -SourceVaultId $KeyVaultID -ErrorAction 'Stop'   # Sets the disk encyption secret
                    $DiskConfig = Set-AzDiskKeyEncryptionKey -Disk $DiskConfig -KeyUrl `
                        $KeyVaultKeyUrl -SourceVaultId $KeyVaultID -ErrorAction 'Stop'      # Sets the disk encyption key
                    New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName `
                        $DiskNameInput -Disk $DiskConfig -ErrorAction 'Stop'                # Creates the disk
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the correct'                               # Write message to screen
                    Write-Host 'permissions to do this action'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End catch
                Write-Host 'The disk has been created'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') {                                            # If $UseEncyptOption equals 'n'
                Try {                                                                       # Try the following
                    $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName `
                        -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType `
                        $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled `
                        $false -ErrorAction 'Stop'                                          # Sets the disk settings
                    New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName `
                        $DiskNameInput -Disk $DiskConfig -ErrorAction 'Stop'                # Creates the disk
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the correct'                               # Write message to screen
                    Write-Host 'permissions to do this action'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End catch
                Write-Host 'The disk has been created'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End elseif ($UseEncryptOption -eq 'n')
        }                                                                                   # End :NewAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzDisk
function ListAzDisk {                                                                       # Function to list all disk objects
    Begin {                                                                                 # Begin function
        :ListAzureDisk while ($true) {                                                      # Outer loop for managing function
            $DiskList = Get-AzDisk                                                          # Gets a list of all disks
            foreach ($_ in $DiskList) {                                                     # For each item in $DiskList
                Write-Host 'Disk Name: ' $_.Name                                            # Write message to screen
                Write-Host 'RG:        ' $_.ResourceGroupName                               # Write message to screen
                Write-Host 'OS:        ' $_.OsType                                          # Write message to screen
                Write-Host 'Size (GB): ' $_.DiskSizeGB                                      # Write message to screen
                Write-Host 'State:     ' $_.DiskState                                       # Write message to screen
                Write-Host 'Location:  ' $_.Location                                        # Write message to screen
                Write-Host 'Created:   ' $_.TimeCreated                                     # Write message to screen
                Write-Host 'Net Access:' $_.NetworkAccessPolicy                             # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $DiskList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureDisk                                                             # Breaks :ListAzureDisk
        }                                                                                   # End :ListAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzDisk
function GetAzDisk {                                                                        # Function to get a disk object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzDisk'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureDisk while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzDisk                                                        # Gets a list of all disks
            $ObjectNumber = 1                                                               # $Var for setting $ObjectList.Number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber;`
                'Name'=$_.Name;'RG'=$_.ResourceGroupName;'OS'=$_.OsType;`
                'Size'=$_.DiskSizeGB;'State'=$_.DiskState;'Loc'=$_.Location;`
                'TC'=$_.TimeCreated;'Sku'=$_.Sku.Name}                                      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureDisk while ($true) {                                                # Inner loop for selecting object from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number]       "$_.Name                                # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) 
                    Write-Host 'Location: '$_.loc                                           # Write message to screen
                    Write-Host 'Sku Name: '$_.Sku                                           # Write message to screen
                    Write-Host 'RG:       '$_.RG                                            # Write message to screen
                    Write-Host 'OS:       '$_.Os                                            # Write message to screen
                    Write-Host 'State:    '$_.State                                         # Write message to screen
                    Write-Host 'Created:  '$_.TC                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk') {               # If $CallingFunction has a value and not equal to 'GetAzDisk'
                    Write-Host 'You are selecting the disk for:'$CallingFunction            # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the disk
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                   Break GetAzureDisk                                                       # Breaks :GetAzureDisk
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $DiskObject = Get-AzDisk -ResourceGroupName $OpSelect.RG `
                        -DiskName $OpSelect.Name                                            # Gets full disk object
                    Return $DiskObject                                                      # Returns $DiskObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                   Write-Host 'That was not a valid input'                                  # Write message to screen
                   Pause                                                                    # Pauses all actions for operator input
                   Clear-Host                                                               # Clears host
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureDisk while ($true)
        }                                                                                   # End :GetAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzDisk
function RemoveAzDisk {                                                                     # Function to remove a disk object
    Begin {                                                                                 # Begin function
        :RemoveAzureDisk while ($true) {                                                    # Outer loop for managing function
            $DiskObject = GetAzDisk                                                         # Calls function and assigns output to $var
            if (!$DiskObject) {                                                             # If $DiskObject is $null
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if (!$DiskObject)
            Write-Host 'Remove disk:        '$DiskObject.Name                               # Write message to screen
            Write-Host 'from resource group:'$DiskObject.ResourceGroupName                  # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete the disk
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Clear-Host                                                                  # Clears screen
                Write-Host 'Deleting:'$DiskObject.Name                                      # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzDisk -ResourceGroupName $DiskObject.ResourceGroupName `
                        -DiskName $DiskObject.Name -Force -ErrorAction 'Stop'               # Removes selected disk
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The disk may still be in use'                               # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions to remove this disk'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureDisk                                                   # Breaks :RemoveAzureDisk
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The selected disk has been deleted'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function RemoveAzDisk
# End ManageAzDisk
# Additional required functions specific to ManageAzCompute
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Windows'                                                # Write message to screen
                    Write-Host '[2] Linux'                                                  # Write message to screen
                    $ImageTypeObject = Read-Host 'Option [#]'                               # Operator input for the image type
                    Clear-Host                                                              # Clears screen
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
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            Write-Host '[0] Exit'                                           # Write message to screen
                            foreach ($_ in $ImagePublisherArray) {                          # For each item in $ImagePublisherArray
                                $Number = $_.Number
                                Write-Host "[$Number]" $_.Name                              # Write message to screen
                            }                                                               # End foreach ($_ in $ImagePublisherArray)
                            Write-Host ''                                                   # Write message to screen
                            if ($CallingFunction) {                                         # If $CallingFunction has a value
                                Write-Host `
                                    'You are selecting the publisher for:'$CallingFunction  # Write message to screen
                            }                                                               # End if ($CallingFunction)
                            $OpSelect = Read-Host 'Option [#]'                              # Operator selection of the publisher
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq '0') {                                        # If $OpDelect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($OpSelect -eq '0')
                            if ($OpSelect -in $ImagePublisherArray.Number) {                # If $OpSelect in $ImagePublisherArray.Number 
                                $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                    {$_.Number -eq $OpSelect}                               # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $OpSelect
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End if ($OpSelect -in $ImagePublisherArray.Number)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
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
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {                                             # Inner loop for setting the image offer
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
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ImageOfferArray) {                                      # For each $_ in $ImageOfferArray
                        $Number = $_.Number                                                 # Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]  " $_.Name                                # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ImageOfferArray)
                    Write-Host ''                                                           # Write message to screen
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host `
                            'You are selecting the image offer for:'$CallingFunction        # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the offer selection
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OpSelect -eq '0')
                    if ($OpSelect -in $ImageOfferArray.Number) {                            # If $OpSelect in $ImageOfferArray.Number
                        $VMOfferObject = $ImageOfferArray | Where-Object `
                            {$_.Number -eq $OpSelect}                                       # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OpSelect
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($OpSelect -in $ImageOfferArray.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -in $ImageOfferArray.Number)))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               # Inner loop for selecting the image sku
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
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ImageSkuArray) {                                        # For each $_ in $ImageSkuArray
                        $Number = $_.Number                                                 # Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]  " $_.Name                                # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ImageOfferArray)
                    Write-Host ''                                                           # Write message to screen
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host `
                            'You are selecting the image sku for:'$CallingFunction          # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the offer selection
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OpSelect -eq '0')
                    if ($OpSelect -in $ImageSkuArray.Number) {                              # If $OpSelect in $imageSkuArray.Number
                        $VMSkuObject = $ImageSkuArray | Where-Object `
                            {$_.Number -eq $OpSelect}                                       # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $OpSelect
                        $VMSkuObject = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                            -Location $LocationObject.DisplayName -PublisherName `
                        $VMPublisherObject | Where-Object {$_.Skus -eq $VMSkuObject.Name}   # Gets the Sku object                                      
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($OpSelect -in $ImageSkuArray.Number) 
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -in $ImageSkuArray.Number) )
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                $ImageVersionList =  Get-AzVMImage -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject -Offer $VMOfferObject.Offer `
                    -Skus $VMSkuObject.Skus                                                 # Gets image version list and assigns to $var
                $ImageVersionNumber = 1                                                     # Sets $ImageVersionNumber to 1
                [System.Collections.ArrayList]$ImageVersionArray = @()                      # Creates the $ImageSkuArray     
                foreach ($_ in $ImageVersionList) {                                         # For each Sku in $ImageSkuList
                    $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                        'Number' = $ImageVersionNumber}                                     # Creates the item to loaded into array
                    $ImageVersionArray.Add($ImageVersionInput) | Out-Null                   # Loads item into array, out-null removes write to screen
                    $ImageVersionNumber = $ImageVersionNumber + 1                           # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                :SelectAzureImageVersion while ($true) {                                    # Inner loop for selecting the image sku version
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ImageVersionArray) {                                    # For each $_ in $ImageSkuArray
                        $Number = $_.Number                                                 # Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]  " $_.Name                                # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ImageVersionArray)
                    Write-Host ''                                                           # Write message to screen    
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host `
                            'You are selecting the image version for:'$CallingFunction      # Write message to screen
                    }                                                                       # End if ($CallingFunction)    
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for selecting the image version
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OpSelect -eq '0')                                           
                    if ($OpSelect -in $ImageVersionArray.Number) {                          # If $OpSelect is in $ImageVersionArray.Number
                        $VMVersionObject = $ImageVersionArray | `
                            Where-Object {$_.Number -eq $OpSelect}                          # $VMSkuObject equals $ImageVersionArray where $ImageVersionArray.Number equals $OpSelect
                        $VMImageObject = Get-AzVMImage -Location $LocationObject.Location `
                            -PublisherName $VMPublisherObject -Offer $VMOfferObject.Offer `
                            -Skus $VMSkuObject.Skus -Version $VMVersionObject.Name          # Pulls the full object and assign to $var
                        Return $VMImageObject                                               # Returns #VMImageObject
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImageVersion while ($true)
            }                                                                               # End :GetAzureImageVersion while ($true)
        }                                                                                   # End :GetAZVMImage while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMOS
function GetAzVMSize {                                                                      # Function for setting the VM size
    Begin {                                                                                 # Begin function
        :GetAzureVMSize while ($true) {                                                     # Outer loop for managing function
            if (!$HVGen) {                                                                  # IF $HVGen is $null
                :SetHyperVGen while ($true) {                                               # Inner loop for setting the hyper v generation
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Gen 1'                                                  # Write message to screen
                    Write-Host '[2] Gen 2'                                                  # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select the generation
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Else if $OpSelect equals '1'
                        $HVGen = '*V1*'                                                     # Sets $HVGen
                        Break SetHyperVGen                                                  # Breaks :SetHyperVGen
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect equals '2'
                        $HVGen = '*V2*'                                                     # Sets $HVGen
                        Break SetHyperVGen                                                  # Breaks :SetHyperVGen
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SetHyperVGen while ($true)
            }                                                                               # End if (!$HVGen)
            $NotAvailable = Get-AzComputeResourceSku -Location $LocationObject.Location `
                | Where-Object {$_.Restrictions.Reasoncode  -eq `
                'NotAvailableForSubscription'}                                              # Gets a list of all unavailble compute objects
            $GenSupported  = Get-AzComputeResourceSku -Location $LocationObject.Location `
                | Where-Object {$_.Capabilities[4].Value -like $HVGen}                      # Gets a list of all VMs with the supported gen value
            $VMSizeList = Get-AzVMSize -Location $LocationObject.Location `
                | Where-Object {$_.Name -notin $NotAvailable.Name}                          # Gets a list of all available VM sizes in location
            $VMSizeList = $VMSizeList | Where-Object {$_.Name -in $GenSupported.Name}
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $OpSelectList)
                :SelectAzureVMCoreCount while ($true) {                                     # Inner loop for selecting the vm core count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidCore) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number] "$_.Count'  Cores'                    # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number] "$_.Count' Cores'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number] "$_.Count'Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number]"$_.Count'  Cores'                     # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number]"$_.Count' Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number]"$_.Count'Cores'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the core count for:'$CallingFunction  # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidCore.Number) {                              # If $CoreCoint in $ValidCore.Number list
                        $OpSelect = $ValidCore | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect is equal to $ValidCore where $ValidCore.Number equals $OpSelect
                        $OpSelect = $OpSelect.Count                                         # CoreCount is equal to $OpSelect.Count
                        Write-Host 'Confirm:'$OpSelect' cores'                              # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation of core count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OperatorConfrim equals 'y'
                            $CoreCount = $OpSelect                                          # CoreCount is equal to $OpSelect
                            Break SetAzureVMCoreCount                                       # Breaks :SetAzureVMCoreCount
                        }                                                                   # End if ($OperatorConfirm -eq 'y') 
                    }                                                                       # End elseif ($OpSelect -in $ValidCore.Number)
                    else {                                                                  # All other values
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMCoreCount while ($true)
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                :SelectAzureVMRamCount while ($true) {                                      # Inner loop for selecting the ram count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidRam) {                                             # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .Count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number] "$_.Count'     MB'                    # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number] "$_.Count'    MB'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number] "$_.Count'   MB'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number] "$_.Count'  MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number] "$_.Count' MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number] "$_.Count'MB'                         # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number]"$_.Count'    MB'                      # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number]"$_.Count'   MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number]"$_.Count'  MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number]"$_.Count'MB'                          # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the RAM count for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidRam.Number) {                               # If $OpSelect is in $ValidRam.Number list
                        $OpSelect = $ValidRam | Where-Object {$_.Number -eq $OpSelect}      # $OpSelect equals $ValidRam where $ValidRam.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' MB of Ram'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $RamCount = $OpSelect                                           # $RamCount is equal to $OpSelect
                            Break SetAzureVMRamCount                                        # Breaks :SetAzureRamCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidRam.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMRamCount while ($true)
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                :SelectAzureVMDiskCount while ($true) {                                     # Inner loop for selecting the max disk count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidDisk) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] "$_.Count' Max disks'                     # Write message to screen
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            Write-Host "[$Number]"$_.Count' Max disks'                      # Write message to screen
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the max disks for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidDisk.Number) {                              # If $OpSelect is in $ValidDisk.Number list
                        $OpSelect = $ValidDisk | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect equals $ValidDisk where $ValidDisk.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' Max disks'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $DiskCount = $OpSelect                                          # $DiskCount is equal to $OpSelect
                            Break SetAzureVMDiskCount                                       # Breaks :SetAzureVMDiskCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidDisk.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMDiskCount while ($true)
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                :SelectAzureVMName while ($true) {                                          # Inner loop for selecting the VM size
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ValidVMSize) {                                          # For each item in $ValidVMSize
                        $Number = $_.Number                                                 # $Number is equal to current item .number
                        $OSDiskSize = $_.OSDiskSize                                         # $OSDiskSize is equal to current item .OSDiskSize
                        $RSDiskSize = $_.RSDiskSize                                         # $RSDiskSize is equal to current item .RSDiskSize
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]"  $_.Name                                 # Write message to screen    
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else if ($Number -le 9)
                        if ($OSDiskSize -le 99999) {                                        # if $OSDiskSize is 99999 or less
                            Write-Host 'OS disk size: '$_.OSDiskSize'   MB'                 # Write message to screen
                        }                                                                   # End if ($OSDiskSize -le 99999)
                        elseif ($OSDiskSize -ge 100000 -and $OSDiskSize -le 999999) {       # Else if $OSDiskSize is between 100000 and 999999
                            Write-Host 'OS disk size: '$_.OSDiskSize'  MB'                  # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 100000 -and $OSDiskSize -le 999999)
                        elseif ($OSDiskSize -ge 1000000 -and $OSDiskSize -le 9999999) {     # Else if $OSDiskSize is between 1000000 and 9999999
                            Write-Host 'OS disk size: '$_.OSDiskSize' MB'                   # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 1000000 -and $OSDiskSize -le 9999999)
                        elseif ($OSDiskSize -ge 10000000 -and $OSDiskSize -le 99999999) {   # Else if $OSDiskSize is between 10000000 and 99999999
                            Write-Host 'OS disk size: '$_.OSDiskSize'MB'                    # Write message to screen
                        }                                                                   # End elseif ($OSDiskSize -ge 10000000 -and $OSDiskSize -le 99999999)
                        if ($RSDiskSize -le 99999) {                                        # if $RSDiskSize is 99999 or less
                            Write-Host 'Res disk size:'$_.RSDiskSize'   MB'                 # Write message to screen
                        }                                                                   # End if ($RSDiskSize -le 99999)
                        elseif ($RSDiskSize -ge 100000 -and $RSDiskSize -le 999999) {       # Else if $RSDiskSize is between 100000 and 999999
                            Write-Host 'Res disk size:'$_.RSDiskSize'  MB'                  # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 100000 -and $RSDiskSize -le 999999)
                        elseif ($RSDiskSize -ge 1000000 -and $RSDiskSize -le 9999999) {     # Else if $RSDiskSize is between 1000000 and 9999999
                            Write-Host 'Res disk size:'$_.RSDiskSize' MB'                   # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 1000000 -and $RSDiskSize -le 9999999)
                        elseif ($RSDiskSize -ge 10000000 -and $RSDiskSize -le 99999999) {   # Else if $RSDiskSize is between 10000000 and 99999999
                            Write-Host 'Res disk size:'$_.RSDiskSize'MB'                    # Write message to screen
                        }                                                                   # End elseif ($RSDiskSize -ge 10000000 -and $RSDiskSize -le 99999999)
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ValidVMSize)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the VM size for:'$CallingFunction     # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidVMSize.Number) {                            # If $OpSelect is in $ValidVMSize.Number
                        $OpSelect = $ValidVMSize | Where-Object {$_.Number -eq $OpSelect}   # $OpSelect is equal to $ValidVMSize where $ValidVMSize.Number equals $OpSelect
                        $VMSizeObject = Get-AzVMSize -Location `
                            $LocationObject.location | Where-Object `
                            {$_.Name -eq $OpSelect.Name}                                    # $VMSizeObject is pulled using $OpSelect.Name
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($VMSizeCount -eq '0'))
                }                                                                           # End :SelectAzureVMName while ($true)
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVMSize
# Additional required functions from other ManageAz sections