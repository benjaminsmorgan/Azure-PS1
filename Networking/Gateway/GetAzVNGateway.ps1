# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVNGateway:             Function to get a virtual network gateway
} #>
<# Variables: {      
    :GetAzureGateway            Outer loop for managing function
    :SelectAzureGateway         Inner loop to select the gateway
    $ObjectList:                List of all resources that are gateways
    $ObjectNumber:              $var used for listing and selecting the gateway
    $ObjectArray:               Array holding all gateway info
    $CGateway:                  Current gateway
    $VNetName:                  Gateway virtual network
    $PubIPName:                 Gateway public IP
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the gateway
    $GatewayObject:             Gateway object
} #>
<# Process Flow {
    function
        Call GetAzVNGateway > Get $GatewayObject            
        End GetAzVNGateway
            Return function > Send $GatewayObject
}#>
function GetAzVNGateway {                                                                   # Function to get a virtual network gateway
    Begin {                                                                                 # Begin function
        :GetAzureGateway while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering gateway info'                                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/virtualNetworkGateways'}            # Gets a list of all gateways
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No gateways present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'If the gateway was just created, please retry in 15 minutes'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureGateway                                                       # Breaks :GetAzureGateway
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $CGateway = Get-AzVirtualNetworkGateway -Name $_.Name -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Gets current object gateway info
                $VNetName = $CGateway.IPConfigurations.Subnet.ID.Split('/')[8]              # Isolates the Vnet name
                $PubIPName = $CGateway.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]   # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$CGateway.Name;                                                  # Gateway name
                    'RG'=$CGateway.ResourceGroupName;                                       # Gateway resource group name
                    'Location'=$CGateway.Location;                                          # Gateway location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                    'GType'=$CGateway.GatewayType;                                          # Gateway type
                    'VPNType'=$CGateway.VPNType;                                            # Gateway VPN type
                    'EnableBgp'=$CGateway.EnableBgp;                                        # Gateway EnableBgp
                    'GDefaultSite'=$CGateway.GatewayDefaultSite;                            # Gateway default site
                    'SkuCap'=$CGateway.Sku.Capacity;                                        # Gateway sku capacity
                    'SkuName'=$CGateway.Sku.Name;                                           # Gateway sku name
                    'SkuTier'=$CGateway.Sku.Tier                                            # Gateway tier
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $CGateway = $null                                                           # Clears $var
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureGateway while ($true) {                                             # Inner loop for selecting the gateway
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Vnet Name:      '$_.VNet                                    # Write message to screen
                    Write-Host 'Gateway RG:     '$_.RG                                      # Write message to screen
                    Write-Host 'Gateway Loc:    '$_.Location                                # Write message to screen
                    Write-Host 'Pub IP Name:    '$_.PubIP                                   # Write message to screen
                    Write-Host 'Gateway Type:   '$_.Gtype                                   # Write message to screen
                    Write-Host 'GW VPN Type:    '$_.VPNtype                                 # Write message to screen
                    Write-Host 'Gateway Sku:    '$_.SkuName                                 # Write message to screen
                    if ($_.GDefaultSite) {                                                  # If $_.GDefaultSite has a value
                        Write-Host 'GW Default Site:'$_.GDefaultSite                        # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    else  {                                                                 # Else if $_.GDefaultSite is $null
                        Write-Host 'GW Default Site: N/A'                                   # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    Write-Host 'EnableBgp:      '$_.EnableBgp                               # Write message to screen                    
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the gateway for:'$CallingFunction         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the gateway
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureGateway                                                   # Breaks :GetAzureGateway
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $GatewayObject = Get-AzVirtualNetworkGateway -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full gateway object
                    Return $GatewayObject                                                   # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureGateway while ($true)
        }                                                                                   # End :GetAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzVNGateway