# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    NewAzLBRuleConfig:          Creates a new load balancer rule
} #>
<# Variables: {      
    :NewAzureLBRuleConfig       Outer loop for managing function
    :NewAzureLBRCName           Inner loop for setting rule name
    :NewAzureLBRuleProtocol     Inner loop for setting rule protocol
    :NewAzureLBRuleFrontEndPort Inner loop for setting rule front end port
    :NewAzureLBRuleBackEndPort  Inner loop for setting rule back end port
    :NewAzureLBRuleIdleTO       Inner loop for setting rule idle time out
    $ValidArray:                Array of valid non first/last characters to load balancer config
    $Valid1stChar:              Array of valid first characters to load balancer config
    $ValidLastChar:             Array of valid last characters to load balancer config
    $LBRuleNameArray:           $LBRuleNameObject converted to array
    $LBRuleNameObject:          Rule name object
    $OpConfirm:                 Operator confirmation of inputs
    $OpSelect:                  Operator selection of the rule protocol
    $LBRuleProtocolObject:      Rule protocol object
    $LBRuleFrontEndPort:        Rule front end port object
    $LBRuleBackEndPort:         Rule back end port object
    $LBRuleIdleTO:              Rule idle time out object
    $OperatorConfirm:           Operator confirmation of the $vars
    $LoadBalanceRule:           Newly created rule object
    $FrontEndIPConfigObject:    Front end object sent from calling function
    $BackEndIPConfigObject:     Back end object sent from calling function
    $HealthProbeObject:         Health probe object sent from calling function
} #>
<# Process Flow {
    function
        Call NewAzLBRuleConfig > Get $LoadBalanceRule    
        End NewAzLBRuleConfig
            Return function > Send $LoadBalanceRule
}#>
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                Write-Host 'Enter a load balancer rule name'                                # Write message to screen
                $LBRuleNameObject = Read-Host 'Name'                                        # Operator input for the pool name
                Clear-Host                                                                  # Clears screen
                $LBRuleNameArray = $LBRuleNameObject.ToCharArray()                          # Loads $LBRuleNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleNameObject.Length -ge 81) {                                      # If $LBRuleNameObject.Length is greater or equal to 81
                    Write-Host 'The rule name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameObject.Length -ge 80)
                if ($LBRuleNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $LBRuleNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                if ($LBRuleNameArray[-1] -notin $ValidLastChar) {                           # If last position of $LBRuleNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBRuleNameArray) {                                          # For each item in $LBRuleNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBRuleNameObject = $null                                           # Clears $LBRuleNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleNameObject) {                                                    # If $LBRuleNameObject has a value
                    Write-Host 'Use:'$LBRuleNameObject' as the rule name'                   # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRCName                                              # Breaks :NewAzureLBRCName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleNameObject)
                else {                                                                      # If $LBRuleNameObject is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleNameObject))
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Load balancer rule protocol'                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Write-Host 'Enter the rule pool front end port'                             # Write message to screen
                $LBRuleFrontEndPort = Read-Host 'Port #'                                    # Operator input for the front end rule port 
                Clear-Host                                                                  # Clears screen
                if ($LBRuleFrontEndPort -ge 1 -and $LBRuleFrontEndPort -le 99999 -and `
                    $LBRuleFrontEndPort -notlike '*.*') {                                   # If $LBRuleFrontEndPort is or in between 1 and 99,999 and not include '.'
                    Write-Host 'Use:'$LBRuleFrontEndPort' as the front end pool rule port'  # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort -ge 1 -and $LBRuleFrontEndPort -le 99999 -and $LBRuleFrontEndPort -notlike '*.*')
                else {                                                                      # All other inputs for $LBRuleFrontEndPort
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort -ge 1 -and $LBRuleFrontEndPort -le 99999 -and $LBRuleFrontEndPort -notlike '*.*'))
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Write-Host 'Enter the rule pool back end port'                              # Write message to screen
                $LBRuleBackEndPort = Read-Host 'Port #'                                     # Operator input for the back end rule port 
                Clear-Host                                                                  # Clears screen
                if ($LBRuleBackEndPort -ge 1 -and $LBRuleBackEndPort -le 99999 -and `
                    $LBRuleBackEndPort -notlike '*.*') {                                    # If $LBRuleBackEndPort is or in between 1 and 99,999 and not include '.'
                    Write-Host 'Use:'$LBRuleBackEndPort' as the back end pool rule port'    # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleBackEndPort -ge 1 -and $LBRuleBackEndPort -le 99999 -and $LBRuleBackEndPort -notlike '*.*')
                else {                                                                      # All other inputs for $LBRuleBackEndPort
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleBackEndPort -ge 1 -and $LBRuleBackEndPort -le 99999 -and $LBRuleBackEndPort -notlike '*.*'))
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in seconds for this rule'               # Write message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
                Clear-Host                                                                  # Clears screen
                if ($LBRuleIdleTO -ge 1 -and $LBRuleIdleTO -le 99999 -and `
                    $LBRuleIdleTO -notlike '*.*') {                                         # If $LBRuleIdleTO is or in between 1 and 99,999 and not include '.'
                    Write-Host 'Use:'$LBRuleIdleTO' as the back end pool rule port'         # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO -ge 1 -and $LBRuleIdleTO -le 99999 -and $LBRuleIdleTO -notlike '*.*')
                else {                                                                      # All other inputs for $LBRuleIdleTO
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO -ge 1 -and $LBRuleIdleTO -le 99999 -and $LBRuleIdleTO -notlike '*.*'))
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the load balancer rule'                                # Write message to screen
                $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                    -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                    $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                    $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                    $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO `
                    -EnableFloatingIP -LoadDistribution SourceIP -ErrorAction 'Stop'        # Creates the load balancer rule
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBRuleConfig                                                  # Breaks :NewAzureLBRuleConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been created'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $LoadBalanceRule                                                         # Returns $LoadBalanceRule to calling function
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig