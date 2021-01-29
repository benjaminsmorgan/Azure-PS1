function NewAzVMWin { # Creates a new Windows VM
    Begin {
        :NewAzureVMWin while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break NewAzureVMWin # Breaks :NewAzureVMWin
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location}
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
                            $WinVMImageSkuListVersionNumber = 1 # Used for version selection
                            Write-Host '0. Select different SKU' # Write message to screen
                            foreach ($Version in $WinVMImageSkuListVersion) { # For each $Version in $WinVMImageSkuListVersion
                                Write-Host $WinVMImageSkuListVersionNumber"." $Version.Version $Version.Skus # Writes list of versions to screen
                                $WinVMImageSkuListVersionNumber = $WinVMImageSkuListVersionNumber + 1 # Increments $WinVMImageSkuListVersionNumber by 1
                            } # End foreach ($Version in $WinVMImageSkuListVersion)
                            :SetAzureServerImageVersion while ($true) { # Inner loop for setting the sku version
                                $ImageVersionSelect = Read-Host "Please enter the number of the version" # Operator input for the sku version
                                if ($ImageVersionSelect -eq '0') { # If ImageVersionSelect equals 0
                                    Break SetAzureServerImageName # Breaks :SetAzureServerImageName restarting :SetAzureServerImage
                                } # End if ($ImageVersionSelect -eq '0')
                                $WinVMImageSkuListVersionNumber = 1 # Resets $WinVMImageSkuListVersionNumber 
                                foreach ($Version in $WinVMImageSkuListVersion) { # For each $Version in $WinVMImageSkuListVersion
                                    if ($ImageVersionSelect -eq $WinVMImageSkuListVersionNumber) { # If $ImageVersionSelect equals $WinVMImageSkuListVersionNumber
                                        $WinVMImageObject = Set-AzVMSourceImage -VM $VMBuildObject -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus $Skus.Skus -version $Version.Version # Collects the windows image object
                                        Break SetAzureServerImage # Breaks :SetAzureServerImage
                                    } # End if ($ImageVersionSelect -eq $WinVMImageSkuListVersionNumber)
                                    else { # if ($ImageVersionSelect -eq $WinVMImageSkuListVersionNumber)
                                    $WinVMImageSkuListVersionNumber = $WinVMImageSkuListVersionNumber + 1 # Increments $WinVMImageSkuListVersionNumber by 1
                                    } # End else (if ($ImageVersionSelect -eq $WinVMImageSkuListVersionNumber))
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
                $SubnetObject = GetAzVNetworkSubnetConfig # Calls function and assigns output to $var
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
function GetAzVNetworkSubnetConfig {
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
} # End function GetAzVNetworkSubnetConfig
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
function GetAzLocation { # Gets azure location
    Begin {
        :GetAzureLocation while ($true) { # Outer loop for managing function
            $LocationList = Get-AzLocation # Gets a list of all Azure locations
            $LocationListNumber = 1 # $Var for selecting the location
            Write-Host "0. Exit" # Write message to screen
            foreach ($Location in $LocationList) { # For each item in $LocationList
                Write-Host $LocationListNumber"." $Location.DisplayName # Writes list to screen
                $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
            } # End foreach ($Location in $LocationList)
            :GetAzureLocationName while ($true) { # Inner loop for selecting location from list
                $LocationSelect = Read-Host "Please enter the number of the location" # Operator input for the selection
                if ($LocationSelect -eq '0') { # If $LocationSelect is 0
                    Break GetAzureLocation # Breaks :GetAzureLocation
                } # End if ($LocationSelect -eq '0')
                $LocationListNumber = 1 # Resets $LocationListNumber
                foreach ($Location in $LocationList) { # For each item in $locationList
                    if ($LocationSelect -eq $LocationListNumber) { # If $LocationSelect equals $LocationListNumber
                        $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $Location.Location} # Collects the current location and assigns to $Location
                        Break GetAzureLocationName # Breaks :GetAzureLocationName 
                    } # End if ($LocationSelect -eq $LocationListNumber)
                    else { # If $locationSelect does not equal $LocationListNumber
                        $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
                    } # End else if ($LocationSelect -eq $LocationListNumber)
                } # End foreach ($Location in $LocationList)
                Write-Host "That was not a valid selection" # Write message to screen
            } # End :GetAzureLocationName while ($true)
            Return $LocationObject # Returns $Location to calling function
        } # End :GetAzureLocation while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzLocation
