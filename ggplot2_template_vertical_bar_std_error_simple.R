# ggplot2_template_vertical_bar_std_error_simple.R

library(tidyverse)

# Reproducible example based on a Pistachio Board Navel Orangeworm 
# project from 2021
dataf <- data.frame(Load = c("Low","High"),
                    Eggs = c(6.7,22.1),
                    sem = c(2,5.4))

# Force order that these categorical variables are shown on the graph
dataf$Load <- factor(dataf$Load, levels = c("Low","High"))

# Basic plot set-up
p1 <- ggplot(dataf, aes(x = Load, y = Eggs)) +
  geom_col(fill = "grey70") + 
  # Use a fill color lighter than the default
  geom_errorbar(aes(ymin = Eggs - sem, ymax = Eggs + sem), width = 0.25, color = "black") +
  # Limit width of error bar whiskers and ensure their color
  
  # I usually prefer a white background to a gray background
  theme_bw() +
  
  # Set labels for  X and Y axis rather than use program-friendly variable names
  xlab("Pistachio load") +
  ylab("Eggs per bag") +
  
  # Set a variety of parameters to ensure descent final appearence
  theme(axis.text.x = element_text(color = "black", size = 9), #angle = 45, hjust = 1),
        axis.text.y = element_text(color = "black", size = 9),
        axis.title.x = element_text(color = "black", size = 9),
        axis.title.y = element_text(color = "black", size = 9),
        legend.title = element_text(color = "black", size = 14),
        legend.text = element_text(color = "black", size = 14))

p1

# ggsave--the final version is not determined until size and density are specified
ggsave(filename = "ggplot2_template_vertical_bar_std_error_simple.jpg", p1,
       path = "../Desktop", 
       # path is obviously specific to the user and computer
       # unless you are working on RStudio projects and/or w version control
       width = 2.83, height = 2.83, dpi = 300, units = "in", device='jpg')
