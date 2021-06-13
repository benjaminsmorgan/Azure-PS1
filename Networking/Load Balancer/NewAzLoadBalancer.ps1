# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0   
} #>
<# Required Functions Links: {
    NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
    NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
    NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
    NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzLoadBalancer:          Creates a new load balancer
    NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
    GetAzPublicIpAddress:       Gets an existing IP address
    NewAzLBBackendIpConfig:     Creates a load balancer back end configuration
    NewAzLBProbeConfig:         Creates a load balancer probe configuration
    NewAzLBIBNatPoolConfig:     Creates inbound pool configuration for load balancer
    NewAzLBRuleConfig:          Creates a new load balancer rule
    GetAzResourceGroup:         Gets an existing resource group
} #>
<# Variables: {      
    :NewAzureLoadBalancer       Outer loop to manage function   
    :SetAzureLBName             Inner loop for set the load balancer name
    $CallingFunction:           Name of this function or the one that called it
    $LBNameObject:              Load balancer name object
    $RGObject:                  Resource group object
    $FrontEndIPConfigObject:    Front end configuration object
    $BackEndIPConfigObject:     Back end configuration object
    $HealthProbeObject:         Health probe configuration object
    $InboundNatPoolObject:      Inbound nat pool configuration object
    $LoadBalanceRule:           Load balancer rule object
    $OpConfirm:                 Operator confirmation of $LBNameObject
    $LoadBalancerObject:        The load balancer object
    GetAzResourceGroup{}        Gets $RGObject
    NewAzLBFrontendIpConfig{}   Gets $FrontEndIPConfigObject
        GetAzPublicIpAddress{}      Gets $PublicIPObject
    NewAzLBBackendIpConfig{}    Gets $BackEndIPConfigObject
    NewAzLBProbeConfig{}        Gets $HealthProbeObject
    NewAzLBIBNatPoolConfig{}    Gets $InboundNatPoolObject
    NewAzLBRuleConfig{}         Gets $LoadBalanceRule 
} #>
<# Process Flow {
    function
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
            Return function > Send $null
}#>
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzLoadBalancer'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                Write-Host 'Enter the load balancer name'                                   # Write message to screen
                $LBNameObject = Read-Host 'Name'                                            # Operator input for the balancer name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$LBNameObject' as the balancer name'                       # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the balancer name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureLBName                                                    # Breaks :SetAzureLBName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureLBName while ($true)
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$RGObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig ($CallingFunction)            # Calls function and assigns output to $var
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
                    $LBRule -InboundNatPool $InboundNatPoolObject -ErrorAction 'Stop' `
                    | Out-Null                                                              # Creates the load balancer
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
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