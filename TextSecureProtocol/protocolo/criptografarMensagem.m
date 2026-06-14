function textoCripto = criptografarMensagem(texto)

% Função responsável por criptografar a mensagem utilizando AES

import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

if isstring(texto)
    texto = char(texto);
end

chave = uint8('AESKey1234567890');

keySpec = SecretKeySpec(chave,'AES');
% Inicializa algoritmo AES

cipher = Cipher.getInstance('AES');

cipher.init(Cipher.ENCRYPT_MODE,keySpec);

dados = unicode2native(texto,'UTF-8');

dadosCripto = cipher.doFinal(dados);

textoCripto = matlab.net.base64encode(typecast(dadosCripto,'uint8'));

end