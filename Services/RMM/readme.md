For offline alerts, the major cause is the horrible settings that Datto puts in place for CagService. 
On some systems, the service starts up before networking has fully started. 
Unfortunately, CagService doesn't restart in these situations, so the device stays offline although the service is running. 
Additionally, the default service recovery settings are set to 0 milliseconds for first, second and subsequent crashes. 
With all the recovery settings set the same, the recovery essentially burns itself out and will not trigger properly. 
So, if the service crashes for whatever reason, it will not restart.

To fix these issues, we push out the following settings to all Windows devices. 

The first is to set the service to a delayed start, the second configures some sane recovery settings of 1 minute for 1st and 2nd crashes, then 5 minutes for anything additional. 
We seldom have issues with false offline alerts. (The space after the = is correct.)

```bat
sc config cagservice start= delayed-auto
sc failure cagservice reset= 86400 actions= restart/60000/restart/60000/restart/300000
```

These settings get reset after every agent update. To make this a bit more automated, you can use the following components from the Datto Community ComStore.

Reliable Datto RMM Service Settings

Service Recovery Settings Monitor
