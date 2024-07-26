$TTL 86400
@   IN  SOA ns1.primario.com. admin.primario.com. (
              2024072501 ; Serial (alterar a cada modificação)
              3600       ; Refresh (1 hora)
              1800       ; Retry (30 minutos)
              1209600    ; Expire (2 semanas)
              86400 )    ; Minimum TTL (1 dia)

; 
@   IN  NS  ns1.primario.com.

ns1 IN  A   192.168.1.10

@   IN  A   192.168.1.10

www IN  A   192.168.1.10
