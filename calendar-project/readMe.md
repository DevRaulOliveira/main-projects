# Calendar Project

![image](https://github.com/user-attachments/assets/73414eaf-081f-4991-86c8-c5d9bf6e547e)

Essse arquivo contem as informações a respeito do projeto de Calendário. A documentação visa incluir também especificações tecnicas e outras informações a respeito do projeto de forma organizada.

## Especificações


O projeto até o momento possui como conteúdo uma planilha do excel em formato CSV. Contendo todas as informações a respeito de todos os feriados do País.
Está em fase de migração para uma tabela em Cloud, utilizando o serviço da AWS RDS, sendo armazenado no PostgreSQL **sem o serviço Aurora** incluso.

## Base de dados

A base de dados da tabela de feriados, poderá possuir **uma dimensão de 7MB** de tamanho, sendo uma tabela leve e podendo ser armazenada utilizando recursos gratuitos.

### Oracle

O banco de dados utlizado para o projeto neste momento foi o **Oracle SQL** estando na versão do **Oracle é a 23.1.1**. Todos os dados da tabela foram padronizados e removidos todo o tipo de acentuação, deixando a estrutura da base de dados mais organizada.
A tabela possui como campos de dados as informações. <br>
-  COD_UF;
-  UF;
-  ESTADO;
-  COD_MUN;
-  MUNICIPIO;
-  FERIADO;
-  TIPO_FERIADO;
-  DATA;

O conteúdo dessa base de dados incluito todos os <b>estados e municipios do Brasil</b>, contendo todos os feriados do ambito **Federal**, **Estadual** e **Municipal**. Além disso como solicitação feita, foi realizada a expansão da tabela até o ano de **2049**.
Anualmente são geradas um total de **87.982** linhas.

## Queries

As queries do projeto Calendar estão salvas na pasta desse repositório [Queries](https://github.com/DevRaulOliveira/CalendarProject/tree/Main/Queries).
