#!/bin/bash

# URL do endpoint do Web Service
URL="http://aws1.flyweb.com.br/SCI/awsadduser.aspx"

# --- DADOS DO USUÁRIO A SER CRIADO ---
# Altere os valores abaixo conforme necessário
CALL_ID="PP5ARF"  # ID do usuário (pode ser seu indicativo, por exemplo)
NOME="ARAF - Associação de Radioamadores de Florianópolis"
SENHA="uma-senha-super-segura"
CIDADE_ID="3" # Exemplo: ID IBGE de Florianópolis

# Monta o corpo da requisição SOAP (XML) usando um "Here Document"
# As variáveis do shell ($CALL_ID, $NOME, etc.) são substituídas pelos seus valores
SOAP_REQUEST="<?xml version=\"1.0\" encoding=\"utf-8\"?>
<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
  <soap:Body>
    <wsAddUser.Execute xmlns=\"SCI\">
      <Callid>${CALL_ID}</Callid>
      <Callnome>${NOME}</Callnome>
      <Callsenha>${SENHA}</Callsenha>
      <Cidadeid>${CIDADE_ID}</Cidadeid>
    </wsAddUser.Execute>
  </soap:Body>
</soap:Envelope>"

# Executa a chamada para a API usando o curl
# -s: Modo silencioso (não mostra a barra de progresso)
# -X POST: Especifica o método de requisição POST
# -H: Adiciona os cabeçalhos HTTP necessários para a requisição SOAP
# -d: Envia os dados (o nosso XML) no corpo da requisição
curl -s -X POST "${URL}" \
-H "Content-Type: text/xml; charset=utf-8" \
-H "SOAPAction: SCIaction/AWSADDUSER.Execute" \
-d "${SOAP_REQUEST}"