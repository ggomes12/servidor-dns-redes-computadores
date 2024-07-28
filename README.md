<h1 style="text-align: center;">
  servidor-dns-redes-computadores
</h1>

O objetivo deste trabalho é desenvolver um sistema completo utilizando Docker que inclua um serviço de DNS (primário e secundário) e servidores HTTP com balanceamento de carga.


![Estrutura HTTP](images/docker.png)
![Estrutura HTTP](images/python.png)

## Descrição do Projeto

O projeto inclue uma infraestrutura utilizando Docker atendendo os seguintes requisitos de estruturação:

Serviço DNS

    Servidor DNS Primário
    Servidor DNS Secundário

Serviço HTTP

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

## Funcionalidades

## Conclusão

Este projeto acadêmico demonstra a criação de uma infraestrutura de rede utilizando Docker, incluindo serviços de DNS primário e secundário, bem como servidores HTTP com balanceamento de carga. Esta implementação é útil para entender na prática os conceitos de redes e a utilização de containers para gerenciamento de serviços.

## Autores

    Crisly Maria
    Erik Vinicius
    Guilherme Gomes

## Licença

Este projeto é licenciado sob a Licença MIT - veja o arquivo LICENSE para mais detalhes.
