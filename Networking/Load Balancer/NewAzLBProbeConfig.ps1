# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    NewAzLBProbeConfig:         Creates a load balancer probe configuration
} #>
<# Variables: {      
    :NewAzureLBProbeConfig      Outer loop for managing function
    :SetAzureProbeName          Inner loop for setting the probe name
    :SetAzureProbeProtocol      Inner loop for setting the probe type
    :SetAzureProbeInterval      Inner loop for setting the probe interval
    :SetAzureProbeCount         Inner loop for setting the probe count
    $ProbeNameObject:           Probe name object
    $ProbeTypeObject:           Probe type object
    $ProbeProtocol:             Array containing probe port and protocol
    $ProbeProtocolInput:        Loads items into the $ProbeProtocol array
    $ProbeIntervalObject:       Probe interval object
    $ProbeCountObject:          Probe count object
    $OpConfirm:                 Operator confirmation of inputs
    $HealthProbeObject:         Health probe configuation
} #>
<# Process Flow {
    function
        Call NewAzLBProbeConfig > Get $HealthProbeObject    
        End NewAzLBProbeConfig
            Return function > Send $HealthProbeObject
}#>
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {                                                                                 # Begin function
        :NewAzureLBProbeConfig while ($true) {                                              # Out loop for managing function
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                Write-Host 'Enter the load balancer probe name'                             # Write message to screen
                $ProbeNameObject = Read-Host 'Name'                                         # Operator input for the probe name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$ProbeNameObject' as the probe name'                       # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the probe name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureProbeName                                                 # Breaks :SetAzureProbeName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host 'Load balanacer health probe protocol'                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option[#]'                                           # Operator input for the probe type object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals '1'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals '2'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (If $OpSelect -eq '0')
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Write-Host 'Enter the probe interval in seconds'                            # Write message to screen
                $ProbeIntervalObject = Read-Host 'Probe interval'                           # Operator input for the probe interval
                Clear-Host                                                                  # Clears screen
                if ($ProbeIntervalObject -ge 1 -and `
                    $ProbeIntervalObject -le 9999999999999 -and `
                    $ProbeIntervalObject -notlike '*.*') {                               # If $ProbeIntervalObject is 1 or more and less or equal to 9999999999999
                    Write-Host 'Set probe interval at:'$ProbeIntervalObject' Seconds'       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeIntervalObject -ge 1 -and $ProbeIntervalObject -le 9999999999999 -and $ProbeIntervalObject -notlike '*.*') 
                else {                                                                      # All other inputs for $ProbeIntervalObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeIntervalObject -ge 1 -and $ProbeIntervalObject -le 9999999999999 -and $ProbeIntervalObject -notlike '*.*'))
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Write-Host 'Enter the number of probes required to'                         # Write message to screen
                Write-Host 'report node is no longer functioning'                           # Write message to screen
                $ProbeCountObject = Read-Host 'Probe count'                                 # Operator input for the probe count
                Clear-Host                                                                  # Clears screen
                if ($ProbeCountObject -ge 1 -and `
                    $ProbeCountObject -le 9999999999999 -and `
                    $ProbeCountObject -notlike '*.*') {                                     # If $ProbeCountObject is greater or equal to 1 or less than or equal to 9999999999999 and not like '.'
                    Write-Host 'Set probe count at:'$ProbeCountObject                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeCountObject -ge 1 -le 9999999999999 -and $ProbeCountObject -le 9999999999999 -and $ProbeCountObject -notlike '*.*')
                else {                                                                      # All other inputs for $ProbeCountObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeCountObject -ge 1 -le 9999999999999 -and $ProbeCountObject -le 9999999999999 -and $ProbeCountObject -notlike '*.*'))
            }                                                                               # End :SetAzureProbeCount while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building health probe configuration'                            # Write message to screen
                $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                    -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                    -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                    -ProbeCount $ProbeCountObject -ErrorAction 'Stop'                       # Creates the Health probe object
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Health probe config has been built'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $HealthProbeObject                                                       # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig