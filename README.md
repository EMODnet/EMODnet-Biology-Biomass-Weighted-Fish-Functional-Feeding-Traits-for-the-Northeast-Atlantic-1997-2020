# Biomass-Weighted Fish Functional Feeding Traits for the Northeast Atlantic (1997-2020)

## Introduction

International efforts to assess the status of marine ecosystems have been hampered by insufficient observations of food web interactions across many species, their various life stages, and geographic ranges. We use a recently published fish stomach contents database for the Northeast Atlantic to infer functional feeding traits for fish species across a range of sizes observed in survey data from the Northeast Atlantic shelf seas. This synthesis of feeding and biomass information can be used to reveal spatial and temporal changes in ecosystem structure and functioning.

## Directory structure

```
EMODnet-Biology-Biomass-Weighted-Fish-Functional-Feeding-Traits-for-the-Northeast-Atlantic-1997-2020/
├── analysis
├── data/
│   ├── derived_data/
│   └── raw_data/
├── docs/
├── product/
└── scripts/
```

* **analysis** - Markdown or Jupyter notebooks
* **data** - Raw and derived data
* **docs** - Rendered reports
* **product** - Output product files
* **scripts** - Reusable code

## Data series

We draw on a fish stomach content data collation spanning the North Atlantic shelf seas, with important contributions from the Baltic, Barents and Norwegian Seas in the Arctic Ocean (Thompson et al., 2024)https://doi.org/10.14466/CefasDataHub.149). This collation contains observations from 944,129 fish stomachs collected between 1836 – 2020, representing 14,196 unique interactions between 227 predator species and 2158 prey taxa. These data were sourced from a combination of previously published and unpublished data including DAPSTOM (Pinnegar, 2019), ICES Year of the Stomach (Daan, 1981; ICES, 1997), the Northeast US continental shelf (Smith & Link, 2010), Northern Spanish shelf (Arroyo et al., 2017), Gulf of Cadiz (Torres et al., 2013), Swedish-, Icelandic-, Norwegian, French- (Cachera et al., 2017; Timmerman et al., 2020; Travers-Trolet, 2017; Verin, 2018) and German-led surveys (e.g., FishNet, https://www.nationalpark-wattenmeer.de/wissensbeitrag/fishnet/; BioConsult, 2023).
Data for the biomass of fish species and size classes are available from multiple surveys using the ICES database of trawl surveys (DATRAS) once quality-controlled and standardised following procedures detailed in Greenstreet and Moriarty (2017). We use the otter trawl survey data for the Northeast Atlantic shelf seas collected between 1997–2020 originally published on DATRAS but processed by Lynam & Ribeiro (2022). Catch records by taxonomic group and by size class (length categories) in terms of biomass and numbers of fish standardised to the area swept by the haul.
To demonstrate how biomass-weighted axis scores were generated, we provide some example survey data from the Greater North Sea collected for the International Otter Trawl Survey Quarter 1 between January to March in 2020 (‘example_survey_data.csv’). We provide taxonomic information for the survey data (‘trawl survey taxa.csv’) needed to append the feeding trait data. We also provide a link to the published feeding guild data (‘feeding guilds.csv’; https://data.cefas.co.uk/view/21771).

Data description
File = ‘example_survey_data.csv’;
FileName = name of file downloaded from: https://data.cefas.co.uk/view/21421 (Lynam & Ribeiro, 2022) where a full description of the data can be found;
HaulID = unique haul identifier;
FishLength_cm = fish length in cm;
DensBiom_kg_Sqkm = biomass in kg wet weight per km2;
DensAbund_N_Sqkm = abundance per km2;
SciName = scientific name of observed taxa;
year = the year the sample was collected;
SweptArea_KM2 = swept area sampled in km2;
Gear = survey gear used;
Ship = ship used;
Month = the month the sample was collected;
Day = the day the sample was collected;
TimeShot = the time the sample was collected;
longitude = sample location in decimal degrees longitude;
latitude = sample location in decimal degrees latitude;
DensAbund_N_perhr = abundance per unit effort (in hours);
DensBiom_kg_perhr = biomass in kg wet weight per unit effort (in hours);
Survey_Acronym = survey acronym;
ices_rectangle  = ICES statistical rectangle;
family = organism family;
species = organism species; 
bin_number = 20 equal size bins to categorise individual predator mass along a log10 transformed gradient from 0.1 micrograms to 190 tonnes.

File = ‘trawl survey taxa.csv’;
taxa = organism taxa;
worms_aphia_id = worms aphia identifier (see https://www.marinespecies.org/aphia.php?p=webservice); 
functional_group = adult functional group of organism following Webb & Vanhoorne (2020) using the “worrms” package (Chamberlain, 2019);
phylum = organism phylum;
class = organism class;
order = organism order;
family = organism family;
genus = organism genus; 
species = organism species;
revised_taxa = updated taxonomy; 
LWRa = a values for length-weight calculation;
LWRb = b values for length-weight calculation;
LWRSource = source of a and b values for length-weight calculation.


## Data product

This product is the result of collating and analysing fish stomach contents data from the North Atlantic and Arctic Oceans to classify fish into functional feeding guilds based on their diet. Non-metric multidimensional scaling (NMDS) analysis was used to provide information on the differences between fish species and size class feeding traits in relation to one-another. The NMDS analysis presents axis scores that offer a more nuanced perspective compared to categorical data (i.e. feeding guilds), of different predator feeding traits. In general terms, higher NMDS1 values = increasing predation on zooplankton; lower NMDS1 values = increasing predation on benthos; higher NMDS2 values = increasing predation on fish (and larger prey); lower NMDS2 values = smaller prey (more benthos and or plankton). This analysis is part of the process to classify feeding guilds based on predator stomach contents data. See figure S4 in https://essd.copernicus.org/preprints/essd-2024-102/essd-2024-102-supplement.pdf from (Thompson et al., 2024) for a pictorial depiction. Data collation and analyses were supported via: the Euromarine foresight workshop EFIMBA; the European Union’s Horizon 2020 Research and Innovation Programme under grant agreements 869300 "FutureMARES" and 101060072 "ACTNOW"; the Natural Environment Research Council grant NE/V017039/1; and Cefas Seedcorn ‘Next generation Cefas biodiversity science: from individuals to ecosystems’ (DP433).

## More information:

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at: http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

### References

Arroyo, N. L., Preciado, I., López-López, L., Muñoz, I., & Punzón, A. (2017). Trophic mechanisms underlying bentho-demersal community recovery in the north-east Atlantic. Journal of Applied Ecology, 54(6), 1957–1967. https://doi.org/10.1111/1365-2664.12879
BioConsult. (2023). Nahrungsnetzprojekt in den Küstengewässern Schleswig Holsteins mit Fokus auf Fischen – FishNet. Untersuchung und Auswertung zum Mageninhalt und Analyse stabiler Isotope von Benthos- und Fischarten im Rahmen des FishNet Projektes (AP2). Auftraggeber: Landesbetrieb für Küstenschutz, Nationalpark und Meeresschutz Schleswig-Holstein, Nationalparkverwaltung (LKN.SH), 70 S
Cachera, M., Ernande, B., Villanueva, M. C., & Lefebvre, S. (2017). Individual diet variation in a marine fish assemblage: Optimal Foraging Theory, Niche Variation Hypothesis and functional identity. Journal of Sea Research, 120, 60–71. https://doi.org/https://doi.org/10.1016/j.seares.2016.08.004
Chamberlain, S. (2019). worrms: World Register of Marine Species (WoRMS) Client (R package version 0.4.0.).
Daan, N. (1981). Data base report of the stomach sampling project 1981. ICES Cooperative Research Report, Vol. 164. 150 pp.
Greenstreet, S. P. R., & Moriarty, M. (2017). OSPAR Interim Assessment 2017 Fish Indicator Data Manual (Relating to Version 2 of the Groundfish Survey Monitoring and Assessment Data Product). Scottish Marine and Freshwater Science Vol 8 No 17, 83pp. DOI: 10.7489/1985-1
ICES. (1997). Database report of the stomach sampling project, 1991. ICES Cooperative Research Report, Vol. 219. 426 pp. https://doi.org/https://doi.org/10.17895/ices.pub.4626
Lynam, C. P., & Ribeiro, J. (2022). A data product derived from Northeast Atlantic groundfish data from scientific trawl surveys 1983-2020. https://doi.org/https://doi.org/10.14466/CefasDataHub.126
Smith, B. E., & Link, J. S. J. (2010). The Trophic Dynamics of 50 Finfish and 2 Squid Species on the Northeast US Continental Shelf. U.S. Dep. Commer. NOAA Technical Memorandum, NMFS-NE-21(May), 1–29.
Thompson, M. S. A., Preciado, I., Maioli, F., Bartolino, V., Belgrano, A., Casini, M., Cresson, P., Eriksen, E., Hernandez-Milian, G., Jónsdóttir, I. G., Neuenfeldt, S., Pinnegar, J. F., Ragnarsson, S., Schueckel, S., Schueckel, U., Smith, B. E., Torres, M. Á., Webb, T. J., & Lynam, C. P. (2024). Fish functional groups of the North Atlantic and Arctic Oceans. Earth Syst. Sci. Data Discuss., 2024, 1–29. https://doi.org/10.5194/essd-2024-102
Thompson, M. S. A., Preciado, I., Maioli, F., Bartolino, V., Belgrano, A., Casini, M., Cresson, P., Eriksen, E., Hernandez-Milian, G., Jónsdóttir, I. G., Neuenfeldt, S., Pinnegar, J. K., Ragnarsson, S., Schückel, S., Schückel, U., Smith, B. E., Torres, M. Á., Webb, T. J., & Lynam, C. P. (2024). Modelled and observed fish feeding traits for the North Atlantic and Arctic Oceans (1836-2020) and population estimates of fish with different feeding traits from Northeast Atlantic scientific trawl surveys (1997-2020). Cefas, UK. V1. doi: https://doi.org/10.14466/CefasDataHub.149
Timmerman, C.-A., Marchal, P., Denamiel, M., Couvreur, C., & Cresson, P. (2020). Seasonal and ontogenetic variation of whiting diet in the Eastern English Channel and the Southern North Sea. PLOS ONE, 15(9), e0239436-. https://doi.org/10.1371/journal.pone.0239436
Torres, M. Á., Coll, M., Heymans, J. J., Christensen, V., & Sobrino, I. (2013). Food-web structure of and fishing impacts on the Gulf of Cadiz ecosystem (South-western Spain). Ecological Modelling, 265, 26–44. https://doi.org/10.1016/j.ecolmodel.2013.05.019
Travers-Trolet, M. (2017). CGFS2017 cruise, RV Thalassa.
Verin, Y. (2018). IBTS 2018 cruise, RV Thalassa.
Webb, T. J., & Vanhoorne, B. (2020). Linking dimensions of data on global marine animal diversity: Dimensions of global marine diversity. Philosophical Transactions of the Royal Society B: Biological Sciences, 375(1814), 20190445. https://doi.org/10.1098/rstb.2019.0445rstb20190445

### Code and methodology

[link_code](https://github.com/MurraySAThompson/EMODnet-Biology-Biomass-Weighted-Fish-Functional-Feeding-Traits-for-the-Northeast-Atlantic-1997-2020/blob/master/scripts/Estimating%20Biomass-Weighted%20Fish%20Functional%20Feeding%20Traits.R)

### Citation and download link

This product should be cited as:

Thompson, M.S.A. & Collingridge, K. (2025). Biomass-Weighted Fish Functional Feeding Traits for the Northeast Atlantic (1997-2020). Integrated data products created under the European Marine Observation Data Network (EMODnet) Biology project CINEA/EMFAF/2022/3.5.2/SI2.895681, funded by the European Union under Regulation (EU) No 508/2014 of the European Parliament and of the Council of 15 May 2014 on the European Maritime and Fisheries Fund.

Available to download in:

Data: https://erddap.emodnet.eu/erddap/files/biology_9774_06d4_3b77_34fa/fish_functional_traits.nc

Metadata: https://emodnet.ec.europa.eu/geonetwork/srv/eng/catalog.search#/metadata/6d617269-6e65-696e-666f-000000008774

EMODnet Viewer: is https://emodnet.ec.europa.eu/geoviewer/?layers=6d617269-6e65-696e-666f-000000008774:1:1&basemap=ebwbl&active=14162&bounds=-3951182.3440919546,5054282.709174126,2779203.24873914,9296761.440409869&filters=&projection=EPSG:3857


### Authors

Murray S.A. Thompson and Kate Collingridge
