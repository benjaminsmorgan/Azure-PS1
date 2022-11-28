# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzNSG:                   Function to get a network security group
} #>
<# Variables: {      
    :GetAzureNSG                Outer loop for managing function
    :SelectAzureNSG             Inner loop for selecting the network security group
    $ObjectList:                List of all network security groups
    $ObjectNumber:              $var used to list and select the network security group
    $ObjectArray:               Array holding all network security group info
    $SASGArray:                 Array holding source application security group names
    $ASGList:                   Current item .SecurityRules.SourceApplicationSecurityGroups.ID 
    $SASGName:                  Current ASG name
    $DASGArray:                 Array holding destination application security group names
    $DASGName:                  Current ASG name
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number, used for formatting
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the network security group
    $NSGObject:                 Network security group object
} #>
<# Process Flow {
    function
        Call GetAzNSG > Get $NSGObject
        End GetAzNSG
            Return function > Send $NSGObject
}#>
function GetAzNSG {                                                                         # Function to get a network security group
    Begin {                                                                                 # Begin function
        :GetAzureNSG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSG                                                           # Breaks :GetAzureNSG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $SASGArray = @()                                                            # Creates $SASGArray
                if ($_.SecurityRules.SourceApplicationSecurityGroups.ID) {                  # If current item .SecurityRules.SourceApplicationSecurityGroups.ID has a value
                    $ASGList = $_.SecurityRules.SourceApplicationSecurityGroups.ID          # ASGList is equal to current item .SecurityRules.SourceApplicationSecurityGroups.ID 
                    foreach ($SID in $ASGList) {                                            # For each item in $ASGList
                        $SASGName = $SID                                                    # Isolates the ASG ID
                        $SASGName = $SASGName.Split('/')[-1]                                # Isolates the ASG name
                        $SASGArray += $SASGName                                             # Adds $SASGName to $SASGArray
                        $SASGName = $null                                                   # Clears $var
                    }                                                                       # End foreach ($SID in $ASGList)
                }                                                                           # End if ($_.SecurityRules.SourceApplicationSecurityGroups.ID)
                $DASGArray = @()                                                            # Creates $DASGArray
                if ($_.SecurityRules.DestinationApplicationSecurityGroups.ID) {             # If current item .SecurityRules.DestinationApplicationSecurityGroups.ID has a value
                    $ASGList = $_.SecurityRules.DestinationApplicationSecurityGroups.ID     # ASGList is equal to current item .SecurityRules.DestinationApplicationSecurityGroups.ID
                    foreach ($DID in $ASGList) {                                            # For each item in $ASGList
                        $DASGName = $DID                                                    # Isolates the ASG ID
                        $DASGName = $DASGName.Split('/')[-1]                                # Isolates the ASG name
                        $DASGArray += $DASGName                                             # Adds $DASGName to $DASGArray
                        $DASGName = $null                                                   # Clears $var
                    }                                                                       # End foreach ($DID in $ASGList)
                }                                                                           # End if ($_.SecurityRules.DestinationApplicationSecurityGroups.ID)
                $SASGArray = $SASGArray | Select-Object -Unique                             # Filters out duplicate entries
                $DASGArray = $DASGArray | Select-Object -Unique                             # Filters out duplicate entries
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'SASGNames'=$SASGArray;                                                 # Source app sec groups
                    'DASGNames'=$DASGArray                                                  # Destination app sec groups
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $SASGArray = $null                                                          # Clears $var
                $DASGArray = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNSG while ($true) {                                                 # Inner loop for selecting the network security group
                Write-Host '[0]                  Exit'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                 "$_.Name                      # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:            '$_.RG                                  # Write message to screen
                    Write-Host 'Rule Loc:           '$_.Location                            # Write message to screen
                    Write-Host 'Sec Rules Count:    '$_.SrulesCount                         # Write message to screen
                    if ($_.SASGNames) {                                                     # If current item .SASGnames has a value
                        Write-Host 'Source ASGs:        '$_.SASGNames                       # Write message to screen
                    }                                                                       # End if ($_.SASGNames)
                    else {                                                                  # else if current item .SASGNames is $null
                        Write-Host 'Source ASGs:         N/A'                               # Write message to screen
                    }                                                                       # End else (if ($_.SASGNames))
                    if ($_.DASGNames) {                                                     # If current item .DASGnames has a value
                        Write-Host 'Destination ASGs:   '$_.DASGNames                       # Write message to screen
                    }                                                                       # End if ($_.DASGNames)
                    else {                                                                  # else if current item .DASGNames is $null
                        Write-Host 'Destination ASGs:    N/A'                               # Write message to screen
                    }                                                                       # End else (if ($_.DASGNames))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the network security group for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the network security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNSG                                                       # Breaks :GetAzureNSG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full network security group object
                    Return $NSGObject                                                       # Returns to calling function with network security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureNSG while ($true)
        }                                                                                   # End :GetAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzNSG