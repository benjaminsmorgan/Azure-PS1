# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzFirewall:              Function to get a firewall
} #>
<# Variables: {      
    :GetAzureFirewall           Outer loop for managing function
    :SelectAzureFirewall        Inner loop for selecting the firewall
    $ObjectList:                List of all firewalls
    $ObjectNumber:              $var used to list and select the firewall
    $ObjectArray:               Array holding all firewall info
    $VNetName:                  Vnet name
    $PubIPName:                 Public IP name
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number, used for formatting
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the firewall
    $FirewallObject:            Firewall object
} #>
<# Process Flow {
    function
        Call GetAzFirewall > Get $FirewallObject            
        End GetAzFirewall
            Return function > Send $FirewallObject
}#>
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