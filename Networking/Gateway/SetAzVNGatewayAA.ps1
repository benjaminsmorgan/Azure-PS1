# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:
    Get-AzVirtualNetworkSubnetConfig:
    Add-AzVirtualNetworkGatewayIpConfig:
    Remove-AzVirtualNetworkGatewayIpConfig
    Set-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworkgateway?view=azps-6.3.0
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/GetAzVNGateway.ps1
} #>
<# Functions Description: {
    ResizeAzVNGateway:          Function to enable or diable active-active
    GetAzVNGateway:             Function to get a virtual network gateway
} #>
<# Variables: {      
    :SetAzureVNGateway          Outer loop for managing function
    :SetAzureGWActiveActive     Inner loop for setting the secondary IP config
    :Confirm                    Inner loop for confirming changes
    $CallingFunction:           Name of this function
    $GatewayObject:             Gateway object
    $GatewaySku:                $GatewayObject.Sku.Name
    $GatewayIPConfigPri:        $GatewayObject.IPConfigurations[0]
    $GatewayIPConfig:           Secondary IP config object
    $RGObject:                  Resource group name
    $VNetObject:                Virtual network object
    $SubnetObject:              Subnet object
    $OpConfirm:                 Operator confirmation to make the changes
    $GatewayIPConSec:           Secondary IP config object
    $MSG:                       Last PS error message
    GetAzVNGateway{}            Gets $GatewayObject
    NewAzVNGatewayIPcon{}       Gets $GatewayIPConfig
} #>
<# Process Flow {
    function
        Call SetAzVNGatewayAA > Get $null
            Call GetAzVNGateway > Get $GatewayObject            
            End GetAzVNGateway
                Return SetAzVNGatewayAA > Send $GatewayObject
        End SetAzVNGatewayAA
            Return function > Send $null
}#>
function SetAzVNGatewayAA {                                                                 # Function to enable or diable active-active
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzVNGatewayAA'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureVNGateway while ($true) {                                                  # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject is $null
                Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway
            }                                                                               # End if (!$GatewayObject)
            if ($GatewayObject.IPConfigurations.count -eq '1' -and `
                $GatewayObject.ActiveActive -eq $false) {                                   # If $GatewayObject.IPConfigurations.count equals '1' and $GatewayObject.ActiveActive equals $false
                $GatewaySku = $GatewayObject.Sku.Name                                       # $GatewaySku is equal to $GatewayObject.Sku.Name
                if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or `
                    'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') {                      # If $GatewaySku equals  'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3Az' -or 'HighPerformance'
                    $GatewayIPConfigPri = $GatewayObject.IPConfigurations[0]                # $GatewayIPConfigPri is equal to $GatewayObject.IPConfigurations[0]
                    $RGObject = $GatewayIPConfigPri.Subnet.ID.Split('/')[4]                 # Isolates the resource group name
                    $VnetObject = $GatewayIPConfigPri.Subnet.ID.Split('/')[8]               # Isolates the Vnet name
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetObject `
                        -ResourceGroupName $RGObject                                        # Pulls the full virtual network object
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' `
                        -VirtualNetwork $VnetObject                                         # Pulls the full subnet object    
                    :SetAzureGWActiveActive while ($true) {                                 # Inner loop for configuring an Active-Active gateway config
                        $GatewayIPConfig = NewAzVNGatewayIPcon ($SubnetObject, $GatewaySku) # Calls function and assigns output to $var
                        if (!$GatewayIPConfig) {                                            # If $GatewayIPConfig is $null
                            Break SetAzureVNGateway
                        }                                                                   # End if (!$GatewayIPConfig) 
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name) {       # If $GatewayIPConfig.Name equals $GatewayIPConfigPri
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different name for the IP config'  # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name)
                            if ($GatewayIPConfigPri.PublicIPAddress.ID -eq `
                                $GatewayIPConfig.PublicIPAddress.ID) {                      # If $GatewayIPConfigPri.PublicIPAddress.ID equals $GatewayIPConfig.PublicIPAddress.ID
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different public IP config'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfigPri.PublicIPAddress.ID -eq $GatewayIPConfig.PublicIPAddress.ID)
                        }                                                                   # End if ($GatewayIPConfig)    
                        Clear-Host                                                          # Clears screen
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            Break SetAzureGWActiveActive                                    # Breaks :SetAzureGWActiveActive
                        }                                                                   # End if ($GatewayIPConfig) 
                    }                                                                       # End :SetAzureGWActiveActive while ($true)
                }                                                                           # End if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or 'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') 
                else {                                                                      # Else if $GatewaySku does not equal 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3Az' -or 'HighPerformance'
                    Write-Host 'This gateway sku is not compatible with active-active'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureVNGateway                                                 # Breaks :SetAzureVNGateway
                }                                                                           # End else (if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or 'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') )
            }                                                                               # End if ($GatewayObject.IPConfigurations.count -eq '1' -and $GatewayObject.ActiveActive -eq $false)
            :Confirm while ($true) {                                                        # Inner loop to confirm the changes
                Write-Host 'Make the following changes'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Gateway Name: '$GatewayObject.Name                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($GatewayObject.activeActive -eq $false) {                               # If $GatewayObject.activeActive equals $false
                    Write-Host 'Enable Active-Active'                                       # Write message to screen
                }                                                                           # End if ($GatewayObject.activeActive -eq $false)
                else {                                                                      # Else if $GatewayObject.activeActive does not equal $false
                    Write-Host 'Disable Active-Active'                                      # Write message to screen
                }                                                                           # End else (if ($GatewayObject.activeActive -eq $false))
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to make this change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureVNGateway                                                 # Breaks :SetAzureVNGateway
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true)
            Try {                                                                           # Try the following
                if ($GatewayObject.activeActive -eq $false) {                               # If $GatewayObject.activeActive equals $false
                    Write-Host 'Adding seconday IP config'                                  # Write message to screen
                    Add-AzVirtualNetworkGatewayIpConfig -VirtualNetworkGateway `
                        $GatewayObject -Name $GatewayIPConfig.Name -SubnetId `
                        $GatewayIPConfig.Subnet.Id -PublicIpAddressId `
                        $GatewayIPConfig.PublicIPAddress.ID | Out-Null                      # Adds the additional IP config
                    Write-Host 'Enabling Active-Active'                                     # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -EnableActiveActiveFeature -ErrorAction 'Stop'                      # Enables Active-Active 
                }                                                                           # End if ($GatewayObject.activeActive -eq $false)
                else {                                                                      # Else if $GatewayObject.activeActive does not equal $false
                    $GatewayIPConSec = $GatewayObject.IpConfigurations[1].Name              # Gets the secondary IP config      
                    Write-Host 'Removing seconday IP config'                                # Write message to screen
                    Remove-AzVirtualNetworkGatewayIpConfig -Name $GatewayIPConSec `
                        -VirtualNetworkGateway $GatewayObject -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the secondary IP config 
                    Write-Host 'Disabling Active-Active'                                    # Write message to screen
                    Write-Host 'This will take a while'                                     # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -DisableActiveActiveFeature -ErrorAction 'Stop' | Out-Null          # Disables Active-Active
                }                                                                           # End else (if ($GatewayObject.activeActive -eq $false))
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
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
                Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway Active-Active Config has been updated'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureVNGateway                                                         # Breaks :SetAzureVNGateway    
        }                                                                                   # End :SetAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVNGatewayAA