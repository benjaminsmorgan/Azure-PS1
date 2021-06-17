# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Remove-AzVirtualNetwork:                    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetwork?view=azps-5.4.0
    Add-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Remove-AzVirtualNetworkSubnetConfig:        https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    New-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Remove-AzNetworkInterface:                  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-5.6.0
    Add-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworkinterfaceipconfig?view=azps-6.0.0
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Remove-AzNetworkInterfaceIPConfig:          https://docs.microsoft.com/en-us/powershell/module/az.network/Remove-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.0.0 
    New-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Set-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/set-azpublicipaddress?view=azps-5.5.0
    Remove-AzPublicIpAddress:                   https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azpublicipaddress?view=azps-5.5.0 
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    ManageAzVirtualNetwork:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/ManageAzVirtualNetwork.ps1       
        NewAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/NewAzVirtualNetwork.ps1
        ListAzVirtualNetwork:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/ListAzVirtualNetwork.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
        RemoveAzVirtualNetwork:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/RemoveAzVirtualNetwork.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    ManageAzVNetSubnetConfig:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/ManageAzVNetSubnetConfig.ps1
        AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        RemoveAzVNetSubnetConfig:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/RemoveAzVNetSubnetConfig.ps1
        GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    ManageAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ManageAzNetworkInterface.ps1
        NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
        ListAzNetworkInterface:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ListAzNetworkInterface.ps1
        GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
        RemoveAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNetworkInterface.ps1  
        ManageAzNICIpConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ManageAzNICIpConfig.ps1
            AddAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/AddAzNICIpConfig.ps1
            ListAzNICIpConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ListAzNICIpConfig.ps1
            GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
            RemoveAzNICIpConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNICIpConfig.ps1
            SetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICIpConfig.ps1
            SetAzNICPriIPConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICPriIPConfig.ps1
            SetAzNICIpConfigPublicIP:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICIpConfigPublicIP.ps1
            RemoveAzNICIpConPublicIP:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNICIpConPublicIP.ps1
            GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
            GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
        GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    ManageAzPublicIPAddress:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/ManageAzPublicIpAddress.ps1
        NewAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1    
        ListAzPublicIPAddress:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/ListAzPublicIpAddress.ps1
        GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
        SetAzPublicIPAddressAllo:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/SetAzPublicIPAddressAllo.ps1
        RemoveAzPublicIPAddress:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/RemoveAzPublicIpAddress.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzLoadBalancer:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/ManageAzLoadBalancer.ps1
        NewAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLoadBalancer.ps1
        ListAzLoadBalancer:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/ListAzLoadBalancer.ps1
        GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
        RemoveAzLoadBalancer:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/RemoveAzLoadBalancer.ps1
        NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
        NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
        GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
        NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
        NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
        NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
        NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzNetwork:            Management function for azure networking
    ManageAzVirtualNetwork:     Management function for azure virtual networks
        NewAzVirtualNetwork:        Creates a new azure virtual network
        ListAzVirtualNetwork:       Lists all existing azure virtual networks
        GetAzVirtualNetwork:        Gets an existing azure virtual network
        RemoveAzVirtualNetwork:     Removes an azure virtual network
        GetAzResourceGroup:         Gets a resource group object
        GetAzLocation:              Gets an Azure location
    ManageAzVNetSubnetConfig:   Management function for subnets    
        AddAzVNetSubnetConfig:      Adds an azure virtual network subnet
        GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
        RemoveAzVNetSubnetConfig:   Removes an azure virtual network subnet
    ManageAzNetworkInterface:   Management function for network interfaces
        NewAzNetworkInterface:      Creates new network interfaces
        ListAzNetworkInterface:     Lists network interfaces
        GetAzNetworkInterface:      Gets an existing network interface
        RemoveAzNetworkInterface:   Removes a network interface   
        ManageAzNICIpConfig:        Management function for network interfaces ip configs
            AddAzNICIpConfig:           Creates a NIC IP configuration
            ListAzNICIpConfig:          Lists all NIC IP configurations
            GetAzNICIpConfig:           Gets a NIC IP configuration
            RemoveAzNICIpConfig:        Removes a network interface config
            SetAzNICIpConfig:           Updates a NIC IP configuration
            SetAzNICPriIPConfig:        Updates a NIC IP primary configuration
            SetAzNICIpConfigPublicIP:   Adds a public IP sku to a network interface config
            RemoveAzNICIpConPublicIP:   Removes a public IP sku to a network interface config
            GetAzPublicIpAddress:       Gets a public IP address sku  
            GetAzNetworkInterface:      Gets an existing network interface
        GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
        GetAzResourceGroup:         Gets a resource group
        GetAzLocation:              Gets an azure location
    ManageAzPublicIPAddress:    Function for managing public IP address Skus
        NewAzPublicIpAddress:       Creates a new public IP address    
        ListAzPublicIPAddress:      Lists all existing public IP addresses
        GetAzPublicIPAddress:       Gets an existing public IP address
        SetAzPublicIPAddressAllo:   Chages an existing public IP address allocation method
        RemoveAzPublicIPAddress:    Removes an existing public IP address
        GetAzResourceGroup:         Gets a resource group
    ManageAzLoadBalancer:       Function for managing load balancers
        NewAzLoadBalancer:          Creates a new load balancer    
        ListAzLoadBalancer:         Lists all existing load balancers
        GetAzLoadBalancer:          Gets an existing load balancer
        RemoveAzLoadBalancer:       Removes an existing load balancer
        NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
        NewAzPublicIpAddress:       Creates a new public IP addres
        GetAzPublicIpAddress:       Gets an existing IP address
        NewAzLBBackendIpConfig:     Creates a load balancer back end configuration
        NewAzLBProbeConfig:         Creates a load balancer probe configuration
        NewAzLBIBNatPoolConfig:     Creates inbound pool configuration for load balancer
        NewAzLBRuleConfig:          Creates a new load balancer rule
    GetAzResourceGroup:         Gets a resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :ManageAzureNetwork         Outer loop for managing function
    $OpSelect:                  Operator input to select management function
    ManageAzVirtualNetwork{}    Gets $VnetObject
        NewAzVirtualNetwork{}       Creates $VNetObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
        ListAzVirtualNetwork{}      Lists Vnets
        RemoveAzVirtualNetwork{}    Removes $VnetObject
            GetAzVirtualNetwork{}       Gets $VNetObject
    ManageAzVNetSubnetConfig{}      Gets $SubnetObject
        AddAzVNetSubnetConfig{}     Creates $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
        RemoveAzVNetSubnetConfig{}  Removes $SubnetObject
            GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
    ManageAzNetworkInterface{}  Get $NicObject
        NewAzNetworkInterface{}     Creates $NicObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
            GetAzVNetSubnetConfig{}     Gets $SubnetObject
        ListAzNetworkInterface{}    Lists $NicObjects
        RemoveAzNetworkInterface{}  Removes $NicObject
            GetAzNetworkInterface{}     Get $NicObject
        ManageAzNICIpConfig{}       Manages $NicIPConfigObject
            AddAzNICIpConfig{}          Adds $NicIPConfigObject
                GetAzNetworkInterface{}     Gets $NicObject,$SubnetObject,$VnetObject
            ListAzNICIpConfig{}         Lists $NicIPConfigObject
            RemoveAzNICIpConfig{}       Removes $NicIPConfigObject
                GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
            SetAzNICIpConfig{}          Updates $NicIPConfigObject
                GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
            SetAzNICPriIPConfig{}       Updates $NicIPConfigObject
                GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
            SetAzNICIpConfigPublicIP{}  Updates $NicIPConfigObject
                GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
                GetAzPublicIpAddress{}      Gets $PublicIPObject
            RemoveAzNICIpConPublicIP{}  Removes $NicIPConfigObject
                GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
    ManageAzPublicIPAddress{}   Gets $PublicIPObject
        NewAzPublicIPAddress{}      Creates $PublicIPObject
            GetAzResourceGroup{}        Gets $RGObject
        ListAzPublicIPAddress{}     Lists $PublicIPObject
        SetAzPublicIPAddressAllo{}  Changes $PublicIPObject
            GetAzPublicIPAddress{}      Gets $PublicIPObject
        RemoveAzPublicIPAddress{}   Removes $PublicIPObject
            GetAzPublicIPAddress{}      Gets $PublicIPObject      
    ManageAzLoadBalancer{}      Gets $LoadBalancerObject
        NewAzLoadBalancer{}         Creates $LoadBalancerObject
            NewAzLBFrontendIpConfig{}   Gets $FrontEndIPConfigObject
            NewAzPublicIpAddress{}      Creates $PublicIPObject
                GetAzResourceGroup{}        Gets $RGObject
            GetAzPublicIpAddress{}      Gets $PublicIPObject
            NewAzLBBackendIpConfig{}    Gets $BackEndIPConfigObject
            NewAzLBProbeConfig{}        Gets $HealthProbeObject
            NewAzLBIBNatPoolConfig{}    Gets $InboundNatPoolObject
            NewAzLBRuleConfig{}         Gets $LoadBalanceRule 
        ListAzLoadBalancer{}        Lists $LoadBalancerObject
        GetAzLoadBalancer{}         Gets $LoadBalancerObject
        RemoveAzLoadBalancer{}      Removes $LoadBalancerObject
            GetAzLoadBalancer{}         Gets $LoadBalancerObject        
} #>
<# Process Flow {
    Function
        Call ManageAzNetwork > Get $null
            Call ManageAzVirtualNetwork > Get $null
                Call NewAzVirtualNetwork > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGoup
                        Return NewAzVirtualNetwork > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzVirtualNetwork > Send $LocationObject
                End NewAzVirtualNetwork
                    Return Function > Send $null
                Call ListAzVirtualNetwork > Get $null 
                End ListAzVirtualNetwork
                    Return ManageAzVirtualNetwork > Send $null
                Call RemoveAzVirtualNetwork > Get $null
                    Call GetAzVirtualNetwork > Get $VNetObject
                    End GetAzVirtualNetwork
                        Return RemoveAzVirtualNetwork > Send $VNetObject
                End RemoveAzVirtualNetwork
                    Return ManageAzVirtualNetwork > Send $null
            End ManageAzVirtualNetwork
                Return ManageAzNetwork > Send $null        
            Call ManageAzVnetSubnetConfig > Get $null
                Call AddAzVNetSubnetConfig > Get $null
                    Call GetAzVirtualNetwork > Get $VNetObject
                    End GetAzVirtualNetwork
                        Return AddAzVNetSubnetConfig > Send $VNetObject
                End AddAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $null
                Call ListAzVNetSubnetConfig > Get $null
                End ListAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $null
                Call RemoveAzVNetSubnetConfig > Get $null
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                    End GetAzVNetSubnetConfig
                        Return RemoveAzVNetSubnetConfig > Send $SubnetObject
                End RemoveAzVNetSubnetConfig
                    Return ManageAzVnetSubnetConfig > Send $null
            End ManageAzVnetSubnetConfig
                Return ManageAzNetwork > Send $null
            Call ManageAzNetworkInterface > Get $null        
                Call NewAzNetworkInterface > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzNetworkInterface > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzNetworkInterface > Send $LocationObject
                    Call GetAzVNetSubnetConfig > Get $SubnetObject, $VNetObject
                    End GetAzVNetSubnetConfig
                        Return NewAzNetworkInterface > Send $SubnetObject, $VNetObject
                End NewAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $null
                Call ListAzNetworkInterface > Get $null
                End ListAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $null
                Call RemoveAzNetworkInterface > Get $null
                    Call GetAzNetworkInterface > Get $NicObject,$SubnetObject,$VnetObject
                    End GetAzNetworkInterface
                        Return RemoveAzNetworkInterface > Send $NicObject,$SubnetObject,$VnetObject
                End RemoveAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $null            
                Call ManageAzNICIpConfig > Get $null
                    Call AddAzNICIpConfig > Get $null
                        Call GetAzNetworkInterface > Get $NicObject,$SubnetObject,$VnetObject
                        End GetAzNetworkInterface
                            Return AddAzNICIpConfig > Send $NicObject,$SubnetObject,$VnetObject
                    End AddAzNICIpConfig
                        Return ManageAzNICIpConfig > Send $null
                    Call ListAzNICIpConfig > Get $null
                    End ListAzNICIpConfig
                        Return ManageAzNICIpConfig > Send $null
                    Call RemoveAzNICIpConfig > Get $null
                        Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                        End GetAzNICIpConfig
                            Return RemoveAzNICIpConfig > Send $NicIPConfigObject, $NicObject
                    End RemoveAzNICIpConfig
                        Return ManageAzNICIpConfig > Send $null
                    Call SetAzNICIpConfig > Get $null
                        Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
                        End GetAzNICIpConfig
                            Return SetAzNICIpConfig > Send $NicIPConfigObject,$NicObject
                    End SetAzNICIpConfig
                        Return ManageAzNICIpConfig > Send $null
                    Call SetAzNICPriIPConfig > Get $null
                        Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
                        End GetAzNICIpConfig
                            Return SetAzNICPriIPConfig > Send $NicIPConfigObject,$NicObject
                    End SetAzNICPriIPConfig
                        Return ManageAzNICIpConfig > Send $null
                    Call SetAzNICIpConfigPublicIP > Get $null
                        Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                        End GetAzNICIpConfig
                            Return SetAzNICIpConfigPublicIP > Send $NicIPConfigObject, $NicObject
                        Call GetAzPublicIpAddress > Get $PublicIPObject
                        End GetAzPublicIpAddress
                            Return SetAzNICIpConfigPublicIP > Send $PublicIPObject
                    End SetAzNICIpConfigPublicIP
                        Return ManageAzNICIpConfig > Send $null
                    Call RemoveAzNICIpConPublicIP > Get $null
                        Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                        End GetAzNICIpConfig
                            Return RemoveAzNICIpConPublicIP > Send $NicIPConfigObject, $NicObject
                    End RemoveAzNICIpConPublicIP
                        Return ManageAzNICIpConfig > Send $null
                End ManageAzNICIpConfig
                    Return ManageAzNetworkInterface > Send $null
            End ManageAzNetworkInterface
                Return ManageAzNetwork > Send $null
            Call ManageAzPublicIPAddress > Get $null
                Call NewAzPublicIpAddress > Get $null
                    Call GetAzResourceGroup > Get RGObject
                    End GetAzResourceGroup
                        Return NewAzPublicIpAddress > Send RGObject
                End NewAzPublicIpAddress
                    Return ManageAzPublicIPAddress > Send $null
                Call ListAzPublicIpAddress > Get $null
                End ListAzPublicIpAddress
                    Return ManageAzPublicIPAddress > Send $null
                Call SetAzPublicIPAddressAllo > Get $null
                    Call GetAzPublicIpAddress > Get $PublicIPObject
                    End GetAzPublicIpAddress
                        Return SetAzPublicIPAddressAllo > Send $PublicIPObject
                End SetAzPublicIPAddressAllo
                    Return ManageAzPublicIPAddress > Send $null    
                Call RemoveAzPublicIPAddres > Get $null
                    Call GetAzPublicIpAddress > Get $PublicIPObject
                    End GetAzPublicIpAddress
                        Return RemoveAzPublicIPAddress > Send $PublicIPObject
                End RemoveAzPublicIPAddress
                    Return ManageAzPublicIPAddress > Send $null
            End ManageAzPublicIPAddress
                Return ManageAzNetwork > Send $null            
            Call ManageAzLoadBalancer > Get $null
                Call NewAzLoadBalancer > Get $null
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzLoadBalancer > Send $RGObject          
                    Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
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
                    Return ManageAzLoadBalancer > Send $null
                Call ListAzLoadBalancer > Get $null
                End ListAzLoadBalancer
                    Return ManageAzLoadBalancer > Send $null
                Call RemoveAzPublicIPAddres > Get $null
                    Call GetAzLoadBalancer > Get $LoadBalancerObject
                    End GetAzLoadBalancer
                        Return RemoveAzLoadBalancer > Send $LoadBalancerObject
                End RemoveAzLoadBalancer
                    Return ManageAzLoadBalancer > Send $null
            End ManageAzLoadBalancer
                Return ManageAzNetwork > Send $null                
        End ManageAzNetwork
            Return function > Send $Null
}#>
function ManageAzNetwork {                                                                  # Function for managing azure network resources
    Begin {                                                                                 # Begin function   
        :ManageAzureNetwork while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Azure Network Management'                                           # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Manage virtual network'                                         # Write message to screen
            Write-Host '[2] Manage subnets'                                                 # Write message to screen
            Write-Host '[3] Manage network interfaces'                                      # Write message to screen
            Write-Host '[4] Manage public IPs'                                              # Write message to screen
            Write-Host '[5] Manage load balancers'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNetwork                                                    # Breaks :ManageAzureNetwork
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals '1'
                Write-Host 'Manage virtual network'                                         # Write message to screen
                ManageAzVirtualNetwork                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'Manage subnets'                                                 # Write message to screen
                ManageAzVNetSubnetConfig                                                    # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'Manage network interfaces'                                      # Write message to screen
                ManageAzNetworkInterface                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Manage public IPs'                                              # Write message to screen
                ManageAzPublicIPAddress                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Manage load balancers'                                          # Write message to screen
                ManageAzLoadBalancer                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureNetwork while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetwork
# Functions for ManageAzVirtualNetwork
function ManageAzVirtualNetwork {                                                           # Function for managing azure virtual networks
    Begin {                                                                                 # Begin function
        :ManageAzureVirtualNetwork while($true) {                                           # Outer loop for managing function
            Write-Host 'Azure Virtual Network Management'                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New virtual network'                                            # Write message to screen
            Write-Host '[2] List virtual networks'                                          # Write message to screen
            Write-Host '[3] Remove virtual network'                                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the management option
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If OpSelect equals '0'
                Break ManageAzureVirtualNetwork                                             # End Break ManageAzureVirtualNetwork
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New virtual network'                                            # Write message to screen
                NewAzVirtualNetwork                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List virtual networks'                                          # Write message to screen
                ListAzVirtualNetwork                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove virtual network'                                         # Write message to screen
                RemoveAzVirtualNetwork                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureVirtualNetwork while($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetwork
function NewAzVirtualNetwork {                                                              # Function to create a new Vnet
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzVirtualNetwork'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureVNet while ($true) {                                                       # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureVNet                                                          # Breaks :NewAzureVnet
            }                                                                               # End if (!$RGObject)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureVNet                                                          # Breaks :NewAzureVnet
            }                                                                               # End if (!$LocationObject)
            :SetAzureVNetName while ($true) {                                               # Inner loop for setting the vnet name
                $VNetName = Read-Host 'Virtual network name'                                # Operator input for the vnet name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VNetName' as the VNet name'                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVNetName                                                  # Breaks :SetAzureVNetName
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureVNetName while ($true)
            :SetAzureVnetAddress while ($true) {                                            # Inner loop for setting the vnet prefix
                $AddressPrefix = Read-Host 'Address Prefix (E.X. 10.0.0.0/16)'              # Operator input for the Vnet prefix
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$AddressPrefix' as the Vnet address prefix'                # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVnetAddress                                               # Breaks :SetAzureVnetAddress
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureVnetAddress while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the virtual network'                                   # Write message to screen
                Write-Host 'This may take a momement'                                       # Write message to screen
                New-AzVirtualNetwork -Name $VNetName -ResourceGroupName `
                $RGObject.ResourceGroupName -Location $LocationObject.location `
                -AddressPrefix $AddressPrefix -ErrorAction 'Stop'                           # Creats the new Vnet
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The address prefix may not be valid'                            # Write message to screen
                Write-Host 'or the address prefix may already be in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group may have a read only lock'                   # Write message to screen
                Write-Host 'or you may not have the permissions to do this'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVNet                                                          # Breaks :NewAzureVNet
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The virtual network has been created'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVNet                                                              # Breaks :NewAzureVNet
        }                                                                                   # End :NewAzureVNet while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVirtualNetwork
function ListAzVirtualNetwork {                                                             # Function to list all virtual networks
    Begin {                                                                                 # Begin function
        :ListAzureVNetwork while ($true) {                                                  # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks in this subscription'                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVNetwork                                                     # Breaks ListAzureVNetwork
            }                                                                               # End if (!$VNetList)
            foreach ($_ in $VNetList) {                                                     # For each item in $VNetList
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.ResourceGroupName                                  # Write message to screen
                Write-Host 'Loc:     '$_.Location                                           # Write message to screen
                Write-Host 'A Space: '$_.AddressSpace.AddressPrefixes                       # Write message to screen
            }                                                                               # End foreach ($_ in $VNetList)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVNetwork                                                         # Breaks ListAzureVNetwork
        }                                                                                   # End :ListAzureVNetwork while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVirtualNetwork
function GetAzVirtualNetwork {                                                              # Function for getting an Azure virtual network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzVirtualNetwork                                              # pulls all items into list for selection
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVnet                                                          # Breaks :GetAzureVnet
            }                                                                               # End if (!$ObjectList)
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' = $_.ResourceGroupName; 'Location' = $_.Location; 'ASpace' = `
                    $_.AddressSpace.AddressPrefixes}                                        # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            :SelectAzureVNet while ($true) {                                                # Inner loop for selecting the Vnet
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Loc:     '$_.Location                                       # Write message to screen
                    Write-Host 'A Space: '$_.ASpace                                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $Array)    
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'Selecting the VNet for:'$CallingFunction                    # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the VNet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureVNet                                                      # Breaks :GetAzureVNet
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full object and assigns to $var
                        Return $VNetObject                                                  # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVNet while ($true)
        }                                                                                   # End :GetAzureVnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork
function RemoveAzVirtualNetwork {                                                           # Function to remove an Azure virtual network
    Begin {                                                                                 # Being function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVirtualNetwork'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVnet while ($true) {                                                    # Outer loop for managing function
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $var
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if (!$VNetObject)
            $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject      # Creates a list of subnets on the $VNetObject
            foreach ($_ in $SubnetList) {                                                   # For each item in $SubnetList
                $Subnet = $_.ID                                                             # $Subnet equals $currentitem.ID
                $NicList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.Subnet.ID -eq $Subnet}                             # Gets a list of NIC in $Subnet if present
                if ($NicList) {                                                             # If $NicList has a value
                    Write-Host 'Please remove all network interfaces'                       # Write message to screen
                    Write-Host 'from this virtual network before deletion'                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVnet                                                   # Breaks RemoveAzureVnet
                }                                                                           # End if ($NicList)
            }                                                                               # End foreach ($_ in $SubnetList)
            Write-Host 'Remove VNet:   '$VNetObject.Name                                    # Write message to screen
            Write-Host 'resource group:'$VNetObject.ResourceGroupName                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the selected VNet
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing:'$VNetObject.name                                  # Write message to screen
                    Remove-AzVirtualNetwork -Name $VNetObject.Name -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Force -ErrorAction 'Stop'            # Removes the virtual network
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen 
                    Write-Host 'required permissions'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'This resource or containing'                                # Write message to screen
                    Write-Host 'resource group maybe locked'                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End catch
                Write-Host 'The selected virtual network has been removed'                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureVnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVirtualNetwork
# End ManageAzVirtualNetwork
# Functions for ManageAzVNetSubnetConfig
function ManageAzVNetSubnetConfig {                                                         # Function for managing azure Subnet resources
    Begin {                                                                                 # Begin function   
        :ManageAzureSubnet while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Azure Subnet Management'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add subnet'                                                     # Write message to screen
            Write-Host '[2] List subnets'                                                   # Write message to screen
            Write-Host '[3] Remove subnet'                                                  # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSubnet                                                     # Breaks :ManageAzureSubnet
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Add subnet'                                                     # Write message to screen
                AddAzVNetSubnetConfig                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals 2
                Write-Host 'List subnets'                                                   # Write message to screen
                ListAzVNetSubnetConfig                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals 3
                Write-Host 'Remove subnet'                                                  # Write message to screen
                RemoveAzVNetSubnetConfig                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureSubnet while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNetSubnetConfig
function AddAzVNetSubnetConfig {                                                            # Function to create a subnet
    begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVNetSubnetConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $Var
            if (!$VNetObject) {                                                             # if $VNetObject is $null
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                Write-Host 'Enter the subnet name'                                          # Write message to screen
                $SubnetName = Read-Host 'Name'                                              # Operator input for the subnet name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$SubnetName' as the subnet name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                Write-Host 'Enter the address prefix (E.X. 10.0.1.0/24)'                    # Write message to screen
                $AddressPrefix = Read-Host 'Prefix'                                         # Operator input for the subnet prefix
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$AddressPrefix' as the subnet address prefix'              # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            try {                                                                           # Try the following
                Write-Host 'Creating the subnet'                                            # Write message to screen
                Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork `
                $VNetObject -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork `
                -ErrorAction 'Stop'                                                         # Creates the new subnet config and adds to $VNetObject
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The address prefix may not be valid'                            # Write message to screen
                Write-Host 'or the address prefix may already be in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group may have a read only lock'                   # Write message to screen
                Write-Host 'or you may not have the permissions to do this'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The subnet has been created'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureSubnet                                                            # Breaks :AddAzureSubnet
        }                                                                                   # End :AddAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig
function ListAzVNetSubnetConfig {                                                           # Function to list all subnets
    Begin{                                                                                  # Begin function
        :ListAzureSubnet while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $ObjectList = Get-AzVirtualNetwork                                              # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureSubnet                                                       # Breaks :ListAzureSubnet 
            }                                                                               # End if (!$ObjectList)
            Write-Host 'Gathering subnets, this may take a moment'                          # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each object in $ObjectList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                if (!$SubnetList) {                                                         # If $SubnetList is $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No Subnets present in:'$VNet                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if (!$SubnetList)
                foreach ($_ in $SubnetList) {                                               # For each $_ in $SubnetList
                    $ListInput = [PSCustomObject]@{
                        'Name'=$_.Name;'Vnet'=$VNet;'PFX'=$_.AddressPrefix;`
                        'VnetPFX'=$VnetPFX;'RG'=$VNetRG}                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $SubnetList)                                        
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No subnets present in this subscription'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureSubnet                                                       # Breaks :ListAzureSubnet 
            }                                                                               # End if (!$ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Sub Name:   '$_.name                                            # Write message to screen
                Write-Host 'Sub Prefix: '$_.PFX                                             # Write message to screen
                Write-Host 'VNet Name:  '$_.Vnet                                            # Write message to screen
                Write-Host 'VNet Prefix:'$_.VnetPFX                                         # Write message to screen
                Write-Host 'VNet RG:    '$_.RG                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)  
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureSubnet                                                           # Breaks :ListAzureSubnet 
        }                                                                                   # End :ListAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVNetSubnetConfig
function GetAzVNetSubnetConfig {                                                            # Function to get a subnet
    Begin{                                                                                  # Begin function
        :GetAzureSubnet while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $ObjectList = Get-AzVirtualNetwork                                              # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            Write-Host 'Gathering subnets, this may take a moment'                          # Write message to screen
            $ObjectNumber = 1                                                               # List number used for subnet selection
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each object in $ObjectList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each $_ in $SubnetList
                    $ListInput = [PSCustomObject]@{
                        'Number'=$ObjectNumber;'Name'=$_.Name;'Vnet'=$VNet;'PFX'= `
                        $_.AddressPrefix;'VnetPFX'=$VnetPFX;'RG'=$VNetRG}                   # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $SubnetList)                                        
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureSubNet while ($true) {                                              # Inner loop for selecting the subnet
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Creates $number from $_.Number
                    Write-Host "[$Number]"   $_.name                                        # Write message to screen
                    Write-Host 'Sub Prefix: '$_.PFX                                         # Write message to screen
                    Write-Host 'VNet Name:  '$_.Vnet                                        # Write message to screen
                    Write-Host 'VNet Prefix:'$_.VnetPFX                                     # Write message to screen
                    Write-Host 'VNet RG:    '$_.RG                                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)    
                if ($CallingFunction) {                                                     # If $Calling function exists
                    Write-Host 'You are selecting the subnet for:'$CallingFunction          # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the subnet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureSubnet                                                    # Breaks :GetAzureSubnet   
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $Subnet select is equal to object in $ObjectArray
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.Vnet `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the $VnetObject
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Name                                    # Pulls the $SubnetObject
                    Return $SubnetObject, $VNetObject                                       # Returns to calling function with $SubnetObject and $VNetObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureSubNet while ($true)
        }                                                                                   # End :GetAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVNetSubnetConfig
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Call function and assign output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            Write-Host 'Remove the subnet'$SubnetObject.Name                                # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for removing the subnet
            if ($OpConfirm -eq 'y') {                                                 # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Write-Host 'The subnet has been removed'                                    # Write message to screen
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # If $OpConfirm does not equal 'y'
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig
# End ManageAzVNetSubnetConfig
# Functions for ManageAzNetworkInterface
function ManageAzNetworkInterface {                                                         # Function for managing azure nic resources
    Begin {                                                                                 # Begin function   
        :ManageAzureNic while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Azure Nic Management'                                               # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nic'                                                        # Write message to screen
            Write-Host '[2] List Nics'                                                      # Write message to screen
            Write-Host '[3] Remove Nic'                                                     # Write message to screen
            Write-Host '[4] Manage NIC IP config'                                           # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNic                                                        # Breaks :ManageAzureNic
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Add Nic'                                                        # Write message to screen
                NewAzNetworkInterface                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals 3
                Write-Host 'List Nics'                                                      # Write message to screen
                ListAzNetworkInterface                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals 3
                Write-Host 'Remove Nic'                                                     # Write message to screen
                RemoveAzNetworkInterface                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals 4
                Write-Host 'Manage NIC IP config'                                           # Write message to screen
                ManageAzNICIpConfig                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetworkInterface
function NewAzNetworkInterface {                                                            # Creates a new network interface
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNetworkInterface'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNIC while ($true) {                                                        # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End if (!$RGObject)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End if (!$LocationObject)
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)           # Calls function and assigns output to $var
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                Break NewAzureNIC                                                           # Breaks NewAzureNIC
            }                                                                               # End if (!$SubnetObject)
            :SetAzureNicName while ($true) {                                                # Inner loop for setting the nic name
                Write-Host 'Provide a name for the new NIC'                                 # Write message to screen
                $NicName = Read-Host 'NIC name'                                             # Operator input for the nic name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$NicName' as the NIC name'                                 # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                    Break SetAzureNicName                                                   # Breaks :SetAzureNicName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureNicName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating NIC'                                                   # Write message to screen
                New-AzNetworkInterface -Name $NicName -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $LocationObject.location `
                    -Subnet $SubnetObject  -ErrorAction 'Stop'                              # Creates the object
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write mesage to screen
                Write-Host ''                                                               # Write mesage to screen
                Write-Host 'You may not have permissions to create this object'             # Write mesage to screen
                Write-Host ''                                                               # Write mesage to screen
                Write-Host 'The resource group maybe locked'                                # Write mesage to screen
                Write-Host ''                                                               # Write mesage to screen
                Write-Host 'The name provided may not be valid'                             # Write mesage to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'NIC has been created'                                               # Write mesage to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNic                                                               # Breaks :NewAzureNic
        }                                                                                   # End :NewAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzNetworkInterface
function ListAzNetworkInterface {                                                           # Function to get a network interface
    Begin {                                                                                 # Begin function
        :ListAzureNIC while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtuals networks present in this subscription'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNIC                                                          # Breaks :ListAzureNIC
            }                                                                               # End if (!$VNetList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                Write-Host 'Gathering subnets in:'$VNet                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    Write-Host 'Gathering NICs in:   '$SubnetName                           # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    if (!$NicList) {                                                        # If $NicList is $null
                        Write-Host 'No NICs present'                                        # Write message to screen
                    }                                                                       # End if (!$NicList)
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ObjectInput = [PSCustomObject]@{
                            'NicName'=$_.Name;'NicRG'=$_.ResourceGroupName;`
                            'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;'VNetName'=$VNet;`
                            'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;'VM'=$_.VirtualMachine.ID;`
                            'IPCon'=$_.IpConfigurations
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    }                                                                       # End foreach ($_ in $NicList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $SubnetList)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VnetList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtuals network interfaces present in this subscription'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNIC                                                          # Breaks :ListAzureNIC
            }                                                                               # End if (!$ObjectArray) 
            Write-Host                                                                      # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'NIC Name:       '$_.NicName                                     # Write message to screen
                foreach ($IP in $_.IPCon) {                                                 # For each item in .IPCon
                    Write-Host 'IP Config Name: '$IP.Name                                   # Write message to screen
                    Write-Host 'Private Address:'$IP.PrivateIpAddress                       # Write message to screen
                    if ($IP.publicIPAddress) {                                              # If current item .PublicAddres has a value
                        $PubID = $IP.publicIPAddress.ID                                     # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public Address: '$PubIP.IpAddress                       # Write message to screen
                    }                                                                       # End if ($IP.PublicAddress)
                }                                                                           # End foreach ($IP in $_.IPCon)
                Write-Host 'NIC RG:         '$_.NicRG                                       # Write message to screen
                Write-Host 'Subnet Name:    '$_.Subname                                     # Write message to screen
                Write-Host 'Subnet Prefix:  '$_.SubPFX                                      # Write message to screen
                Write-Host 'VNet Name:      '$_.VnetName                                    # Write message to screen
                Write-Host 'VNet Prefix:    '$_.VnetPFX                                     # Write message to screen
                Write-Host 'VNet RG:        '$_.VnetRG                                      # Write message to screen
                if ($_.VM) {                                                                # If $_.VM has a value
                    $VM = $_.VM                                                             # VM is equal to current item .VM
                    $VM = $VM.Split('/')[-1]                                                # Collects the VM name
                    Write-Host 'Attached VM:    '$VM                                        # Write message to screen
                    $VM = $null                                                             # Clears $VM                                            
                }                                                                           # End if ($_.VM)
                else {                                                                      # If $_.VM does not have a value
                    Write-Host 'Attached VM:     N/A'                                       # Write message to screen
                }                                                                           # End else (if ($_.VM))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNic                                                              # Breaks :ListAzureNic
        }                                                                                   # End :ListAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNetworkInterface
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                Write-Host 'Gathering subnets in:'$VNet' | '$VNet                           # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    Write-Host 'Gathering NICs in:'$SubnetName                              # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ObjectInput = [PSCustomObject]@{
                            'Number'=$ListNumber;'NicName'=$_.Name;'NicRG'=`
                            $_.ResourceGroupName;'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNet;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;`
                            'VM'=$_.VirtualMachine.ID;'IPCon'=$_.IpConfigurations
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Clear-Host                                                                      # Clears screen
            Write-Host ''                                                                   # Write message to screen
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.NicName                       # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]            "$_.NicName                        # Write message to screen
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
                    Write-Host 'NIC RG:         '$_.NicRG                                   # Write message to screen
                    Write-Host 'Subnet Name:    '$_.Subname                                 # Write message to screen
                    Write-Host 'Subnet Prefix:  '$_.SubPFX                                  # Write message to screen
                    Write-Host 'VNet Name:      '$_.VnetName                                # Write message to screen
                    Write-Host 'VNet Prefix:    '$_.VnetPFX                                 # Write message to screen
                    Write-Host 'VNet RG:        '$_.VnetRG                                  # Write message to screen
                    if ($_.VM) {                                                            # If $_.VM has a value
                        $VM = $_.VM                                                         # VM is equal to current item .VM
                        $VM = $VM.Split('/')[-1]                                            # Collects the VM name
                        Write-Host 'Attached VM:    '$VM                                    # Write message to screen
                        $VM = $null                                                         # Clears $VM                                            
                    }                                                                       # End if ($_.VM)
                    else {                                                                  # If $_.VM does not have a value
                        Write-Host 'Attached VM:     N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.VM))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.VnetName `
                        -ResourceGroupName $OpSelect.VNetRG                                 # Pulls the $Subnet Vnet
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Subname                                 # Pulls the $NicObject subnet
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName |`
                        Where-Object {$_.IpConfigurations.Subnet.ID -eq `
                        $SubnetObject.ID}                                                   # Pulls the full $NicObject
                    Return $NicObject,$SubnetObject,$VnetObject                             # Returns $vars to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface
function RemoveAzNetworkInterface {                                                         # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureNic while ($true) {                                                     # Outer loop for managing function
            if (!$NicObject) {                                                              # If $NicObject does not have a value
                $CallingFunction = 'RemoveAzNetworkInterface'                               # Sets $CallingFunction
                $NicObject,$SubnetObject,$VnetObject = `
                    GetAzNetworkInterface ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject does not have a value
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End if (!$NicObject)
            }                                                                               # End if (!$NicObject)
            If ($NicObject.VirtualMachine) {                                                # If $NicObject.VirtualMachine has a value
                $VM = $NicObject.VirtualMachine.Id                                          # Pulls the VM info into $VM
                $VM = $VM.Split('/')[-1]                                                    # Isolates the attached VM name
                Write-Host 'The selected NIC is attached to:'$VM                            # Write message to screen
                Write-Host 'Unable to delete the NIC while attached'                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End If ($NicObject.VirtualMachine)
            Write-Host 'Remove the NIC:'$NicObject.name                                     # Write message to screen
            Write-Host 'Resource group:'$NicObject.ResourceGroupName                        # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the Nic
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzNetworkInterface -Name $NicObject.Name -ResourceGroupName `
                        $NicObject.ResourceGroupName -Force -ErrorAction 'Stop'             # Removes the selected NIC
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End catch
                Write-Host 'The selected Nic has been removed'                              # Write message to screen
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End else (If ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNetworkInterface
# Functions for ManageAzNICIpConfig
function ManageAzNICIpConfig {                                                              # Function for managing azure nic ip configs
    Begin {                                                                                 # Begin function   
        :ManageAzureNicIPConfig while ($true) {                                             # Outer loop for managing function
            Write-Host 'Azure Nic IP Config Management'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nic IP Config'                                              # Write message to screen
            Write-Host '[2] List Nic IP Configs'                                            # Write message to screen
            Write-Host '[3] Remove Nic IP Config'                                           # Write message to screen
            Write-Host '[4] Change Private IP Config'                                       # Write message to screen
            Write-Host '[5] Change Primary IP Config'                                       # Write message to screen
            Write-Host '[6] Add NIC Public IP config'                                       # Write message to screen
            Write-Host '[7] Remove NIC Public IP config'                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNicIPConfig                                                # Breaks :ManageAzureNicIPConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Add Nic IP Config'                                              # Write message to screen
                AddAzNICIpConfig                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'List Nic IP Configs'                                            # Write message to screen
                ListAzNICIpConfig                                                           # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'Remove Nic IP Config'                                           # Write message to screen
                RemoveAzNICIpConfig                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Change Private IP Config'                                       # Write message to screen
                SetAzNICIpConfig                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Change Primary IP Config'                                       # Write message to screen
                SetAzNICPriIPConfig                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Elseif $OpSelect equals '6'
                Write-Host 'Add NIC Public IP config'                                       # Write message to screen
                SetAzNICIpConPublicIP                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Elseif $OpSelect equals '7'
                Write-Host 'Remove NIC Public IP config'                                    # Write message to screen
                RemoveAzNICIpConPublicIP                                                    # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '7')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNicIPConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNICIpConfig
function AddAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzNICIpConfig'                                           # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureNicIPConfig while ($true) {                                                # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNICIpConfig                                                   # Breaks :AddAzureNICIpConfig
            }                                                                               # End if (!$NicObject)
            :SetAzureIPConfigName while ($true) {                                           # Inner loop for setting the new IP config name
                Write-Host 'Please enter the name of the IP config name'                    # Write message to screen
                $NicIPConfigName = Read-Host 'Name'                                         # Operator input for the new IP config name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$NicIPConfigName' as the IP name'                          # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP config name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureIPConfigName                                              # Breaks :SetAzureIPConfigName  
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break AddAzureNICIpConfig                                               # Breaks :AddAzureNICIpConfig
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureIPConfigName while ($true)
            $SubnetID = $SubnetObject.ID                                                    # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Addinging the IP config'                                        # Write message to screen
                Add-AzNetworkInterfaceIpConfig -Name $NicIPConfigName -NetworkInterface `
                    $NicObject -SubnetId $SubnetID -ErrorAction 'Stop' | Out-Null           # Adds the new config
                $NicObject | Set-AzNetworkInterface -erroraction'Stop' | Out-Null           # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNicIPConfig                                                   # Breaks :AddAzureNicIPConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'IP config has been added to:'$NicObject.Name                        # Write message to the screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureNicIPConfig                                                       # Breaks :AddAzureNicIPConfig
        }                                                                                   # End :AddAzureNicIPConfig while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNICIpConfig
function ListAzNICIpConfig {                                                                # Function to list NIC IP configs
    Begin {                                                                                 # Begin function
        :ListAzureNICIpConfig while($true) {                                                # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets lists of all Vnets
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks exist in this subscription'                 # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break ListAzureNICIpConfig                                                  # Breaks :ListAzureNICIpConfig
            }                                                                               # End if (!$VNetList)
            foreach ($_ in $VNetList) {                                                     # For each item in $var
                $CurrentVNet = $_                                                           # Pulls current object into $var
                Write-Host 'Vnet Name:     '$CurrentVNet.Name                               # Write message to screen
                Write-Host 'Vnet Prefix:   '$CurrentVnet.AddressSpace.AddressPrefixes       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                    $CurrentVNet                                                            # Gets a list of all subnets in Vnet
                if (!$SubnetList) {                                                         # If $SubnetList is $null
                    Write-Host 'No subnets exist in this virtual network'                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if (!$SubnetList)
                foreach ($_ in $SubnetList) {                                               # For each item in $var
                    $CurrentSubnet = $_                                                     # Pulls current object into $var
                    Write-Host 'Sub Name:      '$CurrentSubnet.name                        # Write message to screen
                    Write-Host 'Sub Prefix:    '$CurrentSubnet.AddressPrefix               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $CurrentSubnet.ID}               # Gets a list of all nics attached to subnet
                    if (!$NicList) {                                                        # If $NicList is $null
                        Write-Host 'No NICs exist in this subnet'                           # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End if (!$NicList)
                    foreach ($_ in $NicList) {                                              # For each item in $var
                        $CurrentNic = $_                                                    # Pulls current object into $var
                        Write-Host 'Nic Name:      '$CurrentNic.Name                        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NicIPList = $CurrentNic.IPConfigurations                           # Gets a list of all IP configs on Nic
                        foreach ($_ in $NicIPList) {                                        # For each item in $var
                            $NicCon = $_                                                    # Pulls current object into $var
                            if ($NicCon.PublicIPaddress.ID) {                               # If a public IP sku is attached
                                $PubIP = Get-AzPublicIpAddress | Where-Object `
                                    {$_.ID -eq $NicCon.PublicIPaddress.ID}                  # Pulls the public IP sku info
                            }                                                               # End if ($NicCon.PublicIPaddress.ID)
                            Write-Host 'Config Name:   '$NicCon.Name                        # Write message to screen
                            Write-Host 'Is Primary:    '$NicCon.Primary                     # Write message to screen
                            Write-Host 'PrivIPAddress: '$NicCon.PrivateIPAddress            # Write message to screen
                            Write-Host 'PrivAllocation:'$NicCon.PrivateIpAllocationMethod   # Write message to screen
                            if ($PubIP) {
                                Write-Host 'PubIPName:     '$PubIP.Name                     # Write message to screen
                                Write-Host 'PubIPAddress:  '$PubIP.IpAddress                # Write message to screen
                                Write-Host 'PubAllocation: '$PubIP.PublicIpAllocationMethod # Write message to screen
                                $PubIP = $null                                              # Clears $PubIP
                            }                                                               # End if ($PubIP) 
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NicIPList)
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $NicList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $SubnetList)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VNetList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNICIpConfig                                                      # Breaks :ListAzureNICIpConfig
        }                                                                                   # End :ListAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNICIpConfig
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $NICName = $_.Name                                                          # $NICName is equal to current item .Name
                $NicRG = $_.ResourceGroupName                                               # Gets the NIC resource group
                $NicVM = $_.VirtualMachine.ID                                               # Gets the NIC VM if attached
                if ($NicVM) {                                                               # If $NicVM has a value 
                    $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}                  # Gets the currently attached VM
                }                                                                           # End if ($NicVM)
                $IPConfigList = $_.IPConfigurations                                         # IPConfigList is equal to current item .IPConfigurations
                foreach ($_ in $IPConfigList) {                                             # For each item in $IPConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates $ObjectInput            
                        'Number'=$ObjectNumber;'Name'=$_.Name;`
                        'PrivIP'=$_.PrivateIPAddress;`
                        'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                        'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                        'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name            # Collects the information for the array
                    }                                                                       # End $ObjectInput = [PSCustomObject]
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber +1                                        # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $IPConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                   "$_.Name                    # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]                  "$_.Name                     # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:   '$_.PrivIP                            # Write message to screen 
                    Write-Host 'Private IP Allocation:'$_.PrivIPAllo                        # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address:    '$PubIP.IpAddress                 # Write message to screen
                        Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:           '$_.Pri                               # Write message to screen
                    Write-Host 'Nic Name:             '$_.NicName                           # Write message to screen
                    if ($_.NICVM) {                                                         # If current item .NICVM has a value
                        Write-Host 'Attached VM:          '$_.NicVM                         # Write message to screen
                    }                                                                       # End if ($_.NICVM)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the IP config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the network config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNICIpConfig                                               # Breaks :GetAzureNICIpConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                        -ResourceGroupName $OpSelect.NicRG                                  # Gets the $NicObject
                    $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -Name $OpSelect.Name                                     # Gets the NicIPConfigObject
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig
function RemoveAzNICIpConfig {                                                              # Function to Remove a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNICIpConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNICIpConfig while($true) {                                              # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            if ($NICIPConfigObject.Primary -eq 'true') {                                    # If $NICIPConfigObject.Primary equals 'true'
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This config is primary and cannot be removed'                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($NICIPConfigObject.Primary -eq 'true')
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Write-Host 'Config:'$NicIPConfigObject.name                                     # Write message to screen
            Write-Host 'NIC:   '$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the public IP sku
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            Try {                                                                           # Try the following
                Write-Host 'Removing the IP configuration'                                  # Write message to screen
                Remove-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -NetworkInterface $NicObject -ErrorAction 'Stop' | Out-Null             # Removes the selected configuration
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears host
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks RemoveAzureNICIpConfig
            }                                                                               # End catch            
            Clear-Host                                                                      # Clears host                                                          
            Write-Host 'The IP configuration has been removed'                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureNICIpConfig                                                    # Breaks RemoveAzureNICIpConfig
        }                                                                                   # End :RemoveAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConfig
function SetAzNICIpConfig {                                                                 # Function to change the config private IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConfig'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            Write-Host 'Gathering current subnet info'                                      # Write message to screen
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            $VNetName = $SubnetID.Split('/')[8]                                             # Gets the virtual network name
            $VNetObject = Get-AzVirtualNetwork -Name $VNetName                              # Pulls the virtual network object
            $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject `
                | Where-Object {$_.ID -eq $SubnetID}                                        # Pulls the full subnet object
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on subnetID
            Clear-Host                                                                      # Clears screen
            :SetAzureNICIP while ($true) {                                                  # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $NicList) {                                                  # For each item in $NicList
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $NicList)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the IP address for:'$NicIPConfigObject.name               # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP addres
                Clear-Host                                                                  # Clears screen
                if ($IPInput -in $NicList.PrivateIPAddress) {                               # If $IPInput is in $NicList.PrivateIPAddress 
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -in $NicList.PrivateIPAddress)
                elseif ($IPInput -notlike '*.*.*.*') {                                      # Else if $IPInput is not like '*.*.*.*'
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End elseif ($IPInput -notlike '*.*.*.*')
                else {                                                                      # All other inputs for $IPInput
                    Write-Host 'Use:'$IPInput                                               # Write message to screen
                    Write-Host 'For:'$NicIPConfigObject.name                                # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureNICIP                                                 # Breaks :SetAzureNICIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($IPInput -in $NicList.PrivateIPAddress))
            }                                                                               # End :SetAzureNICIP while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Setting IP config'                                              # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PrivateIpAddress $IPInput -SubnetId $SubnetID -ErrorAction 'Stop'`
                    | Out-Null                                                              # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may fall into the'                              # Write message to screen
                Write-Host 'reserved range of the subnet'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may not be valid'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The NIC IP config has been updated'                                 # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig
function SetAzNICPriIPConfig {                                                              # Function to set the primary config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICPriIPConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            if ($NicObject.VirtualMachine) {                                                # If $NicObject.VirtualMachine has a value 
                $VMID = $NicObject.VirtualMachine.Id                                        # Isolates the VM ID
                $VMObject = Get-AzVM | Where-Object {$_.ID -eq $VMID}                       # Gets the currently attached VM
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This nic is currently attached to the following:'               # Write message to screen
                Write-Host 'VM Name:'$VMObject.Name                                         # Write message to screen
                Write-Host 'VM RG  :'$VMObject.ResourceGroupName                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This NIC cannot be updated while attached'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicObject.VirtualMachine)
            if ($NicIPConfigObject.Primary -eq 'True') {                                    # If $NicIPConfigObject.Primary equals 'True'
                Write-Host 'This configuration is already the primary'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicIPConfigObject.Primary -eq 'True')
            Write-Host 'Set the following as the primary config'                            # Write message to screen
            Write-Host 'Config:'$NicIPConfigObject.Name                                     # Write message to screen
            Write-Host 'On Nic:'$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation of change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Updating primary config on:'$NicObject.Name                     # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -SubnetId $SubnetID -Primary -ErrorAction 'Stop' | Out-Null             # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks SetAzureNICIpConfig
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The primary config has been changed'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin       
}                                                                                           # End function SetAzNICPriIPConfig
function SetAzNICIpConPublicIP {                                                            # Function to change the config public IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConPublicIP'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$PublicIPObject)
            Try {                                                                           # Try the following
                Write-Host 'Adding the public IP'                                           # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $PublicIPObject.ID -SubnetId `
                    $NicIPConfigObject.Subnet.ID -ErrorAction 'Stop' | Out-Null             # Adds $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConPublicIP
function RemoveAzNICIpConPublicIP {                                                         # Function to remove the config public IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNICIpConPublicIP'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            elseif (!$NicIPConfigObject.PublicIPAddress) {                                  # Else if $NicIPConfigObject.PublicIPAddress is $null
                Write-Host 'This IP config does not have an associated public IP sku'       # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End elseif (!$NicIPConfigObject.PublicIPAddress)
            Write-Host ''                                                                   # Write message to screen 
            Write-Host 'Config:'$NicIPConfigObject.name                                     # Write message to screen
            Write-Host 'NIC:   '$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the public IP sku
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Removing the public IP from this config'                        # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $null -SubnetId $SubnetID -ErrorAction 'Stop' `
                    | Out-Null                                                              # Removed $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails                
                Clear-Host                                                                 # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConPublicIP
# End ManageAzNICIpConfig
# End ManageAzNetworkInterface
# Functions for ManageAzPublicIPAddress
function ManageAzPublicIPAddress {                                                          # Function to manage public IP address Skus
    Begin {                                                                                 # Begin function
        :ManageAzurePublicIPAddress while ($true) {                                         # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New public IP sku'                                              # Write message to screen
            Write-Host '[2] List all public IP skus'                                        # Write message to screen
            Write-Host '[3] Change public IP sku allocation'                                # Write message to screen
            Write-Host '[4] Remove a public IP sku'                                         # Write message to screen
            $OpSelect = Read-Host 'Enter the option [#]'                                    # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzurePublicIPAddress                                            # Breaks :ManageAzurePublicIPAddress
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New public IP sku'                                              # Write message to screen
                NewAzPublicIpAddress                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List all public IP skus'                                        # Write message to screen
                ListAzPublicIpAddress                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Change public IP sku allocation'                                # Write message to screen
                SetAzPublicIPAddressAllo                                                    # Calls function 
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove a public IP sku'                                         # Write message to screen
                RemoveAzPublicIpAddress                                                     # Calls function 
            }                                                                               # elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzurePublicIPAddress while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzPublicIPAddress
function NewAzPublicIpAddress {                                                             # Function to create a new public IP address
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzPublicIpAddress'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup                                                  # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz'                                # Creates a string of valid first character
                $Valid1stChar = $Valid1stChar.ToCharArray()                                 # Loads all valid characters into array
                Write-Host 'Public IP name must begin with a letter'                        # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $PublicNameArray = $null                                                    # Clears $PublicNameArray
                $PublicNameInput = Read-Host 'Public IP name'                               # Operator input for the public IP name
                $PublicNameArray = $PublicNameInput.ToCharArray()                           # Loads $PublicNameInput into array
                Clear-Host                                                                  # Clears screen
                if ($PublicNameInput.Length -ge 81) {                                       # If $PublicNameInput.Length is greater or equal to 81
                    Write-Host 'The public IP name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PublicNameInput.Length -ge 62)
                if ($PublicNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $PublicNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter'           # Write message to screen
                    $PublicNameInput = $null                                                # Clears $PublicNameInput
                }                                                                           # End if ($PublicNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PublicNameArray) {                                          # For each item in $PublicNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Public IP name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PublicNameArray)
                if ($PublicNameInput) {                                                     # If $PublicNameInput has a value
                    Write-Host 'Use:'$PublicNameInput' as the public IP name'               # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    else {                                                                  # If $OpConfirm does not equal 'y'
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End else if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PublicNameInput) 
                else {                                                                      # If $PublicNameInput does not have a value
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PublicNameInput))
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $PublicIPAllocationObject = 'static'                                    # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            :SetAzurePublicIPSku while ($true) {                                            # Inner loop for setting the public IP Sku
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Basic'                                                      # Write message to screen
                Write-Host '[2] Standard'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $PubIPSkuObject = 'Basic'                                               # Creates $PubIPSkuObject
                    Break SetAzurePublicIPSku                                               # Breaks :SetAzurePublicIPSku    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $PubIPSkuObject = 'Standard'                                            # Creates $PubIPSkuObject
                    Break SetAzurePublicIPSku                                               # Breaks :SetAzurePublicIPSku
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzurePublicIPSku while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the public IP'                                         # Write message to screen
                New-AzPublicIpAddress -Name $PublicNameInput `
                    -ResourceGroupName $RGObject.ResourceGroupName -Location `
                    $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                    -DomainNameLabel $PublicIPNameObject -Sku $PubIPSkuObject -Force `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the new public IP address
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The public IP has been created'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzurePublicIP                                                          # Breaks :NewAzurePublicIP
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function ListAzPublicIpAddress {                                                            # Function for listing all public IP address skus
    Begin {                                                                                 # Begin function
        :ListAzurePublicIP while ($true) {                                                  # Outer loop for managing function
            $ObjectList = Get-AzPublicIpAddress                                             # Gets a list of all public IP address
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No public IP skus are present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzurePublicIP                                                     # Breaks :ListAzurePublicIP
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates array for list to be loaded into
            foreach ($_ in $ObjectList) {                                                   # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $ObjectInput = [PSCustomObject]@{                                           # Custom item to load into array
                    'Name'=$_.Name;'RG'=$_.ResourceGroupName;'Sku'=$_.Sku.Name;`
                    'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig                            # Creates the item list to load int array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in list
                Write-Host 'IP SKU Name '$_.Name                                            # Write message to screen
                Write-Host 'RG Name:    '$_.RG                                              # Write message to screen
                Write-Host 'Allocation: '$_.Allocation                                      # Write message to screen
                Write-Host 'IP Address: '$_.address                                         # Write message to screen
                Write-Host 'SKU Type:   '$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host 'NIC Name:   '$_.Nic                                         # Write message to screen
                    Write-Host 'NIC Config: '$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                  
                else {                                                                      # If current item .Nic does not have a value
                    Write-Host 'NIC Name:    N/A'                                           # Write message to screen
                    Write-Host 'NIC Config:  N/A'                                           # Write message to screen
                }                                                                           # End else (if ($_.Nic))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input 
            Break ListAzurePublicIP                                                         # Breaks :ListAzurePublicIP
        }                                                                                   # End :ListAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $ObjectList = Get-AzPublicIpAddress                                             # Gets a list of all public IP address
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No public IP skus are present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzurePublicIP                                                      # Breaks :GetAzurePublicIP
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates array for list to be loaded into
            $ObjectNumber = 1                                                               # Creates #var used for list selection
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $ObjectInput = [PSCustomObject]@{                                           # Custom item to load into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RG'=$_.ResourceGroupName;`
                    'Sku'=$_.Sku.Name;'Allocation'=$_.PublicIpAllocationMethod;`
                    'Address'=$_.IPAddress;'NIC'=$AttachedNIC;`
                    'IPconfig'=$AttachedNICIPConfig                                         # Creates the item list to load int array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Creats $Number (Used for formating)
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater than 9
                        Write-Host "[$Number]        "$_.Name                               # Write message to screen    
                    }                                                                       # End else if ($Number -le 9)
                    Write-Host 'RG Name:    '$_.RG                                          # Write message to screen
                    Write-Host 'Allocation: '$_.Allocation                                  # Write message to screen
                    Write-Host 'IP Address: '$_.address                                     # Write message to screen
                    Write-Host 'SKU Type:   '$_.Sku                                         # Write message to screen
                    if ($_.Nic) {                                                           # If current item .Nic has a value
                        Write-Host 'NIC Name:   '$_.Nic                                     # Write message to screen
                        Write-Host 'NIC Config: '$_.IPConfig                                # Write message to screen
                    }                                                                       # End if ($_.Nic)                                 
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray) 
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the public IP selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number list
                    $OpSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $OpSelect}                                           # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $PublicIPObject = Get-AzPublicIpAddress -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls $PublicIPObject
                    Return $PublicIPObject                                                  # Returns to calling function with $PublicIPObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other values
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function SetAzPublicIPAddressAllo {                                                         # Function for changing a public IP Sku IP allocation
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzPublicIPAddressAllo'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break SetAzurePublicIP                                                      # Breaks :SetAzurePublicIP
            }                                                                               # End if (!$PublicIPObject)
            if ($PublicIPObject.IpConfiguration.Id -and `
                $PublicIPObject.PublicIpAllocationMethod -eq 'Static') {                    # If PublicIPObject.IpConfiguration.Id has a value and PublicIpAllocationMethod equals 'Static'
                $AttachedNIC = ($PublicIPObject.IpConfiguration.Id).Split('/')[-3]          # Gets the attached NIC name
                $AttachedNICIPConfig = ($PublicIPObject.IpConfiguration.Id).Split('/')[-1]  # Gets the attached NIC IP config name
                Write-Host 'The selected IP sku allocation method'                          # Write message to screen
                Write-Host 'cannot be changed to dynamic while in use'                      # Write message to screen
                Write-Host 'Please detach this sku from the following:'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Attached NIC:   '$AttachedNIC                                   # Write message to screen
                Write-Host 'Nic config name:'$AttachedNICIPConfig                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Before changing the allocation to dynamic'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzurePublicIP                                                      # Breaks :SetAzurePublicIP
            }                                                                               # End if ($PublicIPObject.IpConfiguration.Id -and $PublicIPObject.PublicIpAllocationMethod -eq 'Static')
            else {                                                                          # If PublicIPObject.IpConfiguration.Id does not have a value
                Write-Host 'Change the public IP:'$PublicIPObject.name                      # Write message to screen
                if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static') {                # If $PublicIPObject.PublicIpAllocationMethod equals 'Static'
                    Write-Host 'allocation method to dynamic'                               # Write message to screen
                }                                                                           # End if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static')
                else {                                                                      # Else if $PublicIPObject.PublicIpAllocationMethod equals 'Dynamic'
                    Write-Host 'allocation method to static'                                # Write message to screen
                }                                                                           # End else (if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static'))
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to remove the public IP
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Write-Host 'Changing allocation method'                             # Write message to screen
                        if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static') {        # If $PublicIPObject.PublicIpAllocationMethod equals 'Static'     
                            $PublicIPObject.PublicIpAllocationMethod = 'Dynamic'            # Changes $PublicIPObject.PublicIpAllocationMethod to 'Dynamic'
                        }                                                                   # End if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static')
                        else {                                                              # Else if $PublicIPObject.PublicIpAllocationMethod -eq 'Dynamic'
                            $PublicIPObject.PublicIpAllocationMethod = 'Static'             # Changes $PublicIPObject.PublicIpAllocationMethod to 'Static'       
                        }                                                                   # End else (if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static'))
                        Set-AzPublicIpAddress -PublicIpAddress $PublicIPObject `
                            -ErrorAction 'Stop' | Out-Null                                  # Saves the public IP configuration
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'You may not have to the permissions'                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'The resource or group maybe locked'                     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break SetAzurePublicIP                                              # Breaks :SetAzurePublicIP
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The selected public IP sku has been changed'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # If $OpConfirm does not equal 'y'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (($PublicIPObject.IpConfiguration.Id -and $PublicIPObject.PublicIpAllocationMethod -eq 'Static'))
        }                                                                                   # End :SetAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzPublicIPAddress
function RemoveAzPublicIPAddress {                                                          # Function for removing a public IP Sku
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzPublicIPAddress'                                    # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzurePublicIP while ($true) {                                                # Outer loop for managing function
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break RemoveAzurePublicIP                                                   # Breaks :RemoveAzurePublicIP
            }                                                                               # End if (!$PublicIPObject)
            if ($PublicIPObject.IpConfiguration.Id) {                                       # If PublicIPObject.IpConfiguration.Id has a value
                $AttachedNIC = ($PublicIPObject.IpConfiguration.Id).Split('/')[-3]          # Gets the attached NIC name
                $AttachedNICIPConfig = ($PublicIPObject.IpConfiguration.Id).Split('/')[-1]  # Gets the attached NIC IP config name
                Write-Host 'The selected IP sku cannot be deleted'                          # Write message to screen
                Write-Host 'Please detach this sku from the following:'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Attached NIC:   '$AttachedNIC                                   # Write message to screen
                Write-Host 'Nic config name:'$AttachedNICIPConfig                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzurePublicIP                                                   # Breaks :RemoveAzurePublicIP
            }                                                                               # End if ($PublicIPObject.IpConfiguration.Id)
            else {                                                                          # If PublicIPObject.IpConfiguration.Id does not have a value
                Write-Host 'Remove the public IP:'$PublicIPObject.name                      # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to remove the public IP
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Write-Host 'Removing public IP sku'                                 # Write message to screen
                        Remove-AzPublicIpAddress -Name $PublicIPObject.Name `
                            -ResourceGroupName $PublicIPObject.ResourceGroupName `
                            -Force -ErrorAction 'Stop' | Out-Null                           # Removes the selected IP sku
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'You may not have to the permissions'                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'The resource or group maybe locked'                     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break RemoveAzurePublicIP                                           # Breaks :RemoveAzurePublicIP
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The selected public IP sku has been removed'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # If $OpConfirm does not equal 'y'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($PublicIPObject.IpConfiguration.Id))
        }                                                                                   # End :RemoveAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzPublicIPAddress
# End ManageAzPublicIPAddress
# Functions for ManageAzLoadBalancer
function ManageAzLoadBalancer {                                                             # Function to manage load balancer Skus
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Load Balancer'                                              # Write message to screen
            Write-Host '[2] List Load Balancers'                                            # Write message to screen
            Write-Host '[3] Remove Load Balancer'                                           # Write message to screen
            Write-Host '[4] Manage Load Balancer Configs'                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New load balancer'                                              # Write message to screen
                NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List load balancers'                                            # Write message to screen
                ListAzLoadBalancer                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove load balancer'                                           # Write message to screen
                RemoveAzLoadBalancer                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Load Balancer Configs'                                   # Write message to screen
                ManageAzLBConfig                                                            # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')    
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLoadBalancer
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzLoadBalancer'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                Write-Host 'Enter the load balancer name'                                   # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBNameObject = Read-Host 'Name'                                            # Operator input for the balancer name
                $LBNameArray = $LBNameObject.ToCharArray()                                  # Loads $LBNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($LBNameObject.Length -ge 81) {                                          # If $PublicNameInput.Length is greater or equal to 81
                    Write-Host 'The load balancer name is to long'                          # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($LBNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $LBNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameArray[0] -notin $Valid1stChar)
                if ($LBNameArray[-1] -notin $ValidLastChar) {                               # If last position of $LBNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBNameArray) {                                              # For each item in $LBNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Load balancer name cannot include any spaces'       # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBNameObject = $null                                               # Clears $LBNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBNameObject) {                                                        # If $LBNameObject has a value
                    Write-Host 'Use:'$LBNameObject' as the balancer name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the balancer name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBName                                                # Breaks :SetAzureLBName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBNameObject)
                else {                                                                      # If $LBNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBNameObject))
            }                                                                               # End :SetAzureLBName while ($true)
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$RGObject)
            :SetAzureLoadBalancerSku while ($true) {                                        # Inner loop to set the load balancer sku
                Write-Host 'Select the load balancer sku'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Basic'                                                      # Write message to screen
                Write-Host '[2] Standard'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $LBSkuObject = 'Basic'                                                  # Creates $LBSkuObject
                    Break SetAzureLoadBalancerSku                                           # Breaks :SetAzureLoadBalancerSku    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $LBSkuObject = 'Standard'                                               # Creates $LBSkuObject
                    Break SetAzureLoadBalancerSku                                           # Breaks :SetAzureLoadBalancerSku
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzureLoadBalancerSku while ($true)
            :NewAzureLBFrontEnd while ($true) {                                             # Inner loop for setting the type of front end config
                Write-Host 'Select type of front end config'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private Dynamic'                                            # Write message to screen
                Write-Host '[2] Private Static'                                             # Write message to screen
                Write-Host '[3] Public'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the IP type for front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer  
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FrontEndIPConfigObject = NewAzLBFEPriDynamicIpCon ($CallingFunction)   # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FrontEndIPConfigObject = NewAzLBFEPriStaticIpCon ($CallingFunction)    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $FrontEndIPConfigObject = NewAzLBFEPubIPCon `
                        ($CallingFunction, $LBSkuObject)                                    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($FrontEndIPConfigObject) {                                              # If $FrontEndIPConfigObject has a value
                    Break NewAzureLBFrontEnd                                                # Breaks :NewAzureLBFrontEnd
                }                                                                           # End if ($FrontEndIPConfigObject)
            }                                                                               # End :NewAzureLBFrontEnd while ($true)
            $BackEndIPConfigObject = NewAzLBBackendIpConfig                                 # Calls function and assigns output to $var
            if (!$BackEndIPConfigObject) {                                                  # If $BackEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$BackEndIPConfigObject)
            $HealthProbeObject = NewAzLBProbeConfig                                         # Calls function and assigns output to $var
            if (!$HealthProbeObject) {                                                      # If $HealthProbeObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$HealthProbeObject)
            $InboundNatPoolObject = NewAzLBIBNatPoolConfig `
                ($FrontEndIPConfigObject, $CallingFunction)                                 # Calls function and assigns output to $var
            if (!$InboundNatPoolObject) {                                                   # If $InboundNatPoolObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$InboundNatPoolObject)
            $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                $BackEndIPConfigObject, $HealthProbeObject, $CallingFunction)               # Calls function and assigns output to $var
            if (!$LoadBalanceRule) {                                                        # If $LoadBalanceRule is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$LoadBalanceRule)
            Try {                                                                           # Try the following
                Write-Host 'Creating the load balanacer'                                    # Write message to screen
                New-AzLoadBalancer -Name $LBNameObject -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location `
                    -FrontendIpConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                    $BackEndIPConfigObject -Probe $HealthProbeObject -LoadBalancingRule `
                    $LBRule -InboundNatPool $InboundNatPoolObject -Sku $LBSkuObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the load balancer
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided ports configuratiob may not be valid'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group maybe locked'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The load balancer has been created'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureLoadBalancer                                                      # Breaks :NewAzureLoadBalancer
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFEPriDynamicIpCon {                                                         # Function to set up a private dynamic front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)           # Calls function and assigns output to $var
            if (!$SubnetObject) {                                                           # If $var is $null
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLPFEIpConfig
            }                                                                               # End if (!$PublicIPObject)
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -SubnetId $SubnetID -ErrorAction 'Stop'             # Creates the load balancer front end config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPriDynamicIpCon
function NewAzLBFEPriStaticIpCon {                                                          # Function to set up a private static front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)           # Calls function and assigns output to $var
            if (!$SubnetObject) {                                                           # If $var is $null
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLPFEIpConfig
            }                                                                               # End if (!$PublicIPObject)
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
            Write-Host 'Gathering current subnet info'                                      # Write message to screen
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on subnetID
            Clear-Host                                                                      # Clears screen
            :SetAzureLBIP while ($true) {                                                   # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $NicList) {                                                  # For each item in $NicList
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $NicList)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the static IP address:'                                   # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP addres
                Clear-Host                                                                  # Clears screen
                if ($IPInput -in $NicList.PrivateIPAddress) {                               # If $IPInput is in $NicList.PrivateIPAddress 
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -in $NicList.PrivateIPAddress)
                elseif ($IPInput -notlike '*.*.*.*') {                                      # Else if $IPInput is not like '*.*.*.*'
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End elseif ($IPInput -notlike '*.*.*.*')
                else {                                                                      # All other inputs for $IPInput
                    Write-Host 'Use:'$IPInput ' for the load balancer front end'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureLBIP                                                  # Breaks :SetAzureLBIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($IPInput -in $NicList.PrivateIPAddress))
            }                                                                               # End :SetAzureLBIP while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -SubnetId $SubnetID -PrivateIpAddress $IPInput `
                    -ErrorAction 'Stop'                                                     # Creates the load balancer front end config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPriStaticIpCon
function NewAzLBFEPubIPCon {                                                                # Function to set up the front end public IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzurePublicIP while ($true) {                                               # Inner loop for selecting the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$PublicIPObject)
                if ($PublicIPObject.Sku.Name -ne $LBSkuObject) {                            # If $PublicIPObject.Sku.Name does not equal $LBSkuObject 
                    if ($LBSkuObject -eq 'Basic') {                                         # If $LBSkuObject equals 'Basic
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a basic sku and requires a'                          # Write message to screen
                        Write-Host 'basic public IP sku'                                    # Write message to screen
                    }                                                                       # End if ($LBSkuObject -eq 'Basic')
                    else {                                                                  # Else if $LBSkuObject equals 'standard'
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a standard sku and requires a'                       # Write message to screen
                        Write-Host 'standard public IP sku'                                 # Write message to screen 
                    }                                                                       # End else (if ($LBSkuObject -eq 'Basic'))
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Select a different public IP sku?'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No'                                  # Operator selection to choose a new public IP sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $PublicIPObject = $null                                             # Clears $PublicIPObject
                    }                                                                       # End if ($OpSelect -eq 'y')
                    else {                                                                  # Else if $OpSelect does not equal 'y'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if ($OpSelect -eq 'y')
                }                                                                           # End if ($PublicIPObject.Sku.Name -ne $LBSkuObject)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.Sku.Name -ne $LBSkuObject))
                if ($PublicIPObject.IpConfiguration.Id) {                                   # If $PublicIPObject.IpConfiguration.Id has a value
                    Write-Host 'The selected public IP sku is already in use'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Select a different public IP sku?'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No'                                  # Operator selection to choose a new public IP sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $PublicIPObject = $null                                             # Clears $PublicIPObject
                    }                                                                       # End if ($OpSelect -eq 'y')
                    else {                                                                  # Else if $OpSelect does not equal 'y'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if ($OpSelect -eq 'y')
                }                                                                           # End if ($PublicIPObject.IpConfiguration.Id)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.IpConfiguration.Id))
            }                                                                               # End :SetAzurePublicIP while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -PublicIpAddress $PublicIPObject -ErrorAction `
                    'Stop'                                                                  # Creates the load balancer front end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFEPubIPCon
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                Write-Host 'Enter the load balancer back end name'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $BackEndNameObject = Read-Host 'Name'                                       # Operator input for the back end name
                $BackEndNameArray = $BackEndNameObject.ToCharArray()                        # Loads $BackEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($BackEndNameObject.Length -ge 81) {                                     # If $BackEndNameObject.Length is greater or equal to 81
                    Write-Host 'The back end name is to long'                               # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($BackEndNameArray[0] -notin $Valid1stChar) {                            # If 0 position of $BackEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($BackEndNameArray[0] -notin $Valid1stChar)
                if ($BackEndNameArray[-1] -notin $ValidLastChar) {                          # If last position of $BackEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($BackEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $BackEndNameArray) {                                         # For each item in $BackEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $BackEndNameObject = $null                                          # Clears $BackEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($BackEndNameObject) {                                                   # $BackEndNameObject has a value
                    Write-Host 'Use:'$BackEndNameObject' as the back end name'              # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBBEIpConfig                                          # Breaks :NewAzureLBBEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBBEName                                              # Breaks :SetAzureLBBEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndNameObject)
                else {                                                                      # If $BackEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndNameObject))
            }                                                                               # End :SetAzureLBBEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer back end config'                     # Write message to screen
                $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                    $BackEndNameObject -ErrorAction 'Stop'                                  # Creates the load balancer back end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Back end config has been built'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $BackEndIPConfigObject                                                   # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {                                                                                 # Begin function
        :NewAzureLBProbeConfig while ($true) {                                              # Out loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                Write-Host 'Enter the load balancer probe name'                             # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeNameObject = Read-Host 'Name'                                         # Operator input for the probe name
                $ProbeNameArray = $ProbeNameObject.ToCharArray()                            # Loads $ProbeNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($ProbeNameObject.Length -ge 81) {                                       # If $ProbeNameObject.Length is greater or equal to 81
                    Write-Host 'The probe name is to long'                                  # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameObject.Length -ge 80)
                if ($ProbeNameArray[0] -notin $Valid1stChar) {                              # If 0 position of $ProbeNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameArray[0] -notin $Valid1stChar)
                if ($ProbeNameArray[-1] -notin $ValidLastChar) {                            # If last position of $ProbeNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $ProbeNameArray) {                                           # For each item in $ProbeNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Probe name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ProbeNameObject = $null                                            # Clears $ProbeNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($ProbeNameObject) {                                                     # If $ProbeNameObject has a value
                    Write-Host 'Use:'$ProbeNameObject' as the probe name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeName                                             # Breaks :SetAzureProbeName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End $ProbeNameObject
                else {                                                                      # If $ProbeNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else $ProbeNameObject
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host 'Load balanacer health probe protocol'                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option[#]'                                           # Operator input for the probe type object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals '1'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals '2'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (If $OpSelect -eq '0')
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Write-Host 'Enter the probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeIntervalObject = Read-Host 'Probe interval'                           # Operator input for the probe interval
                $ProbeIntervalArray = $ProbeIntervalObject.ToCharArray()                    # Loads $ProbeIntervalObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeIntervalArray) {                                       # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeIntervalObject = $null                                        # Clears $ProbeIntervalObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeIntervalObject) {                                                 # If $ProbeIntervalObject has a value
                    Write-Host 'Set probe interval at:'$ProbeIntervalObject' Seconds'       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeIntervalObject)
                else {                                                                      # Else if $ProbeIntervalObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeIntervalObject))
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Write-Host 'Enter the number of probes required to'                         # Write message to screen
                Write-Host 'report node is no longer functioning'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $ProbeCountObject = Read-Host 'Probe count'                                 # Operator input for the probe count
                $ProbeCountArray = $ProbeCountObject.ToCharArray()                          # Loads $ProbeCountObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeCountArray) {                                          # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeCountObject = $null                                           # Clears $ProbeCountObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeCountObject) {                                                    # If $ProbeCountObject has a value
                    Write-Host 'Set probe count at:'$ProbeCountObject                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeCountObject)
                else {                                                                      # All other inputs for $ProbeCountObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeCountObject))
            }                                                                               # End :SetAzureProbeCount while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building health probe configuration'                            # Write message to screen
                $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                    -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                    -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                    -ProbeCount $ProbeCountObject -ErrorAction 'Stop'                       # Creates the Health probe object
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Health probe config has been built'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $HealthProbeObject                                                       # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig
function NewAzLBIBNatPoolConfig {                                                           # Function to create inbound pool configuration for load balancer
    begin {                                                                                 # Begin function
        :NewAzureLBIBNatPoolConfig while ($true) {                                          # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBIBNatPoolName while ($true) {                                        # Inner loop for setting the nat pool name
                Write-Host 'Enter the load balancer nat pool name'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen    
                $NatPoolNameObject = Read-Host 'Name'                                       # Operator input for the pool name
                $NatPoolNameArray = $NatPoolNameObject.ToCharArray()                        # Loads $NatPoolNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($NatPoolNameObject.Length -ge 81) {                                     # If $NatPoolNameObject.Length is greater or equal to 81
                    Write-Host 'The pool name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameObject.Length -ge 80)
                if ($NatPoolNameArray[0] -notin $Valid1stChar) {                            # If 0 position of $NatPoolNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameArray[0] -notin $Valid1stChar)
                if ($NatPoolNameArray[-1] -notin $ValidLastChar) {                          # If last position of $NatPoolNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $NatPoolNameArray) {                                         # For each item in $NatPoolNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Pool name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NatPoolNameObject = $null                                          # Clears $NatPoolNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NatPoolNameObject) {                                                   # If $NatPoolNameObject has a value
                    Write-Host 'Use:'$NatPoolNameObject' as the pool name'                  # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBIBNatPoolName                                       # Breaks :NewAzureLBIBNatPoolName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($NatPoolNameObject)
                else {                                                                      # If $NatPoolNameObject is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NatPoolNameObject))
            }                                                                               # End :NewAzureLBIBNatPoolName while ($true) {
            :NewAzureLBIBNPProtocol while ($true) {                                         # Inner loop for setting the nat pool protocol
                Write-Host 'Load balancer nat pool protocol'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $NatPoolProtocolObject = 'TCP'                                          # Sets $NatPoolProtocolObject to 'TCP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $NatPoolProtocolObject = 'UDP'                                          # Sets $NatPoolProtocolObject to 'UDP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0')) 
            }                                                                               # End :NewAzureLBIBNPProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBFEPortStart while ($true) {                                          # Inner loop for setting the front end port range start
                Write-Host 'Enter the nat pool front end port start'                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndPortStart = Read-Host 'Starting port #'                            # Operator input for the front end port start
                $FrontEndPortArray = $FrontEndPortStart.ToCharArray()                       # Adds $FrontEndPortStart to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $FrontEndPortArray) {                                        # For each item in $FrontEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $FrontEndPortStart = $null                                          # Clears $FrontEndPortStart
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FrontEndPortArray)
                $FrontEndPortArray = $null                                                  # Clears $FrontEndPortArray
                if ($FrontEndPortStart) {                                                   # If $FrontEndPortStart has a value
                    Write-Host 'Use:'$FrontEndPortStart' as the front end pool start'       # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end port start
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBFEPortStart                                         # Breaks :NewAzureLBFEPortStart        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndPortStart)
                else {                                                                      # Else if $FrontEndPortStart is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndPortStart))
            }                                                                               # End :NewAzureLBFEPortStart while ($true)
            :NewAzureLBFEPortEnd while ($true) {                                            # Inner loop for setting the front end port range end
                Write-Host 'Enter the nat pool front end port end'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndPortEnd = Read-Host 'Ending port #'                                # Operator input for the front end port start
                $FrontEndPortArray = $FrontEndPortEnd.ToCharArray()                         # Adds $FrontEndPortEnd to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $FrontEndPortArray) {                                        # For each item in $FrontEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $FrontEndPortEnd = $null                                            # Clears $FrontEndPortEnd
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FrontEndPortArray)
                $FrontEndPortArray = $null                                                  # Clears $FrontEndPortArray
                if ($FrontEndPortEnd) {                                                     # If $FrontEndPortEnd has a value
                    Write-Host 'Use:'$FrontEndPortEnd' as the front end pool end'           # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end port end
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBFEPortEnd                                           # Breaks :NewAzureLBFEPortEnd        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndPortEnd)
                else {                                                                      # Else if $FrontEndPortEnd is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndPortEnd))
            }                                                                               # End :NewAzureLBFEPortEnd while ($true)
            :NewAzureLBBEPort while ($true) {                                               # Inner loop for setting the back end port
                Write-Host 'Enter the nat pool back end port'                               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $BackEndPort = Read-Host 'Back end port #'                                  # Operator input for the back end port
                $BackEndPortArray = $BackEndPort.ToCharArray()                              # Adds $BackEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $BackEndPortArray) {                                         # For each item in $BackEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $BackEndPort = $null                                                # Clears $BackEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $BackEndPortArray)
                $BackEndPortArray = $null                                                   # Clears $BackEndPortArray
                if ($BackEndPort) {                                                         # If $BackEndPort has a value
                    Write-Host 'Use:'$BackEndPort' as the back end port'                    # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end port
                    Clear-Host                                                              # Clears screen 
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBBEPort                                              # Breaks :NewAzureLBBEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndPort)
                else {                                                                      # Else if $BackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndPort))
            }                                                                               # End :NewAzureLBBEPort while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the nat pool'                                          # Write message to screen
                $InboundNatPoolObject = New-AzLoadBalancerInboundNatPoolConfig -Name `
                    $NatPoolNameObject -FrontendIpConfigurationId `
                    $FrontEndIPConfigObject.ID -Protocol $NatPoolProtocolObject `
                    -FrontendPortRangeStart $FrontEndPortStart -FrontendPortRangeEnd `
                    $FrontEndPortEnd -BackendPort $BackEndPort -ErrorAction 'Stop'          # Creates the inbound pool object
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBIBNatPoolConfig                                             # Breaks :NewAzureLBIBNatPoolConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The nat pool has been created'                                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $InboundNatPoolObject                                                    # Returns $InboundNatPoolObject to calling function
        }                                                                                   # End :NewAzureLBIBNatPoolConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBInboundNatPoolConfig
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                Write-Host 'Enter a load balancer rule name'                                # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleNameObject = Read-Host 'Name'                                        # Operator input for the pool name
                Clear-Host                                                                  # Clears screen
                $LBRuleNameArray = $LBRuleNameObject.ToCharArray()                          # Loads $LBRuleNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleNameObject.Length -ge 81) {                                      # If $LBRuleNameObject.Length is greater or equal to 81
                    Write-Host 'The rule name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameObject.Length -ge 80)
                if ($LBRuleNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $LBRuleNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                if ($LBRuleNameArray[-1] -notin $ValidLastChar) {                           # If last position of $LBRuleNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBRuleNameArray) {                                          # For each item in $LBRuleNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBRuleNameObject = $null                                           # Clears $LBRuleNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleNameObject) {                                                    # If $LBRuleNameObject has a value
                    Write-Host 'Use:'$LBRuleNameObject' as the rule name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRCName                                              # Breaks :NewAzureLBRCName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleNameObject)
                else {                                                                      # If $LBRuleNameObject is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleNameObject))
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Load balancer rule protocol'                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Write-Host 'Enter the rule pool front end port'                             # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleFrontEndPort = Read-Host 'Port #'                                    # Operator input for the front end rule port 
                $LBRuleArray = $LBRuleFrontEndPort.ToCharArray()                            # Adds $LBRuleFrontEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleFrontEndPort = $null                                         # Clears $LBRuleFrontEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleFrontEndPort) {                                                  # If $LBRuleFrontEndPort has a value
                    Write-Host 'Use:'$LBRuleFrontEndPort' as the front end pool rule port'  # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Write-Host 'Enter the rule pool back end port'                              # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleBackEndPort = Read-Host 'Port #'                                     # Operator input for the back end rule port 
                $LBRuleArray = $LBRuleBackEndPort.ToCharArray()                             # Adds $LBRuleBackEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleBackEndPort = $null                                          # Clears $LBRuleBackEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleBackEndPort) {                                                   # If $LBRuleBackEndPort has a value
                    Write-Host 'Use:'$LBRuleBackEndPort' as the back end pool rule port'    # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleBackEndPort)
                else {                                                                      # Else if $LBRuleBackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleBackEndPort))
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in seconds for this rule'               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
                $LBRuleArray = $LBRuleIdleTO.ToCharArray()                                  # Adds $LBRuleIdleTO to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleIdleTO = $null                                               # Clears $LBRuleIdleTO
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleIdleTO) {                                                        # If $LBRuleIdleTO has a value
                    Write-Host 'Use:'$LBRuleIdleTO' as the rule idle time out'              # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO)
                else {                                                                      # Else if $LBRuleIdleTO is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO))
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the load balancer rule'                                # Write message to screen
                $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                    -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                    $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                    $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                    $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO `
                    -EnableFloatingIP -LoadDistribution SourceIP -ErrorAction 'Stop'        # Creates the load balancer rule
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBRuleConfig                                                  # Breaks :NewAzureLBRuleConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been created'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $LoadBalanceRule                                                         # Returns $LoadBalanceRule to calling function
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig
function ListAzLoadBalancer {                                                               # Function to list all existing load balancers
    Begin {                                                                                 # Begin function
        :ListAzureLoadBalancer while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLoadBalancer                                                 # Breaks :ListAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Name'= $_.Name;'RG'=$_.ResourceGroupName;'Loc'=$_.Location;`
                    'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;'PubAddress'=`
                    $PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name;`
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Creates the item to loaded into array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'LB name:       '$_.Name                                         # Write message to screen
                Write-Host 'LB loc:        '$_.loc                                          # Write message to screen
                Write-Host 'LB RG:         '$_.RG                                           # Write message to screen
                Write-Host 'LB SKU:        '$_.Sku                                          # Write message to screen
                if ($_.Pubname) {                                                           # If $_.Pubname exists
                    Write-Host 'Pub IP name:   '$_.Pubname                                  # Write message to screen
                    Write-Host 'Pub IP address:'$_.PubAddress                               # Write message to screen
                    Write-Host 'Pub IP allocat:'$_.PubAllocation                            # Write message to screen
                }                                                                           # End if ($_.Pubname)
                if ($_.VmssName) {                                                          # If $_.VmssName has a value
                    Write-Host 'Vmss name:     '$_.VmssName                                 # Write message to screen
                    Write-Host 'Vmss RG:       '$_.VmssRG                                   # Write message to screen
                }                                                                           # End if ($_.VmssName)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLoadBalancer                                                     # Breaks :ListAzureLoadBalancer
        }                                                                                   # End :ListAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLoadBalancer           
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLoadBalancer                                                  # Breaks GetAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RGName'=$_.ResourceGroupName;`
                    'LOC'=$_.Location;'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name; `
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Gets current item info
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB loc:        '$_.loc                                      # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'LB SKU:        '$_.Sku                                      # Write message to screen
                    if ($_.Pubname) {                                                       # If $_.Pubname has a value
                        Write-Host 'Pub IP name:   '$_.Pubname                              # Write message to screen
                        Write-Host 'Pub IP address:'$_.PubAddress                           # Write message to screen
                        Write-Host 'Pub IP allocat:'$_.PubAllocation                        # Write message to screen
                    }                                                                       # End if ($_.Pubname)
                    if ($_.VmssName) {                                                      # If $_.VmssName has a value
                        Write-Host 'Vmss name:     '$_.VmssName                             # Write message to screen
                        Write-Host 'Vmss RG:       '$_.VmssRG                               # Write message to screen
                    }                                                                       # End if ($_.VmssName)
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the load balancer for:'$CallingFunction   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                Clear-Host                                                                  # Clears screen 
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.Name `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer          
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
function ManageAzLBConfig {                                                                 # Function to manage load balancer config
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Public IP Front End Config'                                 # Write message to screen
            Write-Host '[2] New Back End Config'                                            # Write message to screen
            Write-Host '[3] New Probe Config'                                               # Write message to screen
            Write-Host '[4] New Nat Pool Config'                                            # Write message to screen
            Write-Host '[5] New Rule Config'                                                # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Front End Config'                                           # Write message to screen
                AddAzLBFEPublicConfig                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'New Back End Config'                                            # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'New Probe Config'                                               # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'New Nat Pool Config'                                            # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
            Write-Host '[5] New Rule Config'                                                # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBConfig
function AddAzLBFEPublicConfig {                                                            # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPublicConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig ($CallingFunction)            # Calls function and assigns the output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $LBSku =  $LoadBalancerObject.Sku.name                                          # Gets the current load balance sku
            $PubIPID = $FrontEndIPConfigObject.PublicIPAddress.Id                           # Isloates the public IP ID
            $PubIPObject = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubIPID}        # Gets the public IP object
            $PubIPSku = $PubIPObject.Sku.Name                                               # Isloates the sku
            if ($PubIPObject.IpConfiguration.Id) {                                          # If $PubIPObject.IpConfiguration.Id has a value
                Write-Host 'This public IP sku is already in use'                           # Write message to screen
                Write-Host 'Please select an unused public IP sku'                          # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }
            if ($LBSku -ne $PubIPSku) {                                                     # If $LBSku does not equal $PubIPSku
                if ($LBSku -eq 'Basic') {                                                   # If $LBSku equals 'Basic'
                    Write-Host 'The load balancer is a basic SKU and'                       # Write message to screen
                    Write-Host 'can only use a basic public IP sku'                         # Write message to screen
                }                                                                           # End   
                else {                                                                      # If $LBSku does not equal 'Basic'                              
                    Write-Host 'The load balancer is a standard SKU and'                    # Write message to screen
                    Write-Host 'can only use a standard public IP sku'                      # Write message to screen
                }                                                                           # End else (if ($LBSku -eq 'Basic'))
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LBSku -ne $PubIPSku)
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Public IP name:'$PubIPObject.Name                                   # Write message to screen
            Write-Host 'Public IP add: '$PubIPObject.IpAddress                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen                         
                    $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Adds the load balancer config
                    Write-Host 'Saving load balancer front end config'                      # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Saves the load balancer config
                    Write-Host 'Saving load balancer config'                                # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the load balancer state
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The front end config has been added'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBFEPublicConfig
# End ManageAzLBConfig
# End ManageAzLoadBalancer
# Additional functions required for ManageAzVirtualNetwork
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name '|' $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name '|' $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                Write-Host '[0]   Exit'                                                     # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each $_ in $ListArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]  "$_.Location                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number] "$_.Location                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                }                                                                           # End foreach ($_ in $ListArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the location for:'$CallingFunction        # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is '0'
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ListArray.Number) {                                  # If $OpSelect in $ListArray.Number
                    $OpSelect = $ListArray | Where-Object {$_.Number -eq $OpSelect}         # OpSelect is equal to $ListArray where $OpSelect equals $ListArray.Number
                    $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                        -eq $OpSelect.Location} -ErrorAction 'Stop'                         # Pulls the full $LocationObject
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen   
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation