# Leitor de Arquivos PDF

## Visão Geral
Este notebook automatiza a extração de dados de arquivos PDF, convertendo informações específicas em tabelas estruturadas para análise, integração e automação de processos em ambientes Databricks.

---

- Arquivo PDF:

<img width="1337" height="1045" alt="image" src="https://github.com/user-attachments/assets/37c033da-dacf-4e1c-9b55-5e23b0ba005b" />

---
- Dados:

<img width="1867" height="973" alt="image" src="https://github.com/user-attachments/assets/d804cce3-f8d3-42d8-93ff-89b401bec367" />
---

## 1. Processo de desenvolvimento
### Objetivo Técnico
Automatizar a extração de dados de PDFs padronizados usando vetores de coordenadas e a biblioteca `pdfplumber`, gerando DataFrames prontos para análise, integração ou exportação.

### Fluxograma Técnico
```mermaid
graph TD;
    A[Instalação da biblioteca] --> B[Reinicialização do cluster];
    B --> C[Definição dos vetores];
    C --> D[Mapeamento das colunas];
    D --> E[Extração dos dados];
    E --> F[Montagem do DataFrame];
    F --> G[Validação dos resultados];
```

### Pontos Críticos
* Vetores devem ser ajustados conforme layout do PDF.
* Colunas precisam corresponder à ordem dos vetores.
* Testes e validação são essenciais para garantir precisão.

---

## 2. Manutenção e Evolução da utilização
### Orientações
* Atualize vetores e nomes das colunas se o layout dos PDFs mudar.
* Teste a extração com diferentes arquivos para garantir consistência.
* Documente todas as alterações para rastreabilidade.
* Adapte o tratamento de exceções conforme cenários específicos.

### Fluxograma de Manutenção
```mermaid
graph TD;
    H[Recepção de novo layout] --> I[Teste de extração];
    I --> J[Ajuste de vetores/colunas];
    J --> K[Validação dos dados];
    K --> L[Documentação das alterações];
```

### Expansão
O notebook pode ser expandido para múltiplas páginas ou diferentes tipos de documentos, bastando adaptar a lógica de extração.

---

## 3. Resultados e valor
### Benefícios Estratégicos
* Agilidade na análise e integração dos dados operacionais.
* Melhoria da rastreabilidade e governança dos processos.
* Facilidade para gerar relatórios estratégicos e insights.
* Redução de custos e mitigação de riscos operacionais.

### Fluxograma de Valor
```mermaid
graph TD;
    M[Recepção dos PDFs] --> N[Processamento automatizado];
    N --> O[Extração dos dados relevantes];
    O --> P[Validação dos resultados];
    P --> Q[Entrega dos dados estruturados];
    Q --> R[Disponibilização para análise/decisão];
```

### Impacto no Negócio
* Decisões gerenciais em tempo real.
* Padronização do processo de obtenção de dados.
* Escalabilidade para diferentes documentos e áreas de negócio.
* Alinhamento entre TI e áreas estratégicas, acelerando a transformação digital.

---

## Observações Importantes
* Certifique-se de que o caminho do arquivo PDF está correto e acessível no ambiente.
* Ajuste as áreas de extração conforme a estrutura do documento PDF analisado.
* Documente todas as alterações realizadas para garantir rastreabilidade e facilitar futuras adaptações.
