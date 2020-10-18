Configuration dsctestclfo32waagentlvm{
 
Import-DSCResource -Module nx
 
 Node linuxservers{
 
	nxFile dirNaske
	{
	Ensure = "Present"
	DestinationPath = "/opt/waahentDir"
	Type = "Directory"
	}
nxScript AzureWaagentLVM{
 
GetScript = @"
#!/bin/bash
pvs | grep rootvg |awk -F " " '{print $2}'"
"@
 
SetScript = @"
#!/bin/bash
> /etc/waagent.conf
cat <<EOT >> /etc/waagent.conf
echo Provisioning.Enabled=y
echo Provisioning.DeleteRootPassword=n
Provisioning.RegenerateSshHostKeyPair=y
Provisioning.SshHostKeyPairType=rsa
Provisioning.MonitorHostName=y
Provisioning.DecodeCustomData=n
Provisioning.ExecuteCustomData=n
Provisioning.AllowResetSysUser=n
Provisioning.PasswordCryptId=6
Provisioning.PasswordCryptSaltLength=10
LBProbeResponder=y
Logs.Verbose=n
OS.RootDeviceScsiTimeout=300
OS.OpensslPath=None
HttpProxy.Host=None
HttpProxy.Port=None
AutoUpdate.Enabled=y
EOT
"@
 
TestScript = @'
#!/bin/bash
LVMCHK=`pvs | grep rootvg |awk -F " " '{print $2}'`
if [ $LVMCHK == 'rootvg' ]
then
exit 1
else
exit 0
fi         
'@
    }
  }
}