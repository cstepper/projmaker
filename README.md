# projmaker

## Overview

The _projmaker_ should help to setup a project at GeoInsights. 
In future projects, a common structure for folders and a common guideline file naming should be applied.

In general, this is a corpus (minimal set) of folders structured according to a general workflow typical at GeoInsights. 
Feel free to add or delete folders (e.g. 0113_regiograph_files). There should be ample room for individual 
modifications to create a best structure for any given project. Especially the top level folder structure should 
remain as proposed here. If you have suggestions please contact Christoph Stepper or Anja Waldmann.

## Installation

Just copy the *makeproj.cmd* into the root directory where the new project should be locatad in and execute the file by left double-click.

Follow the user prompts to setup the folder structure (i.e. enter a valid name for the study, etc.)

## Remarks

It is advisable to use _RStudio Projects_ when working in a project. Doing so, you can use relative paths to navigate to files within the project
and the projects keeps working when moved to another location (e.g. another drive).
If you want to version control your project with _GIT_, navigate to the Project Options and select _GIT_ as Version control system. 
Then a new git repository gets initialized (hidden _.git_ folder in project working directory and _.gitignore_ file).

## Current structure

├───00_basedata
│   ├───001_data
│   └───002_metadata
├───01_analysis
│   ├───0101_data
│   ├───0110_code
│   │   ├───01100_r_functions
│   │   ├───01101_r_scripts
│   │   └───01102_r_markdowns
│   ├───0120_figures
│   ├───0121_leaflets
│   ├───0130_checks
│   └───0140_misc
├───02_docu
├───03_results
└───04_presentations



00_basedata                  # raw (delivered) data sets and data documentation
                             # input only - i.e. never to be overwridden!
	001_data                     # the data itself
	002_data_docu                # documentation for the data

01_analysis                  # anything to do with analysis/work-in-progress

	0101_data                    # intermediate data sets, e.g. base data enriched with own calculations
	0102_final_data              # results from individual analysis modules, may be needed to create the final result

	0110_r_functions             # any functions that are to be sourced within scripts, e.g. to avoid repetition
	0111_r_scripts               # r scripts for all analysis steps/modules 
								 # (associated with author code in multi-analyst-projects, 
								 #  ie. 4-digit codes with the first digit representing the analyst 0000_*, 0010_*, 0011_*, 1000_*, ...)
	0112_r_markdowns             # if applicable, r markdown files (eg. for documentations etc.)

	0120_figures                 # if applicable, any static or interactive visualisations generated during the analysis

	0121_leaflets		     # map visualisations done during the analysis

	0130_checks                  # anything that is to be checked by people other than the analysis author, e.g. leaflets, excel, etc.

	0140_misc                    # place for things that somehow do not fit into any of the above, e.g. color definitions for logos

02_project_docu              # project documentation and final checks (Checkliste)

03_results                   # final results that are to be delivered to the customer

04_presentations             # things for kick-of/intermediate/final presentations