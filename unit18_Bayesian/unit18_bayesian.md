### Unit 18 Bayesian Phylogenetics

download and install tracer on your computer [[LINK](http://tree.bio.ed.ac.uk/software/tracer/)]


qlogin with 1 processor




```
mkdir ~/unit18
cd ~/unit18
```


Download the data
```
wget -O primates_alnMuscle.nex https://www.dropbox.com/s/zvdjtg8al6jrl17/primates_alnMuscle.nex?dl=0
```

We are using the same primate data from last week (1 *Cyt*b sequence per genus for all (available) primates).  The only difference is the data has been structured according to the nexus format.  The file now looks like this:
```
#NEXUS

begin data;
    dimensions nchar=1140 ntax=50;
    format missing=? gap=- matchchar=. datatype=DNA;
    matrix
        Allocebus_trichotis.AY441461            ATGACCAACATTCGAAAAATCCACCCCTTAATAAAAG...
        Alouatta_belzebul.AY374353.2            ATGACTACCCCCCGCAAAACACACCCACTAGCAAAAA...
        Aotus_azarai.DQ098863                   ATGACTTCNCCCCGCAAAACACACCCACTAGCAAAGA...
        Arctocebus_calabarensis.AY441474        ATGACAATTATACGAAAACAACACCCATTAGCAAAAA...
        ...
        <break>
        ...
         Varecia_variegata.AF081047             ATGACTAACACCCGAAAAAACCACCCTCTAATAAAAA...
        Tupaia_belangeri.EU531776               ATGACCAACATACGAAAAAACCACCCATTACTAAAGA...
        ;
end;
```

A nexus file always begins with ```#NEXUS``` and data is organised in blocks.  Here all of the sequence data is given in a single ```data``` block.  The ```data``` block begins with ```begin data;``` and ends with ```end;```.  It is further broken down into specific commands that end with a ```;```.  For example.  The ```dimensions``` command has two options ```nchar``` and ```ntax```.  The ```format``` command has options for ```missing``` data, ```gap``` coding, ```matchchar``` (matching character) coding, and ```datatype```.  All of the sequences are in the ```matrix``` section that ends with the ```;``` after the last seqeunce.



I absolutely **DESPISE** entiring commands directly into ```mrbayes```.  I keep two windows (or panels...if you are cool and use tmux) open to work with MrBayes.  Open another window.  You do not need to qlogin for this additional window.

```
cd unit18
nano primates_alnMuscle.nex
```

Now you can edit your file in this window while running it in the other.


**2) Running ```mrbayes```**

```
mpirun -np 1 mb
```

Execute your data within ```mrbayes```: 
```
execute primates_alnMuscle.nex
``` 
This loads our sequence data into ```mrbayes```.  So how to build a tree?.  
```
help
```

This gives us all of the commands that are available in ```mrbayes```.  Look through them.  If you need parameter options for each command then type ```help <command```.  For example, to find out about the Monte-Carlo Markov Chain parameters you could use:

```
MrBayes > help mcmcp

   ---------------------------------------------------------------------------   
   Mcmcp                                                                         
                                                                                 
   This command sets the parameters of the Markov chain Monte Carlo (MCMC)       
   analysis without actually starting the chain. This command is identical       
   in all respects to Mcmc, except that the analysis will not start after        
   this command is issued. For more details on the options, check the help       
   menu for Mcmc.
                                                                                 
   Parameter       Options               Current Setting                         
   -----------------------------------------------------                         
   Ngen            <number>              1000000                                      
   Nruns           <number>              2                                      
   Nchains         <number>              4                                      
   Temp            <number>              0.100000                                     
   Reweight        <number>,<number>     0.00 v 0.00 ^                       
   Swapfreq        <number>              1                                      
   Nswaps          <number>              1                                      
   Samplefreq      <number>              500                                      
   Printfreq       <number>              1000                                      
   Printall        Yes/No                Yes                                      
   Printmax        <number>              8                                      
   Mcmcdiagn       Yes/No                Yes                                      
   Diagnfreq       <number>              5000                                      
   Diagnstat       Avgstddev/Maxstddev   Avgstddev                                     
   Minpartfreq     <number>              0.10                                 
   Allchains       Yes/No                No                                     
   Allcomps        Yes/No                No                                     
   Relburnin       Yes/No                Yes                                     
   Burnin          <number>              0                                     
   Burninfrac      <number>              0.25                                 
   Stoprule        Yes/No                No                                     
   Stopval         <number>              0.05                                 
   Savetrees       Yes/No                No                                     
   Checkpoint      Yes/No                Yes                                     
   Checkfreq       <number>              2000                                     
   Filename        <name>                primates_alnMuscle.nex.<p/t>
   Startparams     Current/Reset         Current                                     
   Starttree       Current/Random/       Current                                     
                   Parsimony                                                    
   Nperts          <number>              0                                     
   Data            Yes/No                Yes                                     
   Ordertaxa       Yes/No                No                                     
   Append          Yes/No                No                                     
   Autotune        Yes/No                Yes                                     
   Tunefreq        <number>              100                                     
                                                                                
   ---------------------------------------------------------------------------   
```
From this help menu not only do you get an idea of parameters, but you can find out what the default/current settings are.  In this case, we would run two independent mcmc runs with 1M generations and four chains sampling every 500 generations.

To change a parameter:
```
mcmcp nruns=1
```
Now set the bayes run to
```
mcmcp ngen=10000 samplefreq=100 printfreq=1000 filename=primates_10K-100s-1r-4c.bayes
```
Now execute the MCMC run.
```
mcmc
```
This should run in less than 5 minutes.  While its running we can discuss what is actually going on and what all of the output means.

```
<...>
The MCMC sampler will use the following moves:
      With prob.  Chain will use move
         0.98 %   Dirichlet(Pi)
         0.98 %   Slider(Pi)
         9.80 %   ExtSPR(Tau,V)
         9.80 %   ExtTBR(Tau,V)
         9.80 %   NNI(Tau,V)
         9.80 %   ParsSPR(Tau,V)
        39.22 %   Multiplier(V)
        13.73 %   Nodeslider(V)
         5.88 %   TLMultiplier(V)
<...>
Chain results (100000 generations requested):
 0 -- [-47508.809] (-46388.062) (-46133.286) (-46633.652) (...0 remote chains...) 
 5000 -- [-28952.864] (-28977.447) (-28943.149) (-28960.214) (...0 remote chains...) -- 0:01:16
 10000 -- (-28976.122) [-28958.717] (-28961.856) (-28962.195) (...0 remote chains...) -- 0:01:12
 15000 -- (-28964.889) (-28947.323) (-28959.086) [-28970.997] (...0 remote chains...) -- 0:01:13
 20000 -- (-28952.999) (-28968.473) [-28949.931] (-28970.990) (...0 remote chains...) -- 0:01:08
<...>
```
Other terms to be aware of:
 - chains (hot vs. cold)
 - swap
 - temp/heating
 - runs
 
So this has generated ```ngens``` / ```samplefreq``` trees that have been saved into the ```primates_100K-100s-1r-4c.bayes.t``` and parameters have been saved in ```primates_100K-100s-1r-4c.bayes.p```.

Lets look at the distribution of our data. Download the ```primates_100K-100s-1r-4c.bayes.p``` file and open it in ```Tracer```.no

Here we can see if our data reached stationarity wihtin the ranges of our MCMC parameters.  You can really see the importance of setting an approporiate burnin here.

Tracer demonstration

Based on the tracer visualizaiton, we know that we need to burnin the first trees and ultimatley increase the number sampled.  We will increase our sampling in a bit, but for know we just want to know what our tree looks like...but we generated more than 1K.  All trees can be summarized via the following:

```
sumt 
```

Why did we not include a burnin when summing the trees?

The files that were generated include 

- ```primates_10K-100s-1r-4c.bayes.vstat``` - length information
- ```primates_10K-100s-1r-4c.bayes.trprobs``` - topologies in order of posterior probability
- ```primates_10K-100s-1r-4c.bayes.parts``` - partition frequencies (of the consensus tree)
- ```primates_10K-100s-1r-4c.bayes.con.tre``` - consensus tree.

The model parameteres and tree stats can be summarized using:
```
sump
```
In this version of ```mrbayes``` there is a lot of overlap in the information generated here and with Tracer.

Files generated are:
 - ```primates_10K-100s-1r-4c.bayes.pstat``` - model parameter statistics
 - ```primates_10K-100s-1r-4c.bayes.lstat``` - likelihood statistics



To this point you have given ```mrbayes``` commands via the CLI.  It is much easier to add the commands to a ```mrbayes``` block in your nexus file.  Lets re-run the analysis using a ```mrbayes``` block while adding some new commands.

Add the following to the end of the ```primate_muscleAln.nex```. 

```
begin mrbayes;
		
        [set outgroup]
		outgroup Tupaia_belangeri.EU531776;
        
        [designate character sets]
        charset cytbPos1 = 1-1140\3;
        charset cytbPos2 = 2-1140\3;
        charset cytbPos3 = 3-1140\3;
        
        [combine character sets into partitions]
        partition cytbFull = 2: cytbPos1 cytbPos2, cytbPos3;
        
        [set parameters of the likelihood model]
        lset applyto=(1,2) nst=6 rates=invgamma;
		unlink shape=(all), revmat=(all), statefreq=(all), shape=(all), 
        	   pinvar=(all), brlens=(all), topology=(all);
        
        [set priors on parameters]
        prset applyto=(2)
			revmatpr=fixed(0.6604,9.7015,0.6585,2.3585,23.9207,1.0000)
			statefreqpr=fixed(0.2822,0.1483,0.2659,0.3036)
			pinvarpr=fixed(0.3060)
			shapepr=exponential(1.6090);

        
        [set parameters of the monte-carlo markov chain]
        mcmcp ngen=1000000 nruns=2 samplefreq=100 printfreq=1000;
        
        [being the search]
        mcmc;

		[summarize trees and parameters]
        sumt contype=allcompat;
        sump;

end;
```

While this is running think about the following questions:
1) How many chains are being run?
2) How many total trees are being sampled?
3) How many trees are being summarized?
4) Some people are hesitant to use Bayesian probablilities?  What argument(s) could you make against Bayesian phylogenetics.


Open the one of the parameter files in Tracer.  Look at the ESSs.  They dropped.  Why?  Did this run reach stationarity? How many more samples would you guess we need? Generations?

How would a real ```mrbayes``` run look?  I normally run 4-8 runs of 4 chains with 10M generations, sampling every 100-1K.  What advantages is there to



inkscape


scaling up
```
mpirun -np 16 mb
```
