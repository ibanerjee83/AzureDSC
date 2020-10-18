configuration weeus03dlclfo15_dsc_config
{
Import-DscResource -ModuleName 'LinuxDefaultConfigurations'

    
node "localhost"
{
Li_Firewall Li_Firewall0{ } 

}
}
