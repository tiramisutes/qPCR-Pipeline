# Real-Time RCP (qPCR) Pipeline
Auto-analysis for Real-Time RCP (qPCR) data.

This qPCR experiment usually have two group: Control (CK) and sample, and at least two type genes: [Housekeeping Gene](https://en.wikipedia.org/wiki/Housekeeping_gene) (HG) and Target Gene (TG). In our lab this usually label with ub7 and ve.

* [Dependencies](#Dependencies)
* [INPUT](#INPUT)
* [USAGE](#USAGE)
* [OUTPUT](#OUTPUT)
## 1. Dependencies
- python
  - collections
  - itertools
  - csv
  - pandas
  - numpy
  - sys
- R
  - ggplot2
  - gridExtra
  - ggthemes
  - ggsci
  - reshape2
  - dplyr
## 2. INPUT
There is a example input data in `Example_data/`.
## 3. USAGE
```
./qPCR.sh A B C D E
```
Argument:
- A: absolute path of Input data (e, /public/home/hope/qPCR)
- B: Input Data (e, raw_input_qPCR.csv)
- C: Width of output pdf file
- D: Height of output pdf file
- E: Whether plot a scientific journals figure using the ggsci packages (yes or no)

Running on the example data:
```
./qPCR.sh /public/home/hope/qPCR raw_input_qPCR.csv 18 8 no
```

## 4. OUTPUT
- raw_input_qPCR_ubq7.csv
- raw_input_qPCR_ve.csv
- RQraw_input_qPCR_ve.csv
- RQraw_input_qPCR_ubq7.csv
- raw_input_qPCR_R.csv
- raw_input_qPCR_ANOVA.csv
- Pro_raw_input_qPCR_R.csv
- Pro_raw_input_qPCR.pdf
- raw_input_qPCR_T-test.pdf
