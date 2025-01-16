# Terraform

## Introdução

O Terraform é uma ferramenta de infraestrutura como código (IaC) desenvolvida pela HashiCorp. Ele permite que você defina e provisione infraestrutura de forma declarativa usando uma linguagem de configuração chamada HashiCorp Configuration Language (HCL).

Principais características do Terraform:

- **Multiplataforma:** Suporta diversos provedores de nuvem como AWS, Azure, Google Cloud, além de outras plataformas e serviços
- **Declarativo:** Você especifica o estado desejado da infraestrutura, e o Terraform determina como alcançá-lo
- **Gerenciamento de Estado:** Mantém registro do estado atual da infraestrutura em arquivos de estado
- **Planejamento de Execução:** Permite visualizar mudanças antes de aplicá-las através do comando 'terraform plan'

Workflow básico do Terraform:

1. **terraform init:** Inicializa um diretório de trabalho do Terraform
2. **terraform plan:** Cria um plano de execução
3. **terraform apply:** Aplica as mudanças planejadas
4. **terraform destroy:** Remove a infraestrutura provisionada

Benefícios do uso do Terraform:

- **Automatização:** Reduz erros humanos e aumenta a eficiência
- **Versionamento:** Permite controle de versão da infraestrutura
- **Reusabilidade:** Código pode ser reutilizado em diferentes projetos
- **Documentação:** O código serve como documentação da infraestrutura

O Terraform é amplamente utilizado em ambientes DevOps e é uma ferramenta essencial para times que precisam gerenciar infraestrutura em escala.

## Instalando AWS CLI

Segue o link da instalação do AWS CLI

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Configurando as credenciais do AWS

Não é o ideal usar chave no root, é necessário criar pelo IAM

**Serviço IMA**

O IAM (Identity and Access Management) é um serviço da AWS que permite gerenciar de forma segura o acesso aos serviços e recursos da AWS. Principais características:

- **Usuários e Grupos:** Permite criar e gerenciar usuários individuais e agrupá-los
- **Permissões:** Controle granular de acesso através de políticas (policies)
- **Roles:** Permite que serviços AWS acessem outros serviços de forma segura
- **MFA:** Suporte a autenticação multi-fator para maior segurança

Boas práticas do IAM:

1. **Criar usuários individuais:** Evite compartilhar credenciais do usuário root
2. **Usar grupos:** Organize usuários em grupos para facilitar o gerenciamento de permissões
3. **Princípio do menor privilégio:** Conceda apenas as permissões necessárias
4. **Rotação regular de credenciais:** Altere senhas e chaves de acesso periodicamente

Para criar um novo usuário IAM e configurar suas credenciais:

1. Acesse o Console AWS e navegue até o serviço IAM
2. Crie um novo usuário com acesso programático
3. Atribua as políticas adequadas (diretamente ou via grupos)
4. Salve as credenciais (Access Key ID e Secret Access Key) de forma segura

Criando IAM para permissão de usuário

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%201.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%202.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%203.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%204.png)

Agora vamos configura o AWS CLI

```yaml
aws configure <Access key>
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%205.png)

Execute o seguinte comando

```yaml
aws sts get-caller-identity
```

O comando `aws sts get-caller-identity` é usado para verificar a identidade atual do usuário autenticado na AWS CLI. Ele retorna três informações principais:

- **UserId:** O identificador único do usuário IAM
- **Account:** O número da conta AWS que está sendo utilizada
- **Arn:** O ARN (Amazon Resource Name) do usuário, que é um identificador único para recursos AWS

Este comando é muito útil para:

- Confirmar se as credenciais AWS foram configuradas corretamente
- Verificar qual identidade está sendo usada no momento
- Validar as permissões e o acesso à conta AWS

É uma boa prática executar este comando após configurar as credenciais AWS para garantir que tudo está funcionando como esperado.

Após executar o comando

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%206.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%207.png)

Agora é só logar na conta com  o IAM criado

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%208.png)

Coloca o nome do IAM criado e depois a senha que você criou junto com este serviço

## AWS mão na massa

## Arquitetura do projeto

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%209.png)

1. Criação da VPC (Virtual Private Cloud)
    1. É como se fosse o datacenter de rede, parte mais alta, vai ter os recursos do projeto.
    2. A VPC vai ser criada em um região
2. IGW (Internet Gateway)
3. ALB/NLB (São os Loads Balancers da AWS)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2010.png)

- MNG - Manager Nodes Groups, onde será rodado as VMs

## VPC

VPC (Virtual Private Cloud) é um serviço fundamental da AWS que permite criar uma rede virtual isolada na nuvem. Principais características:

- **Isolamento:** Ambiente de rede totalmente isolado e dedicado na nuvem AWS
- **Controle:** Permite configurar ranges de IP, subnets, tabelas de roteamento e gateways de rede
- **Segurança:** Oferece múltiplas camadas de segurança, incluindo security groups e network ACLs
- **Conectividade:** Pode ser conectada a data centers on-premises através de VPN ou Direct Connect

Componentes principais de uma VPC:

1. **Subnets:** Segmentos de rede que podem ser públicos ou privados
2. **Route Tables:** Controlam o tráfego de rede entre as subnets
3. **Internet Gateway:** Permite comunicação com a internet
4. **Network ACLs:** Regras de segurança no nível da subnet

Uma VPC bem planejada é essencial para:

- Garantir a segurança dos recursos na nuvem
- Otimizar a comunicação entre serviços
- Controlar custos de tráfego de rede
- Facilitar a escalabilidade da infraestrutura

Agora vamos criar uma VPC na AWS

- Pesquise pelo serviço do VPC

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2011.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2012.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2013.png)

VPC criada 

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2014.png)

Agora vá em actions e edite sua vpc, e marque para Enable DNS hostnames

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2015.png)

O Enable DNS resolution na VPC da AWS serve para:

- **Resolução de DNS interna:** Permite que as instâncias dentro da VPC resolvam endereços DNS privados e públicos
- **Nomes de host DNS:** Possibilita que as instâncias EC2 recebam nomes de host DNS automáticos
- **Integração com Route 53:** Facilita a integração com o serviço de DNS da AWS (Route 53) para resolução de nomes
- **Comunicação entre serviços:** Essencial para serviços AWS que dependem de resolução DNS para funcionar corretamente

Esta configuração é fundamental para:

1. Garantir que as instâncias possam se comunicar usando nomes DNS ao invés de IPs
2. Permitir o funcionamento adequado de serviços AWS que dependem de DNS
3. Facilitar a administração e manutenção da infraestrutura

O Enable DNS hostnames na VPC da AWS serve para:

- **Atribuição automática de nomes DNS:** Permite que as instâncias EC2 recebam automaticamente nomes DNS públicos quando lançadas em uma subnet pública
- **Resolução de nomes:** Habilita a capacidade de resolver nomes DNS públicos para endereços IP públicos dentro da VPC
- **Conectividade externa:** Facilita a comunicação com recursos externos que utilizam nomes DNS em vez de IPs diretos
- **Integração com serviços AWS:** Melhora a integração com outros serviços AWS que dependem de resolução de nomes DNS

Esta configuração é especialmente importante quando:

1. Você precisa que suas instâncias sejam acessíveis pela internet usando nomes DNS
2. Seus aplicativos requerem resolução de nomes DNS públicos
3. Você está implementando arquiteturas que dependem de comunicação baseada em DNS

## Subnets (privada e pública)

Subnets são subdivisões de uma VPC que permitem organizar e segmentar recursos. Existem dois tipos principais:

### Subnet Pública

Características principais:

- **Acesso direto à Internet:** Possui rota para Internet Gateway (IGW)
- **Recursos expostos:** Ideal para recursos que precisam ser acessíveis publicamente
- **Casos de uso:** Load balancers, servidores web, bastions hosts
- **IP público:** Instâncias podem receber endereços IP públicos automaticamente

### Subnet Privada

Características principais:

- **Sem acesso direto à Internet:** Não possui rota direta para IGW
- **Maior segurança:** Recursos protegidos do acesso público direto
- **Acesso à Internet via NAT:** Usa NAT Gateway para acesso sainte à Internet
- **Casos de uso:** Bancos de dados, serviços internos, backends de aplicações

Boas práticas de configuração:

1. **Segmentação:** Distribuir recursos entre subnets públicas e privadas conforme necessidade de acesso
2. **Alta disponibilidade:** Criar subnets em múltiplas Availability Zones
3. **CIDR adequado:** Planejar ranges de IP com espaço para crescimento
4. **Documentação:** Manter registro claro da organização e propósito de cada subnet

Criando uma subnet

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2016.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2017.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2018.png)

Subnets criadas

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2019.png)

## Tags na subnets para AWS Load Balancer Controller

### Requisitos de sub-redes para nós

É possível implantar nós e recursos do Kubernetes nas mesmas
 sub-redes que você especifica ao criar o cluster. Porém, isso não é 
necessário. Isso porque também é possível implantar nós e recursos do 
Kubernetes em sub-redes que você não especificou quando criou o cluster.
 Se você implantar nós em sub-redes diferentes, o Amazon EKS não criará 
interfaces de rede de cluster nelas. Qualquer sub-rede na qual você 
implante nós e recursos do Kubernetes deve atender aos seguintes 
requisitos:

- As sub-redes devem ter endereços IP disponíveis suficientes para implantar todos os nós e recursos do Kubernetes.
- Se quiser que o Kubernetes atribua endereços `IPv6` a Pods e serviços, você deverá ter um bloco CIDR `IPv6` e um bloco CIDR `IPv4` associados à sub-rede. Para obter mais informações, consulte [Associar um bloco CIDR IPv6 à sua sub-rede](https://docs.aws.amazon.com/vpc/latest/userguide/working-with-subnets.html#subnet-associate-ipv6-cidr) no Guia do usuário do Amazon VPC. As tabelas de rotas associadas às sub-redes devem incluir rotas para endereços `IPv4` e `IPv6`. Para obter mais informações, consulte [Rotas](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html#route-table-routes), no Guia do usuário da Amazon VPC. Pods recebem apenas um endereço `IPv6`. Porém, as interfaces de rede que criadas pelo Amazon EKS para o seu cluster e os seus nós recebem um endereço `IPv4` e um endereço `IPv6`.
- Se precisar de acesso de entrada pela Internet aos
Pods, certifique-se de ter pelo menos uma sub-rede pública com endereços IP disponíveis suficientes para implantar balanceadores de carga e
ingressos. Você pode implantar balanceadores de carga em sub-redes
públicas. Balanceadores de carga podem balancear carga para Pods em
sub-redes privadas ou públicas. Convém implantar nós em sub-redes
privadas, se possível.
- Se você planeja implantar nós em uma sub-rede pública, esta deverá atribuir automaticamente endereços públicos `IPv4` ou endereços `IPv6`. Se você implantar nós em uma sub-rede privada que tenha um bloco CIDR `IPv6` associado, esta também deverá atribuir endereços `IPv6` automaticamente. Se você usou um modelo [Criar uma Amazon VPC para o cluster do Amazon EKS](https://docs.aws.amazon.com/pt_br/eks/latest/userguide/creating-a-vpc.html)Amazon EKS AWS CloudFormation para implantar sua VPC após 26 de março de 2020, essa configuração está ativada. Se você utilizou os modelos para
implantar sua VPC antes dessa data ou se utilizar sua própria VPC,
deverá habilitar essa configuração manualmente. Para obter mais
informações, consulte [Modificar o atributo de endereçamento IPv4 público para sua sub-rede e](https://docs.aws.amazon.com/vpc/latest/userguide/working-with-subnets.html#subnet-public-ip) [Modificar o atributo de endereçamento IPv6 para sua sub-rede](https://docs.aws.amazon.com/vpc/latest/userguide/working-with-subnets.html#subnet-ipv6) no [Guia do usuário do Amazon VPC](https://docs.aws.amazon.com/vpc/latest/userguide/).
- Se a sub-rede na qual você implanta um nó for privada e sua tabela de rotas não incluir uma rota para um [dispositivo de conversão de endereços de rede (NAT)](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat.html) (`IPv4`) ou um [gateway somente de saída](https://docs.aws.amazon.com/vpc/latest/userguide/egress-only-internet-gateway.html) (`IPv6`), adicione endpoints de VPC usando o AWS PrivateLink à sua VPC. Os
endpoints de VPC são necessários para todos os serviços AWS com os quais seus nós e Pods precisam se comunicar. Os exemplos incluem o Amazon
ECR, o Elastic Load Balancing, o Amazon CloudWatch, o AWS Security Token Service e o Amazon Simple Storage Service (Amazon S3). O endpoint deve
incluir a sub-rede na qual os nós se encontram. Nem todos os serviços do AWS oferecem suporte a endpoints de VPC. Para obter mais informações,
consulte [O que é o AWS PrivateLink?](https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html) e [AWS serviços que se integram ao AWS PrivateLink](https://docs.aws.amazon.com/vpc/latest/privatelink/aws-services-privatelink-support.html). Para obter uma lista de mais requisitos para o Amazon EKS, consulte [Implementar clusters privados com acesso limitado à internet](https://docs.aws.amazon.com/pt_br/eks/latest/userguide/private-clusters.html).
- Se quiser implantar balanceadores de carga em uma sub-rede, esta deve ter a seguinte etiqueta:

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2020.png)

Vamos colocar  tags na subnets  privadas

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2021.png)

Vá nesse link https://docs.aws.amazon.com/pt_br/eks/latest/userguide/network-reqs.html

copie e cole isso aqui [`kubernetes.io/role/internal-elb`](http://kubernetes.io/role/internal-elb) valor 1

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2022.png)

Depois de criado, o nosso controller vai entender que essa é uma subnet privada, que serve para criar Load Balancer que são privados

Agora vamos padronizar as subnets públicas:

Copie e cole, [`kubernetes.io/role/elb`](http://kubernetes.io/role/elb) valor 1

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2023.png)

## Internet Gateway e Route Table

### O que é uma Internet Gateway 💻

Um Internet Gateway é um componente de rede que permite a comunicação entre uma rede privada (como uma Virtual Private Cloud - VPC) e a internet pública. Ele atua como um ponto de entrada e saída para o tráfego de dados, permitindo que instâncias dentro da rede privada se conectem à internet e que usuários da internet acessem recursos dentro da rede privada, se configurado para isso.

Os principais recursos de um Internet Gateway incluem:

1. **Conexão com a Internet**: Permite que as instâncias em uma rede privada acessem a internet para enviar e receber dados.
2. **Endereçamento IP**: Facilita a atribuição de endereços IP públicos às instâncias, permitindo que elas sejam acessíveis a partir da internet.
3. **Roteamento**: Trabalha em conjunto com tabelas de roteamento para direcionar o tráfego de entrada e saída.
4. **Escalabilidade**: Pode lidar com grandes volumes de tráfego, permitindo que a rede se expanda conforme necessário.

Em ambientes de nuvem, como o Amazon Web Services (AWS), o Internet Gateway é um recurso essencial para permitir que as instâncias em uma VPC se comuniquem com a internet.

### O que é uma Route Table 💻

Uma Route Table (tabela de roteamento) é um componente fundamental em redes de computadores que define como o tráfego de rede deve ser direcionado. Ela contém uma lista de rotas, que são regras que informam ao roteador ou à instância de rede como encaminhar pacotes de dados para diferentes destinos.

Aqui estão alguns pontos importantes sobre as Route Tables:

1. **Entradas de Rota**: Cada entrada na tabela de roteamento especifica um destino (geralmente um endereço IP ou uma rede) e o próximo salto (next hop) para onde o tráfego deve ser enviado. Isso pode incluir endereços IP de outros roteadores ou gateways.
2. **Direcionamento de Tráfego**: Quando um pacote de dados é enviado, o dispositivo de rede consulta a tabela de roteamento para determinar a melhor rota para o destino. Se houver uma correspondência na tabela, o pacote é enviado para o próximo salto especificado.
3. **Tipos de Rotas**: As rotas podem ser estáticas (definidas manualmente) ou dinâmicas (aprendidas automaticamente através de protocolos de roteamento).
4. **Roteamento em Nuvem**: Em ambientes de nuvem, como o Amazon Web Services (AWS), as Route Tables são usadas para gerenciar o tráfego entre sub-redes, Internet Gateways e outros recursos de rede. Cada sub-rede em uma VPC (Virtual Private Cloud) pode ser associada a uma Route Table específica.
5. **Prioridade**: As entradas na tabela de roteamento podem ter diferentes prioridades, e o roteador geralmente utiliza a rota mais específica (com a máscara de sub-rede mais longa) quando decide como encaminhar o tráfego.

Em resumo, a Route Table é essencial para garantir que os dados sejam enviados de forma eficiente e correta através de uma rede, seja ela local ou na nuvem.

### Criando um Gateway

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2024.png)

Agora vamos fazer um atach no VPC

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2025.png)

Selecionamos o VPC criado

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2026.png)

Agora vamos criar uma Route Table

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2027.png)

Selecione sua VPC ao criar uma route table

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2028.png)

Agora vamos adicionar uma rota

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2029.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2030.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2031.png)

Agora vamos editar o route table de uma subnet pública

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2032.png)

Selecione o route table que foi criado

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2033.png)

A partir desse momento as nossas sub-nets públicas estão com rota externa.

## Auto Assign Public Ip

O Auto Assign Public IP é uma configuração em redes de nuvem que permite a atribuição automática de endereços IP públicos para instâncias quando elas são lançadas em uma sub-rede específica.

Principais aspectos do Auto Assign Public IP:

- **Atribuição Automática:** Quando habilitado, cada nova instância criada na sub-rede receberá automaticamente um endereço IP público além do seu IP privado
- **Configuração por Sub-rede:** Esta configuração pode ser habilitada ou desabilitada no nível da sub-rede, permitindo controle granular sobre quais partes da sua rede podem ter IPs públicos
- **Segurança:** Útil para instâncias que precisam de acesso direto à internet, mas deve ser usado com cautela e apenas em sub-redes públicas
- **Flexibilidade:** Mesmo com esta configuração habilitada, você ainda pode sobrescrever a configuração padrão ao lançar instâncias individuais

Esta configuração é particularmente importante em arquiteturas que requerem acesso à internet, como servidores web em sub-redes públicas.

- Configurando o subnet para auto assign public ip

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2034.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2035.png)

## Bastion Host para confirmar

O Amazon EC2 (Elastic Compute Cloud) é um serviço web que fornece capacidade computacional redimensionável na nuvem da AWS. Em termos simples, é um serviço que permite alugar computadores virtuais na nuvem.

Principais características do EC2:

- **Elasticidade:** Capacidade de aumentar ou diminuir recursos computacionais conforme necessário
- **Flexibilidade:** Diversos tipos de instâncias otimizadas para diferentes casos de uso
- **Integração:** Funciona perfeitamente com outros serviços AWS
- **Controle total:** Você tem controle completo sobre suas instâncias virtuais
- **Segurança:** Integração com Amazon VPC e diversos recursos de segurança

O EC2 é fundamental para hospedar aplicações, executar servidores, e realizar processamento de dados na nuvem AWS.

### Criar um par de chaves

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2036.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2037.png)

### Agora vamos criar uma instancia na AWS

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2038.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2039.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2040.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2041.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2042.png)

Entrando no modo SSH da instancia

```bash
chmod 600 /Downloads/comunidadedevops-keypar.pem

