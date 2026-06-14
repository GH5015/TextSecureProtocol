function texto = descriptografarMensagem(textoCripto)
% Função responsável por descriptografar mensagens AES recebidas

import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

if isstring(textoCripto)
    textoCripto = char(textoCripto);
end

chave = uint8('AESKey1234567890');

keySpec = SecretKeySpec(chave,'AES');

cipher = Cipher.getInstance('AES');

cipher.init(Cipher.DECRYPT_MODE,keySpec);

bytesCripto = matlab.net.base64decode(textoCripto);

dados = cipher.doFinal(bytesCripto);

texto = reshape(char(native2unicode(typecast(dados,'uint8'),'UTF-8')),1,[]);
end