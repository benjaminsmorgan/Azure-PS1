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
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Start-AzVM:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Stop-AzVM:                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Invoke-AzVMReimage:         https://docs.microsoft.com/en-us/powershell/module/az.compute/Invoke-AzVMReimage?view=azps-5.4.0
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/NewAzVM.ps1
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1                    
    StartAzVM:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StartAzVM.ps1
    StopAzVM:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/StopAzVM.ps1
    ReImageAzVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/ReimageAzVM.ps1
    RemoveAzVM:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/RemoveAzVM.ps1
    SetAzVMOS:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/SetAzVMOS.ps1
    GetAzVMSize:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVMSize.ps1
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzVM:                 Management function for VMs
    NewAzVM:                    Creates a new virtual machine
    GetAzVM:                    Gets an existing VM                    
    StartAzVM:                  Starts a selected VM
    StopAzVM:                   Stops a selected VM
    ReImageAzVM:                Reimages a selected VM
    RemoveAzVM:                 hRemoves a selected VM
    SetAzVMOS:                  Selects a market place image
    GetAzVMSize:                Gets a VM size
    NewAzNetworkInterface:      Creates a new network interface
    GetAzVNetSubnetConfig:      Gets a vnet subnet
    GetAzVirtualNetwork:        Gets a virtual network
    GetAzNetworkInterface:      Gets a network interface
    GetAzResourceGroup:         Gets a resource group 
} #>
<# Variables: {
    :ManageAzureVM              Outer loop for managing function
    $OpSelect:                  Operator input for management function
    $RGObject:                  Resource group object
    $VMObject:                  Virtual machine object
    $LocationObject:            Location object
    NewAzVM{}                   Creates $VMObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzVMSize{}               Gets $VMSizeObject
        NewAzNetworkInterface{}     Gets $NicObject
            GetAzVNetSubnetConfig{} Gets $SubnetObject
                GetAzVirtualNetwork{}       Gets $VnetObject
        GetAzNetworkInterface{}     Gets $NicObject 
            GetAzVNetSubnetConfig{} Gets $SubnetObject
                GetAzVirtualNetwork{}       Gets $VnetObject
        SetAzVMOS{}                 Gets $VMImageObject
    GetAzVM{}                   Gets $VMObject
    StartAzVM{}                 Starts $VMObject
        GetAzVM{}                   Gets $VMObject
    StopAzVM{}                  Stopss $VMObject
        GetAzVM{}                   Gets $VMObject
    ReimageAzVM{}               Reimages $VMObject
        GetAzVM{}                   Gets $VMObject
    RemoveAzVM{}                Removes $VMObject
        GetAzVM{}                   Gets $VMObject
} #>
<# Process Flow {
    Function
        Call ManageAzVM > Get $null
        End ManageAzVM
            Return Function > Send $null
}#>
function ManageAzVM {                                                                       # Function to manage VMs
    Begin {                                                                                 # Begin function
        :ManageAzureVM while ($true) {                                                      # Outer loop for managing function
            Write-Host 'Azure VM Management'                                                # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Create New VM'                                                  # Write message to screen
            Write-Host '[2] List VMs'                                                       # Write message to screen
            Write-Host '[3] Start VM'                                                       # Write message to screen
            Write-Host '[4] Stop VM'                                                        # Write message to screen
            Write-Host '[5] Reimage VM'                                                     # Write message to screen
            Write-Host '[6] Remove VM'                                                      # Write message to screen
            $OpSelect = Read-Host "Option?"                                                 # Operator input on management option
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureVM                                                         # Ends :ManageAzureVM loop, leading to return statement
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $Opselect equals '1'
                Write-Host 'Create New VM'                                                  # Write message to screen
                NewAzVM                                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $Opselect equals '2'
                Write-Host 'List VMs'                                                       # Write message to screen
                ListAzVM                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $Opselect equals '3'
                Write-Host 'Start VM'                                                       # Write message to screen
                StartAzVM:                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $Opselect equals '4'
                Write-Host 'Stop VM'                                                        # Write message to screen
                StopAzVM                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $Opselect equals '5'
                Write-Host 'Reimage VM'                                                     # Write message to screen
                ReimageAzVM                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $Opselect equals '6'
                Write-Host 'Remove VM'                                                      # Write message to screen
                RemoveAzVM                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else(if ($OpSelect -eq '0'))
        }                                                                                   # End ManageAzureVM while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVM
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
            :SetAzureNetwork while ($true) {                                                # Inner loop for creating or selecting NIC
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Write-Host 'VM network configuration'                                   # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New NIC'                                                # Write message to screen
                    Write-Host '[2] Existing NIC'                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for getting the NIC
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break NewAzureVM                                                    # Breaks :NewAzureVM
                    }                                                                       # End if ($OpSelect -eq '0')
                    if ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                        Write-Host 'The current VM build'                                   # Write message to screen
                        Write-Host 'resource group is:'$RGObject.ResourceGroupName          # Write message to screen
                        $NicObject = NewAzNetworkInterface `
                            ($CallingFunction, $LocationObject)                             # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End if ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # If $OpSelect equals 2
                        Write-Host 'The current VM build'                                   # Write message to screen
                        Write-Host 'resource group is:'$RGObject.ResourceGroupName          # Write message to screen
                        $NicObject = GetAzNetworkInterface `
                            ($CallingFunction, $LocationObject)                             # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVM                                                # Breaks :NewAzureVM
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else(if ($OpSelect -eq '1'))
                }                                                                           # End if (!$NicObject)
                Break SetAzureNetwork                                                       # Breaks :SetAzureNetwork
            }                                                                               # End :SetAzureNetwork while ($true)
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
                New-AzVM -ResourceGroupName $RGObject.ResourceGroupName -Location `
                    $LocationObject.DisplayName -VM $VMBuildObject -Verbose `
                    -ErrorAction 'Stop'                                                     # Builds the new VM object
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not created'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVM                                                            # Breaks :NewAzureVM
            }                                                                               # End catch
            Write-Host 'The VM has been created'                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVM                                                                # Breaks :NewAzureVM
        }                                                                                   # End :NewAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVM                                                                                   # End function GetAzVMSize 
