# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
} #>
<# Functions Description: {
    SetAzNICIpConfig:           Updates a NIC IP configuration
    GetAzNICIpConfig:           Gets a NIC IP configuration
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    :SetAzureNICIP              Inner loop for setting the private IP
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         Nic IP configuration object
    $NicObject:                 Nic object
    $SubnetID:                  $NicIPConfigObject.Subnet.ID
    $VNetName:                  Name of virtual network
    $VNetObject:                Virtual network object
    $SubnetObject:              Subnet object
    $NicList:                   List of all nics on $SubnetObject
    $VmssList:                  List of all virtual machine scale sets
    $LBList:                    List of all load balancers with front end in $SubnetID
    $IPInput:                   Operator input for the private IP
    $OpConfirm:                 Operator confirmation of the private IP
    GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
} #>
<# Process Flow {
    function
        Call SetAzNICIpConfig > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
            End GetAzNICIpConfig
                Return SetAzNICIpConfig > Send $NicIPConfigObject,$NicObject
        End SetAzNICIpConfig
            Return function > Send $null
}#>
function SetAzNICIpConfig {                                                                 # Function to change the config private IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConfig'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            Write-Host 'Gathering current subnet info'                                      # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            $VNetName = $SubnetID.Split('/')[8]                                             # Gets the virtual network name
            $VNetObject = Get-AzVirtualNetwork -Name $VNetName                              # Pulls the virtual network object
            $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject `
                | Where-Object {$_.ID -eq $SubnetID}                                        # Pulls the full subnet object
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on subnetID
            foreach ($_ in $NicList) {                                                      # For each item in $NicList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'IP'=$_.PrivateIpAddress                                                # Adds vaules to $ObjectInput
                }                                                                           # End $ObjectInput = [PSCustomObject]@{
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $NicList)
            $NicList = $null                                                                # Clears $NicList
            $VmssList = Get-AzVmss                                                          # Gets a list of all virtual machine scale sets
            if ($VmssList) {                                                                # If $VmssList has a value
                foreach ($_ in $VmssList) {                                                 # For each item in $VmssList
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $_.Name -ResourceGroupName $_.ResourceGroupName                     # Gets a list of all nics on current item .Name
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        if ($_.IpConfigurations.Subnet.ID -eq $SubnetID) {                  # If current item .IpConfigurations.Subnet.ID equals $SubnetID
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput
                                'IP'=$_.IPConfigurations.PrivateIPAddress                   # Adds vaules to $ObjectInput
                            }                                                               # End $ObjectInput = [PSCustomObject]@{
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Adds $ObjectInput to $ObjectArray
                        }                                                                   # End if ($_.IpConfigurations.Subnet.ID -eq $SubnetID)
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssList)
            }                                                                               # End if ($VmssList)
            $LBList = Get-AzLoadBalancer | Where-Object `
                {$_.FrontendIpConfigurations.Subnet.ID -eq $SubnetID}                       # Gets a list of all load balancers with a front end in the $SubnetID
            if ($LBList) {                                                                  # If $LBList has a value
                foreach ($_ in $LBList) {                                                   # For each item in $LBList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates $ObjectInput
                        'IP'=$_.FrontendIpConfigurations.PrivateIPAddress                   # Adds vaules to $ObjectInput
                    }                                                                       # End $ObjectInput = [PSCustomObject]@{
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                }                                                                           # End foreach ($_ in $LBList)
            }                                                                               # End if ($LBList)
            Clear-Host                                                                      # Clears screen
            :SetAzureNICIP while ($true) {                                                  # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    Write-Host $_.IP                                                        # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the IP address for:'$NicIPConfigObject.name               # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP addres
                Clear-Host                                                                  # Clears screen
                if ($IPInput -in $NicList.PrivateIPAddress) {                               # If $IPInput is in $NicList.PrivateIPAddress 
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -in $NicList.PrivateIPAddress)
                elseif ($IPInput -notlike '*.*.*.*') {                                      # Else if $IPInput is not like '*.*.*.*'
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End elseif ($IPInput -notlike '*.*.*.*')
                else {                                                                      # All other inputs for $IPInput
                    Write-Host 'Use:'$IPInput                                               # Write message to screen
                    Write-Host 'For:'$NicIPConfigObject.name                                # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureNICIP                                                 # Breaks :SetAzureNICIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($IPInput -in $NicList.PrivateIPAddress))
            }                                                                               # End :SetAzureNICIP while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Setting IP config'                                              # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PrivateIpAddress $IPInput -SubnetId $SubnetID -ErrorAction 'Stop'`
                    | Out-Null                                                              # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may fall into the'                              # Write message to screen
                Write-Host 'reserved range of the subnet'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may not be valid'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The NIC IP config has been updated'                                 # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig