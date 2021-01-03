function GetAzResourceType {
    Begin {
        if (!$RSObject) {
            $RSObject = GetAzResource
        } # End if (!$RSObject)
        if ($RSObject.ResourceType -eq 'Microsoft.Network/networkInterfaces') {
            Write-Host "This is a NIC"
            $VMObject = GetAZVMfromNIC
            Write-Host $VMObject.Name
        } # End if ($RSObject.ResourceType -eq 'Microsoft.Network/networkInterfaces')
    } # End begin
} # End function GetAzResourceType
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        :GetAzureResourceGroup while ($true) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Break GetAzureResourceGroup # Ends :GetAzureResourceGroup loop
            } # End if statement
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
                Return $RGObject
            } # End of else statement
        } # End of while statement
        Return # Returns to calling function
    } # End of begin statement
} # End of function
function GetAzResource { # Function to get a resource, can pipe $RSObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RSObject = $null # Sets $RSObject to $null from previous uses
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResource function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$RSObject) { # Loop to continue getting a resource until the operator provided name matches an existing resource
            $RSObjectInput = Read-Host "Resource name" # Operator input of the resource name
            if ($RSObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResource function was terminated"
                Return # Returns to calling function
            } # End if statement
            $RSObject = Get-AzResource -Name $RSObjectInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the resource from the operator input
            if (!$RSObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource" # Error note
                Write-Host "This is the list of available resources" # Error note
                $RSList = Get-AzResource -ResourceGroupName $RGObject.ResourceGroupName # Collects all resource objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RSObject is assigned
                Write-Host $RSObject.Name 'Has been assigned to "$RSObject"' # Writes the resource name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RSObject  # Returns the value of $RSObject to a function that called it
    } # End begin statement
} # End function  
function GetAZVMfromNIC {
    Begin {
        :GetAzureVMfromNIC while ($true) {
            if (!$RSObject) {
                $RSObject = GetAzResource
                if (!$RSObject) {
                    Break GetAzureVMfromNIC
                } # End if (!$RSObject)  
            } # End if (!$RSObject)
            :GetAzureVM while ($true) {
                $NICInfo = Get-AzNetworkInterface -Name $RSObject.Name
                $NICVMNAME = $NICInfo.VirtualMachine.ID
                $NICVMNAME = $NICVMNAME.Split('/')[-1]  
                $VMObject = Get-AzVM -Name $NICVMNAME
                if (!$VMObject) {
                    Write-Host $RSObject.Name"is not associated with an existing VM"
                    Break GetAzureVMfromNIC
                } # End if (!$VMObject)
                Write-Host "The NIC"$NICInfo.Name"is attached to"$VMObject.Name"in"$VMObject.ResourceGroupName
                Return $VMObject
            } # End :GetAzureVM while ($true)
        } # End :GetAzureVMfromNIC
    Return
    } # End begin
} # End function GetAZNetInterfaceVM