# TextSecureProtocol (TSP)

Protocolo de Camada de Aplicação Seguro desenvolvido em MATLAB para a disciplina Rede de Computadores I da Universidade do Estado do Rio de Janeiro (UERJ).

O projeto implementa uma arquitetura cliente-servidor sobre TCP com mecanismos de segurança em nível de aplicação, incluindo criptografia AES-128, autenticação HMAC-SHA256, proteção contra ataques de repetição (Replay Attack), coleta de métricas de desempenho e dashboard gráfico desenvolvido no MATLAB App Designer.

📖 Visão Geral

O TextSecureProtocol (TSP) foi desenvolvido com o objetivo de demonstrar a implementação prática de um protocolo de camada de aplicação capaz de fornecer:

Confidencialidade dos dados transmitidos;
Integridade das mensagens;
Autenticidade dos pacotes;
Proteção contra Replay Attacks;
Comunicação confiável utilizando TCP;
Monitoramento de desempenho em tempo real.

O protocolo opera sobre uma conexão TCP cliente-servidor, onde o cliente envia mensagens seguras ao servidor, que as processa e retorna uma resposta.

🏗 Arquitetura
+-------------+
|   Cliente   |
+-------------+
       |
       | TCP
       v
+-------------+
|  Servidor   |
+-------------+

Fluxo de processamento:

Mensagem
   ↓
AES-128
   ↓
HMAC-SHA256
   ↓
Pacote TSP
   ↓
TCP
   ↓
Servidor
   ↓
Validação MAC
   ↓
Validação Timestamp
   ↓
Validação Sequência
   ↓
Descriptografia
   ↓
Processamento
   ↓
Resposta
🔒 Recursos de Segurança
Confidencialidade

Criptografia:

AES-128
Chave compartilhada
Modo ECB
Codificação Base64
Integridade e Autenticidade
HMAC-SHA256
Chave secreta compartilhada
Verificação em todos os pacotes
Proteção contra Replay Attack

Implementada por:

UUID de sessão
Número de sequência crescente
Timestamp Unix
Janela máxima de 30 segundos
📦 Estrutura do Pacote TSP

Cada mensagem segue o formato:

versao|tipo|sessao|seq|timestamp|payload|mac

Exemplo:

1.0|REQ|36bcec4a-93d0-4ef4-...|1|1748820957|SGVsbG8=|a3f2b1...
Campos
Campo	Descrição
versao	Versão do protocolo
tipo	Tipo da mensagem
sessao	UUID da sessão
seq	Número de sequência
timestamp	Horário Unix
payload	Dados criptografados
mac	HMAC-SHA256
🤝 Handshake

Antes da comunicação normal:

Cliente
HELLO
Servidor
WELCOME
📁 Estrutura do Projeto
TextSecureProtocol/
│
├── servidor.m
├── cliente.m
├── app1.mlapp
│
├── protocolo/
│   ├── criptografarMensagem.m
│   ├── descriptografarMensagem.m
│   ├── gerarMAC.m
│   ├── validarMAC.m
│   ├── validarSequencia.m
│   └── criarMensagem.m
│
├── metricas/
│   └── medirRTT.m
│
├── logs/
│   └── servidor.log
│
├── resultadoDesempenho.mat
├── metricas.mat
│
└── README.md
⚙️ Requisitos
Software
MATLAB R2026a ou superior
JVM habilitada
Toolbox Instrument Control
Sistema Operacional
Windows 10/11
Linux
macOS
🚀 Execução
1. Iniciar o Servidor
servidor

Saída esperada:

Servidor iniciado na porta 5000
Aguardando conexões...
2. Executar o Cliente
cliente

Exemplo:

Digite uma mensagem:
Olá servidor

Resposta:

OLÁ SERVIDOR
📊 Dashboard

O projeto inclui um dashboard desenvolvido em MATLAB App Designer.

Funcionalidades
Aba Logs
Visualização do servidor.log
Atualização em tempo real
Aba Métricas
RTT médio
Throughput médio
Quantidade de pacotes
Aba Gráficos
Throughput × Tamanho da Mensagem
RTT × Tamanho da Mensagem
🧪 Testes Realizados
Teste de Desempenho

Foram realizadas:

15 transmissões para cada tamanho
3 tamanhos de payload
Cenários com AES
Cenários sem AES

Total:

90 medições
Tamanhos Testados
Tamanho
256 bytes
1024 bytes
4096 bytes
📈 Resultados com AES
Tamanho	RTT Médio (s)	Throughput Médio (bytes/s)
256	0.035586	7.876
1024	0.037243	28.503
4096	0.045385	96.528
📈 Resultados sem AES
Tamanho	RTT Médio (s)	Throughput Médio (bytes/s)
256	0.043660	6.028
1024	0.040923	27.946
4096	0.048963	85.727
🛡 Teste de Robustez

Foram simulados atrasos artificiais de até:

5 segundos

Resultados:

Tamanho	RTT Médio (s)
256 bytes	0.921
1024 bytes	0.787
4096 bytes	0.777

Resultado observado:

✅ Nenhuma perda de mensagem

✅ Nenhuma falha de sequência

✅ Nenhuma inconsistência de sessão

📚 Referências
Kurose, J.; Ross, K. Redes de Computadores e a Internet.
Stallings, W. Criptografia e Segurança de Redes.
RFC 2104 – HMAC: Keyed-Hashing for Message Authentication.
Documentação MATLAB TCP/IP.
Documentação Java Cryptography Architecture.
👨‍💻 Autores

Gustavo Henrique Souza Moreira Lemos

João Pedro de Lima Fernandes

Universidade do Estado do Rio de Janeiro (UERJ)

Faculdade de Ciências Exatas e Engenharias

Departamento de Computação

Rede de Computadores I – 2026.2

📜 Licença

Projeto desenvolvido exclusivamente para fins acadêmicos na disciplina de Rede de Computadores I da UERJ. Uso educacional permitido mediante atribuição aos autores.
