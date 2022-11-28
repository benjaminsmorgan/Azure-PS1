# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Add-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    New-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    GetAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    GetAzVirtualNetwork:        Function to get an existing azure virtual network
    GetAzPublicIPAddress:       Function to get an existing public IP address
} #>
<# Variables: {      
    :NewAzureFirewall           Outer loop for managing function
    :SetAzureFWName             Inner loop for setting the firewall name
    :GetAzurePublicIP           Inner loop for getting the public IP
    :SelectPubIPError           Inner loop for selecting a different public IP
    :ConfirmBuild               Inner loop for confirming the firewall build settings
    :CreateAzureSubnet          Inner loop for creating a required subnet
    :SetAzureSubnetAddress      Inner loop for setting subnet address prefix
    $CallingFunction:           Name of this function or the one that called it
    $VNetObject:                Virtual network object
    $RGName:                    $VNetObject.ResourceGroupName    
    $LocName:                   $VNetObject.Location            
    $SubnetList:                List of all subnets in $VNetObject
    $AFWSPresent:               Flag if required subnet is present
    $ValidArray:                Array of valid name body characters
    $Valid1stChar:              Array of valid name first position characters
    $ValidLastChar:             Array of valid name last position characters
    $FWNameObject:              Operator input of the firewall name
    $FWNameArray:               $FWNameObject converted to array
    $OpConfirm:                 Operator confirmation of entered values
    $PublicIPObject:            Public IP object
    $OpSelect:                  Operator selection to select a different IP object
    $AddressPrefix:             Operator input for subnet address prefix
    $MSG:                       Last error message text
    GetAzVirtualNetwork{}       Gets $VNetObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call NewAzFirewall > Get $null
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return NewAzFirewall > Send $VNetObject
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return NewAzFirewall > Send $PublicIPObject                
        End NewAzFirewall
            Return function Send > $null
}#>
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