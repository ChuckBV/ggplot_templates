#===========================================================================#
# ggplot2_template_horizontal_bar_plot.R
#
# Scripting for creating of a horizontal bar chart. 
#
#===========================================================================#

library(tidyverse)

### construct data frame in script

release_methods <- data.frame(
  Type = c("Release Type","Release Type","Release Type","Transport Type","Transport Type"),
  Treatment = c("Paper bag","Drone","Bag + tube","Driven","Shipped"),
  Pct_recovery = c(0.6,0.85,1.45,1.35,0.85))
release_methods
    # Also can enter from Excel and use File > Import in RStudio
    # Values here are interpoloated from a bar graph from Excel enncountered
    # in a PowerPoint deck by Houston Wilson. It reports small plot results for
    # 2020.

### Split into two data frames for separate graphs

release <- release_methods %>% 
  filter(Type == "Release Type")

transport <- release_methods %>% 
  filter(Type == "Transport Type")

### Create first plot
p1 <- ggplot(release, aes(x = Treatment, y = Pct_recovery)) +
  geom_col() +
  coord_flip() +
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

p1

ggsave(filename = "ggplot2_template_horizontal_bar_plot.jpg", 
       plot = p1, device = "jpg", 
       dpi = 300, width = 5.83, height = 2.83, units = "in") 


### Create second plot
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

ggsave(filename = "horizontal_bar_y20_wilson_small_plot_recovery_transport.jpg", 
       plot = p2, device = "jpg", 
       dpi = 300, width = 5.83, height = 2.83, units = "in") 

### Note that it was necessary to play with the sizes of the graphics in
### PowerPoint to get them to line up. The width includes the treatment names,
### which can vary.