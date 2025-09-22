library(tidyverse)
library(readxl)
library(tidyr)
library(stringr)
library(VIM)
library(purrr)

setwd("SETPATH")

#IMPUTATION OF LOGFC_SD at PRE ONLY
set.seed(123)
PRE<-raw_merge %>%
  filter(Timepoints == "PRE") 
pre_imp <- kNN(PRE, variable = "logFC_SD", k = 5)
summary(pre_imp)
pre_imp$logFC_SD_status <- ifelse(pre_imp$logFC_SD_imp == 1, "Imputed", "Observed")

ggplot(pre_imp, aes(x = logFC_SD_status, y = logFC_SD)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Imputed vs Observed logFC_SD (PRE Timepoints)",
       x = "Value Type", y = "logFC_SD") +
  theme_minimal()

ggplot(pre_imp, aes(x = logFC_SD, fill = logFC_SD_status)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density of logFC_SD (PRE)", fill = "Imputed?") +
  theme_minimal()

summary(raw_merge)
raw_merge$logFC_SD[raw_merge$Timepoints == "PRE" & is.na(raw_merge$logFC_SD)] <- 
  pre_imp$logFC_SD_imp[is.na(PRE$logFC_SD)]

saveRDS(raw_merge, "XX/rds/miR_data_clean_imputed.rds")

