# Certificate Monitoring with Zabbix Agent 2 (Linux and Windows)

This guide merges the Linux and Windows setup for the BSKP certificate templates.

## 1. File structure

### Linux (NGINX container)

You need a Linux VM running Zabbix Agent 2. The scripts must be placed on this VM
(the NGINX container does not run the agent).

Copy the scripts to the Linux host where Zabbix Agent 2 runs:

```text
/scripts/zabbix/certificados/
  discover-certs.sh
  check_cert_expiry.sh
```

The scripts look for certificates inside an NGINX container.
Set the container name in the `CONTAINER` variable inside the scripts.

### Windows

Copy the scripts to the monitored Windows host:

```text
C:\Scripts\Zabbix\Certificados\
  discover-certs.ps1
  check_cert_expiry.ps1
```

## 2. zabbix_agent2.conf configuration

Edit `zabbix_agent2.conf` and add the following UserParameters.

### Linux

```ini
# Certificate monitoring (NGINX)
UserParameter=cert.lld.nginx,/scripts/zabbix/certificados/certs-lld.sh
UserParameter=cert.nginx.expira[*],/bskp/scripts/zabbix/certificados/cert-expira.sh $1
```

### Windows

```ini
# Certificate monitoring (Windows)
UserParameter=cert.discovery,powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\Zabbix\Certificados\discovery-certs.ps1"
UserParameter=cert.expira[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\Zabbix\Certificados\check_cert_expiry.ps1" -thumb "$1"
```

Restart Zabbix Agent 2 after saving changes.

## 3. Host configuration in Zabbix

### Linux

Create a host (e.g., "Certificates - Linux"), link the template `BSKP - Certificates Linux`,
and set the host IP of the Linux server where the certificates are installed.

### Windows

Create a host (e.g., "Certificates - Windows"), link the template `BSKP - Certificates Windows`,
and set the host IP of the Windows server where the certificates are installed.

## Notes

Expired certificates keep triggering until they are removed from the host.
