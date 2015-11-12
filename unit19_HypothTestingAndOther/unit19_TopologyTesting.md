### Unit 19 Hypothesis testing and other cool stuff

**1) Prep for the day.**

```
mkdir unit19
cd unit19
mkdir topTest
cd topTest
```

Get alignment 
```
wget -O cytbPero_2014-01-31.phy https://www.dropbox.com/s/3hn4ztl2jt4qhj8/cytbPero_2014-01-31.phy?dl=0
```
Get the constrained tree
```
wget -O stricto.const https://www.dropbox.com/s/ycr44vxy9ebye1q/stricto.const?dl=0
```


**2) Using RAxML generate the best tree from 10 starting trees (inferences).**
```
raxmlHPC -m GTRGAMMAI -p 12345 -s cytbPero_2014-01-31.phy -n infer10 -# 10
```

**3) Compare the best tree to the constrained tree in FigTree.***


**4) Build the best constrained (from 10 inferences)***

```
raxmlHPC -m GTRGAMMAI -p 12345 -s cytbPero_2014-01-31.phy -# 10 -g stricto.const -n stricto -m GTRGAMMAI
```

**5) We need to calculate site log likilihood scores for both trees form the alignment.**
```
cat RAxML_bestTree.stricto RAxML_bestTree.infer10 >trees.nwk
```

**6) Use the best tree to generate Site log-likelihood scores (SLL)**

```
raxmlHPC -f g -s cytbPero_2014-01-31.phy -m GTRGAMMAI -z trees.nwk -n SLL
```
```
...
Per-site Log Likelihoods written to File /home/roplatt/unit17/RAxML_perSiteLLs.SLL in Tree-Puzzle format
...
```

**7) now we have to get and install/compile consel**

```
wget http://www.sigmath.es.osaka-u.ac.jp/shimo-lab/prog/consel/pub/cnsls020.tgz
tar -xvf cnsls020.tgz
cd ~/unit19/topTest
cd consel
cd src
make
make install
make clean
cd ~/unit19/topTest
```
The above commands will download, and compile consel.  Don't be scared.  A lot of stuff will flash across the screen.

**8) Run consel.**

Consel takes the Site log-likelihood scores from each tree (generated from your data alignment) and replicates the data.  It then builds a distribution from which to test your actual data against.  To learn more check out this paper: **[Simodaira and Hasegawa (2000)](http://bioinformatics.oxfordjournals.org/content/17/12/1246.abstract)** 

Step A - replicate your data
```
./consel/bin/makermt --puzzle RAxML_perSiteLLs.SLL 
```
Step B - Calculate p-values
```
./consel/bin/consel RAxML_perSiteLLs
```
Step C - print p-values
```
./consel/bin/catpv -s 1 RAxML_perSiteLLs >pValTrees.consel
```
Your information is now stored in ```pValTrees.consel```.  To see it:

```cat pValtrees.consel```

My file looks like:


```
reading RAxML_perSiteLLs.pv
  rank item    obs     au     np |     bp     pp     kh     sh    wkh    wsh |
     2    1   54.0  0.003  0.003 |  0.003  3e-24  0.004  0.004  0.004  0.004 |
     1    2  -54.0  0.997  0.997 |  0.997  1.000  0.996  0.996  0.996  0.996 |
```

The trees are listed in the order of the input tree file.  In this case "item 1" is the constrained tree and "item two" is the unconstrained tree.  Across the board, the unconstrained tree is within the confidence set of our data, while the constrained tree is rejected.  Remember we aren't necessarily comparing these two trees to each other.  Instread we are comparing these trees to the best tree (given the data).  It just so happens that tree 2 (the unconstrained tree) is a close approximation of/if not the best tree.

*******************
rnp

12 nov 2015
