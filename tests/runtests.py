# Title: runtests.py
# Author: Elliot Goodrich <http://elliotgoodri.ch/>
# License: CC0 Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0/>
# Description: A script to test the XSLT file against input XML files and expected HTML files

import os
import re
import sys
from lxml import etree

# directories and files
input_dir = "input"
output_dir = "output"
deXify_file = "../deXify.xslt"

# test counter
test_count = 0

# load the regex to get the file name without the extension
filename_pattern = re.compile("^(.+)\.xml$")

# load the XSLT
f = open(deXify_file, "r")
deXify_doc = etree.parse(f)
deXify_transform = etree.XSLT(deXify_doc)

# loop through each test file
for input_filename in os.listdir(input_dir):

    # open the file
    f = open(os.path.join(input_dir, input_filename), "r")
    test_input = etree.fromstring(f.read())

    # perform the XSLT and get the output
    result = deXify_transform(test_input)
    test_output = unicode(result).strip()

    # get the output file name (test1.xml -> test1.html)
    output_filename = filename_pattern.findall(input_filename)[0] + ".html"

    # get the expected output
    f = open(os.path.join(output_dir, output_filename), "r")
    expected_output = f.read()

    # exit with failed status if they are not equal
    if test_output != expected_output:
        print "Test " + input_filename + " failed :("
        print "-- Output -------------\n" + test_output
        print "-- Expected output ----\n" + expected_output
        sys.exit(1)

    # otherwise incremant the test counter
    else:
        test_count += 1

# exit with passed status
print "All " + str(test_count) + " tests passed :)"
sys.exit(0)