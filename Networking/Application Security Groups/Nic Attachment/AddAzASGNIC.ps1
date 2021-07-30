# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.2.1
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
    Get-AzApplicationSecurityGroup:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-azapplicationsecuritygroup?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
} #>
<# Required Functions Links: {
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    GetAzASG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Application%20Security%20Groups/GetAzASG.ps1
} #>
<# Functions Description: {
    AddAzASGNIC:                Function to add an application security group to nic
    GetAzNetworkInterface:      Function to get a network interface
    GetAzASG:                   Function to get an application security group
} #>
<# Variables: {      
    :AddAzureASGNIC             Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicObject:                 Nic object
    $SubnetObject:              Subnet object (Unused)
    $VnetObject:                Virtual network object (Unused)
    $ObjectList:                $NicObject.IpConfigurations.ApplicationSecurityGroups.ID
    $ASGObject:                 Application security group object
    $AppendedObjectList:        List of ASG IDs to be saved to all $NICIPConfigs 
    $OpConfirm:                 Operator confirmation to make this change
    $NICIPConfigs:              List of all IP configs on $NicObject
    GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
    GetAzASG{}                  Gets $ASGObject
} #>
<# Process Flow {
    function
        Call AddAzASGNIC > Get $null
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return AddAzASGNIC > Send $NicObject, $SubnetObject, $VnetObject
            Call GetAzASG > Get $ASGObject
            End GetAzASG
                Return AddAzASGNIC > Send $ASGObject                
        End AddAzASGNIC
            Return function > Send $null
}#>
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