; Define o tempo de vida(86400 segundos = 1 dia)
$TTL 86400

; "@" refere-se ao domínio raiz especificado no arquivo de configuração do BIND para esta zona.
; "IN" especifica a classe de rede (Internet).
; "SOA" indica que este é o registro de início de autoridade.

@   IN  SOA ns1.primario.com. admin.primario.com. (
              2024072501 ; Serial (alterar a cada modificação)
              3600       ; Refresh (1 hora)
              1800       ; Retry (30 minutos)
              1209600    ; Expire (2 semanas)
              86400 )    ; Minimum TTL (1 dia)


; Define o servidor de nomes autoritativo para esta zona
; "@" refere-se ao domínio raiz da zona
; "NS" o registro de servidor de nomes
; "ns1.primario.com." é o nome do servidor de nomes
@   IN  NS  ns1.primario.com.


; Define o endereço IP para o servidor de nomes ns1
; "ns1" é o nome do servidor dentro deste domínio
; "A" indica um registro de endereço IPv4
; "192.168.1.10" é o endereço IP do servidor ns1
ns1 IN  A   192.168.1.10


; Define o endereço IP para o domínio principal
; "192.168.1.10" é o endereço IP associado ao domínio principal
@   IN  A   192.168.1.10


; Define o endereço IP para o subdomínio "www"
; "www" é o nome do subdomínio
; "192.168.1.10" é o endereço IP associado ao subdomínio www
www IN  A   192.168.1.10


; Define um registro CNAME
; "alias" é o nome do alias, ou seja, apelido
; "CNAME" indica um registro de nome canônico
; "www.primario.com." é o nome canônico para o qual "alias" aponta
alias.com IN  CNAME   www.primario.com.