ssh -i ~/Downloads/comunidadedevops-keypar.pem ubuntu@18.207.102.230
```

A flag -i é para especificar que vamos utilizar chaves privadas

Depois execute um ping para ver se tudo está funcionando certo

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2043.png)

Agora é só terminar a máquina

## NAT Gateway e Route Table

Um NAT Gateway (Network Address Translation Gateway) é um serviço gerenciado que permite que instâncias em uma sub-rede privada se comuniquem com a internet ou outros serviços AWS, mantendo essas instâncias inacessíveis a partir da internet.

Principais características do NAT Gateway:

1. **Acesso à Internet para Sub-redes Privadas:** Permite que instâncias em sub-redes privadas acessem a internet para atualizações, downloads e outros serviços, sem expor essas instâncias diretamente à internet.
2. **Alta Disponibilidade:** É automaticamente redundante dentro de uma zona de disponibilidade e pode ser implantado em múltiplas zonas para maior resiliência.
3. **Escalabilidade Automática:** Pode lidar com até 45 Gbps de largura de banda e escala automaticamente conforme necessário.
4. **Segurança Aprimorada:** Fornece uma camada adicional de segurança ao ocultar instâncias privadas da internet, permitindo apenas tráfego de saída.
5. **Gerenciamento Simplificado:** Como serviço gerenciado pela AWS, não requer administração ou manutenção por parte do usuário.

O NAT Gateway é essencial em arquiteturas que seguem as melhores práticas de segurança, onde recursos que não precisam ser acessíveis publicamente são colocados em sub-redes privadas, mas ainda precisam de acesso à internet para funcionalidades específicas.

### Vamos criar um NAT

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2044.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2045.png)

Com o NAT criado, agora vamos criar um Route Table para as rotas privadas

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2046.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2047.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2048.png)

Com as NAT adicionadas as Route Tables, agora vamos implementar as subnets nas Route Tables

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2049.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2050.png)

## Cluster IAM role

O Cluster IAM Role (Identity and Access Management Role) é uma função que define as permissões que um cluster na AWS pode ter para interagir com outros serviços AWS. É um componente crucial para garantir a segurança e o controle de acesso adequado.

Principais aspectos do Cluster IAM Role:

- **Controle de Acesso:** Define quais serviços AWS o cluster pode acessar e quais ações pode executar
- **Segurança:** Implementa o princípio do menor privilégio, garantindo que o cluster tenha apenas as permissões necessárias
- **Gerenciamento Centralizado:** Permite administrar permissões de forma centralizada através de políticas IAM
- **Flexibilidade:** Pode ser modificado conforme as necessidades do cluster mudam, sem necessidade de alterações no código

O Cluster IAM Role é especialmente importante em ambientes que utilizam serviços como EKS (Elastic Kubernetes Service), ECS (Elastic Container Service) ou outros serviços que necessitam interagir com múltiplos recursos AWS.

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2051.png)

Vamos criar uma role

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2052.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2053.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2054.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2055.png)

## Criação do cluster EKS

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2056.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2057.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2058.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2059.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2060.png)

Dá um next no restante e clique em Create

Aguarde até o cluster ser criado

Executando requisição de Host

```bash
host F9FB1BFE3D622507E1C3D476C63AAE87.gr7.us-east-1.eks.amazonaws.com
```

Execute o seguinte para estabelecer uma conexão TCP com o endpoint especificado na porta 443, enquanto fornece informações detalhadas sobre o processo.

```bash
nc -v F9FB1BFE3D622507E1C3D476C63AAE87.gr7.us-east-1.eks.amazonaws.com 443
```

- `nc`: É o comando para o netcat, uma ferramenta de rede que pode ser usada para criar conexões TCP ou UDP.
- `v`: Esta opção ativa o modo "verbose", que fornece informações detalhadas
sobre o que o netcat está fazendo, como a conexão sendo estabelecida.
- [`F9FB1BFE3D622507E1C3D476C63AAE87.gr7.us-east-1.eks.amazonaws.com](http://f9fb1bfe3d622507e1c3d476c63aae87.gr7.us-east-1.eks.amazonaws.com/):` Este é o endereço do host ao qual você está tentando se conectar.
Parece ser um endpoint de um serviço na AWS (Amazon Web Services),
especificamente no Elastic Kubernetes Service (EKS).
- `443`: Este é o número da porta à qual você está se conectando. A porta 443 é comumente usada para conexões HTTPS, que são seguras.

Que vai retornar o seguinte:

```bash
Connection to F9FB1BFE3D622507E1C3D476C63AAE87.gr7.us-east-1.eks.amazonaws.com (34.192.201.25) 443 port [tcp/https] succeeded!
```

Comando para pegar o kubeconfig do cluster criado no serviço do EKS

```bash
aws eks update-kubeconfig --region us-east-1 --name comunidadedevops-eks 
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2061.png)

```bash
kubectl config get-contexts
```

Comando para começar autilizar o cluster EKS criado

```bash
kubectl config use-context arn:aws:eks:us-east-1:654654576685:cluster/comunidadedevops-eks  
```

```bash
kubectl get po -A
```

[https://www.notion.so](https://www.notion.so)

## Node IAM Role

**Node IAM Role** é um conceito no contexto do **AWS Identity and Access Management (IAM)**, que permite atribuir permissões específicas a instâncias de EC2 ou nós (nodes) dentro de um cluster Kubernetes que estão rodando na AWS. Esse papel é essencial para controlar quais ações esses nós podem realizar nos serviços da AWS.

### Contexto

No caso de clusters Kubernetes gerenciados pela AWS, como o **Amazon EKS (Elastic Kubernetes Service)**, os nós do cluster (geralmente instâncias EC2) frequentemente precisam interagir com outros serviços da AWS, como S3, DynamoDB, CloudWatch, ou outros. Para permitir isso de forma segura e controlada, utilizamos **IAM Roles**.

---

### Como funciona uma Node IAM Role?

1. **Criação da Role**:
    - Uma **IAM Role** é criada e configurada com permissões específicas usando **IAM Policies**.
    - Exemplo: uma policy que permite acesso de leitura/gravação em um bucket S3.
2. **Associação com as instâncias (nós)**:
    - Essa role é associada ao perfil de instância (Instance Profile) da instância EC2 que será usada como nó no cluster.
3. **Execução de operações**:
    - Quando a instância tenta acessar recursos da AWS (por exemplo, fazer upload para um bucket S3), a Node IAM Role fornece as credenciais temporárias necessárias para autenticação e autorização.
4. **Renovação automática**:
    - Credenciais temporárias associadas à role são geradas automaticamente e renovadas periodicamente, eliminando a necessidade de armazenar chaves de acesso estáticas.

---

### Benefícios do uso de Node IAM Role:

- **Segurança**:
    - Evita o uso de credenciais fixas ou hard-coded nos nós.
    - As permissões podem ser limitadas com o princípio do **menor privilégio**.
- **Gerenciamento centralizado**:
    - As permissões são gerenciadas por meio de políticas IAM, centralizando o controle de acesso.
- **Escalabilidade**:
    - Uma mesma role pode ser usada por várias instâncias/nós, simplificando a configuração.

---

### Exemplo de Configuração:

### 1. Criar a IAM Role com permissões:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::meu-bucket/*"
        }
    ]
}

```

### 2. Associar a Role ao Instance Profile:

Ao lançar a instância EC2 (ou gerenciar os nós via o EKS), associe o **Instance Profile** com a role criada.

---

### No contexto de Kubernetes e Amazon EKS:

Dentro de um cluster Kubernetes, o uso do plugin **Amazon EKS Pod Identity (IAM Roles for Service Accounts)** permite atribuir roles diretamente aos **pods**, garantindo permissões mais granulares por pod, enquanto as **Node IAM Roles** fornecem permissões gerais para os nós como um todo.

### Conclusão:

A **Node IAM Role** é fundamental para garantir que os nós (ou instâncias EC2) possam acessar os serviços da AWS de maneira segura e eficiente, sem o uso de credenciais fixas, seguindo as melhores práticas de segurança.

### Criando um Node Group

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2062.png)

Vamos criar um role

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2063.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2064.png)

Agora irá colocar as seguintes permissões:

- [AmazonEKS_CNI_Policy](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonEKS_CNI_Policy)
- [AmazonEKSWorkerNodePolicy](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonEKSWorkerNodePolicy)
- [AmazonEC2ContainerRegistryReadOnly](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonEC2ContainerRegistryReadOnly)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2065.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2066.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2067.png)

## Managed Node Group

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2068.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2069.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2070.png)

Quero que rode nas subnets privadas

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2071.png)

Permitir acesso pelo par de chaves criadas

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2072.png)

Depois de criado, perceba que ele irá criar uma instância no EC2  com todas as configurações do kubernetes

Antes quando executava o `kubectl get nodes` retornava ***No resources found***

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2073.png)

Fonte da imagem: Retirada do curso

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2074.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2075.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2076.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2077.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2078.png)

## OIDC Provider

O **OIDC Provider** no contexto da AWS é um serviço que permite a integração de identidades externas usando o padrão **OpenID Connect (OIDC)** para autenticação e autorização. Ele é frequentemente utilizado em configurações de serviços como o **Amazon EKS** para permitir que aplicações ou workloads autenticadas por identidades externas acessem recursos da AWS de maneira segura e granular.

---

### **O que é OIDC?**

**OpenID Connect (OIDC)** é um protocolo de autenticação baseado em OAuth 2.0. Ele é amplamente usado para autenticar usuários e serviços em sistemas distribuídos. No contexto da AWS, o **OIDC Provider** atua como um intermediário confiável que valida identidades externas.

---

### **OIDC Provider na AWS**

### **Definição**

Um **OIDC Provider** na AWS é uma entidade configurada para aceitar tokens emitidos por um provedor de identidade externo compatível com OIDC, como o **Google**, **Auth0**, **Keycloak** ou até mesmo um serviço interno que implemente OIDC. No caso de clusters Kubernetes, o próprio **EKS Cluster** pode atuar como um provedor de identidade OIDC.

### **Função**

- Permitir que identidades autenticadas por um provedor externo obtenham acesso aos recursos da AWS usando permissões associadas a **IAM Roles**.
- Substituir a necessidade de usar credenciais fixas ou chaves de acesso em workloads.

---

### **Como funciona o OIDC Provider no AWS EKS?**

1. **Configuração do OIDC Provider**:
    - Durante a criação de um cluster EKS, a AWS cria ou permite configurar um **OIDC Provider** específico para o cluster.
    - Esse provider emite **tokens de identidade JWT** que podem ser usados pelos workloads (como pods) para se autenticarem com serviços AWS.
2. **IAM Roles for Service Accounts (IRSA)**:
    - O **OIDC Provider** é usado para associar permissões do IAM diretamente a service accounts no Kubernetes.
    - Com isso, os pods podem herdar permissões específicas sem depender de permissões atribuídas ao nó onde estão executando.
3. **Fluxo de funcionamento**:
    - Um pod assume uma **service account** que está vinculada a uma IAM Role via OIDC.
    - O OIDC Provider valida o token do pod emitido pelo Kubernetes.
    - Com o token validado, a AWS fornece credenciais temporárias para o pod acessar os serviços AWS definidos na política da role.

---

### **Benefícios do OIDC Provider**

- **Segurança melhorada**:
    - Elimina a necessidade de usar credenciais fixas nos workloads.
    - Permite autenticação granular baseada em tokens temporários.
- **Gerenciamento simplificado**:
    - Usa associações entre IAM Roles e service accounts para fornecer permissões específicas a pods ou workloads.
- **Flexibilidade**:
    - Suporte a múltiplos provedores de identidade OIDC externos.

---

### **Exemplo de Uso no EKS**

### Passo 1: Configurar o OIDC Provider

1. Verifique o **OIDC URL** associado ao cluster EKS.
2. Vincule o OIDC Provider com o IAM:
    
    ```bash
    aws eks describe-cluster --name <cluster-name> --query "cluster.identity.oidc.issuer" --output text
    
    ```
    
3. Crie um **OIDC Provider** na AWS:
    
    ```bash
    aws iam create-open-id-connect-provider \
        --url <OIDC-issuer-URL> \
        --thumbprint-list <certificate-thumbprint> \
        --client-id-list sts.amazonaws.com
    
    ```
    

### Passo 2: Associar uma Role ao Pod

- Configure uma **IAM Role** vinculada a uma service account no Kubernetes.
- Use o token emitido pelo OIDC Provider para autenticar o pod e permitir acesso aos recursos da AWS.

---

### Conclusão

O **OIDC Provider** no contexto da AWS é uma ferramenta poderosa para autenticação baseada em identidades externas. Ele é essencial em configurações modernas, como o **Amazon EKS**, onde garante permissões seguras e dinâmicas para workloads Kubernetes, simplificando o gerenciamento e melhorando a segurança do sistema.

### Execute o seguinte comando para criar um provedor OIDC do IAM para o cluster.

```bash
oidc_id=$(aws eks describe-cluster --name comunidadedevops-eks --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
```

1. Determine se um provedor do OIDC do IAM com seu ID do emissor do cluster já está em sua conta.

```bash
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```

Se um resultado for retornado, significará que você
 já tem um provedor OIDC do IAM para o cluster e poderá pular a próxima 
etapa. Se nenhum resultado for retornado, você deverá criar um provedor 
OIDC do IAM para seu cluster.

1. Crie o provedor de identidade de OIDC do IAM para o cluster com o comando a seguir.

```bash
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2079.png)

## DEPLOY AWS Load Balancer Controller

Um **Load Balancer** (ou balanceador de carga) é um componente de infraestrutura usado para distribuir tráfego de rede ou de aplicação entre múltiplos servidores ou instâncias, garantindo alta disponibilidade, escalabilidade e desempenho para sistemas e aplicações. Ele atua como um ponto de entrada centralizado, redirecionando as requisições dos clientes para os servidores disponíveis de forma eficiente.

---

### **Principais Funções de um Load Balancer**

1. **Distribuição de Carga**:
    - Garante que o tráfego seja distribuído uniformemente entre os servidores para evitar sobrecarga em um único ponto.
2. **Alta Disponibilidade**:
    - Caso um servidor falhe, o Load Balancer redireciona automaticamente o tráfego para outros servidores disponíveis.
3. **Escalabilidade**:
    - Facilita a adição ou remoção de servidores de forma transparente para os usuários.
4. **Desempenho**:
    - Otimiza o tempo de resposta ao direcionar o tráfego para servidores com menor carga ou menor latência.
5. **Segurança**:
    - Pode incluir recursos como Terminação de SSL/TLS (HTTPS) e proteção contra ataques DDoS.

---

### **Tipos de Load Balancer**

### 1. **Baseado em Camada de Rede (Layer 4 - TCP/UDP)**

- Opera na camada de transporte do modelo OSI.
- Distribui tráfego com base em informações de rede, como IP de origem/destino e porta.
- Exemplo: **AWS Network Load Balancer (NLB)**.

### 2. **Baseado em Camada de Aplicação (Layer 7 - HTTP/HTTPS)**

- Opera na camada de aplicação do modelo OSI.
- Pode inspecionar o conteúdo das requisições, como URL, cabeçalhos e cookies, para tomar decisões sobre o roteamento.
- Exemplo: **AWS Application Load Balancer (ALB)**.

### 3. **Global Load Balancer (DNS-based)**

- Distribui tráfego entre diferentes regiões ou data centers.
- Exemplo: **AWS Route 53** (com DNS failover).

---

### **Load Balancer na Nuvem**

Na nuvem, serviços gerenciados de Load Balancer são amplamente utilizados. Eles eliminam a necessidade de gerenciar infraestrutura física e oferecem integração nativa com outros serviços.

### Exemplos:

- **AWS Elastic Load Balancer (ELB)**:
    - Suporte para Application Load Balancer, Network Load Balancer e Gateway Load Balancer.
- **Google Cloud Load Balancing**.
- **Azure Load Balancer**.

---

### **Como o Load Balancer Funciona?**

1. **Cliente envia uma requisição**:
    - O cliente acessa o endpoint do Load Balancer.
2. **Load Balancer distribui o tráfego**:
    - Ele escolhe um servidor backend com base em políticas configuradas, como Round Robin, Least Connections, ou IP Hash.
3. **Servidor backend processa a requisição**:
    - O servidor selecionado processa a requisição e retorna a resposta ao Load Balancer.
4. **Resposta ao cliente**:
    - O Load Balancer repassa a resposta ao cliente.

---

### **Algoritmos de Balanceamento Comuns**

- **Round Robin**:
    - Cada servidor recebe requisições de forma sequencial.
- **Least Connections**:
    - Redireciona para o servidor com menos conexões ativas.
- **IP Hash**:
    - Redireciona tráfego com base no hash do IP do cliente.
- **Weighted Round Robin**:
    - Cada servidor recebe tráfego proporcional a um peso configurado.

---

### **Vantagens do Load Balancer**

- **Maior Resiliência**: Ele evita que falhas em um único servidor afetem o sistema.
- **Melhor Experiência do Usuário**: Ao distribuir a carga, reduz o tempo de resposta.
- **Escalabilidade Horizontal**: Permite adicionar mais servidores de forma eficiente.

---

### **Cenários de Uso**

1. **Aplicações Web**:
    - Distribuir tráfego HTTP/HTTPS entre várias instâncias de aplicação.
2. **Serviços de Banco de Dados**:
    - Balancear conexões para réplicas de leitura.
3. **Aplicações Globais**:
    - Direcionar usuários para servidores em regiões geograficamente mais próximas.
4. **Sistemas em Kubernetes**:
    - Load Balancer atua como ponto de entrada para o cluster (Ingress ou Service tipo LoadBalancer).

---

O **Load Balancer Controller** é uma ferramenta utilizada em clusters Kubernetes para gerenciar automaticamente **Load Balancers** nos provedores de nuvem, como AWS, GCP e Azure. Ele é responsável por criar, configurar e gerenciar Load Balancers externos, de forma que as aplicações expostas no cluster possam ser acessadas a partir de fora.

### **O que é um Load Balancer Controller no Kubernetes?**

- É um **Controlador Kubernetes** que gerencia recursos do tipo `Ingress` ou `Service` com a configuração `type: LoadBalancer`.
- Automatiza a integração entre o cluster Kubernetes e os serviços de balanceamento de carga do provedor de nuvem.
- Cria e ajusta Load Balancers com base nas definições no cluster, otimizando o tráfego para pods.

---

### **Exemplo no AWS: AWS Load Balancer Controller**

O **AWS Load Balancer Controller** gerencia dois tipos principais de Load Balancers no Amazon EKS:

1. **Application Load Balancer (ALB)**:
    - Usado para tráfego HTTP/HTTPS.
    - Suporta balanceamento baseado em URL, cabeçalhos ou outras regras da camada 7.
2. **Network Load Balancer (NLB)**:
    - Usado para tráfego TCP/UDP de baixa latência.
    - Funciona na camada 4 (rede) do modelo OSI.

### Funcionalidades:

- Configuração automática de ALB/NLB com base nos recursos `Ingress` e `Service`.
- Suporte a regras avançadas como roteamento baseado em caminhos (path-based routing).
- Integração com o **AWS Certificate Manager (ACM)** para configuração de certificados SSL/TLS.
- Gerenciamento de segurança com grupos de segurança associados ao Load Balancer.

---

### **Como Funciona o Load Balancer Controller?**

1. **Deployment**:
    - O controlador é implementado como um Deployment no cluster Kubernetes.
    - Ele monitora os recursos Kubernetes, como `Ingress` e `Service`, para identificar alterações.
2. **Criação de Load Balancer**:
    - Quando um recurso `Ingress` ou `Service` é criado ou atualizado, o controlador se comunica com o provedor de nuvem para provisionar um Load Balancer.
3. **Configuração Automática**:
    - Configura os backends (grupos de instâncias ou pods), políticas de roteamento e regras de segurança no Load Balancer.
4. **Manutenção**:
    - Atualiza automaticamente o Load Balancer com base nas alterações no cluster, como a adição ou remoção de pods.

---

### **Componentes-Chave**

1. **Ingress Resource**:
    - Define regras de roteamento de tráfego HTTP/HTTPS para diferentes serviços Kubernetes.
    - Exemplo:
        
        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: Ingress
        metadata:
          name: exemplo-ingress
          annotations:
            alb.ingress.kubernetes.io/scheme: internet-facing
        spec:
          rules:
          - host: exemplo.com
            http:
              paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: meu-servico
                    port:
                      number: 80
        
        ```
        
2. **Service of Type LoadBalancer**:
    - Provisione um Load Balancer automaticamente ao expor um serviço.
    - Exemplo:
        
        ```yaml
        apiVersion: v1
        kind: Service
        metadata:
          name: meu-servico
        spec:
          type: LoadBalancer
          ports:
          - port: 80
            targetPort: 8080
          selector:
            app: minha-aplicacao
        
        ```
        
3. **Annotations**:
    - Configuram comportamentos específicos, como:
        - Tipo de Load Balancer (ALB ou NLB).
        - Certificados SSL.
        - Regras de roteamento.

---

### **Benefícios do Load Balancer Controller**

1. **Automação**:
    - Simplifica a configuração e o gerenciamento de Load Balancers no Kubernetes.
2. **Integração Nativa**:
    - Usa serviços gerenciados pelo provedor de nuvem, otimizando desempenho e custo.
3. **Escalabilidade**:
    - Ajusta automaticamente o Load Balancer com base nas mudanças do cluster, como aumento ou diminuição de pods.
4. **Melhor Gestão de Recursos**:
    - Reduz a necessidade de intervenção manual para gerenciar Load Balancers externos.

---

### **Exemplo de Configuração do AWS Load Balancer Controller**

1. **Instale o controlador** usando `kubectl` e `helm`:
    
    ```bash
    helm repo add eks https://aws.github.io/eks-charts
    helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
        --set clusterName=<nome-do-cluster> \
        --set serviceAccount.create=false \
        --set serviceAccount.name=aws-load-balancer-controller \
        --namespace kube-system
    
    ```
    
2. **Configure um Ingress Resource** com regras para o ALB:
    
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-alb
      namespace: default
      annotations:
        alb.ingress.kubernetes.io/scheme: internet-facing
        alb.ingress.kubernetes.io/target-type: ip
    spec:
      rules:
      - host: example.com
        http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: example-service
                port:
                  number: 80
    
    ```
    

---

### **Principais Load Balancer Controllers**

1. **AWS Load Balancer Controller**:
    - Gerencia ALB e NLB no Amazon EKS.
2. **GCP Ingress Controller**:
    - Cria Load Balancers globais gerenciados no Google Cloud.
3. **Azure Application Gateway Ingress Controller**:
    - Gerencia Application Gateways na Azure.
4. **MetalLB** (On-Premises):
    - Fornece suporte a Load Balancers em clusters Kubernetes fora da nuvem.

---

### Instalando o Load Balancer Controller

1. Download do IAM Policy

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json
```

1. Vamos executar um comando para criar uma policy

```bash
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2080.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2081.png)

### Agora, nessa próxima etapa realizaremos a configurção do Service Account e do IAM Role

1. Service Account

```bash
eksctl create iamserviceaccount \
  --cluster=comunidadedevops-eks \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::654654576685:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2082.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2083.png)

### Instalar AWS Load Balancer Controller via Helm

1. Adicione o repositório de chart do Helm `eks-charts`. A AWS mantém [esse repositório](https://github.com/aws/eks-charts) no GitHub.

```bash
helm repo add eks https://aws.github.io/eks-charts
```

1. Atualize o repositório local para confirmar que você tem os gráficos mais recentes.

```bash
helm repo update eks
```

1. Instale o AWS Load Balancer Controller.

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=comunidadedevops-eks \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
```

Deu sucesso:

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2084.png)

```bash
kubectl get po -n kube-system
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2085.png)

E depois consulte os logs desse dois Pods.

## Limpando  tudo

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2086.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2087.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2088.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2089.png)

Depois de cluster e do Node Group deletado, vamos deletar os Nat Gateways

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2090.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2091.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2092.png)

Agora vamos deletar a VPC, ao deletar a mesma perceba que ela irá deletar tudo que está relacionada a ela

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2093.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2094.png)

Agora vamos deletar o elastic ip

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2095.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2096.png)

## Introdução ao terraform e início do projeto

## Arquitetura do terraform

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2097.png)

O **Terraform** é uma ferramenta de infraestrutura como código (IaC) que permite criar, gerenciar e versionar recursos em ambientes de nuvem e locais. A arquitetura do Terraform é baseada em um modelo declarativo e possui os seguintes componentes principais:

---

### **1. Configurações do Terraform**

Os arquivos de configuração (geralmente com extensão `.tf` ou `.tf.json`) contêm o código declarativo que define a infraestrutura desejada. Você descreve os recursos e suas propriedades, e o Terraform é responsável por criar e manter esses recursos.

---

### **2. CLI do Terraform**

A Interface de Linha de Comando (CLI) é usada para interagir com o Terraform. Os comandos mais comuns incluem:

- `terraform init`: inicializa o diretório do projeto, baixando provedores e módulos necessários.
- `terraform plan`: gera um plano de execução para mostrar as alterações que serão feitas.
- `terraform apply`: aplica as mudanças descritas no plano.
- `terraform destroy`: destrói a infraestrutura gerenciada pelo Terraform.

---

### **3. Providers**

