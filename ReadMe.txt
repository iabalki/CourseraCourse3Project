--------User Description --------

## This is a an explanation on how to produce the required output from the source date.

Step 1: Download the files from source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Save locally, record the path where the files are unzipped and saved, using the following format as an example:
"~/Data Science Classes/Course 3 Project/UCI HAR Dataset/" (where ~ is your curent working directory in R
or "C:/Documents/Data Science Classes/Course 3 Project/UCI HAR Dataset/"


Step 2: Start R and R studio (For installation, see Internet or Coursera course materials)

Step 3: Install the following packages, if you already have not installed them -- dplyr, reshape, reshape2
to install type on the command prompt: install.packages ("<replace with package name>") 

Step 4: Open the script included here: run_analysis

Step 5: Copy and paste contents on the prompt

step 6: Type on the prompt <MyData or pick a name> <- CleanData (Path) -- see instructions on Path above

Step 7: In the folder where you saved the source data, there will be an Output.csv file that will contain the required aggregates.
Open with Excel.

If you get error messages, reach to .. for help.

-----------Technical Descripion------

The script is commented and should be sufficiently good to identify all steps taken.
On a high level what it does:

* Loads the source data
* merges test and train data, while applying the activity label and adding the headings for the dataset.
* Creates a Subject and Activity combination label == uniqie observation from perspctive of the output
* Performs a melt - dcast with the Subject-Activity combo as a unique identifier with function mean.
 