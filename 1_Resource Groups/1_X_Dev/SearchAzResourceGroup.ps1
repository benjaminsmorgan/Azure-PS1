function SearchAzResourceGroup {
    Begin {
        :SearchAzureRG while ($true) {
            :FindAzureTags while ($true) {
                $TagsList = Get-AzTag   
                $TagListNumber = 1
                [System.Collections.ArrayList]$TagListArray = @()                                # Creates the RG list array
                foreach ($_ in $TagsList) {                                                       # For each $_ in $RGListList
                    $TagListInput = [PSCustomObject]@{'Name' = $_.Name; `
                        'Number' = $TagListNumber}                                             # Creates the item to loaded into array
                    $TagListArray.Add($TagListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                    $TagListNumber = $TagListNumber + 1                                           # Increments $RGListNumber by 1
                } # End foreach ($_ in $TagsList)
                foreach ($_ in $TagListArray) {
                    Write-Host '['$_.Number']' $_.Name
                } # End foreach ($_ in $TagListArray)
                :SelectAzureTag while ($true) {
                    $TagSelectObject = Read-Host "[Option]"
                    if ($TagSelectObject -eq '0') {
                        Break SearchAzureRG
                    } # End if ($TagSelectObject -eq '0')
                    if ($TagSelectObject -in $TagArray) {
                        $RGObject = Get-AzResourceGroup | Where-Object {$_.Tags}
                    } # End if ($TagSelectObject -in $TagArray)
                } # End :SelectAzureTag while ($true)
            } # End :FindAzureTags while ($true)
        } # End :SearchAzureRG while ($true)
    } # End Begin
} # End function SearchAzResourceGroup