# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
    Get-AzComputeResourceSku:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azcomputeresourcesku?view=azps-6.3.0
    Add-AzVMNetworkInterface:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-6.3.0
    Update-AzVM:                                https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    RemoveAzVMNic:                 Function to add a NIC to an existing VM
    GetAzVM:                    Function to a virtual machine
    GetAzNetworkInterface:      Function to get a network interface
} #>
<# Variables: {
    :RemoveAzureVMNic              Outer loop for managing function
    :GetAzureNIC             Inner loop for selecting the additional Nic
    :Confirm                    Inner loop for confirming the change
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $VMSize:                    Virtual machine object size
    $MaxNics:                   $VMSize.Capabilities[26].value 
    $VMStatus:                  $VMObjects current power state
    $ExistingNic:               $VMObjects existing network interface
    $SubnetID:                  $ExistingNic.IpConfigurations.Subnet.ID                  
    $NicObject:                 Network interface object
    $SubnetObject:              Unused
    $VnetObject:                Unused
    $PriIP:                     $NicObject.IpConfigurations.PrivateIPAddress[0]             
    $PriIPAll:                  $NicObject.IpConfigurations.PrivateIpAllocationMethod[0] 
    $OpConfirm:                 Operator confirmation to make the change
    $VMNicCount:                $VMObject.NetworkProfile.NetworkInterfaces.count       
    $MSG:                       Last powershell error message
    GetAzNetworkInterface{}
} #>
<# Process Flow {
    RemoveAzVMNic
        GetAzVM > Get $VMObject
        GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
}#>
function RemoveAzVMNic {                                                                    # Function to remove a NIC to an existing VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVMNic'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVMNic while ($true) {                                                   # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1) {                # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count is greater than 1
                $VMNicID = $VMObject.NetworkProfile.NetworkInterfaces.ID                    # Isloates the NIC IDs
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1)
            else {                                                                          # Else If$VMObject.NetworkProfile.NetworkInterfaces.ID.Count is 1 or less
                Write-Host 'Only one NIC exists on this VM'                                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to remove this'                              # Write message to screen
                Write-Host 'NIC unless another one is added first'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic                        
            }                                                                               # End else (if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1))
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$ObjectArray = @()                                # $ObjectArray creation
            foreach ($_ in $VMNicID) {                                                      # For each item in $VMNicID
                $CID = $_                                                                   # Assigns current item to $CID
                $CurrentNic = Get-AzNetworkInterface | Where-Object {$_.ID -eq $CID}        # Gets the current network interface
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'Name'=$CurrentNic.Name;                                                # Nic name
                    'IPCon'=$CurrentNic.IpConfigurations;                                   # Ip configuration
                    'NICID'=$CurrentNic.ID                                                  # Nic ID
                }                                                                           # End creating $ArrayInput
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
                $CurrentNic = $null                                                         # Clears $var
            }                                                                               # End foreach ($_ in $VMNicID)
            :SelectAzureNIC while ($true) {
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
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
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break RemoveAzureVMNic                                                  # Breaks :RemoveAzureVMNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $NicObject = Get-AzNetworkInterface | Where-Object `
                        {$_.ID -eq $OpSelect.NICID}                                         # Pulls the full $NicObject
                    Break SelectAzureNIC                                                    # Breaks :SelectAzureNIC
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNIC while ($true)
            :Confirm while ($true) {                                                        # Inner loop for confirming change
                Write-Host 'Remove the following'                                           # Write message to screen
                Write-Host 'Name:      '$NicObject.Name                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'From the following VM'                                          # Write message to screen
                Write-Host 'Name:      '$VMObject.Name                                      # Write message to screen
                Write-Host 'RG:        '$VMObject.ResourceGroupName                         # Write message to screen
                if ($VMObject.OS.WindowsConfiguration) {                                    # If $VMObject.OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:    Windows'                                        # Write message to screen
                }                                                                           # End if ($VMObject.OS.WindowsConfiguration)
                elseif ($VMObject.OS.LinuxConfiguration) {                                  # If $VMObject.OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:    Linux'                                          # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to make the change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break RemoveAzureVMNic                                                  # Breaks :RemoveAzureVMNic
                }                                                                           # End elseif ($OpConfirm -eq 'n') 
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen 
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Making the requested changes'                                   # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                $PrimaryNIC = $VMObject.NetworkProfile.NetworkInterfaces | `
                    Where-Object {$_.Primary -eq $true}                                     # Isolates the primary Nic object
                $PrimaryNIC = $PrimaryNIC.ID                                                # Isolates the primary Nic ID
                $PrimaryNIC = Get-AzNetworkInterface | Where-Object {$_.ID -eq $PrimaryNIC} # Pulls the full primary Nic Object
                if ($NicObject.Name -eq $PrimaryNIC.Name) {                                 # If $NicObject.Name equals $PrimaryNic.Name
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'This Nic is the primary nic,'                               # Write message to screen
                    Write-Host 'reassing primary to next available NIC'                     # Write message to screen
                    if ($PrimaryNIC.ID -eq `
                        $VMObject.NetworkProfile.NetworkInterfaces[0].ID) {                 # If $PrimaryNIC.ID equals $VMObject.NetworkProfile.NetworkInterfaces[0].ID
                        $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $false      # Sets the 0 position network interface primary setting to false
                        $VMObject.NetworkProfile.NetworkInterfaces[1].Primary = $true       # Sets the 1 position network interface primary setting to true
                    }                                                                       # End if ($PrimaryNIC.ID -eq $VMObject.NetworkProfile.NetworkInterfaces[0].ID)
                    else {                                                                  # Else if $PrimaryNIC.ID does not equal $VMObject.NetworkProfile.NetworkInterfaces[0].ID
                        $Number = 0                                                         # Sets $Number to '0'
                        foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces) {                                                             
                            $VMObject.NetworkProfile.NetworkInterfaces[$Number].Primary `
                                = $false                                                    # Sets all network interfaces primary to $false   
                            $Number = $Number + 1                                           # Increments $Number up by '1'
                        }                                                                   # End foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces)
                        $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $true       # Sets the 0 position network interface to primary
                    }                                                                       # End else (if ($PrimaryNIC.ID -eq $VMObject.NetworkProfile.NetworkInterfaces[0].ID))
                    Update-AzVM -VM $VMObject -ResourceGroupName `
                        $VMObject.ResourceGroupName -ErrorAction 'Stop' | Out-Null          # Updates the VM Nic primary configs                                      
                    Clear-Host
                }                                                                           # End if ($NicObject.Name -eq $PrimaryNIC.Name)
                Remove-AzVMNetworkInterface -VM $VMObject -NetworkInterfaceIDs `
                    $NicObject.ID -ErrorAction 'Stop' | Out-Null                            # Removes the network interface
                Update-AzVM -VM $VMObject -ResourceGroupName $VMObject.ResourceGroupName `
                    -ErrorAction 'Stop' | Out-Null                                          # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVMNic                                                      # Breaks :RemoveAzureVMNic    
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The selected NIC has been removed from the VM'                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureVMNic                                                          # Breaks :RemoveAzureVMNic    
        }                                                                                   # End :RemoveAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVMNic