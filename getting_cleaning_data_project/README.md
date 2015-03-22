
Data set generation instructions
--------------------------------
--------------------------------

Requirements
------------
The dplyr package should be installed in the R environement.

Instructions
-------------

* Choose a path for later operations (for example C:\tmp\Coursera). This path will be named `<P>` in the following instructions.
* Download the following [archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to the `<P>` path.
* Unzip the previously downloaded archive into the `<P>` path (it should contains another directory named 'UCI HAR Dataset')
* Download the [run_analysis.R](https://github.com/OlivierG31/datasciencecoursera/blob/master/getting_cleaning_data_project/run_analysis.R) script into the `<P>` path
* Launch the RStudio (or other R executable)
* Set the working directory to `<P>` with the following command: `setwd("<P>")` (replace the `<P>` by the path you choose)
* Load the script with the following command: source("run_analysis.R")
* Execute it with the following command: run_analysis() . It will compute the orginal data set and return the transform data set.


For detailed information about the internal working of the run_analysis.R please open it into the text editor.

