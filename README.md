# SCI-Whatsapp-Sender

Este script Bash gera um arquivo HTML e um arquivo CSV para enviar mensagens de WhatsApp com credenciais de acesso para o evento Santa Catarina Integrada 2024.

## Arquivos Gerados

- \`mensagens_ativadores.html\`: Contém as mensagens formatadas e links para envio via WhatsApp.
- \`dados_ativadores.csv\`: Contém os nomes, indicativos e senhas geradas.

## Como Usar

1. Certifique-se de que o arquivo \`ativadores.csv\` está no mesmo diretório que o script. Este arquivo deve conter os dados dos ativadores no seguinte formato (com cabeçalho):

    \`\`\`
    email;nome;indicativo;telefone
    \`\`\`

2. Execute o script:

    \`\`\`
    ./GeraAcesso.sh
    \`\`\`

3. O script irá gerar os arquivos \`mensagens_ativadores.html\` e \`dados_ativadores.csv\` no mesmo diretório.

## Estrutura do HTML

- Cada mensagem é exibida em um bloco com o nome e indicativo do ativador.
- Há um link para enviar a mensagem via WhatsApp.
- Cada mensagem possui uma caixa de seleção para marcar se a mensagem foi enviada.

## Personalização

- Você pode personalizar a mensagem alterando a variável \`mensagem\` no script.
- A função \`generate_password\` gera senhas aleatórias usando termos relacionados ao evento e caracteres especiais.

## Dependências

- \`jq\`: Utilizado para codificar a mensagem para URL.

## Autor

- PP5KJ - Vinicius Macedo
EOL

echo "Arquivo README.md gerado: $readme_file"