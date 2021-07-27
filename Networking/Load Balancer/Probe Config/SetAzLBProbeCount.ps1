# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerprobeconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-5.5.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/GetAzLBProbeConfig.ps1
} #>
<# Functions Description: {
    SetAzLBProbeCount:          Function to change an existing load balancer probe count config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
} #>
<# Variables: {      
    :SetAzureProbeConfig        Outer loop for managing function
    :SetAzureLBProbeCount       Inner loop for setting he probe count
    $CallingFunction:           Name of this function or the one that called it
    $LBProbeObject:             Load balancer probe object
    $LoadBalancerObject:        Load balancer object
    $ValidArray:                Array of valid characters for $LBProbeCount
    $LBProbeCount:              Operator input for the new probe count
    $LBProbeArray:              $LBProbeCount converted to array
    $LBProbeCountInt:           $LBProbeCount converted to integer
    $OpConfirm:                 Operator confirmation to make this change
    GetAzLBProbeConfig{}        Gets $LBProbeObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBProbeCount > Get $null
            Call GetAzLBProbeConfig > Get $LBProbeObject, $LoadBalancerObject
            End GetAzLBProbeConfig
                Return SetAzLBProbeCount > Send $LBProbeObject, $LoadBalancerObject
        End SetAzLBProbeCount
            Return function > Send $null
}#>
function SetAzLBProbeCount {                                                                # Function to change an existing load balancer probe count config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBProbeCount'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureProbeConfig while ($true) {                                                # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBProbeCount while ($true) {                                           # Inner loop for setting the probe count
                Write-Host 'Enter new probe count'                                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBProbeCount = Read-Host 'Probe count'                                     # Operator input for the probe count 
                $LBProbeArray = $LBProbeCount.ToCharArray()                                 # Adds $LBProbeCount to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBProbeArray) {                                             # For each item in $LBProbeArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBProbeCount = $null                                               # Clears $LBProbeCount
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBProbeArray)
                Try {                                                                       # Try the following
                    $LBProbeCountInt = [INT]$LBProbeCount                                   # Converts $LBProbeCount to an integer
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    $LBProbeCountInt = $null                                                # Clears $LBProbeCountInt
                }                                                                           # End Catch
                if ($LBProbeCountInt -lt 2 -or $LBProbeCountInt -gt 429496729) {            # if ($LBProbeCountInt less than 5 or $LBProbeCountInt greater than 429496729)
                    Write-Host 'The count out must be between 2 and 429 Million'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBProbeCount = $null                                                   # Clears $LBProbeCount
                }                                                                           # End if ($LBProbeCountInt -lt 5 -or $LBProbeCountInt -gt 429496729)
                $LBProbeArray = $null                                                       # Clears $LBProbeArray
                if ($LBProbeCount) {                                                        # If $LBProbeCount has a value
                    Write-Host 'Set'$LBProbeCount' as the probe count'                      # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe count
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureProbeConfig                                           # Breaks :SetAzureProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBProbeCount                                          # Breaks :SetAzureLBProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBProbeCount)
                else {                                                                      # Else if $LBProbeCount is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBProbeCount))
            }                                                                               # End :SetAzureLBProbeCount while ($true)
            Write-Host 'Updating the probe configuration'                                   # Write message to screen
            Try {                                                                           # Try the following
                Set-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBProbeObject.Name -IntervalInSeconds $LBProbeObject.IntervalInSeconds `
                    -Protocol $LBProbeObject.Protocol -Port $LBProbeObject.Port -ProbeCount `
                    $LBProbeCount -RequestPath $LBProbeObject.RequestPath -ErrorAction `
                    'Stop' | Out-Null                                                       # Updates the probe count
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
}                                                                                           # End function SetAzLBProbeCount