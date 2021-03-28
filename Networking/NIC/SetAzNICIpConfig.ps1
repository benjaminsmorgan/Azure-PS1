# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    NewAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    SetAzNICIpConfig:           Updates a NIC IP configuration
    NewAzNetworkInterface:      Creates new network interfaces
    GetAzNetworkInterface:      Gets an existing network interface
    RemoveAzNetworkInterface:   Removes a network interface   
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzResourceGroup:         Gets a resource group
    GetAzLocation:              Gets an azure location
    NewAzPublicIpAddress:       Creates a new public IP address
    GetAzPublicIpAddress:       Gets an existing public IP address
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    :SelectAzureNic             Inner loop for getting or creating a nic
    :GetAzureNicIPConfig        Inner loop for getting the nic ip config
    :SelectAzureNicIPConfig     Inner loop for selecting the nic ip config
    :SelectAzureIPType          Inner loop for selecting private or public IP
    :SelectAzurePrivateIP       Inner loop for selecting a static or dynamic IP
    :SelectAzurePublicIP        Inner loop for creating or getting a public IP
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator selection option
    $NicObject:                 The nic whos configuration is being changed
    $SubnetObject:              Subnet of the nic (Not used)
    $VnetObject:                Vnet holding the subnet (Not used)
    $NicIPList:                 List of all IP configs on nic
    $CurrentPubIPId:            Current object in $NicIPList public IP sku id if existing             
    $CurrentPubIP:              The public IP sku object of the current $NicIPList if existing 
    $ListNumber:                Number used in $ListArray
    $ListArray:                 Used to display nic ip configs
    $ListInput:                 $var used to load info into $ListArray
    $NicIPCon:                  $var used to apply the changes to a selected config
    $PrivateIPObject:           Operator input for the new private IP address
    $PublicIPObject:            Public IP object
    NewAzNetworkInterface{}     Creates $NicObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    GetAzNetworkInterface{}     Gets $NicObject
    NewAzPublicIpAddress{}      Creates $PublicIPObject
        GetAzResourceGroup{}        Gets $RGObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call SetAzNICIpConfig > Get $NicObject
            Call NewAzNetworkInterface > Get $NicObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzNetworkInterface > Send $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzNetworkInterface > Send $LocationObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End NewAzNetworkInterface
                Return SetAzNICIpConfig > Send $NicObject
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return SetAzNICIpConfig > $NicObject
            Call NewAzPublicIpAddress > Get $PublicIPObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzPublicIpAddress > Send $RGObject
            End NewAzPublicIpAddress
                Return SetAzNICIpConfig > Send $PublicIPObject
            Call GetAzPublicIpAddress{}      Gets $PublicIPObject
            End NewAzPublicIpAddress
                Return SetAzNICIpConfig > Send $PublicIPObject
        End SetAzNICIpConfig
            Return function > Send $NicObject
}#>
function SetAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'SetAzNICIpConfig'                                       # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting a NIC
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] New NIC'                                                    # Write message to screen
                Write-Host '[2] Existing NIC'                                               # Write message to screen
                $OperatorSelect = Read-Host 'Select [#] option'                             # Operator input for a new or existing NIC
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break SetAzureNICIpConfig                                               # Breaks :SetAzureNICIpConfig
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -eq '1') {                                          # Else if $OperatorSelect equals '1'
                    $NicObject, $SubnetObject, $VnetObject = NewAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$NicObject -or !$SubnetObject -or !$VnetObject) {                  # If $NicObject, $SubnetObject, or $VnetObject is $null
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                    else {                                                                  # If $NicObject, $SubnetObject, and $VnetObject have a value
                        Break SelectAzureNic                                                # Breaks :SelectAzureNic
                    }                                                                       # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                }                                                                           # End elseif ($OperatorSelect -eq '1')
                elseif ($OperatorSelect -eq '2') {                                          # Else if $OperatorSelect equals '1'
                    $NicObject, $SubnetObject, $VnetObject = GetAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$NicObject -or !$SubnetObject -or !$VnetObject) {                  # If $NicObject, $SubnetObject, or $VnetObject is $null
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                    else {                                                                  # If $NicObject, $SubnetObject, and $VnetObject have a value
                        Break SelectAzureNic                                                # Breaks :SelectAzureNic
                    }                                                                       # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                }                                                                           # End elseif ($OperatorSelect -eq '2')
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # Inner loop for selecting a new or existing nic
            :GetAzureNicIPConfig while ($true) {                                            # Inner loop for selecting the nic IP config
                $NicIPList = $NicObject.IPConfigurations                                    # Gets list of all existing IP configs
                $ListNumber = 1                                                             # Sets list number for $ListArray
                [System.Collections.ArrayList]$ListArray = @()                              # Array used to present information
                foreach ($_ in $NicIPList) {                                                # For each item in $NicIPList
                    if ($_.PublicIPaddress.ID) {                                            # If a public IP sku is attached
                        $CurrentPubIPId = $_.PublicIPaddress.ID                             # Assigns current item .PublicIPaddress.ID to $CurrentPubIPId
                        $CurrentPubIP = Get-AzPublicIpAddress | Where-Object `
                            {$_.Id -eq $CurrentPubIPId}                                     # Pulls the public IP sku info
                    }                                                                       # End if ($CurrentNicIPConfig.PublicIPaddress.ID)
                    $ListInput = [PSCustomObject]@{'Number'=$ListNumber;'Primary' `
                        =$_.Primary;'name'=$_.Name;'PrivIP'=$_.PrivateIPAddress; `
                        'PrivAllo'=$_.PrivateIpAllocationMethod;'pubinfo'=$CurrentPubIP}    # Adds info to $ListInput   
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads content of $ListInput into $ListArray
                    $ListNumber = $ListNumber + 1                                           # Increments $ListNumber up by one
                    $CurrentPubIPId = $null                                                 # Clears $var
                    $CurrentPubIP = $null                                                   # Clears $var
                }                                                                           # End foreach ($_ in $NicIPList)
                Write-Host '[ 0 ] Exit'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each item in $ListArray
                    Write-Host '['$_.Number']'                                              # Write message to screen
                    Write-Host 'Name:    '$_.Name                                           # Write message to screen
                    Write-Host 'Primary: '$_.Primary                                        # Write message to screen
                    Write-Host 'PrivIP:  '$_.PrivIP                                         # Write message to screen
                    Write-Host 'PrivAllo:'$_.PrivAllo                                       # Write message to screen
                    if ($_.Pubinfo) {                                                       # If $_.Pubinfo has a value 
                        Write-Host 'PubIP:   '$_.Pubinfo.name                               # Write message to screen
                        Write-Host 'PubIP:   '$_.Pubinfo.IPaddress                          # Write message to screen
                        Write-Host 'PubAllo: '$_.Pubinfo.PublicIpAllocationMethod           # Write message to screen
                    }                                                                       # End if ($_.Pubinfo) 
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ListArray)
                :SelectAzureNicIPConfig while ($true) {                                     # Inner loop for selecting the IP configuration
                    $OperatorSelect = Read-Host 'Select [#] of Nic IP config'               # Operator input for selecting the IP config
                    if ($OperatorSelect -eq '0') {                                         # If $OperatorSelect equals '0'
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    
                    elseif ($OperatorSelect -in $ListArray.Number) {                        # Else if $OperatorSelect in $ListArray.Number
                        $NicIPCon = $OperatorSelect - 1                                     # Sets $NicIPCon
                        Break GetAzureNicIPConfig                                           # Breaks :GetAzureNicIPConfig
                    }                                                                       # End elseif ($OperatorSelect -in $ListArray.Number)
                    else {                                                                  # All other inputs for $OperatorSelect
                        Write-Host 'That was not a valid selection'                         # Write message to screen
                    }                                                                       # End else (if ($OperatorSelect -eq '0'))
                }                                                                           # End :SelectAzureNicIPConfig while ($true)
            }                                                                               # End :GetAzureNicIPConfig while ($true)
            :SelectAzureIPType while ($true) {                                              # Inner loop for setting the IP type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private IP'                                                 # Write message to screen
                Write-Host '[2] Public IP'                                                  # Write message to screen
                $OperatorSelect = Read-Host 'Select [#] option'                             # Operator input for the IP type
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break SetAzureNICIpConfig                                               # Breaks :SetAzureNICIpConfig
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -eq '1') {                                          # Else if $OperatorSelect equals '1'
                    :SelectAzurePrivateIP while ($true) {                                   # Inner loop for setting the private IP allocation
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Dynamic'                                            # Write message to screen
                        Write-Host '[2] Static'                                             # Write message to screen
                        $OperatorSelect = Read-Host 'Select [#] option'                     # Operator input for selecting the private IP allocation
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals 0
                            Break SelectAzurePrivateIP                                      # Breaks :SelectAzurePrivateIP
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -eq '1') {                                  # Else if $OperatorSelect equals '1'
                            $NicObject.IpConfigurations[$NicIPCon].PrivateIpAllocationMethod `
                            = 'dynamic'                                                     # Sets Nic private to dynamic
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                        }                                                                   # End elseif ($OperatorSelect -eq '1')
                        elseif ($OperatorSelect -eq '2') {                                  # Else if $OperatorSelect equals '2'
                            :SetAzurePrivateIP while ($true) {                              # Inner loop for setting the static IP
                                $PrivateIPObject = Read-Host 'Please enter the new IP'      # Operator input for the static IP
                                if ($PrivateIPObject -eq 'exit') {                          # If $PriveIPObject equals 'exit'
                                    Break SetAzureNICIpConfig                               # Breaks :SetAzureNICIpConfig
                                }                                                           # End if ($PrivateIPObject -eq 'exit')
                                Write-Host `
                                    'Use'$PrivateIPObject' as the new private IP address'   # Write message to screen
                                $OperatorConfirm = Read-Host '[Y] or [N]'                   # Operator confirmation of the private IP
                                if ($OperatorConfirm -eq 'y') {                             # If $OperatorConfirm equals 'y'
                                    $NicObject.IpConfigurations[$NicIPCon].PrivateIpAddress `
                                        = $PrivateIPObject                                  # Assigns the static IP
                                    $NicObject.IpConfigurations[$NicIPCon].PrivateIpAllocationMethod `
                                        = 'static'                                          # Assigns the allocation method
                                    Break SelectAzureIPType                                 # Breaks :SelectAzureIPType
                                }                                                           # End if ($OperatorConfirm -eq 'y')
                            }                                                               # End :SetAzurePrivateIP while ($true)
                        }                                                                   # End elseif ($OperatorSelect -eq '2')
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzurePrivateIP while ($true)
                }                                                                           # End elseif ($OperatorSelect -eq '1')
                elseif ($OperatorSelect -eq '2') {                                          # Else if $OperatorSelect equals '1'
                    :SelectAzurePublicIP while ($true) {                                    # Inner loop for getting a public IP
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] New public IP'                                      # Write message to screen
                        Write-Host '[2] Existing public IP'                                 # Write message to screen
                        Write-Host '[3] Remove the existing public IP'                      # Write message to screen
                        $OperatorSelect = Read-Host 'Select [#] option'                     # Operator input for selecting a new or existing public IP
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals 0
                            Break SelectAzurePublicIP                                       # Breaks :SelectAzurePublicIP
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -eq '1') {                                  # Else if $OperatorSelect equals 1
                            $PublicIPObject = NewAzPublicIpAddress ($CallingFunction)       # Calls function and assigns output to $var
                            if (!$PublicIPObject) {                                         # If $PublicIPObject is $null
                                Break SelectAzurePublicIP                                   # Breaks :SelectAzurePublicIP
                            }                                                               # End if (!$PublicIPObject)
                            else {                                                          # If $PublicIPAddress has a value
                                $NicObject.IpConfigurations[$NicIPCon].PublicIPAddress = `
                                    $PublicIPObject                                         # Assigns the public IP to the IP configuration
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                            }                                                               # End else (if (!$PublicIPObject))
                        }                                                                   # End elseif ($OperatorSelect -eq '1')
                        elseif ($OperatorSelect -eq '2') {                                  # Else if $OperatorSelect equals 2
                            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)       # Calls function and assigns output to $var
                            if (!$PublicIPObject) {                                         # If $PublicIPObject is $null
                                Break SelectAzurePublicIP                                   # Breaks :SelectAzurePublicIP
                            }                                                               # End if (!$PublicIPObject)
                            else {                                                          # If $PublicIPAddress has a value
                                $NicObject.IpConfigurations[$NicIPCon].PublicIPAddress = `
                                    $PublicIPObject                                         # Assigns the public IP to the IP configuration
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                            }                                                               # End else (if (!$PublicIPObject))
                        }                                                                   # End elseif ($OperatorSelect -eq '2')
                        elseif ($OperatorSelect -eq '3') {                                  # Else if $OperatorSelect equals 3
                            $NicObject.IpConfigurations[$NicIPCon].PublicIPAddress = $null  # Clears the public IP to the IP configuration
                            Break SelectAzureIPType                                         # Breaks :SelectAzureIPType
                        }                                                                   # End elseif ($OperatorSelect -eq '3')
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzurePublicIP while ($true)
                }                                                                           # End elseif ($OperatorSelect -eq '2')
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureIPType while ($true)
            Try {                                                                           # Try the following
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break SetAzureNICIpConfig                                                   # Breaks SetAzureNICIpConfig
            }                                                                               # End catch                                                                      
            Write-Host 'The IP has been set'                                                # Write message to screen
            Return $NicObject                                                               # Returns to calling function with $Var
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig