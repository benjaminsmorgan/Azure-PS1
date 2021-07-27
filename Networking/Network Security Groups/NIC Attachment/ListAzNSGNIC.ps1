# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.2.1
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.1
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzNSGNIC:               Function to list all NICs associated with network security groups
} #>
<# Variables: {      
    :ListAzureNSGNic            Outer loop for managing function
    $ObjectList:                List of all network security groups
    $ObjectArray:               Array holding all the listed info
    $NSGObject:                 Current network security group
    $NicList:                   List of all network interfaces.IDs on $NSGObject
    $ID:                        Current item (Nic ID)
    $NicObject:                 Full NIC object
    $VMObject:                  Full VM object
    $OsType:                    Os type on $VMObject
    $ObjectInput:               $var used to load info into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzNSGNIC > Get $null
        End ListAzNSGNIC
            Return function > Send $null
}#>
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