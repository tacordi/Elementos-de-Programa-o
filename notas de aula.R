#ELEMENTOS DE PROGRAMAÇÃO
#ELEMENTOS BÁSICOS DO R


#LINKS ÚTEIS====
#cHEAT-SHEET - GIT NO RSTUDIO
browseURL('https://gysi.quarto.pub/ce302/cheatsheet/gitR_cheatsheet.html')
#CRAN 
browseURL('https://cran.r-project.org')
#Site_Deyse
browseURL('https://gysi.quarto.pub/ce302')

#VETORES ==================

# Criando um vetor de números inteiros
vetor_inteiro <- c(2, 4, 6, 8, 10)

# Criando um vetor de números reais
vetor_real <- c(3.14, 1.618, 2.718, 3.48, 1.9)

# Criando um vetor de caracteres
vetor_caracteres <- c("maçã", "banana", "laranja")

# Criando um vetor misto
vetor_misto <- c(1, 2, "maçã", "banana", "laranja")

#classe - verifica a classe da variável 
class(vetor_inteiro)

#PIPE (%>%) =================

c('x %>% f é equivalente à f(x)
x %>% f(y) é equivalente à f(x, y)
x %>% f %>% g %>% h é equivalente à h(g(f(x)))')
c('Note que não conseguimos utilizar o %>% com operadores aritiméticos. Portanto, uma alternativa é utiliarmos as funções
add(), subtract(), multiply_by(), raise_to_power(), divide_by() etc. Para a lista completa de funções, utilize ?add.')

install.packages('magrittr')
require(magrittr)

set.seed(123)

rnorm(10)    %>%
  multiply_by(5) %>%
  add(5)     


c('Muitas vezes queremos realizar operações e atribuir os resultados ao mesmo 
data.frame de entrada, por exemplo, podemos querer criar uma nova variável em
meu_data_frame, porem, não temos interesse em duplicar o banco de dados. 
Podemos fazer uma atribuição explicita ou implicita. 
Para a explicita, simplismente atribuímos utilizando = ou <-,
como vimos até agora durante o curso. 
Porém, podemos fazer uma atribuição implicita utilizando o operador %<>%.')


require(dplyr)
## Atribuição explicita
meu_data_frame <- data.frame(
  nome = c("Alice", "Bob", "Carol", "Ana", "João", "Carlos", "Patrícia", "Leonardo"),
  idade = c(25, 30, 28, 20, 27, 50, 60, 45),
  salario = c(5000, 6000, 5500, 8000, 2000, 3500, 10000, 3800 ), 
  meio_de_transporte = c('onibus', 'bicicleta', 'onibus', 'carro', 'carro', 'onibus', 'onibus', 'bicicleta'))

meu_data_frame = meu_data_frame %>%
  mutate(idade_25 = idade > 25)

glimpse(meu_data_frame)

c('
Rows: 8
Columns: 5
$ nome               <chr> "Alice", "Bob", "Carol", "Ana", "João", "Carlos", "…
$ idade              <dbl> 25, 30, 28, 20, 27, 50, 60, 45
$ salario            <dbl> 5000, 6000, 5500, 8000, 2000, 3500, 10000, 3800
$ meio_de_transporte <chr> "onibus", "bicicleta", "onibus", "carro", "carro", …
$ idade_25           <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE  
')

## Atribuição implicita
meu_data_frame %<>% 
  mutate(idade_50 = idade > 50)
glimpse(meu_data_frame)


c('Rows: 8
Columns: 6
$ nome               <chr> "Alice", "Bob", "Carol", "Ana", "João", "Carlos", "…
$ idade              <dbl> 25, 30, 28, 20, 27, 50, 60, 45
$ salario            <dbl> 5000, 6000, 5500, 8000, 2000, 3500, 10000, 3800
$ meio_de_transporte <chr> "onibus", "bicicleta", "onibus", "carro", "carro", …
$ idade_25           <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE
$ idade_50           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FAL…')


#MANIPULAÇÃO DE DADOS========


require(data.table)


#Pacote dplyr
install.packages("dplyr")
library(dplyr)

#glimpse - mostra a estrutura de um data frame
df <- data.frame(vetor_inteiro,vetor_real)
glimpse(df)

#select - seleciona colunas de interesse
c('No tidyverse, a função select() do pacote dplyr é amplamente utilizada para 
selecionar as colunas relevantes de um conjunto de dados. Além de selecionar 
colunas pelo nome, a função select() oferece diversas opções avançadas para
facilitar a seleção e manipulação de colunas.Vamos explorar algumas dessas 
opções:')
car_crash %>% 
  select(data, tipo_de_acidente) %>% 
  head()
  

c(' A forma mais simples de usar o select() é especificar os nomes das colunas 
que você deseja manter no resultado, por exemplo, podemos estar interessados em
selecionarmos a data e o tipo_de_acidente.')

car_crash %>% 
  select(starts_with("tipo")) %>% 
  head()

car_crash %>% 
  select(ends_with("feridos")) %>% 
  head()

car_crash %>% 
  select(contains("mente")) %>% 
  head()

car_crash %>% 
  select(where(is.numeric)) %>% 
  glimpse()

car_crash %>% 
  select(where(is.numeric)) %>% 
  glimpse()

car_crash %>% 
  select(where(is.character)) %>% 
  glimpse()

car_crash %>% 
  select(where(is.logical)) %>% 
  glimpse()

c('Seleção por critérios
all_of(), any_of(): Permitem usar variáveis definidas externamente como 
argumentos da função. Note que quando utilizamos all_of() todas as variáveis 
devem existir, já any_of() permite que nem todas as variáveis existam no
banco de dados.')

vars_interesse = c("automovel", "bicicleta", "onibus")
car_crash %>% 
  select(all_of(vars_interesse)) %>% 
  glimpse()

vars_interesse2 = c("automovel", "bicicleta", "onibus", "trator")
car_crash %>% 
  select(any_of(vars_interesse2)) %>% 
  glimpse()


c('No pacote dplyr do tidyverse, a função filter() é amplamente utilizada para 
filtrar linhas de um conjunto de dados com base em condições específicas. 
Ela oferece diversas opções para criar filtros complexos que 
atendam às suas necessidades de análise.Vamos explorar diferentes tipos
de filtros e como utilizá-los de maneira eficaz.')


dados_filtrados <- car_crash %>%
  filter(automovel >= 3)
dados_filtrados %>% 
  glimpse()

c('Filtros combinados')

dados_filtrados <- car_crash %>%
  filter(automovel >= 3 & caminhao > 2)
dados_filtrados %>% 
  glimpse()

c('Usando &')

dados_filtrados <- car_crash %>%
  filter(automovel >= 3, caminhao > 2)
dados_filtrados %>% 
  glimpse()

c('A função between() é útil para filtrar valores dentro de um intervalo numérico.
Podemos estar interessados em filtrar as observações com valores entre 4 e 8
motos envolvidas no acidente')

dados_filtrados <- car_crash %>%
  filter(between(moto, lower = 4, upper = 8, incbounds = TRUE)) 
dados_filtrados %>% 
  glimpse()

c('A função %in% é usada para filtrar valores que correspondem a um conjunto
de valores.Podemos estar interessados em filtrar as observações com ocorrência 
em alguma das seguintes operadoras: “Autopista Regis Bittencourt”, 
“Autopista Litoral Sul”, “Via Sul”.')

autopistas = c("Autopista Regis Bittencourt", "Autopista Litoral Sul", "Via Sul")

dados_filtrados <- car_crash %>%
  filter(lugar_acidente %in% autopistas) 
dados_filtrados %>% 
  glimpse()

c('Ou para a negação')
`%ni%` <- Negate(`%in%`)

dados_filtrados <- car_crash %>%
  filter(lugar_acidente %ni% autopistas) 
dados_filtrados %>% 
  glimpse()
c('ou')
car_crash %>%
  filter(!(lugar_acidente %in% autopistas)) %>%
  glimpse()

c('Outras vezes, podemos utilizar o operador %like% que busca padrões. 
Por exemplo, podemos estar interessados em buscar todos acidentes que 
ocorreram com vítimas, e no campo tipo_de_ocorrencia podemos simplesmente
buscar por:')

car_crash %>% 
  filter(tipo_de_ocorrencia %like% "com vítima") %>%
  glimpse()


c('Algumas vezes temos apenas vários padrões de texto que gostaríamos de buscar.
Para isso, a função grepl() permite filtrar com base em padrões de texto.')
car_crash %>% 
  filter(grepl("ilesa|fatal", tipo_de_ocorrencia)) %>%
  glimpse()

c('
Resumo de informações
No tidyverse, as funções summarise() e group_by() são amplamente utilizadas para
resumir informações e realizar cálculos agregados em conjuntos de dados. 
Elas desempenham um papel crucial na análise exploratória e naobtenção de 
insights significativos a partir dos dados. Vamos explorar como essas funções 
funcionam e como usá-las para resumir informações de maneira eficaz.

A função summarise() é utilizada para calcular estatísticas resumidas para uma 
coluna ou um conjunto de colunas. Ela permite calcular médias, somas, desvios 
padrão, mínimos, máximos e outras estatísticas relevantes.

Estamos interessados em uma tabela descritiva para a variável levemente_feridos.')

tabela <- car_crash %>% 
  summarise(n = n(), 
            f_r = n()/nrow(car_crash), 
            f_per = n()/nrow(car_crash) * 100, 
            media = mean(levemente_feridos, na.rm = T), 
            Q1 = quantile(levemente_feridos, 0.25, type = 5, na.rm = T), 
            Q2 = quantile(levemente_feridos, 0.5, type = 5, na.rm = T), 
            Q3 = quantile(levemente_feridos, 0.75, type = 5, na.rm = T), 
            var = var(levemente_feridos, na.rm = T), 
            sd  = sd(levemente_feridos, na.rm = T), 
            min = min(levemente_feridos, na.rm = T), 
            max = max(levemente_feridos, na.rm = T)) 

c('A função group_by() é usada para agrupar o conjunto de dados por uma ou 
mais colunas. Isso cria um contexto em que a função summarise()
pode calcular estatísticas específicas para cada grupo.')


tabela <- car_crash %>% 
  filter(tipo_de_ocorrencia %in% c("sem vítima", "com vítima"))%>% 
  group_by(tipo_de_ocorrencia) %>%
  summarise(n = n(), 
            f_r = n()/nrow(car_crash), 
            f_per = n()/nrow(car_crash) * 100, 
            media = mean(levemente_feridos, na.rm = T), 
            Q1 = quantile(levemente_feridos, 0.25, type = 5, na.rm = T), 
            Q2 = quantile(levemente_feridos, 0.5, type = 5, na.rm = T), 
            Q3 = quantile(levemente_feridos, 0.75, type = 5, na.rm = T), 
            var = var(levemente_feridos, na.rm = T), 
            sd  = sd(levemente_feridos, na.rm = T), 
            min = min(levemente_feridos, na.rm = T), 
            max = max(levemente_feridos, na.rm = T)) 



c('4.6.2 Manipulação de Datas
Após transformar strings em datas, podemos realizar várias operações de
manipulação de datas. Algumas das operações mais comuns incluem:')
  
c('Adição e subtração de dias, semanas, meses ou anos:')
  data <- as.Date("2023-08-21")
data2 <- data + 7  # Adicionando 7 dias
data3 <- data - 1  # Subtraindo 1 dia

Comparação de datas:
  data1 <- as.Date("2023-08-21")
data2 <- as.Date("2023-08-15")
data1 > data2  # Verifica se data1 é posterior a data2
[1] TRUE

Formatação de datas para strings:
  data <- as.Date("2023-08-21")
data_formatada <- format(data, "%d/%m/%Y")

Extração de componentes de data (ano, mês, dia):
  data <- as.Date("2023-08-21")
ano <- format(data, "%Y")
mes <- format(data, "%m")
dia <- format(data, "%d")

Cálculo de diferenças entre datas:
  data1 <- as.Date("2023-08-21")
data2 <- as.Date("2023-08-15")
diferenca <- difftime(data1, data2, units = "days")  # Diferença em dias
d



c('4.6.3 Lubridate: Facilitando a Manipulação de Datas no R
Lidar com datas no R pode ser uma tarefa desafiadora, especialmente quando se
precisa realizar operações complexas ou extrair informações específicas das
datas. O pacote lubridate foi desenvolvido para simplificar a manipulação de datas,
tornando as tarefas relacionadas a datas mais fáceis e intuitivas. Vamos explorar 
algumas das principais funcionalidades do lubridate em mais detalhes, 
com exemplos práticos:')

c'4.6.3.1 Instalação e Carregamento do Lubridate
Antes de usar o lubridate, é necessário instalá-lo e carregá-lo no R. 
Para isso, utilize o comando install.packages("lubridate") para a instalação 
e library(lubridate) para o carregamento do pacote.
Essas etapas devem ser executadas apenas uma vez.')

c('4.6.3.2 Criando Datas
O lubridate torna a criação de datas simples e flexível. 
Podemos criar datas usando diferentes funções, dependendo do formato dos seus dados. 
Além da já mencionada ymd() para datas no formato “ano-mês-dia,” também podemos utilizar:')
  
  mdy() para datas no formato “mês-dia-ano.”

dmy() para datas no formato “dia-mês-ano.”

'Essas funções ajudam a evitar confusões em relação ao formato das datas, 
tornando o processo de entrada de dados mais seguro. Veja um exemplo:'
  
  require(lubridate)
data_ymd <- ymd("2023-08-21")
data_mdy <- mdy("08-21-2023")
data_dmy <- dmy("21-08-2023")

print(data_ymd)

[1] "2023-08-21"
print(data_mdy)

[1] "2023-08-21"
print(data_dmy)

[1] "2023-08-21"
c('4.6.3.3 Operações com Datas
Operações com datas, como adição e subtração de dias, semanas, meses ou anos, 
são realizadas de forma mais clara e intuitiva no lubridate. 
O pacote fornece funções específicas para isso, como days(), weeks(), months(), 
e years(). Isso permite que executemos operações como:')
  
  data <- ymd("2023-08-21")
data_nova <- data + days(7)  # Adiciona 7 dias
data_anterior <- data - months(2)  # Subtrai 2 meses

print(data_nova)

[1] "2023-08-28"
print(data_anterior)

[1] "2023-06-21"
c('Essa sintaxe simplificada torna as operações com datas mais legíveis e menos
propensas a erros.')

c('4.6.3.4 Extraindo Informações de Datas
O lubridate permite extrair facilmente informações de datas. Com funções
como year(), month(), e day(), você pode obter o ano, mês ou dia de uma data 
específica. Além disso, é possível extrair informações mais detalhadas, como 
hora, minuto, e segundo, caso necessário. Isso é particularmente útil ao lidar 
com séries temporais ou análises de eventos temporais específicos.Veja exemplos:')
  
data <- ymd_hms("2023-08-21 15:30:45")
ano <- year(data)
mes <- month(data)
dia <- day(data)
hora <- hour(data)
minuto <- minute(data)
segundo <- second(data)

print(ano)

[1] 2023
print(mes)

[1] 8
print(dia)

[1] 21
print(hora)

[1] 15
print(minuto)

[1] 30
print(segundo)

[1] 45
4.6.3.5 Funções de Resumo de Datas
c('O lubridate oferece funções que auxiliam na análise e resumo de datas.
Podemos calcular a diferença entre duas datas com facilidade, obtendo o
resultado em dias, semanas, meses ou anos. Isso é útil em cenários em que é 
preciso medir a duração entre eventos ou calcular intervalos de tempo:')



data1 <- ymd("2023-08-21")
data2 <- ymd("2023-08-15")
diferenca_em_dias <- as.numeric(data2 - data1)
diferenca_em_semanas <- as.numeric(weeks(data2 - data1))

print(diferenca_em_dias)

[1] -6
print(diferenca_em_semanas)

[1] -3628800

c('4.6.3.6 Lidar com Fusos Horários
Para situações que envolvem fusos horários, o lubridate facilita a manipulação, 
permitindo a converção de datas entre fusos e calcule diferenças de tempo em
fusos diferentes. Isso é especialmente valioso em análises que abrangem regiões
geográficas distintas ou quando é necessário considerar fusos horários em análises
de eventos globais.')

'Converter uma Data para um Fuso Horário Específico:
 Imagine que temos uma data em um fuso horário específico e desejamos
convertê-la para outro fuso horário. O lubridate facilita essa tarefa usando a
função with_tz(). Veja um exemplo:'
  # Data original no fuso horário de Nova Iorque
  data_ny <- ymd_hms("2023-08-21 12:00:00", tz = "America/New_York")

# Converter para o fuso horário de Londres
data_london <- with_tz(data_ny, tz = "Europe/London")

print(data_ny)

[1] "2023-08-21 12:00:00 EDT"
print(data_london)

[1] "2023-08-21 17:00:00 BST"
'Neste exemplo, convertemos uma data de Nova Iorque para Londres.

Calcular a Diferença de Tempo entre Datas em Fusos Horários Diferentes:
Calcular a diferença de tempo entre duas datas em fusos horários diferentes pode
ser útil para determinar a sincronização de eventos em locais geograficamente
distintos. O lubridate permite isso com facilidade:
  '
# Duas datas em fusos horários diferentes
  data_ny <- ymd_hms("2023-08-21 12:00:00", tz = "America/New_York")
data_london <- ymd_hms("2023-08-21 17:00:00", tz = "Europe/London")

# Calcular a diferença de tempo em horas
diferenca_horas <- as.numeric(data_london - data_ny)

print(diferenca_horas)

[1] 0
'Trabalhar com Fusos Horários em Data Frames:
Em muitos casos, você pode ter um conjunto de dados com datas em diferentes 
fusos horários. O lubridate permite a manipulação desses dados em um Data Frame 
de forma eficiente. Suponha que temos um Data Frame chamado dados com datas em 
diferentes fusos horários:
  '
  dados <- data.frame(
    nome = c("Evento 1", "Evento 2"),
    data = c(
      ymd_hms("2023-08-21 12:00:00", tz = "America/New_York"),
      ymd_hms("2023-08-21 17:00:00", tz = "Europe/London")
    )
  )

# Converter todas as datas para um fuso horário comum, por exemplo, UTC
dados$data_utc <- with_tz(dados$data, tz = "UTC")

print(dados)

nome                data            data_utc
1 Evento 1 2023-08-21 12:00:00 2023-08-21 16:00:00
2 Evento 2 2023-08-21 12:00:00 2023-08-21 16:00:00
'Neste exemplo, convertemos todas as datas no Data Frame para o fuso
horário UTC, criando uma nova coluna chamada data_utc.

Lidar com fusos horários em análises de dados é fundamental para garantir que as
informações temporais sejam precisas e consistentes, especialmente em cenários
globais ou quando eventos ocorrem em locais diferentes ao redor do mundo. 
O pacote lubridate no R simplifica significativamente essa tarefa, 
tornando a manipulação de datas com fusos horários uma tarefa mais clara e 
eficiente.
'


#ESTRUTURAS DE REPETIÇÃO====
'O loop while é uma das estruturas de repetição mais simples. Ele é usado quando
você precisa repetir um bloco de código enquanto uma condição for verdadeira. 
E seu critério de parada é atualizado, i.e., você não sabe de imediato quantas 
vezes vai precisar repetir o procedimento.A estrutura básica do while é a
seguinte:'

While (condicao) {
  # Código a ser repetido enquanto a condição for verdadeira
}

i <- 1 # sempre definimos o critério de parada fora do loop

while (i < 6) {
  print(i)
  i <- i + 1 # Sempre alteramos o critério 
  # de parada, senão caímos em um loop infinito
}

'BREAK'

'Mesmo quando uma condição é verdadeira, podemos ter interesse em parar uma
repetição, mesmo que a condição seja TRUE. Útil quando não queremos cair em um 
loop infinito. Por exemplo, podemos parar o nosso loop caso nosso i == 4.'

i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}

'Next' 
'Outras vezes, podemos pular uma iteração sem encerrar o loop:'
i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}


'Suponha o lançamento de um dado não viesado, com seis faces. Quantas vezes 
devo lançar o dado para obter a face 5?
  
  set.seed(1234)

dado <- seq(1:6)
n_lancamento = 0
sorteio = 0

while (sorteio != 5) {
  sorteio =  sample(dado, 1)
  n_lancamento = n_lancamento + 1
  
  cat(paste0("\n\nLançamento: ", n_lancamento, "\nValor Sorteado: ", sorteio))
}'

##FUNÇÔES====
'Funções e Expressões
6.1 Funções 
Uma função é um conjunto de instruções que realizam uma tarefa específica quando
chamadas. Elas desempenham um papel crucial na programação, permitindo a
modularização e reutilização do código. As funções em R seguem uma estrutura
geral:'
  
  nome_da_funcao <- function(argumentos) {
    # Corpo da função
    # Instruções para realizar a tarefa
    return(resultado) # Resultado da função
  }

'nome_da_funcao: É o nome atribuído à função, que deve ser descritivo e 
significativo.

argumentos: São os parâmetros que a função recebe como entrada.
Eles podem ser opcionais ou obrigatórios, dependendo da função.

Corpo da função: É onde as operações desejadas são definidas usando R.
'
'return(resultado): A função pode opcionalmente retornar um resultado calculado. 
Se não especificado, a função retorna implicitamente o último valor calculado. 
É uma boa prática explicitamente definir o que a função deve retornar.
'

'6.1.1 Exemplo
Suponha que temos interesse em calcular a média de uma determinada variável 
em um banco de dados e gostaríamos de aplicar essa função diversas vezes. 
Vamos demonstrar isso utilizando o banco de dados “iris”.


data("iris")

media_sepal_len = round(sum(iris$Sepal.Length)/length(iris$Sepal.Length),2)
media_sepal_len

[1] 5.84
media_sepal_wid = round(sum(iris$Sepal.Width)/length(iris$Sepal.Width),2)
media_sepal_wid

[1] 3.06
media_petal_len = round(sum(iris$Petal.Length)/length(iris$Petal.Length),2)
media_petal_len

[1] 3.76
media_petal_wid = round(sum(iris$Petal.Width)/length(iris$Petal.Width),2)
media_petal_wid

[1] 1.2
Temos de repetir a mesma operação quatro vezes. Poderiamos simplesmente criar
uma função chamada média e não precisar repetir o mesmo procedimento multiplas
vezes. 
Vamos definir nossa primeira função em R.
'
minha_media <- function(vetor_de_dados){
  media = sum(vetor_de_dados)/length(vetor_de_dados)
  media = round(media, 2)
  return(media)
}

minha_media(iris$Sepal.Length)

[1] 5.84
'Suponha que tenhamos interesse em que o número de casas decimais seja
definido pelo usuário:'
  
  minha_media_arredond <- function(vetor_de_dados, arredondamento = 5){
    media = sum(vetor_de_dados)/length(vetor_de_dados)
    media = round(media, arredondamento)
    return(media)
  }

minha_media(iris$Sepal.Length)

[1] 5.84
minha_media_arredond(iris$Sepal.Length)

[1] 5.84333
Podemos estar interessados em calcular o Desvio Padrão Amostral.

meu_desvio_padrao_amostral <- function(vetor) {
  media <- minha_media_arredond(vetor) 
  diferenca <- vetor - media  # Calcula as diferenças em relação à média
  quadrados <- diferenca^2  # Calcula os quadrados das diferenças
  variancia <- sum(quadrados) / (length(vetor) - 1)  # Calcula a variância
  desvio_padrao <- sqrt(variancia)  # Calcula o desvio padrão
  return(desvio_padrao)
}

meu_desvio_padrao_amostral(iris$Sepal.Length)

[1] 0.8280661
'Com o desvio padrão amostral e a média podemos calcular o coeficiente de
variação (CV). O CV é dado por
ã
é'

.

'Podemos implementar essa função, e para isso, podemos utilizar as duas funções
que implementamos anteriormente.'

meu_coeficiente_variacao <- function(vetor, arredondamento = 2) {
  media <- minha_media_arredond(vetor, arredondamento = arredondamento)  # Calcula a média
  desvio_padrao <- meu_desvio_padrao_amostral(vetor)  # Calcula o desvio padrão
  coeficiente_variacao <- (desvio_padrao / media) * 100  # Calcula o CV em porcentagem
  coeficiente_variacao = round(coeficiente_variacao, arredondamento)
  return(coeficiente_variacao)
}

meu_coeficiente_variacao(iris$Sepal.Length, arredondamento = 2)

[1] 14.18
Suponha que temos interesse em retornar ao usuário mais do que um valor, no nosso exemplo do CV temos interesse em retornar a média, o desvio padrão e o CV. Podemos fazer isso de diversas maneiras, aqui veremos apenas duas: retornar um data.frame e uma lista nomeada.

meu_coeficiente_variacao2 <- function(vetor, arredondamento = 2) {
  media <- minha_media_arredond(vetor, arredondamento = arredondamento)  # Calcula a média
  desvio_padrao <- meu_desvio_padrao_amostral(vetor)  # Calcula o desvio padrão
  coeficiente_variacao <- (desvio_padrao / media) * 100  # Calcula o CV em porcentagem
  coeficiente_variacao = round(coeficiente_variacao, arredondamento)
  return(data.frame(CV = coeficiente_variacao, 
                    média = media, 
                    dp = desvio_padrao))
  
}

meu_coeficiente_variacao2(iris$Sepal.Length, arredondamento = 2)

CV média        dp
1 14.18  5.84 0.8280661
meu_coeficiente_variacao3 <- function(vetor, arredondamento = 2) {
  media <- minha_media_arredond(vetor, arredondamento = arredondamento)  # Calcula a média
  desvio_padrao <- meu_desvio_padrao_amostral(vetor)  # Calcula o desvio padrão
  coeficiente_variacao <- (desvio_padrao / media) * 100  # Calcula o CV em porcentagem
  coeficiente_variacao = round(coeficiente_variacao, arredondamento)
  return(list(CV = coeficiente_variacao, 
              média = media, 
              dp = desvio_padrao))
  
}

meu_coeficiente_variacao3(iris$Sepal.Length, arredondamento = 2)

$CV
[1] 14.18

$média
[1] 5.84

$dp
[1] 0.8280661
6.1.2 Mensagens
'No R existem diversos tipos de mensagem que podem ser geradas dentro de uma
função, as principais são as messages e os warnings.'

'As mensagens em R são usadas para fornecer informações ou feedback ao usuário
durante a execução de uma função ou script. Elas são úteis para comunicar 
detalhes sobre o progresso do código ou resultados intermediários.'

x <- -5
if (x < 0) {
  message("O valor de x é negativo.")
}

'O valor de x é negativo.
Os warnings são mensagens que alertam o usuário sobre situações que não 
são necessariamente erros, mas que podem indicar problemas ou comportamentos 
inesperados em um código. Eles são geralmente usados para chamar a atenção do 
usuário para possíveis questões que precisam ser consideradas.
No entanto, o código continuará sendo executado após a exibição de um aviso.'

x <- -5
if (x < 0) {
  warning("O valor de x é negativo.")
}

Warning: O valor de x é negativo.

'Também podemos forçar a parada da função caso seja um erro.'

x <- -5
if (x < 0) {
  stop("O valor de x é negativo.")
}

'
6.2 Controle de Fluxo
O controle de fluxo refere-se às estruturas que permitem tomada de decisões e
execução de diferentes blocos com base em condições específicas. 
Podemos usar várias construções para controlar o fluxo de execução, 
as principais são: Estruturas Condionais e Estruturas de Repetição. 
Na aula de hoje focaremos apenas nas estruturas condicionais e na
próxima em estruturas de repetição.

6.2.1 Estruturas Condicionais (If-else)
As estruturas condicionais permitem a execução um bloco de código se uma condição for verdadeira e outro bloco de código se a condição for falsa.

A estrutura é basicamente:'
  
  if (condicao) {
    # Código a ser executado se a condição for verdadeira
  } else {
    # Código a ser executado se a condição for falsa
  }

'Exemplo:'
  
  idade <- 25

if (idade >= 18) {
  cat("Você é maior de idade.\n")
} else {
  cat("Você é menor de idade.\n")
}
'
Você é maior de idade.
As estruturas condicionais podem ser aninhadas, por exemplo, podemos ter interesse em classificar as notas dos alunos em diferentes faixas, como “A”, “B”, “C” ou “D”, com base na pontuação. As notas são geralmente classificadas de acordo com um intervalo específico de pontos. Notas acima de 90 são consideradas A, notas entre 80 e 90 são B, notas entre 70 e 80 são C, ou D caso contrário.
'
pontuacao = 90

if (pontuacao >= 90) {
  nota = "A"
} else {
  if (pontuacao >= 80) {
    nota = "B"
  } else {
    if (pontuacao >= 70) {
      nota = "C"
    } else {
      nota = "D"
    }
  }
}

nota

[1] "A"
'Poderíamos estar interessados em realizar esse procedimento múltiplas vezes,
e uma forma de resolvermos esse problema podemos simplesmente passar para uma
função:'
  
  classifica_nota <- function(pontuacao) {
    if (pontuacao >= 90) {
      nota <- "A"
    } else {
      if (pontuacao >= 80) {
        nota <- "B"
      } else {
        if (pontuacao >= 70) {
          nota <- "C"
        } else {
          nota <- "D"
        }
      }
    }
    cat(paste("A nota do aluno é:", nota))
    return(nota)
  }

pontuacao_aluno <- 85
nota <- classifica_nota(pontuacao_aluno)

'A nota do aluno é: B
Podemos estar interessado em criar uma função para determinarmos o Quadrante de
um Ponto no Plano Cartesiano, essa função recebe como entrada dois valores, 
as coordenadas (x, y).'

quadrante <- function(x, y) {
  if (x > 0) {
    if (y > 0) {
      quadrante = "Quadrante 1"
      
      cat(paste0("O ponto (", x, ", ", y, ") pertence ao ",  quadrante))
      return(quadrante)
    } else {
      quadrante = "Quadrante 4"
      
      cat(paste0("O ponto (", x, ", ", y, ") pertence ao ",  quadrante))
    }
  } else {
    if (y > 0) {
      quadrante = "Quadrante 2"
      
      cat(paste0("O ponto (", x, ", ", y, ") pertence ao ",  quadrante))
    } else {
      quadrante = "Quadrante 3"
      
      cat(paste0("O ponto (", x, ", ", y, ") pertence ao ",  quadrante))
    }
  }
}


quadrante(1, 1)

O ponto (1, 1) pertence ao Quadrante 1
[1] "Quadrante 1"
quadrante(-1, 1)

O ponto (-1, 1) pertence ao Quadrante 2
quadrante(1, -1)

O ponto (1, -1) pertence ao Quadrante 4
quadrante(-1, -1)

O ponto (-1, -1) pertence ao Quadrante 3
6.2.2 If_else e ifelse
'Muitas vezes precisamos codificar valores de uma variável dentro de um banco de
dados. Para isso, podemos utilizar as funções if_else ou ifelse.'

'Suponha que queremos classificar o comprimento das pétalas em “longa”ou 
“curta”, para isso podemos fazer como segue:'
  
  require(magrittr)

Loading required package: magrittr
require(dplyr)

Loading required package: dplyr

Attaching package: 'dplyr'
The following objects are masked from 'package:stats':
  
  filter, lag
The following objects are masked from 'package:base':
  
  intersect, setdiff, setequal, union
iris %<>% 
  mutate(cat_petal.len = ifelse(Petal.Length > mean(Petal.Length), "Longa", "Curta"))

iris %<>% 
  mutate(cat_petal.len2 = if_else(Petal.Length > mean(Petal.Length), "Longa", "Curta"))

6.2.3 Switch
'O comando switch é outra construção de controle de fluxo que permite escolher
entre várias alternativas com base em um valor especificado. 
É útil quando você precisa executar um bloco de código diferente para diferentes
valores de uma variável. A sintaxe básica do switch em R é a seguinte:'
  
  switch(expressao, caso1, caso2, ..., casoN)

dia_da_semana <- "segunda"

mensagem <- switch(dia_da_semana,
                   "segunda" = "Hoje é segunda-feira.",
                   "terca" = "Hoje é terça-feira.",
                   "quarta" = "Hoje é quarta-feira.",
                   "quinta" = "Hoje é quinta-feira.",
                   "sexta" = "Hoje é sexta-feira.",
                   "sabado" = "Hoje é sábado.",
                   "domingo" = "Hoje é domingo.",
                   "Outro" = "Dia não reconhecido."
)

cat(mensagem)

'Hoje é segunda-feira.'

'6.2.4 case_when 
Similar ao ifelse, temos o case_when quando nosso interesse está em codificar 
variáveis de um banco de dados.

Tomemos como exemplo as medidas das sépalas, agora queremos agrupar em três 
categorias:'
X < média - 1 desvio

média - 1 desvio < X < média + 1 desvio

X > média + 1 desvio

iris$cat_sepal = 
  case_when((iris$Sepal.Length < mean(iris$Sepal.Length) - sd(iris$Sepal.Length)) ~ "X < media - 1 sd", 
            (iris$Sepal.Length < mean(iris$Sepal.Length) + sd(iris$Sepal.Length)) ~ "X < media + 1 sd", 
            .default = "X > media + 1 sd")






library(usethis)
use_git_config(user.name = "tacordi", 
               user.email = "thiagoacordi@gmail.com")