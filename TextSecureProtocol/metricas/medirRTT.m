function writeline(client,pacote);
% Calcula o tempo de ida e volta da mensagem
inicio = tic;

writeline(client,msg);

while client.NumBytesAvailable == 0
    pause(0.01);
end

rtt = toc(inicio);

end