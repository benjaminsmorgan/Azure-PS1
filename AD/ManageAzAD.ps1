function ManageAzAD {                                                                       # Function for managing Azure AD
    Begin {                                                                                 # Begin function
        Import-Module AzureAD                                                               # Imports AzureAD module (Does not work in PS core)
        Connect-AzureAD                                                                     # Opens Azure AD log in
        :ManageAzureAD while ($true) {                                                      # Outer loop for managing function
            Write-Host '[1] Manage Accounts'                                                # Write message to screen
            Write-Host '[2] Manage Applications'                                            # Write message to screen
            Write-Host '[3] Manage Policies'                                                # Write message to screen
            Write-Host '[4] Manage Proxies'                                                 # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen 
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureADAccounts                                                 # Breaks ManageAzureADAccounts
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # If $OpSelect equals '1'
                ManageAzADAccounts                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))           
        }                                                                                   # End :ManageAzureAD while ($true)
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzAD
function ManageAzADAccounts {                                                               # Function for managing Azure AD Accounts
    Begin {                                                                                 # Begin function
        :ManageAzureADAccounts while ($true) {                                              # Outer loop for managing function
            Write-Host '[1] Manage Users'                                                   # Write message to screen
            Write-Host '[2] Manage Groups'                                                  # Write message to screen
            Write-host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureADAccounts                                                 # Breaks ManageAzureADAccounts
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # If $OpSelect equals '1'
                ManageAzADUser                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureADAccounts while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzADAccounts
function ManageAzADUser {                                                                   # Function for managing Azure AD Users
    Begin {                                                                                 # Begin function
        :ManageAzureADUser while ($true) {                                                  # Outer loop for managing function
            Write-Host '[1] New User'                                                       # Write message to screen
            Write-Host '[2] List Users'                                                     # Write message to screen
            Write-Host '[3] Get User'                                                       # Write message to screen
            Write-Host '[4] Remove User'                                                    # Write message to screen
            Write-host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureADUser                                                     # Breaks ManageAzureADUser
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '3') {                                                    # If $OpSelect equals '3'
                GetAzADUser                                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureADAccounts while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzADAccounts
function GetAzADUser {                                                                      # Function to get an Azure AD user account
    Begin {                                                                                 # Begin function
        :GetAzureADUser while ($true) {                                                     # Outer loop for managing function
            $ObjectList = Get-AzADUser                                                      # Pulls a list of all user accounts
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;`
                    'UPN'=$_.UserPrincipalName;'Loc'=$_.UsageLocation;`
                    'GName'=$_.GivenName;'SName'=$_.Surname;'DName'=$_.DisplayName;`
                    'Mail'=$_.Mail;'Enabled'=$_.AccountEnabled;'ID'=$_.Id}                  # Adds info to current $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber +1                                            # Increments $ObjectNumber up by 1                                  
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # Foreach item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                Write-Host "[$Number]" $_.UPN                                               # Write message to screen
                Write-Host 'Display Name:'$_.DName                                          # Write message to screen
                Write-Host 'Given Name:  '$_.GName                                          # Write message to screen
                Write-Host 'Surname:     '$_.SName                                          # Write message to screen
                Write-Host 'Location:    '$_.Loc                                            # Write message to screen
                if ($_.Mail) {                                                              # If current item .Mail has a value
                    Write-Host 'Email:       '$_.Mail                                       # Write message to screen
                }                                                                           # End if ($_.Mail)
                Write-Host 'Enabled:     '$_.Enabled                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureADUser while ($true) {                                              # Inner loop for selecting the user account
                if ($CallingFunction) {                                                     # If $CallingFunction has a vale
                    Write-Host 'You are selecting a user account for:'$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Select user [#]'                                     # Operator input to select the user account
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureADUser                                                    # Breaks :GetAzureADUser
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Elseif $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.number
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                        $ADUserObject = Get-AzADUser -ObjectId $OpSelect.ID                 # Pulls the full AD user object
                        Clear-Host                                                          # Clears screen 
                        Return $ADUserObject                                                # Returns to calling function with $ADUserObject
                    }                                                                       # End if ($CallingFunction)
                    else {                                                                  # If $CallingFunction does not have a value
                        Break GetAzureADUser                                                # Breaks :GetAzureADUser
                    }                                                                       # End else if ($CallingFunction)
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureADUser while ($true)
        }                                                                                   # End :GetAzureADUser while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzADUser
function NewAzADUser {                                                                      # Function for adding a new Azure AD User
    Begin {                                                                                 # Begin Function
        :NewAzureADUser while ($true) {                                                     # Outer loop for managing function
            $PassProfile = New-Object -Type Microsoft.Open.AzureAD.Model.PasswordProfile    # Creates a password profile
            $PassProfile.Password = 'PASSword1234$$'                                        # Adds defaults to password profile
            $PassProfile.ForceChangePasswordNextLogin = $true                               # Adds defaults to password profile
            $PassProfile.EnforceChangePasswordPolicy = $true                                # Adds defaults to password profile
            :SetAzureADUserGName while ($true) {                                            # Inner loop for setting the user given (first) name
                $GName = Read-Host 'Enter the given (first) name'                           # Operator input for the given name
                $GNameStart = $GName.Substring(0,1).ToUpper()                               # Creates $GNameStart
                $GNameEnd = $GName.Substring(1).ToLower()                                   # Creates $GNameEnd
                $GName = $GNameStart+$GNameEnd                                              # Recreates $GName
                Write-Host $GName 'is correct?'                                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the given name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureADUserGName                                               # Breaks :SetAzureADUserGName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUserGName while ($true)
            :SetAzureADUserSName while ($true) {                                            # Inner loop for setting the user sur (last) name
                $SName = Read-Host 'Enter the surname (last) name'                          # Operator input for the surname
                $SNameStart = $SName.Substring(0,1).ToUpper()                               # Creates $SNameStart
                $SNameEnd = $SName.Substring(1).ToLower()                                   # Creates $SNameEnd
                $SName = $SNameStart+$SNameEnd                                              # Recreates $SName
                Write-Host $SName 'is correct?'                                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the surname
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureADUserSName                                               # Breaks :SetAzureADUserSName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUserSName while ($true)
            :SetAzureADUserMName while ($true) {                                            # Inner loop for setting the user middle inital
                $MName = Read-Host 'Enter the middle Name (if present)'                     # Operator input for the middle inital
                if ($MName) {                                                               # If $MName has a value
                    Write-Host $MName 'is correct?'                                         # Write message to screen
                }                                                                           # End if ($MName)
                else {                                                                      # If $MName does not have a value
                    Write-Host 'Confirm no middle name'                                     # Write message to screen
                }                                                                           # End else (if ($MName))
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the surname
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'y'
                    Break NewAzureADUser                                                    # Breaks :NewAzureADUser                                                    
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Elseif $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen    
                    Break SetAzureADUserMName                                               # Breaks :SetAzureADUserMName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureADUser<Name while ($true)
            :SetAzureADUserPrincipalName while ($true) {                                    # Inner loop for setting the user principalName
                $SNameSub = $SName.Substring(0,6)                                           # Collects the first 6 letters of SName
                $GNameSub = $GName.Substring(0,1).ToLower()                                 # Collects the first letter of the GName                        
                if ($MName) {                                                               # If $MName has a value
                    $MNameSub = $MName.Substring(0,1).ToLower()                             # Collects the first letter of $MName
                    $UPName = $SNameSub+$GNameSub+$MNameSub+'@morganbs.com'                 # Creates $UPName
                    $AddCount = 1                                                           # Number used to append to $UPName
                    :CheckAzureADUserPrincipalName while ($true) {                          # Inner loop for validating the $UPName
                        [string]$AddCountString = $AddCount                                 # Converts $AddCount to string
                        $CheckADUser = Get-AzureAdUser | Where-Object `
                            {$_.UserPrincipalName -eq $UPName}                              # Finds a matching UserPrinicpalName is existing
                        if ($CheckADUser) {                                                 # If $CheckADUser has a value
                            $UPName = `
                            $SNameSub+$GNameSub+$MNameSub+$AddCountString+'@morganbs.com'   # Updates $UPName with $AddCountString
                            $AddCount = $AddCount + 1                                       # Increments $AddCount up by 1
                            $CheckADUser = $null                                            # Clears $CheckADUser
                        }                                                                   # End if ($CheckADUser)
                        else {                                                              # If $CheckADUser does not have a value
                            Break SetAzureADUserPrincipalName                               # Breaks :SetAzureADUserPrincipalName
                        }                                                                   # End else (if ($CheckADUser))
                    }                                                                       # End :CheckAzureADUserPrincipalName while ($true) 
                }                                                                           # End if ($MName)
                else {                                                                      # If $MName does not have a value
                    $UPName = $SNameSub+$GNameSub+'@morganbs.com'                           # Creates $UPName
                    $AddCount = 1                                                           # Number used to append to $UPName
                    :CheckAzureADUserPrincipalName while ($true) {                          # Inner loop for validating the $UPName
                        [string]$AddCountString = $AddCount                                 # Converts $AddCount to string
                        $CheckADUser = Get-AzureAdUser | Where-Object `
                            {$_.UserPrincipalName -eq $UPName}                              # Finds a matching UserPrinicpalName is existing
                        if ($CheckADUser) {                                                 # If $CheckADUser has a value
                            $UPName = $SNameSub+$GNameSub+$AddCountString+'@morganbs.com'   # Updates $UPName with $AddCountString
                            $AddCount = $AddCount +1                                        # Increments $AddCount up by 1
                            $CheckADUser = $null                                            # Clears $CheckADUser
                        }                                                                   # End if ($CheckADUser)
                        else {                                                              # If $CheckADUser does not have a value
                            Break SetAzureADUserPrincipalName                               # Breaks :SetAzureADUserPrincipalName
                        }                                                                   # End else (if ($CheckADUser))
                    }                                                                       # End :CheckAzureADUserPrincipalName while ($true)
                }                                                                           # End else (if ($MName))
            }                                                                               # End :SetAzureADUserPrincipalName while ($true)
            $Dname = $GName + ' ' + $SName                                                  # Creates $DName (Display Name)
            $MailName = $UPName.Split('@')[0]                                               # Creates $MailName (Mail Nickname)
            Try {                                                                           # Try the following
                New-AzureADUser -UserPrincipalName $UPName -DisplayName $Dname `
                    -MailNickname $MailName -GivenName $GName -Surname $SName `
                    -PasswordProfile $PassProfile -AccountEnabled $true `
                    -ErrorAction 'Stop'                                                     # Creates the user account
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Start-Sleep(2)                                                              # Pauses all actions for 2 seconds
                Break NewAzureADUser                                                        # Breaks :NewAzureADUser
            }                                                                               # End catch   
            Write-Host 'The user account has been created'                                  # Write message to screen
            Start-Sleep(2)                                                                  # Pauses all actions for 2 seconds
            Break NewAzureADUser                                                            # Breaks :NewAzureADUser
        }                                                                                   # End :NewAzureADUser while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzADUser