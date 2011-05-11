# Title: runtests.py
# Author: Elliot Goodrich <http://elliotgoodri.ch/>
# License: CC0 Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0/>
# Description: A script to test deXify against input XML files and expected HTML files

import os
import re
import sys
import time
from lxml import etree

# start the clock
time_started = time.time()

# directories and files
input_dir = "input"
output_dir = "output"
deXify_file = "../deXify.xslt"

# test counters
passed_tests = 0
skipped_tests = 0
failed_tests = 0

# load the regex to get the file name without the extension
filename_pattern = re.compile("^(.+)\.xml$")

# load the regex to check what parameters we need to pass
keep_comments = re.compile("^keep\-comments")

# load the XSLT
f = open(deXify_file, "r")
deXify_doc = etree.parse(f)
deXify_transform = etree.XSLT(deXify_doc)

# loop through each test file
for input_filename in os.listdir(input_dir):

    # open the file
    f = open(os.path.join(input_dir, input_filename), "r")
    test_input = etree.fromstring(f.read())

    # change the keep-comments parameter depending on whether the filename says to
    if keep_comments.match(input_filename):
        keep_comments_value = etree.XSLT.strparam("true")
    else:
        keep_comments_value = etree.XSLT.strparam("false")

    # perform the XSLT and get the output
    result = deXify_transform(test_input, **{'keep-comments': keep_comments_value})
    test_output = unicode(result).strip()

    # get the output file name (test1.xml -> test1.html)
    output_filename = filename_pattern.findall(input_filename)[0] + ".html"

    # check there is an expected output
    try:
        f = open(os.path.join(output_dir, output_filename), "r")

    # if the expected output file doesn't exist then skip the test
    except:
        print "Skipping " + input_filename + " as it does not have an expected output"
        skipped_tests += 1
        continue

    else:
        # get the expected output
        expected_output = f.read()

        # if the outputs are equal
	if test_output == expected_output:
	    passed_tests += 1

        # else display what went wrong
        else:
            failed_tests += 1
            print "Test " + input_filename + " failed :("
            print "-- Output -------------\n" + test_output
            print "-- Expected output ----\n" + expected_output

# print the results
print "Number of tests passed:  " + str(passed_tests)
print "Number of tests skipped: " + str(skipped_tests)
print "Number of tests failed:  " + str(failed_tests)

# calculate and print the time taken
time_taken = round(100 * (time.time() - time_started), 2)
print "Time taken ~" + str(time_taken) + "ms"

# exit with the correct error value
if failed_tests == 0:
    sys.exit(0)
else:
    sys.exit(1)
