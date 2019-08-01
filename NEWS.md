## projmaker 0.1.5 (2019-08-01)

changes: 
  - added new option to *create_project.cmd* to automatically setup an 
    RStudio Project (Rproj File) if desired.
  
## projmaker 0.1.4 (2019-07-23)

changes: 
  - modified registry files (*.reg*) for new icons. 
  - renamed PACKAGE back to DESCRIPTION
  - changed BuildType: None in projmaker.Rproj

## projmaker 0.1.3

changes: 
  - modified registry files (*.reg*) for adding the batch scripts to the
    Right Click Context Menu - now it works for paths with spaces as well.

## projmaker 0.1.2

changes: 
  - renamed *makeproj.cmd* to *create_project.cmd*
  - extended *create_project.cmd* to
    + cope with the new naming convention for marketdata studies (*studyname_CTR_YYYY*), 
    + allow for the creation of directory trees for client projects (*projectname_CTR_YYYYMM*)
  - added *cleanup_project.cmd* to remove empty directories in directory tree
    after project finalization
  - added registry files (*.reg*) for adding the batch scripts to the
    Right Click Context Menu
  - updated README

## projmaker 0.1.1

changes: 
  - changed naming convention to capital ISO3 country codes
  - renamed package DESCRIPTION file to PACKAGE, as it is no R package
  - updated documentation


## projmaker 0.1.0

initial release

(re-implementation from the previously existing *project_setup* at GeoInsights)


