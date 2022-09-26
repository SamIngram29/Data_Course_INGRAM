library(tidyverse)
library(ggimage)
Ugly<- ToothGrowth
Uglyy<- Ugly %>% 
  ggplot(aes(x=supp, y=len,fill= supp)) +
  geom_jitter(color="red")+
  geom_area(color= "NA")+ geom_violin(color="white")+
  scale_fill_manual(values= c("#ffffff",
                        "#ffffff"))+
  theme_bw()+ theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank())+
labs(x="Vitamin C Supplement", y="Tooth Length", title = "Это сюжет про зубы бобра, но моя собака гораздо симпатичнее") +
  theme(axis.text.x = element_text(angle = 192.5, size=20, color="light grey"),axis.text.y = element_text(angle = 245.5, size = 20,
                                                                                      color="#f2f2f2"),
        axis.title = element_text(color= "#f2f2f2",size=6, angle=147,face="bold.italic"),
        legend.position = "bottom",legend.text = element_text(color = "#f2f2f2", face = "italic"),
        legend.title = element_text(color="light grey"),title = element_text(color= "#caff99"))+
   geom_bgimage(image = "./Assignments/Assignment_5/MASHA.PNG")

ggsave("./Assignments/Assignment_5/Ugly.png", Uglyy, width=10, height=5, dpi=300)
