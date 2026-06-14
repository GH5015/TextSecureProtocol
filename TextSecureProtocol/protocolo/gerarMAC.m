function mac = gerarMAC(texto)

% Gera código HMAC-SHA256 para garantir integridade dos dados


import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

if isstring(texto)
    texto = char(texto);
end

chave = 'TextSecureKey2026';

keySpec = SecretKeySpec(uint8(chave),'HmacSHA256');

macObj = Mac.getInstance('HmacSHA256');

macObj.init(keySpec);

hashBytes = macObj.doFinal(int8(texto));

hashUint8 = typecast(hashBytes,'uint8');

mac = lower(reshape(dec2hex(hashUint8)',1,[]));

end