Os **providers** são plug-ins que permitem ao Terraform interagir com APIs específicas, como AWS, Azure, Google Cloud, Kubernetes, entre outros. Eles traduzem os recursos declarados no código para chamadas reais à API do provedor.

---

### **4. State (Estado do Terraform)**

O **estado** é onde o Terraform armazena informações sobre os recursos criados. Ele é usado para:

- Rastrear mudanças na infraestrutura.
- Determinar o que precisa ser atualizado, criado ou destruído.
- Sincronizar a configuração do Terraform com os recursos reais.

O estado pode ser armazenado localmente (`terraform.tfstate`) ou remotamente (em buckets S3, GCS ou outros backends). O uso de estado remoto é recomendado em equipes para evitar conflitos.

---

### **5. Módulos**

Os **módulos** são agrupamentos reutilizáveis de configurações do Terraform. Eles ajudam a organizar e compartilhar código, tornando a infraestrutura mais modular e escalável. Um módulo pode ser usado para encapsular a configuração de um recurso específico ou uma parte da infraestrutura.

---

### **6. Workspace**

Os **workspaces** permitem que você mantenha múltiplos estados dentro do mesmo conjunto de configurações. Isso é útil para gerenciar diferentes ambientes (como `dev`, `staging` e `prod`) com o mesmo código.

---

### **Fluxo de Trabalho do Terraform**

1. **Escrever Configurações:** Crie o código declarativo para descrever os recursos.
2. **Inicializar o Projeto:** Execute `terraform init` para configurar os provedores e preparar o ambiente.
3. **Planejar:** Use `terraform plan` para visualizar as mudanças que serão aplicadas.
4. **Aplicar:** Execute `terraform apply` para criar ou atualizar os recursos.
5. **Gerenciar Infraestrutura:** Continue ajustando as configurações e aplicando mudanças conforme necessário.
6. **Destruir:** Quando não precisar mais dos recursos, use `terraform destroy`.

---

### **Vantagens da Arquitetura do Terraform**

- **Declaratividade:** Você define o estado desejado da infraestrutura, e o Terraform cuida dos detalhes de implementação.
- **Reutilização:** Módulos e configurações reutilizáveis facilitam a manutenção e o compartilhamento.
- **Idempotência:** Aplicar a mesma configuração várias vezes resulta no mesmo estado final.
- **Portabilidade:** Suporte a múltiplos provedores de nuvem e infraestrutura local.
- **Automação:** Facilita a integração com pipelines de CI/CD para gerenciar infraestrutura de forma contínua.

Essa arquitetura torna o Terraform uma ferramenta poderosa e amplamente adotada no mundo DevOps.

## Instalação do Terraform

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform -version
```

## Terraform Workflow

O **fluxo de trabalho do Terraform** é um processo bem definido para criar, atualizar e gerenciar a infraestrutura como código. Ele segue etapas claras para garantir consistência e rastreamento das mudanças na infraestrutura. Abaixo estão as etapas principais do fluxo de trabalho:

---

### **1. Escrever Configurações**

- O processo começa com a definição dos recursos que você deseja criar, utilizando o código declarativo do Terraform em arquivos `.tf`.
- Exemplo de código para criar uma instância no AWS:
    
    ```hcl
    provider "aws" {
      region = "us-east-1"
    }
    
    resource "aws_instance" "example" {
      ami           = "ami-12345678"
      instance_type = "t2.micro"
    }
    
    ```
    
- Você pode usar módulos para organizar e reutilizar configurações complexas.

---

### **2. Inicializar o Projeto**

- O comando `terraform init` é usado para preparar o ambiente de trabalho:
**Exemplo:**
    - Baixa e instala os provedores necessários.
    - Configura backends para o estado remoto (se configurado).
    - Verifica se o diretório do projeto está configurado corretamente.
    
    ```bash
    terraform init
    
    ```
    

---

### **3. Planejar as Mudanças**

- Use o comando `terraform plan` para gerar um plano de execução que detalha as mudanças que o Terraform fará na infraestrutura.
- O plano compara o estado atual com o desejado (definido no código) e mostra:
    - Recursos a serem **criados**.
    - Recursos a serem **atualizados**.
    - Recursos a serem **destruídos**.
    
    **Exemplo:**
    
    ```bash
    terraform plan
    
    ```
    

---

### **4. Aplicar as Mudanças**

- Execute o comando `terraform apply` para aplicar o plano gerado e provisionar os recursos.
- O Terraform pedirá uma confirmação antes de aplicar as mudanças, a menos que você use a opção `auto-approve`.
    
    **Exemplo:**
    
    ```bash
    terraform apply
    
    ```
    
- Após a execução, o Terraform atualizará o arquivo de estado (`terraform.tfstate`) para refletir as mudanças feitas.

---

### **5. Inspecionar e Validar**

- Após aplicar, você pode inspecionar o estado atual da infraestrutura usando o comando `terraform show`.
- Também é possível usar `terraform validate` para verificar se os arquivos de configuração estão corretos e bem formatados.

---

### **6. Ajustar e Iterar**

- Quando surgirem novas demandas ou alterações na infraestrutura:
    1. Atualize os arquivos de configuração.
    2. Gere um novo plano com `terraform plan`.
    3. Aplique as mudanças com `terraform apply`.

---

### **7. Destruir a Infraestrutura**

- Quando os recursos não forem mais necessários, use o comando `terraform destroy` para desprovisioná-los.
- Isso ajuda a evitar custos desnecessários em provedores de nuvem.
    
    **Exemplo:**
    
    ```bash
    terraform destroy
    
    ```
    

---

### **Fluxo Resumido**

1. **Configuração:** Crie ou edite os arquivos `.tf`.
2. **Inicialização:** `terraform init` para configurar o ambiente.
3. **Planejamento:** `terraform plan` para visualizar mudanças.
4. **Aplicação:** `terraform apply` para provisionar recursos.
5. **Gerenciamento contínuo:** Ajuste e re-aplique conforme necessário.
6. **Destruição:** `terraform destroy` para remover recursos.

---

### **Boas Práticas no Workflow**

- **Versionamento de Código:** Use sistemas de controle de versão, como Git, para rastrear mudanças nos arquivos `.tf`.
- **Estado Remoto:** Configure um backend remoto para armazenar o estado compartilhado em equipes.
- **Automação:** Integre o Terraform em pipelines de CI/CD para automação do fluxo de trabalho.
- **Validação:** Execute `terraform validate` e `terraform fmt` antes de aplicar mudanças.
- **Módulos Reutilizáveis:** Estruture configurações em módulos para aumentar a eficiência.

---

Esse fluxo garante que as mudanças sejam planejadas, documentadas e executadas de maneira previsível e segura.

Segue a documentação para mais informações:

https://developer.hashicorp.com/terraform/intro/core-workflow

## Setup do repositório no GitHub

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2098.png)

## Providers

No **Terraform**, os **providers** são componentes fundamentais que permitem a interação com APIs de plataformas e serviços para provisionar e gerenciar recursos. Eles atuam como intermediários que traduzem a configuração declarativa do Terraform em chamadas de API que criam, atualizam ou destroem os recursos em um provedor específico.

---

### **Características Principais dos Providers**

1. **Interface com Provedores de Serviço:**
    - Os providers conectam o Terraform a provedores de nuvem, serviços SaaS, bancos de dados ou até sistemas locais.
    - Exemplos de provedores: AWS, Azure, Google Cloud, Kubernetes, GitHub, etc.
2. **Recursos Específicos:**
    - Cada provider oferece um conjunto de recursos e funcionalidades que podem ser gerenciados.
    - Por exemplo:
        - **AWS:** EC2, S3, RDS, Lambda, etc.
        - **Azure:** VMs, Blob Storage, Azure Functions, etc.
        - **Kubernetes:** Deployments, Pods, Services, etc.
3. **Configuração Personalizada:**
    - Os providers precisam ser configurados com informações como credenciais de acesso e região.
    - Exemplo de configuração para o provider AWS:
        
        ```hcl
        provider "aws" {
          region = "us-east-1"
          access_key = "your-access-key"
          secret_key = "your-secret-key"
        }
        
        ```
        
4. **Módulos Plugáveis:**
    - Providers são módulos plugáveis, baixados durante a execução de `terraform init`.
    - Isso garante que o Terraform use a versão correta do provider para o projeto.

---

### **Configuração de Providers**

A configuração dos providers é declarada no arquivo `.tf` para informar ao Terraform qual plataforma será gerenciada.

**Exemplo para múltiplos providers:**

```hcl
provider "aws" {
  region = "us-west-1"
}

provider "google" {
  credentials = file("path-to-credentials.json")
  project     = "my-gcp-project"
  region      = "us-central1"
}

```

---

### **Versão dos Providers**

- É recomendável especificar a versão do provider para evitar atualizações não intencionais que possam introduzir alterações incompatíveis.
- Isso é feito com o bloco `required_providers`.

**Exemplo:**

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

```

---

### **Como os Providers Funcionam no Terraform Workflow**

1. **Download:** O comando `terraform init` baixa os providers necessários para o projeto.
2. **Interação com APIs:** Durante o `terraform apply`, o Terraform usa o provider para interagir com a API do serviço e gerenciar os recursos.
3. **Sincronização:** O estado do Terraform é atualizado conforme o feedback do provider sobre os recursos criados ou modificados.

---

### **Principais Providers Populares**

- **Nuvens Públicas:**
    - AWS (`hashicorp/aws`)
    - Azure (`hashicorp/azurerm`)
    - Google Cloud (`hashicorp/google`)
- **Orquestradores:**
    - Kubernetes (`hashicorp/kubernetes`)
    - Docker (`kreuzwerker/docker`)
- **Sistemas SaaS:**
    - GitHub (`integrations/github`)
    - Datadog (`DataDog/datadog`)
- **Infraestrutura Local:**
    - VMware vSphere (`hashicorp/vsphere`)
    - OpenStack (`terraform-provider-openstack/openstack`)

---

### **Importância dos Providers**

- Permitem que o Terraform seja uma ferramenta **multicloud** e **multipropósito**.
- Ampliam a flexibilidade para gerenciar desde infraestrutura na nuvem até serviços SaaS e sistemas locais.
- Abstraem a complexidade das APIs, tornando o gerenciamento mais simples e declarativo.

---

Resumindo, os **providers** são os pilares do Terraform que possibilitam sua ampla compatibilidade com diferentes plataformas, fazendo a ponte entre o código declarativo e os recursos reais provisionados.

É muito importante definir a versão dos providers.

Segue a documentação dos providers:

https://registry.terraform.io/browse/providers

Nesse módulo vamos utilizar o provider do AWS.

Documentation do provider do AWS:

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%2099.png)

Implementando provider da AWS:

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region
}
```

Execute o seguinte comando para iniciar e baixar os plugins do provider da AWS na versão mais recente:

```hcl
terraform init
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20100.png)

🗄 OBS! 🗄 O seu dia-a-dia para montar configurações do terraform é de suma importância que leia a documentação, e que ela esteja sempre aberta.

## Primeiro Recurso VPC

Criando TF do VPC

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

Nesse `main`, eu posso colocar um apelido

Execute o seguinte comando para ler os códigos e montar plano e mostrar na tela o que foi executado.

```hcl
terraform plan
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20101.png)

Agora vamos aplicar essas configurações com o comando:

```hcl
terraform apply
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20102.png)

Agora vá no sua conta da AWS e veja se a VPC foi criada.

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20103.png)

Agora vá em Arguments references e veja qual referencia srá o idela para configuração no TF.

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20104.png)

```hcl
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  # Habilitando DNS Support e DNS Hostnames
  enable_dns_support = true
  enable_dns_hostnames = true

  # Implementando tags
  tags = {
    Name = "comunidadedevops-vpc"
  }

}
```

```hcl
terraform plan

terraform apply -auto-approve
# Esse -auto-approve indica que você não precisa colocar 'yes' 
# após executar esse comando
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20105.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20106.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20107.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20108.png)

## Terraform state

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20109.png)

Esse arquivo que foi gerado o terraform.tfstate é um arquivo muito crítico, ou seja, tome muito cuidado com ele.

Ele deve ser aramazenado em  repositorio externo.

## Migrando o Backend do tfstate

O backend mais utilizado para aramazenar o tfstate é o S3  do AWS

Vamos criar um bucket S3 no AWS

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20110.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20111.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20112.png)

```hcl
aws s3 ls

aws s3 ls s3://comunidadedevops-eks-s3
```

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.81.0"
    }
  }
  backend "s3" {
    bucket = "comunidadedevops-eks-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
```

```hcl
terraform init -migrate-state
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20113.png)

Ou seja, toda modificação que eu for fazer as alterações do tfstate serão armazenadas no bucket criado na AWS

## terraform fmt

É sempre importante formatar os arquivos do terraform

```bash
terraform fmt -recursive -check

terraform fmt -recursive
```

As linhas de comando mencionadas estão relacionadas ao comando `terraform fmt`, que é usado para formatar arquivos de configuração do Terraform (`.tf` e `.tf.json`). Ele garante que o código segue os padrões de estilo recomendados pelo Terraform, tornando-o mais legível e consistente.

---

### **1. `terraform fmt -recursive -check`**

- **Descrição:**
    - Esse comando verifica todos os arquivos de configuração dentro do diretório atual e seus subdiretórios, sem modificar nada.
    - O argumento `check` é usado para realizar uma verificação e informar se algum arquivo não está formatado corretamente.
- **Uso prático:**
    - É útil em pipelines de CI/CD para validar que o código do Terraform segue o formato padrão antes de permitir o merge ou a execução.
- **Saída esperada:**
    - Caso os arquivos estejam corretamente formatados, o comando não exibe nenhuma mensagem.
    - Caso haja arquivos fora do padrão, o comando lista os arquivos que precisam ser formatados.
- **Exemplo de saída:**
    
    ```
    main.tf
    variables.tf
    
    ```
    
    Isso indica que os arquivos `main.tf` e `variables.tf` precisam ser formatados.
    

---

### **2. `terraform fmt -recursive`**

- **Descrição:**
    - Esse comando formata todos os arquivos de configuração no diretório atual e em seus subdiretórios, aplicando as correções necessárias.
    - Ele modifica diretamente os arquivos para ajustá-los ao estilo padrão do Terraform.
- **Uso prático:**
    - Ideal para garantir a consistência de formatação antes de commits ou durante o desenvolvimento.
- **Comportamento:**
    - Apenas os arquivos que precisam de ajustes serão alterados.
    - Se todos os arquivos já estiverem formatados corretamente, o comando não faz nenhuma mudança nem exibe mensagens.
- **Exemplo:**
Se você tem um arquivo com espaçamento ou indentação fora do padrão, como:
    
    ```hcl
    resource "aws_instance" "example" {
        ami = "ami-12345678"
      instance_type = "t2.micro"
    }
    
    ```
    
    Após executar o comando, ele será corrigido para:
    
    ```hcl
    resource "aws_instance" "example" {
      ami           = "ami-12345678"
      instance_type = "t2.micro"
    }
    
    ```
    

---

### **Diferença entre os dois comandos**

| Comando | Ação |
| --- | --- |
| `terraform fmt -recursive` | Formata automaticamente os arquivos de configuração, aplicando correções diretamente. |
| `terraform fmt -recursive -check` | Apenas verifica os arquivos sem modificar nada, útil para validação em pipelines ou revisões. |

---

### **Cenário Prático: CI/CD**

- **`terraform fmt -recursive -check`:** Adicione este comando em um pipeline de integração contínua para garantir que todos os arquivos estejam formatados corretamente.
- **`terraform fmt -recursive`:** Use localmente para ajustar a formatação antes de enviar o código para o repositório.

Esses comandos ajudam a manter um padrão consistente de formatação no código do Terraform, essencial para colaboração em equipe e manutenção de longo prazo.

## Pre-commit hooks para terraform

Os **pre-commit hooks** para Terraform são scripts automatizados que são executados antes de um commit ser feito no seu repositório Git. Eles ajudam a garantir a qualidade e a consistência do código, além de prevenir que código com problemas seja enviado ao repositório. No contexto do Terraform, esses hooks geralmente verificam a formatação, a validade, e outros padrões relacionados aos arquivos de configuração (`.tf`).

---

### **Como Funcionam os Pre-commit Hooks?**

1. **Definição de Regras:** Você configura os hooks no arquivo `.pre-commit-config.yaml`, onde define as ferramentas e as verificações a serem realizadas.
2. **Execução Automática:** Sempre que você tenta fazer um commit, o `pre-commit` executa essas verificações antes que o commit seja concluído.
3. **Correção ou Falha:**
    - Se o código passar em todas as verificações, o commit é feito.
    - Se houver problemas, os hooks falham e fornecem mensagens de erro, permitindo que você corrija antes de tentar novamente.

---

### **Por que usar Pre-commit Hooks para Terraform?**

- **Consistência:** Garante que o código está sempre formatado (`terraform fmt`) e segue os padrões de estilo.
- **Validação:** Verifica a validade das configurações do Terraform (`terraform validate`).
- **Qualidade:** Previne erros comuns ao aplicar práticas recomendadas automaticamente.
- **Automação:** Automatiza tarefas repetitivas, economizando tempo e esforço.

---

### **Exemplo de Configuração do Pre-commit para Terraform**

### **Passo 1: Instalar o Pre-commit**

Instale o pre-commit usando `pip`:

```bash
pip install pre-commit

```

### **Passo 2: Criar o Arquivo `.pre-commit-config.yaml`**

Exemplo de configuração básica para Terraform:

```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.77.0  # Use a versão mais recente
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_docs

```

### **Passo 3: Instalar os Hooks**

Depois de criar o arquivo de configuração, instale os hooks no repositório:

```bash
pre-commit install

```

### **Passo 4: Testar os Hooks**

Teste os hooks executando o pre-commit manualmente:

```bash
pre-commit run --all-files

```

---

### **Hooks Comuns para Terraform**

Os hooks mais populares para Terraform incluem:

| **Hook** | **Descrição** |
| --- | --- |
| `terraform_fmt` | Garante que os arquivos `.tf` estão formatados corretamente. |
| `terraform_validate` | Valida os arquivos do Terraform para garantir que a sintaxe e as dependências estão corretas. |
| `terraform_docs` | Atualiza automaticamente a documentação gerada nos blocos de variáveis e outputs. |
| `checkov` | Faz uma análise de segurança nas configurações do Terraform. |
| `tflint` | Verifica e aplica linting aos arquivos do Terraform para encontrar problemas ou inconsistências. |

---

### **Fluxo Prático de Uso**

1. Você edita os arquivos `.tf`.
2. Ao tentar fazer o commit (`git commit`), o pre-commit hooks:
    - Formata o código.
    - Valida os arquivos.
    - Atualiza documentação ou realiza outras verificações configuradas.
3. Se tudo estiver correto, o commit é concluído. Caso contrário, ele falha com mensagens explicativas.

---

### **Benefícios de Usar Pre-commit Hooks com Terraform**

- **Prevenção de Erros:** Evita que erros básicos cheguem ao repositório.
- **Automação de Qualidade:** Reduz revisões manuais relacionadas à formatação e padrões.
- **Colaboração:** Garante que todos os membros da equipe seguem os mesmos padrões.
- **Melhoria Contínua:** Facilita a adoção de boas práticas e ferramentas ao longo do tempo.

---

### **Integração com CI/CD**

Os pre-commit hooks podem ser integrados a pipelines de CI/CD para garantir que o código no repositório esteja sempre em conformidade, mesmo que algum membro da equipe não tenha os hooks configurados localmente.

Essa prática, combinada com o Terraform, melhora significativamente a eficiência, a segurança e a qualidade do código.

Segue a documentação do pré-commit:

https://github.com/antonbabenko/pre-commit-terraform?tab=readme-ov-file#how-to-install

**pre-commit para o comando terraform fmt:**

```yaml
repos:
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: v1.96.3 # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_fmt
      args:
      - --args=-recursive
```

```yaml
pre-commit intall

# output
pre-commit installed at .git/hooks/pre-commit
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20114.png)

## Terraform validate

O comando `terraform validate` é usado para validar a sintaxe e a configuração dos arquivos de configuração do Terraform. Ele verifica se os arquivos de configuração estão corretos e se todas as variáveis e recursos estão definidos corretamente. Este comando não faz nenhuma alteração na infraestrutura, apenas verifica a validade da configuração.

### Exemplo de uso:

```
terraform validate

```

### Passos:

1. Navegue até o diretório onde estão os arquivos de configuração do Terraform.
2. Execute o comando `terraform validate`.
3. O Terraform irá analisar os arquivos e retornar mensagens de erro ou sucesso.

### Benefícios:

- Ajuda a identificar erros de sintaxe antes de aplicar as mudanças.
- Garante que a configuração está correta e completa.

### Exemplo de saída:

```
Success! The configuration is valid.

```

Se houver erros, o Terraform fornecerá detalhes sobre o que está errado para que você possa corrigir.

### Implementando o comando terraform validate no pre commit

```yaml
repos:
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: v1.96.3 # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_fmt
      args:
      - --args=-recursive
    - id: terraform_validate
```

## Terraform console

O comando `terraform console` abre um console interativo que permite avaliar expressões e testar consultas no contexto da configuração do Terraform. É útil para depurar e explorar a configuração do Terraform.

### Exemplo de uso:

```
terraform console

```

### Passos:

1. Navegue até o diretório onde estão os arquivos de configuração do Terraform.
2. Execute o comando `terraform console`.
3. O console interativo será aberto, permitindo que você insira expressões Terraform.

### Exemplos de comandos no console:

- Avaliar uma variável:
    
    ```hcl
    var.my_variable
    
    ```
    
- Consultar um recurso:
    
    ```hcl
    aws_instance.my_instance.id
    
    ```
    
- Usar funções do Terraform:
    
    ```hcl
    length(var.my_list)
    
    ```
    

### Benefícios:

- Permite testar e validar expressões sem aplicar mudanças.
- Facilita a depuração de configurações complexas.
- Ajuda a entender como as variáveis e recursos são avaliados.

Para sair do console, você pode usar o comando `exit` ou pressionar `Ctrl+D`.

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20115.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20116.png)

## Terraform destroy

O comando `terraform destroy` é usado para destruir a infraestrutura gerenciada pelo Terraform. Ele remove todos os recursos definidos na configuração do Terraform.

### Exemplo de uso:

```
terraform destroy

```

### Passos:

1. Navegue até o diretório onde estão os arquivos de configuração do Terraform.
2. Execute o comando `terraform destroy`.
3. O Terraform irá mostrar um plano de destruição e solicitar confirmação.
4. Digite `yes` para confirmar e iniciar a destruição dos recursos.

### Benefícios:

- Útil para limpar recursos de um ambiente de teste ou desenvolvimento.
- Ajuda a evitar custos desnecessários ao remover recursos não utilizados.

### Exemplo de saída:

```
Terraform will perform the following actions:

  # aws_instance.example will be destroyed
  - resource "aws_instance" "example" {
      ...
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.example: Destroying... [id=i-1234567890abcdef0]
aws_instance.example: Destruction complete after 1m2s

Destroy complete! Resources: 1 destroyed.

```

### Avisos:

- Use com cuidado, pois este comando remove todos os recursos gerenciados pelo Terraform.
- Certifique-se de que você realmente deseja destruir os recursos antes de confirmar.

Similar code found with 2 license types

```yaml
terraform apply -destroy
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20117.png)

## Subnets

**Configurando o terraforn para implementar na minha cloud AWS**

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "comunidadedevops-subnet-public-1a"
  }
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "comunidadedevops-subnet-public-1b"
  }
}
```

```hcl
terraform fmt
terraform plan
terraform apply -auto-approve
```

## Variables

```hcl
variable "cidr_block" {
    type        = string
    description = "Networking CIDR block to be used for the VPC"
}
```

```hcl
resource "aws_vpc" "eks_vpc" {
  # Habilitando DNS Support e DNS Hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = var.cidr_block

  # Implementando tags
  tags = {
    Name = "comunidadedevops-vpc"
  }

}
```

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "comunidadedevops-subnet-public-1a"
  }
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "comunidadedevops-subnet-public-1b"
  }
}
```

```hcl
terraform plan -var 'cidr_block=10.0.0.0/16'
```

## terraform.tfvars (Valores para variáveis)

Crie um arquivo terraform.tfvars e implemente todos os valores das variáveis dentro desse arquivo

```hcl
# Aqui irá conter os valores das variáveis que serão utilizadas no arquivo main.tf

cidr_block = "10.0.0.0/16"
```

## Region dinâmica e tags para ALB

- Crie um arquivo chamado `region.tf`

```hcl
data "aws_region" "current" {}
```

### Explicação do Código

Este código define duas subnets públicas em uma VPC existente no AWS usando Terraform. Ambas as subnets são configuradas para serem usadas com o Amazon EKS (Elastic Kubernetes Service).

### Detalhes do Código

1. **aws_subnet.eks_subnet_public_1a**:
    - **vpc_id**: ID da VPC onde a subnet será criada.
    - **cidr_block**: Bloco CIDR da subnet, calculado dinamicamente usando a função `cidrsubnet`.
    - **availability_zone**: Zona de disponibilidade onde a subnet será criada, obtida dinamicamente.
    - **map_public_ip_on_launch**: Define se as instâncias lançadas na subnet receberão IPs públicos automaticamente.
    - **tags**: Tags associadas à subnet, incluindo um nome e uma tag específica para o Kubernetes.
2. **aws_subnet.eks_subnet_public_1b**:
    - Configuração similar à subnet `eks_subnet_public_1a`, mas em uma zona de disponibilidade diferente e com um bloco CIDR diferente.

### Código Completo

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "comunidadedevops-subnet-public-1a",
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "comunidadedevops-subnet-public-1b",
    "kubernetes.io/role/elb" = 1
  }
}

```

### Pontos Importantes

- **Região Dinâmica**: A região é obtida dinamicamente usando `data.aws_region.current.name`.
- **CIDR Dinâmico**: O bloco CIDR é calculado dinamicamente usando a função `cidrsubnet`.
- **Tags**: As tags são usadas para identificar as subnets e para integração com o Kubernetes.

Este código cria duas subnets públicas em diferentes zonas de disponibilidade, configuradas para uso com o Amazon EKS e com IPs públicos atribuídos automaticamente às instâncias lançadas.

```hcl
terraform fmt
terraform plan
terraform apply -auto-aprove
```

## Desacoplando tags usando locals

- Crie um arquivo chama local.tf, é onde será colocada todas as tegas que serão utilizadas.

```hcl
locals {
  tags = {
    Department = "DevOps"
    Organization = "Infrastructure and Operations"
    Project = "EKS"
    Environment = "Development"
  }
}
```

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-subnet-public-1a",
    "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

   tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-subnet-public-1b",
    "kubernetes.io/role/elb" = 1
    }
  )
}
```

### Explicação do Código

Este código define duas subnets públicas em uma VPC existente no AWS usando Terraform. Ambas as subnets são configuradas para serem usadas com o Amazon EKS (Elastic Kubernetes Service).

### Detalhes do Código

### Subnet 1: `eks_subnet_public_1a`

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-subnet-public-1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

```

- **vpc_id**: ID da VPC onde a subnet será criada.
- **cidr_block**: Bloco CIDR da subnet, calculado dinamicamente usando a função `cidrsubnet`.
- **availability_zone**: Zona de disponibilidade onde a subnet será criada, obtida dinamicamente.
- **map_public_ip_on_launch**: Define se as instâncias lançadas na subnet receberão IPs públicos automaticamente.
- **tags**: Tags associadas à subnet, incluindo um nome e uma tag específica para o Kubernetes.

### Subnet 2: `eks_subnet_public_1b`

```hcl
resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-subnet-public-1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

```

- Configuração similar à subnet `eks_subnet_public_1a`, mas em uma zona de disponibilidade diferente e com um bloco CIDR diferente.

### Pontos Importantes

- **Região Dinâmica**: A região é obtida dinamicamente usando `data.aws_region.current.name`.
- **CIDR Dinâmico**: O bloco CIDR é calculado dinamicamente usando a função `cidrsubnet`.
- **Tags**: As tags são usadas para identificar as subnets e para integração com o Kubernetes.

### Benefícios

- **Flexibilidade**: A configuração é adaptável a diferentes regiões e zonas de disponibilidade.
- **Organização**: As tags ajudam a identificar e gerenciar os recursos de forma eficiente.
- **Integração com Kubernetes**: As tags específicas para Kubernetes (`kubernetes.io/role/elb`) facilitam a integração com o Amazon EKS.

Este código cria duas subnets públicas em diferentes zonas de disponibilidade, configuradas para uso com o Amazon EKS e com IPs públicos atribuídos automaticamente às instâncias lançadas.

## Private subnets

```hcl
resource "aws_subnet" "eks_subnet_private_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone       = "${data.aws_region.current.name}a"

  tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-priv-subnet-1a",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_private_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone       = "${data.aws_region.current.name}b"

  tags = merge(
    local.tags,
    {
      Name                     = "comunidadedevops-priv-subnet-1b",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}
```

## Variable “project_name”

```hcl
variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}
```

```hcl
# Aqui irá conter os valores das variáveis que serão utilizadas no arquivo main.tf

# Bloco CIDR
cidr_block = "10.0.0.0/16"

# Nome do projeto
project_name = "eksdevelopment"
```

```hcl
resource "aws_subnet" "eks_subnet_private_1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1a",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_private_1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1b",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}
```

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}
```

## Internet Gateway e Route Table

```hcl
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )

}
```

```hcl
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )

}

# Configurando a rota padrão para a internet gateway
resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-pub-route-table"
    }
  )
}
```

```hcl
resource "aws_subnet" "eks_subnet_public_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

