# Title: runtests.py
# Author: Elliot Goodrich <http://elliotgoodri.ch/>
# License: CC0 Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0/>
# Description: A script to test the XSLT file against input XML files and expected HTML files

import os
import re
import sys
from lxml import etree

# directories and files
testdir = "tests"
inputdir = os.path.join(testdir, "input")
outputdir = os.path.join(testdir, "output")
XSLTfile = "deXify.xslt"

# test counter
testcount = 0

# load the regex to get the file name without the extension
pattern = re.compile("^(.+)\.xml$")

# load the XSLT
f = open(XSLTfile, "r")
xsltdoc = etree.parse(f)
transform = etree.XSLT(xsltdoc)

# loop through each test file
for inputfilename in os.listdir(inputdir):

    # open the file
    f = open(os.path.join(inputdir, inputfilename), "r")
    testinput = etree.fromstring(f.read())

    # perform the XSLT and get the output
    result = transform(testinput)
    testoutput = unicode(result).strip()

    # get the output file name (test1.xml -> test1.html)
    outputfilename = pattern.findall(inputfilename)[0] + ".html"

    # get the expected output
    f = open(os.path.join(outputdir, outputfilename), "r")
    expectedoutput = f.read().strip()

    # exit with failed status if they are not equal
    if testoutput != expectedoutput:
        print "Test " + inputfilename + " failed"
        print "-- Output -------------\n" + testoutput
        print "-- Expected output ----\n" + expectedoutput
        sys.exit(1)

    # otherwise incremant the test counter
    else:
        testcount += 1

# exit with passed status
print "All " + str(testcount) + " tests passed :)"
sys.exit(0)