# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerprobeconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-5.5.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/GetAzLBProbeConfig.ps1
} #>
<# Functions Description: {
    SetAzLBProbeInterval:       Function to change an existing load balancer probe interval config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
} #>
<# Variables: {      
    :SetAzureProbeConfig        Outer loop for managing function
    :SetAzureLBProbeInt         Inner loop for setting he probe interval
    $CallingFunction:           Name of this function or the one that called it
    $LBProbeObject:             Load balancer probe object
    $LoadBalancerObject:        Load balancer object
    $ValidArray:                Array of valid characters for $LBProbeinterval
    $LBProbeinterval:           Operator input for the new probe interval
    $LBProbeArray:              $LBProbeinterval converted to array
    $LBProbeintervalInt:        $LBProbeinterval converted to integer
    $OpConfirm:                 Operator confirmation to make this change
    GetAzLBProbeConfig{}        Gets $LBProbeObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBProbeInterval > Get $null
            Call GetAzLBProbeConfig > Get $LBProbeObject, $LoadBalancerObject
            End GetAzLBProbeConfig
                Return SetAzLBProbeInterval > Send $LBProbeObject, $LoadBalancerObject
        End SetAzLBProbeInterval
            Return function > Send $null
}#>
function SetAzLBProbeInterval {                                                             # Function to change an existing load balancer probe interval config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBProbeInterval'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureProbeConfig while ($true) {                                                # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBProbeInt while ($true) {                                             # Inner loop for setting the probe interval
                Write-Host 'Enter new probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBProbeinterval = Read-Host 'Probe interval (Seconds)'                     # Operator input for the probe interval 
                $LBProbeArray = $LBProbeinterval.ToCharArray()                              # Adds $LBProbeinterval to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBProbeArray) {                                             # For each item in $LBProbeArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBProbeinterval = $null                                            # Clears $LBProbeinterval
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBProbeArray)
                $LBProbeintervalInt = [INT]$LBProbeinterval | Out-Null                      # Converts $LBProbeinterval to an integer
                if ($LBProbeintervalInt -lt 5 -or $LBProbeintervalInt -gt 2147483646) {     # if ($LBProbeintervalInt less than 5 or $LBProbeintervalInt greater than 2147483646)
                    Write-Host 'The interval out must be between 5 and 2 Billion seconds'   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBProbeinterval = $null                                                # Clears $LBProbeinterval
                }                                                                           # End if ($LBProbeintervalInt -lt 5 -or $LBProbeintervalInt -gt 2147483646)
                $LBProbeArray = $null                                                       # Clears $LBProbeArray
                if ($LBProbeinterval) {                                                     # If $LBProbeinterval has a value
                    Write-Host 'Set'$LBProbeinterval' seconds as the probe interval'        # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureProbeConfig                                           # Breaks :SetAzureProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBProbeInt                                            # Breaks :SetAzureLBProbeInt        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBProbeinterval)
                else {                                                                      # Else if $LBProbeinterval is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBProbeinterval))
            }                                                                               # End :SetAzureLBProbeInt while ($true)
            Write-Host 'Updating the probe configuration'                                   # Write message to screen
            Try {                                                                           # Try the following
                Set-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBProbeObject.Name -IntervalInSeconds $LBProbeinterval -Protocol `
                    $LBProbeObject.Protocol -Port $LBProbeObject.Port -ProbeCount `
                    $LBProbeObject.NumberOfProbes -RequestPath $LBProbeObject.RequestPath `
                    -ErrorAction 'Stop' | Out-Null                                          # Updates the probe interval
                Write-Host 'Saving the load balancer config'                                # Write message to screen
                Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject -ErrorAction 'Stop'    # Saves the updated load balancer configuration
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig  
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The requested changes have been made'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureProbeConfig                                                       # Breaks :SetAzureProbeConfig
        }                                                                                   # End :SetAzureProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBProbeInterval
function GetAzLBProbeConfig {                                                               # Function to get an existing load balancer probe config
    Begin {                                                                                 # Begin function
        :GetAzureLBProbeConfig while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
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
                    Write-Host 'LB Name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
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
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer probe config object
                    Clear-Host                                                              # Clears screen
                    if ($CallingFunction -eq 'AddAzLBRuleConfig') {                         # If $CallingFunction equals 'AddAzLBRuleConfig'
                        Return $LBProbeObject                                               # Returns to calling function with $var    
                    }                                                                       # End if ($CallingFunction -eq 'AddAzLBRuleConfig')
                    else {                                                                  # Else if $CallingFunction does not equal 'AddAzLBRuleConfig'
                        Return $LBProbeObject, $LoadBalancerObject                          # Returns to calling function with $vars
                    }                                                                       # End else (if ($CallingFunction -eq 'AddAzLBRuleConfig'))
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
}                                                                                           # End function GetAzLBProbeConfig