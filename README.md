# 📌 Desafio Final do Workshop 2026.1 – Fábrica de Software

Este repositório contém a resolução do **Desafio Final do Workshop 2026.1 – Fábrica de Software**.  
O objetivo do desafio foi aplicar na prática conceitos de modelagem de banco de dados, SQL, análise de dados com Python, Machine Learning e criação de dashboards no Power BI, simulando um projeto real de desenvolvimento de software.

---

## 🎯 Objetivo do Projeto

Desenvolver um sistema completo passando por todas as etapas de construção de um projeto de dados, desde a modelagem até a análise final.

O cenário proposto foi o desenvolvimento de um sistema para uma concessionária fictícia chamada **VelozCar**, que necessita informatizar o controle de aluguel de veículos, clientes, pagamentos e manutenções.

O projeto foi dividido em etapas, cada uma utilizando uma tecnologia diferente.

---

## 🧩 Etapa 1 — Modelagem de Dados

Foi desenvolvido o modelo conceitual (E-R) e o modelo lógico do sistema.

Requisitos da modelagem:

- Mínimo de 6 entidades
- Cada entidade com pelo menos 8 atributos
- Definição de chaves primárias (PK)
- Definição de chaves estrangeiras (FK)
- Definição de cardinalidades
- Resolução de relacionamentos N:N com tabela associativa
- Conversão para modelo lógico com tipos de dados

Entidades utilizadas:

- Cliente  
- Funcionário  
- Veículo  
- Aluguel  
- Pagamento  
- Manutenção  

---

## 🗄️ Etapa 2 — SQL

Após a modelagem, foi criado o banco de dados no MySQL.

Nesta etapa foram realizados:

- Criação do schema
- Criação das tabelas
- Definição de PK e FK
- Definição de restrições (NOT NULL, UNIQUE, etc.)
- Inserção de dados (INSERT)
- Atualizações (UPDATE)
- Consultas com funções de agregação
- Consultas com JOIN entre tabelas

Também foi criado um documento com a interpretação das consultas e os insights obtidos.

---

## 🐍 Etapa 3 — Python / Análise de Dados / Machine Learning

Foi utilizada uma base de dados para realizar análise com Python.

Bibliotecas utilizadas:

- pandas
- numpy
- matplotlib
- scikit-learn

Etapas realizadas:

- Extração de dados (CSV)
- Tratamento de valores nulos
- Conversão de tipos
- Criação de novas colunas
- Análise estatística
- Criação de gráficos
- Treinamento de modelo de classificação

O objetivo foi prever categorias com base nos dados da base escolhida.

---

## 📊 Etapa 4 — Power BI

Na última etapa foi criado um dashboard utilizando Power BI.

Foram realizados:

- Importação do dataset
- Ajuste de tipos de dados
- Tratamento de valores nulos
- Criação de gráficos diferentes
- Análise dos dados
- Escrita das conclusões

O dashboard foi utilizado para gerar insights sobre o comportamento dos dados.

---

## 📁 Arquivos do Projeto

- modelo_conceitual.png  
- script.sql  
- notebook.ipynb  
- dataset.csv  
- dashboard.pbix  
- analise.docx  
- README.md  

---

## ✅ Conclusão

O desafio permitiu aplicar na prática conhecimentos de banco de dados, programação, análise de dados e visualização, simulando um fluxo real de desenvolvimento de software.

A integração entre modelagem, SQL, Python e Power BI mostrou a importância de cada etapa no desenvolvimento de sistemas baseados em dados.
