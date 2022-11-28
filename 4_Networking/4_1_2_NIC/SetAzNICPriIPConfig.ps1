# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.0.0                
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
} #>
<# Functions Description: {
    SetAzNICPriIPConfig:        Updates a NIC IP primary configuration
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         Nic IP configuration object
    $NicObject:                 Nic object
    $VMID:                      $NicIPConfigObject.VirtualMachine.ID, if present          
    $VMObject:                  Attached virtual machine object if present
    $SubnetID:                  $NicIPConfigObject.Subnet.ID
    $OpConfirm:                 Operator confirmation of the change
    GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
} #>
<# Process Flow {
    function
        Call SetAzNICPriIPConfig > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
            End GetAzNICIpConfig
                Return SetAzNICPriIPConfig > Send $NicIPConfigObject,$NicObject
        End SetAzNICPriIPConfig
            Return function > Send $null
}#>
function SetAzNICPriIPConfig {                                                              # Function to set the primary config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICPriIPConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            if ($NicObject.VirtualMachine) {                                                # If $NicObject.VirtualMachine has a value 
                $VMID = $NicObject.VirtualMachine.Id                                        # Isolates the VM ID
                $VMObject = Get-AzVM | Where-Object {$_.ID -eq $VMID}                       # Gets the currently attached VM
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This nic is currently attached to the following:'               # Write message to screen
                Write-Host 'VM Name:'$VMObject.Name                                         # Write message to screen
                Write-Host 'VM RG  :'$VMObject.ResourceGroupName                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This NIC cannot be updated while attached'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicObject.VirtualMachine)
            if ($NicIPConfigObject.Primary -eq 'True') {                                    # If $NicIPConfigObject.Primary equals 'True'
                Write-Host 'This configuration is already the primary'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicIPConfigObject.Primary -eq 'True')
            Write-Host 'Set the following as the primary config'                            # Write message to screen
            Write-Host 'Config:'$NicIPConfigObject.Name                                     # Write message to screen
            Write-Host 'On Nic:'$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation of change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Updating primary config on:'$NicObject.Name                     # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -SubnetId $SubnetID -Primary -ErrorAction 'Stop' | Out-Null             # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks SetAzureNICIpConfig
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The primary config has been changed'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin       
}                                                                                           # End function SetAzNICPriIPConfig