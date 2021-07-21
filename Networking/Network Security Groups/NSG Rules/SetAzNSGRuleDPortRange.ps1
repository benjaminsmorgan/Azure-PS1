# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRuleDPortRange:     Function to set a network security rule destination port range
} #>
<# Variables: {      
    :SetAzureNSGRuleDPRange     Outer loop for managing function
    :SetAzureNSGPortRange       Inner loop for selecting the port options
    :SetAzureNSGRulePort        Inner loops for setting the port info
    :SetAzureNSGRulePortSingle  Inner loop for setting a single destination port
    :ConfirmAzureNSGRulePorts   Inner loop for confirming port list
    :SetAzureNSGRDPortStart     Inner loop for setting the starting port of range
    :SetAzureNSGRDPortEnd       Inner loop for setting the ending port of range
    $ValidArray:                Array of valid characters for $NSGRuleDPRange
    $OpSelect:                  Operator input for choosing option
    $NSGRuleDPRange:            Network security group rule destination port range
    $NSGRuleArray:              Current port entry converted to array
    $NSGInt:                    Current port entry converted to integer
    $NSGRuleDPList:             Array holding all previous entries to a multiport list
    $NSGRuleDPAdd:              $var used to add new port to $NSGRuleDPList
    $OpConfirm:                 Operator confirmation of input
    $NSGRuleDPListTrim:         $var used to remove the first ', ' from $NSGRuleDPList
    $DPRangeStart:              Operator input for destination port range start
    $DPRangeEnd:                Operator input for destination port range start
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleDPortRange > Get $NSGRuleDPRange
        End SetAzNSGRuleDPortRange
            Return function > Send $NSGRuleDPRange
}#>
Function SetAzNSGRuleDPortRange {                                                           # Function to set a network security rule destination port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleDPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule destination port range
                Write-Host 'NSG Rule Destination Port Range'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the destination port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleDPRange                                            # Breaks :SetAzureNSGRuleDPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleDPRange = '*'                                                   # Sets $NSGRuleDPRange
                    Return $NSGRuleDPRange                                                  # Returns to calling function with $NSGRuleDPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single destination port
                        Write-Host 'Enter the destination port'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleDPRange = Read-Host 'Port #'                                # Operator input for the destination port number
                        $NSGRuleArray = $NSGRuleDPRange.ToCharArray()                       # Converts $NSGRuleDPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            $NSGInt = [INT]$NSGRuleDPRange                                  # Converts $NSGRuleDPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleDPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleDPRange)
                        if ($NSGRuleDPRange) {                                              # If $NSGRuleDPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleDPRange' as the destination port'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the destination port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleDPRange)
                        else {                                                              # Else if $NSGRuleDPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleDPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleDPList = @()                                                    # Creates $NSGRuleDPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple destination ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the destination port'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleDPAdd = Read-Host 'Port #'                              # Operator input for the destination port number
                            $NSGRuleArray = $NSGRuleDPAdd.ToCharArray()                     # Converts $NSGRuleDPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                $NSGInt = [INT]$NSGRuleDPAdd                                # Converts $NSGRuleDPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleDPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleDPAdd)
                            if ($NSGRuleDPAdd) {                                            # If $NSGRuleDPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleDPAdd' to destination port list'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleDPAdd)
                            else {                                                          # Else if $NSGRuleDPAdd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPAdd))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleDPList += $NSGRuleDPAdd                                     # Adds $NSGRuleDPAdd to $NSGRuleDPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule destination ports
                            Write-Host 'Current destination port list:'                     # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleDPList) {                                # For each item in $NSGRuleDPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleDPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleDPRange = $NSGRuleDPList                            # $NSGRuleDPRange is equal to $NSGRuleDPList 
                                Return $NSGRuleDPRange                                      # Returns to calling function with $NSGRuleDPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleDPAdd = $null                                       # Clears $var
                                Break ConfirmAzureNSGRulePorts                              # Breaks :ConfirmAzureNSGRulePorts
                            }                                                               # End elseif ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq 'e') )
                        }                                                                   # End :ConfirmAzureNSGRulePorts while ($true)
                    }                                                                       # End :SetAzureNSGRSPortMulti while ($true)
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a destination port range
                        :SetAzureNSGRDPortStart while ($true) {                             # Inner loop for settings a destination port start
                            Write-Host 'Enter the destination port range start '            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the destination port range start
                            $NSGRuleArray = $DPRangeStart.ToCharArray()                     # Converts $DPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                $NSGInt = [INT]$DPRangeStart                                # Converts $DPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeStart)
                            if ($DPRangeStart) {                                            # If $DPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeStart' for destination port range start'   # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortStart                            # Breaks :SetAzureNSGRDPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeStart)
                            else {                                                          # Else if $DPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleDPRange))
                        }                                                                   # End :SetAzureNSGRDPortStart while ($true)
                        :SetAzureNSGRDPortEnd while ($true) {                               # Inner loop for settings a destination port end
                            Write-Host 'Enter the destination port range end '              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $DPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the destination port range end
                            $NSGRuleArray = $DPRangeEnd.ToCharArray()                       # Converts $DPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                $NSGInt = [INT]$DPRangeEnd                                  # Converts $DPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $DPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($DPRangeEnd)
                            if ($DPRangeEnd) {                                              # If $DPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host `
                                    'Use'$DPRangeEnd' for destination port range end'       # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the destination port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRDPortEnd                              # Breaks :SetAzureNSGRDPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($DPRangeEnd)
                            else {                                                          # Else if $DPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($DPRangeEnd))
                        }                                                                   # End :SetAzureNSGRDPortEnd while ($true)
                        $NSGRuleDPRange = $DPRangeStart+'-'+$DPRangeEnd                     # $NSGRuleDPRange is equal to5 $DPRangeStart and $DPRangeEnd       
                        Write-Host 'Use'$NSGRuleDPRange' as the destination port range'     # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the destination port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleDPRange                                          # Returns to calling function with $NSGRuleDPRange
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break SetAzureNSGRulePort                                       # Breaks :SetAzureNSGRulePort
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNSGPortRange while ($true)
        }                                                                                   # End :SetAzureNSGRuleDPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleDPortRange