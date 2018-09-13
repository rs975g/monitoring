# monitoring_tools
Scripts to check access to nodes and to open op center, DT dashboard and Ambari in PVPC, Japana, ASV and other environments.

Steps:

1. git clone this repo
1. run `./install.sh`
1. ensure your JumpHost is configured correctly in `~/.ssh/config`. In `~/.ssh/config`, search `Host cf_jumphost_1`, and check the `HostName` to make sure that it's the jump host use to connect to C3 overall (the IP address you were given when you first requested access to CF3).  
1. To check access run: `check_all_env_access <env>`. Example `check_all_env_access pvpc`. Note: this assumes that you are connected to correct VP (example CF3 VPN for pvpc) 
1. To open browser sessions for Op Center, DT, Ambari: `prod_monitor <env>`. Example: prod_monitor pvpc Note: this assumes that you are connected to correct VP (example CF3 VPN for pvpc) 
