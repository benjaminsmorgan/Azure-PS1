# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    New-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-6.2.1
    Remove-AzNetworkSecurityGroup:              https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
    Add-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
    Remove-AzNetworkSecurityRuleConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworksecurityruleconfig?view=azps-6.2.1
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.1
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    NewAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NewAzNSG.ps1
    ListAzNSG:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/ListAzNSG.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    RemoveNSG:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/RemoveNSG.ps1
    ManageAzNSGRule:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/ManageAzNSGRule.ps1
        GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
        SetAzNSGRuleProtocol:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleProtocol.ps1
        SetAzNSGRuleAccess:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleAccess.ps1
        SetAzNSGRuleDirection:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDirection.ps1
        SetAzNSGRulePriority:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRulePriority.ps1
        SetAzNSGRuleSPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleSPortRange.ps1
        SetAzNSGRuleDPortRange:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleDPortRange.ps1
        SetAzNSGRuleAddPrefix:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/SetAzNSGRuleAddPrefix.ps1  
        SetIPAddress:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetIPAddress.ps1
        SetCIDRAddress:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetCIDRAddress.ps1
        ListAzNSGRule:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/ListAzNSGRule.ps1
        ListAzAllNSGsRule:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/ListAzAllNSGsRule.ps1
        UpdateAzNSGRAccess:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRAccess.ps1
        UpdateAzNSGRDirection:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRDirection.ps1
        UpdateAzNSGRPriority:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRPriority.ps1
        UpdateAzNSGRProtocol:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRProtocol.ps1
        UpdateAzNSGRSPRange:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRSPRange.ps1
        UpdateAzNSGRDPRange:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRDPRange.ps1
        UpdateAzNSGRSAddPrefix:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRSAddPrefix.ps1
        UpdateAzNSGRDAddPrefix:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRDAddPrefix.ps1
        UpdateAzNSGRSAppSecG:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRSAppSecG.ps1
        UpdateAzNSGRDAppSecG:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRDAppSecG.ps1
        GetAzAllNSGsRule:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzAllNSGsRule.ps1
        GetAzNSGRule:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/GetAzNSGRule.ps1
        RemoveAzNSGRule:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/RemoveAzNSGRule.ps1
        UpdateAzNSGRuleConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NSG%20Rules/UpdateAzNSGRuleConfig.ps1
        GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/NSG%20Rules/GetAzASG.ps1
    ManageAzNSGNIC:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/ManageAzNSGNIC.ps1
        AddAzNSGNIC:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/AddAzNSGNIC.ps1
        ListAzNSGNIC:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/ListAzNSGNIC.ps1
        RemoveAzNSGNIC:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/RemoveAzNSGNIC.ps1
        GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
        GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1    
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzNSG:                Function to manage network security groups
    NewAzNSG:                   Function to create a new network security group
    ListAzNSG:                  Function to list all network security groups
    GetAzNSG:                   Function to get a network security group
    RemoveNSG:                  Function to remove a network security group
    ManageAzNSGRule:            Function to manage network security group rules
        NewAzNSGRule:               Function to create a new network security group rule
        GetAzNSG:                   Function to get a network security group
        SetAzNSGRuleProtocol:       Function to set a network security group rule protocol
        SetAzNSGRuleAccess:         Function to set a network security group rule access
        SetAzNSGRuleDirection:      Function to set a network security group rule direction
        SetAzNSGRulePriority:       Function to set a network security group rule priority
        SetAzNSGRuleSPortRange:     Function to set a network security rule source port range
        SetAzNSGRuleDPortRange:     Function to set a network security rule destination port range
        SetAzNSGRuleAddPrefix:      Function to set a network security rule address prefix     
        SetIPAddress:               Function to add an IP address to $var
        SetCIDRAddress:             Function to add a CIDR address to $var
        ListAzNSGRule:              Function to list a network security group rules
        ListAzAllNSGsRule:          Function to list all rules from all network security groups
        GetAzAllNSGsRule:           Function to get a rule from all network security groups
        GetAzNSGRule:               Function to get a network security group rule
        RemoveAzNSGRule:            Function to remove a network security group rule
        UpdateAzNSGRAccess:         Function to update a network security group rule access
        UpdateAzNSGRuleConfig:      Function for updating network security group rule configs
        UpdateAzNSGRDirection:      Function to update a network security group rule direction
        UpdateAzNSGRPriority:       Function to update a network security group rule priority
        UpdateAzNSGRProtocol:       Function to update a network security group rule protocol
        UpdateAzNSGRSPRange:        Function to update a network security group rule source port range
        UpdateAzNSGRDPRange:        Function to update a network security group rule destination port range
        UpdateAzNSGRSAddPrefix:     Function to update a network security group rule source application security group
        GetAzASG:                   Function to get a application security group
        UpdateAzNSGRDAddPrefix:     Function to update a network security group rule source application security group
        UpdateAzNSGRSAppSecG:       Function to update a network security group rule source application security group
        UpdateAzNSGRDAppSecG:       Function to update a network security group rule destination application security group
    ManageAzNSGNIC:             Function to manage NSG Nic associations
        AddAzNSGNIC:                Function to add a NSG to NIC
        ListAzNSGNIC:               Function to list all NICs associated with network security groups
        RemoveAzNSGNIC:             Function to remove a NSG from NIC
        GetAzNSG:                   Function to get a network security group
        GetAzNetworkInterface:      Function to get a network interface
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :ManageAzureNSG             Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    NewAzNSG{}                  Creates $NSGObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzNSG{}                 Lists $NSGObject
    RemoveNSG{}                 Removes $NSGObject
        GetAzNSG{}                  Gets $NSGObject
    ManageAzNSGRule{}           Manages $NSGRuleObject
        NewAzNSGRule{}              Creates $NSGRuleObject
            GetAzNSG{}                  Gets $NSGObject
            SetAzNSGRuleProtocol{}      Gets $NSGRuleProtocol
            SetAzNSGRuleAccess{}        Gets $NSGRuleAccess
            SetAzNSGRuleDirection{}     Gets $NSGRuleDirection
            SetAzNSGRulePriority{}      Gets $NSGRulePriority
            SetAzNSGRuleSPortRange{}    Gets $NSGRuleSPRange
            SetAzNSGRuleDPortRange{}    Gets $NSGRuleDPRange
            SetAzNSGRuleAddPrefix{}     Gets $NSGRuleAddPrefix
                SetIPAddress{}              Gets $IPAddress
                SetCIDRAddress{}            Gets $CIDRAddress
            GetAzASG{}                  Gets $ASGObject    
        ListAzNSGRule{}             Lists $NSGRuleObject
            GetAzNSG{}                  Gets $NSGObject
        ListAzAllNSGsRule{}         Lists $NSGRuleObject
        RemoveAzNSGRule{}           Removes $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSGRule{}              Gets $NSGRuleObject
                GetAzNSG{}                  Gets $NSGObject
        UpdateAzNSGRAccess{}        Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleAccess{}        Gets $NSGRuleAccess
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
        UpdateAzNSGRDirection{}     Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleDirection{}     Gets $NSGRuleDirection
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject    
        UpdateAzNSGRPriority{}      Updates $NSGRuleObject
            $OpConfirm:                 Operator confirmation to update the NSG rule object
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRulePriority{}      Gets $NSGRulePriority
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject    
        UpdateAzNSGRProtocol{}      Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleProtocol{}      Gets $NSGRuleProtocol
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
        UpdateAzNSGRSPRange{}       Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleSPortRange{}    Gets $NSGRuleSPRange
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject    
        UpdateAzNSGRDPRange{}       Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleDPortRange{}    Gets $NSGRuleDPRange
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject      
        UpdateAzNSGRSAddPrefix{}    Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
                GetAzNSG{}                  Gets $NSGObject
            GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleAddPrefix{}     Gets $NSGRuleAddPrefix
                SetIPAddress{}              Gets $IPAddress
                SetCIDRAddress{}            Gets $CIDRAddress
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject
        UpdateAzNSGRDAddPrefix{}    Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            SetAzNSGRuleAddPrefix{}     Gets $NSGRuleAddPrefix
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject    
        UpdateAzNSGRSAppSecG{}      Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            GetAzASG{}                  Gets $ASGObject
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject  
        UpdateAzNSGRDAppSecG{}      Updates $NSGRuleObject
            GetAzAllNSGsRule{}          Gets $NSGRuleObject, $NSGObject
            GetAzNSG{}                  Gets $NSGObject
                GetAzNSGRule{}              Gets $NSGRuleObject
            GetAzASG{}                  Gets $ASGObject
            UpdateAzNSGRuleConfig{}     Changes $NSGRuleObject, $NSGObject      
    ManageAzNSGNic              Manages $NicObject, $NSGObject
        AddAzNSGNIC{}               Updates $NicObject
            GetAzNSG{}                  Gets $NSGObject
            GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
        ListAzNSGNIC{}              Lists $NSGObject, $NICObject, $VMObject
        RemoveAzNSGNIC{}            Updates $NicObject
            GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
} #>
<# Process Flow {
    function
        Call ManageAzNSG > Get $null
            Call NewAzNSG > Get $null   
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzNSG > Send $RGObject
            End NewAzNSG
                Return ManageAzNSG > Send $null
            Call ListAzNSG > Get $null
            End ListAzNSG
                Return ManageAzNSG > Send $null
            Call RemoveNSG > Get $null
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return RemoveNSG > Send $NSGObject
            End RemoveNSG
                Return ManageAzNSG > Send $null                 
            Call ManageAzNSGRule > Get $null
                Call NewAzNSGRule > Get $null
                    Call GetAzNSG > Get $NSGObject
                    End GetAzNSG
                        Return NewAzNSGRule > Send $NSGObject
                    Call SetAzNSGRuleProtocol > Get $NSGRuleProtocol
                    End SetAzNSGRuleProtocol
                        Return NewAzNSGRule > Send $NSGRuleProtocol
                    Call SetAzNSGRuleAccess > Get $NSGRuleAccess
                    End SetAzNSGRuleAccess
                        Return NewAzNSGRule > Send $NSGRuleAccess
                    Call SetAzNSGRuleDirection > Get $NSGRuleDirection
                    End SetAzNSGRuleDirection
                        Return NewAzNSGRule > Send $NSGRuleDirection
                    SetAzNSGRulePriority > Get $NSGRulePriority
                    End SetAzNSGRulePriority
                        Return NewAzNSGRule > Send $NSGRulePriority
                    Call SetAzNSGRuleSPortRange > Get $NSGRuleSPRange
                    End SetAzNSGRuleSPortRange
                        Return NewAzNSGRule > Send $NSGRuleSPRange
                    Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
                    End SetAzNSGRuleDPortRange
                        Return NewAzNSGRule > Send $NSGRuleDPRange
                    Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
                        Call SetIPAddress > Get $IPAddress
                        End SetIPAddress
                            Return SetAzNSGRuleAddPrefix > Send $IPAddress
                        Call SetCIDRAddress > Get $CIDRAddress
                        End SetCIDRAddress
                            Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
                    End SetAzNSGRuleAddPrefix
                        Return NewAzNSGRule > Send $NSGRuleAddPrefix
                    Call GetAzASG > Get $ASGObject
                    End GetAzASG
                        Return NewAzNSGRule > Send $ASGObject                
                End NewAzNSGRule
                    Return ManageAzNSGRule > Send $null        
                Call ListAzNSGRule > Get $null
                    Call GetAzNSG > Get $NSGObject
                    End GetAzNSG
                        Return ListAzNSGRule > Send $NSGObject
                End ListAzNSGRule
                    Return ManageAzNSGRule > Send $null
                Call ListAzAllNSGsRule > Get $null
                End ListAzAllNSGsRule
                    Return ManageAzNSGRule > Send $null
                Call RemoveAzNSGRule > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return RemoveAzNSGRule > Send $NSGRuleObject, $NSGObject
                End RemoveAzNSGRule
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRAccess > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRAccess > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRAccess > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleAccess > Get $NSGRuleAccess
                    End SetAzNSGRuleAccess
                        Return UpdateAzNSGRAccess > Send $NSGRuleAccess
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRAccess > Send $null
                End UpdateAzNSGRAccess
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRDirection > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRDirection > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRDirection > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleDirection > Get $NSGRuleDirection
                    End SetAzNSGRuleDirection
                        Return UpdateAzNSGRDirection > Send $NSGRuleDirection
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRDirection > Send $null
                End UpdateAzNSGRDirection
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRPriority > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRPriority > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRPriority > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRulePriority > Get $NSGRulePriority
                    End SetAzNSGRulePriority
                        Return UpdateAzNSGRPriority > Send $NSGRulePriority
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRPriority > Send $null
                End UpdateAzNSGRPriority
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRProtocol > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRProtocol > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRProtocol > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleProtocol > Get $NSGRuleProtocol
                    End SetAzNSGRuleProtocol
                        Return UpdateAzNSGRProtocol > Send $NSGRuleProtocol
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRProtocol > Send $null
                End UpdateAzNSGRProtocol
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRSPRange > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRSPRange > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRSPRange > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleSPortRange > Get $NSGRuleSPRange
                    End SetAzNSGRuleSPortRange
                        Return UpdateAzNSGRSPRange > Send $NSGRuleSPRange
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRSPRange > Send $null
                End UpdateAzNSGRSPRange
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRDPRange > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRDPRange > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRDPRange > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
                    End SetAzNSGRuleDPortRange
                        Return UpdateAzNSGRDPRange > Send $NSGRuleDPRange
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRDPRange > Send $null
                End UpdateAzNSGRDPRange
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRSAddPrefix > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRSAddPrefix > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRSAddPrefix > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
                        Call SetIPAddress > Get $IPAddress
                        End SetIPAddress
                            Return SetAzNSGRuleAddPrefix > Send $IPAddress
                        Call SetCIDRAddress > Get $CIDRAddress
                        End SetCIDRAddress
                            Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
                    End SetAzNSGRuleAddPrefix
                        Return UpdateAzNSGRSAddPrefix > Send $NSGRuleAddPrefix                
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRSAddPrefix > Send $null
                End UpdateAzNSGRSAddPrefix
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRDAddPrefix > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRDAddPrefix > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRDAddPrefix > Send $NSGRuleObject, $NSGObject
                    Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
                        Call SetIPAddress > Get $IPAddress
                        End SetIPAddress
                            Return SetAzNSGRuleAddPrefix > Send $IPAddress
                        Call SetCIDRAddress > Get $CIDRAddress
                        End SetCIDRAddress
                            Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
                    End SetAzNSGRuleAddPrefix
                        Return UpdateAzNSGRDAddPrefix > Send $NSGRuleAddPrefix                
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRDAddPrefix > Send $null
                End UpdateAzNSGRDAddPrefix
                    Return ManageAzNSGRule > Send $null            
                Call UpdateAzNSGRSAppSecG > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRSAppSecG > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRSAppSecG > Send $NSGRuleObject, $NSGObject
                    Call GetAzASG > Get $ASGObject
                    End GetAzASG
                        Return UpdateAzNSGRSAppSecG > Send $ASGObject
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRSAppSecG > Send $null
                End UpdateAzNSGRSAppSecG
                    Return ManageAzNSGRule > Send $null
                Call UpdateAzNSGRDAppSecG > Get $null
                    Call GetAzAllNSGsRule > Get $NSGRuleObject, $NSGObject
                    End GetAzAllNSGsRule
                        Return UpdateAzNSGRDAppSecG > Send $NSGRuleObject, $NSGObject
                    Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
                        Call GetAzNSG > Get $NSGObject
                        End GetAzNSG
                            Return GetAzNSGRule > Send $NSGObject
                    End GetAzNSGRule
                        Return UpdateAzNSGRDAppSecG > Send $NSGRuleObject, $NSGObject
                    Call GetAzASG > Get $ASGObject
                    End GetAzASG
                        Return UpdateAzNSGRDAppSecG > Send $ASGObject
                    Call UpdateAzNSGRuleConfig > Get $null
                    End UpdateAzNSGRuleConfig
                        Return UpdateAzNSGRDAppSecG > Send $null
                End UpdateAzNSGRDAppSecG
                    Return ManageAzNSGRule > Send $null
            End ManageAzNSGRule 
                Return ManageAzNSG > Send $null
            Call ManageAzNSGNIC > Get $null
                Call AddAzNSGNIC > Get $null
                    Call GetAzNSG > Get $NSGObject
                    End GetAzNSG
                        Return AddAzNSGNIC > Send $NSGObject
                    Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
                    End GetAzNetworkInterface
                        Return AddAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
                End AddAzNSGNIC
                    Return ManageAzNSGNIC > Send $null
                Call ListAzNSGNIC > Get $null
                End ListAzNSGNIC
                    Return ManageAzNSGNIC > Send $null
                Call RemoveAzNSGNIC > Get $null
                    Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
                    End GetAzNetworkInterface
                        Return RemoveAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
                End RemoveAzNSGNIC
                    Return ManageAzNSGNIC > Send $null                
            End ManageAzNSGNIC
                Return ManageAzNSG > Send $null
        End ManageAzNSG
            Return function > Send $null
}#>
function ManageAzNSG {                                                                      # Function to manage network security groups
    Begin {                                                                                 # Begin function
        :ManageAzureNSG while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Manage Network Security Groups'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Network Security Group'                                     # Write message to screen
            Write-Host '[2] List Network Security Groups'                                   # Write message to screen
            Write-Host '[3] Remove Network Security Group'                                  # Write message to screen
            Write-Host '[4] Manage NSG Rules'                                               # Write message to screen
            Write-Host '[5] Manage NSG NIC Associations'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureNSG                                                        # Breaks :ManageAzureNSG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Network Security Group'                                     # Write message to screen
                NewAzNSG                                                                    # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Network Security Groups'                                   # Write message to screen
                ListAzNSG                                                                   # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Network Security Group'                                  # Write message to screen
                RemoveNSG                                                                   # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage NSG Rules'                                               # Write message to screen
                ManageAzNSGRule                                                             # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage NSG NIC Associations'                                    # Write message to screen
                ManageAzNSGNIC                                                              # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBNSG
function NewAzNSG {                                                                         # Function to create a new network security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNSG'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNSG while ($true) {                                                        # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureNSG                                                           # Breaks :NewAzureNSG
            }                                                                               # End if (!$RGObject)
            $RGName = $RGObject.ResourceGroupName                                           # Isolates the resource group name
            $RGLoc = $RGObject.Location                                                     # Isolates the resource group location
            $CurrentNSGNames = (Get-AzNetworkSecurityGroup -ResourceGroupName $RGName).Name # Gets list of all network security groups on $RGObject
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureNSGName while ($true) {                                                # Inner loop to set the NSG name
                Write-Host 'NSG name must be between 2 and 64 characters'                   # Write message to screen
                Write-Host 'NSG name must begin with a letter or number'                    # Write message to screen
                Write-Host 'NSG name must end with a letter, number, or -'                  # Write message to screen
                Write-Host 'NSG name body must be a letter, number, or _ . -'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                if ($CurrentNSGNames) {                                                     # If $CurrentNSGNames has a value
                    Write-Host 'The following names are already in use on:'$RGName          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CurrentNSGNames) {                                      # For each item in $CurrentNSGNames
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $CurrentNSGNames)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CurrentNSGNames)
                Write-Host 'Enter the name of the new network security group'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                $NSGName = Read-Host 'Name'                                                 # Operator input for the NSG name
                Clear-Host                                                                  # Clears screen
                $NSGNameArray = $NSGName.ToCharArray()                                      # Converts $NSGName to array
                if ($NSGName -in $CurrentNSGNames) {                                        # If $NSGName is in $CurrentNSGNames
                    Write-Host $NSGName' is already in use'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGName -in $CurrentNSGNames)
                if ($NSGName.Length -lt 2 -or $NSGName.Length -gt 64) {                     # If $NSGName.Length less than 2 or $NSGName.Length greater than 64
                    Write-Host 'NSG name must be between 2 and 64 characters'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGName.Length -lt 2 -or $NSGName.Length -gt 64)
                if ($NSGNameArray[0] -notin $VName1st) {                                    # If 0 position of $NSGNameArray[0] is not in $VName1st
                    Write-Host  $NSGNameArray[0]' is not a valid start character'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGNameArray[0] -notin $VName1st)
                foreach ($_ in $NSGNameArray) {                                             # For each item in $NSGNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'NSG name cannot include any spaces'                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid body character'                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NSGName = $null                                                    # Clears $NSGName
                    }                                                                       # End if ($_ -notin $VNameElse)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NSGNameArray[-1] -notin $VNameLast) {                                  # If last position of $NSGNameArray is not in $VNameLast
                    Write-Host  $NSGNameArray[-1]' is not a valid end character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGName = $null                                                        # Clears $NSGName
                }                                                                           # End if ($NSGNameArray[-1] -notin $VNameLast)
                $NSGNameArray = $null                                                       # Clears $NSGNameArray
                if ($NSGName) {                                                             # If $NSGName has a value
                    Write-Host 'Use:'$NSGName' as the network security group name'          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the network security group name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGName                                               # Breaks :SetAzureNSGName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSG                                                   # Breaks :NewAzureNSG
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($NSGName)
                else {                                                                      # Else if $NSGName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NSGName))
            }                                                                               # End :SetAzureNSGName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the network security group'                            # Write message to screen
                New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName `
                    $RGName -Location $RGLoc -Force -ErrorAction 'Stop' | Out-Null          # Creates the network securit group
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureNSG                                                           # Breaks :NewAzureNSG
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The network security group has been created'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNSG                                                               # Breaks :NewAzureNSG
        }                                                                                   # End :NewAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzNSG 
function ListAzNSG {                                                                        # Function to list all network security groups
    Begin {                                                                                 # Begin function
        :ListAzureNSG while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSG                                                          # Breaks :ListAzureNSG
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:          '$_.Name                                    # Write message to screen
                Write-Host 'Rule RG:            '$_.RG                                      # Write message to screen
                Write-Host 'Rule Loc:           '$_.Location                                # Write message to screen
                Write-Host 'Sec Rules Count:    '$_.SrulesCount                             # Write message to screen
                Write-Host 'Default Rules Count:'$_.DRulesCount                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSG                                                              # Breaks :ListAzureNSG
        }                                                                                   # End :ListAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzNSG
function GetAzNSG {                                                                         # Function to get a network security group
    Begin {                                                                                 # Begin function
        :GetAzureNSG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSG                                                           # Breaks :GetAzureNSG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNSG while ($true) {                                                 # Inner loop for selecting the network security group
                Write-Host '[0]                  Exit'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                 "$_.Name                      # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:            '$_.RG                                  # Write message to screen
                    Write-Host 'Rule Loc:           '$_.Location                            # Write message to screen
                    Write-Host 'Sec Rules Count:    '$_.SrulesCount                         # Write message to screen
                    Write-Host 'Default Rules Count:'$_.DRulesCount                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the network security group for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the network security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNSG                                                       # Breaks :GetAzureNSG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full network security group object
                    Return $NSGObject                                                       # Returns to calling function with network security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureNSG while ($true)
        }                                                                                   # End :GetAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzNSG
function RemoveNSG {                                                                        # Function to remove a network security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveNSG'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNSG while ($true) {                                                     # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End if (!$NSGObject)
            Write-Host 'Remove the following network security group'                        # Write message to screen
            Write-Host 'NSG Name:'$NSGObject.name                                           # Write message to screen
            Write-Host 'NSG RG:  '$NSGObject.ResourceGroupName                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the network security group
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the network security group'                            # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzNetworkSecurityGroup -Name $NSGObject.Name -ResourceGroupName `
                        $NSGObject.ResourceGroupName -Force -ErrorAction 'Stop' | Out-Null  # Removes the network securit group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSG                                                    # Breaks RemoveAzureNSG
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The network security group has been removed'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other input for $OpConfirm
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSG                                                        # Breaks RemoveAzureNSG
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveNSG
# Functions for ManageAzNSGRule
function ManageAzNSGRule {                                                                  # Function to manage network security group rules
    Begin {                                                                                 # Begin function
        :ManageAzureNSGRule while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Network Security Group Rules'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host '[1]  New NSG Rule'                                                  # Write message to screen
            Write-Host '[2]  List NSG Rules'                                                # Write message to screen
            Write-Host '[3]  List All NSG Rules'                                            # Write message to screen
            Write-Host '[4]  Remove NSG Rule'                                               # Write message to screen
            Write-Host '[5]  Update NSG Rule Access'                                        # Write message to screen
            Write-Host '[6]  Update NSG Rule Direction'                                     # Write message to screen
            Write-Host '[7]  Update NSG Rule Priority'                                      # Write message to screen
            Write-Host '[8]  Update NSG Rule Protocol'                                      # Write message to screen
            Write-Host '[9]  Update NSG Rule Source Port Range'                             # Write message to screen
            Write-Host '[10] Update NSG Rule Destination Port Range'                        # Write message to screen
            Write-Host '[11] Update NSG Rule Source Address Prefix'                         # Write message to screen
            Write-Host '[12] Update NSG Rule Destination Address Prefix'                    # Write message to screen
            Write-Host '[13] Update NSG Rule Source App Sec Group'                          # Write message to screen
            Write-Host '[14] Update NSG Rule Destination App Sec Group'                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureNSGRule                                                    # Breaks :ManageAzureNSGRule
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New NSG Rule'                                                   # Write message to screen
                NewAzNSGRule                                                                # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List NSG Rules'                                                 # Write message to screen
                ListAzNSGRule                                                               # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List All NSG Rules'                                             # Write message to screen
                ListAzAllNSGsRule                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove NSG Rule'                                                # Write message to screen
                RemoveAzNSGRule                                                             # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Update NSG Rule Access'                                         # Write message to screen
                UpdateAzNSGRAccess                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Update NSG Rule Direction'                                      # Write message to screen
                UpdateAzNSGRDirection                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Update NSG Rule Priority'                                       # Write message to screen
                UpdateAzNSGRPriority                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Update NSG Rule Protocol'                                       # Write message to screen
                UpdateAzNSGRProtocol                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '8')
            elseif ($OpSelect -eq '9') {                                                    # Else if $OpSelect equals '9'
                Write-Host 'Update NSG Rule Source Port Range'                              # Write message to screen
                UpdateAzNSGRSPRange                                                         # Calls function
            }                                                                               # elseif ($OpSelect -eq '9')
            elseif ($OpSelect -eq '10') {                                                   # Else if $OpSelect equals '10'
                Write-Host 'Update NSG Rule Destination Port Range'                         # Write message to screen
                UpdateAzNSGRDPRange                                                         # Calls function
            }                                                                               # elseif ($OpSelect -eq '10')
            elseif ($OpSelect -eq '11') {                                                   # Else if $OpSelect equals '11'
                Write-Host 'Update NSG Rule Source Address Prefix'                          # Write message to screen
                UpdateAzNSGRSAddPrefix                                                      # Calls function
            }                                                                               # elseif ($OpSelect -eq '11')
            elseif ($OpSelect -eq '12') {                                                   # Else if $OpSelect equals '12'
                Write-Host 'Update NSG Rule Destination Address Prefix'                     # Write message to screen
                UpdateAzNSGRDAddPrefix                                                      # Calls function
            }                                                                               # elseif ($OpSelect -eq '12')
            elseif ($OpSelect -eq '13') {                                                   # Else if $OpSelect equals '13'
                Write-Host 'Update NSG Rule Source App Sec Group'                           # Write message to screen
                UpdateAzNSGRSAppSecG                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '13')
            elseif ($OpSelect -eq '14') {                                                   # Else if $OpSelect equals '14'
                Write-Host 'Update NSG Rule Destination App Sec Group'                      # Write message to screen
                UpdateAzNSGRDAppSecG                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '14')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNSGRule
function NewAzNSGRule {                                                                     # Function to create a new network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzNSGRule'                                               # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureNSGRuleName while ($true) {                                            # Inner loop to set the rule name
                Write-Host 'NSG name must be between 1 and 80 characters'                   # Write message to screen
                Write-Host 'NSG name must begin with a letter or number'                    # Write message to screen
                Write-Host 'NSG name must end with a letter, number, or -'                  # Write message to screen
                Write-Host 'NSG name body must be a letter, number, or _ . -'               # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                if ($CRules) {                                                              # If $CRules has a value
                    Write-Host 'The following names are already in use on:'$NSGObject.Name  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CRules) {                                               # For each item in $CRules
                        Write-Host $_.name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $CRules)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CRules)
                Write-Host 'Enter the name of the new network security group rule'          # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                $NSGRuleName = Read-Host 'Name'                                             # Operator input for the NSG rule name
                Clear-Host                                                                  # Clears screen
                $NSGNameArray = $NSGRuleName.ToCharArray()                                  # Converts $NSGRuleName to array
                if ($NSGRuleName -in $CRules.Name) {                                        # If $NSGRuleName is in $CRules.Name
                    Write-Host $NSGRuleName' is already in use'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName -in $CRules.Name)
                if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80) {             # If $NSGRuleName.Length less than 1 or $NSGRuleName.Length greater than 80
                    Write-Host 'NSG name must be between 1 and 80 characters'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGRuleName.Length -lt 1 -or $NSGRuleName.Length -gt 80)
                if ($NSGNameArray[0] -notin $VName1st) {                                    # If 0 position of $NSGNameArray is not in $VName1st
                    Write-Host  $NSGNameArray[0]' is not a valid start character'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[0] -notin $VName1st)
                foreach ($_ in $NSGNameArray) {                                             # For each item in $NSGNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'NSG name cannot include any spaces'                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid body character'                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NSGRuleName = $null                                                # Clears $NSGRuleName
                    }                                                                       # End if ($_ -notin $VNameElse)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NSGNameArray[-1] -notin $VNameLast) {                                  # If last position of $NSGNameArray is not in $VNameLast
                    Write-Host  $NSGNameArray[-1]' is not a valid end character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NSGRuleName = $null                                                    # Clears $NSGRuleName
                }                                                                           # End if ($NSGNameArray[-1] -notin $VNameLast)
                $NSGNameArray = $null                                                       # Clears $NSGNameArray
                if ($NSGRuleName) {                                                         # If $NSGRuleName has a value
                    Write-Host 'Use:'$NSGRuleName' as the NSG rule name'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the network security group name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureNSGRuleName                                           # Breaks :SetAzureNSGRuleName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureNSGRule                                               # Breaks :NewAzureNSGRule
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($NSGRuleName)
                else {                                                                      # Else if $NSGRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NSGRuleName))
            }                                                                               # End :SetAzureNSGRuleName while ($true)
            $NSGRuleProtocol = SetAzNSGRuleProtocol                                         # Calls function and assigns output to $var
            if (!$NSGRuleProtocol) {                                                        # If $NSGRuleProtocol is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleProtocol)
            $NSGRuleAccess = SetAzNSGRuleAccess                                             # Calls function and assigns output to $var
            if (!$NSGRuleAccess) {                                                          # If $NSGRuleAccess is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule    
            }                                                                               # End if (!$NSGRuleAccess)
            $NSGRuleDirection = SetAzNSGRuleDirection                                       # Calls function and assigns output to $var
            if (!$NSGRuleDirection) {                                                       # If $NSGRuleDirection is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDirection)            
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            $NSGRulePriority = SetAzNSGRulePriority ($NSGObject, $NSGRuleDirection, $CRules)# Calls function and assigns output to $var
            if (!$NSGRulePriority) {                                                        # If NSGRulePriority is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                    
            }                                                                               # End if (!$NSGRulePriority)
            $NSGRuleSPRange = SetAzNSGRuleSPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleSPRange) {                                                         # If $NSGRuleSPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleSPRange)
            $NSGRuleDPRange = SetAzNSGRuleDPortRange                                        # Calls function and assigns output to $var
            if (!$NSGRuleDPRange) {                                                         # If $NSGRuleDPRange is $null
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule                                                       
            }                                                                               # End if (!$NSGRuleDPRange)
            :SetNSGRuleSourceAdd while ($true) {                                            # Inner loop for setting the rule source config
                Write-Host 'Rule source config'                                             # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Address prefix'                                             # Write message to screen
                Write-Host '[2] App Sec Group'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the source type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if ($OpSelect equals '1'
                    $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)            # Calls function and assigns output to $var
                    if ($NSGRuleAddPrefix) {                                                # If $NSGRuleAddPrefix has a value                          
                        $NSGRuleSAPrefix = $NSGRuleAddPrefix                                # $NSGRuleSAPrefix is equal to $NSGRuleAddPrefix 
                        $NSGRuleAddPrefix = $null                                           # Clears $var
                        Break SetNSGRuleSourceAdd                                           # Breaks :SetNSGRuleSourceAdd           
                    }                                                                       # End if ($NSGRuleAddPrefix)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $ASGObject = GetAzASG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($ASGObject) {                                                       # If $ASGObject has a value
                        $NSGRuleSAppSecG = $ASGObject                                       # $NSGRuleSAppSecG is equal to $ASGObject
                        $ASGObject = $null                                                  # Clears $var
                        Break SetNSGRuleSourceAdd                                           # Breaks :SetNSGRuleSourceAdd           
                    }                                                                       # End if ($ASGObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetNSGRuleSourceAdd while ($true)
            :SetNSGRuleDestinAdd while ($true) {                                            # Inner loop for setting the rule source config
                Write-Host 'Rule destination config'                                        # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Address prefix'                                             # Write message to screen
                Write-Host '[2] App Sec Group'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the source type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if ($OpSelect equals '1'
                    $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)            # Calls function and assigns output to $var
                    if ($NSGRuleAddPrefix) {                                                # If $NSGRuleAddPrefix has a value                          
                        $NSGRuleDAPrefix = $NSGRuleAddPrefix                                # $NSGRuleDAPrefix is equal to $NSGRuleAddPrefix 
                        Break SetNSGRuleDestinAdd                                           # Breaks :SetNSGRuleDestinAdd           
                    }                                                                       # End if ($NSGRuleAddPrefix)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $ASGObject = GetAzASG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($ASGObject) {                                                       # If $ASGObject has a value
                        $NSGRuleDAppSecG = $ASGObject                                       # $NSGRuleDAppSecG is equal to $ASGObject
                        Break SetNSGRuleDestinAdd                                           # Breaks :SetNSGRuleDestinAdd           
                    }                                                                       # End if ($ASGObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetNSGRuleDestinAdd while ($true)
            :ConfirmRule while ($true) {                                                    # Inner loop for confirming all inputs
                Write-Host 'Create the following rule:'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'NSG Name:         '$NSGObject.name                              # Write message to screen
                Write-Host 'Rule Name:        '$NSGRuleName                                 # Write message to screen
                Write-Host 'Protocol:         '$NSGRuleProtocol                             # Write message to screen
                Write-Host 'Access:           '$NSGRuleAccess                               # Write message to screen
                Write-Host 'Direction:        '$NSGRuleDirection                            # Write message to screen
                Write-Host 'Priority:         '$NSGRulePriority                             # Write message to screen
                Write-Host 'Source Config:'                                                 # Write message to screen
                Write-Host '  Port:           '$NSGRuleSPRange                              # Write message to screen
                if ($NSGRuleSAPrefix) {                                                     # If $NSGRuleSAPrefix has a value
                    Write-Host '  Address Prefix: '$NSGRuleSAPrefix                         # Write message to screen
                }                                                                           # End if ($NSGRuleSAPrefix)
                else {                                                                      # Esle if $NSGRuleSAPrefix is $null
                    Write-Host '  App Sec Group:  '$NSGRuleSAppSecG.name                    # Write message to screen    
                }                                                                           # End if ($NSGRuleSAPrefix)
                Write-Host 'Destination Config:'                                            # Write message to screen
                Write-Host '  Port:           '$NSGRuleDPRange                              # Write message to screen
                if ($NSGRuleDAPrefix) {                                                     # If $NSGRuleDAPrefix has a value
                    Write-Host '  Address Prefix: '$NSGRuleDAPrefix                         # Write message to screen
                }                                                                           # End if ($NSGRuleDAPrefix)
                else {                                                                      # Esle if $NSGRuleDAPrefix is $null
                    Write-Host '  App Sec Group:  '$NSGRuleDAppSecG.name                    # Write message to screen    
                }                                                                           # End if ($NSGRuleDAPrefix)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to build the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break ConfirmRule                                                       # Breaks :ConfirmRule
                }                                                                           # End if ($OpConfirm -eq 'y') 
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y') )
            }                                                                               # End :ConfirmRule while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the NSG Rule'                                          # Write message to screen
                if ($NSGRuleSAPrefix -and $NSGRuleDAPrefix) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceAddressPrefix $NSGRuleSAPrefix `
                        -DestinationAddressPrefix $NSGRuleDAPrefix `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAPrefix -and $NSGRuleDAPrefix)
                if ($NSGRuleSAppSecG -and $NSGRuleDAPrefix) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceApplicationSecurityGroupId $NSGRuleSAppSecG.ID `
                        -DestinationAddressPrefix $NSGRuleDAPrefix `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAppSecG -and $NSGRuleDAPrefix)
                if ($NSGRuleSAPrefix -and $NSGRuleDAppSecG) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceAddressPrefix $NSGRuleSAPrefix `
                        -DestinationApplicationSecurityGroupId $NSGRuleDAppSecG.ID `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAPrefix -and $NSGRuleDAppSecG)
                if ($NSGRuleSAppSecG -and $NSGRuleDAppSecG) {
                    Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleName -Protocol $NSGRuleProtocol -Access `
                        $NSGRuleAccess -Direction $NSGRuleDirection -Priority `
                        $NSGRulePriority -SourcePortRange $NSGRuleSPRange `
                        -DestinationPortRange $NSGRuleDPRange `
                        -SourceApplicationSecurityGroupId $NSGRuleSAppSecG.ID `
                        -DestinationApplicationSecurityGroupId $NSGRuleDAppSecG.ID `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the NSG rule
                }                                                                           # End if ($NSGRuleSAppSecG -and $NSGRuleDAppSecG)
                Write-Host 'Saving the network security group'                              # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves NSG config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureNSGRule                                                       # Breaks :NewAzureNSGRule
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'An the NSG rule has been created'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureNSGRule                                                           # Breaks :NewAzureNSGRule
        }                                                                                   # End :NewAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End NewAzNSGRule
