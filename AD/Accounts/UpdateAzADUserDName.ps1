# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Update-AzADUser:            https://docs.microsoft.com/en-us/powershell/module/az.resources/update-azaduser?view=azps-5.8.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    UpdateAzADUserDName:        Updates an Azure AD account display name
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :UpdateAzureADUser          Outer loop for managing function
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD account object
    $OpConfirm:                 Operator confirmation to update
    $UpdatedName:               New display name for update
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call UpdateAzADUserDName > Get $null 
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return UpdateAzADUserDName > Send $ADUserObject
        End UpdateAzADUserDName
            Return function > Send $null
}#>
function UpdateAzADUserDName {                                                              # Function to update an Azure AD user account display name
    Begin {                                                                                 # Begin function
        $CallingFunction = 'UpdateAzADUserDName'                                            # Creates $CallingFunction
        :UpdateAzureADUserDName while ($true) {                                             # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Update account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                :UpdateAzureADUserName while ($true) {                                      # Inner loop for setting the display name
                    $UpdatedName = Read-Host 'Enter new display name'                       # Operator input for the new display name
                    Write-Host $UpdatedName'is correct'
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break UpdateAzureADUserDName                                        # Breaks :UpdateAzureADUserDName    
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {
                        Break UpdateAzureADUserName                                         # Breaks :UpdateAzureADUserName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :UpdateAzureADUserName while ($true)
                Try {                                                                       # Try the following
                    Update-AzADUser -UPNOrObjectId $ADUserObject.UserPrincipalName `
                        -DisplayName $UpdatedName -ErrorAction 'Stop'                       # Updates the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break UpdateAzureADUserDName                                            # Breaks :UpdateAzureADUserDName
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been updated'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break UpdateAzureADUserDName                                                # Breaks :UpdateAzureADUserDName
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :UpdateAzureADUserDName while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function EnableAzADUser