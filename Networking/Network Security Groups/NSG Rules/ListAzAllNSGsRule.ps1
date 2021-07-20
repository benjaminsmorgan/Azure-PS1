# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzAllNSGsRule:          Function to list all rules from all network security groups
} #>
<# Variables: {      
    :GetAzureNSGRule            Outer loop for managing function
    $NSGList:                   List of all network security groups
    $ObjectArray:               Array holding all network security group rules info
    $NSGObject:                 Network security group
    $NSGName:                   Network security group name
    $NSGRG:                     Network security group resource group name
    $ObjectList:                List of all rules on $NSGObject
    $ObjectInput:               $var used to load info into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzAllNSGsRule > Get $null
        End ListAzAllNSGsRule
            Return function > Send $null
}#>
function ListAzAllNSGsRule {                                                                # Function to list all rules from all network security groupss
    Begin {                                                                                 # Begin function
        :GetAzureNSGRule while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            $NSGList = Get-AzNetworkSecurityGroup                                           # Gets a list of all network security groups
            if (!$NSGList) {                                                                # If $NSGList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network security groups exist in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$NSGList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Name'=$_.Name;                                                     # Rule config name
                        'NSGName'=$NSGName;                                                 # Network security group name
                        'NSGRG'=$NSGRG;                                                     # Network security group resource group
                        'Descript'=$_.Description;                                          # Rule config description
                        'Proto'=$_.Protocol;                                                # Rule config protocol
                        'SPRange'=$_.SourcePortRange;                                       # Rule config source port range
                        'DPRange'=$_.DestinationPortRange;                                  # Rule config destination port range
                        'SAPrefix'=$_.SourceAddressPrefix;                                  # Rule config source address prefix
                        'DAPrefix'=$_.DestinationAddressPrefix;                             # Rule config destination address prefix
                        'SASG'=$_.SourceApplicationSecurityGroups;                          # Rule config source application security groups
                        'DASG'=$_.DestinationApplicationSecurityGroups;                     # Rule config destination application security groups
                        'Access'=$_.Access;                                                 # Rule config access
                        'PRI'=$_.Priority;                                                  # Rule config priority
                        'Direction'=$_.Direction                                            # Rule config direction
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Addes $ObjectInput to $ObjectArray
                }                                                                           # End foreach ($_ in $ObjectList)
                $NSGObject = $null                                                          # Clears $var
                $NSGName = $null                                                            # Clears $var
                $NSGRG = $null                                                              # Clears $var
                $ObjectList = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on any network security groups'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSGRule                                                       # Breaks :GetAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'NSG Name:       '$_.NSGName                                     # Write message to screen
                Write-Host 'Rule RG:        '$_.NSGRG                                       # Write message to screen
                if ($_.Descript) {                                                          # If current item .Descript has a value
                    Write-Host 'Description:    '$_.Descript                                # Write message to screen
                }                                                                           # End if ($_.Descript)
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.SAPrefix                                    # Write message to screen
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                Write-Host ' Address Prefix:'$_.DAPrefix                                    # Write message to screen
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureNSGRule                                                           # Breaks :GetAzureNSGRule
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzAllNSGsRule