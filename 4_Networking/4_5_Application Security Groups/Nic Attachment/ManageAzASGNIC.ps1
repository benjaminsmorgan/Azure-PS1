# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.2.1
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    AddAzASGNIC:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/Nic%20Attachment/AddAzASGNIC.ps1
    ListAzASGNIC:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/Nic%20Attachment/ListAzASGNIC.ps1
    GetAzASGNIC:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/Nic%20Attachment/GetAzASGNIC.ps1
    RemoveAzASGNIC:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/Nic%20Attachment/RemoveAzASGNIC.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/GetAzASG.ps1
} #>
<# Functions Description: {
    ManageAzASGNIC:             Function for managing application security group NIC associations
    AddAzASGNIC:                Function to add an application security group to nic
    ListAzASGNIC:               Function to list NICs with an application security group 
    GetAzASGNIC:                Function to add an application security group from to nic
    RemoveAzASGNIC:             Function to remove an application security group from a nic
    GetAzNetworkInterface:      Function to get a network interface
    GetAzASG:                   Function to get an application security group
} #>
<# Variables: {      
    :ManageAzureASGNic          Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    AddAzASGNIC{}               Updates $NicObject
        GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
        GetAzASG{}                  Gets $ASGObject
    ListAzASGNICP{}             Lists $NicObjects
    RemoveAzASGNIC{}            Updates $NicObject
        GetAzASGNIC{}               Gets $NicObject
} #>
<# Process Flow {
    function
        Call ManageAzASGNIC > Get $null
            Call AddAzASGNIC > Get $null
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return AddAzASGNIC > Send $NicObject, $SubnetObject, $VnetObject
                Call GetAzASG > Get $ASGObject
                End GetAzASG
                    Return AddAzASGNIC > Send $ASGObject                
            End AddAzASGNIC
                Return ManageAzASGNIC > Send $null
            Call ListAzASGNIC > Get $null              
            End ListAzASGNIC
                Return ManageAzASGNIC > Send $null     
            Call RemoveAzASGNIC > Get $null
                Call GetAzASGNIC > Get $NicObject              
                End GetAzASGNIC
                    Return RemoveAzASGNIC > Send $NicObject
            End RemoveAzASGNIC
                Return ManageAzASGNIC > Send $null
        End ManageAzASGNIC
            Return function > Send $null
}#>
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