# Capstone-Project---Final1
Introduction
Welcome to this Shiny application which is the final course project i.e. capstone project for Data Science Specialization course, from Coursera in cooperation with Swiftkey.

The original unprocessed data can be obtained at https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip that contains the data for Twitter, News and Blogs.

The Prediction Algorithm
This Shiny application is to predict the next word based on last 1, 2 or 3 words entered by the user.

The n-gram files with aggregated frequency then transformed to frequency dictionary data frames for each n-gram file.

In these data frames, each word is represented by 1 column together with the frequency in descending order. E.g. for quadGram data frame, there are 4 columns for 4 words and another column for frequency.

Backoff algorithm will be used for the prediction where it will be recursively trying from the higher order of n-grams data frame to lower order of n-grams data frame until a reasonable probability is found. E.g. If the input is more than 3 words, compare the last 3 words of the input to the first 3 words of the quadGram data frame. If an appropriate match is not found, then compare the last 2 words of the input to the first 2 words of the triGram data frame and continue this process until an appropriate match is found.

Shiny Application Navigation
To display the next predicted word(s), you need to enter word(s) at Please enter your text here: input field and the result will be displayed on right panel.

You have the option to choose how many predicted words to be displayed by selecting Number of predicted word to be displayed: dropdown box.

Besides that, you can choose to display the entered text or vice versa by toggling Display entered text checkbox.

Project files
Source code for server.R and ui.R files are available on the GitHub

Other files such as the n-gram files and ReadMe.md are also available on above GitHub link.
