# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzPublicIpAddress:                   https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azpublicipaddress?view=azps-5.5.0    
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    RemoveAzPublicIPAddress:    Removes an existing public IP address
    GetAzPublicIPAddress:       Gets an existing public IP address
} #>
<# Variables: {      
    :RemoveAzurePublicIP        Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $PublicIPObject:            Public IP object
    $AttachedNIC:               Nic object if attached to $PublicIPObject
    $AttachedNICIPConfig:       IP config object on $AttachedNIC
    $OpConfirm:                 Operator confirmation to remove the public IP sku
} #>
<# Process Flow {
    function
        Call RemoveAzPublicIPAddress > Get $null
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return RemoveAzPublicIPAddress > Send $PublicIPObject
        End RemoveAzPublicIPAddress
            Return function > Send $null
}#>
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