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

#Adjust the upper axis to bring it in centre
library(tidyverse)
library(reshape2)
library(ggplot2)

# Create the dataframe
df1 <- data.frame(
  a = c(397, 682, 506, 0.6),
  b = c(608, 435, 542, 1.4),
  c = c(619, 421, 545, 1.5),
  d = c(512, 522, 551, 0.98),
  row.names = c("A", "B", "C", "D")
)

# Reset the row names
df2 <- df1 %>%
  tibble::rownames_to_column("index")

# Reshape the dataframe
df2 <- melt(df2, id.vars = "index", variable.name = "name", value.name = "value")

# Apply the transformations
df3 <- df2 %>%
  mutate(value = ifelse(index == "D", value * 100, value - (value * 2)))

# Plot the data
ggplot(df3, aes(x = name, y = value)) +
  #geom_col(data = df2 %>% filter(index != "D"), aes(fill = index), width = 0.2) +#for stack bar plot
  geom_col(data = df3 %>% filter(index != "D"), aes(fill = index), width = 0.4,position = "dodge") +
  #geom_col(data = df2 %>% filter(index != "D"), aes(fill = index), position = position_dodge(width = 0.2)) +
  geom_col(data = df3 %>% filter(index == "D"), color = "yellow", width = 0.3, alpha = 0.5, size = 1) +
  #geom_col(data = df2 %>% filter(index == "D"), aes(fill = index), position = position_dodge(width = 0.2)) +
  geom_hline(yintercept = 100, linetype = "dashed", color = "red") +  # Adding horizontal line at y = 1
  scale_y_continuous(
    breaks = c(100 * c(2, 1.5, 1), 0, -200, -400, -600, -800),
    labels = c(2, 1.5, 1, 0, 200, 400, 600, 800)
  )  +
  theme_minimal()


