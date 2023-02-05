<!-- omit in toc -->
# Run CMU Festvox Indic Frontend for Grapheme-to-Phoneme Conversion
Repository containing information and scripts to use the Festvox Indic Frontend to create phonemic pronunciations.

I have created this repository so that you can avoid facing the same issues that I did in getting to run the indic frontend. The purpose of the scripts in this repo is mainly to export lexicon to use outside of festvox. 

Currently the approach given in the repo is applicable only for Ubuntu. I have tested it on Ubuntu 22.04.

<!-- omit in toc -->
## Table of Contents
- [Festvox Indic Frontend](#festvox-indic-frontend)
  - [Scheme](#scheme)
- [Installing Festival](#installing-festival)
- [Create Lexcion](#create-lexcion)
  - [Steps to run `build_dict.sh`:](#steps-to-run-build_dictsh)
- [Files from Indic frontend](#files-from-indic-frontend)
- [Disclaimer and Contributions](#disclaimer-and-contributions)


## Festvox Indic Frontend
The indic frontend in [festvox](https://github.com/festvox/festvox) is a Grapheme-to-Phoneme Conversion system for some of the Indian languages, originally created for the [festival](https://github.com/festvox/festival) speech synthesis system. It is useful for creating lexicons for ASR systems as well. Example of ASR usage: lexicon for kaldi baseline in [Interspeech 2018 Special Session challenge](https://www.microsoft.com/en-us/research/event/interspeech-2018-special-session-low-resource-speech-recognition-challenge-indian-languages/).

- [Indic Frontend Code Folder](https://github.com/festvox/festvox/tree/master/src/vox_files/indic) in festvox
- [Paper](http://www.cs.cmu.edu/~awb/papers/LREC16_parlikar.pdf)

### Scheme
The frontend uses the [Scheme programming language](https://en.wikipedia.org/wiki/Scheme_(programming_language)) which is a dialect of LISP. People might find it difficult to started with this but actually its syntax is pretty simple and minimal. I have to admit it was daunting for me as well at first. Don't let the parentheses scare you!
- [More information and references](http://www.festvox.org/docs/manual-1.4.3/festival_8.html#SEC21) from festvox

## Installing Festival
In order to run the Indic Frontend, I have tried my best to install festvox and its dependencies on Ubuntu (22.04), but couldn't manage to get it right even after multiple attempts. Through [this blog post](https://nicolasbouliane.com/blog/install-festival-text-speech-ubuntu), I found that festival has a package that you can install through `apt`. 
- $ `sudo apt-get install festival festvox-kallpc16k`

There is probably a better way to do it but I found the above to be the fastest and simplest way to setup and install festival.

## Create Lexcion
The major challenge is to adapt the frontend code, in a way that you can use it independently. I have discovered that the simplest way to accomplish this is to use `festival` itself to run a script using `--script` option, mainly due to the intricacies of the scheme variant and libraries used in festival. 

[build_dict.sh](/build_dict.sh) is used to generate pronunciations from words in a file 
- The output is printed to stdout. Use redirection to write to file. Format of output is kaldi-like lexicon file with the tab as the delimiter between the words and the pronunciation.
- The input file for the script can be
  - just a list of words (one word in one line)
  - a kaldi-like lexicon file with the tab as the delimiter between the words and the pronunciation.

For example inputs, we use [te_sample.txt](/te_sample.txt) and [ta_sample.txt](/ta_sample.txt), files of 100 telugu and tamil words respectively. List of all languages supported by the indic frontend are [presented here](http://festvox.org/bsv/x3528.html).

### Steps to run `build_dict.sh`:
- Clone this repo $ `git clone https://github.com/ma08/run_cmu_indic && cd run_cmu_indic`
-  Run the script: $ `./build_dict.sh <lang_code> <input file>`
   -  Telugu Example:  $ `./build_dict.sh 'te' te_sample.txt`
   -  Telugu Example (write to file): $ `./build_dict.sh 'te' te_sample.txt > te_out.dict`
   -  Tamil example: $ `./build_dict.sh 'ta' ta_sample.txt`

## Files from Indic frontend
I have adapted the original [indic_lexicon.scm](https://github.com/festvox/festvox/blob/master/src/vox_files/indic/indic_lexicon.scm) to make it usable for the `build_dict.sh` script. To see the changes with respect to the original, you can check the diff file, [indic_lexicon.diff](/indic_lexicon.diff).

Other files which are used by indic_lexicon that are included in the repo (no changes) from festvox are:
- [indic_utf8_ord_map.scm](/indic_utf8_ord_map.scm) (festvox [link to riginal file](https://github.com/festvox/festvox/blob/master/src/vox_files/indic/indic_utf8_ord_map.scm))
- [unicode_sampa_map_new.scm](/unicode_sampa_map_new.scm) (festvox [link to original file](https://github.com/festvox/festvox/blob/master/src/vox_files/indic/unicode_sampa_map_new.scm))


## Disclaimer and Contributions
Obviously, everything here is kind of a hack that I found just to get it running. No correctness or efficiency guaranteed!

Let me know if you find a better way to accomplish the same through issues/PRs. It might be the case that that the relevant scheme files from festival/festvox will be sufficient to run without needing to install it.