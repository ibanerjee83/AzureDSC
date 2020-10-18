Configuration dsctestclfo01test2{
 
Import-DSCResource -Module nx
 
Node linuxservers{
 
	nxFile dirNaske
	{
	Ensure = "Present"
	DestinationPath = "/opt/testclfo32"
	Type = "Directory"
	}
 nxFileLine Li_SELINUX
    {
    FilePath = "/etc/selinux/config"
    DoesNotContainPattern = 'SELINUX\=enforcing'
    ContainsLine = 'SELINUX=disabled'
    } 
 
}
}