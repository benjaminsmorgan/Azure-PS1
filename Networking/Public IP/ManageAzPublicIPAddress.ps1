# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Remove-AzPublicIpAddress:                   https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azpublicipaddress?view=azps-5.5.0 
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0    
} #>
<# Required Functions Links: {
    NewAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1    
    ListAzPublicIPAddress:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/ListAzPublicIpAddress.ps1
    GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    RemoveAzPublicIPAddress:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/RemoveAzPublicIpAddress.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzPublicIPAddress:    Function for managing public IP address Skus
    NewAzPublicIpAddress:       Creates a new public IP address    
    ListAzPublicIPAddress:      Lists all existing public IP addresses
    GetAzPublicIPAddress:       Gets an existing public IP address
    RemoveAzPublicIPAddress:    Removes an existing public IP address
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {      
    :ManageAzurePublicIPAddress Outer loop for managing function
    $PublicIPObject:            Public IP Sku object
    $OpSelect:            Operator input for selecting the management function
    NewAzPublicIPAddress{}      Creates $PublicIPObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzPublicIPAddress{}     Lists $PublicIPObject
    GetAzPublicIPAddress{}      Gets $PublicIPObject
    RemoveAzPublicIPAddress{}   Removes $PublicIPObject
        GetAzPublicIPAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call ManageAzPublicIPAddress > Get $PublicIPObject
            Call NewAzPublicIpAddress > Get $PublicIPObject
                Call GetAzResourceGroup > Get RGObject
                End GetAzResourceGroup
                    Return NewAzPublicIpAddress > Send RGObject
            End NewAzPublicIpAddress
                Return ManageAzPublicIPAddress > Send $PublicIPObject
            Call ListAzPublicIpAddress > Get $null
            End ListAzPublicIpAddress
                Return ManageAzPublicIPAddress > Send $null
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return ManageAzPublicIPAddress > Send $PublicIPObject
            Call RemoveAzPublicIPAddres > Get $null
                Call GetAzPublicIpAddress > Get $PublicIPObject
                End GetAzPublicIpAddress
                    Return RemoveAzPublicIPAddress > Send $PublicIPObject
            End RemoveAzPublicIPAddress
                Return ManageAzPublicIPAddress > Send $null
        End ManageAzPublicIPAddress
            Return function > Send $PublicIPObject
}#>
function ManageAzPublicIPAddress {                                                          # Function to manage public IP address Skus
    Begin {                                                                                 # Begin function
        :ManageAzurePublicIPAddress while ($true) {                                         # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New public IP sku'                                              # Write message to screen
            Write-Host '[2] List all public IP skus'                                        # Write message to screen
            Write-Host '[3] Remove a public IP sku'                                         # Write message to screen
            $OpSelect = Read-Host 'Enter the option [#]'                                    # Operator input for the function selection
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzurePublicIPAddress                                            # Breaks :ManageAzurePublicIPAddress
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New public IP sku'                                              # Write message to screen
                NewAzPublicIpAddress                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List all public IP skus'                                        # Write message to screen
                ListAzPublicIpAddress                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove a public IP sku'                                         # Write message to screen
                RemoveAzPublicIpAddress                                                     # Calls function 
            }                                                                               # elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzurePublicIPAddress while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzPublicIPAddress
function NewAzPublicIpAddress {                                                             # Function to create a new public IP address
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzPublicIpAddress'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup                                                  # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz'                                # Creates a string of valid first character
                $Valid1stChar = $Valid1stChar.ToCharArray()                                 # Loads all valid characters into array
                Write-Host 'Public IP name must begin with a letter'                        # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $PublicNameArray = $null                                                    # Clears $PublicNameArray
                $PublicNameInput = Read-Host 'Public IP name'                               # Operator input for the public IP name
                $PublicNameArray = $PublicNameInput.ToCharArray()                           # Loads $PublicNameInput into array
                Clear-Host                                                                  # Clears screen
                if ($PublicNameInput.Length -ge 81) {                                       # If $PublicNameInput.Length is greater or equal to 81
                    Write-Host 'The public IP name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PublicNameInput.Length -ge 62)
                if ($PublicNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $PublicNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter'           # Write message to screen
                    $PublicNameInput = $null                                                # Clears $PublicNameInput
                }                                                                           # End if ($PublicNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PublicNameArray) {                                          # For each item in $PublicNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Public IP name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PublicNameArray)
                if ($PublicNameInput) {                                                     # If $PublicNameInput has a value
                    Write-Host 'Use:'$PublicNameInput' as the public IP name'               # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    else {                                                                  # If $OpConfirm does not equal 'y'
                        $PublicNameInput = $null                                            # Clears $PublicNameInput
                    }                                                                       # End else if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PublicNameInput) 
                else {                                                                      # If $PublicNameInput does not have a value
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PublicNameInput))
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $PublicIPAllocationObject = 'static'                                    # Creates $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the public IP'                                         # Write message to screen
                New-AzPublicIpAddress -Name $PublicNameInput 
                    -ResourceGroupName $RGObject.ResourceGroupName -Location `
                    $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                    -DomainNameLabel $PublicIPNameObject -Force -ErrorAction 'Stop' `
                    | Out-Null                                                              # Creates the new public IP address
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The public IP has been created'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzurePublicIP                                                          # Breaks :NewAzurePublicIP
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function ListAzPublicIpAddress {                                                            # Function for listing all public IP address skus
    Begin {                                                                                 # Begin function
        :ListAzurePublicIP while ($true) {                                                  # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name; 'RG' = `
                    $_.ResourceGroupName;'Sku'=$_.Sku.Name;'Allocation'=`
                    $_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig}                           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "IP SKU Name "$_.Name                                            # Write message to screen
                Write-Host "RG Name:    "$_.RG                                              # Write message to screen
                Write-Host "Allocation: "$_.Allocation                                      # Write message to screen
                Write-Host "IP Address: "$_.address                                         # Write message to screen
                Write-Host "SKU Type:   "$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host "NIC Name:   "$_.Nic                                         # Write message to screen
                    Write-Host "NIC Config: "$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                  
                else {                                                                      # If current item .Nic does not have a value
                    Write-Host "NIC Name:    N/A"                                           # Write message to screen
                    Write-Host "NIC Config:  N/A"                                           # Write message to screen
                }                                                                           # End else (if ($_.Nic))
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            Break ListAzurePublicIP                                                         # Breaks :ListAzurePublicIP
        }                                                                                   # End :ListAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $PublicIPInput = [PSCustomObject]@{'Number'=$PublicIPNumber;`
                    'Name' = $_.Name;'RG'=$_.ResourceGroupName;'Sku'=$_.Sku.Name;`
                    'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig}                           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $PublicIPArray)
            Write-Host "[0] to exit"                                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                $Number = $_.Number                                                         # Creats $Number (Used for formating)
                Write-Host "[$Number]         "$_.Name                                      # Write message to screen
                Write-Host "RG Name:    "$_.RG                                              # Write message to screen
                Write-Host "Allocation: "$_.Allocation                                      # Write message to screen
                Write-Host "IP Address: "$_.address                                         # Write message to screen
                Write-Host "SKU Type:   "$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host "NIC Name:   "$_.Nic                                         # Write message to screen
                    Write-Host "NIC Config: "$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                                 
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function RemoveAzPublicIPAddress {                                                          # Function for removing a public IP Sku
    Begin {                                                                                 # Begin function
        :RemoveAzurePublicIP while ($true) {                                                # Outer loop for managing function
            $CallingFunction = 'RemoveAzPublicIPAddress'                                    # Sets $CallingFunction
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End if (!$PublicIPObject)
            }                                                                               # End if (!$PublicIPObject)
            if ($PublicIPObject.IpConfiguration.Id) {                                       # If PublicIPObject.IpConfiguration.Id has a value
                $AttachedNIC = ($PublicIPObject.IpConfiguration.Id).Split('/')[-3]          # Gets the attached NIC name
                $AttachedNICIPConfig = ($PublicIPObject.IpConfiguration.Id).Split('/')[-1]  # Gets the attached NIC IP config name
                Write-Host 'The selecting IP sku cannot be deleted'                         # Write message to screen
                Write-Host 'Please detach this sku from the following'                      # Write message to screen
                Write-Host 'Attached NIC:   '$AttachedNIC                                   # Write message to screen
                Write-Host 'Nic config name:'$AttachedNICIPConfig                           # Write message to screen
                Break RemoveAzurePublicIP                                                   # Breaks :RemoveAzurePublicIP
            }                                                                               # End if ($PublicIPObject.IpConfiguration.Id)
            else {                                                                          # If PublicIPObject.IpConfiguration.Id does not have a value
                Write-Host 'Remove the public IP'$PublicIPObject.name                       # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation to remove the public IP
                if ($OpConfirm -eq 'y') {                                             # If $OpConfirm equals 'y'
                    Try {                                                                   # Try the following
                        Remove-AzPublicIpAddress -Name $PublicIPObject.Name `
                            -ResourceGroupName $PublicIPObject.ResourceGroupName `
                            -Force -ErrorAction 'Stop'                                      # Removes the selected IP sku
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'You may not have to the permissions'                    # Write message to screen
                        Write-Host 'The resource or group maybe locked'                     # Write message to screen
                        Break RemoveAzurePublicIP                                           # Breaks :RemoveAzurePublicIP
                    }                                                                       # End catch
                    Write-Host 'The selected public IP sku has been removed'                # Write message to screen
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # If $OpConfirm does not equal 'y'
                    Break RemoveAzurePublicIP                                               # Breaks :RemoveAzurePublicIP
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($PublicIPObject.IpConfiguration.Id))
        }                                                                                   # End :RemoveAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzPublicIPAddress
# Additional functions required for ManageAzPublicIPAddress
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup