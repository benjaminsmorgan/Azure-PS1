# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzLBRuleProbe:           Function to get an existing load balancer probe config for load balancer rule
} #>
<# Variables: {      
    :GetAzureLBProbeConfig      Outer loop for managing function
    :SelectAzureLBProbeConfig   Inner loop for selecting the probe config
    $LoadBalancerObject:        Load balancer object
    $ObjectNumber:              $var used for selecting and listing items
    $ObjectArray:               Array used to hold item info
    $ObjectList:                List of all probes on $LoadBalancerObject
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the probe config
    $LBProbeObject:             Load balancer probe object
} #>
<# Process Flow {
    function
        Call GetAzLBRuleProbe > Get $LBProbeObject
        End GetAzLBRuleProbe
            Return function > Send $LBProbeObject
}#>
function GetAzLBRuleProbe {                                                                 # Function to get an existing load balancer probe config for load balancer rule
    Begin {                                                                                 # Begin function
        :GetAzureLBProbeConfig while ($true) {                                              # Outer loop to manage function
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            $ObjectList = Get-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject   # Gets a list of all probes on $LoadBalancerObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'Proto'=$_.Protocol;                                                    # Probe protocol
                    'Port'=$_.Port;                                                         # Probe port
                    'Int'=$_.IntervalInSeconds;                                             # Probe interval
                    'Count'=$_.NumberOfProbes;                                              # Probe count
                    'RPath'=$_.RequestPath;                                                 # Request path
                    'Rule'=$_.LoadBalancingRules.ID                                         # Probe rules if any
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist'                           # Write message to screen
                Write-Host 'on load balancer:'$LBObject                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks :GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureLBProbeConfig while ($true) {                                       # Inner loop to select the load balancer probe config
                Write-Host '[0]             Exit'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Probe Protocol:'$_.Proto                                    # Write message to screen
                    Write-Host 'Probe Port:    '$_.Port                                     # Write message to screen
                    Write-Host 'Probe Interval:'$_.Int                                      # Write message to screen
                    Write-Host 'Probe Count:   '$_.Count                                    # Write message to screen
                    if ($_.RPath) {                                                         # If current item .RPath has a value
                        Write-Host 'Probe RPath:   '$_.Rpath                                # Write message to screen
                    }                                                                       # End if ($_.RPath)
                    else {                                                                  # Else if current item .RPath does not have value
                        Write-Host 'Probe RPath:    N/A'                                    # Write message to screen         
                    }                                                                       # End else (if ($_.RPath))
                    Write-Host 'Rule count:    '$_.Rule.Count                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the probe config for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBProbeConfig                                             # Breaks :GetAzureLBProbeConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LBProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer probe config object
                    Clear-Host                                                              # Clears screen
                    Return $LBProbeObject                                                   # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBProbeConfig while ($true)
        }                                                                                   # End :GetAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleProbe