## Unit 15 - Parsimony



When using parsimony, of all solutions preference is given to the least complicated.  Lately, the usage of parsimony seems to have been replaced with the more complicated Bayesian and maximum likelihood methodologies.  As such this represents a very cursory overview of the capabilites of the methodology.  



Available programs

 - ```MEGA6```

 - ```PHYLIP```

 - ```PAUP*``` - [**[beta link](http://people.sc.fsu.edu/~dswofford/paup_test/)**]

    **P**hylogenetic **A**nalyses **U**sing **P**arsimony (\*and other methods) - one of the most complex programs implementing parsiomny.  There are both CL and GUI implementations.  The backbone of ```PAUP*``` is the NEXUS file format.

    

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



I orgranize my #NEXUS block into descrete sections

 - The basics

 - Prepping data

 - Finding a tree

 - Analyzing the tree



Finding trees in PAUP*

 - ```ALLTREES``` - exhaustive
 - ```BANDB``` - exhuastive
 - ```HSEARCH``` - multiple heurisitic methods.

We will be doing **very** basic analyses in PAUP* for today...and only through the GUI.

1) Download [PAUP*](http://people.sc.fsu.edu/~dswofford/paup_test/) and today's test data(1) Download PAUP* and today's [test data](https://www.dropbox.com/s/zjwok7u2vj0ne04/testData.nexus?dl=0). Then launch ```PAUP*``` and open the test data.

We are going to generate 3 different trees (exhaustive search, heursitic search, & bootstrapped). 

2) Set your analysis to ```parsimony``` and the run an ```Exhuastive search```.  What happens?  Why?

You can run an exhaustive search by removing unneccessary taxa through ```Data``` > ```Delete/Restore Taxa```. Re-run your analysis.

3) Generate a tree on the full dataset using a ```heursitic search```.  Make sure your parameters are reasonable and you know what each means.  Ex. ```Sequence addtion```, ```branch swapping```, ```starting tree```.
After generating the tree, use the output to:
 - identify the number of informative characters
 - score of the best tree
 - how many trees have that score
 - The consistency, homoplasy, & retention indecies.

Be aware of the fact that the resulting tree(s) is the most parsimonious, but to determine confidence in indivudual nodes we need to bootstrap the tree.

4) To bootstrap the tree go to ```Analysis```>```Bootstrap/Jacknife```.  Bootstrap the tree using options similar to your heuristic search and for 25 replicates.  If you were doing this analysis on real data, you would want to boostrap the data a minimum of 1K times.

5.  Everything we have done in the GUI can be done through the command line (via the #NEXUS file).  An example is given below.


```
BEGIN PAUP;

	[setting up the parsomony run]
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






