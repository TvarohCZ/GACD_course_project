# Getting and cleaning data - course project

# # Overview

By having UCI HAR Dataset directory in your working directory, you should be able to run "run_analysis.R" script, which will produce "final_dataset.txt" as an output. Both the script and the output can be found at this repository.

# # Analysis step-by-step

1. I analyzed the X-train and X-test datasets and loaded them both into R.
2. After seeing they both have the same amount of variables, I knew then I should put them together via rbind.
3. I named all the variables using "features.txt" file. Then I filtered only those columns having "mean()" or "std()" in its name. As a stepping stone I had to discard duplicate columns, because matching function was behaving funny without it. 
4. Then I loaded activity and subject info (both for train and test). At first I put train and test together the same way I did it with the original data and then I added those columns to the dataframe. It was crucial to do it at this point, because after merging the order of the rows is changed.
5. I loaded the dataset containing activity descriptions, renamed its columns and then merged it with my currect working dataset (already filtered on columns). This got me descriptions for activities and at this point I already had all the variable names in place.
6. Last thing to do is to make summary means for all the columns grouped by subject and activity. I used dplyr for this and decided to keep ActivityID, just because mean on the same number will always produce that number, so I have both ActivityID and ActivityDescription in the final dataset.
7. I ended up with 180 observations of 69 variables (3 of those variables was created by me - ActivityID, ActivityDescription and SubjectID)
