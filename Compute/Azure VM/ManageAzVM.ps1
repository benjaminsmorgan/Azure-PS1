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
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input on management option
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
                StartAzVM                                                                   # Calls function
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
}                                                                                           # End function NewAzVM                                                                                   # End function GetAzVMSize 
function GetAzVM {                                                                          # Function to get a virtual machine
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVM                                                            # Breaks :GetAzureVM
            }                                                                               # End if (!$VMList)
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;'Name'=$_.Name;'RG'= $_.ResourceGroupName; `
                    'Status' = $_.PowerState;'LOC'=$_.Location;'OS'=$_.OsProfile;`
                    'NIC'=$_.Nic                                                            # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VMList)
            :GetAzureVMName while ($true) {                                                 # Inner loop for selecting VM from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $VMArray) {                                                  # For each item in $VMArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))                     
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Location:'$_.LOC                                            # Write message to screen
                    if ($_.OS.WindowsConfiguration) {                                       # If current item .OS.WindowsConfiguration has a value
                        Write-Host 'OS Type:  Windows'                                      # Write message to screen
                    }                                                                       # End if ($_.OS.WindowsConfiguration)
                    elseif ($_.OS.LinuxConfiguration) {                                     # If current item .OS.LinuxConfiguration has a value
                        Write-Host 'OS Type:  Linux'                                        # Write message to screen
                    }                                                                       # End elseif ($_.OS.LinuxConfiguration)
                    Write-Host 'Status:  '$_.Status                                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $VMList)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the VM for:'$CallingFunction              # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                elseif ($OpSelect -in $VMArray.Number) {
                    $OpSelect = $VMArray | Where-Object {$_.Number -eq $OpSelect}           # $OpSelect equals $VMArray where $VMArray.Number equals $OpSelect
                    $VMObject = Get-AzVM -ResourceGroupName $OpSelect.RG `
                        -Name $OpSelect.Name                                                # Pulls full $VMObject
                    Return $VMObject                                                        # Returns to calling function with $VMObject
                }                                                                           # End elseif ($OpSelect -in $VMArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVM
function ListAzVM {                                                                         # Function to list all virtual machines
    Begin {                                                                                 # Begin function
        :ListAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVM                                                           # Breaks :ListAzureVM
            }                                                                               # End if (!$VMList)
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Name'=$_.Name;'RG'= $_.ResourceGroupName;'Status' = $_.PowerState;`
                    'LOC'=$_.Location;'OS'=$_.OsProfile;'NIC'=$_.Nic                        # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
            }                                                                               # End foreach ($_ in $VMList)
            foreach ($_ in $VMArray) {                                                      # For each item in $VMArray
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.RG                                                 # Write message to screen
                Write-Host 'Location:'$_.LOC                                                # Write message to screen
                if ($_.OS.WindowsConfiguration) {                                           # If current item .OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:  Windows'                                          # Write message to screen
                }                                                                           # End if ($_.OS.WindowsConfiguration)
                elseif ($_.OS.LinuxConfiguration) {                                         # If current item .OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:  Linux'                                            # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host 'Status:  '$_.Status                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VMList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVM                                                               # Breaks :ListAzureVM
        }                                                                                   # End :ListAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVM
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StartAzVM'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Power on:'$VMObject.name                                            # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power on:'$VMObject.Name                      # Write message to screen
                    Start-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'Stop'                         # Starts the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to power on the vm'                              # Write message to screen
                    Write-Host 'The VM may already be on'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered on'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :StartAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StopAzVM'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Power off:'$VMObject.name                                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn off the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power off:'$VMObject.Name                     # Write message to screen
                    Stop-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -force -ErrorAction 'Stop'                  # Stops the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to power off the vm'                             # Write message to screen
                    Write-Host 'The VM may already be off'                                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered off'                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :StopAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
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
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVM'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Remove:'$VMObject.name                                              # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to remove:'$VMObject.Name                        # Write message to screen
                    Remove-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -Force -ErrorAction 'Stop'                  # Removes the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to remove the vm'                                # Write message to screen
                    Write-Host 'The VM or resource group'                                   # Write message to screen
                    Write-Host 'Maybe locked or you may'                                    # Write message to screen
                    Write-Host 'not have the permissions'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been removed'                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :RemoveAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
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
            $NotAvailable = Get-AzComputeResourceSku -Location $LocationObject.Location `
                | Where-Object {$_.Restrictions.Reasoncode  -eq `
                'NotAvailableForSubscription'}                                              # Gets a list of all unavailble compute objects
            $VMSizeList = Get-AzVMSize -Location $LocationObject.Location `
                | Where-Object {$_.Name -notin $NotAvailable.Name}                          # Gets a list of all available VM sizes in location
            :SetAzureVMCoreCount while ($true) {                                            # Inner loop for setting the core count
                $CoreCountList = $VMSizeList                                                # Passes original list to loop list
                $CoreCountList = $CoreCountList.NumberOfCores | Sort-Object | Get-Unique    # Retains only the core count values, sorts them and only keeps unique 
                [System.Collections.ArrayList]$ValidCore = @()                              # Creates array for list to be loaded into
                $CoreNumber = 1                                                             # Creates #var used for list selection
                foreach ($_ in $CoreCountList) {                                            # For each item in list
                    $CoreInput = [PSCustomObject]@{'Count' = $_;'Number' = $CoreNumber}     # Creates the item to loaded into array
                    $ValidCore.Add($CoreInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $CoreNumber = $CoreNumber + 1                                           # Increments $var up by 1
                }                                                                           # End foreach ($_ in $OpSelectList)
                :SelectAzureVMCoreCount while ($true) {                                     # Inner loop for selecting the vm core count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidCore) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number] "$_.Count'  Cores'                    # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number] "$_.Count' Cores'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number] "$_.Count'Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 9) {                                             # If $Count is 9 or less
                                Write-Host "[$Number]"$_.Count'  Cores'                     # Write message to screen
                            }                                                               # End if ($Count -le 9)
                            elseif ($Count -ge 10 -and $Count -le 99) {                     # If $Count is between 10 and 99
                                Write-Host "[$Number]"$_.Count' Cores'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10 -and $Count -le 99) 
                            elseif ($Count -ge 100) {                                       # If $Count is 100 or more
                                Write-Host "[$Number]"$_.Count'Cores'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the core count for:'$CallingFunction  # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidCore.Number) {                              # If $CoreCoint in $ValidCore.Number list
                        $OpSelect = $ValidCore | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect is equal to $ValidCore where $ValidCore.Number equals $OpSelect
                        $OpSelect = $OpSelect.Count                                         # CoreCount is equal to $OpSelect.Count
                        Write-Host 'Confirm:'$OpSelect' cores'                              # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation of core count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OperatorConfrim equals 'y'
                            $CoreCount = $OpSelect                                          # CoreCount is equal to $OpSelect
                            Break SetAzureVMCoreCount                                       # Breaks :SetAzureVMCoreCount
                        }                                                                   # End if ($OperatorConfirm -eq 'y') 
                    }                                                                       # End elseif ($OpSelect -in $ValidCore.Number)
                    else {                                                                  # All other values
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMCoreCount while ($true)
            }                                                                               # End :SetAzureVMCoreCount while ($true)
            :SetAzureVMRamCount while ($true) {                                             # Inner loop for setting the VM ram count
                $RamCountList = $VMSizeList | Where-Object {$_.NumberOfCores `
                        -eq $CoreCount}                                                     # Creates loop list using $VMSizeList with $CoreCount filter
                $RamCountList = $RamCountList.MemoryInMB | Sort-Object | Get-Unique         # Retains only the ram count values, sorts them and only keeps unique
                [System.Collections.ArrayList]$ValidRam = @()                               # Creates array list is loaded into
                $RamNumber = 1                                                              # Creates list count $var
                foreach ($_ in $RamCountList) {                                             # For each item in list
                    $RamInput = [PSCustomObject]@{'Count' = $_;'Number' = $RamNumber}       # Creates the item to be loaded into array
                    $ValidRam.Add($RamInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                    $RamNumber = $RamNumber + 1                                             # Increments list number up by 1
                }                                                                           # End foreach ($_ in $RamCountList)
                :SelectAzureVMRamCount while ($true) {                                      # Inner loop for selecting the ram count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidRam) {                                             # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        $Count = $_.Count                                                   # Count is equal to current item .Count
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number] "$_.Count'     MB'                    # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number] "$_.Count'    MB'                     # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number] "$_.Count'   MB'                      # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number] "$_.Count'  MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number] "$_.Count' MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number] "$_.Count'MB'                         # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $number is greater than 9
                            if ($Count -le 999) {                                           # If $Count is 999 or less
                                Write-Host "[$Number]"$_.Count'    MB'                      # Write message to screen
                            }                                                               # End if ($Count -le 999)
                            elseif ($Count -ge 1000 -and $Count -le 9999) {                 # If $Count is between 1000 an 9999
                                Write-Host "[$Number]"$_.Count'   MB'                       # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000 -and $Count -le 9999)
                            elseif ($Count -ge 10000 -and $Count -le 99999) {               # If $Count is between 10000 an 99999
                                Write-Host "[$Number]"$_.Count'  MB'                        # Write message to screen
                            }                                                               # End elseif ($Count -ge 10000 -and $Count -le 99999)
                            elseif ($Count -ge 100000 -and $Count -le 999999) {             # If $Count is between 100000 an 999999
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 100000 -and $Count -le 999999) 
                            elseif ($Count -ge 1000000 -and $Count -le 9999999) {           # If $Count is between 1000000 an 9999990
                                Write-Host "[$Number]"$_.Count' MB'                         # Write message to screen
                            }                                                               # End elseif ($Count -ge 1000000 -and $Count -le 9999999)
                            else {                                                          # All other values for $Count
                                Write-Host "[$Number]"$_.Count'MB'                          # Write message to screen
                            }                                                               # End if ($Count -le 999)
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the RAM count for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidRam.Number) {                               # If $OpSelect is in $ValidRam.Number list
                        $OpSelect = $ValidRam | Where-Object {$_.Number -eq $OpSelect}      # $OpSelect equals $ValidRam where $ValidRam.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' MB of Ram'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $RamCount = $OpSelect                                           # $RamCount is equal to $OpSelect
                            Break SetAzureVMRamCount                                        # Breaks :SetAzureRamCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidRam.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMRamCount while ($true)
            }                                                                               # End :SetAzureVMRamCount while ($true)
            :SetAzureVMDiskCount while ($true) {                                            # Inner loop for setting the max disk count
                $DiskCountList = $VMSizeList | Where-Object {$_.NumberOfCores -eq `
                    $CoreCount -and $_.MemoryInMB -eq $RamCount}                            # Creates loop list using $VMsizelist and filters
                $DiskCountList = $DiskCountList.MaxDataDiskCount | Sort-Object | Get-Unique # Filters list keeping only maxdatadiskcount and sorts and keeps only unique
                [System.Collections.ArrayList]$ValidDisk = @()                              # Creates array for list to be loaded into
                $DiskNumber = 1                                                             # Creates list number $var
                foreach ($_ in $DiskCountList) {                                            # For each item in list
                    $DiskInput = [PSCustomObject]@{'Count' = $_;'Number' = $DiskNumber}     # Creates the item to loaded into array
                    $ValidDisk.Add($DiskInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DiskNumber = $DiskNumber + 1                                           # Increments list number up by 1
                }                                                                           # End foreach ($_ in $DiskCountList)                                            
                :SelectAzureVMDiskCount while ($true) {                                     # Inner loop for selecting the max disk count
                    Write-Host '[0]  exit'                                                  # Write message to screen
                    foreach ($_ in $ValidDisk) {                                            # For each item in list
                        $Number = $_.Number                                                 # Number is current item .number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] "$_.Count' Max disks'                     # Write message to screen
                        }                                                                   # End if ($Number -ge 9)
                        else {                                                              # If $number is greater than 9
                            Write-Host "[$Number]"$_.Count' Max disks'                      # Write message to screen
                        }                                                                   # End else (if ($Number -ge 9))
                    }                                                                       # End foreach ($_ in $ValidCore) 
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the max disks for:'$CallingFunction   # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidDisk.Number) {                              # If $OpSelect is in $ValidDisk.Number list
                        $OpSelect = $ValidDisk | Where-Object {$_.Number -eq $OpSelect}     # $OpSelect equals $ValidDisk where $ValidDisk.Number equals $OpSelect 
                        $OpSelect = $OpSelect.Count                                         # $OpSelect equals $OpSelect.Count
                        Write-Host  'Confirm:'$OpSelect' Max disks'                         # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No'                             # Operator confirmation on ram count
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfrim equals 'y'
                            $DiskCount = $OpSelect                                          # $DiskCount is equal to $OpSelect
                            Break SetAzureVMDiskCount                                       # Breaks :SetAzureVMDiskCount
                        }                                                                   # End if ($OprConfirm -eq 'y')
                    }                                                                       # End elseif ($OpSelect -in $ValidDisk.Number) 
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectAzureVMDiskCount while ($true)
            }                                                                               # End :SetAzureVMDiskCount while ($true)
            $VMSizeList = $VMSizeList | Where-Object {$_.NumberOfCores -eq $CoreCount `
                -and $_.MemoryInMB -eq $RamCount -and $_.MaxDataDiskCount -eq $DiskCount}   # Refilters $VMSizeList
            :SetAzureVMName while ($true) {                                                 # Inner loop for selecting the VM size
                [System.Collections.ArrayList]$ValidVMSize = @()                            # Creates array to load list into
                $VMSizeNumber = 1                                                           # Creates list number $var
                foreach ($_ in $VMSizeList) {                                               # For each item in list
                    $VMSizeInput = [PSCustomObject]@{'Name' = $_.Name;'Number' = `
                        $VMSizeNumber;'OSDiskSize' = $_.OSDiskSizeInMB; `
                        'RSDiskSize' = $_.ResourceDiskSizeInMB}                             # Creates the item to loaded into array
                    $ValidVMSize.Add($VMSizeInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $VMSizeNumber = $VMSizeNumber + 1                                       # Increments list number up by 1
                }                                                                           # End foreach ($_ in $VMSizeList)
                :SelectAzureVMName while ($true) {                                          # Inner loop for selecting the VM size
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ValidVMSize) {                                          # For each item in $ValidVMSize
                        $Number = $_.Number                                                 # $Number is equal to current item .number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number]"  $_.Name                                 # Write message to screen    
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is more than 9
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else if ($Number -le 9)
                        Write-Host 'OS disk size: '$_.OSDiskSize'MB'                        # Write message to screen
                        Write-Host 'Res disk size:'$_.RSDiskSize'MB'                        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ValidVMSize)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        Write-Host 'You are selecting the VM size for:'$CallingFunction     # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input for the core count value
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals 0
                        Break GetAzureVMSize                                                # Breaks :GetAzureVMSize
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ValidVMSize.Number) {                            # If $OpSelect is in $ValidVMSize.Number
                        $OpSelect = $ValidVMSize | Where-Object {$_.Number -eq $OpSelect}   # $OpSelect is equal to $ValidVMSize where $ValidVMSize.Number equals $OpSelect
                        $VMSizeObject = Get-AzVMSize -Location `
                            $LocationObject.location | Where-Object `
                            {$_.Name -eq $OpSelect.Name}                                    # $VMSizeObject is pulled using $OpSelect.Name
                        Return $VMSizeObject                                                # Returns to calling function with $VMSizeObject
                    }                                                                       # End elseif ($VMSizeCount -in $ValidVMSize.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($VMSizeCount -eq '0'))
                }                                                                           # End :SelectAzureVMName while ($true)
            }                                                                               # End :SetAzureVMName while ($true)
        }                                                                                   # End :GetAzureVMSize while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVMSize

