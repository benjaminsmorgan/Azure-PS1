# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzFirewall:             Function to list all firewalls
} #>
<# Variables: {      
    :ListAzureFirewall          Outer loop for managing function
    $ObjectList:                List of all firewalls
    $ObjectArray:               Array holding all firewall info
    $VNetName:                  Vnet name
    $PubIPName:                 Public IP name
    $ObjectInput:               $var used to load info into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzFirewall > Get $null            
        End ListAzFirewall
            Return function > Send $null
}#>
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