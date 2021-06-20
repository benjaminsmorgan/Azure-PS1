# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Add-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
} #>
<# Required Functions Links: {
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
    NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
    } #>
<# Functions Description: {
    AddAzLBFEPrivateConfig:     Adds a private IP configuration to a load balancer
    GetAzLoadBalancer:          Gets an existing load balancer
    NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
} #>
<# Variables: {      
    :SetAzureLoadBalancer       Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LoadBalancerObject:        Load balancer object
    $FrontEndIPConfigObject:    New front end config object
    $SubnetName:                Name of the subnet
    $OpConfirm:                 Operator confirmation to add this config
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
    NewAzLBFEPriDynamicIpCon{}  Gets $FrontEndIPConfigObject
    NewAzLBFEPriStaticIpCon{}   Gets $FrontEndIPConfigObject
} #>
<# Process Flow {
    function
        Call AddAzLBFEPrivateConfig > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return AddAzLBFEPrivateConfig > Send $LoadBalancerObject
            Call NewAzLBFEPriDynamicIpCon > Get $FrontEndIPConfigObject
            End NewAzLBFEPriDynamicIpCon
                Return AddAzLBFEPrivateConfig > Send $FrontEndIPConfigObject
            Call NewAzLBFEPriStaticIpCon > Get $FrontEndIPConfigObject
            End NewAzLBFEPriStaticIpCon
                Return AddAzLBFEPrivateConfig > Send $FrontEndIPConfigObject            
        End AddAzLBFEPrivateConfig
            Return function > Send $null
}#>
function AddAzLBFEPrivateConfig {                                                           # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPrivateConfig'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID) {          # If $LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID has a value
                Write-Host 'This load balancer is currently referencing a public IP'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to add a private config to a load'           # Write message to screen
                Write-Host 'balancer configured with a public IP front end'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID)
            :NewAzureLBFrontEnd while ($true) {                                             # Inner loop for setting the type of front end config
                Write-Host 'Select type of front end config'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private Dynamic'                                            # Write message to screen
                Write-Host '[2] Private Static'                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the IP type for front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer  
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FrontEndIPConfigObject = NewAzLBFEPriDynamicIpCon ($CallingFunction)   # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FrontEndIPConfigObject = NewAzLBFEPriStaticIpCon ($CallingFunction)    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
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
            $SubnetName = $FrontEndIPConfigObject.Subnet.ID                                 # Isolates the subnet ID
            $SubnetName = $SubnetName.Split('/')[-1]                                        # Isolates the subnet name
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Private IP add:'$FrontEndIPConfigObject.PrivateIpAddress            # Write message to screen
            Write-Host 'Private IP all:'$FrontEndIPConfigObject.PrivateIpAllocationMethod   # Write message to screen
            Write-Host 'Subnet Name:   '$SubnetName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen    
                    if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic') {  # If $FrontEndIPConfigObject.PrivateIpAllocationMethod equals 'Dynamic'                  
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Saves the load balancer config
                    }                                                                       # End if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic')
                    else {                                                                  # Else if $FrontEndIPConfigObject.PrivateIpAllocationMethod does not equal 'Dynamic'
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                    }                                                                       # End else (if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic'))
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
}                                                                                           # End function AddAzLBFEPrivateConfig