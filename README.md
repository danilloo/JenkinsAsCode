# Jenkins Configuration as Code

Este projeto contém os arquivos necessários para executar o Jenkins e sua configuração como código, através do plugin "jenkins-configuration-as-code" e a criação de jobs através do "Jenkins Job Builder".


# Execução

O build e execução do container é feito através do **docker-compose**, orientado ao manifesto do arquivo "docker-compose.yml".

Para executá-lo, basta seguir os comandos abaixo:

    $ mkdir data && chown 1000:1000 data
    $ LOCAL_IP_ADDR=YOUR_LOCAL_IP \
      JENKINS_USER=YOUR_USER \
      JENKINS_PWD=YOUR_PASSWORD \
      JENKINS_URL=YOUR_DOMAIN \
      DOCKER_GROUP_ID=$(getent group docker | awk -F ":" '{ print $3}') \
      docker-compose up -d

## Configuração

Toda configuração do Jenkins é definida no arquivo "jenkins-conf-as-code.yaml", encontrado no diretório **jasc** deste projeto.

## Estrutura de diretório

.</br>
├── docker-compose.yml (Manifesto do docker-compose para a stack)</br>
├── Dockerfile (Dockerfile do Jenkins)</br>
├── files</br>
│   ├── check.sh</br>
│   ├── disable-script-security.groovy</br>
│   └── jenkins.sh</br>
├── jasc</br>
│   └── jenkins-conf-as-code.yaml (Arquivo de configuração do Jenkins)</br>
├── jjb</br>
│   ├── Dockerfile (Dockerfile do Jenkins-Job-Builder)</br>
│   └── jobs (Estrutura de jobs)</br>
│       ├── docker-rm.yml</br>
│       └── docker-run.yml</br>
├── plugins.txt (Lista de plugins do Jenkins)</br>
└── README.md</br>


## Documentação do Plugin

A referência e documentação para configuração do plugin "Jenkins Configuration as Code", pode ser encontrada no repositório abaixo:

https://github.com/jenkinsci/configuration-as-code-plugin/

A referência e documentação para configuração da tool "Jenkins Job Builder", pode ser encontrada no endereço abaixo:

https://docs.openstack.org/infra/jenkins-job-builder/
```

