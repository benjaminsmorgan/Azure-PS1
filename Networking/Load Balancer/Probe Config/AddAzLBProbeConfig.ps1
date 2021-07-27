# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Add-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerprobeconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
} #>
<# Required Functions Links: {
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
} #>
<# Functions Description: {
    AddAzLBProbeConfig:         Function to add a new load balancer probe config
    GetAzLoadBalancer:          Function to get a load balancer 
} #>
<# Variables: {      
    :AddAzureLBProbe            Outer loop for managing function
    :SetAzureLBProbeName        Inner loop for setting the probe name
    :SetAzureProbeProtocol      Inner loop for setting the probe protocol
    :SetAzureProbeInterval      Inner loop for setting the probe interval
    :SetAzureProbeCount         Inner loop for setting the probe count
    $CallingFunction:           Name of this function or the one that called it
    $LoadBalancerObject:        Load balancer object
    $VName1st:                  Array of valid probe name 1st characters
    $VNameElse:                 Array of valid probe name characters
    $VNameLast:                 Array of valid probe name last characters
    $ProbeName:                 Operator input for the probe name
    $ProbeNameArray:            $ProbeName converted to array
    $OpConfirm:                 Operator confirmation of values
    $ProbeProtocol:             Array holding the probe protocol
    $ProbeProtocolInput:        $var used to load the protocol into $ProbeProtocol
    $OpSelect:                  Operator input to select the probe protocol
    $ValidArray:                Array of valid characters for probe interval and count
    $ProbeIntervalObject:       Operator input for the probe interval
    $ProbeIntervalArray:        $ProbeIntervalObject converted to array
    $ProbeCountObject:          Operator input for the probe count
    $ProbeCountArray:           $ProbeCountObject converted to array
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call AddAzLBProbeConfig > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return AddAzLBProbeConfig > Send $LoadBalancerObject
        End AddAzLBProbeConfig
            Return function > Send $null
}#>
function AddAzLBProbeConfig {                                                               # Function to add a new load balancer probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBProbeConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBProbe while ($true) {                                                    # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End if (!$LoadBalancerObject)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBProbeName while ($true) {                                            # Inner loop for setting the name
                Write-Host 'Probe name rules:'                                              # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($LoadBalancerObject.Probes.Name) {                                      # If $LoadBalancerObject.Probes.Name has a value
                    Write-Host 'The following names are already in use'                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $LoadBalancerObject.Probes.Name) {                       # For each item in $LoadBalancerObject.Probes.Name
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $LoadBalancerObject.Probes.Name)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($LoadBalancerObject.Probes.Name)
                $ProbeName = Read-Host 'Name'                                               # Operator input for the back end pool name
                $ProbeNameArray = $ProbeName.ToCharArray()                                  # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($ProbeName.Length -gt 80) {                                             # If $ProbeName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $var
                }                                                                           # End if ($ProbeName.Length -gt 80)
                if ($ProbeNameArray[0] -notin $VName1st) {                                  # If 0 position of $ProbeNameArray is not in $VName1st
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VName1st)
                foreach ($_ in $ProbeNameArray) {                                           # For each item in $ProbeNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ProbeName = $null                                                  # Clears $ProbeName
                    }                                                                       # End if ($_ -notin $ProbeNameArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($ProbeNameArray[-1] -notin $VNameLast) {                                # If last position of $ProbeNameArray is not in $VNameLast
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VNameLast)
                if ($ProbeName -in $LoadBalancerObject.Probes.Name) {                       # If $ProbeName is in $LoadBalancerObject.Probes.Name
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host 'Please use a new name'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeName -in $LoadBalancerObject.Probes.Name) 
                if ($ProbeName) {                                                           # If $ProbeName has a value
                    Write-Host 'Use:'$ProbeName' as the back end pool name'                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBProbeName                                           # Breaks :SetAzureLBProbeName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeName)
                else {                                                                      # Else if $ProbeName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeName))
            }                                                                               # End :SetAzureLBProbeName while ($true)
            [System.Collections.ArrayList]$ProbeProtocol = @()                              # Creates array for list to be loaded into
            if ($LoadBalancerObject.Sku.Name -eq 'Basic') {                                 # If $LoadBalancerObject.Sku.Name equals 'Basic'                                  
                $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                    'port' = '80'}                                                          # Creates the item to loaded into array
                $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                          # Loads item into array, out-null removes write to screen
            }                                                                               # End if ($LoadBalancerObject.Sku.Name -eq 'Basic')
            else {                                                                          # Else if $LoadBalancerObject.Sku.Name does not equal 'Basic'
                :SetAzureProbeProtocol while ($true) {                                      # Inner loop for setting the probe type
                    Write-Host 'Load balanacer health probe protocol'                       # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Http (80)'                                              # Write message to screen
                    Write-host '[2] Https(443)'                                             # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpSelect = Read-Host 'Option[#]'                                       # Operator input for the probe type object
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe 
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Elseif $OpSelect equals '1'
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                            'port' = '80'}                                                  # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Elseif $OpSelect equals '2'
                        [System.Collections.ArrayList]$ProbeProtocol = @()                  # Creates array for list to be loaded into
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                            'port' = '443'}                                                 # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (If $OpSelect -eq '0')
                }                                                                           # End :SetAzureProbeProtocol while ($true)
            }                                                                               # End else (if ($LBSkuObject -eq 'Basic'))
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Write-Host 'Enter the probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeIntervalObject = Read-Host 'Probe interval'                           # Operator input for the probe interval
                $ProbeIntervalArray = $ProbeIntervalObject.ToCharArray()                    # Loads $ProbeIntervalObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeIntervalArray) {                                       # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeIntervalObject = $null                                        # Clears $ProbeIntervalObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeIntervalObject) {                                                 # If $ProbeIntervalObject has a value
                    Write-Host 'Set probe interval at:'$ProbeIntervalObject' Seconds'       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeIntervalObject)
                else {                                                                      # Else if $ProbeIntervalObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeIntervalObject))
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Write-Host 'Enter the number of probes required to'                         # Write message to screen
                Write-Host 'report node is no longer functioning'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $ProbeCountObject = Read-Host 'Unhealthy threshold'                         # Operator input for the probe count
                $ProbeCountArray = $ProbeCountObject.ToCharArray()                          # Loads $ProbeCountObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeCountArray) {                                          # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeCountObject = $null                                           # Clears $ProbeCountObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeCountObject) {                                                    # If $ProbeCountObject has a value
                    Write-Host 'Set probe count at:'$ProbeCountObject                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeCountObject)
                else {                                                                      # All other inputs for $ProbeCountObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeCountObject))
            }                                                                               # End :SetAzureProbeCount while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building health probe configuration'                            # Write message to screen
                Add-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject `
                    -Name $ProbeName -RequestPath healthcheck.aspx -Protocol `
                    $ProbeProtocol.Protocol -Port $ProbeProtocol.port `
                    -IntervalInSeconds $ProbeIntervalObject -ProbeCount $ProbeCountObject `
                    -ErrorAction 'Stop'                                                     # Creates the probe config
                Clear-Host                                                                  # Clears screen  
                Write-Host 'Saving the health probe config'                                 # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'                # Saves the probe config to $LoadBalancerObject
                Clear-Host                                                                  # Clears screen
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End catch    
            Write-Host 'Health probe config has been added'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBProbe                                                           # Breaks :AddAzureLBProbe
        }                                                                                   # End :AddAzureLBProbe while ($true)                                                     
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzLBProbeConfig