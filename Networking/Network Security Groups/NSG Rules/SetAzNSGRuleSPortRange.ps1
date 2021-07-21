# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRuleSPortRange:     Function to set a network security rule source port range
} #>
<# Variables: {      
    :SetAzureNSGRuleSPRange     Outer loop for managing function
    :SetAzureNSGPortRange       Inner loop for selecting the port options
    :SetAzureNSGRulePort        Inner loops for setting the port info
    :SetAzureNSGRulePortSingle  Inner loop for setting a single source port
    :ConfirmAzureNSGRulePorts   Inner loop for confirming port list
    :SetAzureNSGRSPortStart     Inner loop for setting the starting port of range
    :SetAzureNSGRSPortEnd       Inner loop for setting the ending port of range
    $ValidArray:                Array of valid characters for $NSGRuleSPRange
    $OpSelect:                  Operator input for choosing option
    $NSGRuleSPRange:            Network security group rule source port range
    $NSGRuleArray:              Current port entry converted to array
    $NSGInt:                    Current port entry converted to integer
    $NSGRuleSPList:             Array holding all previous entries to a multiport list
    $NSGRuleSPAdd:              $var used to add new port to $NSGRuleSPList
    $OpConfirm:                 Operator confirmation of input
    $NSGRuleSPListTrim:         $var used to remove the first ', ' from $NSGRuleSPList
    $SPRangeStart:              Operator input for source port range start
    $SPRangeEnd:                Operator input for source port range start
} #>
<# Process Flow {
    function
        Call SetAzNSGRuleSPortRange > Get $NSGRuleSPRange
        End SetAzNSGRuleSPortRange
            Return function > Send $NSGRuleSPRange
}#>
Function SetAzNSGRuleSPortRange {                                                           # Function to set a network security rule source port range
    Begin {                                                                                 # Begin Function
        :SetAzureNSGRuleSPRange while ($true) {                                             # Outer loop for managing function
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :SetAzureNSGPortRange while ($true) {                                           # Inner loop to set the rule source port range
                Write-Host 'NSG Rule Source Port Range'                                     # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Any'                                                        # Write message to screen
                Write-Host '[2] Single Port'                                                # Write message to screen
                Write-Host '[3] Multiple Ports'                                             # Write message to screen
                Write-Host '[4] Port Range'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the source port range
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureNSGRuleSPRange                                            # Breaks :SetAzureNSGRuleSPRange
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $NSGRuleSPRange = '*'                                                   # Sets $NSGRuleSPRange
                    Return $NSGRuleSPRange                                                  # Returns to calling function with $NSGRuleSPRange
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for settings a single source port
                        Write-Host 'Enter the source port'                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NSGRuleSPRange = Read-Host 'Port #'                                # Operator input for the source port number
                        $NSGRuleArray = $NSGRuleSPRange.ToCharArray()                       # Converts $NSGRuleSPRange into array
                        foreach ($_ in $NSGRuleArray) {                                     # For each item in $NSGRuleArray
                            if ($_ -notin $ValidArray) {                                    # If current item is not in $ValidArray
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($_ -notin $ValidArray)
                        }                                                                   # End foreach ($_ in $NSGRuleArray)                                                                       
                        $NSGRuleArray = $null                                               # Clears $var
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            $NSGInt = [INT]$NSGRuleSPRange                                  # Converts $NSGRuleSPRange into interger
                            if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                      # IF $NSGInt is not between 0 and 65535
                                $NSGRuleSPRange = $null                                     # Clears $var
                            }                                                               # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                        }                                                                   # End if ($NSGRuleSPRange)
                        if ($NSGRuleSPRange) {                                              # If $NSGRuleSPRange has a value
                            Clear-Host                                                      # Clears screen
                            Write-Host 'Use:'$NSGRuleSPRange' as the source port'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                # Operator confirmation of the source port
                            Clear-Host                                                      # Clears screen
                            if ($OpConfirm -eq 'y') {                                       # If $OpSelect -eq 'y'
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End if ($OpConfirm -eq 'y')
                            elseif ($OpConfirm -eq 'e') {                                   # Else if $OpSelect -eq 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End elseif ($OpConfirm -eq 'e')
                        }                                                                   # End if ($NSGRuleSPRange)
                        else {                                                              # Else if $NSGRuleSPRange is $null
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($NSGRuleSPRange))
                    }                                                                       # End :SetAzureNSGRulePort while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $NSGRuleSPList = @()                                                    # Creates $NSGRuleSPList
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting multiple source ports
                        :SetAzureNSGRulePortSingle while ($true) {                          # Inner loop for adding a port to the multiport list
                            Write-Host 'Enter the source port'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $NSGRuleSPAdd = Read-Host 'Port #'                              # Operator input for the source port number
                            $NSGRuleArray = $NSGRuleSPAdd.ToCharArray()                     # Converts $NSGRuleSPAdd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                $NSGInt = [INT]$NSGRuleSPAdd                                # Converts $NSGRuleSPAdd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $NSGRuleSPAdd = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($NSGRuleSPAdd)
                            if ($NSGRuleSPAdd) {                                            # If $NSGRuleSPAdd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Add:'$NSGRuleSPAdd' to source port list'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRulePortSingle                         # Breaks :SetAzureNSGRulePortSingle
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($NSGRuleSPRange)
                            else {                                                          # Else if $NSGRuleSPRange is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($NSGRuleSPRange))    
                        }                                                                   # End :SetAzureNSGRSPortSingle while ($true)
                        $NSGRuleSPList += $NSGRuleSPAdd                                     # Adds $NSGRuleSPAdd to $NSGRuleSPList
                        :ConfirmAzureNSGRulePorts while ($true) {                           # Inner loop to confirm the rule source ports
                            Write-Host 'Current source port list:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $NSGRuleSPList) {                                # For each item in $NSGRuleSPList
                                Write-Host $_                                               # Write message to screen
                            }                                                               # End foreach ($_ in $NSGRuleSPList) 
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Add another port'                                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                 # Operator selection to add more ports
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'e') {                                        # If $OpSelect equals 'e'
                                Break SetAzureNSGRulePort                                   # Breaks :SetAzureNSGRulePort
                            }                                                               # End if ($OpSelect -eq 'e')
                            elseif ($OpSelect -eq 'n') {                                    # Else if $OpSelect equals 'n'
                                $NSGRuleSPRange = $NSGRuleSPList                            # $NSGRuleSPRange is equal to $NSGRuleSPList 
                                Return $NSGRuleSPRange                                      # Returns to calling function with $NSGRuleSPRange
                            }                                                               # End elseif ($OpSelect -eq 'n')
                            elseif ($OpSelect -eq 'y') {                                    # Else if $OpSelect equals 'y'
                                $NSGRuleSPAdd = $null                                       # Clears $var
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
                    :SetAzureNSGRulePort while ($true) {                                    # Inner loop for setting a source port range
                        :SetAzureNSGRSPortStart while ($true) {                             # Inner loop for settings a source port start
                            Write-Host 'Enter the source port range start '                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeStart = Read-Host 'Starting Port #'                     # Operator input for the source port range start
                            $NSGRuleArray = $SPRangeStart.ToCharArray()                     # Converts $SPRangeStart into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                $NSGInt = [INT]$SPRangeStart                                # Converts $SPRangeStart into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeStart = $null                                   # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeStart)
                            if ($SPRangeStart) {                                            # If $SPRangeStart has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeStart' for source port range start' # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortStart                            # Breaks :SetAzureNSGRSPortStart
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeStart)
                            else {                                                          # Else if $SPRangeStart is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeStart))
                        }                                                                   # End :SetAzureNSGRSPortStart while ($true)
                        :SetAzureNSGRSPortEnd while ($true) {                               # Inner loop for settings a source port end
                            Write-Host 'Enter the source port range end '                   # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $SPRangeEnd = Read-Host 'Ending Port #'                         # Operator input for the source port range end
                            $NSGRuleArray = $SPRangeEnd.ToCharArray()                       # Converts $SPRangeEnd into array
                            foreach ($_ in $NSGRuleArray) {                                 # For each item in $NSGRuleArray
                                if ($_ -notin $ValidArray) {                                # If current item is not in $ValidArray
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($_ -notin $ValidArray)
                            }                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
                            $NSGRuleArray = $null                                           # Clears $var
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                $NSGInt = [INT]$SPRangeEnd                                  # Converts $SPRangeEnd into interger
                                if ($NSGInt -lt 0 -or $NSGInt -gt 65535) {                  # If $NSGInt is not between 0 and 65535
                                    $SPRangeEnd = $null                                     # Clears $var
                                }                                                           # End if ($NSGInt -lt 0 -or $NSGInt -gt 65535)
                            }                                                               # End if ($SPRangeEnd)
                            if ($SPRangeEnd) {                                              # If $SPRangeEnd has a value
                                Clear-Host                                                  # Clears screen
                                Write-Host 'Use'$SPRangeEnd' for source port range end'     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'            # Operator confirmation of the source port
                                Clear-Host                                                  # Clears screen
                                if ($OpConfirm -eq 'y') {                                   # If $OpSelect -eq 'y'
                                    Break SetAzureNSGRSPortEnd                              # Breaks :SetAzureNSGRSPortEnd
                                }                                                           # End if ($OpConfirm -eq 'y')
                                elseif ($OpConfirm -eq 'e') {                               # Else if $OpSelect -eq 'e'
                                    Break SetAzureNSGRulePort                               # Breaks :SetAzureNSGRulePort
                                }                                                           # End elseif ($OpConfirm -eq 'e')
                            }                                                               # End if ($SPRangeEnd)
                            else {                                                          # Else if $SPRangeEnd is $null
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($SPRangeEnd))
                        }                                                                   # End :SetAzureNSGRSPortEnd while ($true)
                        $NSGRuleSPRange = $SPRangeStart+'-'+$SPRangeEnd                     # $NSGRuleSPRange is equal to5 $SPRangeStart and $SPRangeEnd       
                        Write-Host 'Use'$NSGRuleSPRange' as the source port range'          # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the source port range
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Return $NSGRuleSPRange                                          # Returns to calling function with $NSGRuleSPRange
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
        }                                                                                   # End :SetAzureNSGRuleSPRange while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # Function SetAzNSGRuleSPortRange