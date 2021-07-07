#' @title flowerplot
#'
#' @description A package for drawing flower plot with multiple data sets.
#'
#' @author Wei Dong <dongw26@mail2.sysu.edu.cn>
#'
#' @param flower_dat a dataframe with multiple columns.
#' @param angle set the angle of rotation in degress.
#' @param a set the radii of the ellipses along the x-axes.
#' @param b set the radii of the ellipses along the y-axes.
#' @param r set the radius of the circle.
#' @param ellipse_col_pal set the color palette for filling the ellipse.
#' @param circle_col set the color for filling the circle.
#' @param label_text_cex set the label text cex.
#'
#' @return A flower plot.
#' @export
#' @import plotrix
#' @import RColorBrewer
#'
#' @examples
#' data(flower_dat)
#' head(flower_dat)
#'
#' flowerplot(flower_dat)
#' flowerplot(flower_dat, a = 0.5, b = 2, r = 1,
#'            circle_col = "red", ellipse_col_pal = "Spectral",
#'            label_text_cex = 1.5)
#' flowerplot(flower_dat, angle = 60, ellipse_col_pal = "Set3")
flowerplot <- function(flower_dat, angle = 90,
                       a = 1, b = 2, r = 1,
                       ellipse_col = NULL,
                       ellipse_col_pal = "Set1",
                       circle_col = "white",
                       label_text_cex = 1)
{
  set_name <- colnames(flower_dat)
  item_id <- unique(flower_dat[,1])
  item_id <- item_id[item_id != '']
  core_item_id <- item_id
  item_num <- length(item_id)

  for (i in 2:ncol(flower_dat)) {
    item_id <- unique(flower_dat[,i])
    item_id <- item_id[item_id != '']
    core_item_id <- intersect(core_item_id, item_id)
    item_num <- c(item_num, length(item_id))
  }
  core_num <- length(core_item_id)

  graphics::par( bty = 'n', ann = F, xaxt = 'n', yaxt = 'n', mar = c(1,1,1,1))
  graphics::plot(c(0,10), c(0,10), type='n')
  n   <- length(set_name)
  # set the angle of degress
  deg <- 360 / n
  # set the ellipse filling color
  if (is.null(ellipse_col)) {
    colors <- RColorBrewer::brewer.pal(8, ellipse_col_pal)
    ellipse_col <- grDevices::colorRampPalette(colors)(n)
  }

  res <- lapply(1:n, function(t){
    plotrix::draw.ellipse(x = 5 + cos((angle + deg * (t - 1)) * pi / 180),
                          y = 5 + sin((angle + deg * (t - 1)) * pi / 180),
                          col = ellipse_col[t],
                          border = ellipse_col[t],
                          a = a, b = b,
                          angle = deg * (t - 1))
    graphics::text(x = 5 + 2.5 * cos((angle + deg * (t - 1)) * pi / 180),
                   y = 5 + 2.5 * sin((angle + deg * (t - 1)) * pi / 180),
                   item_num[t])

    if (deg * (t - 1) < 180 && deg * (t - 1) > 0 ) {
      graphics::text(x = 5 + 3.3 * cos((angle + deg * (t - 1)) * pi / 180),
                     y = 5 + 3.3 * sin((angle + deg * (t - 1)) * pi / 180),
                     set_name[t],
                     srt = deg * (t - 1) - angle,
                     adj = 1,
                     cex = label_text_cex
      )
    } else {
      graphics::text(x = 5 + 3.3 * cos((angle + deg * (t - 1)) * pi / 180),
                     y = 5 + 3.3 * sin((angle + deg * (t - 1)) * pi / 180),
                     set_name[t],
                     srt = deg * (t - 1) + angle,
                     adj = 0,
                     cex = label_text_cex
      )
    }
  })
  plotrix::draw.circle(x = 5, y = 5, r = r, col = circle_col, border = NA)
  graphics::text(x = 5, y = 5, paste('Core items:', core_num), cex = label_text_cex)
}
