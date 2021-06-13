# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/set-azpublicipaddress?view=azps-5.5.0    
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    SetAzPublicIPAddressAllo    Chages an existing public IP address allocation method
    GetAzPublicIPAddress:       Gets an existing public IP address
} #>
<# Variables: {      
    :SetAzurePublicIP           Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $PublicIPObject:            Public IP object
    $AttachedNIC:               Nic object if attached to $PublicIPObject
    $AttachedNICIPConfig:       IP config object on $AttachedNIC
    $OpConfirm:                 Operator confirmation to change the public IP sku
} #>
<# Process Flow {
    function
        Call SetAzPublicIPAddressAllo > Get $null
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return SetAzPublicIPAddressAllo > Send $PublicIPObject
        End SetAzPublicIPAddressAllo
            Return function > Send $null
}#>
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