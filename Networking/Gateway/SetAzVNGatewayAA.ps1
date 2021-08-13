# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
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
    :Confirm                    Inner loop to confirm the changes
    $CallingFunction:           Name of this function
    $GatewayObject:             Gateway object
    $MSG:                       Last powershell error message
    GetAzVNGateway{}            Gets $GatewayObject
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
            if ($GatewayObject.IPConfigurations.count -eq '1') {                            # If $GatewayObject.IPConfigurations.count equals '1'
                Write-Host 'This gateway cannot be configured'                              # Write message to screen
                Write-Host 'with Active-Active configuration'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Active-Active configuration requires'                           # Write message to screen
                Write-Host '2 public IP configurations which'                               # Write message to screen
                Write-Host 'must be added when the gateway is'                              # Write message to screen
                Write-Host 'Created'                                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway 
            }                                                                               # End if ($GatewayObject.IPConfigurations.count -eq '1')
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
            #Try {                                                                           # Try the following
                if ($GatewayObject.activeActive -eq $false) {                               # If $GatewayObject.activeActive equals $false
                    Write-Host 'Enabling Active-Active'                                     # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -EnableActiveActiveFeature -ErrorAction 'Stop'                      # Enables Active-Active 
                }                                                                           # End if ($GatewayObject.activeActive -eq $false)
                else {                                                                      # Else if $GatewayObject.activeActive does not equal $false
                    Write-Host 'Disabling Active-Active'                                    # Write message to screen
                    Set-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                        -DisableActiveActiveFeature -ErrorAction 'Stop'                     # Disables Active-Active
                }                                                                           # End else (if ($GatewayObject.activeActive -eq $false))
            #}                                                                               # End Try
            #Catch {                                                                         # If Try fails
            #    Clear-Host                                                                  # Clears screen
            #    Write-Host 'An error has occured'                                           # Write message to screen
            #    Write-Host ''                                                               # Write message to screen
            #    $MSG = $Error[0]                                                            # Gets the error message
            #    if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
            #        $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
            #        Write-Warning $MSG                                                      # Write message to screen
            #        Write-Host ''                                                           # Write message to screen    
            #    }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
            #    else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
            #        Write-Warning $MSG                                                      # Write message to screen
            #        Write-Host ''                                                           # Write message to screen        
            #    }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
            #    Write-Host 'No changes have been made'                                      # Write message to screen
            #    Write-Host ''                                                               # Write message to screen
            #    Pause                                                                       # Pauses all actions for operator input
            #    Break SetAzureVNGateway                                                     # Breaks :SetAzureVNGateway    
            #}                                                                               # End Catch
            #Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway Active-Active Config has been updated'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureVNGateway                                                         # Breaks :SetAzureVNGateway    
        }                                                                                   # End :SetAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVNGatewayAA