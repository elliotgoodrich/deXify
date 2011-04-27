deXify
======
deXify is an XSLT file that will transform valid XHTML5 into valid HTML5. But while we're at it, we might as well make it the smallest HTML5 file we can!

The Problems
------------
Whether it is XHTML1.0, XHTML2.0 or XHTML5; there are some fundamental problems with serving XHTML on the web. Below are a couple articles on those problems:

 * [Sending XHTML as text/html Considered Harmful](http://hixie.ch/advocacy/xhtml) - by Ian Hickson
 * [Beware of XHTML](http://www.webdevout.net/articles/beware-of-xhtml) - by David Hammond
 * [The Perils of Using XHTML Properly](http://www.456bereastreet.com/archive/200501/the_perils_of_using_xhtml_properly/) - by Roger Johansson
 * [Thought Experiment](http://diveintomark.org/archives/2004/01/14/thought_experiment) - by Mark Pilgrim

The Solution
------------
Due to the vast number of tools available, XML is a very easy markup language to work with. And so, working with XHTML on the server side is usually much simpler than working with HTML. But due to the large number of problems serving XHTML to the browser, we need something to translate between the two.

Enter deXify.

While transforming XHTML5 into HTML5, deXify will remove unnecessary (for validation) parts to the HTML5 document to lower the file size.

How to use deXify
-----------------
Since most programming languages have support for XSLT, deXify can be incorporated with few problems. Example code to follow.