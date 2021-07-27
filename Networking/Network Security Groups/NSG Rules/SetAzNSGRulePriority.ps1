# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzNSGRulePriority:       Function to set a network security group rule priority
} #>
<# Variables: {      
    :SetAzureNSGRulePriority    Outer loop for managing function
    $ObjectArray:               Array holding all current rule directions and prioties on $NSGObject
    $NSGObject:                 Network security group object
    $CRules:                    List of rules on $NSGObject
    $Direction:                 Current item .Direction
    $Priority:                  Current item .Priority
    $DirPri:                    Combination of $Direction and $Priority
    $ObjectInput:               $var used to load info into $ObjectArray
    $ValidArray:                Array of valid characters for $NSGRulePriority
    $NSGRuleDirection:          Selected rule direction
    $NSGRulePriority:           NSG rule priority object
    $NSGRuleArray:              $NSGRulePriority converted to array
    $NSGRuleDirPri:             Combination of $NSGRuleDirection and $NSGRulePriority
    $NSGRuleInt:                $NSGRulePriority converted to integer
    $OpConfirm:                 Operator confirmation of rule priority
} #>
<# Process Flow {
    function
        Call SetAzNSGRulePriority > Get $NSGRulePriority
        End SetAzNSGRulePriority
            Return function > Send $NSGRulePriority
}#>
Function SetAzNSGRulePriority {                                                             # Function to set a network security group rule priority
    Begin {                                                                                 # Begin function
        if (!$CRules) {                                                                     # If $CRules is $null
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array 
            $CRules = Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $NSGObject      # List of current rules on $NSGObject
            foreach ($_ in $CRules) {                                                       # For each item in $CRules
                $Direction = $_.Direction                                                   # $Direction is equal to current item .Direction
                $Priority = $_.Priority                                                     # $Priority is equal to current item .Priority
                $DirPri = $Direction+' '+$Priority                                          # $DirPri and $Direction and $Priority 
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'DirPri'=$DirPri                                                        # Adds $DirPri to $ObjectInput 
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $Direction = $null                                                          # Clears $var
                $Priority = $null                                                           # Clears $var
                $DirPri = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $CRules) 
        }                                                                                   # End if (!$CRules)
        $ValidArray = '0123456789'                                                          # Creates a string of valid characters
        $ValidArray = $ValidArray.ToCharArray()                                             # Loads all valid characters into array    
        :SetAzureNSGRulePriority while ($true) {                                            # Inner loop to set the rule priority
            Write-Host 'NSG Rule priority'                                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Rule priority must be between the values of 100 and 4096'           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($CRules.Direction -eq $NSGRuleDirection) {                                  # If $CRules.Direction equals $NSGRuleDirection
                Write-Host 'The following priorities are'                                   # Write message to screen
                Write-Host 'already in use for'$NSGRuleDirection' traffic'                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $CRules) {                                                   # For each item in $CRules
                    if ($_.Direction -eq $NSGRuleDirection) {                               # If current item .Direction equals $NSGRuleDirection
                        Write-Host $_.Priority                                              # Write message to screen
                    }                                                                       # if ($_.Direction -eq $NSGRuleDirection)
                }                                                                           # End foreach ($_ in $CRules)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($CRules.Direction -eq $NSGRuleDirection)
            $NSGRulePriority = Read-Host 'Rule priority'                                    # Operator input for the rule priority
            Clear-Host                                                                      # Clears screen
            $NSGRuleArray = $NSGRulePriority.ToCharArray()                                  # Converts $NSGRulePriority into array
            foreach ($_ in $NSGRuleArray) {                                                 # For each item in $NSGRuleArray
                if ($_ -notin $ValidArray) {                                                # If current item is not in $ValidArray
                    $NSGRulePriority = $null                                                # Clears $var
                }                                                                           # End if ($_ -notin $ValidArray)
            }                                                                               # End foreach ($_ in $NSGRuleArray)                                                                       
            $NSGRuleArray = $null                                                           # Clears $var
            $NSGRuleDirPri = $NSGRuleDirection+' '+$NSGRulePriority                         # $NSGRuleDirPri is equal to $NSGRuleDirection and $NSGRulePriority                     
            if ($NSGRuleDirPri -in $ObjectArray.DirPri) {                                   # If $NSGRuleDirPri is in $ObjectArray.DirPri
                Write-Host 'This priority is already in use for'$NSGRuleDirection           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please select a different priority'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $NSGRulePriority = $null                                                    # Clears $var
            }                                                                               # End if ($NSGRuleDirPri -in $ObjectArray.DirPri)
            $NSGRuleInt = [INT]$NSGRulePriority                                             # Converts $NSGRulePriority to integer
            if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096) {                             # if $NSGRuleInt is not between 100 and 4096
                Write-Host 'Rule priority must be between the values of 100 and 4096'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                $NSGRulePriority = $null                                                    # Clears $var
                $NSGRuleInt = $null                                                         # Clears $var
                $NSGRuleDirPri = $null                                                      # Clears $var
                Clear-Host                                                                  # Clears screen
            }                                                                               # End if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096)                                                                    
            else {                                                                          # Else if $NSGRuleInt is between 100 and 4096
                Write-Host 'Use:'$NSGRulePriority' as the rule priority'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the rule priority
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Return $NSGRulePriority                                                 # Returns to calling function with $NSGRulePriority
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureNSGRule                                                   # Breaks :NewAzureNSGRule
                }                                                                           # End elseif ($OpConfirm -eq 'e')
                else {                                                                      # All other inputs for $OpConfirm
                    $NSGRulePriority = $null                                                # Clears $var
                    $NSGRuleInt = $null                                                     # Clears $var
                    $NSGRuleDirPri = $null                                                  # Clears $var
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End else (if ($NSGRuleInt -lt 100 -or $NSGRuleInt -gt 4096))
        }                                                                                   # End :SetAzureNSGRulePriority while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End functon SetAzNSGRulePriority