# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzASGNIC:                Function to get a nic with an ASG attached
} #>
<# Variables: {      
    :GetAzureASGNIC             Outer loop for managing function
    :SelectAzureASGNIC          Inner loop for selecting the nic object
    $ObjectList:                List containing all nic objects that have ASGs
    $ObjectNumber:              $var used for listing a selecting NIC
    $ObjectArray:               Array holding all the NIC info
    $ASGNames:                  Array holding all ASG names names on current nic
    $ASGIDList:                 Current item .IPConfigurations.ApplicationSecurityGroups.ID   
    $ASGName:                   Current item ASG name
    $ObjectInput:               $var used to load info into array
    $Number:                    Current item .number
    $ASGList:                   Current item .ASGNames
    $OpSelect:                  Operator input to select the NIC
    $NicObject                  NIC object
} #>
<# Process Flow {
    function
        Call GetAzASGNIC > Get $NicObject              
        End GetAzASGNIC
            Return function > Send $NicObject
}#>
function GetAzASGNIC {                                                                      # Function to get a nic with an ASG attached
    Begin {                                                                                 # Begin function
        :GetAzureASGNIC while ($true) {                                                     # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID}                          # Gets a list of all network interfaces with an application security group
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network interfaces present with'                             # Write message to screen
                Write-Host 'application security groups attached'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASGNIC                                                        # Breaks :GetAzureASGNIC
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGNames = @()                                                             # Creates $ASGNamesArray
                $ASGIDList = $_.IPConfigurations.ApplicationSecurityGroups.ID               # Isolates the application security group names
                foreach ($ID in $ASGIDList) {                                               # For each item in $ASGIDList
                    $ASGName = $ID                                                          # ASGName is equal to current item
                    $ASGName = $ASGName.Split('/')[-1]                                      # Isolates the ASG name
                    $ASGNames += $ASGName                                                   # Adds $ASGName to $ASGNames
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $ASGIDList)
                $ASGNames = $ASGNames | Select-Object -Unique | Sort-Object                 # Removes duplcate items from $ASGNames
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'NicName'=$_.Name;                                                      # Nic name
                    'NICRG'=$_.ResourceGroupName;                                           # Nic RG
                    'IPConCount'=$_.IPConfigurations.Count;                                 # IP configurations count
                    'ASGNames'=$ASGNames                                                    # ASG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGNames = $null                                                           # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureASGNIC while ($true) {                                              # Inner loop for selecting the nic object
                Write-Host '[0]       Exit'                                                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.NicName                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]     "$_.NicName                               # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    $ASGList = $_.ASGNames                                                  # ASGList is equal to current item .ASGNames
                    foreach ($Name in $ASGList) {                                           # For each item in $ASGList
                        Write-Host 'ASG Name:'$Name                                         # Write message to screen
                    }                                                                       # End foreach ($Name in $ASGList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NIC for:'$CallingFunction             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                        -ResourceGroupName $OpSelect.NicRG                                  # Pulls the full nic object
                    Return $NicObject                                                       # Returns to calling function with $NicObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASGNIC while ($true)
        }                                                                                   # End :GetAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzASGNIC