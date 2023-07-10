#!/bin/bash
#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#~~~~~~~~~#
# GC Script
#
#This script can be used to anaylaze the GC percentage of your input fastqfiles
# Run with command:  
# $ sh BaseComposition.sh FILENAME.fastq  
#   
# Takes an input b, then runs through following pipe, whereby:  
# Awk takes every second line of 4 (i.e. sequence line) | Awk seperates each charcter into a new line | grep counts each character | wc counts each hit  
# Then feeds each base into it's own variable
ACOUNT=$(cat $1 | awk 'NR%2==1'| awk -F '' -v 'OFS=\n' '{$1=$1}1'| grep "A" | wc -l)  
CCOUNT=$(cat $1 | awk 'NR%2==1'| awk -F '' -v 'OFS=\n' '{$1=$1}1'| grep "C" | wc -l)  
GCOUNT=$(cat $1 | awk 'NR%2==1'| awk -F '' -v 'OFS=\n' '{$1=$1}1'| grep "G" | wc -l)  
UCOUNT=$(cat $1 | awk 'NR%2==1'| awk -F '' -v 'OFS=\n' '{$1=$1}1'| grep "U" | wc -l) 
# Adds up all the individual bases   
TOTALBASES=$(($ACOUNT + $CCOUNT + $GCOUNT + $UCOUNT)) 
#Calcuates Total GC
GCTOTAL=$(($CCOUNT + $GCOUNT))
#Calculate Total AC 
ATTOTAL=$(($ACOUNT + $UCOUNT))
# Calculates GC Percentage
echo 'GC Percentage:'
echo "scale=2; 100 * $GCTOTAL / $TOTALBASES " | bc
echo 'AU Percentage:'
echo "scale=2; 100 * $ATTOTAL / $TOTALBASES " | bc


