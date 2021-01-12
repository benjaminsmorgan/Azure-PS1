# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzResourceGroup:         Collects resource group object
    GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
} #>
<# Variables: {
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
    GetAzResourceGroupLocksAll {
        $RGObject:              Resource group object
        $Locks:                 Locks object
    }
} #>
<# Process Flow {
    Function
        Call GetAzResourceGroupLocksAll > Get $Locks
            Call GetAzResourceGroup > Get $RGObject
}#>
function GetAzResourceGroupLocksAll { # Function to get all locks assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource group" # Write message to screen
            Write-Host "The GetAzResourceGroupLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function