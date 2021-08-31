# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/new-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
    Remove-AzApplicationSecurityGroup:          https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azapplicationsecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    NewAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/NewAzASG.ps1
    ListAzASG:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/ListAzASG.ps1
    GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/GetAzASG.ps1
    RemoveAzASG:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/RemoveAzASG.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzASG:                Function for managing application security groups
    NewAzASG:                   Function to create a application security group
    ListAzASG:                  Function to list all application security groups
    GetAzASG:                   Function to get an application security group
    RemoveAzASG:                Function to remove an application security group
    GetAzResourceGroup:         Function to get a resource group
} #>
<# Variables: {      
    :ManageAzureASG             Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    NewAzASG{}                  Creates $ASGObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzASG{}                 Lists $ASGObject
    RemoveAzASG{}               Removes $ASGObject
        GetAzASG{}                  Gets $ASGObject
} #>
<# Process Flow {
    ManageAzASG
        NewAzASG
            GetAzResourceGroup > Get $RGObject
        ListAzASG
        RemoveAzASG
            GetAzASG > Get $ASGObject
    
}#>
function ManageAzASG {                                                                      # Function for managing application security groups
    Begin {                                                                                 # Begin function
        :ManageAzureASG while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Manage Application Security Groups'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Application Security Group'                                 # Write message to screen
            Write-Host '[2] List Application Security Groups'                               # Write message to screen
            Write-Host '[3] Remove Application Security Group'                              # Write message to screen
            Write-Host '[4] Manage NIC ASG Associations'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureASG                                                        # Breaks :ManageAzureASG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Application Security Group'                                 # Write message to screen
                NewAzASG                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Application Security Groups'                               # Write message to screen
                ListAzASG                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Application Security Group'                              # Write message to screen
                RemoveAzASG                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage NIC ASG Associations'                                    # Write message to screen
                ManageAzASGNIC                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzASG
function NewAzASG {                                                                         # Function to create a application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzASG'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureASG while ($true) {                                                        # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null 
                Break NewAzureASG                                                           # Breaks :NewAzureASG
            }                                                                               # End if (!$RGObject)
            $CurrentASGList = Get-AzApplicationSecurityGroup -ResourceGroupName `
                $RGObject.ResourceGroupName                                                 # Gets list of all existing application security groups on $RGObject
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureASGName while ($true) {                                                # Inner loop for setting the ASG name
                Write-Host 'The application security group name must meet the following'    # Write message to screen
                Write-Host 'Begin with letter or number'                                    # Write message to screen
                Write-Host 'End with a letter, number, or "_"'                              # Write message to screen
                Write-Host 'Contain only numbers, letters, or "- . _ "'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($CurrentASGList) {                                                      # If $CurrentASGList has a value
                    Write-Host 'The following names are already in use'                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $CurrentASGList) {                                       # For each item in $CurrentASGList
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $CurrentASGList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CurrentASGList)
                $ASGName = Read-Host 'ASG name'                                             # Operator input for the ASG name
                Clear-Host                                                                  # Clears screen
                if ($ASGName -in $CurrentASGList.Name) {                                    # If $ASGName is in $CurrentASGList.Name
                    Write-Host $ASGName' is already in use'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End if ($ASGName -in $CurrentASGList.Name)
                if ($ASGName) {                                                             # If $ASGName has a value
                    $NameArray = $ASGName.ToCharArray()                                     # Converts $NameArray to array
                    if ($NameArray[0] -notin $Valid1stChar) {                               # If 0 position of $NameArray is not in $Valid1stChar
                        Write-Host 'The first character of the name'                        # Write message to screen
                        Write-Host 'must be a letter or number'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End if ($NameArray[0] -notin $Valid1stChar)
                    if ($NameArray[-1] -notin $ValidLastChar) {                             # If last position of $NameArray is not in $ValidLastChar
                        Write-Host 'The last character of the '                             # Write message to screen
                        Write-Host 'name must be a letter, number or _ '                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End if ($NameArray[0] -notin $Valid1stChar)
                    foreach ($_ in $NameArray) {                                            # For each item in $NameArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            if ($_ -eq ' ') {                                               # If current item equals 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host 'ASG name cannot include any spaces'             # Write message to screen
                            }                                                               # End if ($_ -eq ' ')
                            else {                                                          # If current item is not equal to 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host $_' is not a valid character'                    # Write message to screen
                            }                                                               # End else (if ($_ -eq ' '))
                            $ASGName = $null                                                # Clears $ASGName
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $NameArray)
                    $NameArray = $null                                                      # Clears $var
                }                                                                           # End if ($ASGName)
                if ($ASGName) {                                                             # If $ASGName has a value
                    Write-Host 'Use:'$ASGName' as the ASG name'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the ASG name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpSelect equals 'e'
                        Break NewAzureASG                                                   # Breaks :NewAzureASG
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureASGName                                               # Breaks :SetAzureASGName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'n') {                                           # Else if $OpConfirm equals 'n'    
                        $ASGName = $null                                                    # Clears $ASGName
                    }                                                                       # End elseif ($OpConfirm -eq 'n')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfirm -eq 'e') )
                }                                                                           # End if ($ASGName)
                else {                                                                      # If $ASGName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ASGName))
            }                                                                               # End :SetAzureASGName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the app security group'                                # Write message to screen
                New-AzApplicationSecurityGroup -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location `
                    -Name $ASGName -ErrorAction 'Stop' | Out-null
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureASG                                                           # Breaks :NewAzureASG
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The application security group has been made'                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureASG                                                               # Breaks :NewAzureASG
        }                                                                                   # End :NewAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzASG
function ListAzASG {                                                                        # Function to list all application security groups
    Begin {                                                                                 # Begin function
        :ListAzureASG while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureASG                                                          # Breaks :ListAzureASG
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $NSGList = Get-AzNetworkSecurityGroup | Where-Object `
                    {$_.SecurityRules.SourceApplicationSecurityGroups.ID -eq $ASGID -or `
                    $_.SecurityRules.DestinationApplicationSecurityGroups.ID -eq $ASGID}    # Gets a list of all NSGs in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NicNames'=$NICList.Name;                                               # Nic names
                    'NSGNames'=$NSGList.Name                                                # NSG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
                $NSGList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'ASG Name:       '$_.Name                                        # Write message to screen
                Write-Host 'ASG RG:         '$_.RG                                          # Write message to screen
                Write-Host 'ASG Loc:        '$_.Location                                    # Write message to screen
                if ($_.NicNames) {                                                          # If current item .NicNames has a value
                    Write-Host 'Associated NICS:'$_.NicNames                                # Write message to screen
                }                                                                           # End if ($_.NicNames)
                else {                                                                      # Else if current item .NicNames is $null
                    Write-Host 'Associated NICS: N/A'                                       # Write message to screen
                }                                                                           # End else (if ($_.NicNames))
                if ($_.NSGNames) {                                                          # If current item .NSGNames has a value
                    Write-Host 'Associated NSGs:'$_.NSGNames                                # Write message to screen
                }                                                                           # End if ($_.NSGNames)
                else {                                                                      # Else if current item .NSGNames is $null
                    Write-Host 'Associated NSGs: N/A'                                       # Write message to screen
                }                                                                           # End else (if ($_.NSGNames))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureASG                                                              # Breaks :ListAzureASG
        }                                                                                   # End :ListAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzASG
function GetAzASG {                                                                         # Function to get an application security group
    Begin {                                                                                 # Begin function
        :GetAzureASG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering application security group info'                          # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzApplicationSecurityGroup                                    # Gets a list of all application security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASG                                                           # Breaks :GetAzureASG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGID = $_.ID                                                              # $ASGID is equal to current item .ID
                $NICList = Get-AzNetworkInterface | Where-Object `
                    {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGID}           # Gets a list of nics in $ASGID
                $NSGList = Get-AzNetworkSecurityGroup | Where-Object `
                    {$_.SecurityRules.SourceApplicationSecurityGroups.ID -eq $ASGID -or `
                    $_.SecurityRules.DestinationApplicationSecurityGroups.ID -eq $ASGID}    # Gets a list of all NSGs in $ASGID
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NicNames'=$NICList.Name;                                               # Nic names
                    'NSGNames'=$NSGList.Name                                                # NSG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
                $NSGList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the application security group
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'ASG RG:         '$_.RG                                      # Write message to screen
                    Write-Host 'ASG Loc:        '$_.Location                                # Write message to screen
                    if ($_.NicNames) {                                                      # If current item .NicNames has a value
                        Write-Host 'Associated NICs:'$_.NicNames                            # Write message to screen
                    }                                                                       # End if ($_.NicNames)
                    else {                                                                  # Else if current item .NicNames is $null
                        Write-Host 'Associated NICs: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NicNames))
                    if ($_.NSGNames) {                                                      # If current item .NSGNames has a value
                        Write-Host 'Associated NSGs:'$_.NSGNames                            # Write message to screen
                    }                                                                       # End if ($_.NSGNames)
                    else {                                                                  # Else if current item .NSGNames is $null
                        Write-Host 'Associated NSGs: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NSGNames))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the app security group for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $ASGObject = Get-AzApplicationSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full application security group object
                    Return $ASGObject                                                       # Returns to calling function with application security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
        }                                                                                   # End :GetAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzASG
function RemoveAzASG {                                                                      # Function to remove an application security group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzASG'                                                # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureASG while ($true) {                                                     # Outer loop for managing function
            $ASGObject = GetAzASG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$ASGObject) {                                                              # If $ASGObject does not have a value
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG
            }                                                                               # End if (!$ASGObject)
            $AttachedNics = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGObject.ID}        # Gets a list of attached NICs to $ASGObject
            $AttachedNSGs = Get-AzNetworkSecurityGroup | Where-Object `
                {$_.SecurityRules.SourceApplicationSecurityGroups.ID -eq $ASGObject.ID -or `
                $_.SecurityRules.DestinationApplicationSecurityGroups.ID -eq $ASGObject.ID} # Gets a list of all NSGs in $ASGID
            if ($AttachedNics) {                                                            # If $AttachedNics has a value
                Write-Host 'The following NICs have configs referencing'                    # Write message to screen
                Write-Host 'this Application Security Group:'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $AttachedNics) {                                             # For each item in $AttachedNics
                    Write-Host $_.Name                                                      # Write message to screen
                }                                                                           # End foreach ($_ in $AttachedNics)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The ASG will need to be removed from the'                       # Write message to screen
                Write-Host 'IP configurations before it can be deleted'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End if ($AttachedNSGs)
            if ($AttachedNSGs) {                                                            # If $AttachedNSGs has a value
                Write-Host 'The following NSGs have rules referencing'                      # Write message to screen
                Write-Host 'this Application Security Group:'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $AttachedNSGs) {                                             # For each item in $AttachedNSGs
                    Write-Host $_.Name                                                      # Write message to screen
                }                                                                           # End foreach ($_ in $AttachedNSGs)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The ASG will need to be removed from the'                       # Write message to screen
                Write-Host 'NSG rules before it can be deleted'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End if ($AttachedNSGs)
            Write-Host 'Remove ASG:'$ASGObject.name                                         # Write message to screen
            Write-Host 'From RG:   '$ASGObject.ResourceGroupName                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the ASG
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the application security group'                        # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzApplicationSecurityGroup -ResourceGroupName `
                        $ASGObject.ResourceGroupName -Name $ASGObject.Name `
                        -Force -ErrorAction 'Stop' | Out-Null                               # Removes the application security group
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureASG                                                    # Breaks :RemoveAzureASG    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The application security group has been removed'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASG                                                        # Breaks :RemoveAzureASG    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureASG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzASG
# Functions for ManageAzASGNIC
function ManageAzASGNIC {                                                                   # Function for managing application security group NIC associations
    Begin {                                                                                 # Begin function
        :ManageAzureASGNic while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Manage Application Security Group NIC Associations'                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New ASG NIC Association'                                        # Write message to screen
            Write-Host '[2] List ASG NIC Associations'                                      # Write message to screen
            Write-Host '[3] Remove ASG NIC Association'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureASGNic                                                     # Breaks :ManageAzureASGNic
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New ASG NIC Association'                                        # Write message to screen
                AddAzASGNIC                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List ASG NIC Associations'                                      # Write message to screen
                ListAzASGNIC                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove ASG NIC Association'                                     # Write message to screen
                RemoveAzASGNIC                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureASGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzASGNIC
function AddAzASGNIC {                                                                      # Function to add an application security group to nic
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzASGNIC'                                                # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureASGNIC while ($true) {                                                     # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureASGNIC                                                        # Breaks :AddAzureASGNIC
            }                                                                               # End if (!$NicIPConfigObject)
            $ObjectList = $NicObject.IpConfigurations.ApplicationSecurityGroups.ID          # Isolates all asg IDs to $var
            $ASGObject = GetAzASG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$ASGObject) {                                                              # If $ASGObject is $null
                Break AddAzureASGNIC                                                        # Breaks :AddAzureASGNIC
            }                                                                               # End if (!$ASGObject)
            $ASGNICList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID -eq $ASGObject.ID}        # Gets a list of all nics on ASGObject
            if ($ASGNICList) {                                                              # If $ASGNICList has a value
                $ASGVNet = $ASGNICList.IpConfigurations.subnet.ID.split('/')[8]             # Isolates the ASG NIC vnet name
                $NICVnet = $VnetObject.ID.Split('/')[-1]                                    # Isolates the NIC vnet name
                if ($ASGVNet -ne $NICVnet) {                                                # If $ASGVnet does not equal $NICVnet
                    Write-Host 'This NIC is in a different VNet'                            # Write message to screen
                    Write-Host 'then other NICs currently associated'                       # Write message to screen
                    Write-Host 'with the application security group'                        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input    
                    Break AddAzureASGNIC                                                    # Breaks :AddAzureASGNIC
                }
            }
            $AppendedObjectList = @()                                                       # Creates $AppendedObjectList
            $AppendedObjectList += $ASGObject.ID                                            # Adds $ASGObject.ID to $AppendedObjectList
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_ -ne $ASGObject.ID) {                                                 # If current item is not equal to $ASGObject.ID
                    $AppendedObjectList += $_                                               # Add current item to $AppendedObjectList
                }                                                                           # End if ($_ -ne $ASGObject.ID) 
            }                                                                               # End foreach ($_ in $ObjectList)
            $AppendedObjectList = $AppendedObjectList | Select-Object -Unique               # Removes duplicates from $AppendedObjectList
            Write-Host 'Save the following application security groups:'                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $AppendedObjectList) {                                           # For each item in $AppendedObjectList
                Write-Host $_                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $AppendedObjectList)
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To all IP configs on:'$NicObject.name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC IP configs'                                # Write message to screen
                    $NICIPConfigs = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -ErrorAction 'Stop'                                      # Gets a list of all IP configs on $NICObject
                    foreach ($_ in $NICIPConfigs) {
                        Set-AzNetworkInterfaceIpConfig -NetworkInterface $NicObject -Name `
                            $_.Name -ApplicationSecurityGroupId `
                            $AppendedObjectList -ErrorAction 'Stop' | Out-Null              # Updates the application security group listing
                    }                                                                       # End foreach ($_ in $NICIPConfigs)
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null      # Saves the nic config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureASGNIC                                                    # Breaks :AddAzureASGNIC
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The ASG has been added to the IP configs'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureASGNIC                                                        # Breaks :AddAzureASGNIC
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureASGNIC                                                        # Breaks :AddAzureASGNIC
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :AddAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzASGNIC
function ListAzASGNIC {                                                                     # Function to list NICs with an application security group 
    Begin {                                                                                 # Begin function
        :ListAzureASGNIC while ($true) {                                                    # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID}                          # Gets a list of all network interfaces with an application security group
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network interfaces present with'                             # Write message to screen
                Write-Host 'application security groups attached'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureASGNIC                                                       # Breaks :ListAzureASGNIC
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGNames = @()                                                             # Creates $ASGNamesArray
                $ASGIDList = $_.IPConfigurations.ApplicationSecurityGroups.ID               # Isolates the application security group names
                foreach ($ID in $ASGIDList) {                                               # For each item in $ASGIDList
                    $ASGName = $ID                                                          # ASGName is equal to current item
                    $ASGName = $ASGName.Split('/')[-1]                                      # Isolates the ASG name
                    $ASGNames += $ASGName                                                   # Adds $ASGName to $ASGNames
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $ASGIDList)
                $ASGNames = $ASGNames | Select-Object -Unique | Sort-Object                 # Removes duplcate items from $ASGNames
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'NicName'=$_.Name;                                                      # Nic name
                    'NICRG'=$_.ResourceGroupName;                                           # Nic RG
                    'IPConCount'=$_.IPConfigurations.Count;                                 # IP configurations count
                    'ASGNames'=$ASGNames                                                    # ASG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGNames = $null                                                           # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'NIC Name:'$_.NicName                                            # Write message to screen
                $ASGList = $_.ASGNames                                                      # ASGList is equal to current item .ASGNames
                foreach ($Name in $ASGList) {                                               # For each item in $ASGList
                    Write-Host 'ASG Name:'$Name                                             # Write message to screen
                }                                                                           # End foreach ($Name in $ASGList)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureASGNIC                                                           # Breaks :ListAzureASGNIC
        }                                                                                   # End :ListAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzASGNIC
function GetAzASGNIC {                                                                      # Function to get a nic with an ASG attached
    Begin {                                                                                 # Begin function
        :GetAzureASGNIC while ($true) {                                                     # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.ApplicationSecurityGroups.ID}                          # Gets a list of all network interfaces with an application security group
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network interfaces present with'                             # Write message to screen
                Write-Host 'application security groups attached'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureASGNIC                                                        # Breaks :GetAzureASGNIC
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGNames = @()                                                             # Creates $ASGNamesArray
                $ASGIDList = $_.IPConfigurations.ApplicationSecurityGroups.ID               # Isolates the application security group names
                foreach ($ID in $ASGIDList) {                                               # For each item in $ASGIDList
                    $ASGName = $ID                                                          # ASGName is equal to current item
                    $ASGName = $ASGName.Split('/')[-1]                                      # Isolates the ASG name
                    $ASGNames += $ASGName                                                   # Adds $ASGName to $ASGNames
                    $ASGName = $null                                                        # Clears $var
                }                                                                           # End foreach ($ID in $ASGIDList)
                $ASGNames = $ASGNames | Select-Object -Unique | Sort-Object                 # Removes duplcate items from $ASGNames
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'NicName'=$_.Name;                                                      # Nic name
                    'NICRG'=$_.ResourceGroupName;                                           # Nic RG
                    'IPConCount'=$_.IPConfigurations.Count;                                 # IP configurations count
                    'ASGNames'=$ASGNames                                                    # ASG names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGNames = $null                                                           # Clears $var
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureASGNIC while ($true) {                                              # Inner loop for selecting the nic object
                Write-Host '[0]       Exit'                                                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.NicName                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]     "$_.NicName                               # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    $ASGList = $_.ASGNames                                                  # ASGList is equal to current item .ASGNames
                    foreach ($Name in $ASGList) {                                           # For each item in $ASGList
                        Write-Host 'ASG Name:'$Name                                         # Write message to screen
                    }                                                                       # End foreach ($Name in $ASGList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the NIC for:'$CallingFunction             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the application security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureASG                                                       # Breaks :GetAzureASG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                        -ResourceGroupName $OpSelect.NicRG                                  # Pulls the full nic object
                    Return $NicObject                                                       # Returns to calling function with $NicObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureASGNIC while ($true)
        }                                                                                   # End :GetAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzASGNIC
function RemoveAzASGNIC {                                                                   # Function to remove an application security group from a nic
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzASGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureASGNIC while ($true) {                                                  # Outer loop for managing function
            $NicObject = GetAzASGNIC ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if (!$NicObject)
            $ObjectList = $NicObject.IPConfigurations.ApplicationSecurityGroups.ID          # Isolates all asg IDs to $var
            $ObjectList2 = @()                                                              # Creates $ObjectList2 array
            foreach ($_ in $Objectlist) {                                                   # For each item in $ObjectList
                $Objectlist2 += $_                                                          # Adds current item to $ObjectList2
            }                                                                               # End foreach ($_ in $Objectlist)
            $Objectlist = $ObjectList2 | Select-Object -Unique | Sort-Object                # $ObjectList is equal to $ObjectList2 only unique entries
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ASGName = $_                                                               # Isloates the current item
                $ASGName =$ASGName.split('/')[-1]                                           # Isolates the current item ASG name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber                                                  # Object number
                    'ID'=$_                                                                 # ID
                    'Name'=$ASGName                                                         # ASG name
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGName = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureASG while ($true) {                                                 # Inner loop for selecting the ASG to remove
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]  "$_.Name                                     # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is greater than 9
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection to remove the ASG
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break RemoveAzureASGNIC                                                 # Breaks :RemoveAzureASGNIC
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Number
                    $ASGObject = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}      # ASGObject = $ObjectArray where $ObjectArray.Number equals $OpSelect
                    Break SelectAzureASG                                                    # Breaks :SelectAzureASG
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureASG while ($true)
            $AppendedObjectList = @()                                                       # Creates $AppendedObjectList
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_ -ne $ASGObject.ID) {                                                 # If current item is not equal to $ASGObject.ID
                    $AppendedObjectList += $_                                               # Add current item to $AppendedObjectList
                }                                                                           # End if ($_ -ne $ASGObject.ID) 
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host 'Remove:'$ASGObject.ID.split('/')[-1]                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($AppendedObjectList) {                                                      # If $AppendedObjectList has a value
                Write-Host 'Keep:'                                                          # Write message to screen
                foreach ($_ in $AppendedObjectList) {                                       # For each item in $AppendedObjectList
                    Write-Host '       '$_.split('/')[-1]                                   # Write message to screen
                }                                                                           # End foreach ($_ in $AppendedObjectList)
            }                                                                               # End if ($AppendedObjectList)
            else {                                                                          # Else if $AppendedObjectList is $null
                Write-Host 'Keep:   None'                                                   # Write message to screen
            }                                                                               # End else (if ($AppendedObjectList))
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC IP configs'                                # Write message to screen
                    $NICIPConfigs = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -ErrorAction 'Stop'                                      # Gets a list of all IP configs on $NICObject
                    foreach ($_ in $NICIPConfigs) {
                        Set-AzNetworkInterfaceIpConfig -NetworkInterface $NicObject -Name `
                            $_.Name -ApplicationSecurityGroupId `
                            $AppendedObjectList -ErrorAction 'Stop' | Out-Null              # Updates the application security group listing
                    }                                                                       # End foreach ($_ in $NICIPConfigs)
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null      # Saves the nic config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureASGNIC                                                 # Breaks :RemoveAzureASGNIC
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The ASG has been removed from the NIC IP configs'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureASGNIC                                                     # Breaks :RemoveAzureASGNIC
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureASGNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzASGNIC
# End ManageAzASGNIC
# Additional functions required for ManageAzASG
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            Write-Host 'Gathering network interfaces'                                       # Write message to screen
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No Nics are present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$ObjectList)
            else {                                                                          # If $ObjectList has a value
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $NICName = $_.Name                                                      # $NICName is equal to current item .Name
                    $NicRG = $_.ResourceGroupName                                           # Gets the NIC resource group
                    $NicVM = $_.VirtualMachine.ID                                           # Gets the NIC VM if attached
                    $NicNSG = $_.NetworkSecurityGroup.ID                                    # Gets the NIC NSG if attached
                    if ($NicVM) {                                                           # If $NicVM has a value 
                        $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}              # Gets the currently attached VM
                    }                                                                       # End if ($NicVM)
                    if ($NicNSG) {                                                          # If $NicNSG has a value
                        $NSGObject = Get-AzNetworkSecurityGroup | Where-Object `
                            {$_.ID -eq $NicNSG}                                             # Gets the currently attached NSG
                    }                                                                       # End if ($NicNSG)
                    $IPConfigList = $_.IPConfigurations                                     # IPConfigList is equal to current item .IPConfigurations
                    foreach ($_ in $IPConfigList) {                                         # For each item in $IPConfigList
                        $ASGName = @()                                                      # Creates ASGName array
                        if ($_.ApplicationSecurityGroups.ID) {                              # If current item .ApplicationSecurityGroups.ID has a value
                            $ASGID = $_.ApplicationSecurityGroups.ID                        # Isolates the ASG IDs
                            foreach ($ID in $ASGID) {                                       # For each item in $ASGID
                                $ASGIDSplit = $ID                                           # ASGID is equal to current item
                                $ASGIDSplit = $ASGIDSplit.Split('/')[-1]                    # Isolates the ASG name
                                $ASGName += $ASGIDSplit                                     # Adds ASGIDSplit to $ASGName
                                $ASGIDSplit = $null                                         # Clears $var                      
                            }                                                               # End foreach ($_ in $ASGID)
                            $ASGID = $null                                                  # Clears $var
                        }                                                                   # End if ($_.ApplicationSecurityGroups.ID)                                                                
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput            
                            'Number'=$ObjectNumber;                                         # Array item number
                            'Name'=$_.Name;                                                 # Nic IP config name
                            'PrivIP'=$_.PrivateIPAddress;                                   # Nic IP config private IP address
                            'PrivIPAllo'=$_.PrivateIpAllocationMethod;                      # Nic IP config private IP allocation method
                            'PubIP'=$_.PublicIPAddress;                                     # Nic IP config public IP address
                            'Pri'=$_.Primary;                                               # Nic IP config primary status
                            'NICName'=$NICName;                                             # Nic name
                            'NICRG'=$NicRG;                                                 # Nic RG name
                            'NICVM'=$VMObject.Name;                                         # Nic VM name
                            'NICNSG'=$NSGObject.Name;                                       # Nic NSG name
                            'NICASG'=$ASGName                                               # Nic IP config ASGs
                        }                                                                   # End $ObjectInput = [PSCustomObject]
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber +1                                    # Increments $ObjectNumber up by 1
                        $ASGName = $null                                                    # Clears $var
                    }                                                                       # End foreach ($_ in $IPConfigList)
                    $NICName = $null                                                        # Clears $var
                    $NicRG = $null                                                          # Clears $var
                    $NicVM = $null                                                          # Clears $var
                    $VMObject = $null                                                       # Clears $var
                    $NicNSG = $null                                                         # Clears $var
                    $NSGObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End else (if (!$ObjectList))
            Write-Host 'Gathering scale set interfaces'                                     # Write message to screen
            $VmssObject = Get-AzVmss                                                        # Gets a list of Vmss objects if present
            if ($VmssObject) {                                                              # If $VmssObject has a value
                foreach ($_ in $VmssObject) {                                               # For each item in $VmssObject
                    Write-Host 'Gathering NICs on:'$_.name                                  # Writ message to screen
                    $VmssName = $_.name                                                     # Isloates the Vmss name
                    $VmssRG = $_.ResourceGroupName                                          # Isolates the Vmss resource group
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $VmssName -ResourceGroupName $VmssRG                                # Gets a list of nics attached to current vmss object
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $NicName = $_.Name                                                  # $NicName is equal to current item .Name
                        $NicRG = $_.ResourceGroupName                                       # $NicRG is equal to current item .ResourceGroupName
                        $NicNSG = $_.NetworkSecurityGroup.ID                                # Gets the NIC NSG if attached
                        if ($NicNSG) {                                                      # If $NicNSG has a value
                            $NSGObject = Get-AzNetworkSecurityGroup | Where-Object `
                                {$_.ID -eq $NicNSG}                                         # Gets the currently attached NSG
                        }                                                                   # End if ($NicNSG)    
                        $IPConfigList = $_.IPConfigurations                                 # IPConfigList is equal to current item .IPConfigurations
                        foreach ($_ in $IPConfigList) {                                     # For each item in $IPConfigList
                            $ASGName = @()                                                  # Creates ASGName array
                            if ($_.ApplicationSecurityGroups.ID) {                          # If current item .ApplicationSecurityGroups.ID has a value
                                $ASGID = $_.ApplicationSecurityGroups.ID                    # Isolates the ASG IDs
                                foreach ($ID in $ASGID) {                                   # For each item in $ASGID
                                    $ASGIDSplit = $ID                                       # ASGID is equal to current item
                                    $ASGIDSplit = $ASGIDSplit.Split('/')[-1]                # Isolates the ASG name
                                    $ASGName += $ASGIDSplit                                 # Adds ASGIDSplit to $ASGName
                                    $ASGIDSplit = $null                                     # Clears $var                      
                                }                                                           # End foreach ($_ in $ASGID)
                                $ASGID = $null                                              # Clears $var
                            }                                                               # End if ($_.ApplicationSecurityGroups.ID)                                                                
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput            
                                'Number'=$ObjectNumber;                                     # Array number
                                'Name'=$_.Name;                                             # Nic IP config name
                                'PrivIP'=$_.PrivateIPAddress;                               # Nic IP config private IP address
                                'PrivIPAllo'=$_.PrivateIpAllocationMethod;                  # Nic IP config private allocation method
                                'PubIP'=$_.PublicIPAddress;                                 # Nic IP config public IP
                                'Pri'=$_.Primary;                                           # Nic IP config primary status
                                'NICName'=$NICName;                                         # Nic name
                                'NICRG'=$NicRG;                                             # Nic rg name
                                'Type'='ScaleSetNic';                                       # Nic IP config type
                                'VmssName'=$VmssName;                                       # Vmss Name
                                'VmssRG'=$VmssRG;                                           # Vmss RG
                                'Etag'=$_.Etag;                                             # Nic IP config Etag
                                'NICNSG'=$NSGObject.Name;                                   # Nic NSG name
                                'NICASG'=$ASGName                                           # Nic IP config ASGs
                            }                                                               # End $ObjectInput = [PSCustomObject]
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                            $ObjectNumber = $ObjectNumber +1                                # Increments $ObjectNumber up by 1
                            $ASGName = $null                                                # Clears $var
                        }                                                                   # End foreach ($_ in $IPConfigList)
                        $NicName = $null                                                    # Clears $var
                        $NicRG = $null                                                      # Clears $var
                        $NicNSG = $null                                                     # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            else {                                                                          # If $VmssObject is $null
                Clear-Host 'No scale sets present in this subscription'                     # Write message to screen
            }                                                                               # End else (if ($VmssObject))
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network interfaces or scale set interfaces are present'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNICIpConfig                                                   # Breaks :GetAzureNICIpConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
                Clear-Host                                                                  # Clears screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                   "$_.Name                    # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]                  "$_.Name                     # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:   '$_.PrivIP                            # Write message to screen 
                    Write-Host 'Private IP Allocation:'$_.PrivIPAllo                        # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address:    '$PubIP.IpAddress                 # Write message to screen
                        Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:           '$_.Pri                               # Write message to screen
                    Write-Host 'Nic Name:             '$_.NicName                           # Write message to screen
                    if ($_.NICVM) {                                                         # If current item .NICVM has a value
                        Write-Host 'Attached VM:          '$_.NicVM                         # Write message to screen
                    }                                                                       # End if ($_.NICVM)
                    else {                                                                  # Else if current item .NICVM is $null
                        Write-Host 'Attached VM:           N/A'                             # Write message to screen
                    }                                                                       # End else (if ($_.NICVM))
                    if ($_.NicNSG) {                                                        # If current item .NicNSG has a value
                        Write-Host 'Attached NSG:         '$_.NicNSG                        # Write message to screen
                    }                                                                       # End if ($_.NicNSG)
                    else {                                                                  # Else if current item .NicNSG is $null
                        Write-Host 'Attached NSG:          N/A'                             # Write message to screen
                    }                                                                       # End else (if ($_.NicNSG))
                    if ($_.NICASG) {                                                        # If current item .NICASG has a value
                        Write-Host 'App Security Groups:  '$_.NicASG                        # Write message to screen
                    }                                                                       # End if ($_.NICASG)
                    else {                                                                  # Else if current item .NICASG is $null
                        Write-Host 'App Security Groups:   N/A'                             # Write message to screen
                    }                                                                       # End else (if ($_.NICASG))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the IP config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the network config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNICIpConfig                                               # Breaks :GetAzureNICIpConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Name
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    if ($OpSelect.Type -eq 'ScaleSetNic') {                                 # If $OpSelect.Type equals 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                            $OpSelect.VmssName -ResourceGroupName $OpSelect.VmssRG          # Gets the $NicObject
                        $NicIPConfigObject = $NicObject.IpConfigurations | Where-Object `
                        {$_.Etag -eq $OpSelect.Etag}                                        # Isolates NicIPConfigObject
                    }                                                                       # End if ($OpSelect.Type -eq 'ScaleSetNic')
                    else {                                                                  # Else if $OpSelect.Type does not equal 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                            -ResourceGroupName $OpSelect.NicRG                              # Gets the $NicObject
                        $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig `
                            -NetworkInterface $NicObject -Name $OpSelect.Name               # Gets the NicIPConfigObject
                    }                                                                       # End else (if ($OpSelect.Type -eq 'ScaleSetNic'))
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig