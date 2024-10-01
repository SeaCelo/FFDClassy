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

## How to classify text documents using the FFDClassy model:
* Add text files (txt only, no pdf, no directories) to: /FFDClassy/classifier_dev/sources/cl_ffd/   
* Run the classification script "train_model_inferencer_ffd.sh"

```
./infer-scores.sh
```
* Results will be placed in /SDGclassy/target/output/SDG-scores-out.txt

### Alternative script:
* It may be desired to run the script multiple times on different data. Rather than moving the files in and out of the /input folder, use the alternative script "infer-scores2.sh".
* This script requires the user to specify the input and output location using this syntax:  `./infer-scores2.sh -i /path/to/inputs -o /path/to/output`

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

### How to use (with alternative method):
* Add text files (txt only, no pdf, no directories) to: /SDGclassy/target/input/   
* Run the classification script by right-clicking infer-scores.ps1 and selecting "Run with Powershell"
* Results will be placed in /SDGclassy/target/output/SDG-scores-out.txt

# Interpreting the Results of the file SDG-scores-out.txt
* topics in the file SDG-scores-out.txt are listed in order 0-18. Each topic maps to a specific SDG, with one topic as a filter to be ignored. The mapping between topics and SDGs is available in: /classifier/topic-sdg_mapping.csv
* Use the output in your favorite app (excel, etc) and analyze the results, using the topic-sdg mapping.
The results include a extra category that should be ignored. Because of this the remaining 17 scores do not add to 100. You may wish to re-compute the weights if this is important in your analysis.
		

# Other notes
* The instructions will download Mallet in the SDGclassy directory, but you may want to install it in another location.
* In this event adjust the script accordingly or add Mallet to the $PATH. This is left to you and your google. 

* Note: using ngrams may cause Mallet to run out of memory. If you have this problem, try giving 8gb to Mallet, letting the OS manage any paging and vm. 
* To do this, edit the binary. In Terminal: 
   * `cd /path/to/your/install/mallet-2.0.8/bin` 
   * `nano mallet` 
   * Find the line and edit to read: `MEMORY=8g`
