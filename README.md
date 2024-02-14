# Manhattan plots for RAiSD

This is an alternative way of plotting the results of [RAiSD](https://github.com/alachins/raisd). It follows the same logic, but creates one plot per chromosome, and uses [gplot2](https://ggplot2.tidyverse.org) instead of the `manhattan` function of the package [qqman](https://cran.r-project.org/web/packages/qqman/vignettes/qqman.html).

It accepts the same input as RAiSD's own plotting R script, and can simply be run via command line with `Rscript plot_raisd.R chr1.txt` where `chr1.txt` is your input file. It will use the base name of the file as the plot's title. You can easily loop it in bash to create one plot for each chromosome/scaffold of your genome.

