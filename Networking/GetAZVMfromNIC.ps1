function GetAZVMfromNIC { # Function matchs a VM from the NIC info
    Begin {
        :GetAzureVMfromNIC while ($true) { # Outer loop for managing function
            if (!$RSObject) { # If there is not a currently set $RSObject
                $RSObject = GetAzResource # Calls function and assigns to $var
                if (!$RSObject) { # IF called function returns empty
                    Break GetAzureVMfromNIC # Breaks :GetAzureVMfromNIC
                } # End if (!$RSObject)  
            } # End if (!$RSObject)
            :GetAzureVM while ($true) { # Inner loop for getting the associated VM
                $NICInfo = Get-AzNetworkInterface -Name $RSObject.Name # Collects the NIC info from $RSObject
                $NICVMNAME = $NICInfo.VirtualMachine.ID # Isolates the VM ID
                $NICVMNAME = $NICVMNAME.Split('/')[-1] # Keeps only the name of the VM
                $VMObject = Get-AzVM -Name $NICVMNAME -ResourceGroupName $NICInfo.ResourceGroupName # Collects the matching VM and assigns to $VMObject
                if (!$VMObject) { # IF $VMObject is empty
                    Write-Host $RSObject.Name"is not associated with an existing VM" # Write message to screen
                    Break GetAzureVMfromNIC # # Breaks :GetAzureVMfromNIC
                } # End if (!$VMObject)
                Write-Host "The NIC"$NICInfo.Name"is attached to"$VMObject.Name"in"$VMObject.ResourceGroupName # Write message to screen
                Return $VMObject # Returns to calling function with $VMObject
            } # End :GetAzureVM while ($true)
        } # End :GetAzureVMfromNIC
    Return # Returns to calling function empty
    } # End begin
} # End function GetAZNetInterfaceVM