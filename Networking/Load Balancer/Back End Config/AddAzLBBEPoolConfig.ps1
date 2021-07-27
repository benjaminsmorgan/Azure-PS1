# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Add-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerbackendaddresspoolconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0  
} #>
<# Required Functions Links: {
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
} #>
<# Functions Description: {
    AddAzLBBEPoolConfig:        Function to add a new load balancer back end pool
    GetAzLoadBalancer:          Function to get a load balancer 
} #>
<# Variables: {      
    :AddAzureLBBEPool           Outer loop for managing function
    :SetAzureLBBEPoolName       Inner loop for setting the pool name
    $CallingFunction:           Name of this function or the one that called it
    $LoadBalancerObject:        Load balancer object
    $VName1st:                  Array of valid 1st characters for the pool name
    $VNameElse:                 Array of valid middle characters for the pool name
    $VNameLast:                 Array of valid last characters for the pool name
    $BackEndPoolName:           Operator input for the pool name
    $BackEndPoolArray:          $BackEndPoolName converted to array
    $OpConfirm:                 Operator confirmation of the name
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call AddAzLBBEPoolConfig > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return AddAzLBBEPoolConfig > Send $LoadBalancerObject
        End AddAzLBBEPoolConfig
            Return function > Send $null
}#>
function AddAzLBBEPoolConfig {                                                              # Function to add a new load balancer back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBBEPoolConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBBEPool while ($true) {                                                   # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBBEPool                                                      # Breaks :AddAzureLBBEPool
            }                                                                               # End if (!$LoadBalancerObject)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBBEPoolName while ($true) {                                           # Inner loop for setting the name
                Write-Host 'Back End name rules:'                                           # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $BackEndPoolName = Read-Host 'Name'                                         # Operator input for the back end pool name
                $BackEndPoolArray = $BackEndPoolName.ToCharArray()                          # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($BackEndPoolName.Length -gt 80) {                                       # If $BackEndPoolName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $var
                }                                                                           # End if ($BackEndPoolName.Length -gt 80)
                if ($BackEndPoolArray[0] -notin $VName1st) {                                # If 0 position of $BackEndPoolArray is not in $VName1st
                    Write-Host  $BackEndPoolArray[-1]' is not a valid character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $BackEndPoolName
                }                                                                           # End if ($BackEndPoolArray[0] -notin $VName1st)
                foreach ($_ in $BackEndPoolArray) {                                         # For each item in $BackEndPoolArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $BackEndPoolName = $null                                            # Clears $BackEndPoolName
                    }                                                                       # End if ($_ -notin $BackEndPoolArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($BackEndPoolArray[-1] -notin $VNameLast) {                              # If last position of $BackEndPoolArray is not in $VNameLast
                    Write-Host  $BackEndPoolArray[-1]' is not a valid character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $BackEndPoolName
                }                                                                           # End if ($BackEndPoolArray[0] -notin $VNameLast)
                if ($BackEndPoolName) {                                                     # If $BackEndPoolName has a value
                    Write-Host 'Use:'$BackEndPoolName' as the back end pool name'           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBBEPool                                              # Breaks :AddAzureLBBEPool
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBBEPoolName                                          # Breaks :SetAzureLBBEPoolName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndPoolName)
                else {                                                                      # Else if $BackEndPoolName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndPoolName))
            }                                                                               # End :SetAzureLBBEPoolName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building back end configuration'                                # Write message to screen
                $LoadBalancerObject | Add-AzLoadBalancerBackendAddressPoolConfig -Name `
                    $BackEndPoolName -ErrorAction 'Stop' | Out-Null                         # Creates the back end pool
                Write-Host 'Saving load balancer configuration'                             # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the load balancer
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBBEPool                                                      # Breaks :AddAzureLBBEPool
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The back end pool has been created'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBBEPool                                                          # Breaks :AddAzureLBBEPool
        }                                                                                   # End :AddAzureLBBEPool while ($true)                                                     
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzLBBEPoolConfig