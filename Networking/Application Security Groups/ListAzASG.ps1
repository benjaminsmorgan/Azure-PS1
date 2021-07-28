# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzASG:                  Function to list all application security groups
} #>
<# Variables: {      
    :ListAzureASG               Outer loop for managing function
    $ObjectList:                List of all application security groups
    $ObjectArray:               Array holding all application security group info
    $ASGID:                     Current item .ID
    $NICList:                   List of nics using $ASGID
    $ObjectInput:               $var used to load info into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzASG > Get $null
        End ListAzASG
            Return function > Send $null
}#>
function ListAzASG {                                                                        # Function to list all application security groups
    Begin {                                                                                 # Begin function
        :ListAzureASG while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureASG                                                          # Breaks :ListAzureASG
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NicNames'=$NICList.Name                                                # Nic names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'ASG Name:       '$_.Name                                        # Write message to screen
                Write-Host 'ASG RG:         '$_.RG                                          # Write message to screen
                Write-Host 'ASG Loc:        '$_.Location                                    # Write message to screen
                if ($_.NicNames) {                                                          # If current item .NicNames has a value
                    Write-Host 'Associated NICS:'$_.NicNames                                # Write message to screen
                }                                                                           # End if ($_.NicNames)
                else {                                                                      # Else if current item .NicNames is $null
                    Write-Host 'Associated NICS: N/A'                                       # Write message to screen
                }                                                                           # End else (if ($_.NicNames))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureASG                                                              # Breaks :ListAzureASG
        }                                                                                   # End :ListAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzASG