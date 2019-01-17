Rscript qPCR.R $1/$2 ubq7
Rscript qPCR.R $1/$2 ve
python qPCR.py ${2%.*}_ubq7.csv ${2%.*}_ve.csv
cat ${2%.*}_R.csv | awk -F"," 'BEGIN{OFS=","} {print $0,$1}' | sed "s/-[0-9]$//g" | sed "s/Sample/Group/2" > Pro_${2%.*}_R.csv
Rscript plot_qPCR.R Pro_${2%.*}_R.csv $3 $4 $5
