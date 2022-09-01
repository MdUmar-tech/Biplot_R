# Biplot_R
Mirror bar_plot using R
library(dplyr)
library(ggplot2)
library(tidyr)

df1 <- data.frame(
  a = c(397, 682, 506, 0.6),
  b = c(608, 435, 542, 1.4),
  c = c(619, 421, 545, 1.5),
  d = c(512, 522, 551, 0.98)
)
rownames(df1) <- c("A", "B", "C", "D")

df2 <- df1 %>% 
  tibble::rownames_to_column("variable")

df2 <- df2 %>%
  pivot_longer(-c("variable")) %>%
  mutate(value = case_when(
    variable != "D" ~ value - (value * 2),
    
    # scale col D so it can have different scaling than A-C
    variable == "D" ~ value * 100
  ))

ggplot(df2, aes(x = name, y = value, fill = variable)) +
  geom_col(position = "dodge") +
  scale_y_continuous(
    breaks = c(100 * c(2, 1.5, 1), 0, -200, -400, -600, -800),
    labels = c(2, 1.5, 1, 0, 200, 400, 600, 800)
  ) 
