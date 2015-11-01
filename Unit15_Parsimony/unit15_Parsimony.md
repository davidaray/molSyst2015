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
 - ALLTREES - exhaustive
 - BANDB - exhuastive
 - HSEARCH - multiple heurisitic methods.
