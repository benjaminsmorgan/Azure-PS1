# Benjamin Morgan benjamin.s.morgan@outlook.com
# This script is used to connect to a VM using the VM name
function Function {
    begin{
        #Associates the VM name to the Public IP
        $VMNAME = Read-Host "VM Name: " # Prompt for the VM name
        $VM = Get-AzResource -Name $VMNAME -ResourceType Microsoft.Compute/virtualMachines | Where-Object {$_.Name -eq $VMNAME} # Assigns object to $vm1 by matching user input
        $VMNIC = Get-AzNetworkInterface -ResourceGroupName $VM.ResourceGroupName | Where-Object { $_.VirtualMachine.Id -eq $VM.ResourceId} # Assigns Nic object by VM name  
        $VMPubID = Get-AzPublicIpAddress -ResourceGroupName $VM.ResourceGroupName | Where-Object { $_.IpConfiguration.Id -eq $VMNic.IpConfigurations.ID} | Select-Object IpAddress # Assigns Public IP from Nic
        $VMIP = $VMPubID.IpAddress # Isolates the addres to a serperate value
        #End VM to IP association
        #Start Credential Pull
        $Secretname = $VM.Name # Associates the VMname to a new var used to pull the secret for $Pass
        $Pass= (Get-AzKeyVaultSecret -VaultName morganbskeyvault -Name $Secretname).SecretValueText # Retrieves the secret value text using the name pulled from the VM
        $USR = $VMIP + "\morganbs" # Creates variable for local adm account on VM
        cmdkey /generic:TERMSRV/$VMIP /user:$USR /pass:$Pass #assigns variables to RDC session
        #End Credential Pull
        #Start RDC
        mstsc /v:$VMIP #Starts RDC connection to first listed server
        #End RDC
    }
}
