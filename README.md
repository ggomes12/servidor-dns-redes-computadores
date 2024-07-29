<h1 style="text-align: center;">
  servidor-dns-redes-computadores
</h1>

O objetivo deste trabalho é desenvolver um sistema completo utilizando Docker que inclua um serviço de DNS (primário e secundário) e servidores HTTP com balanceamento de carga.


![Estrutura HTTP](images/docker.png)
![Estrutura HTTP](images/python.png)

## Descrição do Projeto

O projeto inclue uma infraestrutura utilizando Docker atendendo os seguintes requisitos de estruturação:

**Serviço DNS**

    Servidor DNS Primário
    Servidor DNS Secundário

**Serviço HTTP**

    Servidores HTTP
    Balanceamento de Carga

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

Diretório `dns`

    Dockerfile: Define a imagem Docker para o servidor DNS.
    named.conf: Configuração principal do BIND9.
    db.: Arquivo de zona para o domínio ....
    db.: Arquivo de zona para o domínio backup.
    db.: Arquivo de zona reversa.

Diretório `http`

    Dockerfile: Define a imagem Docker para os servidores HTTP.
    index.html: Página inicial para os servidores HTTP.
    nginx.conf: Configuração do Nginx.

Diretório `load_balancer`

    Dockerfile: Define a imagem Docker para o balanceador de carga.
    haproxy.cfg: Configuração do HAProxy para balanceamento de carga.

Arquivo `docker-compose.yml`

    Define os serviços Docker e como eles interagem entre si.

## Pré-requisitos

    Docker instalado na máquina.
    Docker Compose instalado.

## Como executar o projeto

1. **Clone o repositório do projeto:**

    ```bash
    $ git clone https://github.com/ggomes12/servidor-dns-redes-computadores.git
    ```

2. **Navegue para o diretório do projeto:**

    ```bash
    $ cd servidor-dns-redes-computadores
    ```

3. **Suba os containers:**

    ```bash
    $ docker-compose up 
    ```

4. **Verifique os logs:**

    - No Windows:
      ```bash
      $ docker-compose logs
      ```

    - No MacOS/Linux:
      ```bash
      $ docker-compose logs
      ```

5. **Acesse o sistema:**

    ```bash
    $ curl http://localhost
    ```

6. **Testar o DNS:**

    ```bash
    $ dig @localhost exemplo.com
    ```

7. **Verificar balanceamento de carga:**

    ```bash
    $ curl http://localhost/balanceamento
    ```

## Exemplos de teste na criação e orquestração dos containers docker


1. **Buildando so containers**
   
    **Explicação do que será testado:**

    Antes de iniciar os containers, é necessário construir as imagens Docker para cada um dos serviços definidos no arquivo docker-compose.yml. Este passo garante que todas as dependências e configurações estejam prontas para a execução dos containers.

    **Comando para buldar os container:**

    ```bash
    $ docker-compose build --no-cache
    ```


    <img src="images/foto01.png">

    **Explicação do que foi testado:**

    O comando docker-compose build --no-cache lê o docker-compose.yml e, em seguida, constrói as imagens Docker conforme especificado nos respectivos Dockerfiles. Este comando prepara todas as imagens necessárias para serem executadas como containers, garantindo que todas as dependências sejam baixadas e configuradas corretamente sem utilizar cache.

2. **Upando os containers**

    **Explicação do que será testado:**

    Após construir as imagens, o próximo passo é iniciar os containers. Este comando cria e inicia os containers conforme especificado no arquivo docker-compose.yml.

    **Comando para upar os container:**

    ```bash
    $  docker-compose up -d
    ```
    <img src="images/image2.png">


    **Explicação do que foi testado:**

    O comando docker-compose up -d inicia os containers em modo desacoplado (background). Isso permite que os serviços definidos no docker-compose.yml sejam executados como containers independentes. A saída do comando confirma a criação e o início dos containers, bem como a criação das redes necessárias.

3. **Verificando os containers**

    **Explicação do que será testado:**

    Após iniciar os containers, é importante verificar se todos estão em execução conforme esperado. Este comando lista todos os containers em execução e seus respectivos estados.

    **Comando para verificar os container:**

    ```bash
    $ docker-compose ps

    ```
    <img src="images/imagem3.png">
    
    imagens para melhor visualização:

    <img src="images/imagem4.png">
    <img src="images/imagem5.png">

    **Explicação do que foi testado:**

    O comando docker-compose ps lista todos os containers definidos no docker-compose.yml que estão em execução, juntamente com seus status, portas expostas e comandos de inicialização. Isso confirma que todos os serviços foram iniciados corretamente e estão prontos para uso.

Os containers acima já estão funcionando. A partir do próximo tópico, será mostrado os testes de cada um deles.

## Exemplos de teste para cada container


1. **Abrindo um branch dentro do container, com o comando**:


    ```bash
    $ docker exec -it dns-primario /bin/bash
    ```

    <img src="images/imagem6.png">

    O comando acima serve para abrir um terminal bash (shell) dentro do container chamado dns-primario.

2. **Resolução de nomes no primário**

    <img src="images/imagem7.png">

    Uma vez que o terminal bash no container esteja aberto, o comando dig pode ser utilizado para testar a resolução de nomes internamente.
   


3. **Resolução de nomes no secundário**

    **Explicação do que será testado:**

    Para garantir que o servidor DNS secundário está funcionando corretamente e pode resolver nomes de domínio do servidor DNS primário, realizamos uma consulta DNS diretamente no container do servidor DNS secundário.

    Comando para acessar o container do servidor DNS secundário e realizar a consulta:

    ```bash
    $ docker exec -it dns-secundario /bin/bash
    ```

    <img src="images/imagem8.png">

    
    **Explicação do que foi testado:**

    O comando docker exec -it dns-secundario /bin/bash permite acessar o terminal interativo do container do servidor DNS secundário. Dentro desse container, o comando dig @localhost primario.com é utilizado para testar a resolução de nomes, consultando o servidor DNS primário para verificar se o domínio primario.com é resolvido corretamente. Esse teste confirma que o servidor DNS secundário pode se comunicar com o primário e resolver nomes de domínio conforme esperado.



4. **Verificando o servidor HTTP**

    **Explicação do que será testado:**
    
    Para garantir que os servidores HTTP estão funcionando corretamente, acessamos cada container dos servidores HTTP (http-server1, http-server2 e http-server3) e utilizamos o comando curl para verificar o conteúdo servido por cada servidor.

    Comandos para acessar os containers dos servidores HTTP e realizar a verificação:

    **Para o http-server1:**
    ```bash
    $ docker exec -it http-server1 /bin/bash
    ```
    <img src="images/imagem9.png">

    **Para o http-server2:**
    ```bash
    $ docker exec -it http-server2 /bin/bash
    ```
    <img src="images/imagem10.png">


    **Para o http-server3:**
    ```bash
    $ docker exec -it http-server3 /bin/bash
    ```
    <img src="images/imagem11.png">

    **Explicação do que foi testado:**

    Os comandos docker exec -it http-server1 /bin/bash, docker exec -it http-server2 /bin/bash e docker exec -it http-server3 /bin/bash permitem acessar os terminais interativos dos containers dos servidores HTTP1, HTTP2 e HTTP3, respectivamente. Dentro de cada container, o comando "curl http: // localhost" é utilizado para enviar uma solicitação HTTP ao próprio servidor. Isso retorna o conteúdo da página index.html, confirmando que cada servidor HTTP está configurado corretamente e está servindo o conteúdo esperado. Este teste é realizado no terminal Linux e verifica se a configuração de cada servidor HTTP está funcionando como esperado.

5. **Verificando a conectividade entre os servidores HTTP**
    **Explicação do que será testado:**

    Para garantir que os servidores HTTP podem se comunicar entre si, acessamos o container do http-server1 e utilizamos o comando ping para verificar a conectividade com os outros dois servidores HTTP (http-server2 e http-server3).

    Comando para acessar o container do http-server1 e realizar o ping:
    ```bash
    $ docker exec -it http-server1 /bin/bash

    ```

    Dentro do terminal do container:
    ```bash
    $ ping http-server2
    $ ping http-server3

    ```
    <img src="images/imagem12.png">

    **Explicação do que foi testado:**
    
    Após acessar o container do http-server1, utilizamos o comando ping para verificar a conectividade entre os servidores HTTP (http-server2 e http-server3). Isso confirma que os servidores HTTP podem se comunicar entre si, garantindo a funcionalidade correta da rede configurada pelo Docker Compose.

6. **Verificando a conectividade com o load balancer**

    **Explicação do que será testado:**

    Além de verificar a conectividade entre os servidores HTTP, também é importante garantir que os servidores HTTP possam se comunicar com o load balancer. Ainda dentro do acesso do container do http-server1 utilizamos o comando ping para verificar a conectividade com o load balancer.

    ```bash
    $ ping load-balancer
    ```
    <img src="images/imagem13.png">

    **Explicação do que foi testado:**

    Utilizamos o comando ping dentro do container do http-server1 para verificar a conectividade com o load balancer. O load balancer é responsável por distribuir o tráfego de rede de forma equilibrada entre os servidores HTTP, garantindo que nenhuma única máquina fique sobrecarregada. Isso confirma que o servidor HTTP pode se comunicar com o load balancer, garantindo a funcionalidade correta da rede configurada pelo Docker Compose.

7. **Verificando a conectividade entre os servidores DNS**

    **Explicação do que será testado:**

    Para garantir que os servidores DNS podem se comunicar entre si, acessamos os containers dns-secundario e dns-primario e utilizamos o comando ping para verificar a conectividade entre eles.

    **Primeiro teste**: Acessando o container do dns-secundario e pingando o dns-primario:
    ```bash
    $ docker exec -it dns-secundario /bin/bash
    ```
    Dentro do terminal do container dns-secundario:
    ```bash
    $ ping dns-primario
    ```
    <img src="images/imagem14.png">

    **Explicação do que foi testado:**

    Utilizamos o comando ping dentro do container do dns-secundario para verificar a conectividade com o dns-primario. Isso confirma que o servidor DNS secundário pode se comunicar com o servidor DNS primário, garantindo a funcionalidade correta da rede configurada pelo Docker Compose.

    **Segundo teste:** Acessando o container do dns-primario e pingando o dns-secundario:
    ```bash
    $ docker exec -it dns-primario /bin/bash
    ```
    Dentro do terminal do container dns-primario:
    ```bash
    $ ping dns-secundario
    ```
    <img src="images/imagem15.png">

    **Explicação do que foi testado:**

    Utilizamos o comando ping dentro do container do dns-primario para verificar a conectividade com o dns-secundario. Isso confirma que o servidor DNS primário pode se comunicar com o servidor DNS secundário, garantindo a funcionalidade correta da rede configurada pelo Docker Compose.

8. **Solicitando transferência de zona do DNS secundário**

    **Explicação do que será testado:**

    Para garantir que o servidor DNS secundário (dns-secundario) está corretamente configurado para replicar os dados do servidor DNS primário (dns-primario), acessamos o container dns-secundario e solicitamos manualmente uma transferência de zona. Esse teste verifica se todos os registros da zona primario.com são transferidos corretamente para o servidor secundário.

    Comando para acessar o container do dns-secundario e solicitar a transferência de zona:
     ```bash
    $ docker exec -it dns-secundario /bin/bash
    ```
    Dentro do terminal do container dns-secundario:
     ```bash
    $ dig @dns-primario primario.com AXFR
    ```
    **Explicação do que foi testado:**

    Utilizamos o comando dig @dns-primario primario.com AXFR dentro do container dns-secundario para solicitar uma transferência de zona do servidor DNS primário. A transferência de zona (AXFR) é um processo pelo qual todos os registros de uma zona DNS são copiados do servidor primário para o servidor secundário. O comando retorna todos os registros da zona primario.com, demonstrando que o servidor DNS secundário é uma cópia exata do servidor primário. Isso confirma que a replicação dos dados DNS entre os servidores está funcionando corretamente.

    <img src="images/imagem16.png">

9. **Testando a falha do servidor DNS primário**

    **Explicação do que será testado:**

    Para garantir que o servidor DNS secundário (dns-secundario) pode atuar como substituto do servidor DNS primário (dns-primario) em caso de falha, paramos o container do servidor DNS primário e verificamos se o servidor DNS secundário consegue resolver consultas para a zona primario.com. Esse teste confirma que o servidor DNS secundário está corretamente configurado para assumir a função do primário em caso de falha.

    Parando o container do servidor DNS primário:
    ```bash
    $ docker stop dns-primario
    ```
    Acessando o container do dns-secundario e solicitando a resolução de nome:
    ```bash
    $ docker exec -it dns-secundario /bin/bash
    ```
    Comando para verificar o estado dos containers:
    ```bash
    $ docker-compose ps -a
    ```
    <img src="images/imagem17.png">

    Comando para acessar o container do dns-secundario e realizar a consulta:
    ```bash
    $ docker exec -it dns-secundario /bin/bash
    ```
    Dentro do terminal do container dns-secundario:
    ```bash
    $ dig primario.com
    ```
    <img src="images/imagem18.png">

    **Explicação do que foi testado:**

    Após parar o container do dns-primario, utilizamos o comando docker-compose ps -a para verificar que o container do dns-primario está parado e que os outros containers estão em execução. Em seguida, acessamos o container do dns-secundario e utilizamos o comando dig primario.com para solicitar a resolução do nome primario.com. O comando retornou a resposta correta, demonstrando que o servidor DNS secundário está atuando corretamente no lugar do servidor primário em caso de falha. Isso confirma que o servidor DNS secundário está configurado para continuar fornecendo resolução de nomes mesmo na ausência do servidor primário.

10. **Inspecionando as redes ativas no Docker**

    **Explicação do que será testado:**

    Para testar o balanceamento de carga, é essencial verificar as redes ativas no Docker para garantir que todas as redes necessárias estão corretamente configuradas. Isso inclui inspecionar a rede específica onde os containers HTTP estão conectados, o que é crucial para testar a distribuição de carga entre os servidores HTTP.

    **Passo 1:** Inspecionando as redes ativas no Docker:
    ```bash
    $ docker network ls
    ```
    <img src="images/imagem19.png">

    **Passo 2:** Inspecionando a rede httpnet:

    Para testar a distribuição da carga, é importante inspecionar a rede httpnet, que contém todos os IPs dos containers HTTP. Isso permite verificar quais IPs estão associados aos servidores HTTP e garantir que a distribuição da carga está funcionando corretamente.
    ```bash
    $ docker network inspect httpnet
    ```
    <img src="images/imagem20.png">

    <img src="images/imagem21.png">

    **Explicação do que foi testado:**

    O comando docker network ls lista todas as redes ativas no Docker, permitindo confirmar que as redes necessárias estão disponíveis e funcionando. Em seguida, o comando docker network inspect httpnet fornece detalhes específicos sobre a rede httpnet, incluindo todos os IPs dos containers HTTP conectados a essa rede. A visualização desta rede é crucial para testar o balanceamento de carga, pois mostra quais servidores HTTP estão disponíveis e conectados. As imagens mostram todos os IPs dos containers HTTP na rede httpnet, permitindo verificar se a configuração da distribuição da carga está correta. A imagem acima e a imagem abaixo são uma só, cortada para melhor visualização dos detalhes.

11. **Testando o Balanceamento de Carga com Requisições ao Load-Balancer**

    **Explicação do que será testado:**

    Para verificar se o balanceamento de carga está funcionando corretamente, fizemos uma série de requisições ao IP do load-balancer. Utilizamos um loop para enviar 20 requisições curl para o IP do load-balancer (172.18.0.2) e registramos o IP do servidor que respondeu a cada requisição. Isso ajuda a verificar se o balanceamento de carga está distribuindo as solicitações entre os servidores HTTP de forma adequada.

    Passo 1: Escrevendo o script para testar o balanceamento de carga
    ```bash
    for i in {1..20}
    do
    curl -s http://172.18.0.2
    echo "Resposta do servidor $(hostname)"
    done
    ```
    <img src="images/imagem22.png">

    **Explicação do que foi testado:**

    O script for utiliza o comando curl para enviar 20 requisições ao IP do load-balancer. A opção -s faz com que o curl opere em modo silencioso, sem exibir o progresso da transferência. Após cada requisição, o IP do servidor que respondeu é impresso na tela usando hostname. Esse método permite verificar se o load-balancer está distribuindo as requisições entre os servidores HTTP. A imagem mostra o script e a saída das requisições, evidenciando quais servidores responderam e a quantidade de respostas, ajudando a validar o funcionamento do balanceamento de carga.

12. **Verificando o Balanceamento de Carga nos Logs do Load-Balancer**

    **Explicação do que será testado:**

    Para confirmar que o balanceamento de carga está funcionando corretamente, verificamos os logs do load-balancer. O objetivo é verificar se as requisições estão sendo distribuídas entre os servidores HTTP (http-server1, http-server2, e http-server3) conforme esperado. Utilizamos o método de balanceamento de carga Round Robin, que distribui as requisições de forma sequencial entre os servidores disponíveis.

    ```bash
    $ docker logs load-balancer
    ```
    <img src="images/imagem23.png">

    **Explicação do que foi testado:**

    Os logs do load-balancer mostram a distribuição das requisições entre os servidores HTTP. No exemplo, você pode observar as seguintes entradas nos logs:

    http_front http_back/http_server1
    http_front http_back/http_server2
    http_front http_back/http_server3
    http_front http_back/http_server1
    http_front http_back/http_server2
    http_front http_back/http_server3

    Essas entradas indicam que o load-balancer está distribuindo as requisições de forma sequencial entre os servidores HTTP, utilizando o método Round Robin. O log confirma que cada servidor (http-server1, http-server2, e http-server3) recebeu uma parte das requisições, como esperado. Este comportamento demonstra que o balanceamento de carga está funcionando corretamente, equilibrando as solicitações entre os servidores disponíveis.

## Conclusão

O projeto "Servidor DNS e Balanceamento de Carga com Docker" foi desenvolvido com o objetivo de criar uma infraestrutura eficiente utilizando Docker para serviços de DNS e HTTP. O sistema implementado inclui servidores DNS primário e secundário, servidores HTTP e um balanceador de carga, com o balanceamento de carga configurado para distribuir requisições de forma eficiente entre os servidores HTTP.

## Principais Realizações

1. **Configuração de Servidores DNS:**

    Implementação de servidores DNS primário e secundário usando BIND9, permitindo a resolução de nomes e replicação de dados entre servidores.

2. **Serviços HTTP:**

    Configuração de múltiplos servidores HTTP com conteúdo estático, garantindo que os serviços estejam disponíveis e funcionem conforme esperado.
    Balanceamento de Carga:

    Implementação de um balanceador de carga usando HAProxy para distribuir requisições entre os servidores HTTP de forma eficiente, utilizando o método Round Robin.
    Orquestração com Docker:

    Utilização do Docker e Docker Compose para criar e gerenciar containers, simplificando o processo de deploy e garantindo a escalabilidade da infraestrutura.

3. **Resultados dos Testes:**

    Serviço DNS: A comunicação e resolução de nomes entre os servidores DNS foram validadas com sucesso. O servidor DNS secundário demonstrou capacidade de assumir a função do primário em caso de falha.

    Serviços HTTP: Todos os servidores HTTP responderam corretamente às requisições, e a conectividade entre eles foi confirmada.

    Balanceamento de Carga: O balanceador de carga distribuiu as requisições entre os servidores HTTP conforme esperado, e os logs confirmaram que o método Round Robin está funcionando corretamente.

## Considerações Finais
Este projeto demonstra a eficácia do Docker para gerenciar e orquestrar serviços de rede, proporcionando uma solução escalável e eficiente para serviços DNS e HTTP com balanceamento de carga. A configuração e os testes realizados confirmam a funcionalidade e a resiliência da infraestrutura implementada, garantindo um ambiente robusto para a operação de serviços de rede.

## Autores

    Crisly Santos
    Erik Lustosa
    Guilherme Gomes

## Licença

Este projeto é licenciado sob a Licença MIT - veja o arquivo LICENSE para mais detalhes.
