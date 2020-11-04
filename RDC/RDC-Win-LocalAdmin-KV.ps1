# Ref https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-powershell-sample-collect-vm-details
function Connect-RDC {
    param (
        # RG is used to determine the name of the resource group which is housing the VM
        [Parameter(Mandatory=$true, Position=0)]
        [String] $RG
    )
    Begin{
        $RGName = (Get-AzResourceGroup -Name $RG).ResourceGroupName
        $VMList = Get-AzVM -ResourceGroupName $RGName
        $PublicIps = Get-AzPublicIpAddress -ResourceGroupName $RGName # Pulls all public IP addresse resources
        $Nics = Get-AzNetworkInterface -ResourceGroupName $RGName | ?{ $_.VirtualMachine -NE $null} # Pulls all network interfaces where the VM is not null
        foreach ($nic in $Nics) { # $Nic is the entire pulled item, This statement is for each object (and its parts) within $NICS do the following
            $info = "" | Select PublicIPAddress # Creates the info var using the Public IP info from Get-AZNetworkInterface  (This Field is mostly empty but does contain the ID)
            $vm = $VMList | ? -Property Id -eq $nic.VirtualMachine.id # In $VMList (Var containing all VMs from the selected RG) where -Property ID is = $nic.ID add to $VM
            foreach($publicIp in $publicIps) { # This foreach cycle associates the publicID to the NIC using the shared .ID info
                if($nic.IpConfigurations.id -eq $publicIp.ipconfiguration.Id) { # When running Get-AzPublicIPAddress and Get-AzNetworkInterface against the same VM, the ID fields will be the same
                    $info.PublicIPAddress = $publicIp.ipaddress # This overwrites the info var from earlier with the matching IP address from the public IP resource
                } 
            } 
            $connect = Read-Host "Do you want to connect to "$VM.Name"?" # Prompts the user to connect to each VM with the resource group
            if ($connect -like "y*") { # Covers and user input starting with y or Y
                $Secretname = $VM.Name # Associates the VMname to a new var used to pull the secret for $Pass
                $Pass= (Get-AzKeyVaultSecret -VaultName morganbskeyvault -Name $Secretname).SecretValueText # Retrieves the secret value text using the name pulled from the VM
                $ConIP = $info.PublicIPAddress # info had to be ported to a different VAR, $publicIP.ipadress causes issues with passing credentials
                $USR = $ConIP + "\morganbs" # Creates variable for local adm account on VM
                cmdkey /generic:TERMSRV/$ConIP /user:$USR /pass:$Pass #assigns variables to RDC session
                mstsc /v:$ConIP #Starts RDC connection to first listed server
            }
            else {
            }
        } 
    }
}
