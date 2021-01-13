function ListItems {
    Begin {
        $ErrorActionPreference = 'silentlyContinue'
        $List = Get-AzResourceGroup # Edit this to choose what list is being created
        if (!$List) { # If $list returns empty
            Write-Host "No items found" # Message write to screen
            Return # This can be set to return or break
        } # End if
        $ListNumber = 1 # Sets the base value of the list
        foreach ($_ in $List) { # For each item in list
            Write-Host $ListNumber"." $_.ResourceGroupName # Edit this to display the info in the list
            $ListNumber = $ListNumber+1 # Adds 1 to $ListNumber
        } # End foreach
        Write-Host "0. Exit"
        $ListNumber = 1 # Resets list number to 1
        $ListSelect = Read-Host "Enter the option number" # User input
        if ($ListSelect -eq '0') {
            Return # This can be set to return or break
        } # End if
        :FindInList foreach ($_ in $List) { # For each item in list
            if ($ListSelect -eq $ListNumber) { # If the user input matches the current $ListNumber
                $RGObject = $_ # Edit this to assign to whatever varible
                Break FindInList
            } # End if
            else { # If user input does not match the current $ListNumber
                $ListNumber = $ListNumber+1 # Adds 1 to $ListNumber
            } # End else
        } # End :FindInList
        $RGObject # This is just for testing, change this to whatever you want to use it for
    } # End begin
} # End funciton ListItems