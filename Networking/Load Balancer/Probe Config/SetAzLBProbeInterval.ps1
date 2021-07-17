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
                Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject -ErrorAction 'Stop' `
                    | Out-Null                                                              # Saves the updated load balancer configuration
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