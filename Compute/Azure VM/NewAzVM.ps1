# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-Object:                 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object?view=powershell-7.1
    Get-AzVMSize:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmsize?view=azps-5.4.0
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
    $OperatorConfirm:           Operator confirmation of VM name, username, and password
    $VMCredObject:              Combined $VMUsernameObject and $VMpasswordObject
    $VMBuildObject:             $Var that VM parameters are loaded into
    $VMSizeObject:              VM size object
    $OperatorSelect:            Operator input of selecting NIC
    $NicObject:                 Network interface card object
    $VMImageObject:             Azure marketplace image object
    $VMObject:                  New VM
    GetAzResourceGroup{}        Gets $RGObject
    GetAzVMSize{}               Gets $VMSizeObject
    NewAzNetworkInterface{}     Gets $NicObject
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
    GetAzNetworkInterface{}     Gets $NicObject 
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $VnetObject
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
            Call NewAzNetworkInterface > Get $NicObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $Vnet
                    End GetAzVirtualNetwork
                        Return GetAzVNetSubnetConfig > Send $Vnet
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End NewAzNetworkInterface
                Return NewAzVMWin > Send $ NicObject
            Call GetAzNetworkInterface > Get $NicObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $Vnet
                    End GetAzVirtualNetwork
                        Return GetAzVNetSubnetConfig > Send $Vnet
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End GetAzNetworkInterface
                Return NewAzVMWin > Send $NicObject
            Call GetAzVMSize > Get $VMImageObject
            End GetAzVMSize
                Return NewAzVMWin > Send $VMImageObject
        End NewAzVMWin
            Return Function > Send $VMObject
}#>
function NewAzVM {                                                                          # Creates a new virtual machine
    Begin {                                                                                 # Begin function
        :NewAzureVM while ($true) {                                                         # Outer loop for managing function
            :SetAzureVMType while ($true) {                                                 # Inner loop for setting the VM type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the VM type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVM                                                        # Breaks :NewAzVM
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVMType                                                    # Breaks :SetAzureVMType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzVM'                                                # Sets $Calling function to 'NewAzVM'
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$RGObject) 
            }                                                                               # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.location -eq `
                $RGObject.location}                                                         # Sets $Location object to match $RGObject.location
            :SetAzureVMName while ($true) {                                                 # Inner loop for setting the VM name
                $VMNameObject = Read-Host "New VM Name"                                     # Operator input for the VM name
                if ($VMNameObject -eq 'exit') {                                             # If $VMNameObject equals $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMNameObject -eq 'exit')
                Write-Host $VMNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the VM name? [Y] or [N]"               # Operator confirmation of the VM name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMName                                                    # Breaks :SetAzureVMName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {                                             # Inner loop for setting the VM username
                $VMUserNameObject = Read-Host "VM Local username"                           # Operator input of the local admin user name
                if ($VMUserNameObject -eq 'exit') {                                         # If $VMUsernameObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMUserNameObject -eq 'exit')
                Write-Host $VMUserNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the VM username? [Y] or [N]"           # Operator confirmation of the local admin user name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMUserName                                                # Breaks :SetAzureVMUserName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMUserName while ($true)
            :SetAzureVMPassword while ($true) {                                             # Inner loop for setting the password
                $VMPasswordObject = Read-Host "VM Local password"                           # Operator input for the password
                if ($VMPasswordObject -eq 'exit') {                                         # If $VMPasswordObject equals 'exit'
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if ($VMPasswordObject -eq 'exit')
                Write-Host $VMPasswordObject                                                # Write message to screen
                $OperatorConfirm = Read-Host "Use as the VM password? [Y] or [N]"           # Operator confirmation of the password
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject `
                        -AsPlainText -Force                                                 # Hashes $VMPasswordObject
                    Break SetAzureVMPassword                                                # Breaks :SetAzureVMPassword
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential `
                ($VMUserNameObject, $VMPasswordObject)                                      # Builds credential object using $VMUsernameObject and $VMPasswordObject
            if (!$VMSizeObject) {                                                           # If $VMSizeObject is $null
                $VMSizeObject = GetAzVMSize ($LocationObject)                               # Calls function and assigns output to $var
                if (!$VMSizeObject) {                                                       # If $VMSizeObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$VMSizeObject)
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
            :SetAzureNetwork while ($true) {                                                # Inner loop for creating or selecting NIC
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Write-Host "1. New NIC"                                                 # Write message to screen
                    Write-Host "2. Existing NIC"                                            # Write message to screen
                    $OperatorSelect = Read-Host "[1] or [2]"                                # Operator input for getting the NIC
                    if ($OperatorSelect -eq 'exit') {                                       # If $OperatorSelect equals exit
                        Break NewAzureVM                                                    # Breaks :NewAzureVM
                    }                                                                       # End if ($OperatorSelect -eq 'exit')
                    if ($OperatorSelect -eq '1') {                                          # If $OperatorSelect equals 1
                        $NicObject = NewAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End if ($OperatorSelect -eq '1')
                    elseif ($OperatorSelect -eq '2') {                                      # If $OperatorSelect equals 2
                        $NicObject = GetAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2')
                    else {                                                                  # All other inputs
                        Write-Host "Invalid selection"                                      # Write message to screen
                    }                                                                       # End else(if ($OperatorSelect -eq '1'))
                }                                                                           # End if (!$NicObject)
                Break SetAzureNetwork                                                       # Breaks :SetAzureNetwork
            }                                                                               # End :SetAzureNetwork while ($true)
            $VMBuildObject = Add-AzVMNetworkInterface -VM $VMBuildObject -Id $NicObject.Id  # Adds NIC info to $VMBuildObject
            if (!$VMImageObject) {                                                          # If $VMImageObject is $null
                $VMImageObject = SetAzVMOS ($LocationObject, $ImageTypeObject)              # Calls function and assigns output to $var
                if (!$VMImageObject){                                                       # If $VMImageObject is $null
                    Break NewAzureVM                                                        # Breaks :NewAzureVM
                }                                                                           # End if (!$VMImageObject)
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
            $VMObject = New-AzVM -ResourceGroupName $RGObject.ResourceGroupName `
                -Location $LocationObject.DisplayName -VM $VMBuildObject -Verbose           # Builds the new VM object
            }                                                                               # End Try
            Catch {                                                                         # If catch fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not created'
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End catch
            $VMObject = Get-AzVM -ResourceGroupName $RGObject.ResourceGroupName `
                -Name $VMNameObject                                                         # Pulls the VM Object prior to returning to calling function
            Return $VMObject                                                                # Returns to calling function with $VMObject
        }                                                                                   # End :NewAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVM              