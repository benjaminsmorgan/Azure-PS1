# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzObject:               https://docs.microsoft.com/en-us/powershell/module/az.resources/
} #>
<# Required Functions Links: {
    GetAzObject:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/
        GetAzObject2:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/
} #>
<# Functions Description: {
    ListItems:                  Allows operator to select item from list
        GetAzObject:                Gets azure Object
} #>
<# Variables: {
    :GetAzureItem               Outer loop for managing function
    :SelectAzureItem            Inner loop for selecting $AzObject
    $AzObject2:                 Additional azure object needed to get main object
    $Getlist:                   List of all AzObjects
    $GetlistNumber:             List number
    $GetlistSelect:             Operator input to select $GetListNumber
    $AzObject:                  Target of this function
    GetAzObject2{}              Gets $AzObject2
        GetAzObject3{}              Gets $AzObject3       
} #>
<# Process Flow {
    Function
        Call ListItems > Get $AzObject
            Call GetAzObject2 > Get $AzObject2
                Call GetAzObject3 > Get $AzObject3
                End GetAzObject3
                    Return GetAzObject2 > Send $AzObject3
            End GetAzObject2
                Return ListItems > Send $AzObject2
        End ListItems
            Return Function > Send $AzObject
}#>
function ListItems {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureItem while ($true) { # Outer loop for managing function
            if (!$AzObject2) { # If $AzObject2 is $null
                $AzObject2 = GetAzObject2 # Calls function and assigns to $var
                if (!$AzObject2) { # If $AzObject2 is still $null
                    Break GetAzureItem # Breaks :GetAzureItem
                } # End if (!$AzObject2)
            } # End if (!$AzObject2)
            $Getlist = Get-AzResourceGroup # Creates lists and assigns to $GetList
            if (!$Getlist) { # If $Getlist returns empty
                Write-Host "No items found" # Message write to screen
                Break GetAzureItem # Breaks :GetAzureItem
            } # End if (!$Getlist)
            $GetlistNumber = 1 # Sets the base value of the list
            foreach ($_ in $Getlist) { # For each item in list
                Write-Host $GetlistNumber"." $_.ResourceGroupName # Writes list to screen
                $GetlistNumber = $GetlistNumber+1 # Adds 1 to $GetlistNumber
            } # End foreach ($_ in $Getlist)
            Write-Host "0. Exit" # Write message to screen
            $GetlistNumber = 1 # Resets list number to 1
            $GetlistSelect = Read-Host "Enter the option number" # Operator input for list selection
            if ($GetlistSelect -eq '0') { # If $GetListSelect is 0
                Break GetAzureItem # Breaks :GetAzureItem
            } # End if ($GetlistSelect -eq '0')
            :SelectAzureItem foreach ($_ in $Getlist) { # For each item in list
                if ($GetlistSelect -eq $GetlistNumber) { # If $GetListSelect matches the current $GetlistNumber
                    $AzObject = $_ # Assigns the current item to $AzObject
                    Break SelectAzureItem # Breaks :SelectAzureItem
                } # End if ($GetlistSelect -eq $GetlistNumber)
                else { # If user input does not match the current $GetlistNumber
                    $GetlistNumber = $GetlistNumber+1 # Adds 1 to $GetlistNumber
                } # End else (if ($GetlistSelect -eq $GetlistNumber))
            } # End :SelectAzureItem
            Return $AzObject # Returns $AzObject to calling function
        } # End :GetAzureItem while ($true) {
        Return # Returns $null to calling function
    } # End begin
} # End funciton ListItems