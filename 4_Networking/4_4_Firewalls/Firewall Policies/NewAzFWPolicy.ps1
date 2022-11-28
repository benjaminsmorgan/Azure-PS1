# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    New-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewallpolicy?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzFWPolicy:              Function to create a new firewall policy
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :NewAzureFWPolicy           Outer loop for managing function
    :SetAzureFWName             Inner loop for setting the policy name
    :SetAzureFWPolicySku        Inner loop for setting the policy tier sku
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $ValidArray:                Array of policy name valid body characters
    $Valid1stChar:              Array of policy name valid first characters
    $ValidLastChar:             Array of policy name valid last characters
    $ObjectList:                List of existing policies on $RGObject
    $FWNameObject:              Operator input for the firewall policy name
    $FWNameArray:               $FWNameObject converted to $array
    $OpConfirm:                 Operator confirmation of the policy name
    $OpSelect:                  Operator selection of the policy sku
    $SkuTierObject:             Sku tier object
    $MSG:                       Last error message
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzFWPolicy > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzFWPolicy > Send $RGObject
        End NewAzFWPolicy
            Return function > Send $null
}#>
function NewAzFWPolicy {                                                                    # Function to create a new firewall policy
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzFWPolicy'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureFWPolicy                                                      # Breaks :NewAzureFWPolicy
            }                                                                               # End if (!$RGObject)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            $ObjectList = $ObjectList | Where-Object `
                {$_.ResourceGroupName -eq $RGObject.ResourceGroupName}                      # Reduces $ObjectList to only objects in $RGObject
            :SetAzureFWName while ($true) {                                                 # Inner loop for setting the firewall name
                if ($ObjectList) {                                                          # If $ObjectList has a value
                    Write-Host 'The following policy names are already in use:'             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectList) {                                           # For each item in $ObjectList
                        Write-Host $_.name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectList)
                Write-Host 'Enter the firewall policy name'                                 # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FWNameObject = Read-Host 'Name'                                            # Operator input for the firewall policy name
                $FWNameArray = $FWNameObject.ToCharArray()                                  # Loads $FWNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($FWNameObject.Length -lt 0 -or $FWNameObject.Length -ge 80) {           # If $FWNameObject.Length is less than 1 or greater than 80 characters
                    Write-Host `
                        'The firewall policy name must be between 1 and 80 characters'      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameObject.Length -ge 80)
                if ($FWNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $FWNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameArray[0] -notin $Valid1stChar)
                if ($FWNameArray[-1] -notin $ValidLastChar) {                               # If last position of $FWNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $FWNameObject
                }                                                                           # End if ($FWNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FWNameArray) {                                              # For each item in $FWNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Firewall name cannot include any spaces'            # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FWNameObject = $null                                               # Clears $FWNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FWNameArray)
                if ($FWNameObject -in $ObjectList.Name) {                                   # If $FWNameObject in $ObjectList.Name
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FWNameObject = $null                                                   # Clears $var
                }                                                                           # End if ($FWNameObject -in $ObjectList.Name) 
                if ($FWNameObject) {                                                        # If $FWNameObject has a value
                    Write-Host 'Use:'$FWNameObject' as the firewall name'                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the firewall name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureFWPolicy                                              # Breaks :NewAzureFWPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureFWName                                                # Breaks :SetAzureFWName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FWNameObject)
                else {                                                                      # If $FWNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FWNameObject))
            }                                                                               # End :SetAzureFWName while ($true)
            :SetAzureFWPolicySku while ($true) {                                            # Inner loop for setting the policy sku tier
                Write-Host 'Please select the firewall policy SKU tier'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Standard'                                                   # Write message to screen
                Write-Host '[2] Premium'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection for the policy tier sku
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureFWPolicy                                                  # Breaks :NewAzureFWPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SkuTierObject = 'Standard'                                             # Sets $SkuTierObject
                    Break SetAzureFWPolicySku                                               # Breaks :SetAzureFWPolicySku
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $SkuTierObject = 'Premium'                                              # Sets $SkuTierObject
                    Break SetAzureFWPolicySku                                               # Breaks :SetAzureFWPolicySku
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureFWPolicySku while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Building the firewall policy'                                   # Write message to screen   
                Write-Host 'This may take a moment'                                         # Write message to screen
                New-AzFirewallPolicy -Name $FWNameObject -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location -SkuTier `
                    $SkuTierObject -ErrorAction 'Stop' | Out-Null                           # Builds the firewall policy
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
                Break NewAzureFWPolicy                                                      # Breaks :NewAzureFWPolicy    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The firewall policy has been created'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureFWPolicy                                                          # Breaks :NewAzureFWPolicy
        }                                                                                   # End :NewAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzFWPolicy  