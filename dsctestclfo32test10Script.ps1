Configuration dsctestclfo32test10Script
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
timedatectl list-timezones  | grep "Europe/Amsterdam"
"@
 
SetScript = @"
#!/bin/bash
timedatectl set-timezone Europe/Amsterdam
"@
 
TestScript = @'
#!/bin/bash
ExTIMEZONE='Pacific/Midway'
TIMEZONE=`timedatectl list-timezones  | grep "Europe/Amsterdam"`
if [ $TIMEZONE == $ExTIMEZONE ]
then
exit 0
else
exit 1
fi         
'@
    }
  }
}