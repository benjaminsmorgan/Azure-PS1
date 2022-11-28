# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.2.0
    Get-AzVM
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    GetAzVMfromNIC:             Gets VM info from NIC
    GetAzResourceGroup:         Gets resource group from full name match
    GetAzResource:              Collects resources within a resource group 
} #>
<# Variables: {
    GetAzVMfromNIC {
        :GetAzureVMfromNIC      Outer loop for function
        :GetAzureVM             Inner loop for getting the matching VM
        $RSObject:              Resource object
        $NICInfo:               NIC object
        $NICVMName:             Name of the attached VM             
        $VMObject:              VM object
        GetAzResource {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name
            $RSList:                Variable used for printing all resources to screen if needed
            GetAzResourceGroup {
                $RGObject:              Resource group object
                $RGObjectInput:         Operator input for the resource group name
                $RGList:                Variable used for printing all resource groups to screen if needed
                :GetAzureResourceGroup  Named loop for getting the resource group object
            } End GetAzResourceGroup
        } End GetAzResource 
    } End GetAzVMfromNIC
} #>
<# Process Flow {
    Function
        Call GetAzVMfromNIC > Get $VMObject
            Call GetAzResource > Get $RSObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzResource > Send $RGObject
                End GetAzResource
                Return RemoveAzResource > Send $RSObject
            End GetAzVMfromNIC > Send $VMObject 
}#>  
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
                $NICVMName = $NICInfo.VirtualMachine.ID # Isolates the VM ID
                $NICVMName = $NICVMNAME.Split('/')[-1] # Keeps only the name of the VM
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