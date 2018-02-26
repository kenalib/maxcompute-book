

# enable relative path in RStudio (push "Source" to execute)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

measures <-
  read.csv(
    '../data/output/20140301/adm_user_measures_weekly.csv',
    header = FALSE,
    sep = ","
  )

colnames(measures) = c("day", "pv", "uv")
measures <- measures[order(measures$day),]
days <- measures$day
pvs <- measures$pv
uvs <- measures$uv

plot(
  x = days,
  y = pvs,
  xlab = "date",
  ylab = "pv/uv",
  type = "l",
  main = "PV/UV",
  col = "red",
  ylim = c(0, 100)
)
lines(x = days, y = uvs, col = "green")
legend(
  "topright",
  legend = c("PV", "UV"),
  col = c("red", "green"),
  lty = c(1:2)
)
box()
