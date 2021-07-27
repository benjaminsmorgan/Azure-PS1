# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    SetIPAddress:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetIPAddress.ps1
    SetCIDRAddress:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Other/SetCIDRAddress.ps1

} #>
<# Functions Description: {
    SetAzNSGRuleAddPrefix:      Function to set a network security rule address prefix     
    SetIPAddress:               Function to add an IP address to $var
    SetCIDRAddress:             Function to add a CIDR address to $var
} #>
<# Variables: {      
    :SetAzureNSGRuleAddPrefix   Outer loop for managing function
    :SetAzureNSGAddPreConfig    Inner loop for setting the address prefix config
    :ConfirmAddressPrefixList   Inner loop for confirming ip address list
    $OpSelect:                  Operator input for choosing option
    $NSGRuleAddPrefix:          NSG rule address prefix
    $IPAddress:                 Single IP addres
    $CIDRAddress:               CIDR notation IP address
    SetIPAddress{}              Gets $IPAddress
    SetCIDRAddress{}            Gets $CIDRAddress
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleAddPrefix > Get $NSGRuleAddPrefix
            Call SetIPAddress > Get $IPAddress
            End SetIPAddress
                Return SetAzNSGRuleAddPrefix > Send $IPAddress
            Call SetCIDRAddress > Get $CIDRAddress
            End SetCIDRAddress
                Return SetAzNSGRuleAddPrefix > Send $CIDRAddress
        End SetAzNSGRuleAddPrefix
            Return function > Send $NSGRuleAddPrefix
}#>
Function SetAzNSGRuleAddPrefix {                                                            # Function to set a network security rule address prefix
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleAddPrefix while ($true) {                                           # Outer loop for managing function
            Write-Host 'NSG Rule Address Prefix'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Any'                                                            # Write message to screen
            Write-Host '[2] Single IP Address'                                              # Write message to screen
            Write-Host '[3] Multiple IP Addresses'                                          # Write message to screen
            Write-Host '[4] CIDR Block'                                                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the address prefix method
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break SetAzureNSGRuleAddPrefix                                              # Breaks :SetAzureNSGRuleAddPrefix
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $NSGRuleAddPrefix = '*'                                                     # Sets $NSGRuleAddPrefix
                Return $NSGRuleAddPrefix                                                    # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for settings a single IP address prefix
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$IPAddress) {                                                      # If $IPAddress does not have a value
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$IPAddress)
                    else {                                                                  # If $IPAddress has a value
                        $NSGRuleAddPrefix = $IPAddress                                      # $NSGRuleAddPrefix is equal to $IPAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$IPAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                $NSGRuleAddPrefix = @()                                                     # Creates $NSGRuleAddPrefix        
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for setting multiple address prefix values
                    $IPAddress = SetIPAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if ($IPAddress) {                                                       # If $IPAddress haa a value
                        Clear-Host                                                          # Clears screen
                        Write-Host 'Add:'$IPAddress' Address prefix list'                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpSelect -eq 'y'
                            $NSGRuleAddPrefix += $IPAddress                                 # Adds $IPAddres to $NSGRuleAddPrefix
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpSelect -eq 'e'
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpConfirm -eq 'e')    
                    }                                                                       # End if ($IPAddress)
                    :ConfirmAddressPrefixList while ($true) {                               # Inner loop for confirming the IP address list
                        Write-Host 'Current IP addres prefix list'                          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        foreach ($_ in $NSGRuleAddPrefix) {                                 # For each item in $NSGRuleAddPrefix
                            Write-Host $_                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NSGRuleAddPrefix)
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Add another IP address'                                 # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input to add another IP
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            Break ConfirmAddressPrefixList                                  # Breaks :ConfirmAddressPrefixList
                        }                                                                   # End if ($OpSelect -eq 'y')
                        elseif ($OpSelect -eq 'n') {                                        # Else if $OpSelect equals 'n'
                            Return $NSGRuleAddPrefix                                        # Returns to calling function with $var
                        }                                                                   # End elseif ($OpSelect -eq 'n')   
                        elseif ($OpSelect -eq 'e') {                                        # Else if $OpSelect equals 'e'        
                            Break SetAzureNSGAddPreConfig                                   # Breaks :SetAzureNSGAddPreConfig
                        }                                                                   # End elseif ($OpSelect -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End :ConfirmAddressPrefixList while ($true)
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                :SetAzureNSGAddPreConfig while ($true) {                                    # Inner loop for getting a CIDR address
                $CIDRAddress = SetCIDRAddress ($CallingFunction)                            # Calls function and assigns output to $var
                    if (!$CIDRAddress) {                                                    # If $CIDRAddress is $null
                        Break SetAzureNSGAddPreConfig                                       # Breaks :SetAzureNSGAddPreConfig
                    }                                                                       # End if (!$CIDRAddress)
                    else {                                                                  # If $CIDRAddress has a value
                        $NSGRuleAddPrefix = $CIDRAddress                                    # $NSGRuleAddPrefix is equal to $CIDRAddress
                        Return $NSGRuleAddPrefix                                            # Returns to calling function with $var
                    }                                                                       # End else (if (!$CIDRAddress))
                }                                                                           # End :SetAzureNSGAddPreConfig while ($true)
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :SetAzureNSGRuleAddPrefix while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleAddPrefix
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
function SetCIDRAddress {                                                                   # Function to add a CIDR address to $var
    Begin {                                                                                 # Begin function
        $ValidArray = '0123456789.'                                                         # Creates $ValidArray
        $ValidArray = $ValidArray.ToCharArray()                                             # Converts $ValidArray to array
        :SetCIDRAddressLoop while ($true) {                                                 # Outer loop for managing function
            :SetIPAddress while ($true) {                                                   # Inner loop for setting the starting IP
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are setting the IP for:'$CallingFunction                # Write message to screen
                }                                                                           # End if ($CallingFunction)
                Write-Host 'Enter the starting IP address (Must be x.x.x.0)'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $IPAddress = Read-Host 'IP Address'                                         # Operator input for the starting IP address
                Clear-Host                                                                  # Clears screen
                if ($IPAddress -notlike '*.*.*.0') {                                        # If $IPAddress is not like '*.*.*.0'
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $IPAddress = $null                                                      # Clears $var
                }                                                                           # End if ($IPAddress -notlike '*.*.*.0') 
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    if ($IPAddress.Split('.')[4]) {                                         # If $IPAddress .Split 4th position has a value
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $IPAddress = $null                                                  # Clears $var
                    }                                                                       # End if ($IPAddress.Split('.')[4])
                }                                                                           # End  if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $IPAddressArray = $IPAddress.ToCharArray()                              # Converts $IPAddress to array
                    foreach ($_ in $IPAddressArray) {                                       # For each item in $IPAddressArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $IPAddressArray)
                    $IPAddressArray = $null                                                 # Clears $var
                }                                                                           # End if ($IPAddress)
                if ($IPAddress) {                                                           # If $IPAddress has a value
                    $OctetCheck = $IPAddress.Split('.')                                     # $OctetCheck is equal to $IPAdress.Split '.'
                    foreach ($_ in $OctetCheck) {                                           # For each item in $OctetCheck
                        $OctetInt = [INT]$_                                                 # $OctetInt is equal to current item converted to integer
                        if ($OctetInt -lt 0 -or $OctetInt -gt 255) {                        # If $OctetInt less than 0 or  $OctetInt greater than 255
                            Write-Host $_' is not a valid octet'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $IPAddress = $null                                              # Clears $var
                        }                                                                   # End if ($OctetInt -lt 0 -or $OctetInt -gt 255)
                        $OctetInt = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $OctetCheck)
                }                                                                           # End if ($IPAddress)
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