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
    $OpConfirm:                 Operator confirmation to add this config
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
    NewAzLBFrontendIpConfig{}   Gets $FrontEndIPConfigObject
        GetAzPublicIpAddress{}      Gets $PubIPObject
} #>
<# Process Flow {
    function
        Call AddAzLBFEPrivateConfig > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return AddAzLBFEPrivateConfig > Send $LoadBalancerObject
            Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
                Call GetAzPublicIpAddress > Get $PubIPObject
                End GetAzPublicIpAddress
                    Return NewAzLBFrontendIpConfig > Send $PubIPObject
            End NewAzLBFrontendIpConfig
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
}                                                                                           # End function AddAzLBFEPrivateConfig