Function SetAzNSGRuleProtocol {                                                             # Function to set a network security group rule protocol
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleProtocol while ($true) {                                            # Inner loop to set the rule protocol
            Write-Host 'Select the rule protocol'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] TCP'                                                            # Write message to screen
            Write-Host '[3] UPD'                                                            # Write message to screen
            Write-Host '[4] ICMP'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule port
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleProtocol                                               # Breaks :SetAzureNSGRuleProtocol
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleProtocol = '*'                                                      # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleProtocol = 'TCP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleProtocol = 'UDP'                                                    # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                $NSGRuleProtocol = 'ICMP'                                                   # Sets $NSGRuleProtocol
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleProtocol) {                                                         # If $NSGRuleProtocol has a value
                Return $NSGRuleProtocol                                                     # Returns to calling function with $NSGRuleProtocol
            }                                                                               # End if ($NSGRuleProtocol)
        }                                                                                   # End :SetAzureNSGRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRuleProtocol
Function SetAzNSGRuleAccess {                                                               # Function to set a network security group rule access
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleAccess while ($true) {                                              # Inner loop to set the rule access
            Write-Host 'Select the rule access'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Allow'                                                          # Write message to screen
            Write-Host '[2] Deny'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule access
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAccess                                                 # Breaks :SetAzureNSGRuleAccess
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAccess = 'Allow'                                                    # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleAccess = 'Deny'                                                     # Sets $NSGRuleAccess
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
            if ($NSGRuleAccess) {                                                           # If $NSGRuleAccess has a value
                Return $NSGRuleAccess                                                       # Returns to calling funtion with $NSGRuleAccess
            }                                                                               # End if ($NSGRuleAccess)
        }                                                                                   # End :SetAzureNSGRuleAccess while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleAccess
Function SetAzNSGRuleDirection {                                                            # Function to set a network security group rule direction
    Begin {                                                                                 # Begin function
        :SetAzureNSGRuleDirection while ($true) {                                           # Inner loop to set the rule direction
            Write-Host 'Select the rule direction'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Inbound'                                                        # Write message to screen
            Write-Host '[2] Outbound'                                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of the rule direction
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleDirection                                              # Breaks :SetAzureNSGRuleDirection
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleDirection = 'Inbound'                                               # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $NSGRuleDirection = 'Outbound'                                              # Sets $NSGRuleDirection
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))   
            if ($NSGRuleDirection) {                                                        # If $NSGRuleDirection has a value
                Return $NSGRuleDirection                                                    # Returns to calling function with $NSGRuleDirection
            }                                                                               # End if ($NSGRuleDirection)
        }                                                                                   # End :SetAzureNSGRuleDirection while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function SetAzNSGRuleDirection
Function SetAzNSGRulePriority {                                                             # Function to set a network security group rule priority
    Begin {                                                                                 # Begin function
        if (!$CRules) {                                                                     # If $CRules is $null
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array 
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
        }                                                                                   # End if (!$CRules)
        $ValidArray = '0123456789'                                                          # Creates a string of valid characters
        $ValidArray = $ValidArray.ToCharArray()                                             # Loads all valid characters into array    
        :SetAzureNSGRulePriority while ($true) {                                            # Inner loop to set the rule priority
            Write-Host 'NSG Rule priority'                                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule priority must be between the values of 100 and 4096'           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($CRules.Direction -eq $NSGRuleDirection) {                                  # If $CRules.Direction equals $NSGRuleDirection
                Write-Host 'The following priorities are'                                   # Write message to screen
                Write-Host 'already in use for'$NSGRuleDirection' traffic'                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $CRules) {                                                   # For each item in $CRules
                    if ($_.Direction -eq $NSGRuleDirection) {                               # If current item .Direction equals $NSGRuleDirection
                        Write-Host $_.Priority                                              # Write message to screen
                    }                                                                       # if ($_.Direction -eq $NSGRuleDirection)
                }                                                                           # End foreach ($_ in $CRules)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($CRules.Direction -eq $NSGRuleDirection)
            $NSGRulePriority = Read-Host 'Rule priority'                                    # Operator input for the rule priority
            Clear-Host                                                                      # Clears screen
            $NSGRuleArray = $NSGRulePriority.ToCharArray()                                  # Converts $NSGRulePriority into array
            foreach ($_ in $NSGRuleArray) {                                                 # For each item in $NSGRuleArray
                if ($_ -notin $ValidArray) {                                                # If current item is not in $ValidArray
                    $NSGRulePriority = $null                                                # Clears $var
                }                                                                           # End if ($_ -notin $ValidArray)
            }                                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
            $NSGRuleArray = $null                                                           # Clears $var
            $NSGRuleDirPri = $NSGRuleDirection+' '+$NSGRulePriority                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $NSGRulePriority                     
            if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                                   # If $NSGRuleDirPri is in $ObjectArray.DirPri
                Write-Host 'This priority is already in use for'$NSGRuleDirection           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please select a different priority'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $NSGRulePriority = $null                                                    # Clears $var
            }                                                                               # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
            $NSGRuleInt = [INT]$NSGRulePriority                                             # Converts $NSGRulePriority to integer
            if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096) {                             # if $NSGRuleInt is not between 100 and 4096
                Write-Host 'Rule priority must be between the values of 100 and 4096'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                $NSGRulePriority = $null                                                    # Clears $var
                $NSGRuleInt = $null                                                         # Clears $var
                $NSGRuleDirPri = $null                                                      # Clears $var
                Clear-Host                                                                  # Clears screen
            }                                                                               # End if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096)                                                                    
            else {                                                                          # Else if $NSGRuleInt is between 100 and 4096
                Write-Host 'Use:'$NSGRulePriority' as the rule priority'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the rule priority
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Return $NSGRulePriority                                                 # Returns to calling function with $NSGRulePriority
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'e')
                else {                                                                      # All other inputs for $OpConfirm
                    $NSGRulePriority = $null                                                # Clears $var
                    $NSGRuleInt = $null                                                     # Clears $var
                    $NSGRuleDirPri = $null                                                  # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096))
        }                                                                                   # End :SetAzureNSGRulePriority while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRulePriority
Function SetAzNSGRuleSPortRange {                                                           # Function to set a network security rule source port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleSPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule source port range
                Write-Host 'NSG Rule Source Port Range'                                     # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the source port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleSPRange                                            # Breaks :SetAzureNSGRuleSPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleSPRange = '*'                                                   # Sets $NSGRuleSPRange
                    Return $NSGRuleSPRange                                                  # Returns to calling function with $NSGRuleSPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single source port
                        Write-Host 'Enter the source port'                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleSPRange = Read-Host 'Port #'                                # Operator input for the source port number
                        $NSGRuleArray = $NSGRuleSPRange.ToCharArray()                       # Converts $NSGRuleSPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            $NSGInt = [INT]$NSGRuleSPRange                                  # Converts $NSGRuleSPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleSPRange)
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleSPRange' as the source port'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the source port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleSPRange)
                        else {                                                              # Else if $NSGRuleSPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleSPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleSPList = @()                                                    # Creates $NSGRuleSPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple source ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the source port'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleSPAdd = Read-Host 'Port #'                              # Operator input for the source port number
                            $NSGRuleArray = $NSGRuleSPAdd.ToCharArray()                     # Converts $NSGRuleSPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                $NSGInt = [INT]$NSGRuleSPAdd                                # Converts $NSGRuleSPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleSPAdd)
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleSPAdd' to source port list'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleSPRange)
                            else {                                                          # Else if $NSGRuleSPRange is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleSPRange))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleSPList += $NSGRuleSPAdd                                     # Adds $NSGRuleSPAdd to $NSGRuleSPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule source ports
                            Write-Host 'Current source port list:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleSPList) {                                # For each item in $NSGRuleSPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleSPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleSPRange = $NSGRuleSPList                            # $NSGRuleSPRange is equal to $NSGRuleSPList 
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleSPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a source port range
                        :SetAzureNSGRSPortStart while ($true) {                             # Inner loop for settings a source port start
                            Write-Host 'Enter the source port range start '                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the source port range start
                            $NSGRuleArray = $SPRangeStart.ToCharArray()                     # Converts $SPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                $NSGInt = [INT]$SPRangeStart                                # Converts $SPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeStart)
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeStart' for source port range start' # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortStart                            # Breaks :SetAzureNSGRSPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeStart)
                            else {                                                          # Else if $SPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeStart))
                        }                                                                   # End :SetAzureNSGRSPortStart while ($true)
                        :SetAzureNSGRSPortEnd while ($true) {                               # Inner loop for settings a source port end
                            Write-Host 'Enter the source port range end '                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the source port range end
                            $NSGRuleArray = $SPRangeEnd.ToCharArray()                       # Converts $SPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                $NSGInt = [INT]$SPRangeEnd                                  # Converts $SPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeEnd)
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeEnd' for source port range end'     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortEnd                              # Breaks :SetAzureNSGRSPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeEnd)
                            else {                                                          # Else if $SPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeEnd))
                        }                                                                   # End :SetAzureNSGRSPortEnd while ($true)
                        $NSGRuleSPRange = $SPRangeStart+'-'+$SPRangeEnd                     # $NSGRuleSPRange is equal to5 $SPRangeStart and $SPRangeEnd       
                        Write-Host 'Use'$NSGRuleSPRange' as the source port range'          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the source port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleSPRange                                          # Returns to calling function with $NSGRuleSPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleSPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleSPortRange
Function SetAzNSGRuleDPortRange {                                                           # Function to set a network security rule destination port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleDPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule destination port range
                Write-Host 'NSG Rule Destination Port Range'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the destination port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleDPRange                                            # Breaks :SetAzureNSGRuleDPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleDPRange = '*'                                                   # Sets $NSGRuleDPRange
                    Return $NSGRuleDPRange                                                  # Returns to calling function with $NSGRuleDPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single destination port
                        Write-Host 'Enter the destination port'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleDPRange = Read-Host 'Port #'                                # Operator input for the destination port number
                        $NSGRuleArray = $NSGRuleDPRange.ToCharArray()                       # Converts $NSGRuleDPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            $NSGInt = [INT]$NSGRuleDPRange                                  # Converts $NSGRuleDPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleDPRange)
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleDPRange' as the destination port'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the destination port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleDPRange)
                        else {                                                              # Else if $NSGRuleDPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleDPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleDPList = @()                                                    # Creates $NSGRuleDPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple destination ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the destination port'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleDPAdd = Read-Host 'Port #'                              # Operator input for the destination port number
                            $NSGRuleArray = $NSGRuleDPAdd.ToCharArray()                     # Converts $NSGRuleDPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                $NSGInt = [INT]$NSGRuleDPAdd                                # Converts $NSGRuleDPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleDPAdd)
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleDPAdd' to destination port list'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleDPAdd)
                            else {                                                          # Else if $NSGRuleDPAdd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPAdd))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleDPList += $NSGRuleDPAdd                                     # Adds $NSGRuleDPAdd to $NSGRuleDPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule destination ports
                            Write-Host 'Current destination port list:'                     # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleDPList) {                                # For each item in $NSGRuleDPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleDPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleDPRange = $NSGRuleDPList                            # $NSGRuleDPRange is equal to $NSGRuleDPList 
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleDPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a destination port range
                        :SetAzureNSGRDPortStart while ($true) {                             # Inner loop for settings a destination port start
                            Write-Host 'Enter the destination port range start '            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the destination port range start
                            $NSGRuleArray = $DPRangeStart.ToCharArray()                     # Converts $DPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                $NSGInt = [INT]$DPRangeStart                                # Converts $DPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeStart)
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeStart' for destination port range start'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortStart                            # Breaks :SetAzureNSGRDPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeStart)
                            else {                                                          # Else if $DPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPRange))
                        }                                                                   # End :SetAzureNSGRDPortStart while ($true)
                        :SetAzureNSGRDPortEnd while ($true) {                               # Inner loop for settings a destination port end
                            Write-Host 'Enter the destination port range end '              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the destination port range end
                            $NSGRuleArray = $DPRangeEnd.ToCharArray()                       # Converts $DPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                $NSGInt = [INT]$DPRangeEnd                                  # Converts $DPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeEnd)
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeEnd' for destination port range end'       # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortEnd                              # Breaks :SetAzureNSGRDPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeEnd)
                            else {                                                          # Else if $DPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($DPRangeEnd))
                        }                                                                   # End :SetAzureNSGRDPortEnd while ($true)
                        $NSGRuleDPRange = $DPRangeStart+'-'+$DPRangeEnd                     # $NSGRuleDPRange is equal to5 $DPRangeStart and $DPRangeEnd       
                        Write-Host 'Use'$NSGRuleDPRange' as the destination port range'     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the destination port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleDPRange                                          # Returns to calling function with $NSGRuleDPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleDPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleDPortRange
Function SetAzNSGRuleAddPrefix {                                                            # Function to set a network security rule address prefix
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleAddPrefix while ($true) {                                           # Outer loop for managing function
            Write-Host 'NSG Rule Address Prefix'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] Single IP Address'                                              # Write message to screen
            Write-Host '[3] Multiple IP Addresses'                                          # Write message to screen
            Write-Host '[4] CIDR Block'                                                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the address prefix method
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAddPrefix                                              # Breaks :SetAzureNSGRuleAddPrefix
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAddPrefix = '*'                                                     # Sets $NSGRuleAddPrefix
                Return $NSGRuleAddPrefix                                                    # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for settings a single IP address prefix
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$IPAddress) {                                                      # If $IPAddress does not have a value
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$IPAddress)
                    else {                                                                  # If $IPAddress has a value
                        $NSGRuleAddPrefix = $IPAddress                                      # $NSGRuleAddPrefix is equal to $IPAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$IPAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleAddPrefix = @()                                                     # Creates $NSGRuleAddPrefix        
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for setting multiple address prefix values
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if ($IPAddress) {                                                       # If $IPAddress haa a value
                        Clear-Host                                                          # Clears screen
                        Write-Host 'Add:'$IPAddress' Address prefix list'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpSelect -eq 'y'
                            $NSGRuleAddPrefix += $IPAddress                                 # Adds $IPAddres to $NSGRuleAddPrefix
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpSelect -eq 'e'
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpConfirm -eq 'e')    
                    }                                                                       # End if ($IPAddress)
                    :ConfirmAddressPrefixList while ($true) {                               # Inner loop for confirming the IP address list
                        Write-Host 'Current IP addres prefix list'                          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        foreach ($_ in $NSGRuleAddPrefix) {                                 # For each item in $NSGRuleAddPrefix
                            Write-Host $_                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NSGRuleAddPrefix)
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Add another IP address'                                 # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input to add another IP
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break ConfirmAddressPrefixList                                  # Breaks :ConfirmAddressPrefixList
                        }                                                                   # End if ($OpSelect -eq 'y')
                        elseif ($OpSelect -eq 'n') {                                        # Else if $OpSelect equals 'n'
                            Return $NSGRuleAddPrefix                                        # Returns to calling function with $var
                        }                                                                   # End elseif ($OpSelect -eq 'n')   
                        elseif ($OpSelect -eq 'e') {                                        # Else if $OpSelect equals 'e'        
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpSelect -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End :ConfirmAddressPrefixList while ($true)
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for getting a CIDR address
                $CIDRAddress = SetCIDRAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$CIDRAddress) {                                                    # If $CIDRAddress is $null
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$CIDRAddress)
                    else {                                                                  # If $CIDRAddress has a value
                        $NSGRuleAddPrefix = $CIDRAddress                                    # $NSGRuleAddPrefix is equal to $CIDRAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$CIDRAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :SetAzureNSGRuleAddPrefix while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleAddPrefix
function ListAzNSGRule {                                                                    # Function to list a network security group rules
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'ListAzNSGRule'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ListAzureNSGRule while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject  # Gets a list of all non-default rules on $NSGObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.SourceApplicationSecurityGroups.ID) {                                # If ($_.SourceApplicationSecurityGroups.ID has a value
                    $SAppSecGID = $_.SourceApplicationSecurityGroups.ID                     # $SAppSecGID is equal to $_.SourceApplicationSecurityGroups.ID
                    $SAppSecGID = $SAppSecGID.Split('/')[-1]                                # Isolates the name of the application security group
                }                                                                           # End if ($_.SourceApplicationSecurityGroups.ID)
                if ($_.DestinationApplicationSecurityGroups.ID) {                           # If ($_.DestinationApplicationSecurityGroups.ID has a value
                    $DAppSecGID = $_.DestinationApplicationSecurityGroups.ID                # DSAppSecGID is equal to $_.DestinationApplicationSecurityGroups.ID
                    $DAppSecGID = $DAppSecGID.Split('/')[-1]                                # Isolates the name of the application security group
                }                                                                           # End if ($_.DestinationApplicationSecurityGroups.ID)
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule config name
                    'Descript'=$_.Description;                                              # Rule config description
                    'Proto'=$_.Protocol;                                                    # Rule config protocol
                    'SPRange'=$_.SourcePortRange;                                           # Rule config source port range
                    'DPRange'=$_.DestinationPortRange;                                      # Rule config destination port range
                    'SAPrefix'=$_.SourceAddressPrefix;                                      # Rule config source address prefix
                    'DAPrefix'=$_.DestinationAddressPrefix;                                 # Rule config destination address prefix
                    'SASG'=$SAppSecGID;                                                     # Rule config source application security groups
                    'DASG'=$DAppSecGID;                                                     # Rule config destination application security groups
                    'Access'=$_.Access;                                                     # Rule config access
                    'PRI'=$_.Priority;                                                      # Rule config priority
                    'Direction'=$_.Direction                                                # Rule config direction
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $SAppSecGID = $null                                                         # Clears $var
                $DAppSecGID = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on this network security group'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                if ($_.SAPrefix) {                                                          # If $_.SAPrefix has a value
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                }                                                                           # End if ($_.SAPrefix)
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                if ($_.DAPrefix) {                                                          # If $_.DAPrefix has a value
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                }                                                                           # End if ($_.DAPrefix)
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSGRule                                                          # Breaks :ListAzureNSGRule
        }                                                                                   # End :ListAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNSGRule
function ListAzAllNSGsRule {                                                                # Function to list all rules from all network security groupss
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $NSGList = Get-AzNetworkSecurityGroup                                           # Gets a list of all network security groups
            if (!$NSGList) {                                                                # If $NSGList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network security groups exist in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    if ($_.SourceApplicationSecurityGroups.ID) {                            # If ($_.SourceApplicationSecurityGroups.ID has a value
                        $SAppSecGID = $_.SourceApplicationSecurityGroups.ID                 # $SAppSecGID is equal to $_.SourceApplicationSecurityGroups.ID
                        $SAppSecGID = $SAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.SourceApplicationSecurityGroups.ID)
                    if ($_.DestinationApplicationSecurityGroups.ID) {                       # If ($_.DestinationApplicationSecurityGroups.ID has a value
                        $DAppSecGID = $_.DestinationApplicationSecurityGroups.ID            # DSAppSecGID is equal to $_.DestinationApplicationSecurityGroups.ID
                        $DAppSecGID = $DAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.DestinationApplicationSecurityGroups.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Name'=$_.Name;                                                     # Rule config name
                        'NSGName'=$NSGName;                                                 # Network security group name
                        'NSGRG'=$NSGRG;                                                     # Network security group resource group
                        'Descript'=$_.Description;                                          # Rule config description
                        'Proto'=$_.Protocol;                                                # Rule config protocol
                        'SPRange'=$_.SourcePortRange;                                       # Rule config source port range
                        'DPRange'=$_.DestinationPortRange;                                  # Rule config destination port range
                        'SAPrefix'=$_.SourceAddressPrefix;                                  # Rule config source address prefix
                        'DAPrefix'=$_.DestinationAddressPrefix;                             # Rule config destination address prefix
                        'SASG'=$SAppSecGID;                                                 # Rule config source application security groups
                        'DASG'=$DAppSecGID;                                                 # Rule config destination application security groups
                        'Access'=$_.Access;                                                 # Rule config access
                        'PRI'=$_.Priority;                                                  # Rule config priority
                        'Direction'=$_.Direction                                            # Rule config direction
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Addes $ObjectInput to $ObjectArray
                    $SAppSecGID = $null                                                     # Clears $var
                    $DAppSecGID = $null                                                     # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
                $NSGObject = $null                                                          # Clears $var
                $NSGName = $null                                                            # Clears $var
                $NSGRG = $null                                                              # Clears $var
                $ObjectList = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on any network security groups'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'NSG Name:       '$_.NSGName                                     # Write message to screen
                Write-Host 'Rule RG:        '$_.NSGRG                                       # Write message to screen
                if ($_.Descript) {                                                          # If current item .Descript has a value
                    Write-Host 'Description:    '$_.Descript                                # Write message to screen
                }                                                                           # End if ($_.Descript)
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                if ($_.SAPrefix) {                                                          # If $_.SAPrefix has a value
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                }                                                                           # End if ($_.SAPrefix)
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                if ($_.DAPrefix) {                                                          # If $_.DAPrefix has a value
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                }                                                                           # End if ($_.DAPrefix)
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureNSGRule                                                           # Breaks :GetAzureNSGRule
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzAllNSGsRule
function GetAzAllNSGsRule {                                                                 # Function to get a rule from all network security groups
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $NSGList = Get-AzNetworkSecurityGroup                                           # Gets a list of all network security groups
            if (!$NSGList) {                                                                # If $NSGList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network security groups exist in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList  
                    if ($_.SourceApplicationSecurityGroups.ID) {                            # If ($_.SourceApplicationSecurityGroups.ID has a value
                        $SAppSecGID = $_.SourceApplicationSecurityGroups.ID                 # $SAppSecGID is equal to $_.SourceApplicationSecurityGroups.ID
                        $SAppSecGID = $SAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.SourceApplicationSecurityGroups.ID)
                    if ($_.DestinationApplicationSecurityGroups.ID) {                       # If ($_.DestinationApplicationSecurityGroups.ID has a value
                        $DAppSecGID = $_.DestinationApplicationSecurityGroups.ID            # DSAppSecGID is equal to $_.DestinationApplicationSecurityGroups.ID
                        $DAppSecGID = $DAppSecGID.Split('/')[-1]                            # Isolates the name of the application security group
                    }                                                                       # End if ($_.DestinationApplicationSecurityGroups.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule config name
                        'NSGName'=$NSGName;                                                 # Network security group name
                        'NSGRG'=$NSGRG;                                                     # Network security group resource group
                        'Descript'=$_.Description;                                          # Rule config description
                        'Proto'=$_.Protocol;                                                # Rule config protocol
                        'SPRange'=$_.SourcePortRange;                                       # Rule config source port range
                        'DPRange'=$_.DestinationPortRange;                                  # Rule config destination port range
                        'SAPrefix'=$_.SourceAddressPrefix;                                  # Rule config source address prefix
                        'DAPrefix'=$_.DestinationAddressPrefix;                             # Rule config destination address prefix
                        'SASG'=$SAppSecGID;                                                 # Rule config source application security groups
                        'DASG'=$DAppSecGID;                                                 # Rule config destination application security groups
                        'Access'=$_.Access;                                                 # Rule config access
                        'PRI'=$_.Priority;                                                  # Rule config priority
                        'Direction'=$_.Direction                                            # Rule config direction
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Addes $ObjectInput to $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                    $SAppSecGID = $null                                                     # Clears $var
                    $DAppSecGID = $null                                                     # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
                $NSGObject = $null                                                          # Clears $var
                $NSGName = $null                                                            # Clears $var
                $NSGRG = $null                                                              # Clears $var
                $ObjectList = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on any network security groups'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzNSGRule while ($true) {                                                # Inner loop for selecting the NSG rule
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 0
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'NSG Name:       '$_.NSGName                                 # Write message to screen
                    Write-Host 'Rule RG:        '$_.NSGRG                                   # Write message to screen
                    if ($_.Descript) {                                                      # If current item .Descript has a value
                        Write-Host 'Description:    '$_.Descript                            # Write message to screen
                    }                                                                       # End if ($_.Descript)
                    Write-Host 'Protocol:       '$_.Proto                                   # Write message to screen
                    Write-Host 'Source'                                                     # Write message to screen
                    Write-Host ' Port Range:    '$_.SPRange                                 # Write message to screen
                    if ($_.SAPrefix) {                                                      # If $_.SAPrefix has a value
                        Write-Host ' Address Prefix:'$_.SAPrefix                            # Write message to screen
                    }                                                                       # End if ($_.SAPrefix)
                    if ($_.SASG) {                                                          # If $_.SASG has a value
                        Write-Host ' Security Group:'$_.SASG                                # Write message to screen
                    }                                                                       # End if ($_.SASG)
                    Write-Host 'Destination'                                                # Write message to screen
                    Write-Host ' Port Range:    '$_.DPRange                                 # Write message to screen
                    if ($_.DAPrefix) {                                                      # If $_.DAPrefix has a value
                        Write-Host ' Address Prefix:'$_.DAPrefix                            # Write message to screen
                    }                                                                       # End if ($_.DAPrefix)
                    if ($_.DASG) {                                                          # If $_.DASG has a value
                        Write-Host ' Security Group:'$_.DASG                                # Write message to screen
                    }                                                                       # End if ($_.DASG)
                    Write-Host 'Access:         '$_.Access                                  # Write message to screen
                    Write-Host 'Priority:       '$_.PRI                                     # Write message to screen
                    Write-Host 'Direction:      '$_.Direction                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NSG rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureNSGRule                                                   # Breaks :GetAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.NSGName `
                        -ResourceGroupName $OpSelect.NSGRG
                    $NSGRuleObject = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                        $NSGObject -Name $OpSelect.name
                    Return $NSGRuleObject, $NSGObject                                       # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzNSGRule while ($true)
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzAllNSGsRule
function GetAzNSGRule {                                                                     # Function to get a network security group rule
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject  # Gets a list of all non-default rules on $NSGObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule config name
                    'Descript'=$_.Description;                                              # Rule config description
                    'Proto'=$_.Protocol;                                                    # Rule config protocol
                    'SPRange'=$_.SourcePortRange;                                           # Rule config source port range
                    'DPRange'=$_.DestinationPortRange;                                      # Rule config destination port range
                    'SAPrefix'=$_.SourceAddressPrefix;                                      # Rule config source address prefix
                    'DAPrefix'=$_.DestinationAddressPrefix;                                 # Rule config destination address prefix
                    'SASG'=$_.SourceApplicationSecurityGroups;                              # Rule config source application security groups
                    'DASG'=$_.DestinationApplicationSecurityGroups;                         # Rule config destination application security groups
                    'Access'=$_.Access;                                                     # Rule config access
                    'PRI'=$_.Priority;                                                      # Rule config priority
                    'Direction'=$_.Direction                                                # Rule config direction
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on this network security group'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzNSGRule while ($true) {                                                # Inner loop for selecting the NSG rule
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 0
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    if ($_.Descript) {                                                      # If current item .Descript has a value
                        Write-Host 'Description:    '$_.Descript                            # Write message to screen
                    }                                                                       # End if ($_.Descript)
                    Write-Host 'Protocol:       '$_.Proto                                   # Write message to screen
                    Write-Host 'Source'                                                     # Write message to screen
                    Write-Host ' Port Range:    '$_.SPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                    if ($_.SASG) {                                                          # If $_.SASG has a value
                        Write-Host ' Security Group:'$_.SASG                                # Write message to screen
                    }                                                                       # End if ($_.SASG)
                    Write-Host 'Destination'                                                # Write message to screen
                    Write-Host ' Port Range:    '$_.DPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                    if ($_.DASG) {                                                          # If $_.DASG has a value
                        Write-Host ' Security Group:'$_.DASG                                # Write message to screen
                    }                                                                       # End if ($_.DASG)
                    Write-Host 'Access:         '$_.Access                                  # Write message to screen
                    Write-Host 'Priority:       '$_.PRI                                     # Write message to screen
                    Write-Host 'Direction:      '$_.Direction                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NSG rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureNSGRule                                                   # Breaks :GetAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.NSGName `
                        -ResourceGroupName $OpSelect.NSGRG
                    $NSGRuleObject = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                        $NSGObject -Name $OpSelect.name
                    Return $NSGRuleObject, $NSGObject                                       # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzNSGRule while ($true)
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNSGRule
function RemoveAzNSGRule {                                                                  # Function to remove a network security group rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'RemoveAzNSGRule'                                            # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNSGRule while ($true) {                                                 # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:       '$NSGRuleObject.Name                               # Write message to screen
            Write-Host 'Access:          '$NSGRuleObject.Access                             # Write message to screen
            Write-Host 'Protocol:        '$NSGRuleObject.Protocol                           # Write message to screen
            Write-Host 'Priority:        '$NSGRuleObject.Priority                           # Write message to screen
            Write-Host 'Direction:       '$NSGRuleObject.Direction                          # Write message to screen
            Write-Host 'Source Port:     '$NSGRuleObject.SourcePortRange                    # Write message to screen
            Write-Host 'Destination Port:'$NSGRuleObject.DestinationPortRange               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing network security group rule'                           # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $NSGRuleObject.Name -ErrorAction 'Stop' | Out-Null            # Removes the network security group rule
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen   
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGRule                                                # Breaks :RemoveAzureNSGRule
                }                                                                           # End catch
                Write-Host 'Saving network security group config'                           # Write message to screen
                Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves the updated network security group
                Clear-Host                                                                  # Clears screen
                Write-Host 'The network security group rule has been removed'               # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGRule                                                    # Breaks :RemoveAzureNSGRule
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :RemoveAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGRule
function UpdateAzNSGRAccess {                                                               # Function to update a network security group rule access
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRAccess'                                         # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleAccess = SetAzNSGRuleAccess ($CallingFunction)                      # Calls function and assigns output to $var
                if (!$NSGRuleAccess) {                                                      # If $NSGRuleAccess is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleAccess)
                else {                                                                      # Else if $NSGRuleAccess has a value
                    $RAccess = $NSGRuleAccess                                               # Updates $RAccess     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleAccess))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Access'                                                  # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Access                                    # Write message to screen
            Write-Host 'New:      '$RAccess                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRAccess
function UpdateAzNSGRDirection {                                                            # Function to update a network security group rule direction
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDirection'                                      # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)     
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules)        
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleDirection = SetAzNSGRuleDirection ($CallingFunction)                # Calls function and assigns output to $var
                if (!$NSGRuleDirection) {                                                   # If $NSGRuleDirection is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleDirection)
                else {                                                                      # Else if $NSGRuleDirection has a value
                    $NSGRuleDirPri = $NSGRuleDirection+' '+$RPriori                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $RPriori                     
                    if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                           # If $NSGRuleDirPri is in $ObjectArray.DirPri
                        Write-Host 'The priority:'$RPriori' is already'                     # Write message to screen
                        Write-Host 'is already in use on an'$NSGRuleDirection' rule'        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'You will need to change the priority'                   # Write message to screen
                        Write-Host 'of this rule before you can change'                     # Write message to screen
                        Write-Host 'the direction of this rule'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input    
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig    
                    }                                                                       # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
                    $RDirect = $NSGRuleDirection                                            # Updates $RDirect     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleDirection))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Direction'                                               # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Direction                                 # Write message to screen
            Write-Host 'New:      '$RDirect                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDirection
function UpdateAzNSGRPriority {                                                             # Function to update a network security group rule priotiry
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRPriority'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            $NSGRuleDirection = $NSGRuleObject.Direction                                    # $NSGRuleDirection is equal to $NSGRuleObject.Direction       
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRulePriority = SetAzNSGRulePriority ($CallingFunction, $NSGObject, `
                    $NSGRuleObject, $NSGRuleDirection)                                      # Calls function and assigns output to $var
                if (!$NSGRulePriority) {                                                    # If $NSGRulePriority is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRulePriority)
                else {                                                                      # Else if $NSGRulePriority has a value
                    $RPriori = $NSGRulePriority                                             # Updates $RPriori     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRulePriority))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Priority'                                                # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Priority                                  # Write message to screen
            Write-Host 'New:      '$RPriori                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRPriority
function UpdateAzNSGRProtocol {                                                             # Function to update a network security group rule protocol
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRProtocol'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleProtocol = SetAzNSGRuleProtocol ($CallingFunction)                  # Calls function and assigns output to $var
                if (!$NSGRuleProtocol) {                                                    # If $NSGRuleProtocol is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleProtocol)
                else {                                                                      # Else if $NSGRuleProtocol has a value
                    $RProto = $NSGRuleProtocol                                              # Updates $Rproto     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleProtocol))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Protocol'                                                # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.Protocol                                  # Write message to screen
            Write-Host 'New:      '$NSGRuleProtocol                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRProtocol
function UpdateAzNSGRSPRange {                                                              # Function to update a network security group rule source port range
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSPRange'                                        # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleSPRange = SetAzNSGRuleSPortRange ($CallingFunction)                 # Calls function and assigns output to $var
                if (!$NSGRuleSPRange) {                                                     # If $NSGRuleSPRange is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleSPRange)
                else {                                                                      # Else if $NSGRuleSPRange has a value
                    $RSPRang = $NSGRuleSPRange                                              # Updates $RSPRang     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleSPRange))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source Port Range'                                       # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.SourcePortRange                           # Write message to screen
            Write-Host 'New:      '$RSPRang                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRSPRange
function UpdateAzNSGRDPRange {                                                              # Function to update a network security group rule destination port range
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDPRange'                                        # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleDPRange = SetAzNSGRuleDPortRange ($CallingFunction)                 # Calls function and assigns output to $var
                if (!$NSGRuleDPRange) {                                                     # If $NSGRuleDPRange is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleDPRange)
                else {                                                                      # Else if $NSGRuleDPRange has a value
                    $RDPRang = $NSGRuleDPRange                                              # Updates $RDPRang     
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleDPRange))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Destination Port Range'                                  # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.DestinationPortRange                      # Write message to screen
            Write-Host 'New:      '$RDPRang                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDPRange
function UpdateAzNSGRSAddPrefix {                                                           # Function to update a network security group rule source address prefix
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSAddPrefix'                                     # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups.ID
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups.ID
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)                # Calls function and assigns output to $var
                if (!$NSGRuleAddPrefix) {                                                   # If $NSGRuleAddPrefix is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleAddPrefix)
                else {                                                                      # Else if $NSGRuleAddPrefix has a value
                    $RSAddre = $NSGRuleAddPrefix                                            # Updates $RSAddre
                    $RSASGr = $null                                                         # clears $var    
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleAddPrefix))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if (!$NSGRuleObject.SourceAddressPrefix) {                                      # If $NSGRuleObject.SourceAddressPrefix is $null
                Write-Host 'Powershell tools cannot convert source'                         # Write message to screen
                Write-Host 'application secruity groups to address prefixes'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'executing this change will remove the'                          # Write message to screen
                Write-Host 'and rebuild it using the existing settings'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Update the following'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Name:'$RName                                               # Write message to screen
                Write-Host 'Setting:   Source Address Prefix'                               # Write message to screen
                Write-Host 'Current:   N/A'                                                 # Write message to screen
                Write-Host 'New:      '$RSAddre                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to rebuild the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Write-Host 'Removing the rule'                                      # Write message to screen
                        Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                            $NSGObject -Name $NSGRuleObject.Name -ErrorAction 'Stop' `
                            | Out-Null                                                      # Removes the rule
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                            -ErrorAction 'Stop' | Out-Null                                  # Saves the updated network security group    
                    }                                                                       # End Try
                    Catch {                                                                 # If try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'There was an error removing the NSG rule'               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'Rebuilding the rule'                                        # Write message to screen
                    Try {                                                                   # Try the following
                        if ($RDAddre) {                                                     # If $RDAddre has a value
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang -SourceAddressPrefix `
                                $RSAddre -DestinationPortRange $RDPRang `
                                -DestinationAddressPrefix $RDAddre -ErrorAction 'Stop' `
                                | Out-Null                                                  # Rebuilds the rule
                        }                                                                   # End if ($RDAddre)
                        else {                                                              # Else if $RDAddre is $null
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang -SourceAddressPrefix `
                                $RSAddre -DestinationPortRange $RDPRang `
                                -DestinationApplicationSecurityGroupId $RDASGr `
                                -ErrorAction 'Stop' | Out-Null                              # Rebuilds the rule
                        }                                                                   # End else (if ($RDAddre))   
                        Write-Host 'Saving the network security group'                      # Write message to screen             
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the updated network security group
                    }                                                                       # End Try
                    Catch {                                                                 # End catch
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error occured rebuilding the rule'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The rule has been rebuilt with the new address prefix'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpConfim
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End if (!$NSGRuleObject.SourceAddressPrefix)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source Address Prefix'                                   # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.SourceAddressPrefix                       # Write message to screen
            Write-Host 'New:      '$RSAddre                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRSAddPrefix
function UpdateAzNSGRDAddPrefix {                                                           # Function to update a network security group rule destination address prefix
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDAddPrefix'                                     # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups.ID
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups.ID
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $NSGRuleAddPrefix = SetAzNSGRuleAddPrefix ($CallingFunction)                # Calls function and assigns output to $var
                if (!$NSGRuleAddPrefix) {                                                   # If $NSGRuleAddPrefix is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$NSGRuleAddPrefix)
                else {                                                                      # Else if $NSGRuleAddPrefix has a value
                    $RDAddre = $NSGRuleAddPrefix                                            # Updates $RSAddre
                    $RDASGr = $null                                                         # clears $var    
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$NSGRuleAddPrefix))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if (!$NSGRuleObject.DestinationAddressPrefix) {                                 # If $NSGRuleObject.DestinationAddressPrefix is $null
                Write-Host 'Powershell tools cannot convert destination'                    # Write message to screen
                Write-Host 'application secruity groups to address prefixes'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Executing this change will remove the'                          # Write message to screen
                Write-Host 'and rebuild it using the existing settings'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Update the following'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Name:'$RName                                               # Write message to screen
                Write-Host 'Setting:   Source Address Prefix'                               # Write message to screen
                Write-Host 'Current:   N/A'                                                 # Write message to screen
                Write-Host 'New:      '$RDAddre                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to rebuild the rule
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Write-Host 'Removing the rule'                                      # Write message to screen
                        Remove-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                            $NSGObject -Name $NSGRuleObject.Name -ErrorAction 'Stop' `
                            | Out-Null                                                      # Removes the rule
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                            -ErrorAction 'Stop' | Out-Null                                  # Saves the updated network security group    
                    }                                                                       # End Try
                    Catch {                                                                 # If try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'There was an error removing the NSG rule'               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'Rebuilding the rule'                                        # Write message to screen
                    Try {                                                                   # Try the following
                        if ($RSAddre) {                                                     # If $RSAddre has a value
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang -SourceAddressPrefix `
                                $RSAddre -DestinationPortRange $RDPRang `
                                -DestinationAddressPrefix $RDAddre -ErrorAction 'Stop' `
                                | Out-Null                                                  # Rebuilds the rule
                        }                                                                   # End if ($RSAddre)
                        else {                                                              # Else if $RSAddre is $null
                            Add-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                                $NSGObject -Name $RName -Description $RDescri -Protocol `
                                $RProto -Access $RAccess -Priority $RPriori -Direction `
                                $RDirect -SourcePortRange $RSPRang `
                                -SourceApplicationSecurityGroupId $RSASGr `
                                -DestinationPortRange $RDPRang `
                                -DestinationAddressPrefix $RDAddre -ErrorAction 'Stop' `
                                | Out-Null                                                  # Rebuilds the rule
                        }                                                                   # End else (if ($RSAddre))   
                        Write-Host 'Saving the network security group'                      # Write message to screen             
                        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the updated network security group
                    }                                                                       # End Try
                    Catch {                                                                 # End catch
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error occured rebuilding the rule'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ChangeAzureNSRGConfig                                         # Breaks :ChangeAzureNSRGConfig
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The rule has been rebuilt with the new address prefix'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpConfim
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End if (!$NSGRuleObject.SourceAddressPrefix)
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source Address Prefix'                                   # Write message to screen
            Write-Host 'Current:  '$NSGRuleObject.DestinationAddressPrefix                  # Write message to screen
            Write-Host 'New:      '$RDAddre                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDAddPrefix
function UpdateAzNSGRSAppSecG {                                                             # Function to update a network security group rule source application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRSAppSecG'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $ASGObject = GetAzASG ($CallingFunction)                                    # Calls function and assigns output to $var
                if (!$ASGObject) {                                                          # If $ASGObject is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$ASGObject)
                else {                                                                      # Else if $ASGObject has a value
                    $RSASGr = $ASGObject.ID                                                 # Updates $RSASGr    
                    $AppSecGroupName = $ASGObject.ID.split('/')[-1]                         # Isolates the application security group name 
                    $RSAddre = $null                                                        # Clears $RSAddre
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$ASGObject))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if ($NSGRuleObject.SourceApplicationSecurityGroups.ID) {                        # If $NSGRuleObject.SourceApplicationSecurityGroups.ID has a value
                $CurrentAppSecGroup = $NSGRuleObject.SourceApplicationSecurityGroups.ID     # $CurrentAppSecGroup is equal to $NSGRuleObject.SourceApplicationSecurityGroups.ID 
                $CurrentAppSecGroup = $CurrentAppSecGroup.Split('/')[-1]                    # Isolates the app security group name
            }                                                                               # End if ($NSGRuleObject.SourceApplicationSecurityGroups.ID)
            else {                                                                          # Else if $NSGRuleObject.SourceApplicationSecurityGroups.ID is $null
                $CurrentAppSecGroup = 'N/A'                                                 # $CurrentAppSecGroup is equal to 'N/A'
            }                                                                               # End else (if ($NSGRuleObject.SourceApplicationSecurityGroups.ID))
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Source App Sec Group'                                    # Write message to screen
            Write-Host 'Current:  '$CurrentAppSecGroup                                      # Write message to screen
            Write-Host 'New:      '$AppSecGroupName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRSAppSecG
function UpdateAzNSGRDAppSecG {                                                             # Function to update a network security group rule destination application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction has a value
            $CallingFunction = 'UpdateAzNSGRDAppSecG'                                       # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ChangeAzureNSRGConfig while ($true) {                                              # Outer loop for managing function
            :GetAzureNSGRule while ($true) {                                                # Inner loop for getting the NSG rule
                Write-Host 'Select Rule Options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Select Rule From All NSGs'                                  # Write message to screen
                Write-Host '[2] Select NSG, then Select Rule'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleObject, $NSGObject =  GetAzAllNSGsRule ($CallingFunction)       # Calls function and assigns output to $var
                    if ($NSGRuleObject) {                                                   # If $NSGRuleObject has a value
                        Break GetAzureNSGRule                                               # Breaks :GetAzureNSGRule
                    }                                                                       # End if ($NSGRuleObject)
                }                                                                           # elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $NSGObject = GetAzNSG ($CallingFunction)                                # Calls function and assigns output to $var
                    if ($NSGObject) {                                                       # If $NSGObject has a value
                        $NSGRuleObject = GetAzNSGRule ($CallingFunction, $NSGObject)        # Calls function and assigns output to $var
                        if ($NSGRuleObject) {                                               # If $NSGRuleObject has a value
                            Break GetAzureNSGRule                                           # Breaks :GetAzureNSGRule
                        }                                                                   # End if ($NSGRuleObject)
                    }                                                                       # End if ($NSGObject)
                }                                                                           # elseif ($OpSelect -eq '2')                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureNSGRule while ($true)            
            $RName = $NSGRuleObject.Name                                                    # $RName is equal to $NSGRuleObject.Name
            $RProto = $NSGRuleObject.Protocol                                               # $RProto is equal to $NSGRuleObject.Protocol
            $RAccess = $NSGRuleObject.Access                                                # $RAccess is equal to $NSGRuleObject.Access
            $RDirect = $NSGRuleObject.Direction                                             # $RDirect is equal to $NSGRuleObject.Direction
            $RPriori = $NSGRuleObject.Priority                                              # $RPriori is equal to $NSGRuleObject.Priority
            $RDescri = $NSGRuleObject.Description                                           # $RDescri is equal to $NSGRuleObject.Description
            if (!$RDescri) {                                                                # If $RDescri is $null
                $RDescri = 'N/A'                                                            # Sets 'N/A' value for $RDescri 
            }                                                                               # End if (!$RDescri)
            $RSPRang = $NSGRuleObject.SourcePortRange                                       # $RSPRang is equal to $NSGRuleObject.SourcePortRange
            $RSAddre = $NSGRuleObject.SourceAddressPrefix                                   # $RSAddre is equal to $NSGRuleObject.SourceAddressPrefix
            $RSASGr = $NSGRuleObject.SourceApplicationSecurityGroups.ID                     # $RSASGr is equal to $NSGRuleObject.SourceApplicationSecurityGroups
            $RDPRang = $NSGRuleObject.DestinationPortRange                                  # $RDPRang is equal to $NSGRuleObject.DestinationPortRange
            $RDAddre = $NSGRuleObject.DestinationAddressPrefix                              # $RDAddre is equal to $NSGRuleObject.DestinationAddressPrefix
            $RDASGr = $NSGRuleObject.DestinationApplicationSecurityGroups.ID                # $RDASGr is equal to $NSGRuleObject.DestinationApplicationSecurityGroups
            :GetAzureNSGRSetting while ($true) {                                            # Inner loop for getting the updated rule config
                $ASGObject = GetAzASG ($CallingFunction)                                    # Calls function and assigns output to $var
                if (!$ASGObject) {                                                          # If $ASGObject is $null
                    Break ChangeAzureNSRGConfig                                             # Breaks :ChangeAzureNSRGConfig    
                }                                                                           # End if (!$ASGObject)
                else {                                                                      # Else if $ASGObject has a value
                    $RDASGr = $ASGObject.ID                                                 # Updates $RDASGr    
                    $AppSecGroupName = $ASGObject.ID.split('/')[-1]                         # Isolates the application security group name 
                    $RDAddre = $null                                                        # Clears $RDAddre
                    Break GetAzureNSGRSetting                                               # Breaks :GetAzureNSGRSetting
                }                                                                           # End else (if (!$ASGObject))
            }                                                                               # End :GetAzureNSGRSetting while ($true)
            if ($NSGRuleObject.DestinationApplicationSecurityGroups.ID) {                   # If $NSGRuleObject.DestinationApplicationSecurityGroups.ID has a value
                $CurrentAppSecGroup = `
                    $NSGRuleObject.DestinationApplicationSecurityGroups.ID                  # $CurrentAppSecGroup is equal to $NSGRuleObject.DestinationApplicationSecurityGroups.ID 
                $CurrentAppSecGroup = $CurrentAppSecGroup.Split('/')[-1]                    # Isolates the app security group name
            }                                                                               # End if ($NSGRuleObject.DestinationApplicationSecurityGroups.ID)
            else {                                                                          # Else if $NSGRuleObject.DestinationApplicationSecurityGroups.ID is $null
                $CurrentAppSecGroup = 'N/A'                                                 # $CurrentAppSecGroup is equal to 'N/A'
            }                                                                               # End else (if ($NSGRuleObject.DestinationApplicationSecurityGroups.ID))
            Write-Host 'Update the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule Name:'$RName                                                   # Write message to screen
            Write-Host 'Setting:   Destination App Sec Group'                               # Write message to screen
            Write-Host 'Current:  '$CurrentAppSecGroup                                      # Write message to screen
            Write-Host 'New:      '$AppSecGroupName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to change the rule
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                UpdateAzNSGRuleConfig ($NSGRuleObject, $NSGObject, $RName, $RProto, `
                    $RAccess, $RDirect, $RPriori, $RDescri, $RSPRang, $RSAddre, $RSASGr, `
                    $RDPRang, $RDAddre, $RDASGr)                                            # Calls function
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # Else if $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ChangeAzureNSRGConfig                                                 # Breaks :ChangeAzureNSRGConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y') )
        }                                                                                   # End :ChangeAzureNSRGConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzNSGRDAppSecG
function UpdateAzNSGRuleConfig {                                                            # Function for updating network security group rule configs
    Begin {                                                                                 # Begin function
        Write-Host 'Updating network security group rule'                                   # Write message to screen
            Try {                                                                           # Try the following
                if ($RSAddre -and $RDAddre) {                                               # If $RSAddre -and $RDAddre have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationAddressPrefix $RDAddre `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End if ($RSAddre -and $RDAddre)
                elseif ($RSAddre -and $RDASGr) {                                            # Else if $RSAddre -and $RDASGr have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -SourceAddressPrefix $RSAddre -DestinationPortRange `
                        $RDPRang -DestinationApplicationSecurityGroupID $RDASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                                                                           # End elseif ($RSAddre -and $RDASGr)
                elseif ($RSASGr -and $RDAddre) {                                            # Else if $RSASGr -and $RDAddre have values
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                        -Name $RName -Description $RDescri -Protocol $RProto -Access `
                        $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                        $RSPRang -DestinationPortRange $RDPRang -DestinationAddressPrefix `
                        $RDAddre -SourceApplicationSecurityGroupID $RSASGr `
                        -ErrorAction 'Stop' | Out-Null                                      # Updates the rule protocol
                }                               
                elseif ($RSASGr -and $RDASGr) {                                             # Else if $RSASGr -and $RDASGr have values      
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $RName -Description $RDescri -Protocol $RProto -Access `
                    $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                    $RSPRang -DestinationPortRange $RDPRang `
                    -SourceApplicationSecurityGroupID $RSASGr `
                    -DestinationApplicationSecurityGroupID $RDASGr `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the rule protocol
                }                                                                           # End elseif ($RSASGr -and $RDASGr)
                else {                                                                      # All other configurations
                    Set-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject `
                    -Name $RName -Description $RDescri -Protocol $RProto -Access `
                    $RAccess -Priority $RPriori -Direction $RDirect -SourcePortRange `
                    $RSPRang -DestinationPortRange $RDPRang -ErrorAction 'Stop' | Out-Null  # Updates the rule protocol
                }                                                                           # End else (if ($RSAddre -and $RDAddre)
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Return $null                                                                # Returns to calling function with $null
            }                                                                               # End catch
            Write-Host 'Saving network security group config'                               # Write message to screen
            Set-AzNetworkSecurityGroup -NetworkSecurityGroup $NSGObject `
                -ErrorAction 'Stop' | Out-Null                                              # Saves the updated network security group
            Clear-Host                                                                      # Clears screen
            Write-Host 'The network security group rule has been updated'                   # Write message to screen   
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Return $null                                                                    # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End UpdateAzNSGRuleConfig
# End ManageAzNSGRuleConfig
# Functions for ManageAzNSGNIC
function ManageAzNSGNIC {                                                                   # Function to manage NSG Nic associations
    Begin {                                                                                 # Begin function
        :ManageAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Manage NSG NIC assoications'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add/Change Association'                                         # Write message to screen
            Write-Host '[2] List Associations'                                              # Write message to screen
            Write-Host '[3] Remove Association'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNSGNic                                                     # Breaks :ManageAzureNSGNic
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add/Change Association'                                         # Write message to screen
                AddAzNSGNIC                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Associations'                                              # Write message to screen
                ListAzNSGNIC                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Association'                                             # Write message to screen
                RemoveAzNSGNIC                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen 
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureNSGNic while ($true)
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNSGNIC 
function AddAzNSGNIC {                                                                      # Function to add a NSG to NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'AddAzNSGNIC'                                                # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :AddAzureNSGNic while ($true) {                                                     # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NSGObject) 
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Replace:'$CurrentNSG                                            # Write message to screen
                Write-Host 'With:   '$NSGObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'On NIC: '$NicObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'Add:'$NSGObject.name                                            # Write message to screen
                Write-Host 'To: '$NicObject.name                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $NSGObject                            # Assigns $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureNSGNic                                                    # Breaks :AddAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been added to the NIC'                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :AddAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNSGNIC
function ListAzNSGNIC {                                                                     # Function to list all NICs associated with network security groups       
    Begin {                                                                                 # Begin function
        :ListAzureNSGNic while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering NSG info'                                                 # Write message to sceen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Creates $ObjectList
            Clear-Host                                                                      # Clears screen
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network security groups present in this subscription'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGNic                                                       # Breaks :ListAzureNSGNic
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            Write-Host 'Gathering NIC info'                                                 # Write message to sceen
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $NSGObject = $_                                                             # NSGObject is equal to current item
                $NicList = $_.NetworkInterfaces.ID                                          # $NicList is equal to current item .NetworkInterfaces.ID
                if ($NicList) {                                                             # If $NicList has a value
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ID = $_                                                            # ID is equal to current item
                        $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}  # Pulls the full nic object
                        if ($NicObject.VirtualMachine.ID) {                                 # If $NicObject.VirtualMachine.ID has a value
                            $VMObject = $NicObject.VirtualMachine.ID                        # Isolates the VM id
                            $VMObject = Get-AzVM | Where-Object {$_.ID -eq $VMObject}       # Pulls the full VM object
                            if ($VMObject.OSProfile.LinuxConfiguration) {                   # If $VMObject.OSProfile.LinuxConfiguration has a value
                                $OsType = 'Linux'                                           # Sets $OSType
                            }                                                               # End if ($VMObject.OSProfile.LinuxConfiguration)
                            else {                                                          # Else if $VMObject.OSProfile.LinuxConfiguration is $null
                                $OsType = 'Windows'                                         # Sets $OSType
                            }                                                               # End else (if ($VMObject.OSProfile.LinuxConfiguration))
                        }                                                                   # End if ($NicObject.VirtualMachine.ID) 
                        $ObjectInput = [PSCustomObject]@{                                   # custom object to add info to $ObjectArray
                            'NSGName'=$NSGObject.Name;                                      # NSG name
                            'NSGRG'=$NSGObject.ResourceGroupName;                           # NSG resource group
                            'RuleCount'=$NSGObject.SecurityRules.Count;                     # Count of non-default rules
                            'NICName'=$NICObject.Name;                                      # NIC name
                            'NICRG'=$NicObject.ResourceGroupName;                           # NIC resource group
                            'NicVM'=$VMObject.Name;                                         # NIC VM name
                            'NicVMRG'=$VMObject.ResourceGroupName;                          # NIC VM resource group
                            'NICVMOS'=$OsType                                               # NIC VM OS                                    
                        }                                                                   # End $ObjectInput = [PSCustomObject]@
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Adds $ObjectInput to $ObjectArray
                        $ID = $null                                                         # Clears $var
                        $NicObject = $null                                                  # Clears $var
                        $VMObject = $null                                                   # Clears $var
                        $OSType = $null                                                     # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End if ($NicList)
                $NSGObject = $null                                                          # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'There are not NICs associated with network security groups'     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGNic                                                       # Breaks :ListAzureNSGNic
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Sec Group Name: '$_.NSGName                                     # Write message to screen
                Write-host 'Sec Group RG:   '$_.NSGRG                                       # Write message to screen
                Write-Host 'Sec Rules count:'$_.RuleCount                                   # Write message to screen
                Write-Host 'NIC Name:       '$_.NICName                                     # Write message to screen
                Write-Host 'NIC RG:         '$_.NICRG                                       # Write message to screen
                if ($_.NicVM) {                                                             # If current item .NicVM has a value
                    Write-Host 'VM Name:        '$_.NicVM                                   # Write message to screen
                    Write-Host 'VM RG:          '$_.NicVMRG                                 # Write message to screen
                    Write-Host 'VM OS Type:     '$_.NICVMOS                                 # Write message to screen
                }                                                                           # End if ($_.NicVM)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSGNic                                                           # Breaks :ListAzureNSGNic
        }                                                                                   # End :ListAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNSGNIC
function RemoveAzNSGNIC {                                                                   # Function to remove a NSG from NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNSGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :RemoveAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Remove:  '$CurrentNSG                                           # Write message to screen
                Write-Host 'From NIC:'$NicObject.name                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'No NSG associated to:'$NicObject.name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $null                                 # Removes $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGNic                                                 # Breaks :RemoveAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been removed from the NIC'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :RemoveAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGNIC
# End ManageAzNSGNIC
# Additional functions required for ManageAzNSG
function GetAzASG {                                                                         # Function to get a application security group
    Begin {                                                                                 # Begin function
        :GetAzureASG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASG                                                           # Breaks :GetAzureASG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NICCount'=$NICList.Count                                               # Count of nic associated to the current application security group
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the application security group
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:        '$_.RG                                      # Write message to screen
                    Write-Host 'Rule Loc:       '$_.Location                                # Write message to screen
                    if ($_.NicCount) {                                                      # If $NicCount has a value
                        Write-Host 'Associated NICS:'$_.NICCount                            # Write message to screen
                    }                                                                       # End if ($_.NicCount)
                    else {                                                                  # Else if $NicCount is $null
                        Write-Host 'Associated NICS: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NicCount))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the app security group for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $ASGObject = Get-AzApplicationSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full application security group object
                    Return $ASGObject                                                       # Returns to calling function with application security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
        }                                                                                   # End :GetAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzASG
function SetIPAddress {                                                                     # Function to add a IP address to $var
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContine'                                          # Turns off error reporting
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetIPAddressLoop while ($true) {                                                   # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-Host 'You are setting the IP for:'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            Write-Host 'Enter the IP address (Must be x.x.x.x)'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $IPAddress = Read-Host 'IP Address'                                             # Operator input for the starting IP address
            Clear-Host                                                                      # Clears screen
            if ($IPAddress -notlike '*.*.*.*') {                                            # If $IPAddress is not like '*.*.*.*'
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = $null                                                          # Clears $var
            }                                                                               # End if ($IPAddress -notlike '*.*.*.*') 
            if ($IPAddress) {                                                               # If $IPAddress has a value
                if ($IPAddress.Split('.')[4]) {                                             # If $IPAddress .Split 4th position has a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress.Split('.')[4])
            }                                                                               # End  if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $IPAddressArray = $IPAddress.ToCharArray()                                  # Converts $IPAddress to array
                foreach ($_ in $IPAddressArray) {                                           # For each item in $IPAddressArray
                    if ($_ -notin $ValidArray) {                                            # If current item not in $ValidArray
                        Write-Host $_' is not a valid character'                            # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $IPAddressArray)
                $IPAddressArray = $null                                                     # Clears $var
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $OctetCheck = $IPAddress.Split('.')                                         # $OctetCheck is equal to $IPAdress.Split '.'
                foreach ($_ in $OctetCheck) {                                               # For each item in $OctetCheck
                    $OctetInt = [INT]$_                                                     # $OctetInt is equal to current item converted to integer
                    if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                            # If $OctetInt less than 0 or  $OctetInt greater than 255
                        Write-Host $_' is not a valid octet'                                # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                    $OctetInt = $null                                                       # Clears $var
                }                                                                           # End foreach ($_ in $OctetCheck)
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                Write-Host 'Use'$IPAddress' as the IP'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP address
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break SetIPAddressLoop                                                  # Breaks :SetIPAddressLoop
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Return $IPAddress                                                       # Returns to calling function with $var  
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End if ($IPAddress)
            else {                                                                          # If $IPAddress is $null
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($IPAddress))
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetIPAddress
function SetCIDRAddress {                                                                   # Function to add a CIDR address to $var
    Begin {                                                                                 # Begin function
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetCIDRAddressLoop while ($true) {                                                 # Outer loop for managing function
            :SetIPAddress while ($true) {                                                   # Inner loop for setting the starting IP
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are setting the IP for:'$CallingFunction                # Write message to screen
                }                                                                           # End if ($CallingFunction)
                Write-Host 'Enter the starting IP address (Must be x.x.x.0)'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = Read-Host 'IP Address'                                         # Operator input for the starting IP address
                Clear-Host                                                                  # Clears screen
                if ($IPAddress -notlike '*.*.*.0') {                                        # If $IPAddress is not like '*.*.*.0'
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress -notlike '*.*.*.0') 
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    if ($IPAddress.Split('.')[4]) {                                         # If $IPAddress .Split 4th position has a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($IPAddress.Split('.')[4])
                }                                                                           # End  if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $IPAddressArray = $IPAddress.ToCharArray()                              # Converts $IPAddress to array
                    foreach ($_ in $IPAddressArray) {                                       # For each item in $IPAddressArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $IPAddressArray)
                    $IPAddressArray = $null                                                 # Clears $var
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $OctetCheck = $IPAddress.Split('.')                                     # $OctetCheck is equal to $IPAdress.Split '.'
                    foreach ($_ in $OctetCheck) {                                           # For each item in $OctetCheck
                        $OctetInt = [INT]$_                                                 # $OctetInt is equal to current item converted to integer
                        if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                        # If $OctetInt less than 0 or  $OctetInt greater than 255
                            Write-Host $_' is not a valid octet'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                        $OctetInt = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $OctetCheck)
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    Write-Host 'Use'$IPAddress' as the starting IP'                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetIPAddress                                                  # Breaks :SetIPAddress  
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($IPAddress)
                else {                                                                      # If $IPAddress is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($IPAddress))
            }                                                                               # End :SetIPAddress while ($true) 
            $ValidArray = '0123456789'                                                      # Creates $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to array
            :SetCIDRBlock while ($true) {                                                   # Inner loop for setting the CIDR block
                Write-Host 'Enter the CIDR Block (0-32)'                                    # Write message to screen
                Write-Host  ''                                                              # Write message to screen
                $CIDRBlock = Read-Host 'CIDR Block'                                         # Operator input for the CIDR block
                Clear-Host                                                                  # Clears screen
                $CIDRBlockArray = $CIDRBlock.ToCharArray()                                  # Converts $CIDRBlock to array
                foreach ($_ in $CIDRBlockArray) {                                           # For each item in $CIDRBlockArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $CIDRBlockArray)
                $CIDRBlockArray = $null                                                     # Clears $var
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    $CIDRBlockInt = [INT]$CIDRBlock                                         # Converts $CIDRBlock to integer
                    if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32) {                     # If $CIDRBlockInt is less than 0 or greater than 32)
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32)
                    $CIDRBlockInt = $null                                                   # Clears $var
                }                                                                           # End if ($CIDRBlock)
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    Write-Host 'Use'$CIDRBlock' as the CIDR block'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the CIDR block
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        $CIDRAddress = $IPAddress+'/'+$CIDRBlock                            # $CIDRAddress is equal to $IPAddress and $CIDRBlock
                        Return $CIDRAddress                                                 # Returns to calling function with $var
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($CIDRBlock)
                else {                                                                      # Else if $CIDRBlock is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($CIDRBlock))
            }                                                                               # End :SetCIDRBlock while ($true)
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetCIDRAddress