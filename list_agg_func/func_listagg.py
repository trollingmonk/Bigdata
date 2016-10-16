########################################################################
# FileName : func_listagg.py (Hive UDF)                                #
# Author   : trollingmonk (https://github.com/trollingmonk/)           #
# Last modified date : 16-Oct-2016                                     #
########################################################################
import sys
from operator import itemgetter
from collections import defaultdict
d1 = defaultdict(list)
for data in sys.stdin:
 words = data.strip().split('\t')
 # creating the python dictionary first column (group by) will be used as key of dictonary and rest of data will be treated as value of key 
 d1.setdefault(words[0],[]).append(words[1:])
#print d1.items()
# now processing each key (grouping set)
for x in d1.keys():
 #sorting the values according to secound column (sort by) in descending order
 y =sorted(d1[x], key=itemgetter(0),reverse=True)
 # now processing the values that we are going to concatenate  
 y1 = [item[1] for item in y]
 #print x,":".join(y1)
 # concatenate the sorted values with ":" 
 y2 = ":".join(map(str, y1))
 # emmits out the gouping key and concatenated string (Final Result)
 print '%s\t%s' % (x, y2)