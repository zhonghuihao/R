library(quantmod)
sse<-getSymbols("^SSEC",from = "2015-01-01",to = Sys.Date(),src = "yahoo")
tail(SSEC)
# candleChart(SSEC,theme = "white")
barChart(SSEC)
## Add multi-coloring and change background to white 
candleChart(SSEC,multi.col=TRUE,theme="white") 

SSEC.m <- to.monthly(SSEC)
tail(SSEC.m)
candleChart(SSEC.m,theme = "white")

SSEC.w <- to.weekly(SSEC)
tail(SSEC.w)
candleChart(SSEC.w,theme = "white")

# Technical analysis charting tools
require(TTR) 
getSymbols("AAPL",from = "2015-01-01",to = Sys.Date(),src = "yahoo")
chartSeries(AAPL) 
addMACD() 
addBBands() 

> # Create a quantmod object for use in 
> # in later model fitting. Note there is 
> # no need to load the data before hand. 
setSymbolLookup(SPY='yahoo',VXN=list(name='^VIX',src='yahoo')) 
mm <- specifyModel(Next(OpCl(SPY)) ~ OpCl(SPY) + Cl(VIX)) 
modelData(mm)

data <- na.omit(
    merge(
      
      ))













