

# enable relative path in RStudio (push "Source" to execute)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

referer <-
  read.csv('../data/output/20140302/adm_refer_info.csv',
           header = FALSE,
           sep = ",")

colnames(referer) = c("site", "cnt")
count <- referer$cnt
sites <- referer$site
percentage <- round(count / sum(count) * 100)
label <- paste(sites, " ", percentage, "%", sep = "")

pie(count,
    labels = label,
    col = rainbow(length(label)),
    main = "referers")
