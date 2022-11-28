# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
    Remove-AzVirtualNetworkGateway:             https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/GetAzVNGateway.ps1
} #>
<# Functions Description: {
    RemoveAzVNGateway:          Function to remove a virtual network gateway
    GetAzVNGateway:             Function to get a virtual network gateway
} #>
<# Variables: {      
    :RemoveAzureGateway         Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $GatewayObject:             Gateway object
    $VNetName:                  $GatewayObject.IPConfigurations.Subnet.ID.Split('/')[8]  
    $OpConfirm:                 Operator confirmation to remove the gateway
    $MSG:                       Last powershell error message
    GetAzVNGateway{}            Gets $GatewayObject
    
} #>
<# Process Flow {
    function
        Call RemoveAzVNGateway > Get $null
            Call GetAzVNGateway > Get $GatewayObject            
            End GetAzVNGateway
                Return RemoveAzVNGateway > Send $GatewayObject
        End RemoveAzVNGateway
            Return function > Send $null
}#>
function RemoveAzVNGateway {                                                                # Function to remove a virtual network gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVNGateway'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureGateway while ($true) {                                                 # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject does not have a value
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway
            }                                                                               # End if (!$GatewayObject)
            $VNetName = $GatewayObject.IPConfigurations.Subnet.ID.Split('/')[8]             # Isolates the Vnet name
            Write-Host 'Remove Gateway: '$GatewayObject.name                                # Write message to screen
            Write-Host 'From VNet:      '$VNetName                                          # Write message to screen
            Write-Host 'From RG:        '$GatewayObject.ResourceGroupName                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the gateway
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the gateway'                                           # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkGateway -Name $GatewayObject.Name `
                        -ResourceGroupName $GatewayObject.ResourceGroupName `
                        -Force -ErrorAction 'Stop' | Out-Null                               # Removes the gateway
                }                                                                           # End Try
                catch {                                                                     # If Try fails
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
                    Break RemoveAzureGateway                                                # Breaks :RemoveAzureGateway    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The gateway has been removed'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNGateway