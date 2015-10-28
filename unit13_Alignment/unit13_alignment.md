## Unit 13 - Databases and Alignments


**Sequence Alignment** - a hypothesis regarding the relationship between individual nucleotide positions.  To make sure and drive it home...homology, homology, homology, homology, homology.
There are three (major) methods for generating a sequence alignment.  We will discuss and use one of each today:

First, lets make a folder and download a test dataset for today:
	
```
mkdir ~/systUnit13
cd ~/systUnit13

wget -O testData.fas https://www.dropbox.com/s/3zpnojcpeajpnxn/adhPero_2014-01-31.fas?dl=0
```
The data is also avilable [here](https://www.dropbox.com/s/3zpnojcpeajpnxn/adhPero_2014-01-31.fas?dl=0).

***********
### Progressive Alignment

**```clustal```** - common progressive alignment program that has been updated as ```clustalw2``` and ```clustalo``` (clustal omega). Each program can be run on the command line, ```clustalX``` is a GUI.

As with many programs there are several clustal servers available.  These are nice since since they offer some sort of GUI and are implemented on someone elses computer.  However, often your alignments will take longer since they will have to sit in a queue.  
	[http://www.genome.jp/tools/clustalw/](http://www.genome.jp/tools/clustalw/)
	
We have several versions of clustal on Hrothgar.  They are located here:
``` /lustre/work/apps/tcoffee/Version_11/plugins/linux ```

So to call clustalw you would need to call the program via

``` /lustre/work/apps/tcoffee/Version_11/plugins/linux/clustalw ```

Can you see where this would be tedious...giving an absolute path for every program we want to run?  Lets make a habit of adding each of the programs we use to our system path.

```export PATH=/lustre/work/apps/tcoffee/Version_11/plugins/linux:$PATH```

Now you should be able to call clustalw simply by entering 

```clustalw``` or ```clustalw2```

Lets compute our first alignments using clustalw2

```clustalw2 testData.fas```

You will end up with 2 new files:
* ```testData.aln``` - alignment file (phylip format)
* ```testData.dnd``` - tree file

You should have also noticed the two "phases" of the alignment, (Phase 1) pairwise alignment & (Phase 2) multiple alignment.  What is occuring during each of these phases?  How does this relate to the .dnd file that was generated.

It is nice that clustalw2 ran easily using a simple command.  What if we want to alter some of the parameters.  You can do this through the command line (see the **[manual](http://www.clustal.org/download/clustalw_help.txt)**) or interactivley.

Generate a second alignment, but play with some of the alignment parameters.  Make them absurd..ex Gap Open Penalty = 100.  Compare alignment 1 and 2.  How do they differ?  Which is better?  It would be nice to have a way to score confidence in an alignment (hint). Generate a total of three alignments with various penalties/parameters. Make sure and save each alignment as a different file name. 

For example:
```
clustalw2 -infile=testData.fas -outfile=testData_clustalw2.fas -type=DNA -output=FASTA
clustalw2 -infile=testData.fas -outfile=testData_go100_ge5_clustalw2.fas -type=DNA -output=FASTA -gapopen=100 -gapext=5
clustalw2 -infile=testData.fas -outfile=testData_go0_ge50_clustalw2.fas -type=DNA -output=FASTA -gapopen=0 -gapext=50
```

For timesake, we cannot discuss running ```clustalo``` (omega).  Here is the **[manual](http://computing.bio.cam.ac.uk/local/doc/clustalo.txt)**.  Have it available in case you have any questions in the future.  The important thing to know about ```clustalo``` is that it is both a progressive and iterative aligner.

***********
### Iterative Alignments

The second major category of aligners are iterative aligners.  Here we will discuss ```muscle```. Like most programs with ```muscle``` you can call the command line options just by calling the program.

```muscle```

Simple enough.  Align your data with ```muscle```.

```muscle -in testData.fas -out testData_muscle.fas```

Each iteration in Muscle does soemthing different
* Iteration 1 – kmer clustering, progressive alignment via tree
* Iteration 2 – distance matrix, re-estimate tree, repeat until convergence
* Iteration 3+ - tree dependent refinement

There are several options, most won't be used on a regular basis.  Some to take note of are:
	

* ```-stable``` - preserve sequence input order
* ```-refine``` – skip first two iterations, requires aligned file
* ```-maxiters``` – set max iterations
* ```-maxhours``` – set max hours
* ```-maxtrees``` – set max trees
* ```-tree1``` – save tree from iteration 1 to <file>
* ```-tree2``` – save tree from iteration 2 to <file>
* ```-weight1``` – use weights <x> in iteration 1
* ```-weight2``` – use wieghts <x> in iteration 2

Usually the default optiosn will work well.  For very large alignments I'll often limit the number of itertions or hours ```muscle``` will run.

Check out the ```muscle``` and ```clustal``` alignments.  Is there a discernable difference.  Is it obvious/large...?

***********
### Consistency

Consistency methods take advantage of intermediate information.  For example an pairwise alignments of seq1 and seq2 and from seq2 and seq 3 may indicate an alignment for seq 1 and seq3 that is not the same as a pairwise alignment of seq 1 and 3.

tcoffee is a very complex CL program ([with a very nice server](http://tcoffee.crg.cat/)) that aligns sequences using consistency methods).  There are several, very powerful options that can be used within ```t_coffee```.  If you are working with difficult alignments, this may be a program you want to consider.  

Probably the most powerful "mode" in ```t_coffee``` is the meta coffee mode which combines progressive alignments from ```clustalw```, ```t_cofee```, ```poa```, ```muslce```, ```mafft```, ```dialignt```, ```pcma```, and ```probcons```.  Specific alignment methods can be specified with ```-method```.
```
t_coffee -n_core 1 -in testData.fas -mode mcoffee -output=fasta -outfile=testData_tcoffee.fas
```
Anther helpful tool is to merge multiple sequence alignments (for example alignments with various combinations of gap penalties).  Try mergine the alignments you generated with clustalw2 using tcoffee.  For me this would look like
```
t_coffee -n_core 1 testData.fas -aln testData_go0_ge50_clustalw2.fas testData_go100_ge5_clustalw2.fas testData_clustalw2.fas -output fasta -outfile=testData_mergedClustalw2.fas
```
A few other useful functions built into ```t_coffee``` include:

Aligning a new sequence to a pre-existing alignment

```bash
#get some new data
wget -O testData_1newSeq.fas https://www.dropbox.com/s/zyrzwvnig5a463g/testData_1newSeq.fas?dl=0
```

```
tcoffee testData_1newSeq.fas -profile testData_tcoffee.fas -outfile=comb1TestData.fas -output fasta
```
***********
### Confidence
Within tcoffee every alignment gets a consistency score.  This score is given in certain output types, but you can specify it with the ```-output=html```

```
t_coffee -infile=testData_go0_ge50_clustalw2.fas -output=html,score_ascii -outfile=testData_CONS
```

This will generate a ```.html``` file that contains your alignment, with each position color coded based on the local consistency score.  This is great.  It tells us how much confidence we can place in specific nucleotides in out data set.  In general anything over 80 is considered very good. The ```ascii``` file contains the same information but in asci format (imagine that).

So what makes this result powerful is that we can use it to improve the confidence in our overall alignment.  Said another way, we can uses the results to get weight positions based on how confident we are in the alignment.  This can be done by removing/masking positions low confidence positions and convinentley enough ```t_coffee``` does this.  We don't have time to go over it today, but be aware of it and try to work on it in your spare time.

***********
### Indels
Indels contain phylogenetic information but are not “visible” to many phylogenetic programs.
We can code them using a presence/abscence binary matrix and then use them in for phylogenetic inference.  Be aware there are several methods for coding indels (ex. simple vs. complex).  

The ```relINDEL``` program replicates an alignment several times,  codes, and then scores indels based on their frequency in all alignments.  ```relINDEL``` can be run locally or on their [server](http://guidance.tau.ac.il/RELINDEL/).

 ```
relindel/relindel.pl --seqFile testData.fas --msaProgram MUSCLE --seqType nuc --outDir relindel  --bootstraps 10  --proc_num 1 --MaskStartEndIndels --indelCutoff 0.5 
 ```   
The output is going ot go to ```./relindel/```.  Tthere are a large number of files generated, but check out the ```.html```.  It shows you the position and frequency of each indel in your "consensus" alignment.  Indels are coded in the ```CODED``` files.  If you were doing this for real, you would probably increase ```--bootstraps``` to 10,000. 

Keep in mind that by coding indels we are increasing the available phylogenetic information contained in our alignment.   
    
 ***********   
    
    
Updated: 7:45 AM - 28 Oct 2015

Molecular Systematics Zool6505
    
    
    
    
    
    
    
    
