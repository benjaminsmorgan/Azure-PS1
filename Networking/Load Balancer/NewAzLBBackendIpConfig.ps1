# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0   
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    NewAzLBBackendIpConfig:     Creates a load balancer back end IP configuration
} #>
<# Variables: {      
    :NewAzureLBBEIpConfig       Outer loop for managing function
    :SetAzureLBBEName           Inner loop for setting the Back end name
    $BackEndNameObject:         Operator input for the Back end name
    $OpConfirm:                 Operator confirmation of the Back end name
    $BackEndIPConfigObject:     Back end IP config object    
} #>
<# Process Flow {
    function
        Call NewAzLBBackendIpConfig > Get $BackEndIPConfigObject    
        End NewAzLBBackendIpConfig
            Return function > Send $BackEndIPConfigObject
}#>
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                Write-Host 'Enter the load balancer back end name'                          # Write message to screen
                $BackEndNameObject = Read-Host 'Name'                                       # Operator input for the back end name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$BackEndNameObject' as the back end name'                  # Writes message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the back end name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e''
                    Break NewAzureLBBEIpConfig                                              # Breaks :NewAzureLBBEIpConfig
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureLBBEName                                                  # Breaks :SetAzureLBBEName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureLBBEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer back end config'                     # Write message to screen
                $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                    $BackEndNameObject -ErrorAction 'Stop'                                  # Creates the load balancer back end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Back end config has been built'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $BackEndIPConfigObject                                                   # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig