# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVMImageOffer:         https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimageoffer?view=azps-5.5.0
    Get-AzVMImageSku:           https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku?view=azps-5.5.0
    Azure Linux Publishers:     https://gmusumeci.medium.com/how-to-find-azure-linux-vm-images-for-terraform-or-packer-deployments-24e8e0ac68a     
} #>
<# Required Functions Links: {
    None:                       In order for this function to work, another function will need to pass $LocationObject.DisplayName
} #>
<# Functions Description: {
    SetLinuxOS:                 Function to get a valid image sku for linux VM
} #>
<# Variables: {      
    :GetAzureLinuxImage         Outer loop for managing function
    :SelectAzurePub             Inner loop for setting the publisher
    :SelectAzureLinuxImage      Inner loop for setting the image
    :SelectAzureLinuxSku        Inner loop for setting the sku
    $ValidPub:                  Array used in pub selection
    $ValidPubList:              List of Linux publishers
    $PubNumber:                 $Var used in publisher selection
    $PubInput:                  $Var used to load items into $ValidPub
    $PubSelect:                 Operator input for selecting an item in $ValidPub array
    $PubObject:                 The publisher object
    $ImageOfferList:            List of image offers for $PubObject
    $ImageOfferNumber:          $Var used in image offe selection
    $OfferArray:                Array used in image offer selection
    $OfferInput:                $Var used to load items into $OfferArray
    $OfferSelect:               Operator input for the offer selection
    $LinuxOfferObject:          Image offer object
    $ImageSkuList:              List of skus for $LinuxOfferObject
    $ImageSkuNumber:            $Var used in the selection of the sku
    $SkuArray:                  Array used in sku selection
    $SkuInput:                  $Var used to load items into $SkuArray
    $SkuSelect:                 Operator input for the Sku selection
    $LinuxSkuObject:            Image sku object
} #>
<# Process Flow {
    function
        Call SetLinuxOS > Get LinuxSkuObject
        End SetLinuxOS
            Return Function > Send $LinuxSkuObject
}#>
function SetLinuxOS {                                                                       # Function to get a valid image sku for linux VM
    Begin {                                                                                 # Begin function
        :GetAzureLinuxImage while ($true) {                                                 # Outer loop to manage function
            [System.Collections.ArrayList]$ValidPub = @()                                   # Creates the valid Pub array
            $ValidPubList = @('Ubuntu','RedHat','CentOS','SUSE','Debian','Oracle','CoreOS') # Creates a list of items to load into $ValidPub Array
            $PubNumber = 1                                                                  # Sets the base number for the valid Pub array
            foreach ($_ in $ValidPubList) {                                                 # For each item in $ValidPubList
                $PubInput = [PSCustomObject]@{'Name' = $_;'Number' = $PubNumber}            # Creates the item to loaded into array
                $ValidPub.Add($PubInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                $PubNumber = $PubNumber + 1                                                 # Increments $PubNumber up 1
            }                                                                               # End foreach ($_ in $ValidPubList)
            Write-Host '0 Exit'                                                             # Write message to screen
            foreach ($_ in $ValidPub) {                                                     # For each item in $ValidPubt
                Write-Host $_.Number $_.Name                                                # Write message to screen
            }                                                                               # End foreach ($_ in $ValidPub)
            :SelectAzurePub while ($true) {                                                 # Inner loop for selecting the publisher
                $PubSelect = Read-Host "Publisher number"                                   # Operator selection of the publisher
                if ($PubSelect -eq '0') {                                                   # If $Pubselect -eq 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End ($PubSelect -eq '0')
                $PubObject = $ValidPub | Where-Object {$_.Number -eq $PubSelect}            # $PubObject equals $ValidPub where $ValidPub.Number is equal to $PubSelect
                If ($PubObject) {                                                           # If $PubObject has a value
                    Break SelectAzurePub                                                    # Breaks :SelectAzurePub
                }                                                                           # End If ($PubObject)
                else {                                                                      # If $PubObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (# End If ($PubObject))
            }                                                                               # End :SelectAzurePub while ($true)
            if ($PubObject.Name -eq 'Ubuntu') {                                             # If $PubObject equals this value
                $PubObject = 'Canonical'                                                    # Reassigns the value of $PubObject
            }                                                                               # End ($PubObject.Name -eq 'Ubuntu')
            elseif ($PubObject.Name -eq 'RedHat') {                                         # If $PubObject equals this value
                $PubObject = 'RedHat'                                                       # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'RedHat')
            elseif ($PubObject.Name -eq 'CentOS') {                                         # If $PubObject equals this value
                $PubObject = 'OpenLogic'                                                    # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'CentOS')
            elseif ($PubObject.Name -eq 'SUSE') {                                           # If $PubObject equals this value
                $PubObject = 'SUSE'                                                         # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'SuSE')
            elseif ($PubObject.Name -eq 'Debian') {                                         # If $PubObject equals this value
                $PubObject = 'credativ'                                                     # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'Debian')
            elseif ($PubObject.Name -eq 'Oracle') {                                         # If $PubObject equals this value
                $PubObject = 'Oracle-Linux'                                                 # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'Oracle')
            elseif ($PubObject.Name -eq 'CoreOS') {                                         # If $PubObject equals this value
                $PubObject = 'CoreOS'                                                       # Reassigns the value of $PubObject
            }                                                                               # End elseif ($PubObject.Name -eq 'CoreOS')
            $ImageOfferList = Get-AzVMImageOffer -Location $LocationObject.DisplayName `
                -PublisherName $PubObject                                                   # Generates the image offer list
            $ImageOfferNumber = 1                                                           # Sets $ImageOfferNumber to 1
            [System.Collections.ArrayList]$OfferArray = @()                                 # Creates the valid Pub array
            foreach ($Offer in $ImageOfferList) {                                           # For each $Offer in $ImageOfferList
                $OfferInput = [PSCustomObject]@{'Name' = $Offer.Offer; `
                    'Number' = $ImageOfferNumber}                                           # Creates the item to loaded into array
                $OfferArray.Add($OfferInput) | Out-Null                                     # Loads item into array, out-null removes write to screen
                $ImageOfferNumber = $ImageOfferNumber + 1                                   # Increments $ImageofferNumber by 1
            }                                                                               # End foreach ($Offer in $ImageOfferList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $OfferArray) {                                                   # For each $_ in $OfferArray
                Write-Host $_.Number $_.Name                                                # Writes offer number and name to screen
            }                                                                               # End foreach ($_ in $OfferArray)
            :SelectAzureLinuxImage while ($true) {                                          # Inner loop to select the image offer
                $OfferSelect = Read-Host "Enter the image number"                           # Operator input for the offer selection
                if ($OfferSelect -eq '0') {                                                 # If $OfferSelect equals 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End if ($OfferSelect -eq '0')
                $LinuxOfferObject = $OfferArray | Where-Object {$_.Number -eq $OfferSelect} # $LinuxOfferObject is equal to $OfferArray where $OfferArray.Number equals $OfferSelect
                if ($LinuxOfferObject) {                                                    # If $LinuxOfferObject has a value
                    Break SelectAzureLinuxImage                                             # Breaks :SelectAzureLinuxImage
                }                                                                           # End if ($LinuxOfferObject)
                else {                                                                      # If $LinuxOfferObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LinuxOfferObject))
            }                                                                               # End :SelectAzureLinuxImage while ($true)
            $LinuxOfferObject = Get-AzVMImageOffer -Location $LocationObject.DisplayName `
                -PublisherName $PubObject | Where-Object {$_.Offer `
                -eq $LinuxOfferObject.Name}                                                 # Pulls the full $LinuxOfferObject
            $ImageSkuList = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer `
                -Location $LocationObject.DisplayName -PublisherName $PubObject             # Generates the $ImageSkuList
            $ImageSkuNumber = 1                                                             # Sets $ImageSkuNumber to 1
            [System.Collections.ArrayList]$SkuArray = @()                                   # Creates the $SkuArray     
            foreach ($Skus in $ImageSkuList) {                                              # For each Sku in $ImageSkuList
                $SkuInput = [PSCustomObject]@{'Name' = $Skus.Skus; `
                    'Number' = $ImageSkuNumber}                                             # Creates the item to loaded into array
                $SkuArray.Add($SkuInput) | Out-Null                                         # Loads item into array, out-null removes write to screen
                $ImageSkuNumber = $ImageSkuNumber + 1                                       # Increments $ImageSkuNumber by 1
            }                                                                               # End foreach ($Offer in $ImageOfferList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $SkuArray) {                                                     # For each $_ in $SkuArray
                Write-Host $_.Number $_.Name                                                # Writes $SkuArray.number and $SkuArray.Name to screen
            }                                                                               # End foreach ($_ in $OfferArray)
            :SelectAzureLinuxSku while ($true) {                                            # Inner loop for selecting the image sku
                $SkuSelect = Read-Host "Enter the sku number"                               # Operator input for selecting the image sku
                if ($SkuSelect -eq '0') {                                                   # If $SkuSelect equals 0
                    Break GetAzureLinuxImage                                                # Breaks :GetAzureLinuxImage
                }                                                                           # End if ($OfferSelect -eq '0')                                           
                $LinuxSkuObject = $SkuArray | Where-Object {$_.Number -eq $SkuSelect}       # $LinuxSkuObject equals $SkuArray where $SkuArray.Number equals $SkuSelect
                if ($LinuxSkuObject) {                                                      # If $LinuxSkuObject has a value
                    Break SelectAzureLinuxSku                                               # Break SelectAzureLinuxSku
                }                                                                           # End if ($LinuxOfferObject)
                else {                                                                      # If $LinuxSkuObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LinuxOfferObject))
            }                                                                               # End :SelectAzureLinuxImage while ($true)
            $LinuxSkuObject = Get-AzVMImageSku -Offer $LinuxOfferObject.Offer -Location `
                $LocationObject.DisplayName -PublisherName $PubObject | Where-Object `
                {$_.Skus -eq $LinuxSkuObject.Name}                                          # Pulls the full $LinuxSkuObject
            Return $LinuxSkuObject                                                          # Returns to calling function with $LinuxSkuObject
        }                                                                                   # End :GetAzureLinuxImage 
        Return                                                                              # Returns to calling function with null
    }                                                                                       # End Begin
}                                                                                           # End function SetLinuxOS