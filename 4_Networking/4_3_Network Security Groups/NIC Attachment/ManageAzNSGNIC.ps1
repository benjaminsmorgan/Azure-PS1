# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.1
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    AddAzNSGNIC:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/AddAzNSGNIC.ps1
    ListAzNSGNIC:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/ListAzNSGNIC.ps1
    RemoveAzNSGNIC:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/NIC%20Attachment/RemoveAzNSGNIC.ps1
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    ManageAzNSGNIC:             Function to manage NSG Nic associations
    AddAzNSGNIC:                Function to add a NSG to NIC
    ListAzNSGNIC:               Function to list all NICs associated with network security groups
    RemoveAzNSGNIC:             Function to remove a NSG from NIC
    GetAzNSG:                   Function to get a network security group
    GetAzNetworkInterface:      Function to get a network interface
} #>
<# Variables: {      
    :AddAzureNSGNic             Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NSGObject:                 Network security group
    $NicObject:                 Nic object
    $SubnetObject:              Subnet object (Unused)
    $VnetObject:                Virtual network object (Unused)
    $CurrentNSG:                Current network support group
    $OpConfirm:                 Operator confirmation to make the change
    AddAzNSGNIC{}               Updates $NicObject
        GetAzNSG{}                  Gets $NSGObject
        GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
    ListAzNSGNIC{}              Lists $NSGObject, $NICObject, $VMObject
    RemoveAzNSGNIC{}            Updates $NicObject
        GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
} #>
<# Process Flow {
    function
        Call ManageAzNSGNIC > Get $null
            Call AddAzNSGNIC > Get $null
                Call GetAzNSG > Get $NSGObject
                End GetAzNSG
                    Return AddAzNSGNIC > Send $NSGObject
                Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
                End GetAzNetworkInterface
                    Return AddAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
            End AddAzNSGNIC
                Return ManageAzNSGNIC > Send $null
            Call ListAzNSGNIC > Get $null
            End ListAzNSGNIC
                Return ManageAzNSGNIC > Send $null
            Call RemoveAzNSGNIC > Get $null
                Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
                End GetAzNetworkInterface
                    Return RemoveAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
            End RemoveAzNSGNIC
                Return ManageAzNSGNIC > Send $null                
        End ManageAzNSGNIC
            Return function > Send $null
}#>
function ManageAzNSGNIC {                                                                   # Function to manage NSG Nic associations
    Begin {                                                                                 # Begin function
        :ManageAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            Write-Host 'Manage NSG NIC assoications'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add/Change Association'                                         # Write message to screen
            Write-Host '[2] List Associations'                                              # Write message to screen
            Write-Host '[3] Remove Association'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNSGNic                                                     # Breaks :ManageAzureNSGNic
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add/Change Association'                                         # Write message to screen
                AddAzNSGNIC                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Associations'                                              # Write message to screen
                ListAzNSGNIC                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Association'                                             # Write message to screen
                RemoveAzNSGNIC                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen 
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureNSGNic while ($true)
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNSGNIC 
function AddAzNSGNIC {                                                                      # Function to add a NSG to NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'AddAzNSGNIC'                                                # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :AddAzureNSGNic while ($true) {                                                     # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NSGObject) 
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Replace:'$CurrentNSG                                            # Write message to screen
                Write-Host 'With:   '$NSGObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'On NIC: '$NicObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'Add:'$NSGObject.name                                            # Write message to screen
                Write-Host 'To: '$NicObject.name                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $NSGObject                            # Assigns $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureNSGNic                                                    # Breaks :AddAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been added to the NIC'                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :AddAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNSGNIC
function ListAzNSGNIC {                                                                     # Function to list all NICs associated with network security groups       
    Begin {                                                                                 # Begin function
        :ListAzureNSGNic while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering NSG info'                                                 # Write message to sceen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Creates $ObjectList
            Clear-Host                                                                      # Clears screen
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No network security groups present in this subscription'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGNic                                                       # Breaks :ListAzureNSGNic
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            Write-Host 'Gathering NIC info'                                                 # Write message to sceen
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $NSGObject = $_                                                             # NSGObject is equal to current item
                $NicList = $_.NetworkInterfaces.ID                                          # $NicList is equal to current item .NetworkInterfaces.ID
                if ($NicList) {                                                             # If $NicList has a value
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ID = $_                                                            # ID is equal to current item
                        $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}  # Pulls the full nic object
                        if ($NicObject.VirtualMachine.ID) {                                 # If $NicObject.VirtualMachine.ID has a value
                            $VMObject = $NicObject.VirtualMachine.ID                        # Isolates the VM id
                            $VMObject = Get-AzVM | Where-Object {$_.ID -eq $VMObject}       # Pulls the full VM object
                            if ($VMObject.OSProfile.LinuxConfiguration) {                   # If $VMObject.OSProfile.LinuxConfiguration has a value
                                $OsType = 'Linux'                                           # Sets $OSType
                            }                                                               # End if ($VMObject.OSProfile.LinuxConfiguration)
                            else {                                                          # Else if $VMObject.OSProfile.LinuxConfiguration is $null
                                $OsType = 'Windows'                                         # Sets $OSType
                            }                                                               # End else (if ($VMObject.OSProfile.LinuxConfiguration))
                        }                                                                   # End if ($NicObject.VirtualMachine.ID) 
                        $ObjectInput = [PSCustomObject]@{                                   # custom object to add info to $ObjectArray
                            'NSGName'=$NSGObject.Name;                                      # NSG name
                            'NSGRG'=$NSGObject.ResourceGroupName;                           # NSG resource group
                            'RuleCount'=$NSGObject.SecurityRules.Count;                     # Count of non-default rules
                            'NICName'=$NICObject.Name;                                      # NIC name
                            'NICRG'=$NicObject.ResourceGroupName;                           # NIC resource group
                            'NicVM'=$VMObject.Name;                                         # NIC VM name
                            'NicVMRG'=$VMObject.ResourceGroupName;                          # NIC VM resource group
                            'NICVMOS'=$OsType                                               # NIC VM OS                                    
                        }                                                                   # End $ObjectInput = [PSCustomObject]@
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Adds $ObjectInput to $ObjectArray
                        $ID = $null                                                         # Clears $var
                        $NicObject = $null                                                  # Clears $var
                        $VMObject = $null                                                   # Clears $var
                        $OSType = $null                                                     # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End if ($NicList)
                $NSGObject = $null                                                          # Clears $var
                $NicList = $null                                                            # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'There are not NICs associated with network security groups'     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNSGNic                                                       # Breaks :ListAzureNSGNic
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Sec Group Name: '$_.NSGName                                     # Write message to screen
                Write-host 'Sec Group RG:   '$_.NSGRG                                       # Write message to screen
                Write-Host 'Sec Rules count:'$_.RuleCount                                   # Write message to screen
                Write-Host 'NIC Name:       '$_.NICName                                     # Write message to screen
                Write-Host 'NIC RG:         '$_.NICRG                                       # Write message to screen
                if ($_.NicVM) {                                                             # If current item .NicVM has a value
                    Write-Host 'VM Name:        '$_.NicVM                                   # Write message to screen
                    Write-Host 'VM RG:          '$_.NicVMRG                                 # Write message to screen
                    Write-Host 'VM OS Type:     '$_.NICVMOS                                 # Write message to screen
                }                                                                           # End if ($_.NicVM)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNSGNic                                                           # Breaks :ListAzureNSGNic
        }                                                                                   # End :ListAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNSGNIC
function RemoveAzNSGNIC {                                                                   # Function to remove a NSG from NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNSGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :RemoveAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Remove:  '$CurrentNSG                                           # Write message to screen
                Write-Host 'From NIC:'$NicObject.name                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'No NSG associated to:'$NicObject.name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $null                                 # Removes $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGNic                                                 # Breaks :RemoveAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been removed from the NIC'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :RemoveAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGNIC
# Additional functions for ManageAzNSGNIC
function GetAzNSG {                                                                         # Function to get a network security group
    Begin {                                                                                 # Begin function
        :GetAzureNSG while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network security group info'                              # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzNetworkSecurityGroup                                        # Gets a list of all network security groups
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No security groups present in this subscription'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNSG                                                           # Breaks :GetAzureNSG
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'RG'=$_.ResourceGroupName;                                              # Rule resource group name
                    'Location'=$_.Location;                                                 # Rule location
                    'SrulesCount'=$_.SecurityRules.Count;                                   # Security rules count
                    'DrulesCount'=$_.DefaultSecurityRules.Count                             # Default security rules count
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureNSG while ($true) {                                                 # Inner loop for selecting the network security group
                Write-Host '[0]                  Exit'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                 "$_.Name                      # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Rule RG:            '$_.RG                                  # Write message to screen
                    Write-Host 'Rule Loc:           '$_.Location                            # Write message to screen
                    Write-Host 'Sec Rules Count:    '$_.SrulesCount                         # Write message to screen
                    Write-Host 'Default Rules Count:'$_.DRulesCount                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the network security group for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the network security group
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNSG                                                       # Breaks :GetAzureNSG
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NSGObject = Get-AzNetworkSecurityGroup -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full network security group object
                    Return $NSGObject                                                       # Returns to calling function with network security group object
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureNSG while ($true)
        }                                                                                   # End :GetAzureNSG while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzNSG
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNIC                                                           # Breaks :GetAzureNIC
            }                                                                               # End if (!$VNetList)
            Clear-Host                                                                      # Clears screen
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                Write-Host 'Gathering subnets in:'$VNet' | '$VNet                           # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    Write-Host 'Gathering NICs in:'$SubnetName                              # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        if ($_.NetworkSecurityGroup.ID) {                                   # If current item .NetworkSecurityGroup.ID has a value
                            $NSGName = $_.NetworkSecurityGroup.ID                           # Isloates the network security group ID
                            $NSGName = $NSGName.Split('/')[-1]                              # Isolates the network security group name
                        }                                                                   # End if ($_.NetworkSecurityGroup.ID)
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput
                            'Number'=$ListNumber;                                           # List number
                            'NicName'=$_.Name;                                              # Nic name
                            'NicRG'=$_.ResourceGroupName;                                   # Nic resource group name
                            'SubName'=$Subnetname;                                          # Subnet name
                            'SubPFX'=$SubnetPFX;                                            # Subnet address prefix
                            'VNetName'=$VNet;                                               # Virtual network name
                            'VnetPFX'=$VnetPFX;                                             # Virtual network address prefix
                            'VnetRG'= $VNetRG;                                              # Virtual network resource group
                            'VM'=$_.VirtualMachine.ID;                                      # VM ID
                            'IPCon'=$_.IpConfigurations;                                    # IP configurations
                            'Type'='NIC';                                                   # Object Type
                            'NSG'=$NSGName                                                  # Network security group                  
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                        $NSGName = $null                                                    # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Write-Host 'Checking for virtual machine scale sets'                            # Write message to screen
            $VmssObject = Get-AzVmss                                                        # Gets a list of Vmss objects if present
            if ($VmssObject) {                                                              # If $VmssObject has a value
                Write-Host 'Gathering scale set instance interfaces'                        # Write message to screen
                foreach ($_ in $VmssObject) {                                               # For each item in $VmssObject
                    Write-Host 'Gathering NICs on:'$_.name                                  # Writ message to screen
                    $VmssName = $_.name                                                     # Isloates the Vmss name
                    $VmssRG = $_.ResourceGroupName                                          # Isolates the Vmss resource group
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $VmssName -ResourceGroupName $VmssRG                                # Gets a list of nics attached to current vmss object
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $SubnetID = $_.IpConfigurations.Subnet.ID                           # Isolates the subnet
                        $VnetName = $SubnetID.Split('/')[8]                                 # Isolates the Vnet name
                        $Vnet = Get-AzVirtualNetwork -Name $VnetName                        # Gets the virtual network
                        $VnetName = $Vnet.name                                              # Isolates the vnet name
                        $VnetPFX = $Vnet.AddressSpace.AddressPrefixes                       # Isolates the vnet prefix
                        $VNetRG = $Vnet.ResourceGroupName                                   # Isolates the vnet resource group
                        $Subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $Vnet `
                            | Where-Object {$_.ID -eq $SubnetID}                            # Gets the subnet
                        $SubnetName = $Subnet.Name                                          # Isolates the subnet name
                        $SubnetPFX = $Subnet.AddressPrefix                                  # Isolates the subnet addressPrefix  
                        if ($_.NetworkSecurityGroup.ID) {                                   # If current item .NetworkSecurityGroup.ID has a value
                            $NSGName = $_.NetworkSecurityGroup.ID                           # Isloates the network security group ID
                            $NSGName = $NSGName.Split('/')[-1]                              # Isolates the network security group name
                        }                                                                   # End if ($_.NetworkSecurityGroup.ID)       
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput
                            'Number'=$ListNumber;                                           # List number
                            'NicName'=$_.Name;                                              # Nic name
                            'NicRG'=$_.ResourceGroupName;                                   # Nic resource group name
                            'SubName'=$Subnetname;                                          # Subnet name
                            'SubPFX'=$SubnetPFX;                                            # Subnet address prefix
                            'VNetName'=$VNet;                                               # Virtual network name
                            'VnetPFX'=$VnetPFX;                                             # Virtual network address prefix
                            'VnetRG'= $VNetRG;                                              # Virtual network resource group
                            'VM'=$_.VirtualMachine.ID;                                      # VM ID
                            'IPCon'=$_.IpConfigurations;                                    # Ip configuration
                            'Type'='Scaleset';                                              # Object type
                            'VmssName'=$VmssName;                                           # VMSS name
                            'VmssRg'=$VmssRG;                                               # VMSS resource group
                            'NSG'=$NSGName                                                  # Network security group     
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                        $NSGName = $null                                                    # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No network interfaces present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNIC                                                           # Breaks :GetAzureNIC
            }                                                                               # End if (!$ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.NicName                       # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]            "$_.NicName                        # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    foreach ($IP in $_.IPCon) {                                             # For each item in .IPCon
                        Write-Host 'IP Config Name: '$IP.Name                               # Write message to screen
                        Write-Host 'Private Address:'$IP.PrivateIpAddress                   # Write message to screen
                        if ($IP.publicIPAddress) {                                          # If current item .PublicAddres has a value
                            $PubID = $IP.publicIPAddress.ID                                 # Isolates the public IP sku ID
                            $PubIP = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubID}                                          # Gets the public IP sku
                            Write-Host 'Public Address: '$PubIP.IpAddress                   # Write message to screen
                        }                                                                   # End if ($IP.PublicAddress)
                    }                                                                       # End foreach ($IP in $_.IPCon)
                    Write-Host 'NIC RG:         '$_.NicRG                                   # Write message to screen
                    Write-Host 'Subnet Name:    '$_.Subname                                 # Write message to screen
                    Write-Host 'Subnet Prefix:  '$_.SubPFX                                  # Write message to screen
                    Write-Host 'VNet Name:      '$_.VnetName                                # Write message to screen
                    Write-Host 'VNet Prefix:    '$_.VnetPFX                                 # Write message to screen
                    Write-Host 'VNet RG:        '$_.VnetRG                                  # Write message to screen
                    if ($_.VM) {                                                            # If $_.VM has a value
                        $VM = $_.VM                                                         # VM is equal to current item .VM
                        if ($VM -like '*virtualMachineScaleSets*') {                        # If $VM is like '*virtualMachineScaleSets*'
                            $Vmss = $VM.Split('/')[-3]                                      # Collects the Vmss name
                            $VM = $VM.Split('/')[-1]                                        # Collects the instance name
                            $VM = $Vmss+'/virtualMachines/'+$VM                             # Combines the Vmss name and the instance name
                        }                                                                   # End if ($VM -like '*virtualMachineScaleSets*')
                        else {                                                              # Else If $VM is not like '*virtualMachineScaleSets*'
                            $VM = $VM.Split('/')[-1]                                        # Collects the VM name
                        }                                                                   # End else (if ($VM -like '*virtualMachineScaleSets*'))
                        Write-Host 'Attached VM:    '$VM                                    # Write message to screen
                        $VM = $null                                                         # Clears $VM                                            
                    }                                                                       # End if ($_.VM)
                    else {                                                                  # If $_.VM does not have a value
                        Write-Host 'Attached VM:     N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.VM))
                    if ($_.NSG) {                                                           # If $_.NSG has a value
                        Write-Host 'Net Sec Group  :'$_.NSG                                 # Write message to screen
                    }                                                                       # End if ($_.NSG)
                    else {                                                                  # Else if $_.NSG is $null
                        Write-Host 'Net Sec Group  : N/A'                                   # Write message to screen    
                    }                                                                       # End else if ($_.NSG)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.VnetName `
                        -ResourceGroupName $OpSelect.VNetRG                                 # Pulls the $Subnet Vnet
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Subname                                 # Pulls the $NicObject subnet
                    if ($OpSelect.Type -eq 'Nic') {                                         # If $OpSelect.Type equals 'Nic'
                        $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName |`
                            Where-Object {$_.IpConfigurations.Subnet.ID -eq `
                            $SubnetObject.ID}                                               # Pulls the full $NicObject
                    }                                                                       # End if ($OpSelect.Type -eq 'Nic')
                    else {                                                                  # Else if $OpSelect.Type does not equal 'Nic'
                        $NicObject = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                            $OpSelect.VmssName -ResourceGroupName $OpSelect.VmssRg `
                            | Where-Object {$_.Name -eq $OpSelect.NicName}                  # Pulls the full $NicObject
                    }                                                                       # End else (if ($OpSelect.Type -eq 'Nic'))
                    Return $NicObject,$SubnetObject,$VnetObject                             # Returns $vars to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface