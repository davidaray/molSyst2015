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



I ABSOLUTELY DESPISE ENTERING PARAMETERS THROUGH MRBAYES.  Open another window




```
mpirun -np 1 mb
```

enter parameters via nano/pico in a new window

```
begin mrbayes;
        mcmcp ngen=10000 nruns=1 samplefreq=100 printfreq=500;
        mcmc;
end;
```




build tree

look at stationarity (continue)

build tree more

look at stationarity




inkscape


scaling up
```
mpirun -np 16 mb
```