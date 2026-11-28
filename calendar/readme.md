<h1> Calendar</h1>
<p>
  O objetivo desse projeto é realizar a extração dos dados de estado do site do IBGE VIA API e inserir esses dados em tabelas em bancos de dados para serem utilizados para analise de dados, desta forma estando consultando diretamente a origem das informações como referencia para o banco de dados, mitigando a existencia de registros manuais de dados por parte dos usuários.
</p>

<h2>Fonte de dados</h2>
<p>
  O site do <b> IBGE </b> conta com 2 APIs que armazenam e disponibilizam essas informações para consultas publicas, sendo elas as seguintes:
</p>
  <li>Fonte de informações por UF brasileira: https://servicodados.ibge.gov.br/api/v1/localidades/estados  </li>
  <li>Fonte de informações por Munícipio: https://servicodados.ibge.gov.br/api/v1/localidades/municipios  </li>

  <h3> Objetivo  </h3>
<p>
  O objetivo inicial é realizar a tabulação desses dados para consultas em multiplos contextos, além de realizar a implantação de metodos de segurança de dados de forma a possuir proteções para cenários de falhas. Além disso os dados terão um fluxo bem definido e com baixa latência de consumo. (a definir)
</p>
