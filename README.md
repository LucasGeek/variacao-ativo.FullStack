[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![Open Source](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://opensource.org/)
![Dart Version](https://img.shields.io/static/v1?label=dart&message=3.0.1&color=00579d)
![Flutter Version](https://img.shields.io/static/v1?label=flutter&message=3.10.1&color=42a5f5)

# **Variação de Ativo**

Este desafio consiste em consultar a variação do preço de um ativo a sua escolha nos últimos 30 pregões. Você deverá apresentar o percentual de variação de preço de um dia para o outro e o percentual desde o primeiro pregão apresentado.

| Dia   | Data          |  Valor    | Variação em relaçào a D-1     | Variação em relação a primeira data
|-      | -             | -         | -                             | - 
|2      |  01/01/2021   |  R$ 1,00  | -                             | -
|3      |  02/01/2021   |  R$ 1,10  | 10%                           | 10%
|4      |  03/01/2021   |  R$ 1,05  | -4,54%                        | 5%
|5      |  04/01/2021   |  R$ 1,90  | 80,95%                        | 90%

Para este desafio, iremos utilizar a API do Yahoo Finance https://finance.yahoo.com/ 

Como sistemas de backend implementar a solução em **.NET Core, NodeJs, Elixir ou Go**. Para frontend, utilizar **Angular, React ou Vue** Para mobile, utilizar **liguagens nativas e React ou Flutter**.

## Backend (.NET Core, NodeJs, Elixir ou Go)
1. Consultar o preço do ativo na API do Yahoo Finance (este é um exemplo da consulta do ativo PETR4 https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA)
2. Armazenar as informações em uma base de dados a sua escolha.
3. Implementar uma API que consulte as informações na sua base de dados, retorne o valor do ativo nos últimos 30 pregões e apresente a variação do preço no período. Você deverá considerar o valor de abertura (*chart.result.indicators.quote.open*)

## Frontend (Angular, React ou Vue)
1. Consultar o preço do ativo na API do Yahoo Finance (este é um exemplo da consulta do ativo PETR4 https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA)
2. Implementar uma página em Angular que apresente o valor do ativo nos últimos 30 pregões e mostre a variação do preço no período. Você deverá considerar o valor de abertura (*chart.result.indicators.quote.open*)
3. Inclua um gráfico apresentando o resultado da variação.

## Mobile (Liguagens nativas e React ou Flutter)
1. Implementar o core da aplicação a talea inicial em linguagem nativa.
2. Para implementações Android, considerar Kotlin ou Java.
3. Para implementações iOS, considerar UIKit ou SwiftUI.
4. Consultar o preço do ativo na API do Yahoo Finance (este é um exemplo da consulta do ativo PETR4 https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA)
5. Implementar uma tela em flutter que apresente a variação do preço do ativo nos últimos 30 pregões e mostre a rentabilidade no período. Você deverá considerar o valor de abertura (*chart.result.indicators.quote.open*)
6. Inclua um gráfico em linguagem nativa ou flutter apresentando o resultado da variação.

Você pode ainda montar a parte de Backend deste desafio e consumir sua própria API para acessar a API do Yahoo Finance. Fica a sua escolha. :smirk:

## Sobre a avaliação
:bangbang: Utilize os recursos disponíveis na linguagem:
* Padrões de projetos 
* Arquiteturas
* Testes unitários
* Configuração de deploy

## Importante
### Sobre a API
Os valores estrão estruturados em vetores, desta forma, você precisará casar a data do pregão (*chart.result.timestamp*) com o valor de abertura (*chart.result.indicators.quote.open*) através do indice do vetor.

### Sobre a entrega
:heavy_exclamation_mark: Use sua criatividade para estruturar sua solução. Importante manter uma documentação clara de como deveremos proceder para executar sua aplicação (__crie um arquivo MD e inclua no seu repositório__), sendo assim, importante disponibilizar os scripts de banco de dados e demais recursos utilizados e como utilizá-los. :heavy_exclamation_mark: 
