###from  http://www.karada-good.net/analyticsr/r-10/
###ライブラリーの読み込み#####
library("XLConnect")
library("tcltk")
library("RMeCab")
library("wordcloud")
library("RColorBrewer")
########

###データの読み込み#####
selectABook <- paste(as.character(tkgetOpenFile(title = "テキストxlsxファイルを選択",filetypes = '{"xlsxファイル" {".xlsx"}}',initialfile = "*.xlsx")), sep = "", collapse =" ")
MasterAnaData <- loadWorkbook(selectABook)
AnaData <- readWorksheet(MasterAnaData, sheet = 1)
########

###単語の出現数設定。3以上での抽出結果となります。出現数は適時調整してください。#####
WordFreq <- 2
########

###結果保存先のフォルダを設定#####
SaveDir <- as.data.frame(paste(as.character(tkchooseDirectory(title = "データ保存フォルダを選択"), sep = "", collapse =" "))) #初期dirpathの取得準備
SaveDir <- paste(SaveDir[1:(nrow(SaveDir)),], sep = " ", collapse = "/" ) #保存先pathの取得
########

###列ごとにテキストファイルを作成#####
for (i in seq(nrow(AnaData)) ){
  setwd(SaveDir)
  write(AnaData[i, 1] ,  file = paste("変換",i, ".txt", sep=""))
}
########

###テキスト内の単語解析######
res <- docMatrix(SaveDir, pos = c("名詞", "形容詞"))
res <- res[row.names(res)!= "[[LESS-THAN-1]]", ] #[[LESS-THAN-1]]の削除
resc <- res[row.names(res)!= "[[TOTAL-TOKENS]]", ]　#[[TOTAL-TOKENS]]の削除
########

###単語解析結果をデータフレーム化#####
AnalyticsFileDoc <- as.data.frame(apply(resc, 1, sum)) #単語の出現率を集計
AnalyticsFileDoc <- subset(AnalyticsFileDoc, AnalyticsFileDoc[, 1] >= WordFreq) #出現数で抽出
colnames(AnalyticsFileDoc) <- "出現数" #行名の設定
########

###タグクラウドのテキストの色を設定#####
Col <- brewer.pal(9, "BuGn") #文字色の指定
Col <- Col[-(1:3)] #見やすく薄い色を削除
########

###タグクラウドのプロット#####
wordcloud(row.names(AnalyticsFileDoc), AnalyticsFileDoc[, 1], scale=c(6,.2),
          random.order = T, rot.per = .15, colors = Col)
########

###結果をcsvで出力#####
write.csv(AnalyticsFileDoc,"結果.csv")
########
