# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzPublicIpAddress:   https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azpublicipaddress?view=azps-5.5.0    
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
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
    $CallingFunction:           Name of this function
    $PublicIPObject:            Public IP object
    $AttachedNIC:               Nic object if attached to $PublicIPObject
    $AttachedNICIPConfig:       IP config object on $AttachedNIC
    $OperatorConfirm:           Operator confirmation to remove the public IP sku
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
        :RemoveAzurePublicIP while ($true) {                                                # Outer loop for managing function
            $CallingFunction = 'RemoveAzPublicIPAddress'                                    # Sets $CallingFunction
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End if (!$PublicIPObject)
            }                                                                               # End if (!$PublicIPObject)
            if ($PublicIPObject.IpConfiguration.Id) {                                       # If PublicIPObject.IpConfiguration.Id has a value
                $AttachedNIC = ($PublicIPObject.IpConfiguration.Id).Split('/')[-3]          # Gets the attached NIC name
                $AttachedNICIPConfig = ($PublicIPObject.IpConfiguration.Id).Split('/')[-1]  # Gets the attached NIC IP config name
                Write-Host 'The selecting IP sku cannot be deleted'                         # Write message to screen
                Write-Host 'Please detach this sku from the following'                      # Write message to screen
                Write-Host 'Attached NIC:   '$AttachedNIC                                   # Write message to screen
                Write-Host 'Nic config name:'$AttachedNICIPConfig                           # Write message to screen
                Break RemoveAzurePublicIP                                                   # Breaks :RemoveAzurePublicIP
            }                                                                               # End if ($PublicIPObject.IpConfiguration.Id)
            else {                                                                          # If PublicIPObject.IpConfiguration.Id does not have a value
                Write-Host 'Remove the public IP'$PublicIPObject.name                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation to remove the public IP
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Remove-AzPublicIpAddress -Name $PublicIPObject.Name `
                            -ResourceGroupName $PublicIPObject.ResourceGroupName `
                            -Force -ErrorAction 'Stop'                                      # Removes the selected IP sku
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'You may not have to the permissions'                    # Write message to screen
                        Write-Host 'The resource or group maybe locked'                     # Write message to screen
                        Break RemoveAzurePublicIP                                           # Breaks :RemoveAzurePublicIP
                    }                                                                       # End catch
                    Write-Host 'The selected public IP sku has been removed'                # Write message to screen
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                else {                                                                      # If $OperatorConfirm does not equal 'y'
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End else (if ($OperatorConfirm -eq 'y'))
            }                                                                               # End else (if ($PublicIPObject.IpConfiguration.Id))
        }                                                                                   # End :RemoveAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzPublicIPAddress