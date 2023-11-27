package utils;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Cryptography {
    public static String convertToMD5(String senha) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(senha.getBytes(StandardCharsets.UTF_8));
        byte[] digest = md.digest();
        return new BigInteger(1, digest).toString(16);
    }

    public static boolean compararSenha(String senha, String senhaGravada) throws NoSuchAlgorithmException {
        String resultado = convertToMD5(senha);
        return resultado.equals(senhaGravada);
    }
}