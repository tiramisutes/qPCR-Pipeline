from collections import defaultdict
import itertools
import csv
import pandas as pd
import numpy as np
import sys

def readqrt(IN,OUT):
    d = defaultdict(list)
    with open(IN) as f:
        r = csv.reader(f)
        headers = next(r, None) # skip the headers
        interestingrows=[row for idx, row in enumerate(r)]
        for row in interestingrows:
            row[2] = float(row[2])
            d[row[0]].append(row)
    with open(OUT, "wb") as outfile:
        writer = csv.writer(outfile)
        writer.writerow(headers)
        for k, v in d.items():
            a, b = min(itertools.combinations(v, 2), key=lambda x: abs(x[0][2]-x[1][2]))
            writer.writerow(a)
            writer.writerow(b)

readqrt(IN=sys.argv[1],OUT="RQ"+sys.argv[1])
readqrt(IN=sys.argv[2],OUT="RQ"+sys.argv[2])

##read ub7
ub7=pd.read_csv("RQ"+sys.argv[1]).rename(columns={'Ct':'ub7'}).ix[:, ['Sample', 'ub7']]
ub7sort=ub7.groupby(['Sample']).apply(lambda x: x.sort_values(['ub7'],ascending=[True]))
ub7sort=ub7sort.reset_index(drop=True)
#ub7sort.to_csv('ub7sort.csv',index=False)
#pd.read_csv("ub7.csv", usecols=['Sample','Ct'])
##read ve
ve=pd.read_csv("RQ"+sys.argv[2]).rename(columns={'Sample':'Sample_ve','Ct':'ve'}).ix[:, ['Sample_ve', 've']]
vesort=ve.groupby(['Sample_ve']).apply(lambda x: x.sort_values(['ve'],ascending=[True]))
vesort=vesort.reset_index(drop=True)
#vesort.to_csv('vesort.csv',index=False)
##merge
h_ub7_ve=pd.concat([ub7sort,vesort],axis=1).ix[:,['Sample', 'ub7','ve']]
#obj=np.repeat(np.array([range(1,len(h_ub7_ve['Sample'])/2+1)]), [2])
#h_ub7_ve['obj']=obj
#h_ub7_ve.to_csv('ASALLCopy_out.csv',index=False)
#h_ub7_ve_sort.sort_values(['ub7', 've'], ascending=[True, True])
h_ub7_ve.loc[:,'2log']=2**(h_ub7_ve['ub7']-h_ub7_ve['ve'])
final = h_ub7_ve.drop(h_ub7_ve.columns[[1,2]],axis=1)
final.to_csv(sys.argv[2][:-6]+'ANOVA.csv',index=False)
finaldata=final.groupby(['Sample'], as_index=False).agg(
                      {'2log':['mean','std']})
finaldata.columns = ['Sample','mean','std']
finaldata.to_csv(sys.argv[2][:-6]+'R.csv',index=False)

print "Next, run plot_qPCR.R scripts"