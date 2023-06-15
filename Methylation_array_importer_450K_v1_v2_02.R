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
