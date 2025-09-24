# inc-preliminary-analysis

This repository supports the preliminary analysis of an individual participant data meta-analysis project. This project aims to assess the reliability, validity, and interpretability of an EEG-based measure developed by our research group, Paediatric Neuroimaging group at the University of Oxford, as a proxy measure of analgesic efficacy in newborns, to support drug development trials. 

## Data availability

The raw EEG datasets are not included in this repository. All datasets used in the analysis are secondary data. For published datasets, access and sharing are governed by the data availability statements of the respective original publications. Some datasets have not been formally published; in such cases, data sharing is subject to the policies of the principal investigators and institutions responsible for the original projects.

Instead, the computed EEG magnitudes are shared in this repository. 

## Script overview

EEG analysis was conducted using [MATLAB](https://www.mathworks.com/help/install/ug/install-products-with-internet-connection.html). It is a customised version adapted from the example script of SIMPLE (SIngle-event Measurement PipeLine for EEG), a MATLAB-based EEG analysis pipeline developed by our research group as an [EEGLAB](https://eeglab.org) plug-in. The pipeline has been completed but is not yet published. This customised script is not shared in this repository, because it utilises some functions from the SIMPLE pipeline, which will be elaborated in the pipeline publication.

## Folder structure

The repository is organised into xx folders:
- 

## How to use this repository
1. Start with the `matlab/` folder:
   - Run the main analysis script to generate spreadsheets that will be used as source data frames for the next steps of the analysis.
2. Go to `stata/` folder:
   - Run 'IPD_MA_analysis' 
   - Instructions are provided to reproduce the version used in the thesis.