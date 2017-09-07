library(shiny)

ui <- fluidPage(
  title = "Dashboard",
  titlePanel("Dashboard"),
  sidebarLayout(
    sidebarPanel(
      numericInput("input_num_I", label = "Número de variáveis", value = "2"),
      uiOutput("selectX"),
      uiOutput("selectY"),
      uiOutput("selectG")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Gráfico",
                 fluidRow(
                   column(12,  plotOutput("plot")),
                   hr(),
                   column(6, "Número de variáveis:", verbatimTextOutput("valueI")),
                   column(6, "Variável X:",  verbatimTextOutput("valueY")),
                   column(6, "Variável Y:",  verbatimTextOutput("valueX")),
                   column(6, "Tipo de gráfico:",  verbatimTextOutput("valueG"))
                  )
                 ),
        tabPanel("Sumário",
                 fluidRow(
                   br(),
                   column(12, verbatimTextOutput("valueSummary") )
                 )
                ),
        tabPanel("Tabela",
                 fluidRow(
                   br(),
                   column(12, tableOutput("tableSet") )
                 )
                )
      )
    )
  )
)