function GetAzVM {                                                                          # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' =  $_.ResourceGroupName; 'Status' = $_.PowerState                  # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VMList)
            Write-Host "Exit:    0"                                                         # Write message to screen
            Write-Host ""                                                                   # Write message to screen 
            foreach ($_ in $VMArray) {                                                      # Writes all VMs to screen
                Write-Host "Number: "$_.Number                                              # Write message to screen 
                Write-Host "Name:   "$_.Name                                                # Write message to screen 
                Write-Host "RG:     "$_.RG                                                  # Write message to screen
                Write-Host "Status: "$_.Status                                              # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            :GetAzureVMName while ($true) {                                                 # Inner loop for selecting VM from list
                $VMSelect = Read-Host "Please enter the number of the VM"                   # Operator input for the selection
                if ($VMSelect -eq '0') {                                                    # If $VMSelect is 0
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                $VMListSelect = $VMArray | Where-Object {$_.Number -eq $VMSelect}           # Isolates selected VM 
                if ($VMListSelect) {                                                        # If $VMListSelect has a valud
                    $VMObject = Get-AzVM -ResourceGroupName $VMListSelect.RG `
                        -Name $VMListSelect.Name                                            # Pulls full $VMObject
                    if ($VMObject) {                                                        # If $VMObject has a value
                        Return $VMObject                                                    # Returns to calling function with $VMObject
                    }                                                                       # End if ($VMObject)
                    else {                                                                  # If $VMObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVM                                                    # Breaks :GetAzureVM
                    }                                                                       # End else (if ($VMObject))
                }                                                                           # End if ($VMListSelect)
                Write-Host "That was not a valid selection"                                 # Write message to screen 
            }                                                                               # End :GetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzureVMName
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OpConfirm = Read-Host "Power on "$VMObject.Name "[Y] or [N]"             # Operator confirmation to turn on the VM
            if (!($OpConfirm -eq 'y')) {                                              # If OpConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!($OpConfirm -eq 'y'))
            Write-Host "Attempting to power on" $VMObject.Name                              # Write message to screen
            Start-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName      # Starts the selected VM
            Break StartAzureVM                                                              # Breaks :StartAzureVM
        }                                                                                   # End :StartAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OpConfirm = Read-Host "Shutdown"$VMObject.Name "[Y] or [N]"              # Operator input to shutdown the VM
            if (!($OpConfirm -eq 'y')) {                                              # If OpConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!($OpConfirm -eq 'y'))
            Write-Host "Attempting to shut off" $VMObject.Name                              # Write message to screen
            Stop-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force                                                                      # Stops the selected VM
            Break StopAzureVM                                                               # Breaks :StopAzureVM
        }                                                                                   # End :StopAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM
function ReimageAzVM {                                                                      # Function to remove a VM
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables powershell error reporting
        :ReimageAzVM while ($true) {                                                        # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break ReimageAzVM                                                       # Breaks :ReimageAzVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OpConfirm = Read-Host "Reimage"$VMObject.Name "[Y] or [N]"               # Operator confirmation to reimage the VM
            if (!($OpConfirm -eq 'y')) {                                              # If OpConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End if (!($OpConfirm -eq 'y'))
            Write-Host "Attempting to reimage" $VMObject.Name                               # Write message to screen
            try {                                                                           # Try the following
                Invoke-AzVMReimage -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'stop'                         # Reimages the selected VM
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host ""                                                               # Write message to screen
                Write-Host "***An Error Has Occured***"                                     # Write message to screen
                Write-Host "Un-able to reimage the selected VM"                             # Write message to screen
                Write-Host "Auto OS upgrades may not be enabled"                            # Write message to screen
                Write-Host "You may not have permission to this VM"                         # Write message to screen
                Write-Host "The VM or group may be locked"                                  # Write message to screen
                Write-Host ""                                                               # Write message to screen
                Break ReimageAzVM                                                           # Breaks :ReimageAzVM
            }                                                                               # End Catch
            Break ReimageAzVM                                                               # Breaks :ReimageAzVM
        }                                                                                   # End :ReimageAzVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ReimageAzVM
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables powershell reporting
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OpConfirm = Read-Host "Remove"$VMObject.Name "[Y] or [N]"                # Operator confirmation to remove the VM
            if (!($OpConfirm -eq 'y')) {                                              # If OpConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!($OpConfirm -eq 'y'))
            Write-Host "Attempting to remove" $VMObject.Name                                # Write message to screen
            Try {                                                                           # Try the following
            Remove-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force -ErrorAction 'Stop'                                                  # Removes the selected VM
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not removed'                                         # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host ''                                                               # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End catch
            Break RemoveAzureVM                                                             # Breaks :RemoveAzureVM
        }                                                                                   # End :RemoveAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM

# Additional functions required for ManageAzVM
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Windows'                                                # Write message to screen
                    Write-Host '[2] Linux'                                                  # Write message to screen
                    $ImageTypeObject = Read-Host 'Option [#]'                               # Operator input for the image type
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$ImageTypeObject)
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break GetAzureVMImage                                                   # Breaks :GetAzureVMImage
                }                                                                           # End if ($ImageTypeObject -eq '0') 
                elseif ($ImageTypeObject -eq '1') {                                         # Else if $ImageTypeObject equals 1
                    $VMPublisherObject = 'MicrosoftWindowsServer'                           # Sets the Windows publisher
                    Break GetAzureImagePublisher                                            # Breaks :GetAzureImagePublisher
                }                                                                           # End elseif ($ImageTypeObject -eq '1')
                elseif ($ImageTypeObject -eq '2') {                                         # Else if $ImageTypeObject equals 2
                    :GetAzureLinuxPublisher while ($true) {                                 # Outer loop to manage function
                        [System.Collections.ArrayList]$ImagePublisherArray = @()            # Creates the valid Pub array
                        $ImagePublisherList = @('Ubuntu','RedHat','CentOS','SUSE','Debian', `
                            'Oracle','CoreOS')                                              # Creates a list of items to load into $ImagePublisherArray Array
                        $ImagePublisherNumber = 1                                           # Sets the base number for the valid Pub array
                        foreach ($_ in $ImagePublisherList) {                               # For each item in $ImagePublisherList
                            $ImagePublisherInput = [PSCustomObject]@{'Name' = $_;'Number' `
                                = $ImagePublisherNumber}                                    # Creates the item to loaded into array
                            $ImagePublisherArray.Add($ImagePublisherInput) | Out-Null       # Loads item into array, out-null removes write to screen
                            $ImagePublisherNumber = $ImagePublisherNumber + 1               # Increments $ImagePublisherNumber up 1
                        }                                                                   # End foreach ($_ in $ImagePublisherList)
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            Write-Host '[0] Exit'                                           # Write message to screen
                            foreach ($_ in $ImagePublisherArray) {                          # For each item in $ImagePublisherArray
                                $Number = $_.Number
                                Write-Host "[$Number]" $_.Name                              # Write message to screen
                            }                                                               # End foreach ($_ in $ImagePublisherArray)
                            Write-Host ''                                                   # Write message to screen
                            if ($CallingFunction) {                                         # If $CallingFunction has a value
                                Write-Host `
                                    'You are selecting the publisher for:'$CallingFunction  # Write message to screen
                            }                                                               # End if ($CallingFunction)
                            $OpSelect = Read-Host 'Option [#]'                              # Operator selection of the publisher
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq '0') {                                        # If $OpDelect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($OpSelect -eq '0')
                            if ($OpSelect -in $ImagePublisherArray.Number) {                # If $OpSelect in $ImagePublisherArray.Number 
                                $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                    {$_.Number -eq $OpSelect}                               # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $OpSelect
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End if ($OpSelect -in $ImagePublisherArray.Number)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (# End If ($VMPublisherObject))
                        }                                                                   # End :SelectAzurePub while ($true)
                        if ($VMPublisherObject.Name -eq 'Ubuntu') {                         # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Canonical'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End ($VMPublisherObject.Name -eq 'Ubuntu')
                        elseif ($VMPublisherObject.Name -eq 'RedHat') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'RedHat'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'RedHat')
                        elseif ($VMPublisherObject.Name -eq 'CentOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'OpenLogic'                                # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CentOS')
                        elseif ($VMPublisherObject.Name -eq 'SUSE') {                       # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'SUSE'                                     # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'SuSE')
                        elseif ($VMPublisherObject.Name -eq 'Debian') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'credativ'                                 # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Debian')
                        elseif ($VMPublisherObject.Name -eq 'Oracle') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'Oracle-Linux'                             # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'Oracle')
                        elseif ($VMPublisherObject.Name -eq 'CoreOS') {                     # If $VMPublisherObject equals this value
                            $VMPublisherObject = 'CoreOS'                                   # Reassigns the value of $VMPublisherObject
                        }                                                                   # End elseif ($VMPublisherObject.Name -eq 'CoreOS')
                        Break GetAzureImagePublisher                                        # Breaks :GetAzureImagePublisher
                    }                                                                       # End GetAzureVMImage
                }                                                                           # End elseif ($ImageTypeObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {                                             # Inner loop for setting the image offer
                $ImageOfferList = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject                                       # Generates the image offer list
                $ImageOfferNumber = 1                                                       # Sets $ImageOfferNumber to 1
                [System.Collections.ArrayList]$ImageOfferArray = @()                        # Creates the valid Pub array
                foreach ($Offer in $ImageOfferList) {                                       # For each $Offer in $ImageOfferList
                    $ImageOfferInput = [PSCustomObject]@{'Name' = $Offer.Offer; `
                        'Number' = $ImageOfferNumber}                                       # Creates the item to loaded into array
                    $ImageOfferArray.Add($ImageOfferInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                    $ImageOfferNumber = $ImageOfferNumber + 1                               # Increments $ImageofferNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ImageOfferArray) {                                      # For each $_ in $ImageOfferArray
                        $Number = $_.Number                                                 # Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]  " $_.Name                                # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ImageOfferArray)
                    Write-Host ''                                                           # Write message to screen
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host `
                            'You are selecting the image offer for:'$CallingFunction        # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the offer selection
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OpSelect -eq '0')
                    if ($OpSelect -in $ImageOfferArray.Number) {                            # If $OpSelect in $ImageOfferArray.Number
                        $VMOfferObject = $ImageOfferArray | Where-Object `
                            {$_.Number -eq $OpSelect}                                       # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OpSelect
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($OpSelect -in $ImageOfferArray.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -in $ImageOfferArray.Number)))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               # Inner loop for selecting the image sku
                $VMOfferObject = Get-AzVMImageOffer -Location $LocationObject.Location `
                    -PublisherName $VMPublisherObject | Where-Object {$_.Offer `
                    -eq $VMOfferObject.Name}                                                # Pulls the full $VMOfferObject
                $ImageSkuList = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                    -Location $LocationObject.DisplayName -PublisherName $VMPublisherObject # Generates the $ImageSkuList
                $ImageSkuNumber = 1                                                         # Sets $ImageSkuNumber to 1
                [System.Collections.ArrayList]$ImageSkuArray = @()                          # Creates the $ImageSkuArray     
                foreach ($Skus in $ImageSkuList) {                                          # For each Sku in $ImageSkuList
                    $ImageSkuInput = [PSCustomObject]@{'Name' = $Skus.Skus; `
                        'Number' = $ImageSkuNumber}                                         # Creates the item to loaded into array
                    $ImageSkuArray.Add($ImageSkuInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    $ImageSkuNumber = $ImageSkuNumber + 1                                   # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ImageSkuArray) {                                        # For each $_ in $ImageSkuArray
                        $Number = $_.Number                                                 # Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]  " $_.Name                                # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ImageOfferArray)
                    Write-Host ''                                                           # Write message to screen
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host `
                            'You are selecting the image sku for:'$CallingFunction          # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the offer selection
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OpSelect -eq '0')
                    if ($OpSelect -in $ImageSkuArray.Number) {                              # If $OpSelect in $imageSkuArray.Number
                        $VMSkuObject = $ImageSkuArray | Where-Object `
                            {$_.Number -eq $OpSelect}                                       # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $OpSelect
                        $VMSkuObject = Get-AzVMImageSku -Offer $VMOfferObject.Offer `
                            -Location $LocationObject.DisplayName -PublisherName `
                        $VMPublisherObject | Where-Object {$_.Skus -eq $VMSkuObject.Name}   # Gets the Sku object                                      
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($OpSelect -in $ImageSkuArray.Number) 
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -in $ImageSkuArray.Number) )
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                :SelectAzureImageVerType while ($true) {                                    # Inner loop for chosing current or previous version of sku
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Use current version'                                    # Write message to screen
                    Write-Host '[2] Select version'                                         # Write message to screen
                    $ImageVersionOption = Read-Host 'Option [#]'                            # Operator input for version selection type
                    if ($ImageVersionOption -eq '0') {                                      # If $ImageVersionOption equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($ImageVersionOption -eq '0')            
                    elseif ($ImageVersionOption -eq '1' -or '2') {                          # If $ImageVersionOption equals 1 or 2
                        Break SelectAzureImageVerType                                       # Breaks :SelectAzureImageVerType
                    }                                                                       # End elseif ($ImageVersionOption -eq '1' -or '2')
                    else {                                                                  # If $ImageVersionOption is not equal to 0, 1, or 2
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($ImageVersionOption -eq '0'))
                }                                                                           # End :SelectAzureImageVerType while ($true)
                if ($ImageVersionOption -eq '1') {                                          # If $ImageVersionOption equals 1
                    $VMImageObject = $VMSkuObject                                           # VMImageObject is equal to $VMSkuObject
                    Return $VMImageObject                                                   # Returns $VMImageObject to calling function
                }                                                                           # End if ($ImageVersionOption -eq '1')
                else {                                                                      # If $ImageVersionOption is not '1' (can only be '2')
                    $ImageVersionList =  Get-AzVMImage -Location `
                        $LocationObject.Location -PublisherName $VMPublisherObject `
                        -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus                 # Gets image version list and assigns to $var
                    $ImageVersionNumber = 1                                                 # Sets $ImageSkuNumber to 1
                    [System.Collections.ArrayList]$ImageVersionArray = @()                  # Creates the $ImageSkuArray     
                    foreach ($_ in $ImageVersionList) {                                     # For each Sku in $ImageSkuList
                        $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                            'Number' = $ImageVersionNumber}                                 # Creates the item to loaded into array
                        $ImageVersionArray.Add($ImageVersionInput) | Out-Null               # Loads item into array, out-null removes write to screen
                        $ImageVersionNumber = $ImageVersionNumber + 1                       # Increments $ImageSkuNumber by 1
                    }                                                                       # End foreach ($Offer in $ImageOfferList)
                    :SelectAzureImageVersion while ($true) {                                # Inner loop for selecting the image sku version
                        Write-Host '[0]  Exit'                                              # Write message to screen
                        foreach ($_ in $ImageVersionArray) {                                # For each $_ in $ImageSkuArray
                            $Number = $_.Number                                             # Number is equal to current item .Number
                            if ($Number -le 9) {                                            # If $Number is 9 or less
                                Write-Host "[$Number]  " $_.Name                            # Write message to screen
                            }                                                               # End if ($Number -le 9)
                            else {                                                          # If $Number is more than 9
                                Write-Host "[$Number] " $_.Name                             # Write message to screen
                            }                                                               # End else (if ($Number -le 9))
                        }                                                                   # End foreach ($_ in $ImageVersionArray)
                        Write-Host ''                                                       # Write message to screen    
                        if ($CallingFunction) {                                             # If $CallingFunction has a value
                            Write-Host `
                                'You are selecting the image version for:'$CallingFunction  # Write message to screen
                        }                                                                   # End if ($CallingFunction)    
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for selecting the image version
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals 0
                            Break GetAzureVMImage                                           # Breaks :GetAzureVMImage
                        }                                                                   # End if ($OpSelect -eq '0')                                           
                        if ($OpSelect -in $ImageVersionArray.Number) {                      # if $OpSelect is in $ImageVersionArray.Number
                            $VMVersionObject = $ImageVersionArray | `
                                Where-Object {$_.Number -eq $OpSelect}                      # $VMSkuObject equals $ImageVersionArray where $ImageVersionArray.Number equals $OpSelect
                            $VMImageObject = Get-AzVMImage -Location `
                                $LocationObject.Location -PublisherName $VMPublisherObject `
                                -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Skus `
                                -Version $VMVersionObject.Name                              # Pulls the full object and assign to $var
                            Break GetAzureImageVersion                                      # Break SelectAzureImageSku
                        }                                                                   # End if ($VMOfferObject)
                        else {                                                              # If $VMSkuObject does not have a value
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($VMOfferObject))
                    }                                                                       # End :SelectAzureImageVersion while ($true)
                }                                                                           # End else(if ($ImageVersionOption -eq '1'))
            }                                                                               # End :GetAzureImageVersion while ($true)
            Clear-Host                                                                      # Clears screen
            Return $VMImageObject                                                           # Returns #VMImageObject
        }                                                                                   # End :GetAZVMImage while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMOS
function GetAzVMSize {                                                                      # Function for setting the VM size
    Begin {                                                                                 # Begin function
        :GetAzureVMSize while ($true) {                                                     # Outer loop for managing function
            $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName                # Gets a list of all VM sizes in location
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $CoreCountList)
                foreach ($_ in $ValidCore) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Cores"                              # Write message to screen
                }                                                                           # End foreach ($_ in $ValidCore) 
                $CoreCount = Read-Host "Enter the list number for VM core count"            # Operator input for the core count value
                if ($CoreCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($CoreCount -eq '0')
                elseif ($CoreCount -in $ValidCore.Number) {                                 # If $CoreCoint in $ValidCore.Number list
                    $CoreCount = $ValidCore | Where-Object {$_.Number -eq $CoreCount}       # $CoreCount is equal to $ValidCore where $ValidCore.Number equals $CoreCount
                    $CoreCount = $CoreCount.Count                                           # CoreCount is equal to $CoreCount.Count
                    $OpConfirm = Read-Host "Confirm:"$CoreCount" cores? [Y] or [N]"   # Operator confirmation of core count
                    if ($OpConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMCoreCount                                           # Breaks :SetAzureVMCoreCount
                    }                                                                       # End if ($OpConfirm -eq 'y') 
                }                                                                           # End elseif ($CoreCount -in $ValidCore.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($CoreCount -eq '0'))
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                foreach ($_ in $ValidRam) {                                                 # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"MB"                                 # Write message to screen
                }                                                                           # End foreach ($_ in $ValidRam)
                $RamCount = Read-Host "Enter the list number for VM Ram"                    # Operator input for the ram count selection
                if ($RamCount -eq '0') {                                                    # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($RamCount -eq '0')
                elseif ($RamCount -in $ValidRam.Number) {                                   # If $Ramcount is in $ValidRam.Number list
                    $RamCount = $ValidRam | Where-Object {$_.Number -eq $RamCount}          # $RamCount equals $ValidRam where $ValidRam.Number equals $RamCount 
                    $RamCount = $RamCount.Count                                             # $RamCount equals $RamCount.Count
                    $OpConfirm = Read-Host "Confirm:" `
                    $RamCount" MB of Ram? [Y] or [N]"                                       # Operator confirmation on ram count
                    if ($OpConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMRamCount                                            # Breaks :SetAzureRamCount
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End elseif ($RamCount -in $ValidRam.Number) 
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RamCount -eq '0'))
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to screen
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                foreach ($_ in $ValidDisk) {                                                # For each item in list
                    Write-Host "["$_.Number"]" $_.Count"Max disks"                          # Write message to screen
                }                                                                           # End foreach ($_ in $ValidDisk)
                $DiskCount = Read-Host "Enter the list number for VM max disks"             # Operator input for the max disk count
                if ($DiskCount -eq '0') {                                                   # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($DiskCount -eq '0')
                elseif ($DiskCount -in $ValidDisk.Number) {                                 # Else if $DiskCount is in $ValidDisk.Number list
                    $DiskCount = $ValidDisk | Where-Object {$_.Number -eq $DiskCount}       # $DiskCount equals $ValidDisk where $ValidDisk.Number equals $DiskCount
                    $DiskCount = $DiskCount.Count                                           # $DiskCount equals $DiskCount.Count
                    $OpConfirm = Read-Host `
                    "Confirm"$DiskCount" max disks? [Y] or [N]"                             # Operator confirmation of the disk count
                    if ($OpConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMDiskCount                                           # Breaks :SetAzureVMDiskCount
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End elseif ($DiskCount -in $ValidDisk.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($DiskCount -eq '0'))
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                Write-Host "[ 0 ] to exit"                                                  # Write message to scrren
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                foreach ($_ in $ValidVMSize) {                                              # For each item in list
                    Write-Host "["$_.Number"]" $_.Name                                      # Write message to screen
                    Write-Host "OS disk size:"$_.OSDiskSize"MB"                             # Write message to screen
                    Write-Host "Resource Disk size:"$_.RSDiskSize"MB"                       # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ValidVMSize)
                $VMSizeCount = Read-Host "Enter the list number for VM size"                # Operator input for the VM size
                if ($VMSizeCount -eq '0') {                                                 # If $var equals 0
                    Break GetAzureVMSize                                                    # Breaks :GetAzureVMSize
                }                                                                           # End if ($VMSizeCount -eq '0')
                elseif ($VMSizeCount -in $ValidVMSize.Number) {                             # If $VMSizeCoint is in $ValidVMSize.Number
                    $VMSizeCount = $ValidVMSize | Where-Object {$_.Number -eq $VMSizeCount} # $VMsizeCount is equal to $ValidVMSize where $ValidVMSize.Number equals $VMSizeCount
                    $VMSizeObject = Get-AzVMSize -Location $LocationObject.location | `
                        Where-Object {$_.Name -eq $VMSizeCount.Name}                        # $VMSizeNumber is pulled using $VMSizeCount.Name
                    if ($VMSizeObject) {                                                    # If $VMSizeObject exists
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End if ($VMSizeObject)
                }                                                                           # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($VMSizeCount -eq '0'))
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}

# Additional required functions from other ManageAz sections
function NewAzNetworkInterface { # Creates a new network interface
    Begin {
        :NewAzureNIC while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # If $RGObject is $null
                    Break NewAzureNIC # Breaks :NewAzureNIC
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$LocationObject) { # If $LocationObject is $null
                $LocationObject = GetAzLocation # Calls function and assigns output to $var
                if (!$LocationObject) { # If $LocationObject is $null
                    Break NewAzureNIC # Breaks :NewAzureNIC
                } # End if (!$LocationObject)
            } # End if (!$LocationObject)
            if (!$SubnetObject) { # If $SubnetObject is $null
                $SubnetObject = GetAzVNetSubnetConfig # Calls function and assigns output to $var
                if (!$SubnetObject) { # If $SubnetObject is $null
                    Break NewAzureNic # Breaks :NewAzureNic
                } # End if (!$SubnetObject)
            } # End if (!$SubnetObject)
            :SetAzureNicName while ($true) { # Inner loop for setting the nic name
                $NicName = Read-Host "Nic name" # Operator input for the nic name
                if ($NicName -eq 'exit') { # If $NicName is 'exit'
                    Break NewAzureNic # Breaks :NewAzureNic
                } # End if ($NicName -eq 'exit')
                $OpConfirm = Read-Host "Set" $NicName "as the Nic name [Y] or [N]" # Operator confirmation of the name
                if ($OpConfirm -eq 'y') { # If $OpConfirm equals 'y'
                    Break SetAzureNicName # Breaks :SetAzureNicName
                } # End if ($OpConfirm -eq 'y')
            } # End :SetAzureNicName while ($true)
            Try { # Try the following
                $NICObject = New-AzNetworkInterface -Name $NicName -ResourceGroupName $RGObject.ResourceGroupName -Location $LocationObject.DisplayName -SubnetId $SubnetObject.ID # Creates the object and assigns to $var
            } # End Try
            Catch { # If try fails
                Write-Host "An error has occured" # Write mesage to screen
                Write-Host "You may not have permissions to create this object" # Write mesage to screen
                Write-Host "The resource group maybe locked" # Write mesage to screen
                Write-Host "The name provided may not be valid" # Write mesage to screen
                Break NewAzureNIC # Breaks :NewAzureNIC
            } # End Catch
            Return $NICObject # Returns NicObject to calling function
        } # End :NewAzureNIC while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End funciton NewAzNetworkInterface
function GetAzVirtualNetwork {
    Begin {
        :GetAzureVnet while ($true) { # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork # pulls all items into list for selection
            $VNetListNumber = 1 # $var used for selecting the virtual network
            foreach ($Name in $VNetList) { # For each name in $VNetList
                Write-Host $VNetListNumber"." $Name.Name $Name.AddressSpace.AddressPrefixes # Writes items from list to screen
                $VNetListNumber = $VNetListNumber + 1 # Increments $var up by 1
            } # End foreach ($Name in $VNetList)
            :GetAzureVNetName while ($true) { # Inner loop for selecting the Vnet
                $VNetListNumber = 1 # Resets $VNetListNumber
                $VNetListSelect = Read-Host "Please enter the number of the virtual network" # Operator input for the VNet selection
                foreach ($Name in $VNetList) { # For each name in $VnetList
                    if ($VNetListSelect -eq $VNetListNumber) { # If $VnetListSelect equals current $VnetListNumber
                        $VNetObject = Get-AzVirtualNetwork -Name $Name.Name # Pulls the selected object and assigns to $var
                        Break GetAzureVnetName # Breaks :GetAzureVnetName
                    } # End if ($VNetListSelect -eq $VNetListNumber)
                    else { # If $VnetListSelect does not equal the current $VnetListNumber
                        $VNetListNumber = $VNetListNumber + 1 # Increments $var up by 1
                    } # End else (if ($VNetListSelect -eq $VNetListNumber))
                } # End foreach ($Name in $VNetList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureVNetName while ($true)
            Return $VNetObject # Returns to calling function with $var
        } # End :GetAzureVnet while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzVirtualNetwork
function GetAzVNetSubnetConfig {
    Begin {
        :GetAzureSubnet while ($true) {
            if (!$VnetObject) {
                $VnetObject = GetAzVirtualNetwork
                if (!$VnetObject) {
                    Break GetAzureSubnet # Breaks :GetAzureSubnet
                } # End if (!$VnetObject)
            } # End if (!$VnetObject)
            $SubNetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VnetObject # pulls all items into list for selection
            $SubNetListNumber = 1 # $var used for selecting the subnet
            foreach ($Name in $SubNetList) { # For each name in $SubNetList
                Write-Host $SubNetListNumber"." $Name.Name $Name.AddressPrefix # Writes items from list to screen
                $SubNetListNumber = $SubNetListNumber + 1 # Increments $var up by 1
            } # End foreach ($Name in $SubNetList)
            :GetAzureSubnetName while ($true) { # Inner loop for selecting the Subnet
                $SubNetListNumber = 1 # Resets $SubNetListNumber
                $SubNetListSelect = Read-Host "Please enter the number of the subnet" # Operator input for the Subnet selection
                foreach ($Name in $SubNetList) { # For each name in $SubnetList
                    if ($SubNetListSelect -eq $SubNetListNumber) { # If $SubnetListSelect equals current $SubnetListNumber
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VnetObject -Name $Name.Name # Pulls the selected object and assigns to $var
                        Break GetAzureSubnetName # Breaks :GetAzureSubnetName
                    } # End if ($SubNetListSelect -eq $SubNetListNumber)
                    else { # If $SubnetListSelect does not equal the current $SubnetListNumber
                        $SubNetListNumber = $SubNetListNumber + 1 # Increments $var up by 1
                    } # End else (if ($SubNetListSelect -eq $SubNetListNumber))
                } # End foreach ($Name in $SubNetList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureSubnetName while ($true)
            Return $SubnetObject # Returns to calling function with $var
        } # End :GetAzureSubnet while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzVNetSubnetConfig
function GetAzNetworkInterface { # Gets a network interface
    Begin {
        :GetAzureNic while ($true) { # Outer loop for managing function
            $NicList = Get-AzNetworkInterface # pulls all items into list for selection
            $NicListNumber = 1 # $var used for selecting the NIC
            foreach ($_ in $NicList) { # For each item in $NicList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $NicListNumber # Adds number property to each item in list
                $NicListNumber = $NicListNumber + 1 # Increments $NicListNumber by 1
            } # End foreach ($_ in $NicList)
            Write-Host "0 Exit" # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($_ in $NicList) { # Writes all objects to screen
                Write-Host "NIC: " $_.Number # Write message to screen
                Write-Host "Name:"$_.Name # Write message to screen
                Write-Host "IP:  " $_.IpConfigurations.PrivateIpAddress # Writes list to screen
                Write-Host "RG : " $_.ResourceGroupName # Write message to screen
                if ($_.VirtualMachine) { # $_.VirtualMachine has a value
                    Write-Host "VM: "$_.VirtualMachine.ID.split("/")[0,-1] # Write message to screen
                } # End if ($_.VirtualMahine) 
                Write-Host "" # Write message to screen
            } # End foreach ($_ in $NicList)
            :GetAzureNicName while ($true) { # Inner loop for selecting the NIC
                $NicListNumber = 1 # Resets $NicListNumber
                $NicListSelect = Read-Host "Please enter the number of the network interface" # Operator input for the NIC selection
                if ($NicListSelect -eq 0) { # IF $NicListSelect equals 0
                    Break GetAzureNic # Breaks :GetAzureNic 
                } # End if ($NicListSelect -eq 0)
                foreach ($Name in $NicList) { # For each name in $NicList
                    if ($NicListSelect -eq $Name.Number) { # If $NicListSelect equals current $NicListNumber
                        $NicObject = Get-AzNetworkInterface | Where-Object {$_.Name -eq $Name.Name} # Pulls the selected object and assigns to $var
                        Break GetAzureNicName # Breaks :GetAzureNicName
                    } # End if ($NicListSelect -eq $NicListNumber)
                    else { # If $NicListSelect does not equal the current $NicListNumber
                        $NicListNumber = $NicListNumber + 1 # Increments $var up by 1
                    } # End else (if ($NicListSelect -eq $NicListNumber))
                } # End foreach ($Name in $NicList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureNicName while ($true)
            Return $NicObject # Returns to calling function with $var
        } # End :GetAzureNic while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzNetworkInterface
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                    # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup