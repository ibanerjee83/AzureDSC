Configuration dsctestclfo01test9Script
{
 
Import-DSCResource -Module nx
 
 Node linuxserversscript
 {
 
	nxFile dirNaske
	{
	Ensure = "Present"
	DestinationPath = "/opt/scriptTestansible"
	Type = "Directory"
	}

nxScript ansiblePassExp {
 
GetScript = @"
#!/bin/bash
chage -l ansible | grep -E "Password expires" | awk '{print $1, $2, $4}'
"@
 
SetScript = @"
#!/bin/bash
chage -m 0 -M 99999 -I -1 -E -1 ansible
"@
 
 TestScript = @'
#!/bin/bash
value=`chage -l ansible | grep -E "Password expires" | cut -d":" -f2`
if [ $value != 'never' ]
then
    exit 0
else
    exit 1
fi
'@
    }
  }
}