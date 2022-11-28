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
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    SetLinuxOS:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Linux%20VM/SetLinuxOS.ps1
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzVMLinux:               Creates a new Linux virtual machine
    SetLinuxOS:                 Gets a Linux image sku
    NewAzNetworkInterface:      Creates a new network interface
    GetAzVNetSubnetConfig:      Gets a vnet subnet
    GetAzVirtualNetwork:        Gets a virtual network
    GetAzNetworkInterface:      Gets a network interface
    GetAzResourceGroup:         Gets a resource group 
} #>
<# Variables: {
    :NewAzureVMWin              Outer loop for managing function
    :SetAzureVMName             Inner loop for setting VM name
    :SetAzureVMUserName         Inner loop for setting VM username
    :SetAzureVMPassword         Inner loop for setting VM password
    :SetAzureVMSize             Inner loop for listing the available VM machine sizes
    :SetAzureVMSizeName         Inner loop for selecting the VM machine size
    :SetAzureNetwork            Inner loop for creating or getting NIC
    $RGObject:                  Resource group object
    $LocationObject:            Azure location object
    $VMNameObject:              VM name object
    $OperatorConfirm:           Operator confirmation
    $VMUserNameObject:          VM username object
    $VMPasswordObject:          VM password object
    $VMCredObject:              Combined VM username and password object
    $VMSizeList:                List of all available VM sized
    $VMSizeListNumber:          Number object used for listing and selecting VM size
    $VMSizeListSelect:          Operator input for the VM size
    $VMSizeObject:              VM size object
    $VMBuildObject:             VM build object, contains all other objects
    $NicObject:                 Network interface object
    $OperatorSelect:            Operator input for the nic selection type
    $LinuxSkuObject:            Linux SKU Object
    $LinuxVMImageObject:        Linux image object (Latest $LinuxSkuObject)
    $LinuxVMObject:             New Linux VM object
    SetLinuxOS{}                Gets $LinuxSkuObject
    GetAzResourceGroup{}        Gets $RGObject
    NewAzNetworkInterface{}     Gets $NicObject
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $Vnet Object
    GetAzNetworkInterface{}     Gets $NicObject 
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $Vnet Object
} #>
<# Process Flow {
    Function
        Call NewAzVMLinux > Get $LinuxVMObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzVMLinux > Send $RGObject
            Call NewAzNetworkInterface > Get $NicObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $Vnet
                    End GetAzVirtualNetwork
                        Return GetAzVNetSubnetConfig > Send $Vnet
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End NewAzNetworkInterface
                Return NewAzVMLinux > Send $ NicObject
            Call GetAzNetworkInterface > Get $NicObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                    Call GetAzVirtualNetwork > Get $Vnet
                    End GetAzVirtualNetwork
                        Return GetAzVNetSubnetConfig > Send $Vnet
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End GetAzNetworkInterface
                Return NewAzVMLinux > Send $NicObject
            Call SetLinuxOS > Get $LinuxSkuObject
            End SetLinuxOS
                Return NewAzVMLinux > Send $LinuxSkuObject
        End NewAzVMLinux
            Return Function > Send $LinuxVMObject
}#>
function NewAzVMLinux {                                                                     # Creates a new Linux VM
    Begin {                                                                                 # Begin function
        :NewAzureVMLinux while ($true) {                                                    # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureVMLinux                                                   # Breaks :NewAzureVMLinux
                }                                                                           # End if (!$RGObject) 
            }                                                                               # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.location -eq `
                $RGObject.location}                                                         # Sets $Location object to match $RGObject.location
            :SetAzureVMName while ($true) {                                                 # Inner loop for setting the VM name
                $VMNameObject = Read-Host "New VM Name"                                     # Operator input for the VM name
                if ($VMNameObject -eq 'exit') {                                             # If $VMNameObject equals 'exit'
                    Break NewAzureVMLinux                                                   # Breaks :NewAzureVMLinux
                }                                                                           # End if ($VMNameObject -eq 'exit')
                Write-Host $VMNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the VM name? [Y] or [N]"               # Operator confirmation of the VM name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMName                                                    # Breaks :SetAzureVMName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {                                             # Inner loop for setting the VM username
                $VMUserNameObject = Read-Host "VM Local username"                           # Operator input of the local admin user name
                if ($VMUserNameObject -eq 'exit') {                                         # if $VMUsernameObject equals exit
                    Break NewAzureVMLinux                                                   # Breaks :NewAzureVMLinux
                }                                                                           # End if ($VMUserNameObject -eq 'exit')
                Write-Host $VMUserNameObject                                                # Write message to screen
                $OperatorConfirm = Read-Host "Use as the VM username? [Y] or [N]"           # Operator confirmation of the local admin user name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVMUserName                                                # Breaks :SetAzureVMUserName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMUserName while ($true)
        :SetAzureVMPassword while ($true) {                                                 # Inner loop for setting VM password
                $VMPasswordObject = Read-Host "VM Local password"                           # Operator input for the VM password
                if ($VMPasswordObject -eq 'exit') {                                         # If $VMPasswordObject equals exit
                    Break NewAzureVMLinux                                                   # Breaks :NewAzureVMLinux
                }                                                                           # End if ($VMPasswordObject -eq 'exit')
                Write-Host $VMPasswordObject                                                # Write message to screen
                $OperatorConfirm = Read-Host "Use as the VM password? [Y] or [N]"           # Operator confirmation of the password
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'   
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject `
                    -AsPlainText -Force                                                     # Convers $VMPasswordObject to secure string
                    Break SetAzureVMPassword                                                # Breaks :SetAzureVMPassword
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential`
                ($VMUserNameObject, $VMPasswordObject)                                      # Creates username and password array
            :SetAzureVMSize while ($true) {                                                 # Inner loop to select the VM machine size
                $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName            # Collects list of all VM sizes in $LocationObject
                $VMSizeListNumber = 1                                                       # $Var used for selecting the VM size
                Write-Host "0. Exit"                                                        # Write message to screen
                foreach ($Name in $VMSizeList) {                                            # For each $Name in $VMSizeList
                    Write-Host $VMSizeListNumber"." $Name.Name $Name.NumberOfCores `
                    $Name.MemoryInMB $Name.MaxDataDiskCount                                 # Writes each VM and number in list to screen 
                    $VMSizeListNumber = $VMSizeListNumber + 1                               # Incremends $VMSizeListNumber by 1
                }                                                                           # End foreach ($Name in $VMSizeList)
                :SetAzureVMSizeName while ($true) {                                         # Inner loop for selecting the VM size
                    $VMSizeListNumber = 1                                                   # Resets $VMSizeListNumber
                    $VMSizeListSelect = Read-Host "Please enter the number of the VM size"  # Operator input for the VM size
                    if ($VMSizeListSelect -eq '0') {                                        # If $VMSizeListSelect equals 0
                        Break NewAzureLinuxVM                                               # Breaks :NewAzureLinuxVM
                    }                                                                       # End if ($VMSizeListSelect -eq '0') 
                    foreach ($Name in $VMSizeList) {                                        # For each loop for match $VMSizeListSelect to $VMSizeListNumber
                        if ($VMSizeListSelect -eq $VMSizeListNumber) {                      # If $VMSizeListSelect equals $VMSizeListNumber
                            $VMSizeObject = Get-AzVMSize -Location 
                                $LocationObject.DisplayName | `
                                Where-Object {$_.Name -eq $Name.Name}                       # Assigns the current selection to $VMSizeObject
                            Break SetAzureVMSize                                            # Breaks :SetAzureVMSize
                        }                                                                   # End if ($VMSizeListSelect -eq $VMSizeListNumber)
                        else {                                                              # If $VMSizeListSelect does not equal $VMSizeListNumber
                            $VMSizeListNumber = $VMSizeListNumber + 1                       # Incremends $VMSizeListNumber by 1
                        }                                                                   # End else (if ($VMSizeListSelect -eq $VMSizeListNumber))
                    }                                                                       # End foreach ($Name in $VMSizeList)
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End :SetAzureVMSizeName while ($true) {
            }                                                                               # End :SetAzureVMSize while ($true)
            $VMBuildObject = New-AzVMConfig -VMName $VMNameObject 
                -VMSize $VMSizeObject.Name                                                  # Starts $VMBuildObject
            $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject `
                -Linux -ComputerName $VMNameObject -Credential $VMCredObject                # Adds VM info to $VMBuildObject
            :SetAzureNetwork while ($true) {                                                # Inner loop for creating or selecting NIC
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Write-Host "1. New NIC"                                                 # Write message to screen
                    Write-Host "2. Existing NIC"                                            # Write message to screen
                    $OperatorSelect = Read-Host "[1] or [2]"                                # Operator input for getting the NIC
                    if ($OperatorSelect -eq 'exit') {                                       # If $OperatorSelect equals exit
                        Break NewAzureVMLinux                                               # Breaks :NewAzureVMLinux
                    }                                                                       # End if ($OperatorSelect -eq 'exit')
                    if ($OperatorSelect -eq '1') {                                          # If $OperatorSelect equals 1
                        $NicObject = NewAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVMLinux                                           # Breaks :NewAzureVMLinux
                        }                                                                   # End if (!$NicObject)
                        else {                                                              # If $NicObject has a value
                            Break SetAzureNetwork                                           # Breaks :SetAzureNetwork
                        }                                                                   # End else (if (!$NicObject))
                    }                                                                       # End if ($OperatorSelect -eq '1')
                    elseif ($OperatorSelect -eq '2') {                                      # If $OperatorSelect equals 2
                        $NicObject = GetAzNetworkInterface ($RGObject, $LocationObject)     # Calls function and assigns output for $var
                        if (!$NicObject) {                                                  # If $NicObject is $null
                            Break NewAzureVMLinux                                           # Breaks :NewAzureVMLinux
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
            $LinuxSkuObject = SetLinuxOS ($LocationObject)                                  # Calls function and assigns output to $var
            if (!$LinuxSkuObject) {                                                         # If $LinuxSkuObject is $null
                Break NewAzureVMLinux                                                       # Breaks NewAzureVMLinux
            }                                                                               # End if (!$LinuxSkuObject)
            $LinuxVMImageObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName `
                $LinuxSkuObject.PublisherName -Offer $LinuxSkuObject.Offer `
                -Skus $LinuxSkuObject.Skus -version 'latest'                                # Collects the Linux image object
            $LinuxVMObject = New-AzVM -ResourceGroupName $RGObject.ResourceGroupName `
                -Location $LocationObject.DisplayName -VM $LinuxVMImageObject -Verbose      # Creates the linux VM
            Return $LinuxVMObject                                                           # Returns to calling function with $LinuxVMObject
        }                                                                                   # End :NewAzureVMLinux while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVMLinux
function SetLinuxOS {                                                                       # Function to get a valid image sku for linux VM
    Begin {                                                                                 # Begin function
        :GetAzureLinuxImage while ($true) {                                                 # Outer loop to manage function
            [System.Collections.ArrayList]$ValidPub = @()                                   # Creates the valid Pub array
            $ValidPubList = @('Ubuntu','RedHat','CentOS','SUSE','Debian','Oracle','CoreOS') # Creates a list of items to load into $ValidPub Array
            $PubNumber = 1                                                                  # Sets the base number for the valid Pub array
            foreach ($_ in $ValidPubList) {                                                 # For each item in $ValidPubList
                $PubInput = [PSCustomObject]@{'Name' = $_;'Number' = $PubNumber}            # Creates the item to loaded into array
                $ValidPub.Add($PubInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                $PubNumber = $PubNumber + 1                                                 # Increments $PubNumber up 1
            }                                                                               # End foreach ($_ in $ValidPubList)
            Write-Host '0 Exit'                                                             # Write message to screen
            foreach ($_ in $ValidPub) {                                                     # For each item in $ValidPubt
                Write-Host $_.Number $_.Name                                                # Write message to screen
            }                                                                               # End foreach ($_ in $ValidPub)
            :SelectAzurePub while ($true) {                                                 # Inner loop for selecting the publisher
                $PubSelect = Read-Host "Publisher number"                                   # Operator selection of the publisher
                if ($PubSelect -eq '0') {                                                   # If $Pubselect -eq 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End ($PubSelect -eq '0')
                $PubObject = $ValidPub | Where-Object {$_.Number -eq $PubSelect}            # $PubObject equals $ValidPub where $ValidPub.Number is equal to $PubSelect
                If ($PubObject) {                                                           # If $PubObject has a value
                    Break SelectAzurePub                                                    # Breaks :SelectAzurePub
                }                                                                           # End If ($PubObject)
                else {                                                                      # If $PubObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (# End If ($PubObject))
            }                                                                               # End :SelectAzurePub while ($true)
            if ($PubObject.Name -eq 'Ubuntu') {                                             # If $PubObject equals this value
                $PubObject = 'Canonical'                                                    # Reassigns the value of $PubObject
            }                                                                               # End ($PubObject.Name -eq 'Ubuntu')
            elseif ($PubObject.Name -eq 'RedHat') {                                         # If $PubObject equals this value
                $PubObject = 'RedHat'                                                       # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'RedHat')
            elseif ($PubObject.Name -eq 'CentOS') {                                         # If $PubObject equals this value
                $PubObject = 'OpenLogic'                                                    # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'CentOS')
            elseif ($PubObject.Name -eq 'SUSE') {                                           # If $PubObject equals this value
                $PubObject = 'SUSE'                                                         # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'SuSE')
            elseif ($PubObject.Name -eq 'Debian') {                                         # If $PubObject equals this value
                $PubObject = 'credativ'                                                     # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'Debian')
            elseif ($PubObject.Name -eq 'Oracle') {                                         # If $PubObject equals this value
                $PubObject = 'Oracle-Linux'                                                 # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'Oracle')
            elseif ($PubObject.Name -eq 'CoreOS') {                                         # If $PubObject equals this value
                $PubObject = 'CoreOS'                                                       # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'CoreOS')
            $ImageOfferList = Get-AzVMImageOffer -Location $LocationObject.DisplayName `
                -PublisherName $PubObject                                                   # Generates the image offer list
            $ImageOfferNumber = 1                                                           # Sets $ImageOfferNumber to 1
            [System.Collections.ArrayList]$OfferArray = @()                                 # Creates the valid Pub array
            foreach ($Offer in $ImageOfferList) {                                           # For each $Offer in $ImageOfferList
                $OfferInput = [PSCustomObject]@{'Name' = $Offer.Offer; `
                    'Number' = $ImageOfferNumber}                                           # Creates the item to loaded into array
                $OfferArray.Add($OfferInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                $ImageOfferNumber = $ImageOfferNumber + 1                                   # Increments $ImageofferNumber by 1
            }                                                                               # End foreach ($Offer in $ImageOfferList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $OfferArray) {                                                   # For each $_ in $OfferArray
                Write-Host $_.Number $_.Name                                                # Writes offer number and name to screen
            }                                                                               # End foreach ($_ in $OfferArray)
            :SelectAzureLinuxImage while ($true) {                                          # Inner loop to select the image offer
                $OfferSelect = Read-Host "Enter the image number"                           # Operator input for the offer selection
                if ($OfferSelect -eq '0') {                                                 # If $OfferSelect equals 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End if ($OfferSelect -eq '0')
                $LinuxOfferObject = $OfferArray | Where-Object {$_.Number -eq $OfferSelect} # $LinuxOfferObject is equal to $OfferArray where $OfferArray.Number equals $OfferSelect
                if ($LinuxOfferObject) {                                                    # If $LinuxOfferObject has a value
                    Break SelectAzureLinuxImage                                             # Breaks :SelectAzureLinuxImage
                }                                                                           # End if ($LinuxOfferObject)
                else {                                                                      # If $LinuxOfferObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LinuxOfferObject))
            }                                                                               # End :SelectAzureLinuxImage while ($true)
            $LinuxOfferObject = Get-AzVMImageOffer -Location $LocationObject.DisplayName `
                -PublisherName $PubObject | Where-Object {$_.Offer `
                -eq $LinuxOfferObject.Name}                                                 # Pulls the full $LinuxOfferObject
            $ImageSkuList = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer `
                -Location $LocationObject.DisplayName -PublisherName $PubObject             # Generates the $ImageSkuList
            $ImageSkuNumber = 1                                                             # Sets $ImageSkuNumber to 1
            [System.Collections.ArrayList]$SkuArray = @()                                   # Creates the $SkuArray     
            foreach ($Skus in $ImageSkuList) {                                              # For each Sku in $ImageSkuList
                $SkuInput = [PSCustomObject]@{'Name' = $Skus.Skus; `
                    'Number' = $ImageSkuNumber}                                             # Creates the item to loaded into array
                $SkuArray.Add($SkuInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                $ImageSkuNumber = $ImageSkuNumber + 1                                       # Increments $ImageSkuNumber by 1
            }                                                                               # End foreach ($Offer in $ImageOfferList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $SkuArray) {                                                     # For each $_ in $SkuArray
                Write-Host $_.Number $_.Name                                                # Writes $SkuArray.number and $SkuArray.Name to screen
            }                                                                               # End foreach ($_ in $OfferArray)
            :SelectAzureLinuxSku while ($true) {                                            # Inner loop for selecting the image sku
                $SkuSelect = Read-Host "Enter the sku number"                               # Operator input for selecting the image sku
                if ($SkuSelect -eq '0') {                                                   # If $SkuSelect equals 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End if ($OfferSelect -eq '0')                                           
                $LinuxSkuObject = $SkuArray | Where-Object {$_.Number -eq $SkuSelect}       # $LinuxSkuObject equals $SkuArray where $SkuArray.Number equals $SkuSelect
                if ($LinuxSkuObject) {                                                      # If $LinuxSkuObject has a value
                    Break SelectAzureLinuxSku                                               # Break SelectAzureLinuxSku
                }                                                                           # End if ($LinuxOfferObject)
                else {                                                                      # If $LinuxSkuObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LinuxOfferObject))
            }                                                                               # End :SelectAzureLinuxImage while ($true)
            $LinuxSkuObject = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer -Location `
                $LocationObject.DisplayName -PublisherName $PubObject | Where-Object `
                {$_.Skus -eq $LinuxSkuObject.Name}                                          # Pulls the full $LinuxSkuObject
            Return $LinuxSkuObject                                                          # Returns to calling function with $LinuxSkuObject
        }                                                                                   # End :GetAzureLinuxImage 
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetLinuxOS
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
                $OperatorConfirm = Read-Host "Set" $NicName "as the Nic name [Y] or [N]" # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureNicName # Breaks :SetAzureNicName
                } # End if ($OperatorConfirm -eq 'y')
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
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $RGList = Get-AzResourceGroup # Gets all resource groups and assigns to $RGList
        if (!$RGList) { # If $RGList returns empty
            Write-Host "No resource groups found" # Message write to screen
            Return # Returns to calling function with $null
        } # End if (!$RGList)
        $RGListNumber = 1 # Sets the base value of the list
        Write-Host "0. Exit" # Adds exit option to beginning of list
        foreach ($_ in $RGList) { # For each item in list
            Write-Host $RGListNumber"." $_.ResourceGroupName # Writes the option number and resource group name
            $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
        } # End foreach ($_ in $RGList)
        :GetAzureResourceGroup while ($true) { # Loop for selecting the resource group object
            $RGListNumber = 1 # Resets list number to 1
            $RGListSelect = Read-Host "Please enter the number of the resource group" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Return $RGObject # Returns $RGObject to calling function
                } # End if ($RGListSelect -eq $RGListNumber)
                else { # If user input does not match the current $RGListNumber
                    $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
                } # End else (if ($RGListSelect -eq $RGListNumber))
            } # End foreach ($_ in $RGList)
            Write-Host "That was not a valid selection, please try again" # Write message to screen
        } # End :GetAzureResourceGroup while ($true)
        Return $RGObject # Returns $RGObject to calling function
    } # End of begin statement
} # End of function