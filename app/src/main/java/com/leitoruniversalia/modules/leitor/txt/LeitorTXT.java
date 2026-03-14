package com.leitoruniversalia.modules.leitor.txt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class LeitorTXT {

    public static String lerArquivo(File arquivo) {

        StringBuilder conteudo = new StringBuilder();

        try {

            BufferedReader reader = new BufferedReader(new FileReader(arquivo));
            String linha;

            while ((linha = reader.readLine()) != null) {
                conteudo.append(linha).append("\n");
            }

            reader.close();

        } catch (Exception e) {
            return "Erro ao ler arquivo.";
        }

        return conteudo.toString();
    }
}
