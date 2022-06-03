# Term Project

## Data
- CLIP-35L33G.bam : RNA 상에서 LIN28이 달라 붙은 위치와 서열을 알려준다.
- gencode.gtf : GTF 파일이다.
- RNA-control.bam : 
- RNA-siLin28a.bam : LIN28a knockdown 후 RNA-seq
- RNA-siLuc.bam : Luc knockdown 후 RNA-seq
- RPF-siLin28a.bam : Ribosome-Protected mRNA Fragments
- RPF-siLuc.bam


# 1. LIN28이 ER-Associated mRNA에 달라붙는 위치에 따른 Ribosome density change upon *LIN28a* knockdown의 크기 분석.
## 개요
- LIN28이 붙는 위치가 LIN28이 mRNA의 번역을 억제하는 정도에 영항을 주는지 알아보기 위함이다. 
- 분석 결과는 scatter plot으로 나타낸다. 예를 들자면, Figure 3C와 같은 그래프에서 y축을 CLIP tag count에서 Ribosome density change upon *LIN28a* knockdown로 바꾼 그래프가 될 것이다.

## 기대효과
- LIN28이 붙는 위치에 따라서 번역 억제 정도가 다른 것을 확인하고, 번역 억제 기능이 적은/많은 위치를 알아낸다면 LIN28a가 기능하는 원리를 이해하는 데 힌트를 줄 수 있다.

## 분석 순서
유전자 별로 (x, y) 값을 얻어서 scatter plot으로 나타낼 것이다. x 값은 LIN28a가 주로 달라붙는 위치, y 값은 Ribosome density change upon *LIN28a* knockdown 이다.

### 1. LIN28a가 주로 달라붙는 위치 구하기.
- 하나의 유전자는 하나의 x 값을 가져야한다. -> It is hard to distribution of LIN28a with a single number -> Cluster genes according to LIN28a binding pattern and observe the correlation between the cluster and Ribosome densitity change.

- 하나의 유전자의 여러곳에 CLIP tag가 있다. -> Use the distribution of CLIP tag of each gene.


- 유전자마다 길이가 다르다. -> normalize the distribution by the length of genes.


1. gencode.gtf에서 ER-Associated gene들만 추려내기. intron은 안 해도 된다.
  - ER associated (GO:0016021 U GO:0005576 U GO:0009986 U GO:0005794 U GO:0005783 - GO:0031966)
  - 또는 https://hyeshik.qbio.io/binfo/mouselocalization-20210507.txt 의 데이터 사용
2. CLIP-35L33G.bam 중에서 1.에서 추려낸 유전자에 해당하는 alignment만 추려내기 -> ./bash_script/extract-BAM.sh
4. 2.에서 추려낸 alignment를 1.의 유전자별로 나누기.
5. 3.에서 얻은 유전자별 CLIP-tag들을 종합하여 LIN28a가 주로 달라붙는 위치 구하기. -> 

### 2. LIN28a가 주로 달라붙는 위치가 유전자 별로 차이가 있는지 확인하기.
- 만약 차이가 없으면 중단.

### 3. Ribosome density change upon *LIN28a* knockdown 구하기.
Figure4 A,D 를 참고하여 진행한다.

## Scripts
### extract-BAM.sh
- INPUT
  1. GTF file with only 'gene'
  2. BAM file
- OUTPUT: BAM files for each gene (ensembl_ID.bam)

It extract alignments of each gene and store them separately. 
