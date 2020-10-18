Configuration dsctestclfo01test4{
 
Import-DSCResource -Module nx
 
 Node linuxservers{
 
	nxFile dirNaske
	{
	Ensure = "Present"
	DestinationPath = "/opt/testclfo01"
	Type = "Directory"
	}
    nxFileLine Li_SELINUX
    {
    FilePath = "/etc/selinux/config"
    DoesNotContainPattern = 'SELINUX\=enforcing'
    ContainsLine = 'SELINUX=disabled'
    } 
    nxFileLine Li_local_passchange_policy
    {
     FilePath = "/etc/login.defs"
	 DoesNotContainPattern = 'PASS_MIN_DAYS'
     ContainsLine = "PASS_MIN_DAYS 0"
    }
    nxFileLine Li_tmp_mountOption 
	{
     FilePath = "/etc/fstab"
	 DoesNotContainPattern = '/dev/mapper/rootvg-tmplv '
     ContainsLine = "/dev/mapper/rootvg-tmplv /tmp xfs default,strictatime,nodev,nosuid 0 0"
    }
  }
}