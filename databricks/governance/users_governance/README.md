<a id="topo"></a>

# User Management Notebook

**🌐 Idioma / Language:** [Português](#pt) | [English](#en)

<img width="1860" alt="Notebook de gestão de usuários / User management notebook" src="https://github.com/user-attachments/assets/ea06d459-6781-45fe-a178-93ca2693e80d" />

---

<a id="pt"></a>

## 🇧🇷 Português


### 📌 Sobre o projeto

O **User Management Notebook** automatiza a criação, a atualização e a consulta de uma tabela de usuários para governança de dados.

O objetivo é consolidar informações de auditoria de acesso e atributos de usuários em um repositório atualizado e confiável para governança e análises.


### 🗂️ Fonte de dados

- **Origem:** tabela de auditoria de acesso e arquivo CSV.
- **Conteúdo:** acessos por e-mail e atributos dos usuários.
- **Observação:** o caminho do CSV e a tabela de auditoria devem estar acessíveis e atualizados.


### ⚙️ Desenvolvimento

1. **Estrutura:** exclusão e criação da tabela `data_governance.users`, com chave primária, struct e comentários.
2. **Conexão:** leitura dos atributos do CSV em uma view temporária e uso da auditoria de acesso.
3. **Tratamento:** primeiro e último acesso por e-mail, junção dos dados, struct `user_info` e deduplicação.
4. **Carga:** upsert na tabela principal com `MERGE`.
5. **Validação:** consulta da tabela para validação e análise.

**Tabela**

<img width="1860" alt="Tabela de usuários" src="https://github.com/user-attachments/assets/a9519cca-e345-4a3b-be9b-b25ba3f82033" />

**Pipeline**

<img width="1860" alt="Pipeline do projeto" src="https://github.com/user-attachments/assets/f7a875f8-f335-4825-bd9e-d4de6a463a32" />


### 🔀 Fluxo do projeto

```mermaid
flowchart TD
    T["Criação da tabela<br/>Esquema e comentários"] --> H[("data_governance.users")]
    A[("Auditoria de acesso")] --> C["Agregação<br/>Primeiro e último acesso"]
    B[("Arquivo CSV")] --> D["View temporária<br/>Atributos dos usuários"]
    C --> E["Junção<br/>Struct user_info"]
    D --> E
    E --> F["Deduplicação<br/>Por e-mail"]
    F --> G["Upsert<br/>MERGE"]
    G --> H
    H --> I(["Consulta<br/>Validação e análise"])
```


### ✨ Funcionalidades

- Criação e documentação da tabela de usuários
- Cálculo do primeiro e do último acesso
- Integração de atributos a partir de CSV
- Deduplicação por e-mail
- Upsert com `MERGE`


### 💼 Valor gerado e ganhos de negócio

O projeto reúne auditoria de acesso e atributos em uma única tabela, para apoiar a governança de dados. A solução pode gerar:

| Valor gerado | Ganho de negócio potencial |
|---|---|
| Repositório centralizado de usuários | Apoio à governança, segurança e auditoria |
| Registro de acessos, status e atributos | Rastreabilidade dos usuários |
| Dados consolidados | Apoio à conformidade, aos relatórios e às decisões |
| Consolidação automatizada | Menos esforço manual |
| Deduplicação e upsert | Menor risco de dados inconsistentes |

> **Nota:** os ganhos são potenciais e não foram medidos.


### 🛠️ Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| Notebook | Lógica de consolidação |
| Pipeline | Pipeline de dados do projeto |
| CSV | Atributos dos usuários |
| `MERGE` | Upsert na tabela principal |

[⬆️ Voltar ao topo](#topo)


---


<a id="en"></a>

## 🇺🇸 English


### 📌 About the project

**User Management Notebook** automates how a user table is created, updated and queried for data governance.

Its goal is to consolidate access audit data and user attributes into an up-to-date, reliable repository for governance and analytics.


### 🗂️ Data source

- **Origin:** access audit table and CSV file.
- **Content:** accesses by email and user attributes.
- **Note:** the CSV path and the audit table must be accessible and up to date.


### ⚙️ Development

1. **Structure:** drop and create the `data_governance.users` table, with a primary key, a struct and comments.
2. **Connection:** read CSV attributes into a temporary view and use the access audit data.
3. **Preparation:** first and last access per email, data join, `user_info` struct and deduplication.
4. **Load:** upsert into the main table with `MERGE`.
5. **Validation:** query the table for validation and analysis.

**Table**

<img width="1860" alt="User table" src="https://github.com/user-attachments/assets/ab877c1f-2d91-43a0-b16e-d1469dc7837c" />

**Pipeline**

<img width="1860" alt="Project pipeline" src="https://github.com/user-attachments/assets/f7a875f8-f335-4825-bd9e-d4de6a463a32" />


### 🔀 Project flow

```mermaid
flowchart TD
    T["Table creation<br/>Schema and comments"] --> H[("data_governance.users")]
    A[("Access audit")] --> C["Aggregation<br/>First and last access"]
    B[("CSV file")] --> D["Temporary view<br/>User attributes"]
    C --> E["Join<br/>user_info struct"]
    D --> E
    E --> F["Deduplication<br/>By email"]
    F --> G["Upsert<br/>MERGE"]
    G --> H
    H --> I(["Query<br/>Validation and analysis"])
```


### ✨ Features

- User table creation and documentation
- First and last access calculation
- Attribute integration from CSV
- Deduplication by email
- Upsert with `MERGE`


### 💼 Value delivered and business gains

The project brings access audit data and attributes into a single table to support data governance. The solution can deliver:

| Value delivered | Potential business gain |
|---|---|
| Centralized user repository | Support for governance, security and audit |
| Record of access, status and attributes | User traceability |
| Consolidated data | Support for compliance, reporting and decisions |
| Automated consolidation | Less manual effort |
| Deduplication and upsert | Lower risk of inconsistent data |

> **Note:** these gains are potential and have not been measured.


### 🛠️ Technologies used

| Technology | Purpose |
|---|---|
| Notebook | Consolidation logic |
| Pipeline | Project data pipeline |
| CSV | User attributes |
| `MERGE` | Upsert into the main table |

[⬆️ Back to top](#topo)
