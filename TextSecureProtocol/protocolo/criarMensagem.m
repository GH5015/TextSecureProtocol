function pacote = criarMensagem(seq,payload)

pacote = sprintf("MSG|%d|%s",seq,payload);

end