# Associando as subnets públicas com a route table pública
# ADD na subnet A
resource "aws_route_table_association" "eks_rtb_assoc_1a" {
  subnet_id      = aws_subnet.eks_subnet_public_1a.id
  route_table_id = aws_route_table.eks_public_route_table.id
}

# ADD na subnet B
resource "aws_route_table_association" "eks_rtb_assoc_1b" {
  subnet_id      = aws_subnet.eks_subnet_public_1b.id
  route_table_id = aws_route_table.eks_public_route_table.id
}
```

- Depois de aplicar, vá até o console da AWS e consulte se foi criado corretamente.

## NAT gateway e EIP

```hcl
resource "aws_eip" "eks_ngw_eip_1a" {

  # No curso foi usado o 'vpc = true' para criar um Elastic IP na VPC
  # Porém, ele está depreciado e não e está sendo mais usado

  # O correto é usar o 'domain = "vpc"' para criar um Elastic IP na VPC
  domain = "vpc"
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1a"
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {

  # No curso foi usado o 'vpc = true' para criar um Elastic IP na VPC
  # Porém, ele está depreciado e não e está sendo mais usado

  # O correto é usar o 'domain = "vpc"' para criar um Elastic IP na VPC
  domain = "vpc"
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1b"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_subnet_public_1a.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1a"
    }
  )

}

resource "aws_nat_gateway" "eks_ngw_1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_subnet_public_1b.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1b"
    }
  )

}
```

## Private route tables

```hcl
resource "aws_eip" "eks_ngw_eip_1a" {

  # No curso foi usado o 'vpc = true' para criar um Elastic IP na VPC
  # Porém, ele está depreciado e não e está sendo mais usado

  # O correto é usar o 'domain = "vpc"' para criar um Elastic IP na VPC
  domain = "vpc"
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1a"
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {

  # No curso foi usado o 'vpc = true' para criar um Elastic IP na VPC
  # Porém, ele está depreciado e não e está sendo mais usado

  # O correto é usar o 'domain = "vpc"' para criar um Elastic IP na VPC
  domain = "vpc"
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1b"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_subnet_public_1a.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1a"
    }
  )

}

resource "aws_nat_gateway" "eks_ngw_1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_subnet_public_1b.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1b"
    }
  )

}

resource "aws_route_table" "eks_private_route_table_1a" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_ngw_1a.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-priv-route-table-1a"
    }
  )
}

resource "aws_route_table" "eks_private_route_table_1b" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_ngw_1b.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-priv-route-table-1b"
    }
  )
}
```

```hcl
resource "aws_subnet" "eks_subnet_private_1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1a",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_private_1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1b",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_route_table_association" "eks_rtb_assoc_priv_1a" {
  subnet_id      = aws_subnet.eks_subnet_private_1a.id
  route_table_id = aws_route_table.eks_private_route_table_1a.id
}

resource "aws_route_table_association" "eks_rtb_assoc_priv_1b" {
  subnet_id      = aws_subnet.eks_subnet_private_1b.id
  route_table_id = aws_route_table.eks_private_route_table_1b.id
}
```

## Introdução a terraform modules

## Introdução

### Módulos do Terraform

Os módulos do Terraform são blocos reutilizáveis de configuração que agrupam vários recursos relacionados. Eles ajudam a organizar e reutilizar código, facilitando a manutenção e a padronização das infraestruturas.

### Benefícios dos Módulos

- **Reutilização**: Permite reutilizar a mesma configuração em diferentes projetos.
- **Organização**: Ajuda a estruturar o código de forma mais organizada e modular.
- **Manutenção**: Facilita a manutenção e atualização da infraestrutura.
- **Padronização**: Garante que as melhores práticas sejam seguidas de forma consistente.

### Estrutura de um Módulo

Um módulo geralmente consiste em três arquivos principais:

- [**main.tf**](http://main.tf/): Define os recursos principais.
- [**variables.tf**](http://variables.tf/): Define as variáveis de entrada.
- [**outputs.tf**](http://outputs.tf/): Define as saídas do módulo.

### Exemplo de Módulo

### Estrutura de Diretórios

```
modules/
  └── vpc/
      ├── main.tf
      ├── variables.tf
      └── outputs.tf

```

### [main.tf](http://main.tf/)

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

```

### 

[variables.tf](http://variables.tf/)

```hcl
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = number
  default     = 2
}

```

### [outputs.tf](http://outputs.tf/)

```hcl
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

```

### Usando o Módulo

Para usar o módulo em uma configuração principal, você pode referenciá-lo da seguinte forma:

```hcl
module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  vpc_name            = "my-vpc"
  public_subnet_count = 2
}

```

### Pontos Importantes

- **source**: Especifica o caminho do módulo. Pode ser um caminho local, um repositório Git, ou um registro de módulos.
- **Variáveis**: As variáveis definidas no módulo são passadas como argumentos.
- **Saídas**: As saídas do módulo podem ser usadas na configuração principal.

### Conclusão

Os módulos do Terraform são uma poderosa ferramenta para organizar, reutilizar e padronizar a infraestrutura como código. Eles ajudam a manter o código limpo, modular e fácil de manter.

## Modulo Networking

- Crie um diretório chamado de **modules** e é dentro desse diretório que serão criados os nosso módulos

- Dentro do diretório modules, crie um diretório chamado de **network**

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20118.png)

- Para fazer a chamada do módulo é necessário que crie um arquivo chamado de `modules.tf`

```hcl
module "eks_network" {
    source = "./modules/network"
    # Passando as variáveis para o módulo
    project_name = var.project_name
    cidr_block = var.cidr_block
    tags = local.tags
}
```

./modules/network/variables.tf

```hcl
variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type = map
  description = "Tags to be added to AWS resources"
}
```

Execute o seguinte comando:

```hcl
terraform init
terraform plan
terraform apply -auto-approve
```

## Output do Módulo

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20119.png)

1

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.

output "subnet_pub_1a" {
  value = aws_subnet.eks_subnet_public_1a.id

}

output "subnet_pub_1b" {
  value = aws_subnet.eks_subnet_public_1b.id

}

output "subnet_priv_1a" {
  value = aws_subnet.eks_subnet_private_1a.id

}

output "subnet_priv_1b" {
  value = aws_subnet.eks_subnet_private_1b.id

}
```

2

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
    value = module.eks_network.subnet_pub_1a
  
}
```

## Módulo do Cluster

## EKS Cluster IAM role

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20120.png)

iam.tf

```hcl
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-cluster-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-role"
    }
  )
}
```

variables.tf

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map
  description = "Tags to be added to AWS resources"
}
```

modules.tf

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
    source = "./modules/cluster"
    project_name = var.project_name
    tags = local.tags
}
```

```hcl
terraform init
terraform fmt -recursive
terraform plan
terraform apply -auto-approve
```

- Agora vamos colocar as permissões (policy)
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment - iam policy attachment

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20121.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20122.png)

```hcl
# Arquivo responsável por criar as permissões necessárias para o EKS gerenciar clusters

# Vamos criar uma role para o EKS gerenciar clusters
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-cluster-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-role"
    }
  )
}

# Vamos anexar a policy AmazonEKSClusterPolicy ao role criado que permite o EKS gerenciar clusters
resource "aws_iam_policy_attachment" "eks_cluster_role_attachment" {
  name       = "${var.project_name}-cluster-role-attachment"
  roles      = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
```

# 📕OBS📕: Toda vez que você cria uma módulo, necessário que execute o seguinte comenado:

```hcl
terraform init
```

## Criação do cluster EKS

```hcl
resource "aws_eks_cluster" "eks_cluster" {

  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      var.public_subnet_1a,
      var.public_subnet_1b
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  # Forçar a dependência para que o cluster só seja criado após a role e a policy serem criadas
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_attachment
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster"
    }
  )

}
```

Este código Terraform cria um cluster EKS (Elastic Kubernetes Service) na AWS com as seguintes configurações:

- **Nome do Cluster:** Utiliza a variável project_name concatenada com "-cluster"
- **IAM Role:** Associa a role criada anteriormente (eks_cluster_role) para permitir que o EKS gerencie recursos AWS
- **Configuração de VPC:**
    - Utiliza duas subnets públicas (1a e 1b)
    - Permite acesso tanto privado quanto público ao endpoint do cluster
- **Dependências:** Garante que a policy seja anexada à role antes da criação do cluster através do depends_on
- **Tags:** Mescla as tags padrão definidas com uma tag Name específica para o cluster

Este é um exemplo de infraestrutura como código que cria um cluster EKS básico e seguro na AWS, pronto para hospedar aplicações Kubernetes.

Variables

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1a"

}

variable "public_subnet_1b" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1b"

}
```

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20123.png)

```hcl
terraform apply -auto-aprove
```

## Alterando a regra de HTTPS para API server

module/cluster

```hcl
output "eks_vpc_config" {
    value = aws_eks_cluster.eks_cluster.vpc_config
  
}
```

./projeto

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
  value = module.eks_network.subnet_pub_1a

}

# Fazendo a chama do output do módulo cluster imprimir a configuração da VPC
output "eks_vpc_config" {
    value = module.eks_cluster.eks_vpc_config
  
}
```

sg-rule.tf

```hcl
resource "aws_security_group_rule" "eks_cluster_sg_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id

}
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20124.png)

🚨OBS🚨 

O [0] é usado porque vpc_config retorna uma lista de configurações VPC, mesmo que normalmente só exista uma configuração. Em Terraform, quando um atributo retorna uma lista ou array, precisamos especificar qual elemento queremos acessar usando o índice.

Neste caso, [0] está acessando o primeiro (e único) elemento da lista de configurações VPC do cluster EKS. É uma particularidade da API do AWS EKS que requer este acesso indexado, mesmo quando sabemos que só existe uma configuração VPC.

Se tentássemos acessar cluster_security_group_id diretamente sem o [0], receberíamos um erro porque o Terraform não saberia qual elemento da lista usar.

```hcl
terraform fmt -recursive
terraform plan 
terraform apply -auto-approve
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20125.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20126.png)

A imagem mostra a interface de gerenciamento de grupos de segurança (Security Groups) no console da AWS. Especificamente, está exibindo uma regra de entrada (inbound rule) para HTTPS na porta 443 que foi configurada para o cluster EKS (Elastic Kubernetes Service). A regra permite tráfego HTTPS de entrada (IPv4) de qualquer origem (0.0.0.0/0) para o grupo de segurança do cluster EKS.

Os elementos principais visíveis na imagem são:

- Um grupo de segurança associado ao cluster EKS (eks-cluster-sg-eksdevopment)
- Uma regra de entrada configurada para:
- Protocolo: TCP
- Porta: 443 (HTTPS)
- Origem: 0.0.0.0/0 (qualquer IP)
- Tipo: IPv4

Esta configuração permite que a API do cluster Kubernetes seja acessada de forma segura através de HTTPS de qualquer localização na internet.

## Entendendo o Fingerprint do OIDC

O Fingerprint OIDC (OpenID Connect) é uma sequência única de caracteres que identifica e verifica a autenticidade de um provedor OIDC. No contexto do EKS (Elastic Kubernetes Service), o fingerprint é usado para estabelecer uma relação de confiança segura entre o cluster EKS e o provedor de identidade.

Principais aspectos do Fingerprint OIDC:

- **Função de Segurança:** Garante que a comunicação está sendo feita com o provedor OIDC legítimo, prevenindo ataques de intermediário (man-in-the-middle)
- **Autenticação IAM:** Permite que pods no EKS assumam roles do IAM através da autenticação OIDC, eliminando a necessidade de gerenciar credenciais AWS manualmente
- **Integração com AWS:** O EKS usa o fingerprint para configurar a integração com o AWS IAM, permitindo um controle de acesso mais granular aos recursos AWS

O fingerprint é especialmente importante quando se configura a integração do EKS com serviços AWS usando o IAM Roles for Service Accounts (IRSA), pois ele valida a autenticidade do provedor OIDC do cluster.

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20127.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20128.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20129.png)

Vai abrir essa tela, onde você poder extrair o fingerprint ou baixar o certificar e imprimir via command line

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20130.png)

Feito o download, execute o seguinte comando:

```bash
openssl x509 -in ~/Downloads/eks-us-east-1-amazonaws-com.pem -text 
```

