# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancerFrontendIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0    
} #>
<# Required Functions Links: {
    NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
    NewAzPublicIpAddress:       Creates a new public IP addres
    GetAzPublicIpAddress:       Gets an existing IP address
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {      
    :NewAzureLBFEIpConfig       Outer loop for managing function
    :GetAzurePublicIP           Inner loop for getting a public IP
    :SetAzureLBFEName           Inner loop for setting the front end name
    $PublicIPType:              Operator input for creating a new public IP or getting an existing one
    $PublicIPObject:            Public IP Object
    $FrontEndNameObject:        Operator input for the front end name
    $OperatorConfirm:           Operator confirmation of the front end name
    $FrontEndIPConfigObject:    Front end IP config object
    NewAzPublicIpAddress{}      Creates $PublicIPObject
        GetAzResourceGroup{}        Gets $RGObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject    
} #>
<# Process Flow {
    function
        Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject    
            Call NewAzPublicIpAddress > Get $PublicIPObject
                Call GetAzResourceGroup > Get RGObject
                End GetAzResourceGroup
                    Return NewAzPublicIpAddress > Send RGObject
            End NewAzPublicIpAddress
                Return NewAzLBFrontendIpConfig > Send $PublicIPObject
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return NewAzLBFrontendIpConfig > Send $PublicIPObject        
        End NewAzLBFrontendIpConfig
            Return function > Send $FrontEndIPConfigObject
}#>
function NewAzLBFrontendIpConfig {                                                          # Function to set up the front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :GetAzurePublicIP while ($true) {                                               # Inner loop for getting the public IP
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] New Public IP"                                              # Write message to screen
                Write-Host "[2] Existing public IP"                                         # Write message to screen
                $PublicIPType = Read-Host "[0], [1], or [2]"                                # Operator input for getting the public IP
                if ($PublicIPType -eq '0') {                                                # If $PublicIPType equals '0'
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if ($PublicIPType -eq '0')
                elseif ($PublicIPType -eq '1') {                                            # If $PublicIPType equals 1
                    $PublicIPObject = NewAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '1')
                elseif ($PublicIPType -eq '2') {                                            # If $PublicIPType equals 2
                    $PublicIPObject = GetAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else(if ($PublicIPType -eq '0'))
            }                                                                               # End :GetAzurePublicIP while ($true)
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                $FrontEndNameObject = Read-Host "Front end Name"                            # Operator input for the front end name
                if ($FrontEndNameObject -eq 'exit') {                                       # If $FrontEndNameObject equals $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLBFEIpConfig
                }                                                                           # End if ($FrontEndNameObject -eq 'exit')
                Write-Host $FrontEndNameObject                                              # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the front end name? [Y] or [N]"        # Operator confirmation of the front end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBFEName                                                  # Breaks :SetAzureLBFEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBFEName while ($true)
            $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                $FrontEndNameObject -PublicIpAddress $PublicIPObject                        # Creates the load balancer front end pool
            if ($FrontEndIPConfigObject) {                                                  # If $FrontEndIPConfigObject has a value
                Return $FrontEndIPConfigObject                                              # Returns to calling function with $
            }                                                                               # End if ($FrontEndIPConfigObject)
            else {                                                                          # If $FrontEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End else (if ($FrontEndIPConfigObject))
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFrontendIpConfig
function NewAzPublicIpAddress {                                                             # Creates a new public IP address
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                Try {                                                                       # Try the following
                    [ValidatePattern('^[a-z][a-z0-9-]{1,61}[a-z0-9]$')]$PublicIPNameObject `
                    = [string](Read-Host "Enter the public IP name").ToLower()              # Operator input for the public IP name
                }                                                                           # End try
                catch {                                                                     # Error reporting for try statement
                    Write-Host "! That enty was not valid"                                  # Write message to screen
                    Write-Host "! Valid entries are 1-61 characters"                        # Write message to screen
                    Write-Host "! The name must start with a letter"                        # Write message to screen
                    Write-Host "! Special charaters are not allowed"                        # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End catch
                if ($PublicIPNameObject) {
                    if ($PublicIPNameObject -eq 'exit') {                                   # IF $PublicIPNameObject equals 'exit'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($PublicIPNameObject -eq 'exit')
                    Write-Host $PublicIPNameObject                                          # Write message to screen
                    $OperatorConfirm = Read-Host "Use this name [Y] or [N]"                 # Operator confirmation of the name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If $OperatorConfirm does not equal 'y'
                        Remove-Variable PublicIPNameObject                                  # Removes $PublicIPNameObject
                    }                                                                       # End else if ($OperatorConfirm -eq 'y')
                }                                                                           # End if ($PublicIPNameObject) 
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $PublicIPAllocationObject = Read-Host "[0], [1], or [2]"                    # Operator input for the allocation method
                if ($PublicIPAllocationObject -eq '0') {                                    # If $PublicIPAllocationObject equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($PublicIPAllocationObject -eq '1') {                                # Elseif $PublicIPAllocationObject equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($PublicIPAllocationObject -eq '2') {                                # Elseif $PublicIPAllocationObject equals 2
                    $PublicIPAllocationObject = 'static'                                    # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            $PublicIPObject = New-AzPublicIpAddress -Name $PublicIPNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                -DomainNameLabel $PublicIPNameObject -Force                                 # Creates the new public IP address
            if ($PublicIPObject) {                                                          # If $PublicIPObject is not $null
                Return $PublicIPObject                                                      # Returns to calling function with $PublicIPObject
            }                                                                               # End if ($PublicIPObject)
            else {                                                                          # If $PublicIPObject is $null 
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End else (if ($PublicIPObject))
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for 
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            Write-Host "[ 0 ] to exit"                                                      # Write message to screen
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name;'Number' `
                    = $PublicIPNumber;'RG' = $_.ResourceGroupName;'Sku'=$_.Sku.Name `
                ;'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress}           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "["$_.Number"]"                                                  # Write message to screen
                Write-Host "Name "$_.Name                                                   # Write message to screen
                Write-Host "RG:  "$_.RG                                                     # Write message to screen
                Write-Host "Type:"$_.Allocation                                             # Write message to screen
                Write-Host "Add: "$_.address                                                # Write message to screen
                Write-Host "Sku: "$_.Sku                                                    # Write message to screen                            
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
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