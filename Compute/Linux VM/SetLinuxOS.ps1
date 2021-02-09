function SetLinuxOS {
    Begin {
        :SelectAzureLinuxPub while ($true) {
            [System.Collections.ArrayList]$ValidPub = @() # Creates the valid Pub array
            $ValidPubList = @('Ubuntu','RedHat','CentOS','SUSE','Debian','Oracle','CoreOS') # Creates a list of items to load into $ValidPub Array
            $PubNumber = 1 # Sets the base number for the valid Pub array
            foreach ($_ in $ValidPubList) { # For each item in $ValidPubList
                $PubInput = [PSCustomObject]@{'Name' = $_;'Number' = $PubNumber} # Creates the item to loaded into array
                $ValidPub.Add($PubInput) | Out-Null # Loads item into array, out-null removes write to screen
                $PubNumber = $PubNumber + 1 # Increments $PubNumber up 1
            } # End foreach ($_ in $ValidPubList)
            Write-Host '0 Exit'
            foreach ($_ in $ValidPub) { # For each item in $ValidPubt
                Write-Host $_.Number $_.Name # Write message to screen
            } # End foreach ($_ in $ValidPub)
            :SelectAzurePub while ($true) {
                $PubSelect = Read-Host "Publisher number"
                if ($PubSelect -eq '0') {
                    Break SelectAzureLinuxPub
                } # End ($PubSelect -eq '0')
                $PubObject = $ValidPub | Where-Object {$_.Number -eq $PubSelect}
                If ($PubObject) {
                    Break SelectAzurePub
                } # End If ($PubObject)
                else {
                    Write-Host "That was not a valid option"
                } # End else (# End If ($PubObject))
            } # End :SelectAzurePub while ($true)
            if ($PubObject.Name -eq 'Ubuntu') {
                $PubObject = 'Canonical'
            } # End ($PubObject.Name -eq 'Ubuntu')
            elseif ($PubObject.Name -eq 'RedHat') {
                $PubObject = 'RedHat'
            } # End elseif ($PubObject.Name -eq 'RedHat')
            elseif ($PubObject.Name -eq 'CentOS') {
                $PubObject = 'OpenLogic'
            } # End elseif ($PubObject.Name -eq 'CentOS')
            elseif ($PubObject.Name -eq 'SUSE') {
                $PubObject = 'SUSE'
            } # End elseif ($PubObject.Name -eq 'SuSE')
            elseif ($PubObject.Name -eq 'Debian') {
                $PubObject = 'credativ'
            } # End elseif ($PubObject.Name -eq 'Debian')
            elseif ($PubObject.Name -eq 'Oracle') {
                $PubObject = 'Oracle-Linux'
            } # End elseif ($PubObject.Name -eq 'Oracle')
            elseif ($PubObject.Name -eq 'CoreOS') {
                $PubObject = 'CoreOS'
            } # End elseif ($PubObject.Name -eq 'CoreOS')
            :ListAzureLinuxImage while ($true) {
                $ImageOfferList = Get-AzVMImageOffer -Location 'eastus' -PublisherName $PubObject
                $ImageOfferNumber = 1
                [System.Collections.ArrayList]$OfferArray = @() # Creates the valid Pub array
                foreach ($Offer in $ImageOfferList) {
                    $OfferInput = [PSCustomObject]@{'Name' = $Offer.Offer;'Number' = $ImageOfferNumber} # Creates the item to loaded into array
                    $OfferArray.Add($OfferInput) | Out-Null # Loads item into array, out-null removes write to screen
                    $ImageOfferNumber = $ImageOfferNumber + 1
                } # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"
                foreach ($_ in $OfferArray) {
                    Write-Host $_.Number $_.Name
                } # End foreach ($_ in $OfferArray)
                :SelectAzureLinuxImage while ($true) {
                    $OfferSelect = Read-Host "Enter the image number"
                    if ($OfferSelect -eq '0') {
                        Break SelectAzureLinuxPub    
                    } # End if ($OfferSelect -eq '0')
                    $LinuxOfferObject = $OfferArray | Where-Object {$_.Number -eq $OfferSelect}
                    if ($LinuxOfferObject) {
                        Break SelectAzureLinuxImage
                    } # End if ($LinuxOfferObject)
                    else {
                        Write-Host "That was not a valid option"
                    } # End else (if ($LinuxOfferObject))
                } # End :SelectAzureLinuxImage while ($true)
                $LinuxOfferObject = Get-AzVMImageOffer -Location 'Eastus' -PublisherName $PubObject | Where-Object {$_.Offer -eq $LinuxOfferObject.Name}
                Break :ListAzureLinuxImage
            } # End :ListAzureLinuxImage while ($true)
            :ListAzureLinuxSku while ($true) {
                $ImageSkuList = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer -Location 'eastus' -PublisherName $PubObject
                $ImageSkuNumber = 1
                [System.Collections.ArrayList]$SkuArray = @() # Creates the valid Pub array
                foreach ($Skus in $ImageSkuList) {
                    $SkuInput = [PSCustomObject]@{'Name' = $Skus.Skus;'Number' = $ImageSkuNumber} # Creates the item to loaded into array
                    $SkuArray.Add($SkuInput) | Out-Null # Loads item into array, out-null removes write to screen
                    $ImageSkuNumber = $ImageSkuNumber + 1
                } # End foreach ($Offer in $ImageOfferList)
                Write-Host "0 Exit"
                foreach ($_ in $SkuArray) {
                    Write-Host $_.Number $_.Name
                } # End foreach ($_ in $OfferArray)
                :SelectAzureLinuxSku while ($true) {
                    $SkuSelect = Read-Host "Enter the sku number"
                    if ($SkuSelect -eq '0') {
                        Break SelectAzureLinuxPub    
                    } # End if ($OfferSelect -eq '0')
                    $LinuxSkuObject = $SkuArray | Where-Object {$_.Number -eq $SkuSelect}
                    if ($LinuxSkuObject) {
                        Break SelectAzureLinuxSku
                    } # End if ($LinuxOfferObject)
                    else {
                        Write-Host "That was not a valid option"
                    } # End else (if ($LinuxOfferObject))
                } # End :SelectAzureLinuxImage while ($true)
                $LinuxSkuObject = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer -Location 'Eastus' -PublisherName $PubObject | Where-Object {$_.Skus -eq $LinuxSkuObject.Name}
                Return $LinuxSkuObject
            } # End :ListAzureLinuxImage while ($true)
        } # End :SelectAzureLinuxPub
        Return # Returns to calling function with null
    } # End Begin
} # End function