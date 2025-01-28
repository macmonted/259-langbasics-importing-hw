#PSYC 259 Homework 1 - Data Import
#For full credit, provide answers for at least 6/8 questions

#List names of students collaborating with (no more than 2): 

#GENERAL INFO 
#data_A contains 12 files of data. 
#Each file (6192_3.txt) notes the participant (6192) and block number (3)
#The header contains metadata about the session
#The remaining rows contain 4 columns, one for each of 20 trials:
#trial_number, speed_actual, speed_response, correct
#Speed actual was whether the figure on the screen was actually moving faster/slower
#Speed response was what the participant report
#Correct is whether their response matched the actual speed

### QUESTION 1 ------ 

# Load the readr package

# ANSWER
library(readr) #does this mean we don't always need to use chunks?

### QUESTION 2 ----- 

# Read in the data for 6191_1.txt and store it to a variable called ds1
# Ignore the header information, and just import the 20 trials
# Be sure to look at the format of the file to determine what read_* function to use
# And what arguments might be needed

# ds1 should look like this:

# # A tibble: 20 × 4
#  trial_num    speed_actual speed_response correct
#   <dbl>       <chr>        <chr>          <lgl>  
#     1          fas          slower         FALSE  
#     2          fas          faster         TRUE   
#     3          fas          faster         TRUE   
#     4          fas          slower         FALSE  
#     5          fas          faster         TRUE   
#     6          slo          slower         TRUE
# etc..

# A list of column names are provided to use:

col_names  <-  c("trial_num","speed_actual","speed_response","correct")

# ANSWER

ds1 <- read_tsv("data_A/6191_1.txt", skip = 7, col_names = col_names) #Questions - when do you know " vs. ', why skip 7 (goes from 1 column to 4)

### QUESTION 3 ----- 

# For some reason, the trial numbers for this experiment should start at 100
# Create a new column in ds1 that takes trial_num and adds 100
# Then write the new data to a CSV file in the "data_cleaned" folder

# ANSWER
ds1$newtrail_num <- ds1$trial_num + 100

write_csv(ds1, "data_cleaned/6191_1_cleaned.csv") #Question: can this function make a folder, or do you make it in advanced? if making a folder, don't include in Data A (will mess up combining function)

### QUESTION 4 ----- 

# Use list.files() to get a list of the full file names of everything in "data_A"
# Store it to a variable

# ANSWER

full_data_A <- list.files('data_A', full.names = TRUE)


### QUESTION 5 ----- 

# Read all of the files in data_A into a single tibble called ds

# ANSWER

ds <- read_tsv(full_data_A, skip = 7, col_names = col_names) 

### QUESTION 6 -----

# Try creating the "add 100" to the trial number variable again
# There's an error! Take a look at 6191_5.txt to see why.
# Use the col_types argument to force trial number to be an integer "i"
# You might need to check ?read_tsv to see what options to use for the columns
# trial_num should be integer, speed_actual and speed_response should be character, and correct should be logical
# After fixing it, create the column to add 100 to the trial numbers 
# (It should work now, but you'll see a warning because of the erroneous data point)

# ANSWER

ds$trail_100 <- ds$trial_num + 100

coltypes = "iccl" #Question: why can't we type this straight into the formula? why is it better to have as a variable?

ds <- read_tsv(full_data_A, skip = 7, col_names = col_names, col_types = coltypes) 

ds$trail_100 <- ds$trial_num + 100

### QUESTION 7 -----

# Now that the column type problem is fixed, take a look at ds
# We're missing some important information (which participant/block each set of trials comes from)
# Read the help file for read_tsv to use the "id" argument to capture that information in the file
# Re-import the data so that filename becomes a column

# ANSWER
ds <- read_tsv(full_data_A, skip = 7, col_names = col_names, col_types = coltypes, id = "filename") 
ds$trail_100 <- ds$trial_num + 100


### QUESTION 8 -----

# Your PI emailed you an Excel file with the list of participant info 
# Install the readxl package, load it, and use it to read in the .xlsx data in data_B
# There are two sheets of data -- import each one into a new tibble

# ANSWER

library(readxl)

datab_1 <- read_excel("data_B/participant_info.xlsx", sheet = 1)

col_names2 <- c("Participant","Test Date")

datab_2 <- read_excel("data_B/participant_info.xlsx", sheet = 2, col_names = col_names2)
