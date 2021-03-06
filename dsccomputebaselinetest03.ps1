Configuration dsccomputebaselinetest03
{
Import-DSCResource -Module nx


 Node linuxservers
 {
 
	nxFile dirComputebase
	{
	Ensure = "Present"
	DestinationPath = "/opt/dirCmbasetest03"
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
nxScript timezoneSet 
{
 
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
ExTIMEZONE='Europe/Amsterdam'
TIMEZONE=`timedatectl | sed -n 's/^\s*Time zone: \(.*\) (.*/\1/p`
if [ $TIMEZONE == $ExTIMEZONE ]
then
exit 0
else
exit 1
fi         
'@
}

nxScript OptRepository
{
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