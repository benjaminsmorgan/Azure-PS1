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
    $SASGArray:                 Array holding source application security group names
    $ASGList:                   Current item .SecurityRules.SourceApplicationSecurityGroups.ID 
    $SASGName:                  Current ASG name
    $DASGArray:                 Array holding destination application security group names
    $DASGName:                  Current ASG name
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
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'SASGNames'=$SASGArray;                                                 # Source app sec groups
                    'DASGNames'=$DASGArray                                                  # Destination app sec groups
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $SASGArray = $null                                                          # Clears $var
                $DASGArray = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Rule Name:          '$_.Name                                    # Write message to screen
                Write-Host 'Rule RG:            '$_.RG                                      # Write message to screen
                Write-Host 'Rule Loc:           '$_.Location                                # Write message to screen
                Write-Host 'Sec Rules Count:    '$_.SrulesCount                             # Write message to screen
                if ($_.SASGNames) {                                                         # If current item .SASGnames has a value
                    Write-Host 'Source ASGs:        '$_.SASGNames                           # Write message to screen
                }                                                                           # End if ($_.SASGNames)
                else {                                                                      # else if current item .SASGNames is $null
                    Write-Host 'Source ASGs:         N/A'                                   # Write message to screen
                }                                                                           # End else (if ($_.SASGNames))
                if ($_.DASGNames) {                                                         # If current item .DASGnames has a value
                    Write-Host 'Destination ASGs:   '$_.DASGNames                           # Write message to screen
                }                                                                           # End if ($_.DASGNames)
                else {                                                                      # else if current item .DASGNames is $null
                    Write-Host 'Destination ASGs:    N/A'                                   # Write message to screen
                }                                                                           # End else (if ($_.DASGNames))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSG                                                              # Breaks :ListAzureNSG
        }                                                                                   # End :ListAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzNSG