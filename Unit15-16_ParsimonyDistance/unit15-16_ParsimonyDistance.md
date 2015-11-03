## Unit 15 - Parsimony



When using parsimony, of all solutions preference is given to the least complicated.  Lately, the usage of parsimony seems to have been replaced with the more complicated Bayesian and maximum likelihood methodologies.  As such this represents a very cursory overview of the capabilities of the methodology.  



Available programs

 - ```MEGA6```

 - ```PHYLIP```

 - ```PAUP*``` - [**[beta link](http://people.sc.fsu.edu/~dswofford/paup_test/)**]

    **P**hylogenetic **A**nalyses **U**sing **P**arsimony (\*and other methods) - one of the most complex programs implementing parsimony.  There are both CL and GUI implementations.  The backbone of ```PAUP*``` is the NEXUS file format.

    

#### NEXUS blocks

PAUP* uses a NEXUS file that is organized into predetermined blocks of code.  If the program 

Begins with #NEXUS

Blocks categorize information that can be read/ignored by other programs

semicolons designate the end of a command

The PAUP* manual is your friend





Available blocks in PAUP*

 - ```TAXA```– defines taxa

 - ```CHARACTERS```– character matrix

 - ```ASSUMPTIONS```– assumptions about your data

 - ```SETS```– character sets/partitions

 - ```TREES```– stores (information about) trees

 - ```CODONS```– defines codons

 - ```DISTANCES```– distance matrices

 - ```PAUP```– commands specific to PAUP*



Example

```
#NEXUS

[anything in brackets is a comment]

BEGIN TAXA;

	<commands...>;

END;

BEGIN CHARACTERS;

	<commands...>;

END;

BEGIN PAUP;

	<commands...>;

END;

BEGIN NONEXISTENTPROGRAM;

	<commands...>;

END;

```



I organize my #NEXUS block into discrete sections

 - The basics

 - Prepping data

 - Finding a tree

 - Analyzing the tree



Finding trees in PAUP*

 - ```ALLTREES``` - exhaustive
 - ```BANDB``` - exhaustive
 - ```HSEARCH``` - multiple heuristic methods.

We will be doing **very** basic analyses in PAUP* for today...and only through the GUI.

1) Download [PAUP*](http://people.sc.fsu.edu/~dswofford/paup_test/) and today's test data(1) Download PAUP* and today's [test data](https://www.dropbox.com/s/zjwok7u2vj0ne04/testData.nexus?dl=0). Then launch ```PAUP*``` and open the test data.

We are going to generate 3 different trees (exhaustive search, heuristic search, & bootstrapped). 

2) Set your analysis to ```parsimony``` and the run an ```Exhaustive search```.  What happens?  Why?

You can run an exhaustive search by removing unnecessary taxa through ```Data``` > ```Delete/Restore Taxa```. Re-run your analysis.

3) Generate a tree on the full dataset using a ```heuristic search```.  Make sure your parameters are reasonable and you know what each means.  Ex. ```Sequence addition```, ```branch swapping```, ```starting tree```.
After generating the tree, use the output to:
 - identify the number of informative characters
 - score of the best tree
 - how many trees have that score
 - The consistency, homoplasy, & retention indices.

Be aware of the fact that the resulting tree(s) is the most parsimonious, but to determine confidence in individual nodes we need to bootstrap the tree.

4) To bootstrap the tree go to ```Analysis```>```Bootstrap/Jackknife```.  Bootstrap the tree using options similar to your heuristic search and for 25 replicates.  If you were doing this analysis on real data, you would want to bootstrap the data a minimum of 1K times.

5.  Everything we have done in the GUI can be done through the command line (via the #NEXUS file).  An example is given below.


```
BEGIN PAUP;

	[setting up the parsimony run]
	set criterion=parsimony;
	set storebrlens=yes;
	set increase=auto;
	
	[rooting the data]
	set root=outgroup;
	outgroup Neotoma_bryanti_AF307835.1;
	
	[bootstrapping the data for 25 replicates]	
 	bootstrap nreps=10 search=heuristic/ addseq=random nreps=10 swap=tbr hold=1;
	
	[save tree to a file]
	savetrees from=1 to=1 file=cytb_2015-11-01.nex format=altnex brlens=yes savebootp=NodeLabels MaxDecimals=0;

END;	
```


**********


## Unit 16 - Distance

Since we are wanting to spend more time on maximum likelihood and Bayesian methods, we will only go over distance analyses in the most cursory way.  
1) Download the [test data](https://www.dropbox.com/s/ezingyif0s99zsx/testData.fas?dl=0), which is the same you used for parsimony except in fasta format.  Load it in ```MEGA6```.  The data is from Cytb (a vertebrate, mitochondrial, protein-coding gene
2) Build a Neighbor-joining tree.  ```Phylogeny```>```Construct/Test Neighbor-Joining Tree```. You are asked what model to use....which one should we choose. 
4) Bootstrap the data for 1K replicates.

You probably noticed that the tree was built much more quickly.  NJ trees are ideal for very large datasets.  They are less likely to give you the "best" tree, but are often times good approximations.  Frequently, you will build a NJ tree that serves as a starting tree for other analyses.

******
Updated 11:30AM, 3 Nov 2015

rnp