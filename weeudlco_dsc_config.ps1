configuration weeus03dlclfo32_dsc_config
{
Import-DscResource -ModuleName 'LinuxDefaultConfigurations'

    
node "localhost"
{
Li_Firewall Li_Firewall{ } 
Li_SELINUX Li_SELINUX{}
Li_setTimezone Li_setTimezone{} 
Li_tmp_mountOption Li_tmp_mountOption{}
Li_AzureWaagentLVM Li_AzureWaagentLVM{}
Li_local_passchange_policy Li_local_passchange_policy{}
Li_redhat_Optional_repoSet Li_redhat_Optional_repoSet{}
}
}
