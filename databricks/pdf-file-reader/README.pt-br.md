
# Leitor de Arquivos PDF [PT-BR]

## Objetivo
Este notebook foi desenvolvido para automatizar a extração de dados de arquivos PDF, convertendo informações específicas em tabelas estruturadas para análise, integração e automação de processos em ambientes Databricks.

## Requisitos
* **Biblioteca Necessária:** pdfplumber
  - Instale com: `pip install pdfplumber`
  - Reinicie o cluster após a instalação para garantir o funcionamento.
* **Ambiente:** Databricks com suporte a Python (Serverless ou Clusters Interativos)

## Funcionamento e Regras Fundamentais
* **Vetores de Extração:**
  - A conversão dos dados em tabela depende exclusivamente dos vetores definidos (`vetores`), que representam as áreas de interesse no layout do PDF.
  - Cada vetor corresponde a uma posição (coordenadas x0, top, x1, bottom) onde a informação desejada está localizada.
  - **Regra Fundamental:** Todos os arquivos PDF processados devem possuir as palavras localizadas nos mesmos vetores e o mesmo comprimento de informações. PDFs com layouts diferentes ou campos em posições distintas podem gerar resultados inconsistentes ou incompletos.
* **Mapeamento de Colunas:**
  - Os nomes das colunas da tabela resultante devem corresponder à ordem e quantidade dos vetores definidos.
  - O código associa cada vetor a uma coluna específica, garantindo que os dados extraídos sejam organizados corretamente.
* **Definição de Coordenadas:**
  - As coordenadas devem ser ajustadas conforme o contexto desejado:
    - `x0`: coordenada inicial no eixo X
    - `top`: coordenada inicial no eixo Y
    - `x1`: coordenada final no eixo X
    - `bottom`: coordenada final no eixo Y
  - Recomenda-se ajustar as coordenadas iniciais e finais (subtraindo/adicionando 2 a 5 unidades) para garantir que nenhum caractere seja excluído.

## Etapas do Processo
1. Instale e configure a biblioteca `pdfplumber`.
2. Defina os vetores de extração conforme o layout do PDF.
3. Liste os arquivos PDF a serem processados.
4. Para cada arquivo, extraia os textos das áreas especificadas e monte um dicionário com os dados.
5. Converta a lista de dicionários em um DataFrame para análise e visualização.

## Exemplos de Uso
* Extração de palavras e textos de áreas específicas do PDF usando `pdfplumber` e vetores definidos.
* Impressão dos resultados para validação dos dados extraídos.
* Conversão dos dados extraídos em DataFrame para visualização e análise.

## Orientações para Manutenção e Adaptação
* **Adaptação para Novos Layouts:**
  - Se o layout dos PDFs mudar, atualize os vetores e os nomes das colunas para refletir as novas posições das informações.
  - Teste a extração com diferentes arquivos para garantir consistência.
* **Validação dos Dados:**
  - Sempre verifique se o número de vetores e colunas corresponde ao conteúdo dos PDFs.
  - Imprima os dados extraídos para validar a precisão antes de análises avançadas.
* **Tratamento de Erros:**
  - O código inclui verificações para garantir que os arquivos existam e que as áreas de extração estejam corretas.
  - Adapte o tratamento de exceções conforme necessário para cenários específicos.
* **Padronização dos PDFs:**
  - O sucesso da extração depende da padronização dos PDFs. Arquivos com variações de layout exigem ajustes nos vetores e na lógica de extração.
  - Recomenda-se documentar cada alteração nos vetores e colunas para facilitar futuras manutenções.
* **Expansão do Notebook:**
  - Este notebook pode ser expandido para processar múltiplas páginas ou diferentes tipos de documentos, bastando adaptar a lógica de extração.

## Observações Importantes
* Certifique-se de que o caminho do arquivo PDF está correto e acessível no ambiente.
* Ajuste as áreas de extração conforme a estrutura do documento PDF analisado.
* A abordagem pode ser adaptada para diferentes layouts de documentos, bastando modificar as coordenadas e áreas de interesse.
* Documente todas as alterações realizadas para garantir rastreabilidade e facilitar futuras adaptações.

## Resultados

- Arquivo PDF:

<img width="1337" height="1045" alt="image" src="https://github.com/user-attachments/assets/e00fc5c8-5171-4fa9-ac94-ded846213fe9" />


- Tabela com os dados:

<img width="1867" height="973" alt="image" src="https://github.com/user-attachments/assets/b362b986-b946-4bf9-abeb-085094a4e564" />

---

Esta documentação consolidada foi revisada para garantir máxima clareza, riqueza de detalhes e facilidade de manutenção. Siga as orientações para adaptar o notebook conforme suas necessidades e garantir resultados confiáveis.
