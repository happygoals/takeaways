
## XML String 

<?xml version="1.0" encoding="utf-8"?>
<root>
    <woot>Yes</woot>
    <woot>No</woot>
</root

## XSLT

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
                xmlns:Cirrus="http://www.cirrusabs.com"
                xmlns:pres="urn:CirrusPresentationUtilities"
                xmlns:logic="urn:CirrusLogicUtilities"
                xmlns:asp="urn:asp" >
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
      Hello Woot: <xsl:value-of select="/root/woot[1]" />
    </xsl:template>
    
</xsl:stylesheet>
