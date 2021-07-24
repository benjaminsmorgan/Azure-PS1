# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
} #>
<# Functions Description: {
    ListAzNSGRule:              Function to List a network security group rules
    GetAzNSG:                   Function to get a network security group
} #>
<# Variables: {      
    :ListAzureNSGRule           Outer loop for managing function
    $ObjectArray:               Array holding all network security group rules info
    $NSGObject:                 Network security group
    $ObjectList:                List of all rules on $NSGObject
    $SAppSecGID:                Current item source app sec group name
    $DAppSecGID:                Current item destination app sec group name
    $ObjectInput:               $var used to load info into $ObjectArray
    GetAzNSG{}                  Gets $NSGObject
} #>
<# Process Flow {
    function
        Call ListAzNSGRule > Get $null
            Call GetAzNSG > Get $NSGObject
            End GetAzNSG
                Return ListAzNSGRule > Send $NSGObject
        End ListAzNSGRule
            Return function > Send $null
}#>
function ListAzNSGRule {                                                                    # Function to list a network security group rules
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'ListAzNSGRule'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ListAzureNSGRule while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering network security group information'                       # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$NSGObject)
            $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject  # Gets a list of all non-default rules on $NSGObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.SourceApplicationSecurityGroups.ID) {                                # If ($_.SourceApplicationSecurityGroups.ID has a value
                    $SAppSecGID = $_.SourceApplicationSecurityGroups.ID                     # $SAppSecGID is equal to $_.SourceApplicationSecurityGroups.ID
                    $SAppSecGID = $SAppSecGID.Split('/')[-1]                                # Isolates the name of the application security group
                }                                                                           # End if ($_.SourceApplicationSecurityGroups.ID)
                if ($_.DestinationApplicationSecurityGroups.ID) {                           # If ($_.DestinationApplicationSecurityGroups.ID has a value
                    $DAppSecGID = $_.DestinationApplicationSecurityGroups.ID                # DSAppSecGID is equal to $_.DestinationApplicationSecurityGroups.ID
                    $DAppSecGID = $DAppSecGID.Split('/')[-1]                                # Isolates the name of the application security group
                }                                                                           # End if ($_.DestinationApplicationSecurityGroups.ID)
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule config name
                    'Descript'=$_.Description;                                              # Rule config description
                    'Proto'=$_.Protocol;                                                    # Rule config protocol
                    'SPRange'=$_.SourcePortRange;                                           # Rule config source port range
                    'DPRange'=$_.DestinationPortRange;                                      # Rule config destination port range
                    'SAPrefix'=$_.SourceAddressPrefix;                                      # Rule config source address prefix
                    'DAPrefix'=$_.DestinationAddressPrefix;                                 # Rule config destination address prefix
                    'SASG'=$SAppSecGID;                                                     # Rule config source application security groups
                    'DASG'=$DAppSecGID;                                                     # Rule config destination application security groups
                    'Access'=$_.Access;                                                     # Rule config access
                    'PRI'=$_.Priority;                                                      # Rule config priority
                    'Direction'=$_.Direction                                                # Rule config direction
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Addes $ObjectInput to $ObjectArray
                $SAppSecGID = $null                                                         # Clears $var
                $DAppSecGID = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $NSGList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-host 'No non-default rules exist on this network security group'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGRule                                                      # Breaks :ListAzureNSGRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:      '$_.Name                                        # Write message to screen
                Write-Host 'Protocol:       '$_.Proto                                       # Write message to screen
                Write-Host 'Source'                                                         # Write message to screen
                Write-Host ' Port Range:    '$_.SPRange                                     # Write message to screen
                if ($_.SAPrefix) {                                                          # If $_.SAPrefix has a value
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                }                                                                           # End if ($_.SAPrefix)
                if ($_.SASG) {                                                              # If $_.SASG has a value
                    Write-Host ' Security Group:'$_.SASG                                    # Write message to screen
                }                                                                           # End if ($_.SASG)
                Write-Host 'Destination'                                                    # Write message to screen
                Write-Host ' Port Range:    '$_.DPRange                                     # Write message to screen
                if ($_.DAPrefix) {                                                          # If $_.DAPrefix has a value
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                }                                                                           # End if ($_.DAPrefix)
                if ($_.DASG) {                                                              # If $_.DASG has a value
                    Write-Host ' Security Group:'$_.DASG                                    # Write message to screen
                }                                                                           # End if ($_.DASG)
                Write-Host 'Access:         '$_.Access                                      # Write message to screen
                Write-Host 'Priority:       '$_.PRI                                         # Write message to screen
                Write-Host 'Direction:      '$_.Direction                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSGRule                                                          # Breaks :ListAzureNSGRule
        }                                                                                   # End :ListAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNSGRule