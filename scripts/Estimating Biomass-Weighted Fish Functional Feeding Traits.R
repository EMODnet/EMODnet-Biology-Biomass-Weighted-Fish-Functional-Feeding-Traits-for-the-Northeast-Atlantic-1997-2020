# Estimating Biomass-Weighted Fish Functional Feeding Traits for the Northeast Atlantic (1997-2020). 
# Author: Murray SA Thompson
# Contact: murray.thompson@cefas.gov.uk
# Version: 1
# March 2025
# prepared for EMODnet


# rm(list=ls()); gc()

pkgs = c("tidyverse", "data.table", "vroom", "mapplots", "patchwork", "ggpubr") #
for(p in pkgs){
  if(!require(p, character.only = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
} 

### Here is how to load and pre-process all of the fish survey data downloaded from https://data.cefas.co.uk/view/21421
# trawl_survey_taxonomy.csv stored here: https://github.com/MurraySAThompson/Estimating-Biomass-Weighted-Fish-Functional-Feeding-Traits-for-the-Northeast-Atlantic-1997-2020/tree/master/data/derived_data
##txdf = read_csv(file='trawl_survey_taxonomy.csv')
#
# 
# # read all survey data txt files:
# list_of_files = list.files(
#   pattern = "\\.txt$", 
#   full.names = TRUE)
# 
# # Read all the files and create a FileName column to store filenames
# DT = rbindlist(sapply(list_of_files, fread, simplify = FALSE),
#                use.names = TRUE, fill=TRUE, idcol = "FileName")
# 
# alldf = DT %>% as_tibble() %>%
#   left_join(txdf, c('SciName'='taxa')) %>%
#   rename(taxa=new_taxa, year=Year, latitude=ShootLat_degdec, longitude=ShootLong_degdec) %>%
#   mutate(ices=ices.rect2(longitude, latitude),
#          # to iron out missing biomass info
#          ind_weight_g = exp(log(LWRa)+LWRb*log(FishLength_cm)),# \1000 to convert to kg
#          DensBiom_kg_Sqkm = case_when(is.na(DensBiom_kg_Sqkm) ~ (ind_weight_g/1000)*DensAbund_N_Sqkm,
#                                       TRUE ~ DensBiom_kg_Sqkm),
#          # add body mass bins
#          bin_num = case_when(ind_weight_g < 6.73e-8 ~ 1,
#                              ind_weight_g < 4.38e-7 ~ 2,
#                              ind_weight_g < 2.85e-6 ~ 3,
#                              ind_weight_g < 1.85e-5 ~ 4,
#                              ind_weight_g < 1.20e-4 ~ 5,
#                              ind_weight_g < 7.83e-4 ~ 6,
#                              ind_weight_g < 5.09e-3 ~ 7,
#                              ind_weight_g < 3.31e-2 ~ 8,
#                              ind_weight_g < 2.16e-1 ~ 9,
#                              ind_weight_g < 1.40e+0 ~ 10,
#                              ind_weight_g < 9.12e+0 ~ 11,
#                              ind_weight_g < 5.93e+1 ~ 12,
#                              ind_weight_g < 3.86e+2 ~ 13,
#                              ind_weight_g < 2.51e+3 ~ 14,
#                              ind_weight_g < 1.63e+4 ~ 15,
#                              ind_weight_g < 1.06e+5 ~ 16,
#                              ind_weight_g < 6.90e+5 ~ 17,
#                              ind_weight_g < 4.49e+6 ~ 18,
#                              ind_weight_g < 2.92e+7 ~ 19,
#                              ind_weight_g < 1.90e+8 ~ 20))
#
# save(alldf, file='combined_survey_data.R')

#################################################

# example for github
# example_survey_data.csv stored here: https://github.com/MurraySAThompson/Estimating-Biomass-Weighted-Fish-Functional-Feeding-Traits-for-the-Northeast-Atlantic-1997-2020/tree/master/data/derived_data
survey_df = read_csv('example_survey_data.csv')

# NMDS scores generated for this study: https://doi.org/10.5194/essd-2024-102
# Feeding guilds.csv published here: https://data.cefas.co.uk/view/21771
glds = read_csv('feeding guilds_24_03_25.csv')

# exploratory plots for % prey functional groups and prey size vs NMDS axis scores
par(mfrow=c(2,2))
plot(zooplankton~NMDS1, glds)
plot(benthos~NMDS1, glds)
plot(fish~NMDS2, glds)
plot(log10_prey_mass~NMDS2, glds)

# Higher NMDS1 values = increasing predation on zooplankton;
# lower NMDS1 values = increasing predation on benthos; 
# higher NMDS2 values = increasing predation on fish (and larger prey);
# lower NMDS2 values = smaller prey (more benthos and or plankton).

# select required columns
tbl = glds %>% 
  dplyr::select(taxa, bin_number, NMDS1, NMDS2) %>%
  arrange(taxa, bin_number)


# Gobiidae and Ammodytidae taxa resolved to species across different data:
go_am_tx = c("Pomatoschistus minutus",
             "Hyperoplus lanceolatus", 
             "Gobius niger", 
             "Gobiusculus flavescens", 
             "Gobius paganellus",
             "Ammodytes dubius",
             "Aphia minuta")

# select data to use - Otter trawls between 1997-2020 (github example uses only data from year 2020)
# GNSIntOT3 is subset because it overlaps spatially with GNSIntOT1, the latter is more comparable in timing with other surveys
otterdf = survey_df %>%
  filter(Gear == 'GOV',
         year %in% c(1997:2020), 
         !Survey_Acronym == 'GNSIntOT3',
         DensBiom_kg_Sqkm >0,
         !is.na(bin_number)) %>%
  distinct() %>%
  # resolve taxa, ready for integration with feeding guild information
  mutate(taxa = case_when(species %in% go_am_tx ~ species,
                          family == 'Gobiidae' ~ 'Gobiidae',
                          family == 'Ammodytidae' ~ 'Ammodytes',
                          TRUE ~ species)) %>% 
  left_join(tbl, c('bin_number', 'taxa')) 

# calculate biomass weighted mean axis scores
surv_wgts = otterdf %>%
  group_by(HaulID, Survey_Acronym, ices_rectangle, year) %>%
  summarise(b_nmds1 = weighted.mean(NMDS1, DensBiom_kg_Sqkm, na.rm=T),
            b_nmds2 = weighted.mean(NMDS2, DensBiom_kg_Sqkm, na.rm=T)) %>%
  pivot_longer(cols = -(HaulID:year),
               names_to = 'scrs',
               values_to = 'value') %>%
  separate(scrs, c('response', 'axes'), sep='_', remove=T) %>%
  pivot_wider(names_from = response,
              values_from = value)

##############################################################

# ices-level means for converting to NetCDF 
dat_to_plot = surv_wgts %>%
  group_by(ices_rectangle, year, axes) %>%
  summarise(av_bw_axis_scores=mean(b))


##############################################################
#### map plots

# extract ices.rect coordinates
coords = ices.rect(dat_to_plot$ices_rectangle)
dat_to_plot = cbind(ungroup(dat_to_plot), coords)

# set map limits with full dataset
xlims = range(dat_to_plot$lon)
ylims = range(dat_to_plot$lat)

# axes to plot
toplot = unique(dat_to_plot$axes)

# world shape
world_shp = sf::st_as_sf(maps::map("world", plot = FALSE, fill = TRUE))

##########
# spatial means

plot_list_b = list()
for(axs in unique(dat_to_plot$axes)){ 
  
  pltdat = subset(dat_to_plot, axes==axs & !is.na(av_bw_axis_scores)) 
  
  lims = range(0, max(pltdat$av_bw_axis_scores))
  
  p = pltdat %>% ggplot() +
    geom_tile(aes(x = lon, y = lat, fill = av_bw_axis_scores)) +
    viridis::scale_fill_viridis(name = '') +
    geom_sf(data = world_shp,
            fill = 'black',
            color = 'black',
            size = 0.1) +
    coord_sf(xlim = xlims, ylim = ylims)+
    labs(x='', y='', title=axs) +
    guides(fill = guide_colourbar(barwidth = 1)) +
    theme(panel.background = element_rect(fill = 'grey80'),
          panel.border = element_rect(colour='black', fill=NA),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank())
  plot_list_b[[axs]] = p
}

do.call(ggarrange, c(plot_list_b[toplot], align='hv', ncol=2, nrow=1)) %>%
  annotate_figure(fig.lab = 'Biomass-weighted axis scores in space', fig.lab.size = 14)
