Configuration dsctestclfo01{
 
Import-DSCResource -Module nx
 
Node mylinux{
 
nxFile dirNaske
{
Ensure = "Present"
DestinationPath = "/opt/naske"
Type = "Directory"
}
 
}
}