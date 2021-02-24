# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancerRuleConfig:  https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
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
    $LBRuleNameObject:          Rule name object
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
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                $LBRuleNameObject = Read-Host "Rule Name"                                   # Operator input for the pool name
                if ($LBRuleNameObject -eq 'exit') {                                         # If $LBRuleNameObject equals $null
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleNameObject -eq 'exit')
                Write-Host $LBRuleNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the rule name? [Y] or [N]"             # Operator confirmation of the rule name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBRCName                                                  # Breaks :NewAzureLBRCName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $LBRuleProtocolObject = Read-Host '[0], [1], or [2]'                        # Operator input for the protocol object
                if ($LBRuleProtocolObject -eq '0') {                                        # If $LBRuleProtocolObject equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleProtocolObject -eq '0')
                elseif ($LBRuleProtocolObject -eq '1') {                                    # If $LBRuleProtocolObject equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '1')
                elseif ($LBRuleProtocolObject -eq '2') {                                    # If $LBRuleProtocolObject equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($LBRuleProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Try {                                                                       # Try the following
                    [int]$LBRuleFrontEndPort = Read-Host "Rule front end port"              # Operator input for the front end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleFrontEndPort -le 0) {                                            # If $LBRuleFrontEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleFrontEndPort -le 0) 
                elseif ($LBRuleFrontEndPort -ge 1) {                                        # If $LBRuleFrontEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Front end port will be' `
                    $LBRuleFrontEndPort '[Y], [N], or [E] to exit'                          # Operator confirmation of the front end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleFrontEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Try {                                                                       # Try the following
                    [int]$LBRuleBackEndPort = Read-Host "Rule back end port"                # Operator input for the back end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleBackEndPort -le 0) {                                             # If $LBRuleBackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleBackEndPort -le 0) 
                elseif ($LBRuleBackEndPort -ge 1) {                                         # If $LBRuleBackEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $LBRuleBackEndPort '[Y], [N], or [E] to exit'                           # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleBackEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Try {                                                                       # Try the following
                    [int]$LBRuleIdleTO = Read-Host "Rule idle time out"                     # Operator input for the rule idle timeout
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleIdleTO -le 0) {                                                  # If $LBRuleIdleTO is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleIdleTO -le 0) 
                elseif ($LBRuleIdleTO -ge 1) {                                              # If $LBRuleIdleTO is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Load balancer idle timeout will be' `
                    $LBRuleIdleTO '[Y], [N], or [E] to exit'                                # Operator confirmation of the rule idle timeout
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleIdleTO -ge 1)
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO -EnableFloatingIP `
                -LoadDistribution SourceIP                                                  # Creates the load balancer rule
            if ($LoadBalanceRule) {                                                         # If $LoadBalanceRule has a value
                Return $LoadBalanceRule                                                     # Returns to calling function with $LoadBalanceRule
            }                                                                               # End if ($LoadBalanceRule)
            else {                                                                          # If $LoadBalanceRule does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzLBRuleConfig                                                     # Breaks :NewAzLBRuleConfig     
            }                                                                               # End else (if ($LoadBalanceRule))
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig