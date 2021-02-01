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
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzVMWin:                 Creates a new windows virtual machine
    NewAzNetworkInterface:      Creates a new network interface
    GetAzVNetSubnetConfig:      Gets a vnet subnet
    GetAzVirtualNetwork:        Gets a virtual network
    GetAzNetworkInterface:      Gets a network interface
    GetAzResourceGroup:         Gets a resource group 
    GetAzLocation:              Gets a location
} #>
<# Variables: {
    :NewAzureVMWin              Outer loop for managing function
    :SetAzureVMName             Inner loop for setting VM name
    :SetAzureVMUserName         Inner loop for setting VM username
    :SetAzureVMPassword         Inner loop for setting VM password
    :SetAzureVMSize             Inner loop for listing the available VM machine sizes
    :SetAzureVMSizeName         Inner loop for selecting the VM machine size
    :SetAzureServerImage        Inner loop for listing the available VM image types
    :SetAzureServerImageName    Inner loop for selecting the VM image type
    :SetAzureServerImageVersion Inner loop for selecting the VM image type version
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
    $ImageSkuList:              List of all available image skus
    $ImageSkuListNumber:        Number object used for listing and selecting VM image sku
    $ImageSkuSelect:            Operator input for the image sku selection
    $WinVMImageSkuListVersion:  List of all available versions of the selected sku
    $WinVMImageSkuListVerNum:   Number object used for listing and selecting VM image sku version
    $ImageVersionSelect:        Operator input for the image sku version
    $WinVMImageObject:          Full windows image sku and version object
    $WinVMObject:               Built VM object
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
    NewAzNetworkInterface{}     Gets $NicObject
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $Vnet Object
    GetAzNetworkInterface{}     Gets $NicObject 
        GetAzVNetSubnetConfig{} Gets $SubnetObject
            GetAzVirtualNetwork{}       Gets $Vnet Object
} #>
<# Process Flow {
    Function
        Call NewAzVMWin > Get $WinVMObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzVMWin > Send $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzVMWin > Send $LocationObject
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
        End NewAzVMWin
            Return Function > Send $WinVMObject
}#>
function NewAzVMWin { # Creates a new Windows VM
    Begin {
        :NewAzureVMWin while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break NewAzureVMWin # Breaks :NewAzureVMWin
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            if (!$LocationObject) {
                $LocationObject = GetAzLocation
                if (!$LocationObject) {
                    Break NewAzureWinVM # Breaks :NewAzureWinVM 
                } # End if (!$LocationObject)
            } # End if (!$LocationObject)
            :SetAzureVMName while ($true) { # Inner loop for setting the VM name
                $VMNameObject = Read-Host "New VM Name" # Operator input for the VM name
                if ($VMNameObject -eq 'exit') {
                    Break NewAzureVMWin # Breaks :NewAzureVMWin
                } # End if ($VMNameObject -eq 'exit')
                Write-Host $VMNameObject
                $OperatorConfirm = Read-Host "Use as the VM name? [Y] or [N]" # Operator confirmation of the VM name
                if ($OperatorConfirm -eq 'y') { 
                    Break SetAzureVMName # Breaks :SetAzureVMName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVMName while ($true)
            :SetAzureVMUserName while ($true) {
                $VMUserNameObject = Read-Host "VM Local username" # Operator input of the local admin user name
                if ($VMUserNameObject -eq 'exit') {
                    Break NewAzureVMWin # Breaks :NewAzureVMWin
                } # End if ($VMUserNameObject -eq 'exit')
                Write-Host $VMUserNameObject
                $OperatorConfirm = Read-Host "Use as the VM username? [Y] or [N]" # Operator confirmation of the local admin user name
                if ($OperatorConfirm -eq 'y') {
                    Break SetAzureVMUserName # Breaks :SetAzureVMUserName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVMUserName while ($true)
            :SetAzureVMPassword while ($true) {
                $VMPasswordObject = Read-Host "VM Local password"
                if ($VMPasswordObject -eq 'exit') {
                    Break NewAzureVMWin # Breaks :NewAzureVMWin
                } # End if ($VMPasswordObject -eq 'exit')
                Write-Host $VMPasswordObject
                $OperatorConfirm = Read-Host "Use as the VM password? [Y] or [N]"
                if ($OperatorConfirm -eq 'y') {
                    $VMPasswordObject = ConvertTo-SecureString $VMPasswordObject -AsPlainText -Force
                    Break SetAzureVMPassword # Breaks :SetAzureVMPassword
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVMPassword while ($true)
            $VMCredObject = New-Object System.Management.Automation.PSCredential ($VMUserNameObject, $VMPasswordObject)
            :SetAzureVMSize while ($true) { # Inner loop to select the VM machine size
                $VMSizeList = Get-AzVMSize -Location $LocationObject.DisplayName # Collects list of all VM sizes in $LocationObject
                $VMSizeListNumber = 1 # $Var used for selecting the VM size
                Write-Host "0. Exit" # Write message to screen
                foreach ($Name in $VMSizeList) { # For each $Name in $VMSizeList
                    Write-Host $VMSizeListNumber"." $Name.Name $Name.NumberOfCores $Name.MemoryInMB $Name.MaxDataDiskCount # Writes each VM and number in list to screen 
                    $VMSizeListNumber = $VMSizeListNumber + 1 # Incremends $VMSizeListNumber by 1
                } # End foreach ($Name in $VMSizeList)
                :SetAzureVMSizeName while ($true) { # Inner loop for selecting the VM size
                    $VMSizeListNumber = 1 # Resets $VMSizeListNumber
                    $VMSizeListSelect = Read-Host "Please enter the number of the VM size" # Operator input for the VM size
                    if ($VMSizeListSelect -eq '0') {
                        Break NewAzureWinVM # Breaks :NewAzureWinVM
                    } # End if ($VMSizeListSelect -eq '0') 
                    foreach ($Name in $VMSizeList) { # For each loop for match $VMSizeListSelect to $VMSizeListNumber
                        if ($VMSizeListSelect -eq $VMSizeListNumber) { # If $VMSizeListSelect equals $VMSizeListNumber
                            $VMSizeObject = Get-AzVMSize -Location $LocationObject.DisplayName | Where-Object {$_.Name -eq $Name.Name} # Assigns the current selection to $VMSizeObject
                            Break SetAzureVMSize # Breasks :SetAzureVMSize
                        } # End if ($VMSizeListSelect -eq $VMSizeListNumber)
                        else { # If $VMSizeListSelect does not equal $VMSizeListNumber
                            $VMSizeListNumber = $VMSizeListNumber + 1 # Incremends $VMSizeListNumber by 1
                        } # End else (if ($VMSizeListSelect -eq $VMSizeListNumber))
                    } # End foreach ($Name in $VMSizeList)
                    Write-Host "That was not a valid entry" # Write message to screen
                } # End :SetAzureVMSizeName while ($true) {
            } # End :SetAzureVMSize while ($true)
            $VMBuildObject = New-AzVMConfig -VMName $VMNameObject -VMSize $VMSizeObject.Name # Starts $VMBuildObject
            $VMBuildObject = Set-AzVMOperatingSystem -VM $VMBuildObject -Windows -ComputerName $VMNameObject -Credential $VMCredObject -ProvisionVMAgent -EnableAutoUpdate # Adds VM info to $VMBuildObject
            :SetAzureNetwork while ($true) { # Inner loop for creating or selecting NIC
                if (!$NicObject) { # If $NicObject is $null
                    Write-Host "1. New NIC" # Write message to screen
                    Write-Host "2. Existing NIC" # Write message to screen
                    $OperatorSelect = Read-Host "[1] or [2]" # Operator input for getting the NIC
                    if ($OperatorSelect -eq 'exit') { # If $OperatorSelect equals exit
                        Break NewAzureVMWin # Breaks :NewAzureVMWin
                    } # End if ($OperatorSelect -eq 'exit')
                    if ($OperatorSelect -eq '1') { # If $OperatorSelect equals 1
                        $NicObject = NewAzNetworkInterface ($RGObject, $LocationObject) # Calls function and assigns output for $var
                        if (!$NicObject) { # If $NicObject is $null
                            Break NewAzureVMWin # Breaks :NewAzureVMWin
                        } # End if (!$NicObject)
                        else { # If $NicObject has a value
                            Break SetAzureNetwork # Breaks :SetAzureNetwork
                        } # End else (if (!$NicObject))
                    } # End if ($OperatorSelect -eq '1')
                    elseif ($OperatorSelect -eq '2') { # If $OperatorSelect equals 2
                        $NicObject = GetAzNetworkInterface ($RGObject, $LocationObject) # Calls function and assigns output for $var
                        if (!$NicObject) { # If $NicObject is $null
                            Break NewAzureVMWin # Breaks :NewAzureVMWin
                        } # End if (!$NicObject)
                        else { # If $NicObject has a value
                            Break SetAzureNetwork # Breaks :SetAzureNetwork
                        } # End else (if (!$NicObject))
                    } # End elseif ($OperatorSelect -eq '2')
                    else { # All other inputs
                        Write-Host "Invalid selection" # Write message to screen
                    } # End else(if ($OperatorSelect -eq '1'))
                } # End if (!$NicObject)
                Break SetAzureNetwork # Breaks :SetAzureNetwork
            } # End :SetAzureNetwork while ($true)
            $VMBuildObject = Add-AzVMNetworkInterface -VM $VMBuildObject -Id $NicObject.Id # Adds NIC info to $VMBuildObject
            :SetAzureServerImage while($true) { # Inner loop for selecting the windows server image
                $ImageSkuList = Get-AzVMImageSku -Location $LocationObject.DisplayName -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' # Gets list of all Windows Server Image Skus
                $ImageSkuListNumber = 1 # Used for Sku selection
                Write-Host "0. Exit" # Write message to screen
                foreach ($Skus in $ImageSkuList) { # For each Sku in $ImageSkuList
                    Write-Host $ImageSkuListNumber"." $Skus.Skus # Writes the Number and $Sku to screen
                    $ImageSkuListNumber = $ImageSkuListNumber + 1 # Increments $ImageSkuListNumber by 1
                } # End foreach ($Skus in $ImageSkuList)
                :SetAzureServerImageName while ($true) { # Inner loop for selecting the Sku
                    $ImageSkuSelect = Read-Host "Please enter the number of the image" # Operator input for the Sku
                    if ($ImageSkuSelect -eq '0') { # If $ImageSkuSelect equals '0'
                        Break NewAzureVMWin # Breaks :NewAzureVMWin
                    } # End if ($ImageSkuSelect -eq '0')
                    $ImageSkuListNumber = 1 # Resets $ImageSkuListNumber
                    foreach ($Skus in $ImageSkuList) { # For each $Sku in $ImageSkuList
                        if ($ImageSkuSelect -eq $ImageSkuListNumber) { # If $ImageSkuSelect equals $ImageSkuListNumber
                            $WinVMImageSkuListVersion = Get-AzVMImage -Location $LocationObject.DisplayName -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus $Skus.Skus # Gets a list of all versions fo the selected Sku
                            $WinVMImageSkuListVerNum = 1 # Used for version selection
                            Write-Host '0. Select different SKU' # Write message to screen
                            foreach ($Version in $WinVMImageSkuListVersion) { # For each $Version in $WinVMImageSkuListVersion
                                Write-Host $WinVMImageSkuListVerNum"." $Version.Version $Version.Skus # Writes list of versions to screen
                                $WinVMImageSkuListVerNum = $WinVMImageSkuListVerNum + 1 # Increments $WinVMImageSkuListVerNum by 1
                            } # End foreach ($Version in $WinVMImageSkuListVersion)
                            :SetAzureServerImageVersion while ($true) { # Inner loop for setting the sku version
                                $ImageVersionSelect = Read-Host "Please enter the number of the version" # Operator input for the sku version
                                if ($ImageVersionSelect -eq '0') { # If ImageVersionSelect equals 0
                                    Break SetAzureServerImageName # Breaks :SetAzureServerImageName restarting :SetAzureServerImage
                                } # End if ($ImageVersionSelect -eq '0')
                                $WinVMImageSkuListVerNum = 1 # Resets $WinVMImageSkuListVerNum 
                                foreach ($Version in $WinVMImageSkuListVersion) { # For each $Version in $WinVMImageSkuListVersion
                                    if ($ImageVersionSelect -eq $WinVMImageSkuListVerNum) { # If $ImageVersionSelect equals $WinVMImageSkuListVerNum
                                        $WinVMImageObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus $Skus.Skus -version $Version.Version # Collects the windows image object
                                        Break SetAzureServerImage # Breaks :SetAzureServerImage
                                    } # End if ($ImageVersionSelect -eq $WinVMImageSkuListVerNum)
                                    else { # if ($ImageVersionSelect -eq $WinVMImageSkuListVerNum)
                                    $WinVMImageSkuListVerNum = $WinVMImageSkuListVerNum + 1 # Increments $WinVMImageSkuListVerNum by 1
                                    } # End else (if ($ImageVersionSelect -eq $WinVMImageSkuListVerNum))
                                } # End foreach ($Version in $WinVMImageSkuListVersion)
                                Write-Host "That was not a valid entry" # Write message to screen
                            } # End :SetAzureServerImageVersion while ($true)
                        } # End if ($ImageSkuSelect -eq $ImageSkuListNumber)
                        else { # if ($ImageSkuSelect -eq $ImageSkuListNumber)
                            $ImageSkuListNumber = $ImageSkuListNumber + 1 # Increments $ImageSkuListNumber by 1
                        } # End else (if ($ImageSkuSelect -eq $ImageSkuListNumber))
                        } # End foreach ($Skus in $ImageSkuList)
                        Write-Host "That was not a valid entry" # Write message to screen
                } # End :SetAzureServerImageName while ($true)
            } # End :SetAzureServerImage while($true)
            $WinVMObject = New-AzVM -ResourceGroupName $RGObject.ResourceGroupName -Location $LocationObject.DisplayName -VM $WinVMImageObject -Verbose
            Return $WinVMObject #TESTING
        } # End :NewAzureVMWin while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzVMWin