# Builda a imagem do linux
FROM ubuntu:latest

# Atualiza os pacotes(apt update) e instala o bind9, utilitarios do dns , (netcat e ping para fins de teste) 
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc dnsutils netcat-openbsd iputils-ping curl

# Copy -> Copia os arquivos de configuração para o conteiner

# named.conf contem os includes dos demais arquivos
COPY named.conf /etc/bind/named.conf
#named.conf.local contem as zonas utilizadas
COPY named.conf.local.primario /etc/bind/named.conf.local
#db.primario contem as configurações da zona
COPY db.primario.com /etc/bind/db.primario.com
#rndc controla a operação do servidor de nomes
COPY rndc.key /etc/bind/rndc.key

COPY named.conf.options /etc/bind/named.conf.options

#dá permissão à pasta dentro do container
RUN chown -R bind:bind /etc/bind 

# Expõe a porta do DNS
EXPOSE 53/udp 53/tcp

# Ativa o comando final
CMD ["named", "-g", "-c", "/etc/bind/named.conf"]

