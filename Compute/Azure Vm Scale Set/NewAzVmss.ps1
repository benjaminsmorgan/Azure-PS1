function NewAzVmss {                                                                        # Function to create a new virtual machine scale set
    Begin{                                                                                  # Begin function
        :NewAzureVmss while ($true) {                                                       # Outer loop for managing function
            :SetAzureVmssType while ($true) {                                               # Inner loop for setting the VMss type
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] Windows"                                                    # Write message to screen
                Write-Host "[2] Linux"                                                      # Write message to screen
                $ImageTypeObject = Read-Host "[0], [1], or [2]"                             # Operator input for the VM type
                if ($ImageTypeObject -eq '0') {                                             # If $ImageTypeObject equals 0
                    Break NewAzureVmss                                                      # Breaks :NewAzVmss
                }                                                                           # End if ($VMType -eq 'exit')
                if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2') {                # If $ImageTypeObject equals 1 or 2
                    Break SetAzureVmssType                                                  # Breaks :SetAzureVmssType
                }                                                                           # End if ($ImageTypeObject -eq '1' -or $ImageTypeObject -eq '2')
                else {                                                                      # All other input
                    Write-Host "That was not a valid selection"                             # Write message to screen
                }                                                                           # End else (if ($VMType -eq 'exit') )
            }                                                                               # End :SetAzureVMType while ($true)
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # if $RGObject is $null 
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object `
                {$_.Location -eq $RGObject.Location}                                        # Creates $LocationObject
            :SetAzureVmssSkuCapacity while ($true) {
                $VmssSkuCapacityObject = Read-Host "Enter the max number of VMs"
                if ($VmssSkuCapacityObject -eq '0') {
                    Break NewAzureVmss                                                      # Breaks :NewAzureVmss
                }
                Write-Host $VmssSkuCapacityObject
                $OperatorConfirm = Read-Host `
                "Confirm max"$VmssSkuCapacityObject" skus [Y] or [N]"
                if ($OperatorConfirm -eq 'y') {
                    Break SetAzureVmssSkuCapacity
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureVmssSkuCapacity while ($true)
            $VMSizeObject = GetAzVMSize ($LocationObject)
            if (!$VMSizeObject) {
                Break NewAzureVmss
            } # End if (!$VMSizeObject)
            $VmssConfigObject = New-AzVmssConfig -Location $LocationObject.Location `
                -SkuCapacity $VmssSkuCapacityObject -SkuName $VMSizeObject.Name
            $VmssOSProfileObject = SetAzVmssOsProfile ($VmssConfigObject, $ImageTypeObject)
            if (!$VmssOSProfileObject) {
                Break NewAzureVmss
            } # End if (!$VmssOSProfileObject)
            $VmssStorageProfileObject = SetAzVmssStorageProfile ($VmssConfigObject)
            if (!$VmssStorageProfileObject) {
                Break NewAzureVmss
            } # End if (!$VmssStorageProfileObject)
            Write-Host $RGObject.ResourceGroupName
            Return $VmssConfigObject
        }                                                                                   # End :NewAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with #null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVmss
function SetAzVmssOsProfile {                                                               # Function to set VMss OS profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssOSProfile while ($true) {                                              # Outer loop to manage function
            :SetAzureVmssOSProPrefix while ($true) {                                        # Inner loop for setting the VMss OS name prefix
                $VmssNamePrefixObject = Read-Host `
                "Please enter the Vmss computer name prefix [1-15] characters"              # Operator input for the VM name prefix
                if ($VmssNamePrefixObject -eq 'exit') {                                     # If $VmssNamePrefixObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssNamePrefixObject -eq 'exit')
                elseif ($VmssNamePrefixObject.Length -gt 15) {                              # If $VmssNamePrefixObject is greater than 15 characters
                    Write-Host `
                    "The input is to long, prefix is limitied to 15 or less characters"     # Write message to screen
                    $VmssNamePrefixObject = $null                                           # Clears $var
                }                                                                           # End elseif ($VmssNamePrefixObject.Length -gt 15)
                else {                                                                      # All other input
                    Write-Host $VmssNamePrefixObject                                        # Write message to screen
                    $OperatorConfirm = Read-Host "Use this prefix [Y] or [N]"               # Operator confirmation of the name prefix
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssOSProPrefix                                       # Breaks :SetAzureVmssOSProPrefix 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssNamePrefixObject = $null                                       # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssNamePrefixObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssOSProPrefix while ($true)
            :SetAzureVmssProUserName while ($true) {                                        # Inner loop for setting the admin username
                $VmssAdminUserNameObject = Read-Host "Enter the user name"                  # Operator input for the admin username
                if ($VmssAdminUserNameObject -eq 'exit') {                                  # If $VmssAdminUserNameObject equals 'exit'
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminUserNameObject -eq 'exit')
                elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject `
                    -eq '1') {                                                              # If $VmssAdminUserNameObject characters are greater than 20 and $ImageTypeObject equals '1'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 20 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 20 -and $ImageTypeObject -eq '1')
                elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject `
                    -eq '2') {                                                              # If $VmssAdminUserNameObject characters are greater than 64 and $ImageTypeObject equals '2'
                    Write-Host "The admin name is to long"                                  # Write message to screen
                    Write-Host "The admin account must be 64 charaters or less"             # Write message to screen
                    $VmssAdminUserNameObject = $null                                        # Clears $var
                }                                                                           # End elseif ($VmssAdminUserNameObject.Length -gt 64 -and $ImageTypeObject -eq '2')
                else {                                                                      # All other inputs   
                    Write-Host $VmssAdminUserNameObject                                     # Write message to screen
                    $OperatorConfirm = Read-Host "Use this admin name [Y] or [N]"           # Operator confirmation of the admin username
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProUserName                                       # Breaks :SetAzureVmssProUserName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminUserNameObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminUserNameObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProUserName while ($true)
            :SetAzureVmssProPassword while ($true) {                                        # Inner loop for setting the admin password
                $VmssAdminPasswordObject = Read-Host "Enter the password"                   # Operator input for the admin password
                if ($VmssAdminPasswordObject -eq 'exit') {                                  # If $VmssAdminPasswordObject equals exit
                    Break SetAzureVmssOSProfile                                             # Breaks :SetAzureVmssOSProfile
                }                                                                           # End if ($VmssAdminPasswordObject -eq 'exit')
                else {                                                                      # All other inputs
                    Write-Host $VmssAdminPasswordObject                                     # Write message to screen   
                    $OperatorConfirm = Read-Host "Use this admin password [Y] or [N]"       # Operator confirmation of the admin password
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzureVmssProPassword                                       # Breaks :SetAzureVmssProPassword 
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # All other inputs
                        $VmssAdminPasswordObject = $null                                    # Clears $var
                    }                                                                       # End else (if ($OperatorConfirm -eq 'y'))
                }                                                                           # End else (if ($VmssAdminPasswordObject -eq 'exit'))
            }                                                                               # End :SetAzureVmssProPassword while ($true)
            $VmssOSProfileObject = Set-AzVmssOsProfile -VirtualMachineScaleSet `
            $VmssConfigObject -ComputerNamePrefix $VmssNamePrefixObject -AdminUsername `
            $VmssAdminUserNameObject -AdminPassword $VmssAdminPasswordObject                # Creates the VM scale set os profile
            if (!$VmssOSProfileObject) {                                                    # If $VmssOSProfileObject is $null
                Write-Host "An error has occured"
                Break SetAzureVmssOSProfile                                                 # Breaks :SetAzureVmssOSProfile
            }                                                                               # End if (!$VmssOSProfileObject)
            else {                                                                          # If $VmssOSProfileObject is not $null
                Return $VmssOSProfileObject                                                 # Returns to calling function with $VmssOSProfileObject
            }                                                                               # End else ((!$VmssOSProfileObject))
        }                                                                                   # End :SetAzureVmssOSProfile while ($true)     
        Return                                                                              # Returns to calling function with $null                                    
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVmssOsProfile 
function SetAzVmssStorageProfile {                                                          # Function to create a VM scale set operating system image and storage profile
    Begin {                                                                                 # Begin function
        :SetAzureVmssStorageProfile while ($true) {                                         # Outer loop for managing function
            $RGObject = $null                                                               # Sets $RGObject to $null for storage container selection
            $VMImageObject = SetAzVMOS                                                      # Calls function and assigns output for $var
            if (!$VMImageObject) {                                                          # If $var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile 
            }                                                                               # End if (!$VMImageObject)
            $StorageConObject = GetAzStorageContainer                                       # Calls function and assigns output for $var
            if (!$StorageConObject) {                                                       # If $var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile
            }                                                                               # End if (!$StorageConObject)
            $VmssStorageProfileObject = Set-AzVmssStorageProfile -VirtualMachineScaleSet `
                $VmssConfigObject -OsDiskCreateOption "FromImage" -ImageReferencePublisher `
                $VMImageObject.PublisherName -ImageReferenceOffer $VMImageObject.Offer `
                -ImageReferenceSku $VMImageObject.Skus -ImageReferenceVersion `
                $VMImageObject.Version -VhdContainer $StorageConObject                      # Sets the VM scale set os profile
            if (!$VmssStorageProfileObject) {                                               # If $Var is null
                Break SetAzureVmssStorageProfile                                            # Breaks :SetAzureVmssStorageProfile
            }                                                                               # End if (!$VmssStorageProfileObject)
            else {                                                                          # If $var has a value
                Return $VmssStorageProfileObject                                            # Returns to calling function
            }                                                                               # End else (if (!$VmssStorageProfileObject))
        }                                                                                   # End :SetAzureVmssStorageProfile while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SetAzVmssStorageProfile
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host "[0] Exit"                                                   # Write message to screen
                    Write-Host "[1] Windows"                                                # Write message to screen
                    Write-Host "[2] Linux"                                                  # Write message to screen
                    $ImageTypeObject = Read-Host '[0], [1], or [2]'                         # Operator input for the image type
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
                        Write-Host '0 Exit'                                                 # Write message to screen
                        foreach ($_ in $ImagePublisherArray) {                              # For each item in $ImagePublisherArray
                            Write-Host $_.Number $_.Name                                    # Write message to screen
                        }                                                                   # End foreach ($_ in $ImagePublisherArray)
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            $PublisherSelect = Read-Host "Publisher number"                 # Operator selection of the publisher
                            if ($PublisherSelect -eq '0') {                                 # If $Pubselect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($PublisherSelect -eq '0')
                            $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                {$_.Number -eq $PublisherSelect}                            # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $PublisherSelect
                            If ($VMPublisherObject) {                                       # If $VMPublisherObject has a value
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End If ($VMPublisherObject)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host "That was not a valid option"                    # Write message to screen
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
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {
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
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageOfferArray) {                                          # For each $_ in $ImageOfferArray
                    Write-Host $_.Number $_.Name                                            # Writes offer number and name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    $OfferSelect = Read-Host "Enter the offer number"                       # Operator input for the offer selection
                    if ($OfferSelect -eq '0') {                                             # If $OfferSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')
                    $VMOfferObject = $ImageOfferArray | Where-Object `
                        {$_.Number -eq $OfferSelect}                                        # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OfferSelect
                    if ($VMOfferObject) {                                                   # If $VMOfferObject has a value
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMOfferObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               #
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
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageSkuArray) {                                            # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    $SkuSelect = Read-Host "Enter the sku number"                           # Operator input for selecting the image sku
                    if ($SkuSelect -eq '0') {                                               # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')                                           
                    $VMSkuObject = $ImageSkuArray | Where-Object {$_.Number -eq $SkuSelect} # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    if ($VMSkuObject) {                                                     # If $VMSkuObject has a value
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                $ImageVersionList =  Get-AzVMImage -Location `
                    $LocationObject.Location -PublisherName $VMPublisherObject `
                    -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Name                     # Gets image version list and assigns to $var
                $ImageVersionNumber = 1                                                     # Sets $ImageSkuNumber to 1
                [System.Collections.ArrayList]$ImageVersionArray = @()                      # Creates the $ImageSkuArray     
                foreach ($_ in $ImageVersionList) {                                         # For each Sku in $ImageSkuList
                    $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                        'Number' = $ImageVersionNumber}                                     # Creates the item to loaded into array
                    $ImageVersionArray.Add($ImageVersionInput) | Out-Null                   # Loads item into array, out-null removes write to screen
                    $ImageVersionNumber = $ImageVersionNumber + 1                           # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageVersionArray) {                                        # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End 
                :SelectAzureImageVersion while ($true) {                                    # Inner loop for selecting the image sku
                    $VersionSelect = Read-Host "Enter the Version number"                   # Operator input for selecting the image sku
                    if ($VersionSelect -eq '0') {                                           # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')                                           
                    $VMVersionObject = $ImageVersionArray | `
                        Where-Object {$_.Number -eq $VersionSelect}                         # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    if ($VMVersionObject) {                                                 # If $VMSkuObject has a value
                        $VMImageObject = Get-AzVMImage -Location `
                        $LocationObject.Location -PublisherName $VMPublisherObject `
                        -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Name -Version `
                        $VMVersionObject.Name                                               # If #VMVersionObject has a value, pull the full object and assign to $var
                        Break GetAzureImageVersion                                          # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImageVersion while ($true)
            }                                                                               # End :GetAzureImageVersion while ($true)
            Return $VMImageObject                                                           # Returns #VMImageObject
        }                                                                                   # End :GetAZVMImage while ($true)
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMOS
function GetAzStorageContainer {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            $SCList = Get-AzStorageContainer -Context $StorageAccObject.Context
            $SCListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $SCList) { # For each item in list
                Write-Host $SCListNumber"." $_.Name # Writes the option number and storage container name
                $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
            } # End foreach ($_ in $SCList)
            :GetAzureStorageConName while ($true) { # Loop for selecting the storage container object
                $SCListNumber = 1 # Resets list number to 1
                $SCListSelect = Read-Host "Please enter the number of the storage container" # Operator input for selecting which storage container
                if ($SCListSelect -eq '0') { # If $SCListSelect is equal to 0
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($SCListSelect -eq '0')
                foreach ($_ in $SCList) { # For each item in list
                    if ($SCListSelect -eq $SCListNumber) { # If the operator input matches the current $SCListNumber
                        $StorageConObject = Get-AzStorageContainer -Context $StorageAccObject.Context -Name $_.Name # collects the full storage container object
                        Break GetAzureStorageConName # Breaks :GetAzureStorageConName 
                    } # End if ($SCListSelect -eq $SCListNumber)
                    else { # If user input does not match the current $SCListNumber
                        $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
                    } # End else (if ($SCListSelect -eq $SCListNumber))
                } # End foreach ($_ in $SCList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :GetAzureStorageConName while ($true)
            Return $StorageConObject
        } # End GetAzureStorageContainer
        Return # Returns to calling function with #null
    } # End Begin
} # End GetAzStorageContainer
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$StorageAccList) { # If $StorageAcclist returns empty
                Write-Host "No storage accounts found" # Message write to screen
                Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
            } # End if (!$StorageAccList)
            $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                Write-Host $StorageAccListNumber"." $_.StorageAccountName # Writes $StorageAccList to screen
                $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
            } # End foreach ($_ in $StorageAccList)
            :GetAzureStorageAccount while ($true) {
                $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
                $StorageAccListSelect = Read-Host "Please enter the number of the storage account" # Operator input for the storage account selection
                if ($StorageAccListSelect -eq '0') { # If $StorageAccList is '0'
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # if ($StorageAccListSelect -eq '0')
                foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                    if ($StorageAccListSelect -eq $StorageAccListNumber) { # If the operator input matches the current $StorageAccListNumber
                        $StorageAccObject = $_ # Assigns current item in $StorageAccList to $StorageAccObject
                        Break GetAzureStorageAccount # Breaks :GetAzureStorageAccount
                    } # End if ($StorageAccListSelect -eq $StorageAccListNumber)
                    else { # If user input does not match the current $StorageAccListNumber
                        $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
                    } # End else (if ($StorageAccListSelect -eq $StorageAccListNumber))
                } # End foreach ($_ in $StorageAccList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $StorageAccObject # Returns to calling function with $StorageAccObject
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
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
function SetAzVMOS {                                                                        # Function to get a image for a new VM
    Begin {                                                                                 # Begin function
        :GetAzureVMImage while ($true) {                                                    # Outer loop for managing function
            :GetAzureImagePublisher while ($true) {                                         # Inner loop for setting the publisher
                if (!$ImageTypeObject) {                                                    # If $ImageTypeObject is $null
                    Write-Host "[0] Exit"                                                   # Write message to screen
                    Write-Host "[1] Windows"                                                # Write message to screen
                    Write-Host "[2] Linux"                                                  # Write message to screen
                    $ImageTypeObject = Read-Host '[0], [1], or [2]'                         # Operator input for the image type
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
                        Write-Host '0 Exit'                                                 # Write message to screen
                        foreach ($_ in $ImagePublisherArray) {                              # For each item in $ImagePublisherArray
                            Write-Host $_.Number $_.Name                                    # Write message to screen
                        }                                                                   # End foreach ($_ in $ImagePublisherArray)
                        :SelectAzurePub while ($true) {                                     # Inner loop for selecting the publisher
                            $PublisherSelect = Read-Host "Publisher number"                 # Operator selection of the publisher
                            if ($PublisherSelect -eq '0') {                                 # If $Pubselect -eq 0
                                Break GetAzureVMImage                                       # Breaks :GetAzureVMImage
                            }                                                               # End ($PublisherSelect -eq '0')
                            $VMPublisherObject = $ImagePublisherArray | Where-Object `
                                {$_.Number -eq $PublisherSelect}                            # $VMPublisherObject equals $ImagePublisherArray where $ImagePublisherArray.Number is equal to $PublisherSelect
                            If ($VMPublisherObject) {                                       # If $VMPublisherObject has a value
                                Break SelectAzurePub                                        # Breaks :SelectAzurePub
                            }                                                               # End If ($VMPublisherObject)
                            else {                                                          # If $VMPublisherObject does not have a value
                                Write-Host "That was not a valid option"                    # Write message to screen
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
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ImageTypeObject -eq '0'))
            }                                                                               # End :GetAzureImagePublisher while ($true)
            :GetAzureImageOffer while ($true) {
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
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageOfferArray) {                                          # For each $_ in $ImageOfferArray
                    Write-Host $_.Number $_.Name                                            # Writes offer number and name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageOffer while ($true) {                                      # Inner loop to select the image offer
                    $OfferSelect = Read-Host "Enter the offer number"                       # Operator input for the offer selection
                    if ($OfferSelect -eq '0') {                                             # If $OfferSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')
                    $VMOfferObject = $ImageOfferArray | Where-Object `
                        {$_.Number -eq $OfferSelect}                                        # $VMOfferObject is equal to $ImageOfferArray where $ImageOfferArray.Number equals $OfferSelect
                    if ($VMOfferObject) {                                                   # If $VMOfferObject has a value
                        Break GetAzureImageOffer                                            # Breaks :SelectAzureImage
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMOfferObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageOffer while ($true)
            :GetAzureImageSku while ($true) {                                               #
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
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageSkuArray) {                                            # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End foreach ($_ in $ImageOfferArray)
                :SelectAzureImageSku while ($true) {                                        # Inner loop for selecting the image sku
                    $SkuSelect = Read-Host "Enter the sku number"                           # Operator input for selecting the image sku
                    if ($SkuSelect -eq '0') {                                               # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')                                           
                    $VMSkuObject = $ImageSkuArray | Where-Object {$_.Number -eq $SkuSelect} # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    if ($VMSkuObject) {                                                     # If $VMSkuObject has a value
                        Break GetAzureImageSku                                              # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImage while ($true)
            }                                                                               # End :GetAzureImageSku while ($true)
            :GetAzureImageVersion while ($true) {                                           # Pulls the full $VMOfferObject
                $ImageVersionList =  Get-AzVMImage -Location `
                    $LocationObject.Location -PublisherName $VMPublisherObject `
                    -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Name                     # Gets image version list and assigns to $var
                $ImageVersionNumber = 1                                                     # Sets $ImageSkuNumber to 1
                [System.Collections.ArrayList]$ImageVersionArray = @()                      # Creates the $ImageSkuArray     
                foreach ($_ in $ImageVersionList) {                                         # For each Sku in $ImageSkuList
                    $ImageVersionInput = [PSCustomObject]@{'Name' = $_.Version; `
                        'Number' = $ImageVersionNumber}                                     # Creates the item to loaded into array
                    $ImageVersionArray.Add($ImageVersionInput) | Out-Null                   # Loads item into array, out-null removes write to screen
                    $ImageVersionNumber = $ImageVersionNumber + 1                           # Increments $ImageSkuNumber by 1
                }                                                                           # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"                                                         # Write message to screen
                foreach ($_ in $ImageVersionArray) {                                        # For each $_ in $ImageSkuArray
                    Write-Host $_.Number $_.Name                                            # Writes $ImageSkuArray.number and $ImageSkuArray.Name to screen
                }                                                                           # End 
                :SelectAzureImageVersion while ($true) {                                    # Inner loop for selecting the image sku
                    $VersionSelect = Read-Host "Enter the Version number"                   # Operator input for selecting the image sku
                    if ($VersionSelect -eq '0') {                                           # If $SkuSelect equals 0
                        Break GetAzureVMImage                                               # Breaks :GetAzureVMImage
                    }                                                                       # End if ($OfferSelect -eq '0')                                           
                    $VMVersionObject = $ImageVersionArray | `
                        Where-Object {$_.Number -eq $VersionSelect}                         # $VMSkuObject equals $ImageSkuArray where $ImageSkuArray.Number equals $SkuSelect
                    if ($VMVersionObject) {                                                 # If $VMSkuObject has a value
                        $VMImageObject = Get-AzVMImage -Location `
                        $LocationObject.Location -PublisherName $VMPublisherObject `
                        -Offer $VMOfferObject.Offer -Skus $VMSkuObject.Name -Version `
                        $VMVersionObject.Name                                               # If #VMVersionObject has a value, pull the full object and assign to $var
                        Break GetAzureImageVersion                                          # Break SelectAzureImageSku
                    }                                                                       # End if ($VMOfferObject)
                    else {                                                                  # If $VMSkuObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($VMOfferObject))
                }                                                                           # End :SelectAzureImageVersion while ($true)
            }                                                                               # End :GetAzureImageVersion while ($true)
            Return $VMImageObject                                                           # Returns #VMImageObject
        }                                                                                   # End :GetAZVMImage while ($true)
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
                    $OperatorConfirm = Read-Host "Confirm:"$CoreCount" cores? [Y] or [N]"   # Operator confirmation of core count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMCoreCount                                           # Breaks :SetAzureVMCoreCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y') 
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
                    $OperatorConfirm = Read-Host "Confirm:" `
                    $RamCount" MB of Ram? [Y] or [N]"                                       # Operator confirmation on ram count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMRamCount                                            # Breaks :SetAzureRamCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
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
                    $OperatorConfirm = Read-Host `
                    "Confirm"$DiskCount" max disks? [Y] or [N]"                             # Operator confirmation of the disk count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureVMDiskCount                                           # Breaks :SetAzureVMDiskCount
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
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