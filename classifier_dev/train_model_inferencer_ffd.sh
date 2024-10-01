#!/bin/bash
set -e     #needed to ignore errors

d='/Users/mlafleur/Projects/FFDClassy'   #root path
c='cl_ffd'                        #classifier training data subdirectory
w='ffd-exclude-words.txt'			#stop words file
n='10'                          #number of topics 

cd "${d}" && \
rm "${d}"/classifier_dev/sources/"${c}"/.DS_Store || true   #Clean up on Mac. We ignore any errors here

#Import data
mallet import-dir --input "${d}"/classifier_dev/sources/"${c}"/  --output "${d}"/classifier_dev/results/"${c}".mallet --keep-sequence --remove-stopwords --extra-stopwords "${d}"/workshop/"${w}" --keep-sequence-bigrams --gram-sizes 1,2 

#Train topic model
mallet train-topics --input "${d}"/classifier_dev/results/"${c}".mallet --output-state "${d}"/classifier_dev/state/"${c}"-state.gz --output-doc-topics "${d}"/classifier_dev/topics/"${c}"-topics.txt  --output-topic-keys "${d}"/classifier_dev/topics/"${c}"-keys.txt --num-top-words 30 --topic-word-weights-file "${d}"/classifier_dev/topics/"topic-weights.txt" --word-topic-counts-file "${d}"/classifier_dev/topics/"topic-counts.txt" --diagnostics-file "${d}"/classifier_dev/topics/"diagnostics.xml" --xml-topic-report "${d}"/classifier_dev/topics/"topic-report.xml" --xml-topic-phrase-report "${d}"/classifier_dev/topics/"phrase-report.xml"  --optimize-interval 10 --num-topics ${n} --output-model "${d}"/classifier_dev/results/"${c}"-model --evaluator-filename "${d}"/evaluator/"${c}"-evaluator.mallet

#Use model to create inferencer
mallet train-topics --input-model "${d}"/classifier_dev/results/"${c}"-model --inferencer-filename "${d}"/classifier_dev/results/"${c}"-inferencer.mallet --num-iterations 0  

echo ""${c}"FFD classifier and inferencer created in "${d}"/classifier_dev/results/"
