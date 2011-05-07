<?xml version="1.0"?>
<!--
	Title: deXify
	Author: Elliot Goodrich <http://elliotgoodri.ch/>
	License: CC0 Public Domain Dedication <http://creativecommons.org/publicdomain/zero/1.0/>
	Description: An XSLT to transform XHTML into valid, file size optimised HTML5.
	Note:
	- All comments starting with [SPEC] are taken from the HTML5 specification <http://dev.w3.org/html5/spec/spec.html>
	- All comments starting with [MICRO] are taken from the HTML5 Microdata specification <http://www.w3.org/TR/html5/microdata.html>
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:svg="http://www.w3.org/2000/svg" xmlns:mathml="http://www.w3.org/1998/Math/MathML">
	<xsl:output method="html"/>
	<xsl:strip-space elements="*"/>
	<!-- Variable for a single quotation symbol -->
	<xsl:variable name="singlequote">'</xsl:variable>
	<!-- Variable for a double quotation symbol -->
	<xsl:variable name="doublequote">"</xsl:variable>
	<!--

	/
	Apply templates -->
	<xsl:template match="/">
		<!-- Output HTML5 Doctype. -->
		<xsl:text disable-output-escaping="yes"><![CDATA[<!doctype html>]]></xsl:text>
		<xsl:apply-templates/>
	</xsl:template>
	<!--

	<html>
	[SPEC] An html element's start tag may be omitted if the first thing inside the html element is not a comment.
	[SPEC] An html element's end tag may be omitted if the html element is not immediately followed by a comment. -->
	<xsl:template match="xhtml:html">
		<!-- An html element's start tag is only required if the element has attributes -->
		<xsl:if test="attribute::*">
			<xsl:text disable-output-escaping="yes"><![CDATA[<html]]></xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- An html element's end tag is never required -->
	</xsl:template>
	<!--

	<head>
	[SPEC] A head element's start tag may be omitted if the element is empty, or if the first thing inside the head element is an element.
	[SPEC] A head element's end tag may be omitted if the head element is not immediately followed by a space character or a comment. -->
	<xsl:template match="xhtml:head">
		<!-- A head element's start tag is only required if the element has attributes, or is not empty and the first thing inside the <head> element is not an element. -->
		<xsl:if test="attribute::* or (node() and node()[1][not(self::xhtml:*)])">
			<xsl:text disable-output-escaping="yes"><![CDATA[<head]]></xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A head element's end tag is never required. -->
	</xsl:template>
	<!--

	<body>
	[SPEC] A body element's start tag may be omitted if the element is empty, or if the first thing inside the body element is not a space character or a comment, except if the first thing inside the body element is a script or style element.
	[SPEC] A body element's end tag may be omitted if the body element is not immediately followed by a comment. -->
	<xsl:template match="xhtml:body">
		<!-- A body element's start tag is only required if the element has attributes, or is not empty and the first thing inside the body element is a script or style element. -->
		<xsl:if test="attribute::* or (node() and node()[1][self::xhtml:script or self::xhtml:style])">
			<xsl:text disable-output-escaping="yes"><![CDATA[<body]]></xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A body element's end tag is never required -->
	</xsl:template>
	<!--

	<p>
	[SPEC] A p element's end tag may be omitted if the p element is immediately followed by an address, article, aside, blockquote, dir, div, dl, fieldset, footer, form, h1, h2, h3, h4, h5, h6, header, hgroup, hr, menu, nav, ol, p, pre, section, table, or ul, element, or if there is no more content in the parent element and the parent element is not an a element. -->
	<xsl:template match="xhtml:p">
		<xsl:text disable-output-escaping="yes"><![CDATA[<p]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A p element's end tag is only required if the element is not immediately followed by an address, ..., table or ul element, and either there is more content in the parent element or the parent element is an a element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:p or self::xhtml:address or self::xhtml:article or self::xhtml:aside or self::xhtml:blockquote or self::xhtml:dir or self::xhtml:div or self::xhtml:dl or self::xhtml:fieldset or self::xhtml:footer or self::xhtml:form or self::xhtml:h1 or self::xhtml:h2 or self::xhtml:h3 or self::xhtml:h4 or self::xhtml:h5 or self::xhtml:h6 or self::xhtml:header or self::xhtml:hgroup or self::xhtml:hr or self::xhtml:menu or self::xhtml:nav or self::xhtml:ol or self::xhtml:pre or self::xhtml:section or self::xhtml:table or self::xhtml:ul]) and (following-sibling::node() or parent::xhtml:a)">
			<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<li>
	[SPEC] A li element's end tag may be omitted if the li element is immediately followed by another li element or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:li">
		<xsl:text disable-output-escaping="yes"><![CDATA[<li]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A li element's end tag is only required if the li element is not immediately followed by another li element and there is more content in the parent element. -->
		<xsl:if test="following-sibling::node() and not(following-sibling::node()[1][self::xhtml:li])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</li>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<dt>
	[SPEC] A dt element's end tag may be omitted if the dt element is immediately followed by another dt element or a dd element. -->
	<xsl:template match="xhtml:dt">
		<xsl:text disable-output-escaping="yes"><![CDATA[<dt]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A dt element's end tag is only required if the dt element is not immediately followed by another dt or dd element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:dt or self::xhtml:dd])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</dt>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<dd>
	[SPEC] A dd element's end tag may be omitted if the dd element is immediately followed by another dd element or a dt element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:dd">
		<xsl:text disable-output-escaping="yes"><![CDATA[<dd]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A dd element's end tag is only required if the dd element is not immediately followed by another dd or dt element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:dt or self::xhtml:dd]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</dd>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<rt> and <rp>
	[SPEC] An rt/rp element's end tag may be omitted if the rt/rp element is immediately followed by an rt or rp element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:rt | xhtml:rp">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An rt/rp element's end tag is only required if the rt/rp element is not immediately followed by an rt or rp element and if there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:rt or self::xhtml:rp]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<optgroup>
	[SPEC] An optgroup element's end tag may be omitted if the optgroup element is immediately followed by another optgroup element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:optgroup">
		<xsl:text disable-output-escaping="yes"><![CDATA[<optgroup]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An optgroup element's end tag is only required if the optgroup element is not immediately followed by another optgroup element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:optgroup]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</optgroup>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<option>
	[SPEC] An option element's end tag may be omitted if the option element is immediately followed by another option element, or if it is immediately followed by an optgroup element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:option">
		<xsl:text disable-output-escaping="yes"><![CDATA[<option]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An option element's end tag is only required if the option element is not immediately followed by another option or optgroup element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:option or self::xhtml:optgroup]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</option>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<colgroup>
	[SPEC] A colgroup element's start tag may be omitted if the first thing inside the colgroup element is a col element, and if the element is not immediately preceded by another colgroup element whose end tag has been omitted. (It can't be omitted if the element is empty.)
	[SPEC] A colgroup element's end tag may be omitted if the colgroup element is not immediately followed by a space character or a comment. -->
	<xsl:template match="xhtml:colgroup">
		<!-- A colgroup element's start tag is only required if the element has attributes, or if the first thing inside the colgroup element isn't a col element or the preceeding node is a colgroup element. -->
		<xsl:if test="attribute::* or not(node()[1][self::xhtml:col]) or preceding-sibling::node()[1][self::xhtml:colgroup]">
			<xsl:text disable-output-escaping="yes"><![CDATA[<colgroup]]></xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A colgroup element's end tag is never required. -->
	</xsl:template>
	<!--

	<thead>
	[SPEC] A thead element's end tag may be omitted if the thead element is immediately followed by a tbody or tfoot element. -->
	<xsl:template match="xhtml:thead">
		<xsl:text disable-output-escaping="yes"><![CDATA[<thead]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A thead element's end tag is only required if the thead element is not immediately followed by a tbody or tfoot element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:tbody or self::xhtml:tfoot])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</thead>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tbody>
	[SPEC] A tbody element's start tag may be omitted if the first thing inside the tbody element is a tr element, and if the element is not immediately preceded by a tbody, thead, or tfoot element whose end tag has been omitted. (It can't be omitted if the element is empty.)
	[SPEC] A tbody element's end tag may be omitted if the tbody element is immediately followed by a tbody or tfoot element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:tbody">
		<!-- A tbody element's start tag is only required if the first thing inside the tbody element isn't a tr element, or the tbody element is preceded by a tbody, thead or tfoot element (none of these will have end tags after the transformation). -->
		<xsl:if test="not(node()[1][self::xhtml:tr]) or preceding-sibling::node()[1][self::xhtml:tbody or self::xhtml:thead or self::xhtml:tfoot]">
			<xsl:text disable-output-escaping="yes"><![CDATA[<tbody]]></xsl:text>
			<xsl:apply-templates select="@*">
				<xsl:sort select="local-name()"/>
			</xsl:apply-templates>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A tbody element's end tag is only required if the tbody element isn't immediately followed by a tbody or tfoot element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:tbody or self::xhtml:tfoot]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tbody>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tfoot>
	[SPEC] A tfoot element's end tag may be omitted if the tfoot element is immediately followed by a tbody element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:tfoot">
		<xsl:text disable-output-escaping="yes"><![CDATA[<tfoot]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A tfoot element's end tag is only required if the tfoot element isn't immediately followed by a tbody element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:tbody]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tfoot>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tr>
	[SPEC] A tr element's end tag may be omitted if the tr element is immediately followed by another tr element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:tr">
		<xsl:text disable-output-escaping="yes"><![CDATA[<tr]]></xsl:text>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A tr element's end tag is only required if the tr element isn't immediately followed by a tr element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:tr]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tr>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<td> and <th>
	[SPEC] A td/th element's end tag may be omitted if the td/th element is immediately followed by a td or th element, or if there is no more content in the parent element. -->
	<xsl:template match="xhtml:td | xhtml:th">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A td/th element's end tag is only required if the td/th element isn't immediately followed by a td or th element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::xhtml:td or self::xhtml:th]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
			<xsl:value-of select="local-name()"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	Void elements
	[SPEC] Void elements only have a start tag; end tags must not be specified for void elements. -->
	<xsl:template match="xhtml:area | xhtml:base | xhtml:br | xhtml:col | xhtml:command | xhtml:embed | xhtml:hr | xhtml:img | xhtml:input | xhtml:keygen | xhtml:link | xhtml:meta | xhtml:param | xhtml:source | xhtml:track | xhtml:wbr">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
	</xsl:template>
	<!--

	Other elements
	[SPEC] The start and end tags of certain normal elements can be omitted, as described later. Those that cannot be omitted must not be omitted. -->
	<xsl:template match="*">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:apply-templates select="@*">
			<xsl:sort select="local-name()"/>
		</xsl:apply-templates>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
	</xsl:template>
	<!--

	Empty attributes
	[SPEC] Just the attribute name. The value is implicitly the empty string. -->
	<xsl:template match="@*[. = '']">
		<xsl:text> </xsl:text>
		<xsl:value-of select="local-name()"/>
	</xsl:template>
	<!--

	Boolean attributes
	[SPEC] A number of attributes are boolean attributes. The presence of a boolean attribute on an element represents the true value, and the absence of the attribute represents the false value. 
	[SPEC] If the attribute is present, its value must either be the empty string or a value that is an ASCII case-insensitive match for the attribute's canonical name, with no leading or trailing whitespace.
	[MICRO] The itemscope attribute is a boolean attribute. -->
	<xsl:template match="@compact | @checked | @declare | @readonly | @disabled | @selected | @defer | @ismap | @nohref | @noshade | @nowrap | @multiple | @noresize | @itemscope">
		<!-- Display the attribute name if the value is a case-insensitive match to the name (the case where the attribute value is empty is handled by the previous template). -->
		<xsl:variable name="lower-case-text">
			<xsl:call-template name="to-lower-case">
				<xsl:with-param name="text" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$lower-case-text = local-name()">
			<xsl:text> </xsl:text>
			<xsl:value-of select="local-name()"/>
		</xsl:if>
	</xsl:template>
	<!--

	Attributes
	[SPEC] Attribute values are a mixture of text and character references, except with the additional restriction that the text cannot contain an ambiguous ampersand. -->
	<xsl:template match="@*">
		<xsl:text> </xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:text>=</xsl:text>
		<xsl:choose>
			<!--
			Unquoted attribute value syntax
			[SPEC] ... must not contain any literal space characters, any U+0022 QUOTATION MARK characters ("), U+0027 APOSTROPHE characters ('), U+003D EQUALS SIGN characters (=), U+003C LESS-THAN SIGN characters (<), U+003E GREATER-THAN SIGN characters (>), or U+0060 GRAVE ACCENT characters (`), and must not be the empty string. -->
			<xsl:when test="not(contains(., ' ') or contains(., $doublequote) or contains(., $singlequote) or contains(., '=') or contains(., '&lt;') or contains(., '&gt;') or contains(., '`'))">
				<xsl:value-of select="."/>
			</xsl:when>
			<!--
			Double-quoted attribute value syntax
			[SPEC] ... must not contain any literal U+0022 QUOTATION MARK characters (").
			Use double quotes only when the number of double quotes is fewer than the number of apostrophes. -->
			<xsl:when test="string-length(translate(., $singlequote, '')) &lt; string-length(translate(., $doublequote, ''))">
				<xsl:value-of select="$doublequote"/>
				<xsl:call-template name="escape-quotes">
					<xsl:with-param name="text" select="."/>
				</xsl:call-template>
				<xsl:value-of select="$doublequote"/>
			</xsl:when>
			<!--
			Single-quoted attribute value syntax
			[SPEC] ... must not contain any literal U+0027 APOSTROPHE characters (').
			Use single quotes when the number of double quotes is greater than or equal to the number of apostrophes. -->
			<xsl:otherwise>
				<xsl:value-of select="$singlequote"/>
				<xsl:call-template name="escape-apostrophes">
					<xsl:with-param name="text" select="."/>
				</xsl:call-template>
				<xsl:value-of select="$singlequote"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--

	Text -->
	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>
	<!--

	Non-escaped Text
	[SPEC] Raw text elements can have text, though it has restrictions described below.
	[SPEC] RCDATA elements can have text and character references, but the text must not contain an ambiguous ampersand. There are also further restrictions described below.
	[SPEC] The text in raw text and RCDATA elements must not contain any occurrences of the string "</" (U+003C LESS-THAN SIGN, U+002F SOLIDUS) followed by characters that case-insensitively match the tag name of the element followed by one of U+0009 CHARACTER TABULATION, U+000A LINE FEED (LF), U+000C FORM FEED (FF), U+000D CARRIAGE RETURN (CR), U+0020 SPACE, U+003E GREATER-THAN SIGN (>), or U+002F SOLIDUS (/). -->
	<xsl:template match="text()[parent::xhtml:script or parent::xhtml:style]">
		<!-- Disable escaping for raw text elements. -->
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>
	<!--

	escape-apostrophes
	This function replaces:
		- ' with &apos;
		- &gt; with >
		- &lt; with <
	for attribute values -->
	<xsl:template name="escape-apostrophes">
		<xsl:param name="text"/>
		<xsl:if test="string-length($text) &gt; 0">
			<xsl:variable name="character" select="substring($text, 1, 1)"/>
			<xsl:choose>
				<xsl:when test="$character = $singlequote">
					<xsl:text disable-output-escaping="yes"><![CDATA[&apos;]]></xsl:text>
				</xsl:when>
				<xsl:when test="$character = '&gt;'">
					<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
				</xsl:when>
				<xsl:when test="$character = '&lt;'">
					<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$character"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="escape-apostrophes">
				<xsl:with-param name="text" select="substring($text, 2)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--

	escape-quotes
	This function replaces:
		- " with &quot;
		- &gt; with >
		- &lt; with <
	for attribute values -->
	<xsl:template name="escape-quotes">
		<xsl:param name="text"/>
		<xsl:if test="string-length($text) &gt; 0">
			<xsl:variable name="character" select="substring($text, 1, 1)"/>
			<xsl:choose>
				<xsl:when test="$character = $doublequote">
					<xsl:text disable-output-escaping="yes"><![CDATA[&quot;]]></xsl:text>
				</xsl:when>
				<xsl:when test="$character = '&gt;'">
					<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
				</xsl:when>
				<xsl:when test="$character = '&lt;'">
					<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$character"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="escape-quotes">
				<xsl:with-param name="text" select="substring($text, 2)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--

	to-lower-case
	Returns the input in lower case. -->
	<xsl:template name="to-lower-case">
		<xsl:param name="text"/>
		<xsl:variable name="lower-case" select="'abcdefghijklmnopqrstuvwxyz'"/>
		<xsl:variable name="upper-case" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
		<xsl:value-of select="translate($text, $upper-case, $lower-case)"/>
	</xsl:template>
</xsl:stylesheet>
