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
# demonstration code to unify EPIC v2 with EPIC v1 and 450K Illumina Infinium Methylation Microarrays
library(devtools)
library(minfi)

bn1 <- "/applications/epidip_demo_data/data/demo_idat/3998523002_R03C02" # 450k
bn2 <- "/applications/epidip_demo_data/data/demo_idat/201465930047_R03C01" # EPIC v1
bn3 <- "/applications/epidip_demo_data/data/demo_idat/206909630108_R04C01" # EPIC v2

bn <- c(bn1,bn2,bn3)

for (b in bn){
	message(b)
	message("read.metharray")
	RGset <- read.metharray(basenames=b)
	Mset <- preprocessSWAN(RGset)
	Mset450k <- convertArray(Mset,"IlluminaHumanMethylation450k")
	mappedRgSet <- mapToGenome(Mset450k)
	singleBetas <- getBeta(mappedRgSet)
	message(nrow(singleBetas))
}
```
Output will look like this, indicating significant differences in the number of overlapping probes between the three microarray types:
```
  /.../idat/3998523002_R03C02
  read.metharray
  Loading required package: IlluminaHumanMethylation450kmanifest
  Loading required package: IlluminaHumanMethylation450kanno.ilmn12.hg19
485512
  /.../idat/201465930047_R03C01
  read.metharray
  Loading required package: IlluminaHumanMethylationEPICmanifest
  [convertArray] Casting as IlluminaHumanMethylation450k
452832
  /.../idat/206909630108_R04C01
  read.metharray
  Loading required package: IlluminaHumanMethylationEPICv2manifest
  [convertArray] Casting as IlluminaHumanMethylation450k
394380

```
