# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-6.2.1
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.2.1
    New-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewallPolicy:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewallpolicy?view=azps-6.2.1
    Get-AzFirewall:                             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azfirewall?view=azps-6.2.1
    Remove-AzFirewallPolicy:                    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azfirewallpolicy?view=azps-6.2.1
} #>
<# Required Functions Links: {
    NewAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/NewAzFWPolicy.ps1
    ListAzFWPolicy:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/ListAzFWPolicy.ps1
    RemoveAzFWPolicy:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/RemoveAzFWPolicy.ps1
    GetAzFWPolicy:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Firewalls/Firewall%20Policies/GetAzFWPolicy.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzFWPolicy:           Function to manage firewall policy
    NewAzFWPolicy:              Function to create a new firewall policy
    ListAzFWPolicy:             Function to list all firewall policies
    RemoveAzFWPolicy:           Function to remove a firewall policy
    GetAzFWPolicy:              Function to get a firewall policy
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :ManageAzureFWPolicy        Outer loop for managing function
    $OpSelect:                  Operator input to select management function
    NewAzFWPolicy{}             Creates $FWPolicyObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzFWPolicy{}            Lists $FWPolicyObject
    RemoveAzFWPolicy{}          Removes $FWPolicyObject
        GetAzFWPolicy{}             Gets $FWPolicyObject  
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
function ManageAzFWPolicy {                                                                 # Function to manage firewall policies
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicy while ($true) {                                                # Outer loop for managing function
            Write-Host 'Manage Firewall Policies'                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Policy'                                            # Write message to screen
            Write-Host '[2] List Firewall Policies'                                         # Write message to screen
            Write-Host '[3] Remove Firewall Policy'                                         # Write message to screen
            Write-Host '[4] Associate Firewall Policy'                                      # Write message to screen
            Write-Host '[5] Dissociate Firewall Policy'                                     # Write message to screen
            Write-Host '[6] Manage Policy Rule Collections'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicy                                                   # Breaks :ManageAzureFWPolicy
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Policy'                                            # Write message to screen
                NewAzFWPolicy                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Policies'                                         # Write message to screen
                ListAzFWPolicy                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Policy'                                         # Write message to screen
                RemoveAzFWPolicy                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Associate Firewall Policy'                                      # Write message to screen
                AssociateAzFWPolicy                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Dissociate Firewall Policy'                                     # Write message to screen
                DissociateAzFWPolicy                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5') 
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Policy Rule Collections'                                 # Write message to screen
                ManageAzFWPolicyRCG                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFWPolicy
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
function ListAzFWPolicy {                                                                   # Function to list all firewall policies
    Begin {                                                                                 # Begin function
        :ListAzureFWPolicy while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Gathering firewall policies'                                        # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicy                                                     # Breaks :ListAzureFWPolicy
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RCGList = @()                                                              # Creates $RCGList
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $RCGList += $RCGName                                                    # Adds $RCGName to $RCGList
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$FWPolicy.Name;                                                  # Policy name
                    'RG'=$FWPolicy.ResourceGroupName;                                       # Policy resource group name
                    'Location'=$FWPolicy.Location;                                          # Policy location
                    'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                            # Policy threat intel mode
                    'FWName'=$FirewallObject.Name;                                          # Firewall name
                    'RCGList'=$RCGList;                                                     # Rule collection group names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Policy Name:  '$_.Name                                          # Write message to screen
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:'$_.FWName                                    # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name: Not Assigned'                                # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host 'Policy RG:    '$_.RG                                            # Write message to screen
                Write-Host 'Policy Loc:   '$_.Location                                      # Write message to screen
                Write-Host 'Policy TIM:   '$_.ThreatIntelMode                               # Write message to screen
                if ($_.RCGList) {                                                           # If current item .RCGLust has a value
                    $RCGList = $_.RCGList                                                   # $RCGList is equal to current item.RCGList
                    Write-Host 'Policy RCG {'                                               # Write message to screen
                    foreach ($Name in $RCGList) {                                           # For each item in $RCGList
                        Write-Host '              '$Name                                    # Write message to screen
                    }                                                                       # End foreach ($Name in $RCGList)
                    Write-Host '           }'                                               # Write message to screen
                    $RCGList = $null                                                        # Clears $var
                }                                                                           # End if ($_.RCGList)
                else {                                                                      # Else if current item .RCGList is $null
                    Write-Host 'Policy RCG:    N/A'                                         # Write message to screen
                }                                                                           # End else (if ($_.RCGList))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Paues all actions for operator input
            Break ListAzureFWPolicy                                                         # Breaks :ListAzureFWPolicy
        }                                                                                   # End :ListAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPolicy
function GetAzFWPolicy {                                                                    # Function to get firewall policy
    Begin {                                                                                 # Begin function
        :GetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            Write-Host 'Gathering firewall policies'                                        # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicy                                                      # Breaks :GetAzureFWPolicy
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RCGList = @()                                                              # Creates $RCGList
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $RCGList += $RCGName                                                    # Adds $RCGName to $RCGList
                    $RCGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$FWPolicy.Name;                                                  # Policy name
                    'RG'=$FWPolicy.ResourceGroupName;                                       # Policy resource group name
                    'Location'=$FWPolicy.Location;                                          # Policy location
                    'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                            # Policy threat intel mode
                    'FWName'=$FirewallObject.Name;                                          # Firewall name
                    'RCGList'=$RCGList;                                                     # Rule collection group names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPolicy while ($true) {                                            # Inner loop for selecting the firewall policy
                Write-Host '[0]            Exit'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:'$_.FWName                                # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name: Not Assigned'                            # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host 'Policy RG:    '$_.RG                                        # Write message to screen
                    Write-Host 'Policy Loc:   '$_.Location                                  # Write message to screen
                    Write-Host 'Policy TIM:   '$_.ThreatIntelMode                           # Write message to screen
                    if ($_.RCGList) {                                                       # If current item .RCGList has a value
                        $RCGList = $_.RCGList                                               # $RCGList is equal to current item.RCGList
                        Write-Host 'Policy RCG {'                                           # Write message to screen
                        foreach ($Name in $RCGList) {                                       # For each item in $RCGList
                            Write-Host '              '$Name                                # Write message to screen
                        }                                                                   # End foreach ($Name in $RCGList)
                        Write-Host '           }'                                           # Write message to screen
                        $RCGList = $null                                                    # Clears $var
                    }                                                                       # End if ($_.RCGList)
                    else {                                                                  # Else if current item .RCGList is $null
                        Write-Host 'Policy RCG:    N/A'                                     # Write message to screen
                    }                                                                       # End else (if ($_.RCGList))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the firewall policy for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPolicy                                                  # Breaks :GetAzureFWPolicy
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    Return $FWPolicyObject                                                  # Returns to calling function with $FWPolicyObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPolicy while ($true)
        }                                                                                   # End :GetAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPolicy
function RemoveAzFWPolicy {                                                                 # Function to remove a firewall policy
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicy'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicy while ($true) {                                                # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject does not have a value
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy
            }                                                                               # End if (!$FWPolicyObject) 
            $FirewallObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            if ($FirewallObject) {                                                          # If $FirewallObject has a value
                $VNetName = $FirewallObject.IPConfigurations.Subnet.ID.Split('/')[8]        # Isolates the Vnet name
                Write-Host 'This policy is currently associated to the following'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Firewall:'$FirewallObject.name                                  # Write message to screen
                Write-Host 'VNet:    '$VNetName                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please dissociate this policy from the firewall'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy 
            }                                                                               # End if ($FirewallObject)
            Write-Host 'Remove Firewall Policy :'$FWPolicyObject.name                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall policy'                                   # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewallPolicy -ResourceId $FWPolicyObject.ID -Force `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the firewall policy
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureFWPolicy                                               # Breaks :RemoveAzureFWPolicy    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy has been removed'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicy                                                   # Breaks :RemoveAzureFWPolicy    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFWPolicy
function AssociateAzFWPolicy {                                                              # Function to associate a firewall policy to a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AssociateAzFWPolicy'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            $FWPolicyObject = GetAzFWPolicy ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FWPolicyObject) {                                                         # If $FWPolicyObject does not have a value
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject) 
            $CurrentFWObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            if ($CurrentFWObject) {                                                         # If $CurrentFWObject has a value
                $VNetName = $CurrentFWObject.IPConfigurations.Subnet.ID.Split('/')[8]       # Isolates the Vnet name
                Write-Host 'This policy is currently associated to the following'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Firewall:'$CurrentFWObject.name                                 # Write message to screen
                Write-Host 'VNet:    '$VNetName                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please dissociate this policy from the firewall'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen 
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy 
            }                                                                               # End if ($CurrentFWObject)
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject is $null
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject)
            Write-Host 'Update Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($FirewallObject.FirewallPolicy) {                                           # If $FirewallObject.FirewallPolicy has a value
                $CurrentPolicy = $FirewallObject.FirewallPolicy.ID.Split('/')[-1]           # Isolates the current policy name
                Write-Host 'Current Policy: '$CurrentPolicy                                 # Write message to screen
            }                                                                               # End if ($FirewallObject.FirewallPolicy)
            Write-Host 'New Policy:     '$FWPolicyObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Updating the firewall policy'                                   # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    if ($FirewallObject.FirewallPolicy.ID) {                                # If $FirewallObject.FirewallPolicy.ID has a value
                        $FirewallObject.FirewallPolicy.ID = $FWPolicyObject.ID              # Updates the firewall policy    
                    }                                                                       # End if ($FirewallObject.FirewallPolicy.ID)
                    else {                                                                  # Else if $FirewallObject.FirewallPolicy.ID is $null
                        $FirewallObject.FirewallPolicy = $FWPolicyObject.ID                 # Updates the firewall policy
                    }                                                                       # End else (if ($FirewallObject.FirewallPolicy.ID))
                    $FirewallObject | Set-AzFirewall -ErrorAction 'Stop' | Out-Null         # Saves the firewall config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureFWPolicy                                                  # Breaks :SetAzureFWPolicy    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy has been associated'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AssociateAzFWPolicy
function DissociateAzFWPolicy {                                                             # Function to dissociate a firewall policy to a firewall
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'DissociateAzFWPolicy'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureFWPolicy while ($true) {                                                   # Outer loop for managing function
            $FirewallObject = GetAzFirewall ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$FirewallObject) {                                                         # If $FirewallObject is $null
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy
            }                                                                               # End if (!$FirewallObject)
            if (!$FirewallObject.FirewallPolicy.ID) {                                       # If $FirewallObject.FirewallPolicy.ID is $null
                Write-Host 'There is no policy associated to this firewall'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End if (!$FirewallObject.FirewallPolicy.ID)
            Write-Host 'Update Firewall:'$FirewallObject.name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $CurrentPolicy = $FirewallObject.FirewallPolicy.ID.Split('/')[-1]               # Isolates the current policy name
            Write-Host 'Remove Policy:  '$CurrentPolicy                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Dissociating the firewall policy'                               # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    $FirewallObject.FirewallPolicy = $null                                  # Updates the firewall policy
                    $FirewallObject | Set-AzFirewall -ErrorAction 'Stop' | Out-Null         # Saves the firewall config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureFWPolicy                                                  # Breaks :SetAzureFWPolicy    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy has been dissociated'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureFWPolicy                                                      # Breaks :SetAzureFWPolicy    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureFWPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function DissociateAzFWPolicy
# Functions for ManageAzFWPolicyRCG
function ManageAzFWPolicyRCG {                                                              # Function to manage firewall policy Rule Collection groups
    Begin {                                                                                 # Begin function
        :ManageAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            Write-Host 'Manage Firewall Policy Rule Collection Groups'                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Firewall Policy RCG (In Dev)'                               # Write message to screen
            Write-Host '[2] List Firewall Policies RCG'                                     # Write message to screen
            Write-Host '[3] Remove Firewall Policy RCG'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureFWPolicyRCG                                                # Breaks :ManageAzureFWPolicyRCG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Firewall Policy RCG'                                        # Write message to screen
                #Functiongohere                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Firewall Policies RCG'                                     # Write message to screen
                ListAzFWPolicyRCG                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Firewall Policy'                                         # Write message to screen
                RemoveAzFWPolicyRCG                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzFWPolicyRCG
function ListAzFWPolicyRCG {                                                                # Function to list all firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :ListAzureFWPolicyRCG while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $FWPolicyRCG = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicy.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicy.Name                             # Gets the current item rule collection group object
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$FWPolicyRCG.Name;                                           # Policy RCG name
                        'Priority'=$FWPolicyRCG.Properties.Priority;                        # Policy RCG priority
                        'RuleColl'=$FWPolicyRCG.Properties.RuleCollection;                  # Policy RCG rule collection
                        'PolicyName'=$FWPolicy.Name;                                        # Policy name
                        'RG'=$FWPolicy.ResourceGroupName;                                   # Policy resource group name
                        'Location'=$FWPolicy.Location;                                      # Policy location
                        'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                        # Policy threat intel mode
                        'FWName'=$FirewallObject.Name;                                      # Firewall name
                        'RCGList'=$RCGList;                                                 # Rule collection group names
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collection groups exist'                # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureFWPolicyRCG                                                  # Breaks :ListAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'RCG Name:     '$_.Name                                          # Write message to screen
                Write-Host 'RCG Priority: '$_.Priority                                      # Write message to screen
                if ($_.RuleColl) {                                                          # If current item .RuleColl has a value
                    $RuleList = $_.RuleColl                                                 # $RuleList is equal to current item.RuleColl
                    Write-Host 'Rules        {'                                             # Write message to screen
                    foreach ($Name in $RuleList) {                                          # For each item in $RuleList
                        Write-Host '              '$Name.Name                               # Write message to screen
                    }                                                                       # End foreach ($Name in $RuleList)
                    Write-Host '             } '                                            # Write message to screen
                    $RuleList = $null                                                       # Clears $var
                }                                                                           # End if ($_.RuleColl)
                else {                                                                      # Else if current item .RuleColl is $null
                    Write-Host 'Rules:         None'                                        # Write message to screen
                }                                                                           # End else (if ($_.RuleColl))
                Write-Host 'Policy Name:  '$_.PolicyName                                    # Write message to screen
                Write-Host 'Policy RG:    '$_.RG                                            # Write message to screen
                Write-Host 'Policy Loc:   '$_.Location                                      # Write message to screen
                Write-Host 'Policy TIM:   '$_.ThreatIntelMode                               # Write message to screen                    
                if ($_.FWName) {                                                            # If current item .FWName has a value
                    Write-Host 'Firewall Name:'$_.FWName                                    # Write message to screen
                }                                                                           # End if ($_.FWName) 
                else {                                                                      # Else if current item .FWName is $null
                    Write-Host 'Firewall Name: Not Assigned'                                # Write message to screen
                }                                                                           # End else (if ($_.FWName))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureFWPolicyRCG                                                      # Breaks :ListAzureFWPolicyRCG
        }                                                                                   # End :ListAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzFWPolicyRCG
function RemoveAzFWPolicyRCG {                                                              # Function to remove a firewall policy rule collection group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzFWPolicyRCG'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureFWPolicyRCG while ($true) {                                             # Outer loop for managing function
            $FWPolicyRCGObject, $FWPolicyObject = GetAzFWPolicyRCG ($CallingFunction)       # Calls function and assigns output to $var
            if (!$FWPolicyRCGObject) {                                                      # If $FWPolicyRCGObject does not have a value
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG
            }                                                                               # End if (!$FWPolicyRCGObject) 
            $FirewallObject = Get-AzFirewall | Where-Object `
                {$_.FirewallPolicy.ID -eq $FWPolicyObject.ID}                               # Pulls the firewall object if attached
            Write-Host 'Remove Rule Collection Group:'$FWPolicyRCGObject.Name               # Write message to screen
            Write-Host 'From:'                                                              # Write message to screen
            Write-Host 'Firewall Policy:'$FWPolicyObject.name                               # Write message to screen
            if ($FirewallObject) {                                                          # If $FirewallObject has a value
                Write-Host 'Firewall Name:  '$FirewallObject.name                           # Write message to screen
                Write-Host 'VNet Name:      '$VNetName                                      # Write message to screen    
            }                                                                               # End if ($FirewallObject)
            else {                                                                          # Else if $FirewallObject is $null
                Write-Host 'Firewall Name:   N/A'                                           # Write message to screen
                Write-Host 'VNet Name:       N/A'                                           # Write message to screen        
            }                                                                               # End else (if ($FirewallObject))
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the firewall
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the firewall policy rule collection group'             # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzFirewallPolicyRuleCollectionGroup -Name `
                        $FWPolicyRCGObject.Name -ResourceGroupName `
                        $FWPolicyObject.ResourceGroupName -AzureFirewallPolicyName `
                        $FWPolicyObject.Name -Force -ErrorAction 'Stop' | Out-Null          # Removes the firewall policy rule collection group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureFWPolicyRCG                                            # Breaks :RemoveAzureFWPolicyRCG    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The firewall policy rule collection group has been removed'     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureFWPolicyRCG                                                # Breaks :RemoveAzureFWPolicyRCG    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzFWPolicyRCG
function GetAzFWPolicyRCG {                                                                 # Function to get firewall policy rule collection group
    Begin {                                                                                 # Begin function
        :GetAzureFWPolicyRCG while ($true) {                                                # Outer loop for managing function
            Write-Host 'Gathering firewall policy rule collection groups'                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/firewallPolicies'}                  # Gets a list of all resources with a type 'FirewallPolicies'
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No firewall policies exist in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $FWPolicy = Get-AzFirewallPolicy -ResourceId $_.ResourceID                  # Pulls the full firewall policy
                $FirewallObject = Get-AzFirewall | Where-Object `
                    {$_.FirewallPolicy.ID -eq $FWPolicy.ID}                                 # Pulls the firewall object if attached
                $RuleCollectGroups = $FWPolicy.RuleCollectionGroups                         # Isolates the rule collection groups
                foreach ($ID in $RuleCollectGroups) {                                       # For each item in $RuleCollectGroups
                    $RCGName = $ID.ID.Split('/')[-1]                                        # Isolates the current item name
                    $FWPolicyRCG = Get-AzFirewallPolicyRuleCollectionGroup -Name $RCGName `
                        -ResourceGroupName $FWPolicy.ResourceGroupName `
                        -AzureFirewallPolicyName $FWPolicy.Name                             # Gets the current item rule collection group object
                    $ObjectInput = [PSCustomObject]@{                                       # custom object to add info to $ObjectArray
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$FWPolicyRCG.Name;                                           # Policy RCG name
                        'Priority'=$FWPolicyRCG.Properties.Priority;                        # Policy RCG priority
                        'RuleColl'=$FWPolicyRCG.Properties.RuleCollection;                  # Policy RCG rule collection
                        'PolicyName'=$FWPolicy.Name;                                        # Policy name
                        'RG'=$FWPolicy.ResourceGroupName;                                   # Policy resource group name
                        'Location'=$FWPolicy.Location;                                      # Policy location
                        'ThreatIntelMode'=$FWPolicy.ThreatIntelMode;                        # Policy threat intel mode
                        'FWName'=$FirewallObject.Name;                                      # Firewall name
                        'RCGList'=$RCGList;                                                 # Rule collection group names
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                    $RCGName = $null                                                        # Clears $var
                    $FWPolicyRCG = $null                                                    # Clears $var
                }                                                                           # End foreach ($ID in $RuleCollectGroups)
                $FWPolicy = $null                                                           # Clears $var
                $FirewallObject = $null                                                     # Clears $var
                $RCGList = $null                                                            # Clears $var
                $RuleCollectGroups = $null                                                  # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No firewall policy rule collection groups exist'                # Write messag to screen
                Write-Host ''                                                               # Write messag to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureFWPolicyRCG                                                   # Breaks :GetAzureFWPolicyRCG
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            :SelectAzureFWPolicyRCG while ($true) {                                         # Inner loop for selecting the firewall policy rule collection group
                Write-Host '[0]            Exit'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RCG Priority: '$_.Priority                                  # Write message to screen
                    if ($_.RuleColl) {                                                      # If current item .RuleColl has a value
                        $RuleList = $_.RuleColl                                             # $RuleList is equal to current item.RuleColl
                        Write-Host 'Rules        {'                                         # Write message to screen
                        foreach ($Name in $RuleList) {                                      # For each item in $RuleList
                            Write-Host '              '$Name.Name                           # Write message to screen
                        }                                                                   # End foreach ($Name in $RuleList)
                        Write-Host '             } '                                        # Write message to screen
                        $RuleList = $null                                                   # Clears $var
                    }                                                                       # End if ($_.RuleColl)
                    else {                                                                  # Else if current item .RuleColl is $null
                        Write-Host 'Rules:         None'                                    # Write message to screen
                    }                                                                       # End else (if ($_.RuleColl))
                    Write-Host 'Policy Name:  '$_.PolicyName                                # Write message to screen
                    Write-Host 'Policy RG:    '$_.RG                                        # Write message to screen
                    Write-Host 'Policy Loc:   '$_.Location                                  # Write message to screen
                    Write-Host 'Policy TIM:   '$_.ThreatIntelMode                           # Write message to screen                    
                    if ($_.FWName) {                                                        # If current item .FWName has a value
                        Write-Host 'Firewall Name:'$_.FWName                                # Write message to screen
                    }                                                                       # End if ($_.FWName) 
                    else {                                                                  # Else if current item .FWName is $null
                        Write-Host 'Firewall Name: Not Assigned'                            # Write message to screen
                    }                                                                       # End else (if ($_.FWName))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the firewall policy RCG for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the firewall policy
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureFWPolicyRCG                                               # Breaks :GetAzureFWPolicyRCG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $FWPolicyRCGObject = Get-AzFirewallPolicyRuleCollectionGroup -Name `
                        $OpSelect.Name -ResourceGroupName $OpSelect.RG `
                        -AzureFirewallPolicyName $OpSelect.PolicyName                       # Pulls the full policy rule collection group object
                    $FWPolicyObject = Get-AzFirewallPolicy -Name $OpSelect.PolicyName `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full policy object
                    Return $FWPolicyRCGObject, $FWPolicyObject                              # Returns to calling function with $FWPolicyRCGObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureFWPolicyRCG while ($true)
        }                                                                                   # End :GetAzureFWPolicyRCG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzFWPolicyRCG
# End ManageAzFWPolicyRCG