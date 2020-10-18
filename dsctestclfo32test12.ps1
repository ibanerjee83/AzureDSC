Configuration dsctestclfo32test12
{
 
Import-DSCResource -Module nx
 
 Node linuxserversscript
 {
 
	nxFile PkgIns
	{
	Ensure = "Present"
	DestinationPath = "/opt/PkgIns"
	Type = "Directory"
	}
    nxPackage gdisk {
    Name = 'gdisk'
    Ensure = "Present"
    PackageManager = "yum" 
	}
    nxPackage sclutils {
    Name = 'scl-utils'
	Ensure = "Present"
    PackageManager = "yum" 
    }

  }
}