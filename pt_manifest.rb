Facter.add(:pt_manifest) do
  if Dir.exist?('/opt/oracle/psft/pt/')
    setcode do
      pt_manifest = {
        "PeopleTools" => {
          "version" => `su - psadm2 -c "/opt/oracle/psft/pt/8.5?.??/bin/psadmin -v"`.chomp,
          "jre"     => `su - psadm2 -c "/opt/oracle/psft/pt/8.5?.??/jre/bin/java -version 2>&1 |grep 'SE Runtime Environment'"`.chomp,
        },
        "OracleClient" => {
          "version" => `su - oracle -c "/opt/oracle/psft/pt/oracle-client/12.1.0.2/bin/sqlplus -v |grep 'SQL'"`.chomp,
          "opatch"  => `su - oracle -c "/opt/oracle/psft/pt/oracle-client/12.1.0.2/OPatch/opatch version 2>&1 |grep 'OPatch Version'"`.chomp,
          "patches" => `su - oracle -c "/opt/oracle/psft/pt/oracle-client/12.1.0.2/OPatch/opatch lspatches |grep '^[0-9]'"`.chomp,
        },
        "WebLogic" => {
          "version" => `su - psadm1 -c ". /opt/oracle/psft/pt/bea/wlserver/server/bin/setWLSEnv.sh >/dev/null 2>&1 && java weblogic.version 2>/dev/null |grep 'WebLogic Server'"`.chomp,
          "opatch"  => `su - psadm1 -c "/opt/oracle/psft/pt/bea/OPatch/opatch version 2>&1 |grep 'OPatch Version'"`.chomp,
          "patches" => `su - psadm1 -c "/opt/oracle/psft/pt/bea/OPatch/opatch lspatches -oh /opt/oracle/psft/pt/bea 2>/dev/null |grep '^[0-9]'"`.chomp,
          "jdk"     => `su - psadm1 -c "/opt/oracle/psft/pt/jdk1.7/bin/java -version 2>&1 |grep 'SE Runtime Environment'"`.chomp,
        },
        "Tuxedo" => {
          "version" => `su - psadm1 -c "/opt/oracle/psft/pt/bea/tuxedo/tuxedo12.1.3.0.0/bin/tmadmin -v 2>&1"`.chomp
        },
      }
    end
  else
    setcode do
      pt_manifest = "PeopleTools not installed"
    end
  end
end
