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
    function
        Call ManageAzASG > Get $null
            Call NewAzASG > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzASG > Send $RGObject
            End NewAzASG
                Return ManageAzASG > Send $null  
            Call ListAzASG > Get $null
            End ListAzASG
                Return ManageAzASG > Send $null
            Call RemoveAzASG > Get $null
                Call GetAzASG > Get $ASGObject
                End GetAzASG
                    Return RemoveAzASG > Send $ASGObject
            End RemoveAzASG
                Return ManageAzASG > Send $null
        End ManageAzASG
            Return function > Send $null
}#>
function ManageAzASG {                                                                      # Function for managing application security groups
    Begin {                                                                                 # Begin function
        :ManageAzureASG while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Manage Application Secruity Groups'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Application Secruity Group'                                 # Write message to screen
            Write-Host '[2] List Application Secruity Groups'                               # Write message to screen
            Write-Host '[3] Remove Application Secruity Group'                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureASG                                                        # Breaks :ManageAzureASG
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Application Secruity Group'                                 # Write message to screen
                NewAzASG                                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Application Secruity Groups'                               # Write message to screen
                ListAzASG                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Application Secruity Group'                              # Write message to screen
                RemoveAzASG                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
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
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NicNames'=$NICList.Name                                                # Nic names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
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
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'NicNames'=$NICList.Name                                                # Nic names
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $ASGID = $null                                                              # Clears $var
                $NicList = $null                                                            # Clears $var
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
                        Write-Host 'Associated NICS:'$_.NicNames                            # Write message to screen
                    }                                                                       # End if ($_.NicNames)
                    else {                                                                  # Else if current item .NicNames is $null
                        Write-Host 'Associated NICS: N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.NicNames))
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
            }                                                                               # End if ($AttachedNics)
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