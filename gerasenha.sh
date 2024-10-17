#!/bin/bash

# Lista de termos de radioamadorismo
termos=(
        "Acoplador" "AM" "Analisador" "Yagi" "APRS" "Balun" "PX" 
        "Banda" "BandaLateral" "Bandas" "Bateria" "Beacon" "Cargafantasma" "Cabocoaxial" 
        "Chaveador" "Contest" "Contestador" "Coaxial" "Dipolo" "DMR" "D-Star" "DX" "DXpedition" 
        "Echolink" "emergencia" "Estacao_movel" "Filtrodecavidade" 
        "Frequencia" "FT4" "FT8" "Heterodino" "Indicativo" 
        "Interferencia" "Intermodulacao" "Logbook" "logperiodica" "LoopAntenna" "Mododigital" 
        "multibanda" "Noiseblanker" "notch" "OM" "Oscilador" "PL-259" "Planoterra" "Polarizacao" 
        "Propagacao" "PTT" "QRM" "QRN" "QRP" "QRP" "QSL" "QSO" "QSY" "QTH" "Radiobaliza" "Radiobase" 
        "Radioescuta" "Receptor" "Repetidora" "RFI" "RPT" "RTTY" "SSB" "SWR" 
        "SantaCatarina" "telegrafia" "Tropoducto" "UHF" "VHF" "vox" "YL" "ENCARA" "ARAF" "LABRE" "Yaesu" "Icom" "Kenwood" "Baofeng"
    )

# Lista de caracteres especiais
caracteres_especiais=('!' '@' '#' '$' '%' '&' '*' '-' '_')

# Função para gerar três números aleatórios e um caractere especial aleatório
gerar_sufixo() {
    numeros=$(shuf -i 100-999 -n 1) # Gera um número aleatório entre 100 e 999
    caractere=${caracteres_especiais[$RANDOM % ${#caracteres_especiais[@]}]} # Seleciona um caractere especial
    echo "${numeros}${caractere}"
}

# Função para selecionar um termo aleatório da lista
escolher_termo_aleatorio() {
    echo "${termos[$RANDOM % ${#termos[@]}]}"
}

# Gerar senha no formato Termo + Número_CaractereEspecial + Termo
termo1=$(escolher_termo_aleatorio)
termo2=$(escolher_termo_aleatorio)
sufixo=$(gerar_sufixo)

# Exibir a senha gerada
senha="${termo1}${sufixo}${termo2}"
echo "Senha gerada: $senha"
