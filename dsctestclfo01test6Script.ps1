Configuration dsctestclfo01test6Script
{
 
Import-DSCResource -Module nx
 
 Node linuxserversscript
 {
 
	nxFile dirNaske
	{
	Ensure = "Present"
	DestinationPath = "/opt/testclfoscript"
	Type = "Directory"
	}
    nxScript "timezoneset" 
	{
	  GetScript = @'
       #!/bin/bash
        TIMEZONE=`timedatectl list-timezones  | grep "Europe/Amsterdam"`
'@
      SetScript = @'
           timedatectl set-timezone Europe/Amsterdam
'@	

   	  TestScript = @'
        #!/bin/bash
		exit 1
'@
	}
  }
}