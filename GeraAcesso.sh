#!/bin/bash

# Definindo um arquivo HTML para armazenar as mensagens
temp_file="mensagens_ativadores.html"
csv_file="dados_ativadores.csv"

# Criar ou limpar o arquivo HTML
cat <<EOL > "$temp_file"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensagens dos Ativadores</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            margin: 20px;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #007BFF;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .message {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: box-shadow 0.3s ease;
        }
        .message:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .message-content {
            flex-grow: 1;
            margin-right: 20px;
        }
        .name {
            font-size: 18px;
            font-weight: bold;
            color: #007BFF;
        }
        .link {
            margin-top: 5px;
        }
        .link a {
            text-decoration: none;
            color: #28a745;
            font-weight: bold;
        }
        .checkbox {
            display: flex;
            align-items: center;
        }
        .checkbox input {
            margin-right: 10px;
        }
        .message.sent {
            background-color: #d4edda; /* Cor verde suave */
            border-color: #c3e6cb; /* Borda verde */
        }
    </style>
    <script>
        function toggleSent(checkbox) {
            const messageDiv = checkbox.closest('.message');
            if (checkbox.checked) {
                messageDiv.classList.add('sent');
            } else {
                messageDiv.classList.remove('sent');
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Envio de Credenciais SCI - 2024</h1>
EOL

# Criar ou limpar o arquivo CSV com cabeçalho
echo "Nome;Indicativo;Senha" > "$csv_file"

# Função para gerar uma senha aleatória usando termos e sufixo
generate_password() {
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
    caracteres_especiais=('!' '@' '#' '$' '%' '&' '*' '-' '_')

    gerar_sufixo() {
        numeros=$(shuf -i 100-999 -n 1)
        caractere=${caracteres_especiais[$RANDOM % ${#caracteres_especiais[@]}]}
        echo "${numeros}${caractere}"
    }

    escolher_termo_aleatorio() {
        echo "${termos[$RANDOM % ${#termos[@]}]}"
    }

    termo1=$(escolher_termo_aleatorio)
    termo2=$(escolher_termo_aleatorio)
    sufixo=$(gerar_sufixo)
    
    senha="${termo1}${sufixo}${termo2}"
    echo "$senha"
}

# Ler os dados do arquivo CSV atualizado
while IFS=';' read -r email nome indicativo telefone; do
    # Remover espaços do número de telefone
    telefone=$(echo "$telefone" | tr -d ' ')

    # Verificar se o telefone contém apenas dígitos e tem o comprimento correto
    if [[ $telefone =~ ^[0-9]+$ && ${#telefone} -ge 11 ]]; then
        # Garantir que o código do país seja 55 (Brasil)
        telefone="55$telefone"
    fi

    # Gerar uma senha aleatória
    senha=$(generate_password)

    # Mensagem padrão para enviar
    mensagem="Olá $nome - $indicativo!

Aqui é o PP5KJ - Vinícius da ARAF, e estou entrando em contato para repassar os acessos ao sistema do *Santa Catarina Integrada 2024*.

Suas informações de acesso são as seguintes:

- *Nome de Usuário:* $indicativo
- *Senha:* $senha

Os links para acesso ao sistema são:

- *Estatísticas do evento:* http://aws1.flyweb.com.br/sci/sciestatisticas.aspx
- *Emissão do diploma:* http://aws1.flyweb.com.br/sci/scimeudiploma.aspx
- *Logbook Online:* http://aws1.flyweb.com.br/sci/login.aspx

Por favor, mantenha suas credenciais seguras e entre em contato pelo Grupo *Ativadores SCI 2024* caso precise de assistência.

*Maiores Informações em:*
https://araf.org.br/santa-catarina-integrada-regulamento-2024


*O Básico da Operação SCI - CQ*: 
https://drive.google.com/file/d/13EBrDRoXTHMKAkUuWGoAFPe3qv_y7crn/view

*Padronizando o QRZ*
https://youtu.be/_wzg0Q-huOI

/* Código para QRZ */
<iframe height="3200px" src="https://www.araf.org.br/sci-qrz" width="100%"></iframe>

*Como acessar e usar o Sistema para envio do LOG*
https://youtu.be/xqEIOIwmYuA

73, PP5KJ"

    # Codificar a mensagem para URL
    mensagem_encoded=$(echo "$mensagem" | jq -sRr @uri)

    # Gerar link do WhatsApp corretamente com o telefone no formato esperado
    link_whatsapp="https://api.whatsapp.com/send?phone=$telefone&text=$mensagem_encoded"

    # Adicionar a mensagem e link ao arquivo HTML com a caixa de seleção
    cat <<EOL >> "$temp_file"
    <div class="message">
        <div class="message-content">
            <span class="name">$nome ($indicativo)</span>
            <div class="link"><a href="$link_whatsapp" target="_blank">Clique aqui para enviar a mensagem pelo WhatsApp</a></div>
        </div>
        <div class="checkbox">
            <input type="checkbox" id="enviado_$indicativo" onclick="toggleSent(this)">
            <label for="enviado_$indicativo">Mensagem Enviada</label>
        </div>
    </div>
EOL

    # Salvar nome, indicativo e senha no arquivo CSV
    echo "$nome;$indicativo;$senha" >> "$csv_file"

done < <(tail -n +2 ativadores.csv) # Ignorar cabeçalho

# Encerrar o arquivo HTML
cat <<EOL >> "$temp_file"
    </div>
    Made By: PP5KJ - Vinicius Macedo
</body>
</html>
EOL

# Exibir o resultado
echo "Arquivo HTML gerado: $temp_file"
echo "Arquivo CSV gerado: $csv_file"
