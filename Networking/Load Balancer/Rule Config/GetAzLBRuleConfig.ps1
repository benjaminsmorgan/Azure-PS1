# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :GetAzureLBRuleConfig       Outer loop for managing function
    :SelectAzureLBProbeConfig   Inner loop for selecting the rule config
    $ObjectList:                List of all load balanacers
    $ObjectNumber:              $var used for selecting and listing items
    $ObjectArray:               Array used to hold item info
    $LBObject:                  Current load balancer
    $LBObjectType:              Current load balancer internal or external type
    $RuleConfigList:            List of all probes on $LBObject
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $FEndName:                  Current item front end name if present
    $BPoolName:                 Current item back end name if present
    $ProbeName:                 Current item probe name if present
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the probe config
    $LoadBalancerObject:        Load balancer object
    $LBRuleObject:              Load balancer rule object
} #>
<# Process Flow {
    function
        Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
        End GetAzLBRuleConfig
            Return function > Send $LBRuleObject, $LoadBalancerObject
}#>
function GetAzLBRuleConfig {                                                                # Function to get an existing load balancer rule config
    Begin {                                                                                 # Begin function
        :GetAzureLBRuleConfig while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBRuleConfig                                                  # Breaks GetAzureLBRuleConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID) {               # If $LBObject.FrontendIpConfigurations.PublicIPAddress.ID is $null
                    $LBObjectType = 'Internal'                                              # Sets $LBObjectType
                }                                                                           # End if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID)
                else {                                                                      # Else if $LBObject.FrontendIpConfigurations.PublicIPAddress.ID has a value
                    $LBObjectType = 'External'                                              # Sets $LBObjectType
                }                                                                           # End else (if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID))
                $RuleConfigList = Get-AzLoadBalancerRuleConfig -LoadBalancer $_             # Gets a list of all rules on $LBObject
                foreach ($_ in $RuleConfigList) {                                           # For each item in $RuleConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'LBSku'=$LBObject.Sku.Name;                                         # Load balancer sku
                        'LBType'=$LBObjectType;                                             # Load balancer internal or external
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Rule protocol
                        'FEPort'=$_.FrontendPort;                                           # Front end port
                        'BEPort'=$_.BackendPort;                                            # Back end port
                        'Idle'=$_.IdleTimeoutInMinutes;                                     # Idle timeout
                        'LD'=$_.LoadDistribution;                                           # Load distribution
                        'TCP'=$_.EnableTcpReset;                                            # EnableTCPReset enabled
                        'EFIP'=$_.EnableFloatingIP;                                         # Floating IP enabled
                        'FEIP'=$_.FrontendIPConfiguration.ID;                               # Front end ID
                        'BEPool'=$_.BackendAddressPool.ID;                                  # Back end pool ID
                        'Probe'=$_.Probe.ID                                                 # Probe ID
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $RuleConfigList)
                $LBObject = $null                                                           # Clears $var
                $LBObjectType = $null                                                       # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer rule configs exist in this subscription'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBRuleConfig                                                  # Breaks :GetAzureLBRuleConfig
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
                    Write-Host 'LB Name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'LB Sku:        '$_.LBSku                                    # Write message to screen
                    Write-Host 'LB Type:       '$_.LBType                                   # Write message to screen       
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'Rule Protocol: '$_.Proto                                    # Write message to screen
                    Write-Host 'Front End Port:'$_.FEPort                                   # Write message to screen
                    Write-Host 'Back End Port: '$_.BEPort                                   # Write message to screen
                    Write-Host 'TO In Minutes: '$_.Idle                                     # Write message to screen
                    Write-Host 'Load Distro:   '$_.LD                                       # Write message to screen
                    Write-Host 'TCP Reset:     '$_.TCP                                      # Write message to screen
                    Write-Host 'Floating IP:   '$_.EFIP                                     # Write message to screen
                    if ($_.FEIP) {                                                          # If current item .FEIP has a value
                        $FEndName = $_.FEIP                                                 # Isolates the current item
                        $FEndName = $FEndName.Split('/')[-1]                                # Isolates the front end name
                        Write-Host 'Front End Name:'$FEndName                               # Write message to screen
                    }                                                                       # End if ($_.FEIP)
                    else {                                                                  # Else if current item .FEIP does not have value
                        Write-Host 'Front End Name: N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.BEPool))
                    if ($_.BEPool) {                                                        # If current item .BEPool has a value
                        $BPoolName = $_.BEPool                                              # Isolates the current item
                        $BPoolName = $BPoolName.Split('/')[-1]                              # Isolates the back end name
                        Write-Host 'Back End Name: '$BPoolName                              # Write message to screen
                    }                                                                       # End if ($_.BEPool)
                    else {                                                                  # Else if current item .BEPool does not have value
                        Write-Host 'Back End Name:  N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.BEPool))
                    if ($_.Probe) {                                                         # If current item .Probe has a value
                        $ProbeName = $_.Probe                                               # Isolates the current item
                        $ProbeName = $ProbeName.Split('/')[-1]                              # Isolates the front end name
                        Write-Host 'Probe Name:    '$ProbeName                              # Write message to screen
                    }                                                                       # End if ($_.Probe)
                    else {                                                                  # Else if current item .Probe does not have value
                        Write-Host 'Probe Name:     N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.Probe))
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the rule config for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBRuleConfig                                              # Breaks :GetAzureLBRuleConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBRuleObject = Get-AzLoadBalancerRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer rule config object
                    Clear-Host                                                              # Clears screen
                    Return $LBRuleObject, $LoadBalancerObject                               # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBProbeConfig while ($true)
        }                                                                                   # End :GetAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleConfig