# Tutorial - Monitoramento de Certificados no Linux com Zabbix Agent 2

Este guia aplica o template `BSKP - Certificates Linux` (NGINX) e depende de dois scripts no host Linux.

## 1. Estrutura de arquivos

Copie os scripts para o servidor Linux onde o Zabbix Agent 2 roda.

Exemplo:

```text
/bskp/scripts/zabbix/certificados/
  discover-certs.sh
  check_cert_expiry.sh
```

Os scripts foram feitos para localizar certificados dentro de um container NGINX.
Defina o nome do container na variavel `CONTAINER` dentro dos scripts.

## 2. Configuracao do zabbix_agent2.conf

Edite o arquivo `zabbix_agent2.conf` no host Linux e adicione:

```ini
# Certificate monitoring (NGINX)
UserParameter=cert.lld.nginx,/bskp/scripts/zabbix/certificados/discover-certs.sh
UserParameter=cert.nginx.expira[*],/bskp/scripts/zabbix/certificados/check_cert_expiry.sh $1
```

Reinicie o Zabbix Agent 2 apos salvar.

## 3. Configuracao do host no Zabbix

Crie um host (ex.: "Certificates - Linux"), associe o template `BSKP - Certificates Linux`
e aponte o IP do servidor onde os certificados estao instalados.

## Observacao

Certificados expirados continuam gerando alerta ate serem removidos do host.
