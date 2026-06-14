function valido = validarMAC(texto,macRecebido)
% Compara o MAC recebido com o MAC calculado

macCalculado = gerarMAC(texto);

valido = strcmp(macCalculado,macRecebido);

end