```bash
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            08:92:fd:5c:66:da:c2:96:7a:22:c1:86:bc:3a:9d:c8
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Amazon, CN=Amazon RSA 2048 M02
        Validity
            Not Before: Mar 28 00:00:00 2024 GMT
            Not After : Apr 26 23:59:59 2025 GMT
        Subject: CN=*.eks.us-east-1.amazonaws.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:b8:89:5a:60:c6:38:0e:98:c2:9d:0b:6b:58:4c:
                    76:bd:cb:3b:ae:2d:d6:02:8e:90:ba:c4:dd:55:80:
                    8e:f5:b9:38:92:c5:41:9f:e9:1d:cd:fd:17:64:e6:
                    f8:f3:d8:23:ae:dd:fb:15:80:c8:7a:70:2a:6a:ac:
                    f9:71:53:fe:6e:3f:4f:c3:15:f4:06:75:5c:41:6d:
                    9e:2f:61:10:bd:8c:86:e0:c8:a9:b0:a8:e1:09:30:
                    3f:fd:07:78:86:1f:3d:ca:a4:1a:67:5c:37:2e:ba:
                    5a:96:b0:2b:6e:ba:ac:63:9c:c2:cb:e2:1d:54:74:
                    e7:80:3c:dc:21:3b:24:31:28:c1:e5:f8:b7:eb:09:
                    97:82:b9:e8:4a:72:1f:97:33:ff:25:85:d2:a0:63:
                    22:e9:f2:8d:4d:9b:b2:2c:34:6d:5a:37:a8:8d:a1:
                    9e:ab:c4:4c:94:57:0e:9f:57:ea:59:0d:a2:2b:c6:
                    46:1f:ee:e9:d0:ac:07:d4:59:1d:76:da:95:c6:cd:
                    64:6d:bf:95:46:64:b8:eb:72:2f:1e:bf:86:69:80:
                    65:62:23:36:f6:2c:ea:93:16:6f:20:75:ee:9a:51:
                    19:40:9b:8b:8c:0c:5c:e6:67:f8:8e:a8:45:7e:e7:
                    6b:ce:f5:9d:04:e9:8a:39:33:77:49:66:a4:28:ee:
                    e5:29
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier: 
                C0:31:52:CD:5A:50:C3:82:7C:74:71:CE:CB:E9:9C:F9:7A:EB:82:E2
            X509v3 Subject Key Identifier: 
                84:6D:59:0C:A6:BB:EA:1B:4B:65:55:CF:F8:4D:CF:DC:69:D8:1E:31
            X509v3 Subject Alternative Name: 
                DNS:*.eks.us-east-1.amazonaws.com
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.2.1
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 CRL Distribution Points: 
                Full Name:
                  URI:http://crl.r2m02.amazontrust.com/r2m02.crl
            Authority Information Access: 
                OCSP - URI:http://ocsp.r2m02.amazontrust.com
                CA Issuers - URI:http://crt.r2m02.amazontrust.com/r2m02.cer
            X509v3 Basic Constraints: critical
                CA:FALSE
            CT Precertificate SCTs: 
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : CF:11:56:EE:D5:2E:7C:AF:F3:87:5B:D9:69:2E:9B:E9:
                                1A:71:67:4A:B0:17:EC:AC:01:D2:5B:77:CE:CC:3B:08
                    Timestamp : Mar 28 21:41:13.052 2024 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:20:72:37:F7:6F:A4:E4:3B:3B:EF:B9:CC:E0:
                                2C:0D:AF:EC:63:8C:2A:F8:F4:24:3F:BC:72:09:0D:92:
                                57:A2:43:3B:02:21:00:FB:E5:4F:0F:2C:8C:2E:28:CF:
                                CB:41:91:F1:90:48:BC:07:2B:61:B8:DF:25:74:C5:DC:
                                69:22:CD:E2:4B:54:92
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : 7D:59:1E:12:E1:78:2A:7B:1C:61:67:7C:5E:FD:F8:D0:
                                87:5C:14:A0:4E:95:9E:B9:03:2F:D9:0E:8C:2E:79:B8
                    Timestamp : Mar 28 21:41:13.054 2024 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:20:20:64:84:C6:9F:F6:07:51:DD:B0:9B:2F:
                                15:C5:6C:73:44:5D:48:7B:B7:73:FF:4B:16:94:28:37:
                                04:E9:49:88:02:21:00:DB:9C:D9:F5:A0:6D:FE:6A:E1:
                                0D:C3:1C:D7:9E:55:F2:A9:F0:69:D4:C4:AA:DB:4B:74:
                                FE:17:30:49:8C:B0:F0
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : E6:D2:31:63:40:77:8C:C1:10:41:06:D7:71:B9:CE:C1:
                                D2:40:F6:96:84:86:FB:BA:87:32:1D:FD:1E:37:8E:50
                    Timestamp : Mar 28 21:41:13.073 2024 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:44:02:20:51:45:E2:4A:6A:70:D8:07:17:34:62:D9:
                                C9:CB:E0:76:CD:02:96:65:9E:57:3E:45:EF:48:C9:85:
                                E2:0A:57:6A:02:20:64:65:48:2C:D7:68:AE:DA:E5:86:
                                53:DE:D5:50:02:02:B7:6F:B3:66:48:63:51:5D:E2:F8:
                                ED:E4:62:1D:72:AD
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        59:8e:4e:c5:1e:eb:5a:d6:05:4b:4f:71:01:86:08:1e:50:45:
        ef:07:54:c5:01:fa:d3:38:bf:22:a0:07:64:84:42:14:8d:71:
        1d:db:09:d0:15:2f:df:49:4b:ca:21:ad:56:be:03:85:e0:68:
        f3:5f:c8:12:b0:51:a5:79:92:91:da:03:24:0f:b9:77:f2:73:
        dc:41:6d:6e:b5:68:82:31:12:00:b0:20:05:f4:86:b8:95:f4:
        40:bb:21:8f:24:e5:f4:ed:ab:d3:4a:a4:c4:88:5b:2a:64:8f:
        4a:5f:49:41:5c:6a:b7:68:d3:68:1e:a9:0f:74:a3:59:7e:94:
        fa:5d:fd:ec:db:35:2f:aa:48:6f:5e:35:f2:85:68:ec:b7:87:
        c0:47:84:c7:a0:0f:30:8c:a3:ce:57:dc:5d:d0:87:03:a9:55:
        29:e8:8d:17:c4:87:f9:05:be:87:a6:4e:a4:65:c9:21:4e:a5:
        94:18:e0:58:08:6c:72:aa:c6:46:3d:40:3e:9b:8a:58:65:64:
        54:2c:1e:02:32:0e:70:4b:96:57:c1:6a:99:fa:75:87:d8:e6:
        79:49:06:e9:2a:01:89:fa:e5:e3:53:ef:84:ad:28:a9:0d:cb:
        94:01:7a:3a:9e:a7:ec:92:da:da:b9:57:91:fe:8b:89:e9:d9:
        0d:59:52:b9
-----BEGIN CERTIFICATE-----
MIIF5TCCBM2gAwIBAgIQCJL9XGbawpZ6IsGGvDqdyDANBgkqhkiG9w0BAQsFADA8
MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRwwGgYDVQQDExNBbWF6b24g
UlNBIDIwNDggTTAyMB4XDTI0MDMyODAwMDAwMFoXDTI1MDQyNjIzNTk1OVowKDEm
MCQGA1UEAwwdKi5la3MudXMtZWFzdC0xLmFtYXpvbmF3cy5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4iVpgxjgOmMKdC2tYTHa9yzuuLdYCjpC6
xN1VgI71uTiSxUGf6R3N/Rdk5vjz2COu3fsVgMh6cCpqrPlxU/5uP0/DFfQGdVxB
bZ4vYRC9jIbgyKmwqOEJMD/9B3iGHz3KpBpnXDcuulqWsCtuuqxjnMLL4h1UdOeA
PNwhOyQxKMHl+LfrCZeCuehKch+XM/8lhdKgYyLp8o1Nm7IsNG1aN6iNoZ6rxEyU
Vw6fV+pZDaIrxkYf7unQrAfUWR122pXGzWRtv5VGZLjrci8ev4ZpgGViIzb2LOqT
Fm8gde6aURlAm4uMDFzmZ/iOqEV+52vO9Z0E6Yo5M3dJZqQo7uUpAgMBAAGjggL1
MIIC8TAfBgNVHSMEGDAWgBTAMVLNWlDDgnx0cc7L6Zz5euuC4jAdBgNVHQ4EFgQU
hG1ZDKa76htLZVXP+E3P3GnYHjEwKAYDVR0RBCEwH4IdKi5la3MudXMtZWFzdC0x
LmFtYXpvbmF3cy5jb20wEwYDVR0gBAwwCjAIBgZngQwBAgEwDgYDVR0PAQH/BAQD
AgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjA7BgNVHR8ENDAyMDCg
LqAshipodHRwOi8vY3JsLnIybTAyLmFtYXpvbnRydXN0LmNvbS9yMm0wMi5jcmww
dQYIKwYBBQUHAQEEaTBnMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5yMm0wMi5h
bWF6b250cnVzdC5jb20wNgYIKwYBBQUHMAKGKmh0dHA6Ly9jcnQucjJtMDIuYW1h
em9udHJ1c3QuY29tL3IybTAyLmNlcjAMBgNVHRMBAf8EAjAAMIIBfQYKKwYBBAHW
eQIEAgSCAW0EggFpAWcAdgDPEVbu1S58r/OHW9lpLpvpGnFnSrAX7KwB0lt3zsw7
CAAAAY6HAoTcAAAEAwBHMEUCIHI392+k5Ds777nM4CwNr+xjjCr49CQ/vHIJDZJX
okM7AiEA++VPDyyMLijPy0GR8ZBIvAcrYbjfJXTF3GkizeJLVJIAdgB9WR4S4Xgq
exxhZ3xe/fjQh1wUoE6VnrkDL9kOjC55uAAAAY6HAoTeAAAEAwBHMEUCICBkhMaf
9gdR3bCbLxXFbHNEXUh7t3P/SxaUKDcE6UmIAiEA25zZ9aBt/mrhDcMc155V8qnw
adTEqttLdP4XMEmMsPAAdQDm0jFjQHeMwRBBBtdxuc7B0kD2loSG+7qHMh39HjeO
UAAAAY6HAoTxAAAEAwBGMEQCIFFF4kpqcNgHFzRi2cnL4HbNApZlnlc+Re9IyYXi
CldqAiBkZUgs12iu2uWGU97VUAICt2+zZkhjUV3i+O3kYh1yrTANBgkqhkiG9w0B
AQsFAAOCAQEAWY5OxR7rWtYFS09xAYYIHlBF7wdUxQH60zi/IqAHZIRCFI1xHdsJ
0BUv30lLyiGtVr4DheBo81/IErBRpXmSkdoDJA+5d/Jz3EFtbrVogjESALAgBfSG
uJX0QLshjyTl9O2r00qkxIhbKmSPSl9JQVxqt2jTaB6pD3SjWX6U+l397Ns1L6pI
b1418oVo7LeHwEeEx6APMIyjzlfcXdCHA6lVKeiNF8SH+QW+h6ZOpGXJIU6llBjg
WAhscqrGRj1APpuKWGVkVCweAjIOcEuWV8Fqmfp1h9jmeUkG6SoBifrl41PvhK0o
qQ3LlAF6Op6n7JLa2rlXkf6LienZDVlSuQ==
-----END CERTIFICATE-----
```

OU

```bash
openssl x509 -in ~/Downloads/eks-us-east-1-amazonaws-com.pem -fingerprint -noout | cut -d = -f 2 | sed 's/://g' | tr '[:upper:]' '[:lower:]'

# Output
9451ad2b53c7f41fab22886cc07d482085336561

```

## Criação do OIDC Provider

```hcl
data "tls_certificate" "eks_oidc_tls_certificate" {
    url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

```

Output

module/cluster

```hcl
output "oidc" {
    value = aws_eks_cluster.eks_cluster.identity
  
}
```

Depois de debugar o problema, chegamos a essa configuração

```hcl
output "eks_vpc_config" {
    value = aws_eks_cluster.eks_cluster.vpc_config
  
}

output "oidc" {
    value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
}
```

./project

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
  value = module.eks_network.subnet_pub_1a

}

# Fazendo a chama do output do módulo cluster imprimir a configuração da VPC
output "eks_vpc_config" {
    value = module.eks_cluster.eks_vpc_config
  
}

output "oidc" {
    value = module.eks_cluster.oidc
  
}
```

sg-rule.tf

```hcl
resource "aws_security_group_rule" "eks_cluster_sg_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id

}
```

oidc.tf

```hcl
data "tls_certificate" "eks_oidc_tls_certificate" {
    url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
    client_id_list = [
        "sts.amazonaws.com"
    ]
    thumbprint_list = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
    url = data.tls_certificate.eks_oidc_tls_certificate.url

    tags = merge(
        var.tags,
        {
            Name = "${var.project_name}-oidc"
        }
    )

  
}
```

```hcl
terraform init
terraform plan
terraform apply -auto-approve
```

## Módulo do Managed Node Group

Um Managed Node Group é um recurso do Amazon EKS (Elastic Kubernetes Service) que automatiza o provisionamento e gerenciamento dos nós (nodes) do cluster Kubernetes.

Principais características do Managed Node Group:

- **Gerenciamento Automatizado:** A AWS gerencia automaticamente o ciclo de vida dos nós, incluindo atualizações de sistema operacional, patches de segurança e atualizações do Kubernetes
- **Auto Scaling:** Suporta escalabilidade automática baseada em demanda, podendo aumentar ou diminuir o número de nós conforme necessário
- **Integração com IAM:** Utiliza roles IAM para gerenciar permissões e acessos de forma segura
- **Facilidade de Manutenção:** Permite atualizações rolling dos nós sem interrupção do serviço
- **Monitoramento:** Integração com CloudWatch para métricas e logs dos nós

O Managed Node Group é especialmente útil porque:

- Reduz a complexidade operacional do gerenciamento de nós
- Minimiza o trabalho manual de manutenção e atualização
- Garante alta disponibilidade e confiabilidade do cluster
- Oferece melhor custo-benefício por otimizar recursos automaticamente

## Configuração do kubeconfig para kubectl

Comando para gerar um kubeconfig

```hcl
aws eks update-kubeconfig --region us-east-1 --name eksdevelopment-cluster
```

Variables

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  
}

variable "subnet_private_1a" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1a"
  
}

variable "subnet_private_1b" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1b"
  
}

```

```hcl
resource "aws_eks_node_group" "eks" {
    cluster_name = var.cluster_name
    node_group_name = "${var.project_name}-nodegroup"
    node_role_arn = aws_iam_role.eks_mng_role.arn
    subnet_ids = [
        var.subnet_private_1a,
        var.subnet_private_1b,
    ]

    scaling_config {
        desired_size = 1
        max_size = 1
        min_size = 1
    }

    depends_on = [ 
        aws_iam_role_policy_attachment.eks_mng_role_attachment_worker,
        aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr,
        aws_iam_role_policy_attachment.eks_mng_role_attachment_cni
     ]

}
```

Este é um recurso do Terraform que define um grupo de nós gerenciados (Managed Node Group) para um cluster EKS. Vamos analisar seus principais componentes:

- **Identificação e Localização**: O grupo de nós é vinculado a um cluster EKS específico e será implantado nas subnets privadas especificadas (subnet_private_1a e 1b)
- **Configuração de Escala**: Define os parâmetros de escalabilidade do grupo, onde neste caso está configurado para manter exatamente 1 nó (desired_size = 1, max_size = 1, min_size = 1)
- **Dependências**: O recurso depende de três políticas IAM essenciais:
    - Uma política para workers do EKS
    - Uma política para acesso ao ECR (Container Registry)
    - Uma política para o CNI (Container Network Interface)

Este recurso é parte fundamental do EKS pois é responsável por gerenciar os nós onde os containers Kubernetes serão executados. Ele oferece benefícios importantes como:

- Gerenciamento automatizado do ciclo de vida dos nós
- Capacidade de auto-scaling baseado em demanda
- Integração com IAM para gerenciamento seguro de permissões

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}

module "eks_managed_node_group" {
  source       = "./modules/managed-node-group"
  project_name = var.project_name
  cluster_name = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_priv_1a
  subnet_private_1b = module.eks_network.subnet_priv_1b
  tags         = local.tags

}
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20131.png)

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20132.png)

## Módulo do AWS Load Balancer Controller

## IAM policy do Controller

Segue o link para pegar o json iam_policy

https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

