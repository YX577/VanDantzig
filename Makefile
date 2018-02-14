SHELL = /bin/sh
Baseline_Model = Model_Versions/Baseline_Model/Figures/optimal_dike_learning.pdf Model_Versions/Baseline_Model/Figures/sea_level_learn.pdf Model_Versions/Baseline_Model/Figures/optimal_dike_height_NOLA.pdf Model_Versions/Baseline_Model/Figures/FigureS1.pdf Model_Versions/Baseline_Model/Figures/Objective\ Tradeoffs/Baseline_tradeoffs_log.pdf Model_Versions/Baseline_Model/Figures/Objective\ Tradeoffs/Baseline_tradeoffs.pdf
Parametric_Uncertainty = Model_Versions/Parametric_Uncertainty/Parametric_Uncertainty.RData Model_Versions/Parametric_Uncertainty/Figures/Comparison/Baseline_Uncertainty.png
Uncertainty_SLR = Model_Versions/Uncertainty_SLR/Uncertainty_SLR_uniform.RData
Uncertainty_SLR_GEV = Model_Versions/Uncertainty_SLR/Uncertainty_SLR_uniform.RData
.PHONY: all install clean


all: $(Baseline_Model) $(Parametric_Uncertainty) $(Uncertainty_SLR) $(Uncertainty_SLR_GEV)


help: ## Displays this help message
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s\n\t%s\n" $$help_command $$help_info ; \
	done


install: install.R ## Install required R libraries
	Rscript install.R


$(Baseline_Model): Model_Versions/Baseline_Model/baseline_learning.R Model_Versions/Baseline_Model/Figures/Objective\ Tradeoffs/Baseline_tradeoffs.R ## Generate baseline model figures
	cd Model_Versions/Baseline_Model; \
	Rscript baseline_learning.R; \
	Rscript vanDantzig_baseline_NOLA.R; \
	Rscript vanDantzig_baseline.R


$(Parametric_Uncertainty): Model_Versions/Parametric_Uncertainty/vanDantzig_Uncertainty.R Model_Versions/Parametric_Uncertainty/Figures/Comparison/Baseline_Uncertainty.R ## Generate model figures with uncertainty in parameter values
	cd Model_Versions/Parametric_Uncertainty; \
	Rscript vanDantzig_Uncertainty.R
	cd Model_Versions/Parametric_Uncertainty/Figures/Comparison; \
	Rscript Baseline_Uncertainty.R


$(Uncertainty_SLR): Model_Versions/Uncertainty_SLR/vanDantzig_SLR.R ## Generate model figures with uncertainty in models and updated sea-level rise
	cd Model_Versions/Uncertainty_SLR; \
	Rscript vanDantzig_SLR.R


$(Uncertainty_SLR_GEV): Model_Versions/Uncertainty_SLR_GEV/vanDantzig_SLR_GEV_vxs.R ## Generate model figures with storm surge progections
	cd Model_Versions/Uncertainty_SLR_GEV; \
	Rscript vanDantzig_SLR_GEV_vxs.R


clean:
	-rm $(Baseline_Model) $(Parametric_Uncertainty) $(Uncertainty_SLR) $(Uncertainty_SLR_GEV)
