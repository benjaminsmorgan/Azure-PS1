# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Reference links: {
    Set-AzureADUser:            https://docs.microsoft.com/en-us/powershell/module/azuread/set-azureaduser?view=azureadps-2.0
    Get-AzADUser:               https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azaduser?view=azps-5.8.0
} #>
<# Required Functions Links: {
    GetAzADUser:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/AD/Accounts/GetAzADUser.ps1                
} #>
<# Functions Description: {
    UpdateAzADUserDept:         Updates an Azure AD account department
    GetAzADUser:                Gets an Azure AD account
} #>
<# Variables: {
    :UpdateAzureADUserDept     Outer loop for managing function
    :UpdateAzureADUserName      Inner loop for confirming the new name
    $CallingFunction:           Name of this function
    $ADUserObject:              Azure AD account object
    $OpConfirm:                 Operator confirmation to update
    $DeptArray:                 Array used for selection of dept
    $DeptList:                  List of all departments
    $DeptNumber:                Number used for listing and selecting from $DeptArray
    $DeptInput:                 $var used for loading items into $DeptArray
    $Number:                    Current item .number
    $OpSelect:                  Operator selection of the dept
    $DeptObject:                Name of the new dept
    GetAzADUser{}               Gets $ADUserObject
} #>
<# Process Flow {
    Function
        Call UpdateAzADUserDept > Get $null 
            Call GetAzADUser > Get $ADUserObject
            End GetAzADUser
                Return UpdateAzADUserDept > Send $ADUserObject
        End UpdateAzADUserDept
            Return function > Send $null
}#>
function UpdateAzADUserDept {                                                               # Function to update an Azure AD user account department
    Begin {                                                                                 # Begin function
        $CallingFunction = 'UpdateAzADUserDept'                                             # Creates $CallingFunction
        :UpdateAzureADUserDept while ($true) {                                              # Outer loop for managing function
            $ADUserObject = GetAzADUser ($CallingFunction)                                  # Calls function and assigns output to $var
            if (!$ADUserObject) {                                                           # If $ADUserObject is $null
                Break UpdateAzureADUserDept                                                 # Breaks :UpdateAzureADUserDept
            }                                                                               # End if (!$ADUserObject)
            Write-Host 'Update account'$ADUserObject.UserPrincipalName                      # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to Enable account
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                [System.Collections.ArrayList]$DeptArray = @()                              # Creates the dept array
                $DeptList = @('IT','HR','MT','MK','SL','BL','EX')                           # Creates a list of items to load into $DeptArray
                $DeptNumber = 1                                                             # Sets the base number for the $DeptArray
                foreach ($_ in $DeptList) {                                                 # For each item in $DeptList
                    $DeptInput = [PSCustomObject]@{'Name' = $_;'Number' `
                        = $DeptNumber}                                                      # Creates the item to loaded into array
                    $DeptArray.Add($DeptInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $DeptNumber = $DeptNumber + 1                                           # Increments $DeptNumber up 1
                }                                                                           # End foreach ($_ in $DeptList)
                Write-Host '[0] Exit'                                                       # Write message to screen
                foreach ($_ in $DeptArray) {                                                # For each item in $DeptArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    Write-Host "[$Number]" $_.Name                                          # Write message to screen
                }                                                                           # End foreach ($_ in $DeptArray)
                :SelectDept while ($true) {                                                 # Inner loop for selecting the dept
                    $OpSelect = Read-Host 'Dept [#]'                                        # Operator selection of the dept
                    if ($OpSelect -eq '0') {                                                # If $OpSelect -eq 0
                        Break UpdateAzureADUserDept                                         # Breaks :UpdateAzureADUserDept
                    }                                                                       # End ($OpSelect -eq '0')
                    if ($OpSelect -in $DeptArray.Number) {                                  # If $OpSelect is in $DeptArray.Number
                        $DeptObject = $DeptArray | Where-Object {$_.Number -eq $OpSelect}   # $DeptObject equals $DeptArray where $DeptArray.Number is equal to $OpSelect
                        $DeptObject = $DeptObject.Name                                      # Sets $DeptObject to $DeptObject.Name
                        Break SelectDept                                                    # Breaks :SelectDept
                    }                                                                       # End if ($OpSelect -in $DeptArray.Number)
                    else {                                                                  # If $DeptObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($OpSelect -in $DeptArray.Number))
                }                                                                           # End :SelectDept while ($true)
                Try {                                                                       # Try the following
                    Set-AzureADUser -ObjectId $ADUserObject.ID -Department `
                        $DeptObject -ErrorAction 'Stop'                                     # Updates the account
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes made'                                            # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Break UpdateAzureADUserDept                                             # Breaks :UpdateAzureADUserDept
                }                                                                           # End catch
                Write-Host $ADUserObject.UserPrincipalName'has been updated'                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break UpdateAzureADUserDept                                                 # Breaks :UpdateAzureADUserDept
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break UpdateAzureADUserDept                                                 # Breaks :UpdateAzureADUserDept
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :UpdateAzureADUserDept while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function UpdateAzADUserDept