# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ManageAzLBNSG:              Function to get a network security group
} #>
<# Variables: {      
    :ListAzureNSG               Outer loop for managing function
    $ObjectList:                List of all network security groups
    $ObjectArray:               Array holding all network security group info
    $ObjectInput:               $var used to load info into $ObjectArray
    $NSGObject:                 Network security group object
} #>
<# Process Flow {
    function
        Call ListAzNSG > Get $null
        End ListAzNSG
            Return function > Send $null
}#>
function ListAzNSG {                                                                        # Function to list all network security groups
    Begin {                                                                                 # Begin function
        :ListAzureNSG while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSG                                                          # Breaks :ListAzureNSG
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:          '$_.Name                                    # Write message to screen
                Write-Host 'Rule RG:            '$_.RG                                      # Write message to screen
                Write-Host 'Rule Loc:           '$_.Location                                # Write message to screen
                Write-Host 'Sec Rules Count:    '$_.SrulesCount                             # Write message to screen
                Write-Host 'Default Rules Count:'$_.DRulesCount                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSG                                                              # Breaks :ListAzureNSG
        }                                                                                   # End :ListAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzNSG