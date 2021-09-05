# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
    Get-AzComputeResourceSku:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azcomputeresourcesku?view=azps-6.3.0
    Add-AzVMNetworkInterface:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-6.3.0
    Update-AzVM:                                https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    AddAzVMNic:                 Function to add a NIC to an existing VM
    GetAzVM:                    Function to a virtual machine
    GetAzNetworkInterface:      Function to get a network interface
} #>
<# Variables: {
    :AddAzureVMNic              Outer loop for managing function
    :SelectAzureNIC             Inner loop for selecting the additional Nic
    :Confirm                    Inner loop for confirming the change
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $VMSize:                    Virtual machine object size
    $MaxNics:                   $VMSize.Capabilities[26].value 
    $VMStatus:                  $VMObjects current power state
    $ExistingNic:               $VMObjects existing network interface
    $SubnetID:                  $ExistingNic.IpConfigurations.Subnet.ID                  
    $NicObject:                 Network interface object
    $SubnetObject:              Unused
    $VnetObject:                Unused
    $PriIP:                     $NicObject.IpConfigurations.PrivateIPAddress[0]             
    $PriIPAll:                  $NicObject.IpConfigurations.PrivateIpAllocationMethod[0] 
    $OpConfirm:                 Operator confirmation to make the change
    $VMNicCount:                $VMObject.NetworkProfile.NetworkInterfaces.count       
    $MSG:                       Last powershell error message
    GetAzNetworkInterface{}
} #>
<# Process Flow {
    AddAzVMNic
        GetAzVM > Get $VMObject
        GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
}#>
function AddAzVMNic {                                                                       # Function to add a NIC to an existing VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVMNic'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureVMNic while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic
            }                                                                               # End if (!$VMObject)
            $VMSize = Get-AzComputeResourceSku -Location $VMObject.Location  | `
                Where-Object {$_.Name -eq $VMObject.HardwareProfile.VmSize}                 # Gets the VM size
            $MaxNics = $VMSize.Capabilities[26].value                                       # Isolates the max number of nics available for VM size
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics) {         # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count -equals $MaxNics
                Write-Host 'This VM already has the max number'                             # Write message ot screen
                Write-Host 'of NICs supported by the VM size'                               # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please remove an existing nic '                                 # Write message ot screen
                Write-Host 'before adding a new one, or please'                             # Write message ot screen
                Write-Host 'change the VM size'                                             # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1) {                # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count is greater than 1
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID[0]                 # Isloates the first NIC ID
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1)
            else {                                                                          # Else If$VMObject.NetworkProfile.NetworkInterfaces.ID.Count is 1 or less
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID                    # Isolates the NIC ID
            }                                                                               # End else (if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1))
            $ExistingNic = Get-AzNetworkInterface | Where-Object {$_.ID -eq $VMSubID}       # Pulls the existing primary Nic object
            if ($ExistingNic.IpConfigurations.Count -gt 1) {                                # If $ExistingNic.IpConfigurations.Count greater than 1 
                $SubnetID = $ExistingNic.IpConfigurations[0].Subnet.ID                      # Isolates the subnet ID    
            }                                                                               # End if ($ExistingNic.IpConfigurations.Count -gt 1) 
            else {                                                                          # Else if $ExistingNic.IpConfigurations.Count equals 1 
                $SubnetID = $ExistingNic.IpConfigurations.Subnet.ID                         # Isolates the subnet ID
            }                                                                               # End else (if ($ExistingNic.IpConfigurations.Count -gt 1) )
            :SelectAzureNIC while ($true) {                                                 # Inner loop for selecting the additional nic
                $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface `
                    ($CallingFunction)                                                      # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End if (!$NicObject)
                if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) {                  # If $NicObject.IpConfigurations.Subnet.ID does not equal $SubnetID 
                    Write-Host 'The selected NIC is on a different subnet'                  # Write message to screen
                    Write-Host 'Please chose a different NIC'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) 
                else {                                                                      # Else if $NicObject.IpConfigurations.Subnet.ID equals $SubnetID
                    Break SelectAzureNIC                                                    # Breaks :SelectAzureNIC
                }                                                                           # End else (if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID))
            }                                                                               # End :SelectAzureNIC while ($true)
            :Confirm while ($true) {                                                        # Inner loop for confirming change
                Write-Host 'Add the following'                                              # Write message to screen
                Write-Host 'Name:      '$NicObject.Name                                     # Write message to screen
                if ($NicObject.IpConfigurations.Count -gt 1) {                              # If $NicObject.IpConfigurations.Count is greater than 1
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress[0]                # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod[0]    # Isolates the private IP allocation method
                }                                                                           # End if ($NicObject.IpConfigurations.Count -gt 1)
                else {                                                                      # Else if $NicObject.IpConfigurations.Count is 1 or less
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress                   # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod       # Isolates the private IP allocation method
                }                                                                           # End else (if ($NicObject.IpConfigurations.Count -gt 1))
                Write-Host 'Private IP:'$PriIP                                              # Write message to screen
                Write-Host 'Allocation:'$PriIPAll                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'To the following VM'                                            # Write message to screen
                Write-Host 'Name:      '$VMObject.Name                                      # Write message to screen
                Write-Host 'RG:        '$VMObject.ResourceGroupName                         # Write message to screen
                if ($VMObject.OS.WindowsConfiguration) {                                    # If $VMObject.OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:    Windows'                                        # Write message to screen
                }                                                                           # End if ($VMObject.OS.WindowsConfiguration)
                elseif ($VMObject.OS.LinuxConfiguration) {                                  # If $VMObject.OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:    Linux'                                          # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to make the change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End elseif ($OpConfirm -eq 'n') 
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen 
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Making the requested changes'                                   # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary) {               # If the first interface is not flagged as primary
                    $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $true           # Sets the first interface primary flag to $true
                }                                                                           # End if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary)
                $VMNicCount = $VMObject.NetworkProfile.NetworkInterfaces.count              # Gets the current number of interfaces
                Add-AzVMNetworkInterface -VM $VMObject -NetworkInterface $NicObject  `
                    -ErrorAction 'Stop' | Out-Null                                          # Adds the additional interface
                $VMObject.NetworkProfile.NetworkInterfaces[$VMNicCount].Primary = $false
                Update-AzVM -VM $VMObject -ResourceGroupName $VMObject.ResourceGroupName `
                    -ErrorAction 'Stop'  | Out-Null
            }                                                                               # End try
            catch {                                                                         # If try fails
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
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The selected NIC has been added to the VM'                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureVMNic                                                             # Breaks :AddAzureVMNic    
        }                                                                                   # End :AddAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVMNic