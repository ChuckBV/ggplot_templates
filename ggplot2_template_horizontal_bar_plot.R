# ggplot2_template_horizontal_bar_plot.R

library(tidyverse)

### construct data frame in script
release_methods <- data.frame(
  Type = c("Release Type","Release Type","Release Type","Transport Type","Transport Type"),
  Treatment = c("Paper bag","Drone","Bag + tube","Driven","Shipped"),
  Pct_recovery = c(0.6,0.85,1.45,1.35,0.85))
release_methods
    # Also can enter from Excel and use File > Import in RStudio

release <- release_methods %>% 
  filter(Type == "Release Type")

transport <- release_methods %>% 
  filter(Type == "Transport Type")

ggplot(release, aes(x = Treatment, y = Pct_recovery)) +
  geom_col() +
  coord_flip() +
  theme_bw()


p2 <- ggplot(transport, aes(x = Treatment, y = Pct_recovery)) +
  geom_col() +
  # Essential portion
  coord_flip() + # Y axis horizontal
  theme_bw() +
  ylim(0,1.5) + # Uniform chosen range
  
  # Rest is pure formatting
  
  xlab("") +
  ylab("Percent sterile males recovered") +
  theme(axis.text.x = element_text(color = "black", size = 12), #angle = 45, hjust = 1),
        axis.text.y = element_text(color = "black", size = 12),
        axis.title.x = element_text(color = "black", size = 12),
        axis.title.y = element_text(color = "black", size = 12),
        legend.title = element_text(color = "black", size = 12),
        legend.text = element_text(color = "black", size = 10))

p2

ggsave(filename = "horizontal_bar_y20_wilson_small_plot_recovery.jpg", 
       plot = p2, device = "jpg", 
       dpi = 300, width = 5.83, height = 2.83, units = "in") 