```bash
wget https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
```

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": "elasticloadbalancing.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeVpcs",
                "ec2:DescribeVpcPeeringConnections",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeInstances",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeTags",
                "ec2:GetCoipPoolUsage",
                "ec2:DescribeCoipPools",
                "ec2:GetSecurityGroupsForVpc",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeListenerCertificates",
                "elasticloadbalancing:DescribeSSLPolicies",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:DescribeTags",
                "elasticloadbalancing:DescribeTrustStores",
                "elasticloadbalancing:DescribeListenerAttributes",
                "elasticloadbalancing:DescribeCapacityReservation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-idp:DescribeUserPoolClient",
                "acm:ListCertificates",
                "acm:DescribeCertificate",
                "iam:ListServerCertificates",
                "iam:GetServerCertificate",
                "waf-regional:GetWebACL",
                "waf-regional:GetWebACLForResource",
                "waf-regional:AssociateWebACL",
                "waf-regional:DisassociateWebACL",
                "wafv2:GetWebACL",
                "wafv2:GetWebACLForResource",
                "wafv2:AssociateWebACL",
                "wafv2:DisassociateWebACL",
                "shield:GetSubscriptionState",
                "shield:DescribeProtection",
                "shield:CreateProtection",
                "shield:DeleteProtection"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateSecurityGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags"
            ],
            "Resource": "arn:aws:ec2:*:*:security-group/*",
            "Condition": {
                "StringEquals": {
                    "ec2:CreateAction": "CreateSecurityGroup"
                },
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Resource": "arn:aws:ec2:*:*:security-group/*",
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateTargetGroup"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:CreateRule",
                "elasticloadbalancing:DeleteRule"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:RemoveTags"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
            ],
            "Condition": {
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:RemoveTags"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:SetIpAddressType",
                "elasticloadbalancing:SetSecurityGroups",
                "elasticloadbalancing:SetSubnets",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:ModifyListenerAttributes",
                "elasticloadbalancing:ModifyCapacityReservation"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:AddTags"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
            ],
            "Condition": {
                "StringEquals": {
                    "elasticloadbalancing:CreateAction": [
                        "CreateTargetGroup",
                        "CreateLoadBalancer"
                    ]
                },
                "Null": {
                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets"
            ],
            "Resource": "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:SetWebAcl",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:AddListenerCertificates",
                "elasticloadbalancing:RemoveListenerCertificates",
                "elasticloadbalancing:ModifyRule"
            ],
            "Resource": "*"
        }
    ]
}

```

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

```

```hcl
resource "aws_iam_policy" "policy" {

  name = "${var.project_name}-policy"

  policy = file("${path.module}/policy.json")
  tags   = var.tags

}
```

Este resource do Terraform cria uma política IAM (Identity and Access Management) na AWS com as seguintes características:

- **Tipo do Recurso:** "aws_iam_policy" - Indica que estamos criando uma política IAM na AWS
- **Nome do Recurso:** O nome da política é dinâmico, usando a variável "project_name" concatenada com "-policy"
- **Conteúdo da Política:** O conteúdo é carregado de um arquivo JSON local usando a função file(). O caminho "${path.module}/policy.json" referencia um arquivo policy.json no mesmo diretório do módulo
- **Tags:** As tags são atribuídas através da variável "var.tags", permitindo a marcação do recurso para melhor organização

Este resource é comumente usado para definir permissões e controles de acesso na AWS, sendo parte fundamental da infraestrutura como código com Terraform.

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_priv_1a
  subnet_private_1b = module.eks_network.subnet_priv_1b
  tags              = local.tags

}

module "eks_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  project_name = var.project_name
  tags         = local.tags

}
```

```hcl
terraform init
terraform fmt -recursive
terraform plan
terraform apply -auto-approve
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20133.png)

## IAM role do Controller

```hcl
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
```

```hcl
# Arquivo responsável por criar as permissões necessárias para o EKS gerenciar clusters

# Vamos criar uma role para o EKS gerenciar clusters
resource "aws_iam_role" "eks_controller_role" {
  name = "${var.project_name}-aws-load-balancer-controller"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:aud": "sts.amazonaws.com",
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}
EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-aws-load-balancer-controller"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_controller_role_attachment" {
  role       = aws_iam_role.eks_controller_role.name
  policy_arn = aws_iam_policy.eks_load_balancer_controller.arn
}
# Vamos anexar a policy AmazonEKSClusterPolicy ao role criado que permite o EKS gerenciar clusters
# resource "aws_iam_role_policy_attachment" "eks_controller_role_attachment" {
#   role       = aws_iam_role.eks_controller_role.name
#   policy_arn = aws_iam_policy.eks_load_balancer_controller.arn
# }

# data - vai buscar informações do ambiente atual da AWS para utilizar no código
```

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from OIDC provider of the EKS cluster"

}
```

```hcl
output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster.vpc_config

}

# output "oidc" {
#   value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
# }

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

output "oidc" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
```

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_priv_1a
  subnet_private_1b = module.eks_network.subnet_priv_1b
  tags              = local.tags

}

module "eks_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  project_name = var.project_name
  tags         = local.tags
  oidc         = module.eks_cluster.oidc

}
```

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
  value = module.eks_network.subnet_pub_1a

}

# Fazendo a chama do output do módulo cluster imprimir a configuração da VPC
output "eks_vpc_config" {
  value = module.eks_cluster.eks_vpc_config

}

# output "oidc" {
#   value = module.eks_cluster.oidc

# }

output "oidc" {
  value = module.eks_cluster.oidc

}
```

Agora abra o terraform e use a função split() para cortar a url do oidc gerada pelo output configurado

```hcl
terraform console
```

```hcl
> split("/", "https://oidc.eks.us-east-1.amazonaws.com/id/BFD8257863CB12694B306F4C4E96F33B")
tolist([
  "https:",
  "",
  "oidc.eks.us-east-1.amazonaws.com",
  "id",
  "BFD8257863CB12694B306F4C4E96F33B",
])
> split("/", "https://oidc.eks.us-east-1.amazonaws.com/id/BFD8257863CB12694B306F4C4E96F33B")[4]
"BFD8257863CB12694B306F4C4E96F33B"
>  
```

local.tf

```hcl
locals {
  oidc = split("/", var.oidc)[4]
}
```

```hcl
terraform plan
terraform apply -auto-approve
```

## Provider do Kubernetes

O Provider do Kubernetes no Terraform é um plugin que permite gerenciar recursos do Kubernetes através do Terraform. Ele possibilita a criação e gerenciamento de recursos como deployments, services, namespaces e outros objetos do Kubernetes de forma declarativa.

Configuração básica do provider:

```hcl
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
```

Principais características:

- **Integração com diferentes clusters:** Pode ser configurado para trabalhar com qualquer cluster Kubernetes, seja local ou na nuvem
- **Autenticação flexível:** Suporta diferentes métodos de autenticação, incluindo tokens, certificados e kubeconfig
- **Recursos nativos:** Permite gerenciar todos os tipos de recursos nativos do Kubernetes
- **Custom Resources:** Suporte para recursos personalizados (CRDs) do Kubernetes

Exemplo de criação de um namespace:

```hcl
resource "kubernetes_namespace" "example" {
  metadata {
    name = "my-namespace"
  }
}
```

O provider do Kubernetes é especialmente útil quando você precisa:

- Gerenciar infraestrutura e aplicações Kubernetes em um único fluxo de trabalho
- Manter consistência entre diferentes ambientes
- Automatizar o processo de deployment de aplicações
- Integrar com outros recursos gerenciados pelo Terraform

Código usado na aula:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
  backend "s3" {
    bucket = "comunidadedevops-eks-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
    command     = "aws"
  }
}
```

module cluster

```hcl
# Output do cluster

# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.

# Imprimir a configuração da VPC
output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster.vpc_config

}

# output "oidc" {
#   value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
# }

# Imprimir o nome do cluster
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

# Impressão do OIDC
output "oidc" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

# Imprimir o certificado da autoridade
output "certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  
}

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
  
}
```

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
  value = module.eks_network.subnet_pub_1a

}

# Fazendo a chama do output do módulo cluster imprimir a configuração da VPC
output "eks_vpc_config" {
  value = module.eks_cluster.eks_vpc_config

}

# output "oidc" {
#   value = module.eks_cluster.oidc

# }

output "oidc" {
  value = module.eks_cluster.oidc

}

output "ca" {
  value = module.eks_cluster.certificate_authority
  
}

output "endpoint" {
  value = module.eks_cluster.endpoint
  
}
```

## Deploy da Service Account

Vá na documentação do Kubernetes em providers no terraform e pesquise por Service Account

```hcl
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account
```

```hcl
resource "kubernetes_service_account" "eks_controller_sa" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.eks_controller_role.arn
    }
  }
}

```

```hcl
terraform plan
terraform apply -auto-approve
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20134.png)

## Deploy do helm chart

- Segue a documentação para configurar o Helm Providar

https://registry.terraform.io/providers/hashicorp/helm/latest

```hcl
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

helm search repo aws-load-balancer-controller
```

```hcl
resource "aws_iam_policy" "eks_load_balancer_controller" {

  name = "${var.project_name}-aws-load-balancer-controller"

  policy = file("${path.module}/iam_policy.json")
  tags   = var.tags

}
```

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
  backend "s3" {
    bucket = "comunidadedevops-eks-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
      command     = "aws"
    }
  }
}
```

Este bloco de configuração do Terraform define a estrutura básica do projeto com três componentes principais:

### 1. Configuração do Terraform

- Define os provedores necessários (AWS, Kubernetes e Helm) com suas versões específicas
- Configura o backend S3 para armazenar o estado do Terraform remotamente no bucket "comunidadedevops-eks-s3"

### 2. Provider AWS

- Configura o provedor AWS para a região us-east-1

### 3. Provider Kubernetes

- Configura a conexão com o cluster EKS usando:
- Endpoint do cluster
- Certificado de autoridade do cluster
- Token de autenticação obtido via comando AWS CLI

### 4. Provider Helm

- Configura o Helm para interagir com o cluster Kubernetes
- Usa as mesmas configurações de autenticação do provider Kubernetes
- Permite o gerenciamento de releases Helm via Terraform

module network

```hcl
# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.

output "subnet_pub_1a" {
  value = aws_subnet.eks_subnet_public_1a.id

}

output "subnet_pub_1b" {
  value = aws_subnet.eks_subnet_public_1b.id

}

output "subnet_priv_1a" {
  value = aws_subnet.eks_subnet_private_1a.id

}

output "subnet_priv_1b" {
  value = aws_subnet.eks_subnet_private_1b.id

}

output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}
```

```hcl
variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from OIDC provider of the EKS cluster"

}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  
}

variable "vpc_id" {
  type        = string
  description = "EKS cluster name"
}
```

```hcl
resource "helm_release" "eks_helm_controller" {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    version    = "1.11.0"
    namespace  = "kube-system"

    #timeout = 700

    set {
    name  = "clusterName"
    value = var.cluster_name
    }

    set {
    name  = "serviceAccount.create"
    value = "false"
    }

    set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    }
    set {
    name  = "vpcId"
    value = var.vpc_id
    }
}
```

Este recurso do Terraform configura a instalação do AWS Load Balancer Controller usando o Helm:

- **name:** Define o nome da release do Helm como "aws-load-balancer-controller"
- **repository:** Especifica o repositório Helm oficial da AWS para o EKS
- **chart:** Nome do chart Helm a ser instalado
- **version:** Versão específica do chart (1.11.0)
- **namespace:** Instala no namespace kube-system

As configurações do 'set' definem valores importantes:

- **clusterName:** Nome do cluster EKS onde será instalado
- **serviceAccount.create:** Definido como false pois a Service Account já foi criada separadamente
- **serviceAccount.name:** Nome da Service Account existente
- **vpcId:** ID da VPC onde o controller irá operar

```hcl
module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_priv_1a
  subnet_private_1b = module.eks_network.subnet_priv_1b
  tags              = local.tags

}

module "eks_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  project_name = var.project_name
  tags         = local.tags
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
  vpc_id       = module.eks_network.vpc_id 

}
```

```hcl
terraform init
terraform fmt -recursive
terraform plan
terraform apply -auto-approve
```

Tava tendo um problema ao aplicar o helm controller mas achei uma solução para isso.

- O erro era: Context dealine exceeded

```bash
│ Warning: Helm release "aws-load-balancer-controller" was created but has a failed status. Use the `helm` command to investigate the error, correct it, then run Terraform again.

│

│   with module.eks_aws_load_balancer_controller.helm_release.eks_helm_controller,

│   on modules/aws-load-balancer-controller/helm.tf line 1, in resource "helm_release" "eks_helm_controller":

│    1: resource "helm_release" "eks_helm_controller" {

│ Error: context deadline exceeded

│

│   with module.eks_aws_load_balancer_controller.helm_release.eks_helm_controller,

│   on modules/aws-load-balancer-controller/helm.tf line 1, in resource "helm_release" "eks_helm_controller":

│    1: resource "helm_release" "eks_helm_controller" {

│

```

- O script acima já estão corrigidos já, para que não possa ter nenhum equívoco

- Solução:

```hcl
inseri isso no helm.tf:

     set {
        name  = "vpcId"
        value = var.vpc_id
      }

Inseri essa linha no output.tf que está dentro da pasta network:

    output "vpc_id" {
      value = aws_vpc.eks_vpc.id
    }

inseri isso no variables.tf que está dentro da pasta aws-load-balancer-controller

    variable "vpc_id" {
      type        = string
      description = "EKS cluster name"
    }

E no modules.tf que está na raiz do projeto onde tem essa parte:

    module "eks_aws_load_balancer_controller" {
      source       = "./modules/aws-load-balancer-controller"
      project_name = var.project_name
      tags         = local.tags
      oidc         = module.eks_cluster.oidc
      cluster_name = module.eks_cluster.cluster_name
      vpc_id       = module.eks_network.vpc_id 
    }

Inseri a linha :
vpc_id       = module.eks_network.vpc_id

```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20135.png)

## Super módulo

## Instalação do terraform-docs

Link da documentação

https://terraform-docs.io/user-guide/installation/

Depois de instalado, execute o seguinte comando para verfificar se realmente o terraform docs foi instalado

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20136.png)

## Gerando a documentação do módulo e de sub-módulos

Comandos

```bash
# Vai documentar em json
terraform-docs json .

terraform-docs markdown . --output-file README.md 
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20137.png)

## Pre-commit com terraform-docs

```yaml
repos:
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: v1.96.3 # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_fmt
      args:
      - --args=-recursive
    - id: terraform_validate
    - id: terraform_docs
      args:
        - --args=--output-file README.md
```

Toda a alteração que ocorrer, ele irá documentar

## Modularizando o super módulo

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
  

}

provider "aws" {
  # Configuration options
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
      command     = "aws"
    }
  }
}
```

```hcl
variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "region" {
  type        = string
  description = "AWS region to deploy the resources"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to all AWS resources"

}

```

Depois delete o [locals.tf](http://locals.tf) da raiz

## Utilizando o módulo

https://developer.hashicorp.com/terraform/language/modules/sources#github

- Vá no github e pegue a url de seu projeto criado e importe ele como modulo

```hcl
module "eks" {
  source = "git@github.com:Erick-Fernandes-dev/terraform-eks.git?ref=main"
}
```

![image.png](Terraform%201472e2f65d7e80cda081d84211707a20/image%20138.png)

```hcl
locals {
  tags = {
    Department   = "DevOps"
    Organization = "Infrastructure and Operations"
    Project      = "EKS"
    Environment  = "Development"
  }
}
```

```hcl
module "eks" {
  source = "git@github.com:Erick-Fernandes-dev/terraform-eks.git?ref=main"
  cidr_block = "10.0.0.0/16"
  project_name = "demoeks"
  region = "us-east-1"
  tags = local.tags
}
```

```hcl
terraform {
  backend "s3" {
    bucket = "comunidadedevops-eks-s3"
    key    = "qa/terraform.tfstate"
    region = "us-east-1"
  }
}

```

- Vamos baixar esse módulo

```hcl
terraform init
terraform plan
terrafrom fmt -recursive
terraform apply -auto-approve
```