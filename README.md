# Plos-one-i2019
code and figures

The steps of our Simulation study were summarized as the following steps:

i.	  Parameter identification for simulation: 
      A set of assumptions about the nature and parameters of a dataset are specified with heterogenous compound symmetry, and 
      heterogenous first order autoregressive variance covariance structure.
ii.	  Simulation using R:
      1000 datasets were generated according to factorial combination of the following factors: model (null and alternative), 
      two variance assumptions, three possible sample sizes for each group (group n =3,6,12; total n = 9, 18 and 36), and four 
      possible values of the correlation between different time point within the same subject (ρ =0.1, 0.3, 0.6, 0.9).  
iii.	Statistical analyses of interest are performed on each simulated dataset, and the parameter estimates of interest these 
      analyses (e.g., p-values, etc.) are retained. Three models were analyzed for each simulation: repeated measures analysis 
      with heterogenous variance covariance structure (CSH, ARH), repeated measures analysis with homogenous variance covariance
      structure (CS, AR(1)) and separate ANOVA. The assumptions specified in step 1 is only for model I, and it was modified for 
      model II and model III. This analysis are repeated many times with 1000 datasets) to obtain an empirical distribution of 
      parameter estimates. 
iv.	  The obtained distributions of parameter estimate from these simulated datasets are analyzed to evaluate the question interest,
      that is what the impact of is using homogenous variance-covariance structure (CS and AR(1))or separate ANOVA when the data was
      simulated as heterogenous variance-covariance structure (CSH and ARH).


The detailed information for each step of the simulation study was illustrated as follows: (bolded texts are files’ names in Github 
https://github.com/jingzhao19/Plos-one-i2019).

I. Parameters identification for simulation: 
1.	null model: Mean and sd for null model
2.	alter model: Mean and sd for alternative model

Parameters (alter model and null model dataset) used for simulations were extracted by plot digitizer software Version 2.1 
(Zein et al. 2015) from the study (Cho et al. 2013). We conducted two sets of simulations corresponding to a null model, and an 
alternative model. There was no treatment and treatment x time interaction effect under the null model, in contrasts to the 
alternative model. The population parameter (means and sds) used for the null model and alternative model simulations are summarized
in above two datasets: null model and alter model.
 

II. Simulation code for four models using R.

1.	Simulation_Null_CSH_Model: 
    R code for simulate Null model with heterogenous compound symmetry variance covariance structure.
2.	Simulation_Null_ARH_Model: 
    R code for simulate Null model with heterogenous first-order autoregressive variance covariance structure.
3.	Simulation_Alternative_CSH_Model: 
    R code for simulate Alternative model with heterogenous compound symmetry variance covariance structure.
4.	Simulation_Alternative_ARH_Model:
    R code for simulate Alternative model with heterogenous first order autoregressive variance covariance structure.

The data simulation condition of each pair of null and alternative model were factorial combinations of the following: (i) two possible
population variance-covariance structures CSH or ARH (1);(ii) 3 possible sample sizes for each group (group n =3,6,12; total n = 9, 18 
and 36); (iii) four possible values of the correlation between different time point within the same subject (ρ =0.1, 0.3, 0.6, 0.9). 
All possible combinations factors were assessed and simulated 1,000 times. The multivariate normal function in R was used to simulate
the data 1000 times for each scenario (e.g., one scenario with Covariance structure with heterogeneity =CSHetro, group n=3, and ρ =0.1). 

The simulated datasets were based on the following model:

Y_ijk = μ + Di + Sij + TK + DTik + eijk (Euqation 1) 
Where Yijk is the bodyweight for treatment i subject j, and time k, Di represents the fixed dietary treatment (i= 1,2,3), Sij represent for random subject (j=1…n) nested in diet Di; Tk denotes the fixed time points (k= 1, 2, 3, 4, 5); DTij is for fixed diet and time interaction, and eijk is for random error with N (0, σ2) and is independent of Sij.


III. Data analysis code for 1000 simulated dataset from aboved four models using SAS:

1.	Analysis_SAS_Null CSH model:
SAS code for analyzing 1000 dataset simulated from the null model with heterogenous compound symetry variance coveraince structure.
2.	Analysis_SAS_Null ARH model:
SAS code for analyzing 1000 dataset simulated from the null model with heterogenous first order autoregressive coveraince structure.
3.	Analysis_SAS_Alternative_CSH model:
SAS code for analyzing 1000 dataset simulated from the alternative model with heterogenous compound symetry variance coveraince structure.
4.	Analysis_SAS_Alternative_ARH model:
     SAS code for analyzing 1000 dataset simulated from the 
     alternative model with heterogenous compound symetry 
     variance coveraince structure.

Analyses of the simulated datasets were performed using SAS PROC MIXED and PROC GLM procedure. For each simulated scenario, three models were fitted: (i) model 1: fitting the correct covariance structure--for example, fitting a CSH structure if the data was simulated using covariance matrix of type CSH or fitting an ARH(1) structure if the data was simulated using covariance matrix of type ARH(1); (ii) model 2: fitting the corresponding correct covariance structure but assuming equal variance across each time point (e.g., Type=CS with simulation in CSH or AR(1) with simulation in ARH(1) structure); (iii) an analysis based on single time points that ignore the repeated measures structure and used an ANOVA model at each time point. 
For model 1 and 2, the PROC MIXED procedure (model = Treatment | Time with subject nested in time, type = covariance structure) was used. PROC GLM procedure (model=Treatment) was applied for separate ANOVA analysis at specific time point in (iii). Using one simulated scenario (covariance structure = CSHetro, n=3, and ρ=0.1) as an example, we initially fit the covariance structure type = CSHetro (the same structure of the simulation) using PROC MIXED procedure. The same data was then fit covariance structure type = CSHomo, i.e. ignoring the heterogenous variance at the diagonal of the variance-covariance matrix. For analysis (i) and (ii), main effects including treatment, time, treatment x time interaction, and effect at each time point where estimated using the slice function in PROC MIXED procedure for each of the 1000 replicates. For analysis (iii), only treatment effect at each time point was estimated by separate ANOVA using PROC GLM procedure. 




IV. Result for different simulation 
as listed in 

Results from the first, second, and third model were denoted by heterogenous-CS/Heterogenous-AR, homogenous-CS/Homogenous-AR, and separate ANOVA, respectively.  The P value of analysis of 1000 simulated data point for three models were then plotted together using R package ggplot2.


