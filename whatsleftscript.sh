#!/bin/sh

# REMINDER: URLs need to be before name of link in org/text file
# For example:
# http://leftnews.org
# Leftnews is news and views from the left

# REMINDER: input file name: whatsleft.org
# REMINDER: image links are preceded with an "!"

# Needed programs include sed, pandoc, bash

# Needed files include
# whatsleftpreamble.html > Preamble text
# whatsleftpostable.html > End of file text

# This creates tmp.html. Delete when finished.

#Naming Temporary file
inputfile="tmp.html"

#convert org/text to html with pandoc
pandoc -t html -i whatsleft.org -o tmp.html

#add H2 formatting first
sed -i 's/<h2>/<h2 style="margin-top: 2em; font-size: 1.25em; font-family: helvetica, arial, serif;" class="title">/' $inputfile

#add H1 formatting
sed -i 's/<h1>/<\/td><\/tr><\/table><\/center><br \/><\/div><\/div><div style="border-bottom: 1px solid #cccccc;"><\/div><\/div><div class="section"><div class="mobileMargins" style="margin: 0 1em;"><div class="section-content" style="margin: 3em 0 3em 0;"><center><table cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tr><td width="500" style="text-align: left;"><h1 style="margin: 1.5em 0 0 0; font-size: 1.5em; font-family: helvetica, arial, serif; text-transform: uppercase; color: #999999;">/' $inputfile

#add H1 end formatting
sed -i 's/<\/h1>/<\/h1><div class="article" style="margin-bottom: 1.5em;">/' $inputfile

#add paragraph style
sed -i 's/<p>/<p style="margin-bottom: 1em; line-height: 1.5em; font-family: helvetica, arial, serif;">/' $inputfile

#add URL style
sed -i -e '/<a href=/ s/<p style="margin-bottom: 1em; line-height: 1.5em; font-family: helvetica, arial, serif;">/<p style="margin: 0 0 0.5em 0; line-height: 1.25em; font-family: helvetica, arial, serif;">/ ; s/<a href="/<a style="color: #990000;" href="/' $inputfile

#remove excess formatting added
sed -i 's/class="uri".*<\/a>/>/ ; s/<\/p>/<\/a><\/p>/' $inputfile

#Add image formatting

sed -i -e '/\.gif/ s/<p style="margin-bottom: 1em; line-height: 1.5em; font-family: helvetica, arial, serif;">!/<p style="margin-bottom: 1em; line-height: 1.5em; font-family: helvetica, arial, serif;"> <img src="/' $inputfile

sed -i -e '/\.gif/ s/<\/a><\/p>/" style="display: block;border: none;outline: none;-ms-interpolation-mode: bicubic;max-width: 500px;width: 100%;margin-left: auto;margin-right: auto;height: auto;font-size: 14px;font-weight: bold;line-height: 100%;text-decoration: none;text-transform: capitalize;"><\/p>/' $inputfile



#add pre and post text and rename
cat whatsleftpreamble.html $inputfile whatsleftpostamble.html >> tmp1.html && mv tmp1.html whatsleft.html


