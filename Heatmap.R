
R version 3.2.2 (2015-08-14) -- "Fire Safety"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.66 (6996) x86_64-apple-darwin13.4.0]

[History restored from /Users/Jullybully/.Rapp.history]

> setwd("~/Downloads")
> require(gplots)
Loading required package: gplots

Attaching package: ‘gplots’

The following object is masked from ‘package:stats’:

    lowess

Warning message:
package ‘gplots’ was built under R version 3.2.4 
> require(RColorBrewer)
Loading required package: RColorBrewer
> mf_log <- read.csv(file = "mf_log_st.csv", header=T, na.strings = "NA", strip.white = TRUE)
> head(mf_log)
     Feature.ID fdr_q M0_01_Log_RPKM M0_09_Log_RPKM M0_15_Log_RPKM
1 0610007P14Rik 0.414       2.252476       2.378234       2.336283
2 0610009B22Rik 0.772       3.566693       3.342128       3.511974
3 0610009L18Rik 0.382       1.022190       1.394514       1.158983
4 0610009O20Rik 0.778       2.983313       2.982400       2.898015
5 0610010F05Rik 0.660       2.095587       1.932439       2.054848
6 0610010K14Rik 0.215       2.637147       2.967169       2.630172
  M2_02_Log_RPKM M2_10_Log_RPKM M2_16_Log_RPKM
1      2.3442604      2.4895429      2.4562805
2      3.6532894      3.4657133      3.4123751
3      0.7731524      0.7941039      0.9701174
4      3.0299829      2.8910303      3.0084510
5      2.0482362      1.8587767      1.8511993
6      2.8383467      3.1376675      2.9601410
> 
> dif.001 <- mf_log[mf_log$fdr_q < 0.001,]
> dif.001[mapply(is.infinite, dif.001)] <- -8
> rownames(dif.001) <- dif.001$Feature.ID
> dif.001$Feature.ID <- NULL
> dif.001$fdr_q <- NULL
> dif.001$mean_m0 <- rowMeans(dif.001[1:3])
> dif.001$mean_m2 <- rowMeans(dif.001[4:6])
> dif.001$ratio <-  dif.001$mean_m2-dif.001$mean_m0
> dif.001_f2 <- dif.001[abs(dif.001$ratio) > 1.416,] 
> difmat <-  as.matrix(dif.001_f2[,1:6])
> heatmap.2(difmat, # this is the name of the datamatrix
+           col=colorRampPalette(c("cyan4","cyan","darkcyan","darkorange4","orange","yellow"))(600),
+           key=T,
+           keysize=0.8,
+           #cellnote = mat_data, # same data set for cell labels
+           #scale="row",         # scales column. default settings (X-Xcolum)/SDcolumn
+           #main = main ,         # heat map title
+           distfun = function(x) dist(x,method = 'euclidean'), # Use Euclidean to calculate distances for hierarchical clustering
+           hclustfun = function(x) hclust(x,method = 'ward.D2'), #use Ward.D2 for aglomerative clustering
+           #notecol=,            # change font color of cell labels to black
+           density.info="none",  # turns off density plot inside color legend
+           trace="none",         # turns off trace lines inside the heat map
+           margins =c(12,12),    # widens margins around a plot
+           dendrogram="both"    
+           #Colv="NA"         
+ )      
> 
