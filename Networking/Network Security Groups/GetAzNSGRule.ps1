# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecurityruleconfig?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzNSGRule:               Function to get a network security group rule
} #>
<# Variables: {      
    :GetAzureNSGRule            Outer loop for managing function
    :SelectAzNSGRule            Inner loop for selecting the network security group rule
    $NSGList:                   List of all network security groups
    $ObjectNumber:              $var used to list and select the network security group rule
    $ObjectArray:               Array holding all network security group rules info
    $NSGObject:                 Network security group
    $NSGName:                   Network security group name
    $NSGRG:                     Network security group resource group name
    $ObjectList:                List of all rules on $NSGObject
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number, used for formatting
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the network security group rule
    $NSGRuleObject:             Network security group rule object
} #>
<# Process Flow {
    function
        Call GetAzNSGRule > Get $NSGRuleObject, $NSGObject
        End GetAzNSGRule
            Return function > Send $NSGRuleObject, $NSGObject
}#>
function GetAzNSGRule {                                                                     # Function to get a network security group rule
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
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $NSGList) {                                                      # Foreach item in $NSGList
                $NSGObject = $_                                                             # $NSGObject is equal to current item
                $NSGName = $_.Name                                                          # $NSGName is equal to current item .name
                $NSGRG = $_.ResourceGroupName                                               # $NSGRG is equal to current item .ResourceGroupName
                $ObjectList = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                    $NSGObject                                                              # Gets a list of all non-default rules on $NSGObject
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
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
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
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
            :SelectAzNSGRule while ($true) {                                                # Inner loop for selecting the NSG rule
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 0
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule Name:      '$_.NSGName                                 # Write message to screen
                    Write-Host 'Rule RG:        '$_.NSGRG                                   # Write message to screen
                    if ($_.Descript) {                                                      # If current item .Descript has a value
                        Write-Host 'Description:    '$_.Descript                            # Write message to screen
                    }                                                                       # End if ($_.Descript)
                    Write-Host 'Protocol:       '$_.Proto                                   # Write message to screen
                    Write-Host 'Source'                                                     # Write message to screen
                    Write-Host ' Port Range:    '$_.SPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.SAPrefix                                # Write message to screen
                    if ($_.SASG) {                                                          # If $_.SASG has a value
                        Write-Host ' Security Group:'$_.SASG                                # Write message to screen
                    }                                                                       # End if ($_.SASG)
                    Write-Host 'Destination'                                                # Write message to screen
                    Write-Host ' Port Range:    '$_.DPRange                                 # Write message to screen
                    Write-Host ' Address Prefix:'$_.DAPrefix                                # Write message to screen
                    if ($_.DASG) {                                                          # If $_.DASG has a value
                        Write-Host ' Security Group:'$_.DASG                                # Write message to screen
                    }                                                                       # End if ($_.DASG)
                    Write-Host 'Access:         '$_.Access                                  # Write message to screen
                    Write-Host 'Priority:       '$_.PRI                                     # Write message to screen
                    Write-Host 'Direction:      '$_.Direction                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NSG rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the NSG rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureNSGRule                                                   # Breaks :GetAzureNSGRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.NSGName `
                        -ResourceGroupName $OpSelect.NSGRG
                    $NSGRuleObject = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup `
                        $NSGObject -Name $OpSelect.name
                    Return $NSGRuleObject, $NSGObject                                       # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzNSGRule while ($true)
        }                                                                                   # End :GetAzureNSGRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNSGRule