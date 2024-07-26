# Builda a imagem do linux
FROM ubuntu:latest

# Atualiza os pacotes e instala o bind
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc dnsutils

# Copia os arquivos de configuração para o conteiner
COPY named.conf /etc/bind/named.conf
COPY named.conf.local /etc/bind/named.conf.local
COPY db.primario.com /etc/bind/db.primario.com

# Expõe a porta do DNS
EXPOSE 53/udp

# Ativa o comando final
CMD ["named", "-g", "-c", "/etc/bind/named.conf"]

