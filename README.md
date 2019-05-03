
<!-- README.md is generated from README.Rmd. Please edit that file -->

# projmaker ![](figures/logo/projmaker_hex.png)

-----

## Overview

The *projmaker* should help to setup a project (*create\_project.cmd*)
at GeoInsights and clean-up when ready (*cleanup\_project.cmd*).

In future projects, a common structure for folders and a common
guideline for file naming should be applied.

In general, this tools help you to setup a corpus (minimal set) of
folders structured according to a general workflow typical at
GeoInsights.

Feel free to add or delete folders (e.g. *0111\_regiograph\_files*).

There should be ample room for individual modifications to create a best
structure for any given project. Especially the top level folder
structure should remain as proposed here.

Currently, the convention for naming project folders is

  - for Market Data: *studyname\_CTR\_YYYY*,
    e.g. *superproject\_CZE\_2019*
  - for Client Projects: *clientproject\_CTR\_YYYYMM*,
    e.g. *megaservice\_CZE\_201904*.

This means:

  - no spaces, german umlauts, special characters, etc.
  - *capital ISO3 country codes*
    (cf. <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3>).

If you have suggestions please contact [Christoph
Stepper](mailto:christoph.stepper@gfk.com) or [Anja
Waldmann](mailto:anja.waldmann@gfk.com).

## Current structure

At the moment, the directory tree for an initialized project looks
like:

``` bash
├───00_basedata                     # raw (delivered) data sets and data documentation; input only - i.e. never to be overwridden!
│   ├───001_data                        # the data itself
│   └───002_metadata                    # documentation for the data
├───01_analysis                     # anything to do with analysis/work-in-progress
│   ├───0101_data                       # intermediate data sets, e.g. results from individual analysis modules (tip: name subfolders corresponding to your R-scripts and save your data)
│   ├───0110_code                       # all code files, i.e. R code, py code, SAS code, etc.
│   │   ├───01100_r_functions               # R functions necessary for projects (longer than a 3-liner), but not worth to be put into a GIpackage; sourced within scripts to avoid code repetition 
│   │   ├───01101_r_scripts                 # R scripts for all analysis steps/modules, named in a comprehensible way (tip: number scrips in the order they need to be executed)    
│   │   └───01102_r_markdowns               #  if applicable, R markdown files (eg. for documentations etc.)
│   ├───0120_figures                    # any static or interactive visualisations generated during the analysis
│   ├───0121_leaflets                   # any map visualisation generated during the analysis
│   ├───0130_checks                     # anything that is to be checked by people other than the analysis author, e.g. excel comparison files in purchasing power
│   └───0140_misc                       # place for things that somehow do not fit into any of the above, e.g. colour definitions for logos
├───02_docu                         # project documentation and final checks (Checkliste)
├───03_results                      # final results that are to be delivered to the client or that are to be pushed to our official products
└───04_presentations                # things for kick-of/intermediate/final presentations
```

## General remarks

If you work with R, it is generally a good idea to set the **Workspace
Options** as follows:

1.  Uncheck *Restore .RData into workspace at startup*
2.  Set *Save workspace to .RData on exit:* to **Never**

Additionally, I strongly advice you to uncheck *Always save history
(even when not saving .RData)*. Have you ever had a look into your saved
*.Rhistory* files in any project? I didn’t.

![](figures/workspace_settings_RStudio.png)

It is advisable to use *RStudio Projects* when working in a project
mostly done in R.  
Doing so, you can use relative paths to navigate to files within the
project and the project keeps working when moved to another location
(e.g. another drive).

## Setup and workflow

### Setup

To use the *projmaker*, the easiest option would be to clone the
repository to your machine and use it from there.

If you only want to use one batch file, feel free to download it
directly.

### Generate folder structure

To generate a valid folder structure, just follow these steps:

1.  Copy the *create\_project.cmd* into the root directory where the new
    project should be locatad in.
2.  Execute the file by left double-click.
3.  Follow the user prompts to setup the folder structure.
      - Enter a valid name for the study, etc.
      - Delete *cmd* from the root directory (either automatically or
        manually).

Here are two examples for both cases:

  - Market Data

![](figures/create_project_marketdata.png)

  - Client Project

![](figures/create_project_clientproject.png)

### Setup RStudio project

To setup the project, open RStudio and execute:

1.  Navigate to *Project: (None)* (topright in RStudio GUI) and click on
    *New Project*
    
    ![](figures/proj_1.png)

2.  Select: Create Project in *Existing Directory*
    
    ![](figures/proj_2.png)

3.  Navigate to your project directory to set this as project working
    directory
    
    ![](figures/proj_3.png)

When a new RStudio project is created,

  - a project file (named *\*.proj*) is created within the project
    directory, containing various project settings,
  - a hidden directory (named *.Rproj.user*) is created, where project
    specific temporary files are stored.

![](figures/proj_4.png)

If you want to version control your project with *Git*, navigate to the
Project Options and select *Git* as Version control system.

Then a new git repository gets initialized (hidden *.git* folder and
*.gitignore* file in project working directory).

![](figures/project_options_1.png)

![](figures/project_options_2.png)

More info on working with RStudio projects can be found here:  
[Using
Projects](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)

### Clean-up empty directories

There might be some folders in your project directory tree which you did
not use while working on your project.

In order to keep our folder structure as tidy as possible, we’d advice
to remove all empty folders after finishing your analysis.

You can use the *cleanup\_project.cmd* to execute this task:

1.  Copy the *cleanup\_project.cmd* into the root directory of your
    project (e.g. “P:/03\_marketdata/CZE/superproject\_CZE\_2019”).
2.  Execute the file by left double-click.
3.  Follow the user prompts to remove all empty directories
    (incl. subdirectories)
      - Delete *cmd* from the root directory (either automatically or
        manually)

Here’s an examples for removing all empty directories:

![](figures/cleanup_project.png)

## Remarks

### Spinning R files

If you want to spin R files (–\> Markdown –\> html) within a project,
you should set the *R Markdown Option* as follows:

  - Evaluate chunks in directory: *Project*

![](figures/RMarkdown_settings_RStudio.png)

### Windows Context Menu

> NOTE: Make changes to the Windows *registry* with caution. Edits may
> harm the behavior of your computer.

If you’re tired of copying the batch files over and over again to the
target directories, you can add them to the *Right Click Menu* of your
file explorer.

Therefore, you need to tweak the *registry*. Simply add two new keys for
the batch files into the following root in your registry.

    Computer\HKEY_CLASSES_ROOT\Directory\Background\shell

You can add them either manually by opening the *Registry Editor* or by
executing the provided *.reg* files (in the “reg” directory) - make sure
that the links are pointing to the right location where your batch files
sit\!

Check if the keys were correctly set in your registry:

1.  Lauch **regedit.exe** from the Start menu

![](figures/regedit.png)

2.  Navigate to the **HKEY\_CLASSES\_ROOT** key and check if there are
    the two newly created keys *create\_project* and *cleanup\_project*.
    You can evaluate the given value for your key (Default) string by
    double-clicking *(Default)* and see what’s in the *Value data*
    field.

![](figures/registry_directory_background.png)

![](figures/registry_command_value.png)

Now you can easily open the batch scripts at any location. Just upen the
Right Click Context Menu (by right clicking in the background - *not on
a file or directory*) and select the task you want to run. It gets
executed in the current directory.

![](figures/right_click_menu.png)
