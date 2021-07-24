# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetCIDRAddress:             Function to add a CIDR address to $var
} #>
<# Variables: {      
    :SetCIDRAddressLoop         Outer loop for managing function
    :SetIPAddress               Inner loop for setting the starting IP address
    :SetCIDRBlock               Inner loop for setting the CIDR block
    $ValidArray:                Array of valid characters
    $IPAddress:                 Operator input for the starting IP address
    $IPAddressArray:            $IPAddress converted to array
    $OpConfirm:                 Operator confirmation of inputs
    $CIDRBlock:                 Operator input for the CIDR block
    $CIDRBlockArray:            $CIDRBlock converted to array
    $CIDRBlockInt:              $CIDRBlock converted to interger
    $CIDRIPAddress:             Full CIDR notation address
} #>
<# Process Flow {
    function
        Call SetCIDRAddress > Get $CIDRIPAddress
        End SetCIDRAddress
            Return function > Send $CIDRIPAddress
}#>
function SetCIDRAddress {                                                                   # Function to add a CIDR address to $var
    Begin {                                                                                 # Begin function
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetCIDRAddressLoop while ($true) {                                                 # Outer loop for managing function
            :SetIPAddress while ($true) {                                                   # Inner loop for setting the starting IP
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are setting the IP for:'$CallingFunction                # Write message to screen
                }                                                                           # End if ($CallingFunction)
                Write-Host 'Enter the starting IP address (Must end with .0)'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = Read-Host 'IP Address'                                         # Operator input for the starting IP address
                Clear-Host                                                                  # Clears screen
                if ($IPAddress -notlike '*.*.*.0') {                                        # If $IPAddress is not like '*.*.*.0'
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress -notlike '*.*.*.0') 
                else {                                                                      # Else if $IPAddress is like '*.*.*.0'
                    $IPAddressArray = $IPAddress.ToCharArray()                              # Converts $IPAddress to array
                    foreach ($_ in $IPAddressArray) {                                       # For each item in $IPAddressArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $IPAddressArray)
                    $IPAddressArray = $null                                                 # Clears $var
                }                                                                           # End else (if ($IPAddress -notlike '*.*.*.0') )
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    Write-Host 'Use'$IPAddress' as the starting IP'                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetIPAddress                                                  # Breaks :SetIPAddress  
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($IPAddress)
                else {                                                                      # If $IPAddress is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($IPAddress))
            }                                                                               # End :SetIPAddress while ($true) 
            $ValidArray = '0123456789'                                                      # Creates $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to array
            :SetCIDRBlock while ($true) {                                                   # Inner loop for setting the CIDR block
                Write-Host 'Enter the CIDR Block (0-32)'                                    # Write message to screen
                Write-Host  ''                                                              # Write message to screen
                $CIDRBlock = Read-Host 'CIDR Block'                                         # Operator input for the CIDR block
                Clear-Host                                                                  # Clears screen
                $CIDRBlockArray = $CIDRBlock.ToCharArray()                                  # Converts $CIDRBlock to array
                foreach ($_ in $CIDRBlockArray) {                                           # For each item in $CIDRBlockArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $CIDRBlockArray)
                $CIDRBlockArray = $null                                                     # Clears $var
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    $CIDRBlockInt = [INT]$CIDRBlock                                         # Converts $CIDRBlock to integer
                    if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32) {                     # If $CIDRBlockInt is less than 0 or greater than 32)
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End if ($CIDRBlockInt -lt 0 -or $CIDRBlockInt -gt 32)
                    $CIDRBlockInt = $null                                                   # Clears $var
                }                                                                           # End if ($CIDRBlock)
                if ($CIDRBlock) {                                                           # If $CIDRBlock has a value
                    Write-Host 'Use'$CIDRBlock' as the CIDR block'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the CIDR block
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetCIDRAddressLoop                                            # Breaks :SetCIDRAddressLoop
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        $CIDRAddress = $IPAddress+'/'+$CIDRBlock                            # $CIDRAddress is equal to $IPAddress and $CIDRBlock
                        Return $CIDRAddress                                                 # Returns to calling function with $var
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                        $CIDRBlock = $null                                                  # Clears $var
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End if ($CIDRBlock)
                else {                                                                      # Else if $CIDRBlock is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($CIDRBlock))
            }                                                                               # End :SetCIDRBlock while ($true)
        }                                                                                   # Outer loop for managing function
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetCIDRAddress