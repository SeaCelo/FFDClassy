# FFDClassy
 Classification of texts using LDA topic model

This script is based on my work to classify publications for FFD. This tool provides a way to easily compute "scores" for individual or a collection of texts. Note that each category is defined by a collection of training texts from FFD publications 

To read the details of the methodology: "Art is long, life is short: An SDG Classification System for DESA Publications" (https://www.un.org/development/desa/publications/working-paper/wp159). 

If you desire to add more training data, the process of generating synthetic training data using the ChatGPT LLM is discussed in the paper "Using large language models to help train machine learning SDG classifiers" (https://desapublications.un.org/working-papers/using-large-language-models-help-train-machine-learning-sdg-classifiers.)

A word of caution: See the section on "Interpreting the results"

## Requires:
* Mallet 2.0.8 (http://mallet.cs.umass.edu)
* Text files to be classified (.txt)
* Convert your text files to .txt and clean them up as much as possible. The results will be better if you exclude non-relevant material (front matter, etc). 

### Tested on Mac OS X Big Sur, Windows and Linux:
* on Mac, Zsh shell is preferred, tough the code should run in older Bash shell (pre-Catalina). 
* On windows, bigrams command is broken. Need to apply this fix: https://github.com/mimno/Mallet/issues/151    

## Mac OS and UNIX Installation and use
* From the Terminal shell, cd into the location you would like to install
* clone the repository

```
git clone https://github.com/SeaCelo/FFDClassy.git FFDClassy
cd FFDClassy
chmod +x train_model_inferencer_ffd.sh
```
* Install Mallet
```
wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.zip
unzip mallet-2.0.8.zip
rm mallet-2.0.8.zip
```

## How to train the FFD classifer on a selection of representative texts:
* Add text files (txt only, no pdf, no directories) to: /FFDClassy/classifier_dev/sources/cl_ffd/   
* Run the classification script "train_model_inferencer_ffd.sh"

```
./train_model_inferencer_ffd.sh
```
* Results of the training will be placed in "/FFDClassy/classifier_dev/topics"


## How to classify (or "infer") text documents using the FFDClassy model:
* Add text files (txt only, no pdf, no directories) to any directory 
* Run the inference script "infer-scores2.sh" and specify the input and output directories:

```
./infer-scores2.sh -i /path/to/inputs -o /path/to/output
```
* Results of the classification will be placed in the "output" directory you speficied


## Windows Installation and use 
* [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* Open a Powershell window inside the location you would like to install
* Type `wsl` and follow the [Mac and UNIX installation steps and usage instructions](#mac-os-and-unix-installation-and-use)

### Alternatively:
* From Powershell, cd into the location you would like to install
* clone the repository

```
git clone https://github.com/SeaCelo/SDGclassy.git SDGclassy
cd SDGclassy
```
* Install Mallet

```
wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.zip -OutFile mallet-2.0.8.zip
unzip mallet-2.0.8.zip
rm mallet-2.0.8.zip
```

# Interpreting the Results 
* topics are listed in order 0-n (where "n" is the number of topics you specified). One topic serves as a "filter" and should be ignored. The mapping between topics and the desired themes should be done when the model is trained. It will change each time the training is done. Recommend to create a file that has the mapping. 
* Use the output in your favorite app (excel, etc) and analyze the results, using the mapping.
The results include a extra category that should be ignored. Because of this the remaining scores do not add to 100. You may wish to re-compute the weights if this is important in your analysis.
		

# Other notes
* The instructions will download Mallet in the SDGclassy directory, but you may want to install it in another location.
* In this event adjust the script accordingly or add Mallet to the $PATH. This is left to you and your google. 

* Note: using ngrams may cause Mallet to run out of memory. If you have this problem, try giving 8gb to Mallet, letting the OS manage any paging and vm. 
* To do this, edit the binary. In Terminal: 
   * `cd /path/to/your/install/mallet-2.0.8/bin` 
   * `nano mallet` 
   * Find the line and edit to read: `MEMORY=8g`
