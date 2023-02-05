#==========================================
#Title:  build_dict.sh
#Author: Sourya Kakarla
#
#Takes the language code and input file as arguments
#Writes kaldi style lexicon output to stdout
#==========================================

lang=$1 #'ta' (tamil),'te' (telugu), 'gu' (gujarati) etc.
input_file=$2
while read p; do
  word=$(echo "$p" | awk '{print $1}')
  festival --script get_pron.scm $lang $word | sed 's/[()]//g'
done < $input_file