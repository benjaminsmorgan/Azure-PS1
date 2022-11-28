<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-6.3.0
    Update-AzVM:                                https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    SetAzVMNicPri:              Function to set a VM primary network interface
    GetAzVM:                    Function to get a virtual machine
} #>
<# Variables: {
    :SetAzureVMNic              Outer loop for managing function
    :SelectAzureVMNic           Inner loop for selecting the nic
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $VMStatus:                  $VMObjects power state
    $NicList:                   $VMObject.NetworkProfile.NetworkInterfaces 
    $ListNumber:                $var used for listing and selecting
    $NicNumber:                 $number representing position in $NicList
    $ObjectArray:               Array used to hold nic info
    $CurrentItem:               $var used to hold the current items info
    $NicObject:                 Full nic object
    $ArrayInput:                $var used to load info into $ObjectArry
    $Number:                    Number used for formatting and marking all nics
    $PubIP:                     Public IP object
    $OPSelect:                  Operator input to select the nic
    $NewPrimary:                $var used to hold the new primary nic number
    $MSG:                       Last powershell error message
} #>
<# Process Flow {
    SetAzVMNicPri
        GetAzVM > Get $VMObject
}#>
function SetAzVMNicPri {                                                                    # Function to set a VM primary network interface
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzVMNicPri'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureVMNic while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break SetAzureVMNic                                                         # Breaks :SetAzureVMNic
            }                                                                               # End if (!$VMObject)
            if ($VMObject.NetworkProfile.NetworkInterfaces.Count -lt 2) {                   # If $VMObject.NetworkProfile.NetworkInterfaces.Count is less than 2
                Write-Host 'Only one NIC is associated with this VM'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No chanage have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break SetAzureVMNic                                                         # Breaks :SetAzureVMNic    
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.Count -lt 2)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureVMNic                                                         # Breaks :SetAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            $NicList = $VMObject.NetworkProfile.NetworkInterfaces                           # Isolates the NICs
            $ListNumber = 1                                                                 # $Var for selecting the VM
            $NicNumber = 0                                                                  # $Var used for IDing the nic
            [System.Collections.ArrayList]$ObjectArray = @()                                # $ObjectArray creation
            foreach ($_ in $NicList) {                                                      # For each item in $NicList
                $CurrentItem = $_                                                           # $CurrentItem is equal to current item
                $NicObject = Get-AzNetworkInterface | Where-Object {`
                        $_.ID -eq $CurrentItem.ID}                                          # Pulls the full nic object
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'NicNumber'=$NicNumber;                                                 # Nic number
                    'Name'=$NicObject.Name;                                                 # Nic Name
                    'RG'=$NicObject.ResourceGroupName;                                      # Nic resource group name
                    'IPCon'=$NicObject.IpConfigurations;                                    # Nic IP configs
                    'Primary'=$CurrentItem.Primary;                                         # VM primary nic
                }                                                                           # End $ArrayInput = [PSCustomObject]@
                $NicNumber = $NicNumber + 1                                                 # Increments $var up by 1
                $ListNumber = $ListNumber + 1                                               # Increments $var up by 1
                $NicObject = $null                                                          # Clears $var
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Adds $ArrayInput to $ObjectArray
            }                                                                               # End foreach ($_ in $NicList)
            :SelectAzureVMNic while ($true) {                                               # Inner loop for selecting the nic
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]          "$_.Name                             # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))                     
                    Write-Host 'RG:           '$_.RG                                        # Write message to screen
                    Write-Host 'Is Primary:   '$_.Primary                                   # Write message to screen
                    foreach ($Con in $_.IPCon) {                                            # For each item in current item .IPCon
                        Write-Host 'Config Name:  '$Con.Name                                # Write message to screen
                        Write-Host '  Private IP: '$Con.PrivateIPAddress                    # Write message to screen
                        Write-Host '  Private All:'$Con.PrivateIpAllocationMethod           # Write message to screen
                        if ($Con.PublicIPAddress.ID) {                                      # If $Con.PublicIPAddress.ID has a value
                            $PubIP = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $Con.PublicIPAddress.ID}                         # Gets the public IP addess
                            Write-Host '  Pub IP:'$PubIP.IpAddress                          # Write message to screen
                            Write-Host '  Pub All:'$PubIP.PublicIpAllocationMethod          # Write message to screen
                        }                                                                   # End if ($Con.PublicIPAddress.ID)
                    }                                                                       # End foreach ($Con in $_.IPCon)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OPSelect = Read-Host 'Option [#]'                                          # Operator input to select the NIC
                Clear-Host                                                                  # Clear screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureVMNic                                                     # Breaks :SetAzureVMNic
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OPSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $NewPrimary = $ObjectArray | Where-Object {$_.number -eq $OPSelect}     # $NewPrimary is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NewPrimary = $NewPrimary.NicNumber                                     # Isolates the NIC selection number
                    Break SelectAzureVMNic                                                  # Breaks :SelectAzureVMNic
                }                                                                           # End elseif ($OPSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureVMNic while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Updating the NIC configs'                                       # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                $Number = 0                                                                 # Sets $Number to '0'
                foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces) {                # For each item in $VMObject.NetworkProfile.NetworkInterfaces)                                            
                    $VMObject.NetworkProfile.NetworkInterfaces[$Number].Primary = $false    # Sets all network interfaces primary to $false   
                    $Number = $Number + 1                                                   # Increments $Number up by '1'
                }                                                                           # End foreach ($_ in $VMObject.NetworkProfile.NetworkInterfaces)
                $VMObject.NetworkProfile.NetworkInterfaces[$NewPrimary].Primary = $true     # Sets the $NewPrimary position network interface to primary
                Update-AzVM -VM $VMObject -ResourceGroupName `
                    $VMObject.ResourceGroupName -ErrorAction 'Stop' | Out-Null              # Updates the VM Nic primary configs                                          
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
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
                Break SetAzureVMNic                                                         # Breaks :SetAzureVMNic
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The primary interface has been updated'                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureVMNic                                                             # Breaks :SetAzureVMNic
        }                                                                                   # End :SetAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzVMNicPri