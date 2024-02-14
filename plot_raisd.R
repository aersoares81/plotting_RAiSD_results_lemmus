args = commandArgs(trailingOnly=TRUE)
library(ggplot2)
library(dplyr)

RUNNAME <- args[1]
THRESHOLD <- "0.9995"
RUNNAME <- sub(".txt", "", RUNNAME)  # remove ".txt" from RUNNAME
reportListN <- paste(RUNNAME,".txt", sep="")
reportList <- read.table(reportListN)[,1]
data <- data.frame(pos=c(), value=c(), chr=c())
for (i in 1:length(reportList[])) {
  d <- read.table(paste(reportList[i]), header=F, skip=0)[,1:7]
  tmp.dat <- data.frame(pos=d[,1], value=d[,7]*1, chr=rep(i, length(d[,1])))
  data <- rbind(data, tmp.dat)}

# Convert chr to a factor
data$chr <- as.factor(data$chr)

# Randomly sample a fraction of your data to reduce the number of points
set.seed(123)  # for reproducibility
trimmed <- data %>%
  filter(value > 0.5) %>%
  sample_frac(size = 0.5)  # adjust this value to get the desired number of points

output_file <- paste(RUNNAME,".pdf", sep="")
thres<-as.numeric(THRESHOLD)
topQ<-thres*100
threshold <- quantile(x=data$value, probs = thres)
title_msg <- paste(RUNNAME, "\nthreshold=",formatC(threshold, format = "f", digits = 2))

# Create the plot
g <- ggplot(trimmed, aes(x=pos, y=value)) +
  geom_point(aes(color=chr), alpha=0.5, size=0.5) +
  scale_color_manual(values=c("blue2", "darkorange1")) +
  geom_segment(aes(xend = max(pos)), y = threshold, yend = threshold, color="red", linetype=2) +
  labs(title = title_msg, x = paste("Position on", RUNNAME), y = expression(mu ~ "statistic")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face="bold"),
        legend.position="none",
        axis.line.x = element_blank(),
        axis.line.y = element_blank()) +
  geom_segment(aes(xend = max(pos)), y = 0, yend = 0, color = "black") +
  geom_segment(aes(yend = max(value)), x = 0, xend = 0, color = "black")

# Save the plot
ggsave(output_file, g, width = 7, height = 7)
