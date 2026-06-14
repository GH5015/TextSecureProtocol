clear
clc

addpath('protocolo')

% Conecta ao servidor
client = tcpclient("127.0.0.1",5000);

client.Timeout = 15;

disp("Conectado ao servidor")

% Handshake
writeline(client,"HELLO");

resp = readline(client);

fprintf("Servidor: %s\n",char(resp));

% Informações da sessão
versao = "1.0";
sessao = char(java.util.UUID.randomUUID());

seq = 1;

% Tamanhos exigidos pelo trabalho
tamanhos = [256 1024 4096];

% Matriz de resultados
resultado = [];

for t = tamanhos

    fprintf("\n====================================\n");
    fprintf("TESTANDO %d BYTES\n",t);
    fprintf("====================================\n");

    rttHistorico = zeros(1,15);
    tpHistorico = zeros(1,15);

    for i = 1:15

        % Gera mensagem do tamanho desejado
        msg = repmat('A',1,t);

        % Criptografia AES
        payloadCripto = criptografarMensagem(msg);

        % Timestamp atual
        timestamp = string(posixtime(datetime('now')));

        % Dados protegidos pelo HMAC
        dadosMAC = sprintf('%s|REQ|%s|%d|%s|%s',...
            versao,...
            sessao,...
            seq,...
            timestamp,...
            payloadCripto);

        % Gera HMAC
        mac = gerarMAC(dadosMAC);

        % Monta pacote completo
        pacote = sprintf('%s|REQ|%s|%d|%s|%s|%s',...
            versao,...
            sessao,...
            seq,...
            timestamp,...
            payloadCripto,...
            mac);

        % Inicia medição RTT
        inicio = tic;

        % Envia pacote
        writeline(client,pacote);

        % Aguarda resposta
        resposta = readline(client);

        % RTT
        rtt = toc(inicio);

        % Throughput
        throughput = length(msg)/rtt;

        % Armazena histórico
        rttHistorico(i) = rtt;
        tpHistorico(i) = throughput;

        fprintf("Teste %02d -> RTT: %.6f s | TP: %.2f bytes/s\n",...
            i,...
            rtt,...
            throughput);

        seq = seq + 1;

    end

    % Médias
    rttMedio = mean(rttHistorico);
    tpMedio = mean(tpHistorico);

    fprintf("\nRESULTADO %d BYTES\n",t);
    fprintf("RTT Médio: %.6f s\n",rttMedio);
    fprintf("Throughput Médio: %.2f bytes/s\n",tpMedio);

    resultado = [resultado;
        t rttMedio tpMedio];

end

disp(" ")
disp("========== RESULTADOS FINAIS ==========")

T = array2table(resultado,...
    'VariableNames',{'TamanhoBytes','RTT_Medio','Throughput_Medio'});

disp(T)

save('resultadoDesempenho.mat','resultado')

clear client