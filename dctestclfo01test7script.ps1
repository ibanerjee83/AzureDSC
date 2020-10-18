Configuration dsctestclfo01test7Script
{
 
Import-DSCResource -Module nx
 
 Node linuxserversscript
 {
 
    nxFile dirNaske
    {
    Ensure = "Present"
    DestinationPath = "/opt/scriptTest"
    Type = "Directory"
    }
       nxScript "timezoneset" 
    {
    
      GetScript = @'
       #!/bin/bash
        TIMEZONE=`timedatectl list-timezones  | grep "Europe/Amsterdam"`
'@
    
         TestScript = @'
        #!/bin/bash
        #ExTIMEZONE='Europe/Amsterdam'
         ExTIMEZONE='Pacific/Midway'
         TIMEZONE=`timedatectl list-timezones  | grep "Europe/Amsterdam"`

 

         if [ $TIMEZONE == $ExTIMEZONE ]
           then
             echo "Timezone equal $TIMEZONE"
           exit 0
         else
            echo "Timezone not equal $TIMEZONE"
          exit 1
         fi         
'@ 

 

      SetScript = @'
           timedatectl set-timezone Europe/Amsterdam
'@    
    }
  }
}