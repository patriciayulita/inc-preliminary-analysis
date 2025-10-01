# inc-preliminary-analysis

This repository supports the preliminary analysis of an individual participant data meta-analysis project, which formed a chapter (Chapter 5) in my doctoral thesis. This project aims to assess the reliability, validity, and interpretability of an EEG-based measure developed by our research group, Paediatric Neuroimaging group at the University of Oxford, as a proxy measure of analgesic efficacy in newborns, to support drug development trials. 

## Data availability

The raw EEG datasets are not included in this repository. All datasets used in the analysis are secondary data. For published datasets, access and sharing are governed by the data availability statements of the respective original publications. Some datasets have not been formally published; in such cases, data sharing is subject to the policies of the principal investigators and institutions responsible for the original projects.

Instead, the computed EEG magnitudes are shared in this repository. 

## Script overview

EEG analysis was conducted using [MATLAB](https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html). It is a customised version adapted from the example script of SIMPLE (SIngle-event Measurement PipeLine for EEG), a MATLAB-based EEG analysis pipeline developed by our research group as an [EEGLAB](https://eeglab.org) plug-in. The pipeline has been completed but is not yet published. This customised script is not shared in this repository, because it utilises some functions from the SIMPLE pipeline, which will be elaborated in the pipeline publication.

## Folder structure

The repository is organised into 2 folders:
- `code/` folder, which is further divided into 3 subfolders according to the software used to generate the codes:
   * `matlab/` folder
   * `R/` folder
   * `stata/` folder
All subfolders contain scripts used to generate results and figures of Chapter 5 in the thesis.
- `data/` folder, which contains source data frames required to run the analysis scripts in the `code/` folder.
- `result` folder will be automatically generated as outputs of the scripts in the `code/` folder. Some files in this folder also act as source data frames for some of the scripts in the `code/` folder, thus the order of running the scripts is important. This order is described in the `How to use this repository` section).

## Software Requirements

To use this repository fully, you’ll need:

- [MATLAB](https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html)
- [STATA](https://www.stata.com)  
- [R](https://www.r-project.org/) and [RStudio](https://posit.co/downloads/)

These tools work on most systems (Windows, macOS, Linux).

## How to use this repository
A. Validity and interpretability analysis
   1. Start with the `matlab/` folder:
      - Run `IPD_MA_analysis` to generate spreadsheets that will be used as source data frames for the next steps of the analysis.
   2. Go to `stata/` folder:
      - Run `IPD_MA_analysis` to generate spreadsheets that will be used as source data frames for the next steps of the analysis.
   3. Go to `R/` folder:
      - Run `validity_analysis` for analysis of validity assessment
      - Run `interpretability_analysis` for analysis of interpretability assessment: typical magnitudes for noxious and innocuous stimuli
   4. Go to `stata/` folder:
      - Run `IPD_MA_analysis_2` to generate spreadsheets that will be used as source data frames for the next steps of the analysis, and to analyse and generate the forest plot figure for interpretability results by sites within stimulus types.
   5. Go to `R/` folder:
      - Run `interpretability_analysis_2` for analysis of interpretability assessment: typical magnitudes and effect sizes for each stimulus type

B. Reliability analysis
   1. Start with the `matlab/` folder:
      - Run `responses_data_cleaning_g` to prepare the responses spreadsheet (`reliability assessment_responses_cleaned`) to a compatible format to be used as source data frames for the next steps of the analysis. This spreadsheet contains n=966 responses, which is from n=483 epochs that appear twice so each epoch can be rated twice by each rater (for intra-rater reliability assessment). The discrepancy between the amount of epochs here and the number reported in Figure 5.4 of the thesis (n=483 epochs here vs n=457 epochs in thesis) is because some epochs were excluded after the assessment due to ineligible age range. The exclusion of these ineligible epochs were performed in the next script.
2. Go to `R/` folder:
      - Run `reliability_ox_ols` for reliability analysis of Oxford epochs
      - Run `reliability_ucl.ols` for reliability analysis of UCL epochs
      - Run `reliability_ex.ols` for reliability analysis of Exeter epochs
      - Run `reliability_betweensites` for average reliability coefficients between sites
3. Go to `stata/` folder:
      - Run `reliability` to generate the agreement cross-table figures and list of agreement coefficient figures for each reliability assesment. Manually screenshot the tables generated. The list of agreement coefficients figures generated here could also be used as a sanity check with the results produced using the script in R (B. Reliability analysis, step 2). 
      - Run `reliability_forestplot` to generate forest plot of reliability results. This figure was edited manually in [Canva](https://www.canva.com) to add the values in the figure.

C. Demographic analysis
   Go to `stata/` folder:
   - Run `demographics` for demographic analysis of unique participants (N=601 participants) and of all participants across stimulus types (N=1028 epochs). "Unique" means participants that received more than one stimulus type thus were analysed twice in interpretability analysis were only listed once. The results output for demographic analysis of unique participants (N=601 participants) were used to generate table 5.5 in the thesis, while the results output for demographic analysis of all participants across stimulus types (N=1028 epochs) were used to generate table 5.6 in the thesis.

## Summary

This repository provides a fully reproducible workflow for the preliminary analysis of an individual participant data meta-analysis project, assessing the reliability, validity, and interpretability of an EEG-based measure as a proxy measure of analgesic efficacy in newborns, to support drug development trials. It combines MATLAB-based, STATA-based, and R-based data analysis, published in my doctoral thesis.

For questions or collaboration, please contact the repository maintainer.