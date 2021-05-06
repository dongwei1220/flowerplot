## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example, fig.width=7,fig.height=6.5--------------------------------------
library(flowerplot)

## basic example code
data(flower_dat)
head(flower_dat)

flowerplot(flower_dat)
flowerplot(flower_dat, a = 0.5, b = 2, r = 1,
           circle_col = "red", ellipse_col_pal = "Spectral",
           label_text_cex = 1)
flowerplot(flower_dat, angle = 60, ellipse_col_pal = "Set3")

