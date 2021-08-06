# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    New-AzFirewallPolicyRuleCollectionGroup:    https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewallpolicyrulecollectiongroup?view=azps-6.3.0
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
} #>
<# Functions Description: {
    NewAzFWPolicyRCG:           Function to create a new firewall policy rule collection group
    GetAzResourceGroup:         Function to get firewall policy
} #>
<# Variables: {      
    :NewAzureFWPolicyRCG        Outer loop for managing function
    :SetAzureFWPolicyRCGName    Inner loop for setting the rule collection group name
    :SetAzureFWPolicyRCGPri     Inner loop for setting the rule collection group priority
    :ConfirmSetting             Inner loop for confirming the RCG priority
    $CallingFunction:           Name of this function or the one that called it
    $FWPolicyObject:            Firewall policy object
    $ObjectArray:               Array of rule collection group names
    $ObjectArray2:              Array of rule collection group priorities
    $RuleCollectGroups:         $FWPolicyObject.RuleCollectionGroups  
    $RCGName:                   Currently existing policy RCG names 
    $RCGObject:                 Current item RCG object
    $RCGPriority:               $RCGObject.Properties.Priority             
    $ValidArray:                Array of valid body characters for the RCG name
    $Valid1stChar:              Array of valid first characters for the RCG name
    $ValidLastChar:             Array of valid last characters for the RCG name
    $PolicyRCGName:             Operator input for the RCG name
    $PolicyRCGNameArray:        $PolicyRCGName converted to array
    $PolicyRCGPri:              Operator input for the RCG priority
    $PolicyRCGPriArray:         $PolicyRCGPri converted to array
    $PolicyRCGPriInt:           $PolicyRCGPri converted to integer
    $OpConfirm:                 Operator confirmation on the RCG priority
    $MSG:                       Last powershell error message
    GetAzFWPolicy{}             Gets $FWPolicyObject
} #>
<# Process Flow {
    function
        Call NewAzFWPolicyRCG > Get $null
            Call GetAzFWPolicy > Get $FWPolicyObject            
            End GetAzFWPolicy
                Return NewAzFWPolicyRCG > Send $FWPolicyObject        
        End NewAzFWPolicyRCG
            Return function > Send $null
}#>
function NewAzFWPolicyRCG {                                                                 # Function to create a new firewall policy rule collection group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzFWPolicyRCG'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject is $null
                Break NewAzureFWPolicyRCG                                                   # Breaks :NewAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyObject)
            if ($FWPolicyObject.RuleCollectionGroups) {                                     # If $FWPolicyObject.RuleCollectionGroups has a value
                $ObjectArray =@()                                                           # Creates $ObjectArray
                $ObjectArray2 = @()                                                         # Creates $ObjectArray2
                $RuleCollectGroups = $FWPolicyObject.RuleCollectionGroups                   # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $ObjectArray += $RCGName                                                # Addes $RCGName to $ObjectArray
                    $RCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicyObject.Name                       # Gets current item RCGObject
                    $RCGPriority = $RCGObject.Properties.Priority                           # Gets the $RCGObject priority
                    $ObjectArray2 += $RCGPriority                                           # Adds $RCGPriority to $ObjectArray2
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
            }                                                                               # End if ($FWPolicyObject.RuleCollectionGroups)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureFWPolicyRCGName while ($true) {                                        # Inner loop for setting the firewall name
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following policy rule collection '                      # Write message to screen
                    Write-Host 'group names are already in use:'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host 'Enter the policy rule collection group name'                    # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $PolicyRCGName = Read-Host 'Name'                                           # Operator input for the firewall policy name
                $PolicyRCGNameArray = $PolicyRCGName.ToCharArray()                          # Loads $PolicyRCGName into array
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGName.Length -lt 0 -or $PolicyRCGName.Length -ge 80) {         # If $PolicyRCGName.Length is less than 1 or greater than 80 characters
                    Write-Host 'The policy rule collection group name '                     # Write message to screen
                    Write-Host 'must be between 1 and 80 characters'                        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGName.Length -ge 80)
                if ($PolicyRCGNameArray[0] -notin $Valid1stChar) {                          # If 0 position of $PolicyRCGNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGNameArray[0] -notin $Valid1stChar)
                if ($PolicyRCGNameArray[-1] -notin $ValidLastChar) {                        # If last position of $PolicyRCGNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $PolicyRCGName
                }                                                                           # End if ($PolicyRCGNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $PolicyRCGNameArray) {                                       # For each item in $PolicyRCGNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule collection name cannot include any spaces'     # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $PolicyRCGName = $null                                              # Clears $PolicyRCGName
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $PolicyRCGNameArray)
                if ($PolicyRCGName -in $ObjectArray) {                                      # If $PolicyRCGName in $ObjectArray
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $PolicyRCGName = $null                                                  # Clears $var
                }                                                                           # End if ($PolicyRCGName -in $ObjectArray) 
                if ($PolicyRCGName) {                                                       # If $PolicyRCGName has a value
                    Write-Host 'Use:'$PolicyRCGName' as the rule collection group name'     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the firewall name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureFWPolicyRCG                                           # Breaks :NewAzureFWPolicyRCG
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureFWPolicyRCGName                                       # Breaks :SetAzureFWPolicyRCGName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($PolicyRCGName)
                else {                                                                      # If $PolicyRCGName does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGName))
            }                                                                               # End :SetAzureFWPolicyRCGName while ($true)
            $ValidArray = '1234567890'                                                      # Changes $ValidArray
            $ValidArray = $ValidArray.ToCharArray()                                         # Converts $ValidArray to Array
            :SetAzureFWPolicyRCGPri while ($true) {                                         # Inner loop for setting the policy rule collection group priority
                Write-Host 'Please enter the rule collection group priority'                # Write message to screen
                Write-Host 'The value must be between 100 and 65000'                        # Write message to screen
                if ($ObjectArray2) {                                                        # If $ObjectArray2 has a value
                    Write-Host 'The following priorities are already in use'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray2) {                                         # For each item in $ObjectArray2
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray2)
                }                                                                           # End if ($ObjectArray2)
                Write-Host ''                                                               # Write message to screen
                $PolicyRCGPri = Read-Host 'Priority [#]'                                    # Operator input for the RCG priority
                Clear-Host                                                                  # Clears screen
                if ($PolicyRCGPri -in $ObjectArray2) {                                      # If $PolicyRCGPri in $ObjectArray2
                    $PolicyRCGPri = $null                                                   # Clears $var
                    Write-Host 'That priority is already in use'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($PolicyRCGPri -in $ObjectArray2)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriArray = $PolicyRCGPri.ToCharArray()                        # Converts $PolicyRCGPri to array
                    foreach ($_ in $PolicyRCGPriArray) {                                    # For each item in $PolicyRCGPriArray
                        if ($_ -notin $ValidArray) {                                        # If current item not in $ValidArray
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $PolicyRCGPri = $null                                           # Clears $var
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $PolicyRCGPriArray) 
                }                                                                           # End if ($PolicyRCGPri)                                                                     
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    $PolicyRCGPriInt = [Int]$PolicyRCGPri                                   # Converts $PolicyRCGPri to Int
                    if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000) {          # If $PolicyRCGPriInt is not between 100 and 65000
                        Write-Host 'The value must be between 100 and 65000'                # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                        $PolicyRCGPri = $null                                               # Clears $var
                    }                                                                       # End if ($PolicyRCGPriInt -lt 100 -or $PolicyRCGPriInt -gt 65000)            
                    $PolicyRCGPriInt = $null                                                # Clears $var
                }                                                                           # End if ($PolicyRCGPri)
                if ($PolicyRCGPri) {                                                        # If $PolicyRCGPri has a value
                    :ConfirmSetting while ($true) {                                         # Inner loop for confirming the RCG priority
                        Write-Host 'Use:'$PolicyRCGPri' as the rule collection priority'    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the RCG priority
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureFWPolicyRCGPri                                    # Breaks SetAzureFWPolicyRCGPri
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $PolicyRCGPri = $null                                           # Clears $var
                            Break ConfirmSetting                                            # Breaks :ConfirmSetting
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break NewAzureFWPolicyRCG                                       # Breaks :NewAzureFWPolicyRCG
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :ConfirmSetting while ($true)
                }                                                                           # End if ($PolicyRCGPri)
                else {                                                                      # Else if $PolicyRCGPri is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($PolicyRCGPri))
            }                                                                               # End :SetAzureFWPolicyRCGPri while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Building the policy rule collection group'                      # Write message to screen   
                Write-Host 'This may take a moment'                                         # Write message to screen
                New-AzFirewallPolicyRuleCollectionGroup -Name $PolicyRCGName -Priority `
                    $PolicyRCGPri -FirewallPolicyName $FWPolicyObject.Name `
                    -ResourceGroupName $FWPolicyObject.ResourceGroupName `
                    -ErrorAction 'Stop' | Out-Null                                          # Builds the policy rule collection group
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                $MSG = $Error[0]                                                            # Gets the error message
                $MSG = $MSG.Exception.InnerException.Body.Message                           # Isolates the error message
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Warning $MSG                                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureFWPolicyRCG                                                   # Breaks :NewAzureFWPolicyRCG    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The policy rule collection group has been created'                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureFWPolicyRCG                                                       # Breaks :NewAzureFWPolicyRCG
        }                                                                                   # End :NewAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzFWPolicyRCG  