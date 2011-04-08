<?xml version="1.0"?>
<!-- TODO: Set up some tests for this -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<!--

	/
	Apply templates -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!--

	<html>
	[SPEC] An html element's start tag may be omitted if the first thing inside the html element is not a comment.
	[SPEC] An html element's end tag may be omitted if the html element is not immediately followed by a comment. -->
	<xsl:template match="html">
		<!-- An html element's start tag is only required if the element has attributes -->
		<xsl:if test="attribute::*">
			<xsl:text disable-output-escaping="yes"><![CDATA[<html]]></xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- An html element's end tag is never required -->
	</xsl:template>
	<!--

	<head>
	[SPEC] A head element's start tag may be omitted if the element is empty, or if the first thing inside the head element is an element.
	[SPEC] A head element's end tag may be omitted if the head element is not immediately followed by a space character or a comment. -->
	<xsl:template match="head">
		<!-- A head element's start tag is only required if the element has attributes, or is not empty and the first thing inside the <head> element is not an element. -->
		<xsl:if test="attribute::* or (node() and node()[1][not(self::*)])">
			<xsl:text disable-output-escaping="yes"><![CDATA[<head]]></xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A head element's end tag is never required. -->
	</xsl:template>
	<!--

	<body>
	[SPEC] A body element's start tag may be omitted if the element is empty, or if the first thing inside the body element is not a space character or a comment, except if the first thing inside the body element is a script or style element.
	[SPEC] A body element's end tag may be omitted if the body element is not immediately followed by a comment. -->
	<xsl:template match="body">
		<!-- A body element's start tag is only required if the element has attributes, or is not empty and the first thing inside the body element is a script or style element. -->
		<xsl:if test="attribute::* or (node() and node()[1][self::script or self::style])">
			<xsl:text disable-output-escaping="yes"><![CDATA[<body]]></xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A body element's end tag is never required -->
	</xsl:template>
	<!--

	<p>
	[SPEC] A p element's end tag may be omitted if the p element is immediately followed by an address, article, aside, blockquote, dir, div, dl, fieldset, footer, form, h1, h2, h3, h4, h5, h6, header, hgroup, hr, menu, nav, ol, p, pre, section, table, or ul, element, or if there is no more content in the parent element and the parent element is not an a element. -->
	<xsl:template match="p">
		<xsl:text disable-output-escaping="yes"><![CDATA[<p]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A p element's end tag is only required if the element is not immediately followed by an address, ..., table or ul element, and either there is more content in the parent element or the parent element is an a element. -->
		<xsl:if test="not(following-sibling::node()[1][self::p or self::address or self::article or self::aside or self::aside or self::blockquote or self::dir or self::div or self::dl or self::fieldset or self::footer or self::form or self::h1 or self::h2 or self::h3 or self::h4 or self::h5 or self::h6 or self::header or self::hgroup or self::hr or self::menu or self::nav or self::ol or self::pre or self::section or self::table or self::ul]) and (following-sibling::node() or parent::a)">
			<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<li>
	[SPEC] A li element's end tag may be omitted if the li element is immediately followed by another li element or if there is no more content in the parent element. -->
	<xsl:template match="li">
		<xsl:text disable-output-escaping="yes"><![CDATA[<li]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A li element's end tag is only required if the li element is not immediately followed by another li element and there is more content in the parent element. -->
		<xsl:if test="following-sibling::node() and not(following-sibling::node()[1][self::li])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</li>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<dt>
	[SPEC] A dt element's end tag may be omitted if the dt element is immediately followed by another dt element or a dd element. -->
	<xsl:template match="dt">
		<xsl:text disable-output-escaping="yes"><![CDATA[<dt]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A dt element's end tag is only required if the dt element is not immediately followed by another dt or dd element. -->
		<xsl:if test="not(following-sibling::node()[1][self::dt or self::dd])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</dt>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<dd>
	[SPEC] A dd element's end tag may be omitted if the dd element is immediately followed by another dd element or a dt element, or if there is no more content in the parent element. -->
	<xsl:template match="dd">
		<xsl:text disable-output-escaping="yes"><![CDATA[<dd]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A dd element's end tag is only required if the dd element is not immediately followed by another dd or dt element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::dt or self::dd]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</dd>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<rt> and <rp>
	[SPEC] An rt/rp element's end tag may be omitted if the rt/rp element is immediately followed by an rt or rp element, or if there is no more content in the parent element. -->
	<xsl:template match="rt | rp">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An rt/rp element's end tag is only required if the rt/rp element is not immediately followed by an rt or rp element and if there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::rt or self::rp]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<optgroup>
	[SPEC] An optgroup element's end tag may be omitted if the optgroup element is immediately followed by another optgroup element, or if there is no more content in the parent element. -->
	<xsl:template match="optgroup">
		<xsl:text disable-output-escaping="yes"><![CDATA[<optgroup]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An optgroup element's end tag is only required if the optgroup element is not immediately followed by another optgroup element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::optgroup]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</optgroup>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<option>
	[SPEC] An option element's end tag may be omitted if the option element is immediately followed by another option element, or if it is immediately followed by an optgroup element, or if there is no more content in the parent element. -->
	<xsl:template match="option">
		<xsl:text disable-output-escaping="yes"><![CDATA[<option]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- An option element's end tag is only required if the option element is not immediately followed by another option or optgroup element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::option or self::optgroup]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</option>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<colgroup>
	[SPEC] A colgroup element's start tag may be omitted if the first thing inside the colgroup element is a col element, and if the element is not immediately preceded by another colgroup element whose end tag has been omitted. (It can't be omitted if the element is empty.)
	[SPEC] A colgroup element's end tag may be omitted if the colgroup element is not immediately followed by a space character or a comment. -->
	<xsl:template match="colgroup">
		<!-- A colgroup element's start tag is only required if the first thing inside the colgroup element isn't a col element (no colgroup elements will have end tags after the transformation). -->
		<xsl:if test="not(preceding-sibling::node()[1][self::colgroup]) ">
			<xsl:text disable-output-escaping="yes"><![CDATA[<colgroup]]></xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A colgroup element's end tag is never required. -->
	</xsl:template>
	<!--

	<thead>
	[SPEC] A thead element's end tag may be omitted if the thead element is immediately followed by a tbody or tfoot element. -->
	<xsl:template match="thead">
		<xsl:text disable-output-escaping="yes"><![CDATA[<thead]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A thead element's end tag is only required if the thead element is not immediately followed by a tbody or tfoot element. -->
		<xsl:if test="not(following-sibling::node()[1][self::tbody or self::tfoot])">
			<xsl:text disable-output-escaping="yes"><![CDATA[</thead>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tbody>
	[SPEC] A tbody element's start tag may be omitted if the first thing inside the tbody element is a tr element, and if the element is not immediately preceded by a tbody, thead, or tfoot element whose end tag has been omitted. (It can't be omitted if the element is empty.)
	[SPEC] A tbody element's end tag may be omitted if the tbody element is immediately followed by a tbody or tfoot element, or if there is no more content in the parent element. -->
	<xsl:template match="tbody">
		<!-- A tbody element's start tag is only required if the first thing inside the tbody element isn't a tr element, or the tbody element is preceded by a tbody, thead or tfoot element (none of these will have end tags after the transformation). -->
		<xsl:if test="not(node()[1][self::tr]) or preceding-sibling::node()[1][self::tbody or self::thead or self::tfoot]">
			<xsl:text disable-output-escaping="yes"><![CDATA[<tbody]]></xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<!-- A tbody element's end tag is only required if the tbody element isn't immediately followed by a tbody or tfoot element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::tbody or self::tfoot]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tbody>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tfoot>
	[SPEC] A tfoot element's end tag may be omitted if the tfoot element is immediately followed by a tbody element, or if there is no more content in the parent element. -->
	<xsl:template match="tfoot">
		<xsl:text disable-output-escaping="yes"><![CDATA[<tfoot]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A tfoot element's end tag is only required if the tfoot element isn't immediately followed by a tbody element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::tbody]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tfoot>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<tr>
	[SPEC] A tr element's end tag may be omitted if the tr element is immediately followed by another tr element, or if there is no more content in the parent element. -->
	<xsl:template match="tr">
		<xsl:text disable-output-escaping="yes"><![CDATA[<tr]]></xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A tr element's end tag is only required if the tr element isn't immediately followed by a tr element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::tr]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</tr>]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	<td> and <th>
	[SPEC] A td/th element's end tag may be omitted if the td/th element is immediately followed by a td or th element, or if there is no more content in the parent element. -->
	<xsl:template match="td | th">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<!-- A td/th element's end tag is only required if the td/th element isn't immediately followed by a td or th element and there is more content in the parent element. -->
		<xsl:if test="not(following-sibling::node()[1][self::td or self::th]) and following-sibling::node()">
			<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		</xsl:if>
	</xsl:template>
	<!--

	Void elements
	[SPEC] Void elements only have a start tag; end tags must not be specified for void elements. -->
	<xsl:template match="area | base | br | col | command | embed | hr | img | input | keygen | link | meta | param | source | track | wbr">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
	</xsl:template>
	<!--

	Other elements
	[SPEC] The start and end tags of certain normal elements can be omitted, as described later. Those that cannot be omitted must not be omitted. -->
	<xsl:template match="*">
		<xsl:text disable-output-escaping="yes"><![CDATA[<]]></xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="yes"><![CDATA[</]]></xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[>]]></xsl:text>
	</xsl:template>
	<!--

	Attributes -->
	<xsl:template match="@*">
		<xsl:text> </xsl:text>
		<xsl:value-of select="name(.)"/>
		<!-- Only add the value of the attribute if it's not duplicated and non empty -->
		<xsl:if test="not(name() = . or . = '')">
			<xsl:if test="not(name() = 'compact' or name() = 'checked' or name() = 'declare' or name() = 'readonly' or name() = 'disabled' or name() = 'selected' or name() = 'defer' or name() = 'ismap' or name() = 'nohref' or name() = 'noshade' or name() = 'nowrap' or name() = 'multiple' or name() = 'noresize')">
				<xsl:text>=</xsl:text>
				<!-- if there are single quotes inside the attribute then we must use double quotes -->
				<xsl:variable name="singlequote">'</xsl:variable>
				<xsl:variable name="doublequote">"</xsl:variable>
				<xsl:variable name="quotation">
					<xsl:choose>
						<xsl:when test="contains(., $singlequote)">
							<xsl:text>"</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>'</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- Only include quotes if there is a space character or an equals symbol or quotes -->
				<xsl:choose>
					<xsl:when test="contains(., ' ') or contains(., '=') or contains(., $singlequote) or contains(., $doublequote)">
						<xsl:value-of select="$quotation"/>
						<!--<xsl:call-template name="escape-xml">
							<xsl:with-param name="text" select="."/>
						</xsl:call-template>-->
						<xsl:value-of select="."/>
						<xsl:value-of select="$quotation"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template name="escape-xml">
		<xsl:param name="text"/>
		<xsl:if test="$text != ''">
			<xsl:variable name="head" select="substring($text, 1, 1)"/>
			<xsl:variable name="tail" select="substring($text, 2)"/>
			<xsl:choose>
				<xsl:when test="$head = '&amp;'">
					<xsl:text disable-output-escaping="no">&amp;amp;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$head" disable-output-escaping="no"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="escape-xml">
				<xsl:with-param name="text" select="$tail"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
