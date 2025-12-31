# Notebook de Gestão de Usuários

## Visão Geral
Este notebook automatiza a criação, atualização e consulta de uma tabela de usuários para governança de dados, integrando informações de auditoria de acesso e atributos de usuários.

- Tabela:
<img width="1860" height="940" alt="image" src="https://github.com/user-attachments/assets/c7c9543d-9824-4562-8f2c-b3c0551ac6ee" />


- Notebook:
<img width="1860" height="940" alt="image" src="https://github.com/user-attachments/assets/ea06d459-6781-45fe-a178-93ca2693e80d" />


- Pipeline:
<img width="1860" height="940" alt="image" src="https://github.com/user-attachments/assets/f7a875f8-f335-4825-bd9e-d4de6a463a32" />


---

## 1. Processo de Desenvolvimento
### Objetivo Técnico
Automatizar a consolidação de dados de usuários a partir de auditorias de acesso e fontes de atributos, mantendo um repositório de usuários atualizado e confiável para governança e análises.

### Fluxo Técnico
- Criação da tabela com chave primária e struct para detalhes do usuário
- Adição de comentários para documentação
- Agregação dos dados de auditoria de acesso para primeiro/último acesso
- Integração de atributos de usuários a partir de CSV
- Junção, estruturação e deduplicação dos dados
- Upsert dos dados usando MERGE
- Consulta final para validação e análise

**Fluxograma passo a passo:**
1. Excluir e criar a tabela `data_governance.users` com o esquema necessário
2. Adicionar comentários à tabela e colunas para clareza
3. Ler atributos de usuários do CSV e criar uma view temporária
4. Agregar dados de auditoria de acesso para cada email
5. Juntar dados de auditoria e atributos, construir o struct user_info
6. Deduplicar registros por email
7. Upsert na tabela principal usando MERGE
8. Consultar a tabela para validação

---

## 2. Manutenção e evolução
### Orientações
* Atualize a fonte CSV ou a tabela de auditoria conforme necessário para novos usuários ou alterações
* Garanta a consistência do esquema e atualize comentários/documentação quando houver mudanças nos campos
* Valide a integração dos dados e a lógica de deduplicação após qualquer atualização
* Monitore a lógica de upsert para evitar perda ou duplicação de dados
* Documente todas as alterações para rastreabilidade

**Fluxograma de Manutenção:**
- Receber dados de usuários novos/atualizados (CSV ou auditoria)
- Validar o esquema e atualizar a documentação
- Integrar e testar o pipeline de dados
- Monitorar o upsert e a deduplicação
- Documentar alterações e resultados

---

## 3. Resultados e percepção de valor
### Valor Estratégico
* Repositório centralizado e confiável de usuários para governança, segurança e auditoria
* Permite rastreamento de acessos, status e atributos organizacionais dos usuários
* Facilita conformidade, relatórios e decisões estratégicas
* Reduz esforço manual e risco de dados inconsistentes

**Fluxograma de Valor de Negócio:**
- Coletar dados de acesso e atributos de usuários
- Automatizar consolidação e validação
- Manter repositório de usuários atualizado
- Permitir análises, relatórios e conformidade
- Apoiar decisões estratégicas com dados confiáveis

---

## Observações Importantes
* Certifique-se de que o caminho do arquivo CSV e a tabela de auditoria estejam acessíveis e atualizados
* Ajuste o esquema e a lógica conforme as necessidades organizacionais evoluírem
* Documente todas as alterações para futuras manutenções e auditorias
