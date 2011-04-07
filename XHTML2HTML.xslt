<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Void elements -->
	<!-- http://dev.w3.org/html5/spec/syntax.html#void-elements -->
	<xsl:template match="area | base | br | col | command | embed | hr | img | input | keygen | link | meta | param | source | track | wbr">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<!-- We don't need end tags for these elements -->
	</xsl:template>
	<!-- html -->
	<xsl:template match="html">
		<xsl:if test="attribute::*">
			<xsl:text disable-output-escaping="yes">&lt;html</xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="*"/>
		<!-- Don't close the tag because it won't be followed by a comment -->
	</xsl:template>
	<!-- head -->
	<xsl:template match="head">
		<!-- Display the start tag if there are attributes or the first element is not an element (which only leaves text nodes) -->
		<xsl:if test="attribute::* or node()[1][self::text()]">
			<xsl:text disable-output-escaping="yes">&lt;head</xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="* | text()"/>
		<!-- Don't close the tag because we won't have any spaces or comments following the element -->
	</xsl:template>
	<!-- body-->
	<xsl:template match="body">
		<!-- Display the start tag is the body element has attributes, or has content and the first element is a script or a style element (we don't need to check for comments as these are stripped) -->
		<xsl:if test="attribute::* or (node() and node()[1][self::script or self::style])">
			<xsl:text disable-output-escaping="yes">&lt;body</xsl:text>
			<xsl:apply-templates select="@*"/>
			<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="* | text()"/>
		<!-- Don't close the tag because we won't have any spaces or comments following the element -->
	</xsl:template>
	<!-- p -->
	<xsl:template match="p">
		<!-- Always include the start tage -->
		<xsl:text disable-output-escaping="yes">&lt;p</xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates select="* | text()"/>
		<!-- Display the end tag if there are following elements or we're in an <a> element, and the next node is not a listed element -->
		<xsl:if test="(following-sibling::node() or parent::a) and not(following-sibling::node()[1][self::p or self::address or self::article or self::aside or self::aside or self::blockquote or self::dir or self::div or self::dl or self::fieldset or self::footer or self::form or self::h1 or self::h2 or self::h3 or self::h4 or self::h5 or self::h6 or self::header or self::hgroup or self::hr or self::menu or self::nav or self::ol or self::pre or self::section or self::table or self::ul])">
			<xsl:text disable-output-escaping="yes">&lt;/p&gt;</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- li -->
	<xsl:template match="li">
		<!-- Always include the start tage -->
		<xsl:text disable-output-escaping="yes">&lt;li</xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates select="* | text()"/>
		<!-- Display the end tag if there are more nodes afterwards and they aren't <li> elements -->
		<xsl:if test="following-sibling::node() and not(following-sibling::node()[1][self::li])">
			<xsl:text disable-output-escaping="yes">&lt;/li&gt;</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- dt -->
	<xsl:template match="dt">
		<!-- Always include the start tage -->
		<xsl:text disable-output-escaping="yes">&lt;dt</xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates select="* | text()"/>
		<!-- Display the end tag if the following nodes are neither a <dt> element or a <dd> element-->
		<xsl:if test="not(following-sibling::node()[1][self::dt or self::dd])">
			<xsl:text disable-output-escaping="yes">&lt;/dt&gt;</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- dd -->
	<xsl:template match="dd">
		<!-- Always include the start tage -->
		<xsl:text disable-output-escaping="yes">&lt;dd</xsl:text>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates select="* | text()"/>
		<!-- Display the end tag if there are following nodes and the following nodes are neither a <dt> element or a <dd> element-->
		<xsl:if test="following-sibling::node() and not(following-sibling::node()[1][self::dt or self::dd])">
			<xsl:text disable-output-escaping="yes">&lt;/dd&gt;</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- rp or rt -->
	<xsl:template match="rt | rp">
		<!-- Always include the start tage -->
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates select="* | text()"/>
		<!-- Display the end tag if there are following nodes and the following nodes are neither a <rt> element or a <rp> element-->
		<xsl:if test="following-sibling::node() and not(following-sibling::node()[1][self::rt or self::rp])">
			<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- Other elements -->
	<xsl:template match="*">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:apply-templates select="@*"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	</xsl:template>
	<!-- Attributes -->
	<xsl:template match="@*">
		<xsl:text> </xsl:text>
		<xsl:value-of select="name(.)"/>
		<!-- Only add the value of the attribute if it's not duplicated and non empty -->
		<xsl:if test="not(name() = . or . = '')">
			<xsl:if test="not(name() = 'compact' or name() = 'checked' or name() = 'declare' or name() = 'readonly' or name() = 'disabled' or name() = 'selected' or name() = 'defer' or name() = 'ismap' or name() = 'nohref' or name() = 'noshade' or name() = 'nowrap' or name() = 'multiple' or name() = 'noresize')">
				<xsl:text>=</xsl:text>
				<!-- Only include quotes if we need to -->
				<xsl:choose>
					<xsl:when test="contains(., ' ')">
						<xsl:text>'</xsl:text>
						<xsl:value-of select="."/>
						<xsl:text>'</xsl:text>
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
</xsl:stylesheet>
