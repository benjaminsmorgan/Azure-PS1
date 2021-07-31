# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Add-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    New-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewall?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Remove-AzFirewall:                          https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    NewAzFirewall:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/NewAzFirewall.ps1
    ListAzFirewall:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/ListAzFirewall.ps1
    RemoveAzFirewall:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/RemoveAzFirewall.ps1
    GetAzFirewall:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/GetAzFirewall.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    ManageAzFirewall:           Function to manage firewalls
    NewAzFirewall:              Function to create a new firewall
    ListAzFirewall:             Function to list all firewalls
    RemoveAzFirewall:           Function to remove a firewall
    GetAzFirewall:              Function to get a firewall
    GetAzVirtualNetwork:        Function to get an existing azure virtual network
    GetAzPublicIPAddress:       Function to get an existing public IP address
} #>
<# Variables: {      
    :NewAzureFirewall           Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    NewAzFirewall{}             Creates $FirewallObject
        GetAzVirtualNetwork{}       Gets $VNetObject
        GetAzPublicIpAddress{}      Gets $PublicIPObject
    ListAzFirewall{}            Lists $FirewallObjects
    RemoveAzFirewall{}          Removes $FirewallObject
        GetAzFirewall{}             Gets $FirewallObject
} #>
<# Process Flow {
    function
        Call ManageAzFirewall > Get $null
            Call NewAzFirewall > Get $null
                Call GetAzVirtualNetwork > Get $VNetObject
                End GetAzVirtualNetwork
                    Return NewAzFirewall > Send $VNetObject
                Call GetAzPublicIpAddress > Get $PublicIPObject
                End GetAzPublicIpAddress
                    Return NewAzFirewall > Send $PublicIPObject                
            End NewAzFirewall
                Return ManageAzFirewall > Send $null
            Call ListAzFirewall > Get $null            
            End ListAzFirewall
                Return ManageAzFirewall > Send $null
            Call RemoveAzFirewall > Get $null
                Call GetAzFirewall > Get $FirewallObject            
                End GetAzFirewall
                    Return RemoveAzFirewall > Send $FirewallObject
            End RemoveAzFirewall
                Return ManageAzFirewall > Send $null
        End ManageAzFirewall
            Return function > Send $null
}#>
function ManageAzFirewall {                                                                 # Function to manage firewalls
    Begin {                                                                                 # Begin function
        :ManageAzureFirewall while ($true) {                                                # Outer loop for managing function
            Write-Host 'Manage Firewalls'                                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall'                                                   # Write message to screen
            Write-Host '[2] List Firewalls'                                                 # Write message to screen
            Write-Host '[3] Remove Firewall'                                                # Write message to screen
            Write-Host '[4] Manage Firewall Rules'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFirewall                                                   # Breaks :ManageAzureFirewall
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall'                                                   # Write message to screen
                NewAzFirewall                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewalls'                                                 # Write message to screen
                ListAzFirewall                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall'                                                # Write message to screen
                RemoveAzFirewall                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Firewall Rules'                                          # Write message to screen
                #FunctionGoHere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFirewall
function NewAzFirewall {                                                                    # Function to create a new firewall
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'SilentlyContinue'                                         # Disables error write
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzFirewall'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureFirewall while ($true) {                                                   # Outer loop for managing function
            Write-Host 'The following this must exist for this operation to complete:'      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Resource Group:  Any'                                               # Write message to screen
            Write-Host 'Virtual Network: No existing firewall'                              # Write message to screen
            Write-Host 'Public IP:       Standard Sku | Not in use'                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $var
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                Break NewAzureFirewall                                                      # Breaks :NewAzureFirewall
            }                                                                               # End if (!$VNetObject)
            $RGName = $VNetObject.ResourceGroupName                                         # Isolates the resource group name
            $LocName = $VNetObject.Location                                                 # Isolates the virtual network location
            $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject      # Gets a list of all subnets on $VNetObject
            $AFWSPresent = 'n'                                                              # Creates $AFWSPresent
            if ($SubnetList) {                                                              # If $SubnetList has a value
                foreach ($_ in $SubnetList) {                                               # For each item in $Subnetlist
                    if ($_.Name -eq 'AzureFirewallSubnet') {                                # If current item .name equals 'AzureFirewallSubnet'
                        $AFWSPresent = 'y'                                                  # Changes $AFWSPresent to 'y'
                    }                                                                       # End if ($_ -eq 'AzureFirewallSubnet')
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End if ($SubnetList)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureFWName while ($true) {                                                 # Inner loop for setting the firewall name
                Write-Host 'Enter the firewall name'                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FWNameObject = Read-Host 'Name'                                            # Operator input for the firewall name
                $FWNameArray = $FWNameObject.ToCharArray()                                  # Loads $FWNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($FWNameObject.Length -lt 0 -or $FWNameObject.Length -ge 56) {           # If $FWNameObject.Length is less than 1 or greater than 56 characters
                    Write-Host 'The firewall name must be between 1 and 56 characters'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameObject.Length -ge 80)
                if ($FWNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $FWNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameArray[0] -notin $Valid1stChar)
                if ($FWNameArray[-1] -notin $ValidLastChar) {                               # If last position of $FWNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FWNameArray) {                                              # For each item in $FWNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Firewall name cannot include any spaces'            # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FWNameObject = $null                                               # Clears $FWNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FWNameArray)
                if ($FWNameObject) {                                                        # If $FWNameObject has a value
                    Write-Host 'Use:'$FWNameObject' as the firewall name'                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the firewall name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureFirewall                                              # Breaks :NewAzureFirewall
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureFWName                                                # Breaks :SetAzureFWName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FWNameObject)
                else {                                                                      # If $FWNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FWNameObject))
            }                                                                               # End :SetAzureFWName while ($true)
            :GetAzurePublicIP while ($true) {                                               # Inner loop for selecting the public IP
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    Break NewAzureFirewall                                                  # Breaks :NewAzureFirewall
                }                                                                           # End if (!$PublicIPObject)
                if ($PublicIPObject.Sku.name -ne 'standard') {                              # If $PublicIPObject.Sku.name does not equal 'standard'
                    Write-Host 'This public IP sku cannot be used'                          # Write message to screen
                    Write-Host 'Please select a "standard" IP sku'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    $PublicIPObject = $null                                                 # Write message to screen
                }                                                                           # End if ($PublicIPObject.Sku.name -ne 'standard') 
                if ($PublicIPObject.IpConfiguration) {                                      # If $PublicIPObject.IpConfiguration has a value
                    $PubIPConID = $PublicIPObject.IpConfiguration.ID                        # Isolates the public IP configuration ID
                    $PubIPConName = $PubIPConID.Split('/')[-1]                              # Isolates the public IP configuration name
                    Write-Host 'This public IP is currently'                                # Write message to screen
                    Write-Host 'in use by:'$PubIPConName                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    $PublicIPObject = $null                                                 # Write message to screen
                }                                                                           # End if ($PublicIPObject.IpConfiguration)
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    :SelectPubIPError while ($true) {                                       # Inner loop to select a different public IP
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Select another Public IP'                               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No'                              # Operator selection to get a different public IP
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break SelectPubIPError                                          # Breaks :SelectPubIPError
                        }                                                                   # Endif ($OpSelect -eq 'y')
                        elseif ($OpSelect -eq 'n') {                                        # Else if $OpSelect equals 'n'
                            Break NewAzureFirewall                                          # Breaks :NewAzureFirewall
                        }                                                                   # End elseif ($OpSelect -eq 'n')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End :SelectPubIPError while ($true)
                }                                                                           # End if (!$PublicIPObject)
                else {                                                                      # Else if $PublicIPObject has a value
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($PublicIPObject.Sku.name -ne 'standard')
            }                                                                               # End :GetAzurePublicIP while ($true)
            :ConfirmBuild while ($true) {                                                   # Inner loop to confirm the firewall config
                Write-Host 'Build a firewall using the following config'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Firewall name:  '$FWNameObject                                  # Write message to screen
                Write-Host 'Virtual Network:'$VNetObject.name                               # Write message to screen
                Write-Host 'Resource Group: '$RGName                                        # Write message to screen
                Write-Host 'Location:       '$LocName                                       # Write message to screen  
                Write-Host 'Public IP Sku:  '$PublicIPObject.name                           # Write message to screen                            
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to build the firewall
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break ConfirmBuild                                                      # Breaks :ConfirmBuild                  
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfim -eq 'n') {                                                # Else if $OpConfim equals 'n'
                    Break NewAzureFirewall                                                  # Breaks :NewAzureFirewall
                }                                                                           # End elseif ($OpConfim -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfim -eq 'y'))
            }                                                                               # End :ConfirmBuild while ($true)
            if ($AFWSPresent -eq 'n') {                                                     # If $AFWSPresent equals 'n'
                :CreateAzureSubnet while ($true) {                                          # Inner loop for confirming creation of required subnet
                    Write-Host 'In order to add a firewall to this '                        # Write message to screen
                    Write-Host 'virtual network, a subnet named '                           # Write message to screen
                    Write-Host '"AzureFirewallSubnet" must be created'                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Create the required subnet'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfim = Read-Host '[Y] Yes [N] No'                                  # Operator confirmation to make the subnet
                    Clear-Host                                                              # Clears screen
                    if ($OpConfim -eq 'y') {                                                # If $OpConfim equals 'y'
                        :SetAzureSubnetAddress while ($true) {                              # Inner loop for setting the subnet prefix
                            if ($SubnetList) {                                              # If $SubnetList has a value
                                Write-Host 'The following prefixes are already in use'      # Write message to screen
                                foreach ($_ in $SubnetList) {                               # For each item in $SubnetList
                                    Write-Host $_.AddressPrefix                             # Write message to screen
                                }                                                           # End foreach ($_ in $SubnetList)
                                Write-Host ''                                               # Write message to screen
                            }                                                               # End if ($SubnetList)
                            Write-Host 'Enter the address prefix (E.X. 10.0.1.0/24)'        # Write message to screen
                            $AddressPrefix = Read-Host 'Prefix'                             # Operator input for the subnet prefix
                            Clear-Host                                                      # Clears screen
                            if ($AddressPrefix -notlike '*.*.*.0/*') {                      # If $AddressPrefix is not like '*.*.*.0/*'
                                Write-Host $AddressPrefix' is not a valid address prefix'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                                $AddressPrefix = $null                                      # Clears $var
                            }                                                               # End if ($AddressPrefix -notlike '*.*.*.0/*')
                            else {                                                          # Else if $AddressPrefix is like '*.*.*.0/*'
                                Write-Host `
                                    'Use:'$AddressPrefix' as the subnet address prefix'     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the name
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpConfirm equals 'y'
                                    Break SetAzureSubnetAddress                             # Breaks :SetAzureSubnetAddress
                                }                                                           # End if ($OpConfirm -eq 'y')
                                if ($OpConfirm -eq 'e') {                                   # If $OpConfirm is 'e'
                                    Break NewAzureFirewall                                  # Breaks :NewAzureFirewall
                                }                                                           # End if ($OpConfirm -eq 'e')
                            }                                                               # End else (if ($AddressPrefix -notlike '*.*.*.0/*'))
                        }                                                                   # End :SetAzureSubnetAddress while ($true)
                        Try {                                                               # Try the following
                            Write-Host 'Building AzureFireWallSubnet'                       # Write message to screen
                            Add-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject `
                                -Name 'AzureFirewallSubnet' -AddressPrefix $AddressPrefix `
                                -ErrorAction 'Stop' | Out-Null                              # Creates the subnet
                            $VNetObject | Set-AzVirtualNetwork -ErrorAction 'Stop' | `
                                Out-Null                                                    # Saves the VNet config
                            $VNetObject = Get-AzVirtualNetwork -Name $VNetObject.name       # Repulls the updated $VNetObject
                            Clear-Host                                                      # Clears screen
                            Write-Host 'The required subnet has been created'               # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                            Break CreateAzureSubnet                                         # Breaks :CreateAzureSubnet
                        }                                                                   # End Try
                        Catch {                                                             # If Try fails
                            Clear-Host                                                      # Clears screen
                            $MSG = $Error[0]                                                # Gets the error message
                            $MSG = $MSG.Exception.InnerException.Body.Message               # Isolates the error message
                            Write-Host 'An error has occured'                               # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Warning $MSG                                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'No changes have been made'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End catch
                    }                                                                       # End if ($OpConfim -eq 'y')
                    elseif ($OpConfim -eq 'n') {                                            # Else if $OpConfim equals 'n'
                        Break NewAzureFirewall                                              # Breaks :NewAzureFirewall
                    }                                                                       # End elseif ($OpConfim -eq 'n')
                    else {                                                                  # All other inputs for $OpConfirm
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfim -eq 'y'))
                }                                                                           # End :CreateAzureSubnet while ($true)
            }                                                                               # End if ($AFWSPresent -eq 'n')
            Try {                                                                           # Try the following
                Write-Host 'Building the new firwall'                                       # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                New-AzFirewall -Name $FWNameObject -VirtualNetwork $VNetObject `
                    -ResourceGroupName $RGName -Location $LocName -PublicIpAddress `
                    $PublicIPObject -ErrorAction 'Stop' | Out-Null                          # Creates the firewall
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                $MSG = $Error[0]                                                            # Gets the error message
                $MSG = $MSG.Exception.InnerException.Body.Message                           # Isolates the error message
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Warning $MSG                                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureFirewall                                                      # Breaks :NewAzureFirewall
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The firewall has been built'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureFirewall                                                          # Breaks :NewAzureFirewall
        }                                                                                   # End :NewAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzFirewall
function ListAzFirewall {                                                                   # Function to list all firewalls
    Begin {                                                                                 # Begin function
        :ListAzureFirewall while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Gathering firewall info'                                            # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzFirewall                                                    # Gets a list of all firewalls
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewalls present in this subscription'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFirewall                                                     # Breaks :ListAzureFirewall
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $VNetName = $_.IPConfigurations.Subnet.ID.Split('/')[8]                     # Isolates the Vnet name
                $PubIPName = $_.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]          # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # firewall name
                    'RG'=$_.ResourceGroupName;                                              # firewall resource group name
                    'Location'=$_.Location;                                                 # firewall location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Firewall Name:'$_.Name                                          # Write message to screen
                Write-Host 'Vnet Name:    '$_.VNet                                          # Write message to screen
                Write-Host 'Firewall RG:  '$_.RG                                            # Write message to screen
                Write-Host 'Firewall Loc: '$_.Location                                      # Write message to screen
                Write-Host 'Pub IP Name:  '$_.PubIP                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureFirewall                                                         # Breaks :ListAzureFirewall
        }                                                                                   # End :ListAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzFirewall
function GetAzFirewall {                                                                    # Function to get a firewall
    Begin {                                                                                 # Begin function
        :GetAzureFirewall while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering firewall info'                                            # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzFirewall                                                    # Gets a list of all firewalls
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewalls present in this subscription'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFirewall                                                      # Breaks :GetAzureFirewall
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $VNetName = $_.IPConfigurations.Subnet.ID.Split('/')[8]                     # Isolates the Vnet name
                $PubIPName = $_.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]          # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # firewall name
                    'RG'=$_.ResourceGroupName;                                              # firewall resource group name
                    'Location'=$_.Location;                                                 # firewall location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFirewall while ($true) {                                            # Inner loop for selecting the firewall
                Write-Host '[0]           Exit'                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]         "$_.Name                              # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Vnet Name:   '$_.VNet                                       # Write message to screen
                    Write-Host 'Firewall RG: '$_.RG                                         # Write message to screen
                    Write-Host 'Firewall Loc:'$_.Location                                   # Write message to screen
                    Write-Host 'Pub IP Name: '$_.PubIP                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the firewall for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFirewall                                                  # Breaks :GetAzureFirewall
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FirewallObject = Get-AzFirewall -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full firewall object
                    Return $FirewallObject                                                  # Returns to calling function with firewall object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFirewall while ($true)
        }                                                                                   # End :GetAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzFirewall
function RemoveAzFirewall {                                                                 # Function to remove a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFirewall'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFirewall while ($true) {                                                # Outer loop for managing function
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject does not have a value
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall
            }                                                                               # End if (!$FirewallObject)
            $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]            # Isolates the Vnet name
            Write-Host 'Remove Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host 'From VNet:      '$VNetName                                          # Write message to screen
            Write-Host 'From RG:        '$FirewallObject.ResourceGroupName                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall'                                          # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewall -Name $FirewallObject.Name -ResourceGroupName `
                        $FirewallObject.ResourceGroupName -Force -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the firewall
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureFirewall                                               # Breaks :RemoveAzureFirewall    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall has been removed'                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFirewall                                                   # Breaks :RemoveAzureFirewall    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFirewall while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFirewall