clear
clc

% Adiciona funções do protocolo
addpath('protocolo')

% Cria conexão TCP com o servidor
client = tcpclient("127.0.0.1",5000);

% Define timeout de comunicação
client.Timeout = 10;

disp("Conectado ao servidor")

% Inicia handshake
writeline(client,"HELLO");

resp = readline(client);

fprintf("Servidor: %s\n",char(resp));

% Informações da sessão
versao = "1.0";

% Identificador único da sessão
sessao = char(java.util.UUID.randomUUID());

% Primeiro número de sequência
seq = 1;

% Vetores para armazenamento das métricas
rttHistorico = [];
tpHistorico = [];

while true

% Entrada de mensagem
msg = input("Mensagem (sair para encerrar): ","s");

% Encerramento da sessão
if strcmpi(msg,"sair")

    writeline(client,"BYE");

    break

end

% Criptografa mensagem usando AES
payloadCripto = criptografarMensagem(msg);

% Simulação de corrupção de mensagem
if rand < 0.05

    payloadCripto = [payloadCripto 'X'];

    fprintf("Corrupção simulada\n");

end

% Timestamp Unix atual
timestamp = string(posixtime(datetime('now')));

% Dados utilizados para geração do HMAC
dadosMAC = sprintf('%s|REQ|%s|%d|%s|%s',...
    versao,...
    sessao,...
    seq,...
    timestamp,...
    payloadCripto);

% Geração do HMAC-SHA256
mac = gerarMAC(dadosMAC);

% Montagem do pacote
pacote = sprintf('%s|REQ|%s|%d|%s|%s|%s',...
    versao,...
    sessao,...
    seq,...
    timestamp,...
    payloadCripto,...
    mac);

% Início da medição RTT
inicio = tic;

% Envio do pacote
writeline(client,pacote);

% Recebe resposta
resposta = readline(client);

% RTT calculado
rtt = toc(inicio);

% Throughput simples
throughput = strlength(msg)/rtt;

% Armazena histórico de RTT
rttHistorico(end+1) = rtt;

% Armazena histórico de throughput
tpHistorico(end+1) = throughput;

% Salva métricas para uso no dashboard
save('metricas.mat',...
    'rttHistorico',...
    'tpHistorico');

fprintf("Resposta: %s\n",char(resposta));
fprintf("RTT: %.6f s\n",rtt);
fprintf("Throughput: %.2f bytes/s\n\n",throughput);

% Incrementa número de sequência
seq = seq + 1;

end

clear client
