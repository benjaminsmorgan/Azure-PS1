# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetIPAddress:               Function to add an IP address to $var
} #>
<# Variables: {      
    :SetIPAddressLoop           Outer loop for managing function
    $ValidArray:                Array of valid characters
    $IPAddress:                 Operator input for the starting IP address
    $IPAddressArray:            $IPAddress converted to array
    $OctetCheck:                Array of $IPAddress split by '.'
    $OctetInt:                  Current item converted to integer
    $OpConfirm:                 Operator confirmation of inputs
} #>
<# Process Flow {
    function
        Call SetIPAddress > Get $IPAddress
        End SetIPAddress
            Return function > Send $IPAddress
}#>
function SetIPAddress {                                                                     # Function to add an IP address to $var
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContine'                                          # Turns off error reporting
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetIPAddressLoop while ($true) {                                                   # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-Host 'You are setting the IP for:'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            Write-Host 'Enter the IP address (Must be x.x.x.x)'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $IPAddress = Read-Host 'IP Address'                                             # Operator input for the starting IP address
            Clear-Host                                                                      # Clears screen
            if ($IPAddress -notlike '*.*.*.*') {                                            # If $IPAddress is not like '*.*.*.*'
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = $null                                                          # Clears $var
            }                                                                               # End if ($IPAddress -notlike '*.*.*.*') 
            if ($IPAddress) {                                                               # If $IPAddress has a value
                if ($IPAddress.Split('.')[4]) {                                             # If $IPAddress .Split 4th position has a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress.Split('.')[4])
            }                                                                               # End  if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $IPAddressArray = $IPAddress.ToCharArray()                                  # Converts $IPAddress to array
                foreach ($_ in $IPAddressArray) {                                           # For each item in $IPAddressArray
                    if ($_ -notin $ValidArray) {                                            # If current item not in $ValidArray
                        Write-Host $_' is not a valid character'                            # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $IPAddressArray)
                $IPAddressArray = $null                                                     # Clears $var
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                $OctetCheck = $IPAddress.Split('.')                                         # $OctetCheck is equal to $IPAdress.Split '.'
                foreach ($_ in $OctetCheck) {                                               # For each item in $OctetCheck
                    $OctetInt = [INT]$_                                                     # $OctetInt is equal to current item converted to integer
                    if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                            # If $OctetInt less than 0 or  $OctetInt greater than 255
                        Write-Host $_' is not a valid octet'                                # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                    $OctetInt = $null                                                       # Clears $var
                }                                                                           # End foreach ($_ in $OctetCheck)
            }                                                                               # End if ($IPAddress)
            if ($IPAddress) {                                                               # If $IPAddress has a value
                Write-Host 'Use'$IPAddress' as the IP'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP address
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break SetIPAddressLoop                                                  # Breaks :SetIPAddressLoop
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Return $IPAddress                                                       # Returns to calling function with $var  
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End if ($IPAddress)
            else {                                                                          # If $IPAddress is $null
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($IPAddress))
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetIPAddress