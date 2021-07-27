# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzLocation:              Gets Azure location
} #>
<# Variables: {
    :GetAzureLocation           Outer loop for managing function
    :GetAzureLocationName       Inner loop for selecting the location
    $LocationList:              List of all Azure locations
    $LocationListNumber:        $Var used in selecting the location
    $LocationSelect:            Operator input for matching $LocationListNumber
    $LocationListSelect:        $LocationList object where $LocationList.Number equals $LocationSelect
    $LocationObject             Selected location object
} #>
<# Process Flow {
    Function
        Call GetAzLocation > Get $LocationObject
        End GetAzLocation
            Return Function > Send $LocationObject
}#>
function GetAzLocation2 { # Gets azure location
    Begin {
        :GetAzureLocation while ($true) { # Outer loop for managing function
            $LocationList = Get-AzLocation # Gets a list of all Azure locations
            $LocationListNumber = 1 # $Var for selecting the location
            foreach ($Location in $LocationList) { # For each item in $LocationList
                $Location | Add-Member -NotePropertyName 'Number' -NotePropertyValue $LocationListNumber
                $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
            } # End foreach ($Location in $LocationList)
            Write-Host "0 Exit" # Write message to screen
            foreach ($Location in $LocationList) {
                Write-Host $Location.Number $Location.DisplayName # Writes list to screen
            } # End foreach ($Location in $LocationList)
            :GetAzureLocationName while ($true) { # Inner loop for selecting location from list
                $LocationSelect = Read-Host "Please enter the number of the location" # Operator input for the selection
                if ($LocationSelect -eq '0') { # If $LocationSelect is 0
                    Break GetAzureLocation # Breaks :GetAzureLocation
                } # End if ($LocationSelect -eq '0')
                $LocationListSelect = $LocationList | Where-Object {$_.Number -eq $LocationSelect}
                if ($LocationListSelect) {
                    Break GetAzureLocationName
                } # End if ($LocationListSelect)
                Write-Host "That was not a valid selection" # Write message to screen 
            } # End :GetAzureLocationName while ($true)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $LocationListSelect.Location}
            Return $LocationObject # Returns $Location to calling function
        } # End :GetAzureLocation while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzLocation