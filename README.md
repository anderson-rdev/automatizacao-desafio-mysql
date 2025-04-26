# automatizacao-desafio-mysql
 📈 Sistema de Avaliação e Bonificação de Funcionários

Este projeto tem como objetivo automatizar a avaliação periódica de funcionários com base em tempo de serviço, assiduidade e regras corporativas de bonificação salarial.

 📋 Regras de Bonificação

A cada 5 anos, os funcionários passam por uma avaliação. Se aprovados, recebem um aumento de 1,5% no salário mensal e avançam para o próximo grau. O valor máximo de bonificação acumulada é de 7,5%.

| Grau | Tempo de Serviço | Percentual |
|------|------------------|------------|
| A    | 5 anos           | 0%         |
| B    | 10 anos          | 1,5%       |
| C    | 15 anos          | 3,0%       |
| D    | 20 anos          | 4,5%       |
| E    | 25 anos          | 6,0%       |
| F    | 30 anos          | 7,5%       |

 📌 Regras de Avaliação
 
- O funcionário não pode ter mais de 90 dias ausentes no período de 5 anos (faltas e licenças médicas).
- Licenças maternidade prorrogam o período avaliativo.
- Se reprovado, o funcionário mantém o mesmo grau até a próxima avaliação.

---

 ⚙️ Funcionalidades

- 📊 Visualização de Funcionários Ativos e Inativos  
  View que exibe estatísticas atualizadas do quadro de pessoal.

- 🏷️ Regras de Progressão no Banco  
  Estrutura de tabelas e relacionamentos para armazenar critérios de progressão.

- 📅 Grau Atual e Próximo Avaliativo  
  Informações atualizadas por funcionário no momento da implantação.

- 💰 Cálculo de Bônus e Novo Salário  
  View detalhada com nome, cargo, salário base, grau, bônus e novo salário.

- 📉 Impacto na Folha de Pagamento  
  Comparativo de valores totais com e sem bonificações aplicadas.

- 🧾 Consulta por Ciclo Avaliativo  
  Procedure que retorna os funcionários a serem avaliados em determinado mês/ano.

- 🤖 Avaliação Automática  
  Procedure que realiza as avaliações automaticamente, armazena histórico e atualiza dados futuros.

- 👶 Tratamento de Licença Maternidade  
  Trigger para prorrogação automática do período avaliativo conforme a duração da licença.

---
 🗂️ Estrutura Técnica

- Banco de Dados Relacional (Mysql)
- Procedures e Triggers
- Views para análise e relatórios
- Modelagem de dados orientada à regra de negócio

---
 📌 Como usar
1. Clone este repositório
2. Importe o script SQL no seu banco de dados
3. Execute as views e procedures conforme o manual de uso

---
👨‍💻 Autor
Anderson Ramos  
Desenvolvedor de sistemas com foco em soluções automatizadas, dados e eficiência operacional.
