deXify
======
deXify is an XSLT that converts XHTML into HTML. The goals of deXify (in order of precedence) are:

 1. To convert valid XHTML5 into valid HTML5
 2. To convert XHTML1.0 into HTML (though validness is not a goal)
 3. To convert XHTML into the smallest HTML possible without sacrificing the time taken to convert a file

The Problems
------------
Whether it is XHTML1.0 or XHTML5, there are some fundamental problems with serving XHTML on the web. Below are a couple articles on those problems:

 * [Sending XHTML as text/html Considered Harmful](http://hixie.ch/advocacy/xhtml) - by Ian Hickson
 * [Beware of XHTML](http://www.webdevout.net/articles/beware-of-xhtml) - by David Hammond
 * [The Perils of Using XHTML Properly](http://www.456bereastreet.com/archive/200501/the_perils_of_using_xhtml_properly/) - by Roger Johansson
 * [Thought Experiment](http://diveintomark.org/archives/2004/01/14/thought_experiment) - by Mark Pilgrim

The Solution
------------
Due to the vast number of tools available, XML is a very easy markup language to work with. And so, working with XHTML on the server side is usually much simpler than working with HTML. But due to the large number of problems serving XHTML to the browser, we need something to translate between the two.

Enter deXify.

How to use deXify
-----------------
Since most programming languages have support for XSLT, deXify can be used in all of them.

Tasks to do
-----------
 * Add all the boolean attributes (the initial list I used was not complete, e.g. there are attributes on the `<media>` and `<video>` elements)
 * Example code to use deXify in:
  * PHP
  * Python
  * Perl
  * Ruby
  * C#
 * Add a param in deXify to toggle removing comments or keeping them (could be useful for IE conditional comments)
  * Write tests for this
  * Need to add more logic to optional start/end tags
