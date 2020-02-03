---
layout: default
title: XPath Query
parent: XML

nav_order: 3
---

# Chapter 1 - XPath Query Examples
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Given the following XML:
  <div class="code-example" markdown="1">
books.xml

<?xml version="1.0" encoding="ISO-8859-1"?>
<book category="cooking">
<title>Everyday Italian</title>
<author>Giada De Laurentiis</author>
<year>2005</year>
<price>30.00</price>
</book>

  </div>
Example of nodes in the XML document above:

<book> (root element node)
category="cooking" (attribute node)
<title>Everyday Italian</title> (element node)

Q. Create XPath Queries that do the following:
<b>Select the Title of the Book<b>
//book/title
//title
book/title
 <b>Select the Year of the book</b>
book/year
 <b>Select the category attribute of the book nodebook</b>
/@category

<div class="code-example" markdown="1">
 <?xml version="1.0" encoding="ISO-8859-1"?>
<bookstore>
<book category="cooking">
<title lang="en">Everyday Italian</title>
<author>Giada De Laurentiis</author>
<year>2005</year>
<price>30.00</price>
</book>
<book category="children">
<title lang="en">Harry Potter</title>
<author>J K. Rowling</author>
<year>2005</year>
<price>29.99</price>
</book>
<book category="web">
<title lang="en">XQuery Kick Start</title>
<author>James McGovern</author>
<author>Per Bothner</author>
<author>Kurt Cagle</author>
<author>James Linn</author>
<author>Vaidyanathan Nagarajan</author>
<year>2003</year>
<price>49.99</price>
</book>
<book category="web" cover="paperback">
<title lang="en">Learning XML</title>
<author>Erik T. Ray</author>
<year>2003</year>
<price>39.95</price>
</book>
</bookstore>
 </div>
 Q. Create XPath Queries that do the following:
Select the first book node
Select all book nodes that are in the "web" category
Select all book nodes for books that were published after 2003
Select all book nodes for books that contains the letter "l" in the title
Select all book nodes that have more than one author

  select="/bookstore/book[author.count() &gt; 1]">
  <xsl:value-of select="title" disable-output-escaping="yes" />
  
  
      <xsl:template match="/">
	  <html>
	  <body>
			<ol>
        <!-- Select the first book node -->
        <li><xsl:value-of select="bookstore/book[1]/*" /></li>      
        <!-- Select all book nodes that are in the "web" category -->
        <li>
          <ul>
            <xsl:for-each select="/bookstore/book[@category='web']">
              <li>
                <xsl:value-of select="title" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!-- Select all book nodes for books that were published after 2003 -->
        <li>
          <ul>
            <xsl:for-each select="/bookstore/book[year &gt; 2003]">
              <li>
                <xsl:value-of select="title" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!-- Select all book nodes for books that contains the letter "l" in the title -->
        <li>
          <ul>
            <xsl:for-each select="/bookstore/book[contains(title,'l')]">
              <li> <xsl:value-of select="title" disable-output-escaping="yes" />  </li>
            </xsl:for-each>
          </ul>
        </li>
        <!-- Select all book nodes that have more than one author -->
        <li>
          <ul>
            <xsl:for-each select="/bookstore/book">
              <xsl:if test="count(author) &gt; 1">
                <li>
                  <xsl:value-of select="title" disable-output-escaping="yes"/>
                </li>
              </xsl:if>
            </xsl:for-each>
          </ul>
        </li>
			</ol>
	  </body>
  </html>
    </xsl:template>
  
