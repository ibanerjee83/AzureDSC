Configuration dsctestclfo01test8{
 
Import-DSCResource -Module nx
Import-DSCResource -Module nxComputerManagement

 
 Node linuxservers{
 
	nxFile dirtimeZone
	{
	Ensure = "Present"
	DestinationPath = "/opt/timezonecheck"
	Type = "Directory"
	}
    nxComputer ComputerSettings{
	Name= "weeus03dlclfo01"
	TimeZoneName = "Asia/Calcutta"
	}
  }
}