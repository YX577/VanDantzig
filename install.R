#!/usr/bin/env Rscript

# Check for missing libraries and install as needed
list.of.packages <- c("zoo", "lubridate", "lhs", "extrafont", "fExtremes", "extRemes")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='http://cran.us.r-project.org')
