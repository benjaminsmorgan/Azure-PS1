# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-Object:                 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object?view=powershell-7.1
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.4.0
    Get-AzComputeResourceSku:   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azcomputeresourcesku?view=azps-6.0.0
    New-AzVMConfig:             https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmconfig?view=azps-5.4.0
    Set-AzVMOperatingSystem:    https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmoperatingsystem?view=azps-5.4.0
    Add-AzVMNetworkInterface:   https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-5.4.0
    Get-AzVMImageSku:           https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku?view=azps-5.4.0
    Get-AzVMImage:              https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimage?view=azps-5.4.0
    Set-AzVMSourceImage:        https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmsourceimage?view=azps-5.4.0
    New-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm?view=azps-5.4.0     
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
    GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
} #>
<# Functions Description: {
    NewAzVM:                    Creates a new virtual machine
    NewAzNetworkInterface:      Creates a new network interface
    GetAzVNetSubnetConfig:      Gets a vnet subnet
    GetAzVirtualNetwork:        Gets a virtual network
    GetAzNetworkInterface:      Gets a network interface
    GetAzResourceGroup:         Gets a resource group 
    SetAzVMOS:                  Gets an Azure marketplace image
    GetAzVMSize:                Gets a VM size
} #>
<# Variables: {
    :NewAzureVM                 Outer loop for managing function
    :SetAzureVMType             Inner loop for setting the vm type
    :SetAzureVMName             Inner loop for setting the vm name
    :SetAzureVMUserName         Inner loop for setting the VM local username
    :SetAzureVMPassword         Inner loop for setting the VM local password
    :SetAzureNetwork            Inner loop for setting the VM nic
    $ImageTypeObject:           $var used in setting windows or linux parameters
    $CallingFunction:           Passes the name of this function to GetAzResourceGroup{}
    $RGObject:                  Resource group object
    $LocationObject:            Location object, based of resource group location
    $VMNameObject:              VM name object
    $VMUserNameObject:          VM user name object
    $VMPasswordObject:          VM password object
    $OpConfirm:                 Operator confirmation of VM name, username, and password
    $VMCredObject:              Combined $VMUsernameObject and $VMpasswordObject
    $VMBuildObject:             $Var that VM parameters are loaded into
    $VMSizeObject:              VM size object
    $NicObject:                 Network interface card object
    $VMImageObject:             Azure marketplace image object
    $VMObject:                  New VM
    GetAzResourceGroup{}        Gets $RGObject
    GetAzVMSize{}               Gets $VMSizeObject
    GetAzNetworkInterface{}     Gets $NicObject,  
    SetAzVMOS{}                 Gets $VMImageObject
} #>
<# Process Flow {
    Function
        Call NewAzVMWin > Get $VMObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzVMWin > Send $RGObject
            Call GetAzVMSize > Get $VMSizeObject
            End GetAzVMSize
                Return NewAzVMWin > Send $VMSizeObject
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return NewAzVMWin > Send $NicObject,$SubnetObject,$VnetObject
            Call GetAzVMSize > Get $VMImageObject
            End GetAzVMSize
                Return NewAzVMWin > Send $VMImageObject
        End NewAzVMWin
            Return Function > Send $VMObject
}#>
function NewAzVM {                                                                          # Function to create a new virtual machine
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzVM'                                                    # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureVM while ($true) {                                                         # Outer loop for managing function
            :SetAzureVMType while ($true) {                                                 # Inner loop for setting the VM type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Windows'                                                    # Write message to screen
                Write-Host '[2] Linux'                                                      # Write message to screen
                $ImageTypeObject = Read-Host 'Option [#]'                                   # Operator input for the VM type
                Clear-Host                                                                  # Clears screen
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVM                                                        # Breaks :NewAzVM
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVMType                                                    # Breaks :SetAzureVMType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls (Function) GetAzResourceGroup to get $RGObject
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$RGObject) 
            $LocationObject = Get-AzLocation | Where-Object {$_.location -eq `
                $RGObject.location}                                                         # Sets $Location object to match $RGObject.location
            Write-Host $LocationObject.Location
            :SetAzureVMName while ($true) {                                                 # Inner loop for setting the VM name
                $VMNameObject = Read-Host 'New VM Name'                                     # Operator input for the VM name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMNameObject' as the VM name'                             # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the VM name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVMName                                                    # Breaks :SetAzureVMName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {                                             # Inner loop for setting the VM username
                $VMUserNameObject = Read-Host 'VM Local username'                           # Operator input of the local admin user name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMUserNameObject' as the local username'                  # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the local admin user name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureVMUserName                                                # Breaks :SetAzureVMUserName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMUserName while ($true)
            :SetAzureVMPassword while ($true) {                                             # Inner loop for setting the password
                $VMPasswordObject = Read-Host 'VM Local password'                           # Operator input for the password
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$VMPasswordObject' as the local username password'         # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the password
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($OpConfirm -eq 'e') 
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject `
                        -AsPlainText -Force                                                 # Hashes $VMPasswordObject
                    Break SetAzureVMPassword                                                # Breaks :SetAzureVMPassword
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential `
                ($VMUserNameObject, $VMPasswordObject)                                      # Builds credential object using $VMUsernameObject and $VMPasswordObject
            $VMSizeObject = GetAzVMSize ($CallingFunction, $LocationObject)                 # Calls function and assigns output to $var
            if (!$VMSizeObject) {                                                           # If $VMSizeObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$VMSizeObject)
            $VMBuildObject = New-AzVMConfig -VMName $VMNameObject -VMSize `
                $VMSizeObject.Name                                                          # Starts $VMBuildObject
            if ($ImageTypeObject -eq '1') {                                                 # If $ImageTypeObject equals '1'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Windows `
                    -ComputerName $VMNameObject -Credential $VMCredObject -ProvisionVMAgent `
                    -EnableAutoUpdate                                                       # Adds VM info to $VMBuildObject
            }                                                                               # End if ($ImageTypeObject -eq '1') 
            elseif ($ImageTypeObject -eq '2') {                                             # If $ImageTypeObject equals '2'
                $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Linux `
                    -ComputerName $VMNameObject -Credential $VMCredObject                   # Adds VM info to $VMBuildObject
            }                                                                               # End elseif ($ImageTypeObject -eq '2')
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface `
                ($CallingFunction, $LocationObject)                                         # Calls function and assigns output for $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$NicObject)
            else {                                                                          # If $NicObject has a value
                Break SetAzureNetwork                                                       # Breaks :SetAzureNetwork
            }                                                                               # End else (if (!$NicObject))
            $VMBuildObject = Add-AzVMNetworkInterface -VM $VMBuildObject -Id $NicObject.Id  # Adds NIC info to $VMBuildObject
            $VMImageObject = SetAzVMOS ($CallingFunction, $LocationObject, $ImageTypeObject)# Calls function and assigns output to $var
            if (!$VMImageObject){                                                           # If $VMImageObject is $null
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End if (!$VMImageObject)
            if ($VMImageObject.Version) {                                                   # If $VMImageObject.Version has a value
                $VMBuildObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $VMImageObject.PublisherName -Offer $VMImageObject.Offer -Skus `
                $VMImageObject.Skus -Version $VMImageObject.Version                         # Adds image setting to $VMBuildObject
            }                                                                               # End if ($VMImageObject.Version)
            else {                                                                          # If $VMImageObject.Version does not have a value
                $VMBuildObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $VMImageObject.PublisherName -Offer $VMImageObject.Offer -Skus `
                $VMImageObject.Skus -Version 'latest'                                       # Adds image setting to $VMBuildObject
            }                                                                               # End else (if ($VMImageObject.Version))
            Try {                                                                           # Try the following
                Write-Host 'Attempting to build the VM'                                     # Write message to screen
                Write-Host 'This may take a few minutes'                                    # Write message to screen
                New-AzVM -ResourceGroupName $RGObject.ResourceGroupName -VM $VMBuildObject `
                -Location $LocationObject.Location -Verbose  
                    -ErrorAction 'Stop'                                                     # Builds the new VM object
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not created'                                         # Write message to screen
                Write-Host 'The image and VM may'                                           # Write message to screen
                Write-host 'be different generations'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End catch
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'The VM has been created'                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVM                                                                # Breaks :NewAzureVM
        }                                                                                   # End :NewAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVM   