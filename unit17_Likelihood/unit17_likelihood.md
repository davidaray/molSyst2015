### Unit 1 7 Likelihood
There are multiple programs that can build trees using likelihood and the list is constantly growing (```PaML```, ```RAxML```, ```PhyML```, ```MEGA6```, ```PAUP*```, ```bootPhyML```, ```Garli```, ...).  All analsyses for today will be conducted in RAxML.



**1] Prep.**

Here is the RAxML manual ([LINK](http://sco.h-its.org/exelixis/resource/download/NewManual.pdf))

Get an interactive session with 2 processors.

```qlogin -q phylo -pe fill 2 -P hrothgar```

We will work from the ```unit17``` directory
```
mkdir ~/unit17
cd ~/unit17
```

Download the data
```
wget -O primates_alnMuscle.fas https://www.dropbox.com/s/hs6vqras0ihg8d5/primates_alnMuscle.fas?dl=0 
wget -O primates_alnMuscle.phy https://www.dropbox.com/s/k1ukq9vnfie89jn/primates_alnMuscle.phy?dl=0
wget Model information ([jModelTest](LINK HERE))
```
**Links**
- Model information ([jModelTest PDF](https://www.dropbox.com/s/rfx99qu1xahmzow/primate_jModelTest.pdf?dl=0))
- FigTree ([LINK](http://tree.bio.ed.ac.uk/software/figtree/))

**2] Setting up RAxML**

We are going to build and bootstrap the ML trees in RAxML two different ways. The "better" way and then the "fast" way.

**"Better way"**

A typical RAxML command looks like this:

```
/lustre/work/apps/RAxML/raxmlHPC -m <model> -p <seedNumber> -s <alignment_file> -n <name>
```
Parameters
- ```-m``` - nucleodtide substitution model
- ```-p``` random seed number (to build inital trees from)
- ```-s``` alignment file in phylip format
- ```-n``` name designation for this run

Using our data - lets infer the ML tree

``` raxmlHPC -m GTRGAMMA -p 12345 -s primates_alnMuscle.phy -n singleInf```



This will build a GTR+G tree from a randomized stepwwise addtion parsiomny tree (using 12345 as the random number seed...increases replicability) from the alignment test.phy and all output is appended with the .short tag/name.



Your result files shoudl icnlude:
- ```RAxML_result.inital``` - trees resulting from the seach
- ```RAxML_parsimonyTree.inital``` - tree file of the starting parsimony tree)
- ```RAxML_log.initial``` - log file
- ```RAxML_info.inital``` - information on the job
- ```RAxML_bestTree.inital``` - tree file of the estimated ML tree.

RAxML saves files using a "RAxML_infoType.NameDesignation" format.

To view the tree.  Download it to your desktop and open it in FigTree.

So the previous analysis identified the best scoring ML tree from a single starting tree.  When I ran this analysis the score of my tree was -23947.871001, shown in the RAxML_info.inital file:

```
...
Inference[0] final GAMMA-based Likelihood: -23947.871001 tree written to file /home/roplatt/unit17/RAxML_result.inital
...
```

**3) Multiple inferences of the ML tree**


Now this tree was the ML tree created from a single starting tree. We can increase the number of searches by using the ```-#``` command

```
raxmlHPC -m GTRGAMMA -p 12345 -s primates_alnMuscle.phy -n infer10 -# 10
```

This command will calculate an ML tree from 10 random starting trees.


If you ```ls``` you will see that the log, result, and parsimony tree have been stored for each of our 10 searches, but the best tree has been stored in a single ```RAxML_bestTree.infer10``` file.  The ```RAxML_info.infer10``` contains information on the score and tree for the best.

Great.  **This gives us the best tree but doesn't tell us anything about how much confidence we should place in indivdual nodes within the tree**.  


**4) Bootstrapping the data**

Taking the best scoring tree from the prevous run, lets bootstrap it using the -b option.  When the -b option is present we are telling RAxML that we want to bootstrap our data.  The number immediatley after the ```-b``` is not the number of bootstrapping replicates.  Instead it is a random seed number.  The ```-#``` tells RAxML the number of boostrapping replicates.

```
raxmlHPC -m GTRGAMMA -p 12345 -b 98765 -s primates_alnMuscle.phy -n shortBoot -# 10
```

This command genetates 10 bootstrap relicates to the file RAxML_bootstrap.shortboot and these can be used to score clades (bipartitions) on the best tree from step X.

There there are a few new parameters:
- ```-f``` - type of anlaysis
- ```-t``` - starting tree
- ```-z``` - other trees (in this case boostrap replicates).

```
raxmlHPC -m GTRGAMMA -f b -t RAxML_bestTree.infer10 -z RAxML_bootstrap.shortBoot -n bootFinal
```

Several new files are generated.  The important one is ```RAxML_bipartitions.bootFinal```.  This has your best scoring tree with bipartition frequencies added.


Check out your tree in figTree.  A dialogue box will appear asking you to name the branch/label data. You can save this as "boostrap" or leave it the same.

To view the bipartition frequency
1) Check "Branch Labels"
2) Set the Display to "Label" or "Bootstrap"


**5) The "Fast" way**


So RAxML offers the ability to combine the ML search and the bootstrapping into a single step.  This "rapid bootstrapping" option can be invoked using:

```raxmlHPC -f a -m GTRGAMMA -p 12345 -x 98765 -s test.phy -n MLBoot -# 1000```

This will generate a ML tree and bootstrap it ```-#``` times (in this case 1K).  Notice the only diiference between this command and ones we used previously is ```-f a``` and ```-x```.



So there are a few other major things - outgroups, combined data, models that need to be discussed.

1) an outgroup can be set with ```-o```.
```
raxmlHPC -f a -m GTRGAMMA -p 12345 -x 98765 -s primates_alnMuscle.phy -n MLBoot -# 1000 -o Tupaia_belangeri#EU531776
```

2) GTR is pretty much the only model that is used

```-m GTRCAT, GTRCATI, GTRGAMMA, GTRGAMMAI```

3) When you are doing your actual analysis you can use more than 1 processor/thread with the -T option.
```
raxmlHPC -f a -m GTRGAMMA -p 12345 -x 98765 -s primates_alnMuscle.phy -n MLBoot -# 1000 -o Tupaia_belangeri#EU531776 -T 4
```
Its tempting to overdo the number of threads.  Don't. From the RAxML manual (pg 5):


>Thus, if you run RAxML with 32 instead of 1 thread this does not mean that it will automatically become 32 times faster, it may actually even become slower. As I already mentioned, the parallelefficiency, that is, with how many threads/cores you can still execute it efficiently in parallel depends on the alignment length, or to be more precise on the number of distinct patterns in your alignment. This number is printed by RAxML to the terminal and into the RAxML_info.runID fileand look like this:
Alignment has 70 distinct alignment patterns As a rule of thumb I'd use one core/thread per 500 DNA site patterns, i.e., if you have less, than it's probably better to just use the sequential version. Single-gene DNA alignments with around 1000 sites can be analyzed with 2 or at most 4 threads. Thus, the more patterns your alignment has, the more threads/cores you can use efficiently

4) You can partition your data into genes (or codons) using the -q option and passing a file of partition boundaries to RAxML. 

```
raxmlHPC -f a -m GTRGAMMA -p 12345 -x 98765 -s primates_alnMuscle.phy -n MLBoot -# 1000 -o Tupaia_belangeri#EU531776 -q primatePartions.txt
```
The primatePartions.txt file looks like this:
```
DNA, firstSecondPos = 1-1140\3, 2-1140\3
DNA, thirdPos = 3-1140\3
```

Spend sometime and scan through the RAxML manual.  There is a bunch of cool stuff in there where you can compare multiple trees, remove rogue taxa, bootstrap a sequence alignment.

For now, take some time and begin running the data for your final project through RAxML.


*****
rnp

10 Nov 2015












