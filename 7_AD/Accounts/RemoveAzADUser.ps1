# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Remove-AzADUser:            https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azaduser?view=azps-5.8.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1
} #>
<# Functions Description: {
    RemoveAzADUser:             Removes an Azure user account
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :RemoveAzureADUser          Outer loop for managing function
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD user account object
    $OpConfirm:                 Operator confirmation to remove $ADUserObject
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call RemoveAzADUser > Get $null
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return RemoveAzADUser > Send $ADUserObject
        End RemoveAzADUser
            Return function > Send $null
}#>
function RemoveAzADUser {                                                                   # Function to remove an Azure AD
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzADUser'                                                 # Creates $CallingFunction
        :RemoveAzureADUser while ($true) {                                                  # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject does not have a value
                Break RemoveAzureADuser                                                     # End Break RemoveAzureADuser
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Remove'$ADUserObject.UserPrincipalName                              # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm is equal to 'y'
                try {                                                                       # Try the following
                    Remove-AzADUser -ObjectId $ADUserObject.ID -Force -ErrorAction 'Stop'   # Removes the selected account
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Start-Sleep(2)                                                          # Pauses all actions for 2 seconds
                    Break RemoveAzureADuser                                                 # End Break RemoveAzureADuser
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been removed'                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break RemoveAzureADuser                                                     # End Break RemoveAzureADuser
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No changes has been made'                                       # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break RemoveAzureADuser                                                     # End Break RemoveAzureADuser
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureADUser while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzADUser