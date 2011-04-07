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
