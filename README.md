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

## 1. LIN28a binding location on mRNA for integral membrane protein
### Step 1. Extract GTF lines corresponding to mRNA for integral membrane protein
Extract mRNA parts from GTF for the genes that coding integral membrane proteins.
Protein localization data from https://hyeshik.qbio.io/binfo/mouselocalization-20210507.txt.
1. Extract lines with "protein_coding" and without "processed_transcript"-> **protein_coding.gtf**
2. One transcript(and its exon, CDS, UTR) for each gene. Ignore alternative splicing. -> **one_transcript_for_each_gene.gtf**
3. Only the transcript, CDS, and UTR lines for integral membrane gene are extracted and stored separately for each gene. -> **./integral_membrane_gtf**
---

### Step 2. Get LIN28a binding coordinates on mRNA. 
*CLIP-35L33G.bam* has coordinates on genome, but binding distribution on mRNA is needed.
1. Extract alignments of integral membrane genes from 'CLIP-35L33G.bam' file -> **./analysis/bam-for-membrane-genes** and **extract-BAM.sh**
2. Prepare mpileup for each "protein_coding" gene. 
3. Extract lines of CDS and UTR range.
4. Concatenate CDS and UTR so that their coordiates are continuous.
5. Make each mpileup result start from 1.
6. Devide the coordinates by the total length of mRNA. 

---
- 하나의 유전자는 하나의 x 값을 가져야한다. -> It is hard to distribution of LIN28a with a single number -> Cluster genes according to LIN28a binding pattern and observe the correlation between the cluster and Ribosome densitity change.

- 하나의 유전자의 여러곳에 CLIP tag가 있다. -> Use the distribution of CLIP tag of each gene.


- 유전자마다 길이가 다르다. -> normalize the distribution by the length of genes.


1. gencode.gtf에서 ER-Associated gene들만 추려내기. intron은 안 해도 된다.
  - ER associated (GO:0016021 U GO:0005576 U GO:0009986 U GO:0005794 U GO:0005783 - GO:0031966)
  - 또는 https://hyeshik.qbio.io/binfo/mouselocalization-20210507.txt 의 데이터 사용
2. CLIP-35L33G.bam 중에서 1.에서 추려낸 유전자에 해당하는 alignment만 추려내기 -> ./bash_script/extract-BAM.sh
3. pile-up each BAM files to easily see the mapping distribution. -> ./bash_script/pile-up.sh
4. 2.에서 추려낸 alignment를 1.의 유전자별로 나누기.
5. 3.에서 얻은 유전자별 CLIP-tag들을 종합하여 LIN28a가 주로 달라붙는 위치 구하기. -> 

### 2. LIN28a가 주로 달라붙는 위치가 유전자 별로 차이가 있는지 확인하기. -> Check whether meaningful clusters are generated or not.
- 만약 차이가 없으면 중단. 

### 3. Ribosome density change upon *LIN28a* knockdown 구하기.
Figure4 A,D 를 참고하여 진행한다. -> Check if the average ribosome density change varies from cluster to cluster.

# Scripts
### extract-BAM.sh
- INPUT
  1. GTF file with only 'gene'
  2. BAM file
- OUTPUT: BAM files for each gene (ensembl_ID.bam)

It extract alignments of each gene and store them separately. 

---
### pileup-multiple-BAM.sh
- INPUT: a list of BAM files
- OUTPUT: pileup file for each BAM file

It excutes 'mpileup' for each file in the provided list.

---
### remove_intron_from_pileup.sh
- INPUT: a list of pileup files
- OUTPUT: pileup files without '>' or '<' in fifth field.

> and < are originated from mapping to intron. So those are removed.
---
### extract-ensembl-membrane-gene.sh
---
### extract_GTF.sh
---
### extract-gtf-using-ensembl.sh
---
### extract_pileup.sh
---
### generate_CLIP_mRNA_table.sh
---
### normalize_length.sh
---
### one_transcript_per_gene.sh
---
### only_CDS+UTR.sh
---
### pileup-multiple-BAM.sh
---
### remove_intron_from_pileup.sh
---
### remove_intron_from_pileup_single.sh
---
### reverse_strand.sh
---
### sort_gtf_by_start_pos.sh
---
### sum_by_interval.sh
---
