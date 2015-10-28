## Unit 14 - Substitution Models


First put the following information at the bottom of your .bashrc.

```
########################################################
# systematics paths/aliases
#########################################################
export PATH=/lustre/work/apps/tcoffee/Version_11/plugins/linux:$PATH                     
export PATH=/lustre/work/apps/tcoffee/Version_11/bin/t_coffee:$PATH
export PATH=/lustre/work/daray/software/muscle/muscle:$PATH
alias relindel.pl="/lustre/work/apps/relindel.v1.0/programs/relindel/relindel.pl"
```

Now make sure you have the following programs installed.
* MEGA6 ([link](http://www.megasoftware.net/megabeta.php))
* jMoldetest ([link](http://www.megasoftware.net/megabeta.php))([link for class use](https://www.dropbox.com/sh/kceo0u7371hawf9/AAAdLwV_hGzvju7kG0kDHkija?dl=0))
* BioEdit ([link](http://www.mbio.ncsu.edu/Bioedit/bioedit.html))

And here is today's data ([link](https://www.dropbox.com/s/ioca0lsyades5eg/bar1ML_aln.fas?dl=0)).  Save it as ```bar1ML_aln.fas```)

Everything we do in this unit will be on your local computer.
***********

### Models

1) Calculate the number of substitutions in a pairwise alignment of the bar1ML_aln.fas data

2) Calculate the precent of substitutions in a pairwise alignment of teh bar1ML_aln.fas data.

3) What is the difference between pairwise, partial, and complete deletion?

4) Calculate the substitution **matrix** for the data using the Jukes-Cantor model.  This is the most simplistic substitution model.  How does this compare with your data.  Look at it.  Also, take note of the likelihood score.

5) Recalculate the substitution matrix for the data using the most parameter rich model available (GTR+I+G).  Note the likelihood score.

5) Recalculate the substitution matrix for the data using the remaiing models.  Note the likelihood score.  

6) Using something like Excel, make a graph showing the change in likelihood score for each model (put the models in order of parameter richness).  Notice a trend?

7) Now go back and compute the overall mean distance using JC69 K80 HKY and GTR.  

*You should notice that the model really does affect the distance. At a certain point adding parameters does appreciably alter your distance values*

*How do we choose which model is best in a statistically justifiable way?*

 ***********   
### Model Choice    
 
 9) Use ```MEGA6``` to test for the best fit model. Which is it?  How does this compare with your graph of likelihood scores? How many models were tested.
 10) Use ```jModelTest``` to choose the best-fit model.  Run this with minimal substitution schemes.  How many models were tested?  How many models are available to be tested? 
 
 
 *```jModelTest``` can test >1,600 models.  Most downstream phylogenetic programs cannot use most of those. Other programs like ```partitionFinder``` can limit the models tested to thos capable of being implemented in major phylogenetic programs.*
 
*********** 
Updated: 9:00 PM - 25 Oct 2015

Molecular Systematics Zool6505
    
    
    
    
    
    
    
    