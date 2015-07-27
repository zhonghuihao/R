library(quantmod)

## 上证指数
setSymbolLookup(SZZS = list(name="000001.SS", src="yahoo"))
szzs <- getSymbols("SZZS",from = "2013-01-01",to = Sys.Date())

## 四维图新
setSymbolLookup(SWTX = list(name="002405.SZ", src="yahoo"))
swtx <- getSymbols("SWTX",from = "2013-01-01",to = Sys.Date())

## 月指数和周指数
SZZS.M <- to.monthly(SZZS)
SZZS.W <- to.weekly(SZZS)
SWTX.M <- to.monthly(SWTX)
SWTX.W <- to.weekly(SWTX)

require(TTR) 
ser <- chartSeries(SWTX.W,theme = chartTheme("white",up.col="red",dn.col="green")) 

## add moving averges to a chart 
addSMA(5,on=1 ,with.col = Cl , overlay = T, col = "yellow")
addSMA(10,on=1 ,with.col = Cl , overlay = T, col = "green")
addSMA(30,on=1 ,with.col = Cl , overlay = T, col = "red")

## add MACD line
## red&green:MACD,yellow:DIFF,red:DAE 
addMACD(fast = 10, slow = 20, signal = 5,col = c("red", "green", "yellow", "red"))

## add Bollinger bands
addBBands()

