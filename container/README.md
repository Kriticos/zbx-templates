# BSKP - Container - Monitor Linux

Template para monitoramento basico de containers Linux com itens TRAP.
Os dados devem ser enviados para o Zabbix com as chaves abaixo.

## Itens (chaves)

- `container.cpu.util`: percentual de uso de CPU
- `container.memory.util`: memoria usada (B)
- `container.disk.read.bytes`: total lido desde o inicio (B)
- `container.disk.write.bytes`: total gravado desde o inicio (B)
- `container.net.rx.bytes`: total recebido desde o inicio (B)
- `container.net.tx.bytes`: total enviado desde o inicio (B)
- `container.pids`: quantidade de processos em execucao

## Macros

- `{$CPU.UTIL.MAX}`: limite de CPU para alerta (padrao 90)
- `{$NO.DATA.TIME}`: janela sem dados para alerta (padrao 10m)
- `{$PROC.MIN}`: minimo de processos esperados (padrao 1)

## Alertas principais

- Uso alto de CPU
- Sem dados recebidos
- Sem processos em execucao
- Sem trafego de rede

## Instalacao no servidor Docker

Para enviar os dados, o host Docker precisa ter o Zabbix Agent 2 instalado e o script salvo localmente com execucao via cron.

### 1) Instalar o Zabbix Agent 2

Exemplo (Debian/Ubuntu):

```bash
sudo apt-get update
sudo apt-get install -y zabbix-agent2
```

Em outras distros, instale o pacote equivalente `zabbix-agent2` via gerenciador de pacotes.

### 2) Salvar o script no servidor

Copie o script para um caminho padrao e deixe executavel:

```bash
sudo mkdir -p /usr/local/bin
sudo cp ./container/scripts/<SEU_SCRIPT>.sh /usr/local/bin/<SEU_SCRIPT>.sh
sudo chmod +x /usr/local/bin/<SEU_SCRIPT>.sh
```

### 3) Criar a cron para execucao periodica

Exemplo executando a cada 1 minuto:

```bash
sudo crontab -e
```

Adicione a linha:

```cron
* * * * * /usr/local/bin/<SEU_SCRIPT>.sh >/tmp/<SEU_SCRIPT>.log 2>&1
```
