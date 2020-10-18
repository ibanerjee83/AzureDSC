Configuration dsctestclfo32test11Script
{
 
Import-DSCResource -Module nx
 
 Node linuxserversscript
 {
 
	nxFile dirOptrepo
	{
	Ensure = "Present"
	DestinationPath = "/opt/scriptOptRepo"
	Type = "Directory"
	}

nxScript OptRepository{
 
GetScript = @"
#!/bin/bash
yum repolist enabled | grep "rhui-rhel-7-server-rhui-optional-rpms"
"@
 
SetScript = @"
#!/bin/bash
yum-config-manager --enable rhui-rhel-7-server-rhui-optional-rpms
"@
 
TestScript = @'
#!/bin/bash
OPTREPO=`yum repolist enabled | grep "rhui-rhel-7-server-rhui-optional-rpms"|wc -l`
if [ $OPTREPO -eq 0 ]
then
exit 1
else
exit 0
fi         
'@
    }
  }
}