library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting --------------------------
dat <- "[{name: 'A',
value: 6,
children: [
{
  name: 'A-1',
  value: 6,
  children:[
  {
  name: 'A-1-1',
  value: 6
  },
  {
  name: 'A-1-2',
  value: 2
  }
  ]
},
  {
  name: 'A-2',
  value: 3
  }
  ]
  },
  {
  name: 'B',
  value: 6,
  children: [
  {name : 'B-1',
  value:10
  },
  {
  name:'B-2',
  value:2
  }
  ]
  },
  {
  name: 'C',
  value: 4
  }]"

  # Server function -------------------------------------------
  server <- function(input, output) {
    # Call functions from ECharts2Shiny to render charts
    renderTreeMap(div_id = "test",
                  data = dat)
  }
  
  # UI layout -------------------------------------------------
  ui <- fluidPage(
    # We MUST load the ECharts javascript library in advance
    loadEChartsLibrary(),
    
    tags$div(id="test", style="width:100%;height:500px;"),
    deliverChart(div_id = "test")
  )
  
  # Run the application --------------------------------------
  shinyApp(ui = ui, server = server)
  
  