# IlluminaHumanMethylationEPICv2manifest, forked from mwsill

```bash
# install LaTeX for R
sudo apt -y install texlive-latex-recommended texlive-latex-extra

# install devtools dependencies (R4.3.0 obtained from CRAN on ubuntu 20)
sudo apt -y install libharfbuzz-dev libfribidi-dev libfontconfig1-dev libtiff-dev

## R compilation dependencies (https://github.com/Jiefei-Wang/Painless-R-compilation-and-installation-on-Ubuntu)
# gcc-multilib not avaiable for ARM 
sudo apt-get -y install gcc-multilib
sudo apt-get -y install build-essential fort77 xorg-dev liblzma-dev libblas-dev gfortran gobjc++ aptitude libreadline-dev libbz2-dev libpcre2-dev libcurl4 libcurl4-openssl-dev default-jre default-jdk openjdk-8-jdk openjdk-8-jre  texinfo texlive texlive-fonts-extra -y libssl-dev -y libxml2-dev 

## GenoGAM dependencies
sudo apt-get -y install libjpeg-dev wkhtmltopdf xorg-dev libreadline-dev pandoc r-markdown
```
## Installation of current minfi package from bioconductor, then install the EPIC v2 variant from mwsill over it
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("minfi","minfiData","minfiDataEPIC","conumee"))

install.packages("devtools")
library(devtools)
install_github("neuropathbasel/IlluminaHumanMethylationEPICv2manifest") 
install_github("neuropathbasel/minfi")
```
## Download demo idat files from Illumina.
https://support.illumina.com/array/array_kits/infinium-methylationepic-beadchip-kit/downloads.html
(link under "Product Files")

```r
# Read one of the demo datasets provided by Illumina Inc. to test the installation
# Demonstration code to unify EPIC v2 with EPIC v1 and 450K Illumina Infinium Methylation Microarrays (v2/v1/450k overlap set)
library(devtools)
library(minfi)
library(minfiData)
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
library(IlluminaHumanMethylation450kmanifest)

bn <- "./idat/206891110005_R02C01"
message("read.metharray")
RGset <- read.metharray(basenames=bn)
Mset <- preprocessSWAN(RGset)
Mset450k <- convertArray(Mset,"IlluminaHumanMethylation450k") # rgSet conversion seems to result in different numbers of elements
mappedRgSet <- mapToGenome(Mset450k)
singleBetas <- getBeta(mappedRgSet) # calculate beta values (return value)
print(singleBetas)
print(nrow(singleBetas))