# Additional required functions from other ManageAz sections
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                Write-Host 'Gathering subnets in:'$VNet' | '$VNet                           # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    Write-Host 'Gathering NICs in:'$SubnetName                              # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ObjectInput = [PSCustomObject]@{
                            'Number'=$ListNumber;'NicName'=$_.Name;'NicRG'=`
                            $_.ResourceGroupName;'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNet;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.NicName                         # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]          "$_.NicName                          # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'NIC RG:       '$_.NicRG                                     # Write message to screen
                    Write-Host 'Subnet Name:  '$_.Subname                                   # Write message to screen
                    Write-Host 'Subnet Prefix:'$_.SubPFX                                    # Write message to screen
                    Write-Host 'VNet Name:    '$_.VnetName                                  # Write message to screen
                    Write-Host 'VNet Prefix:  '$_.VnetPFX                                   # Write message to screen
                    Write-Host 'VNet RG:      '$_.VnetRG                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.VnetName `
                        -ResourceGroupName $OpSelect.VNetRG                                 # Pulls the $Subnet Vnet
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Subname                                 # Pulls the $NicObject subnet
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName |`
                        Where-Object {$_.IpConfigurations.Subnet.ID -eq `
                        $SubnetObject.ID}                                                   # Pulls the full $NicObject
                    Return $NicObject,$SubnetObject,$VnetObject                             # Returns $vars to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface
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