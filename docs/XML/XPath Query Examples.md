---
layout: default
title: XPath Query Examples
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
books.xml
```ruby
<?xml version="1.0" encoding="ISO-8859-1"?>
<book category="cooking">
   <title>Everyday Italian</title>
   <author>Giada De Laurentiis</author>
   <year>2005</year>
   <price>30.00</price>
</book>
```
  
Example of nodes in the XML document above:
```ruby
<book> (root element node)
category="cooking" (attribute node)
<title>Everyday Italian</title> (element node)
```
Q. Create XPath Queries that do the following:
```ruby
<b>Select the Title of the Book<b>
```
//book/title
//title
book/title
```ruby
 <b>Select the Year of the book</b>
 ```
book/year
```ruby
 <b>Select the category attribute of the book nodebook</b>
 ```
/@category

```ruby
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
```
 

 Q. Create XPath Queries that do the following:
* Select the first book node
* Select all book nodes that are in the "web" category
* Select all book nodes for books that were published after 2003
* Select all book nodes for books that contains the letter "l" in the title
* Select all book nodes that have more than one author

A. My first answer : 
```ruby
  <xsl:for-each select="/bookstore/book[author.count() &gt; 1]">
  	<xsl:value-of select="title" disable-output-escaping="yes" />
  </xsl:for-each>
```
A. Right answer : 
```ruby
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
    
 </div>
 ```
  --------------------------------------------------------------- 
  My Errored answers : 
  1. Select all book nodes that belong to the web category, have at least one author, were published in 2003, and cost more than $40
  
```ruby
      <!--one node at the same time, on the same node, in the same level.--> 
       <xsl:for-each select="//book[@category='web' and count(author) &gt; 1 and year = '2003' and price &gt; 40]">
              <li>
                <xsl:value-of select="title" disable-output-escaping="yes" />
              </li>
       </xsl:for-each>
```
   
   2. Select all book nodes that have titles greater in length than 12 characters
   
```ruby
 	<!--There's a duplication of location specification. Double titled. --> 
         <xsl:for-each select="/bookstore/book/title[string-length(.) &gt; 12 ]">
              <li>
                <xsl:value-of select="title" disable-output-escaping="yes" />
              </li>
         </xsl:for-each>
```

A. Right answer : 

```ruby
  <xsl:template match="/">
   <html>
    <body>
      <ol>
      <!-- Select all book nodes that belong to the web category, have at least one author, were published in 2003, and cost more than $40 -->
      <li>
        <ul>
           <!--one node at the same time, on the same node, in the same level.--> 
          <xsl:for-each select="//book[@category='web' and count(author) &gt; 1 and year = '2003' and price &gt; 40]">
            <li>
              <xsl:value-of select="title" disable-output-escaping="yes" />
            </li>
          </xsl:for-each>
        </ul>
      </li>
     <!-- Select the first book's title, but trim any leading or trailing whitespace -->
      <li>
        <xsl:value-of select="normalize-space(bookstore/book[1]/title)" disable-output-escaping="yes" />
      </li>
     <!-- select all book nodes that have titles greater in length than 12 characters -->
        <li>
          <ul>
            <xsl:for-each select="/bookstore/book/title[string-length(.) &gt; 12 ]">
              <li>
                <xsl:value-of select="." disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
     <!-- Select all book nodes after the first node that only have a single author -->
        <li>
          <ul>
            <xsl:for-each select="//book">
                <xsl:if test=" position() &gt; 1 and count(author) = 1">
                  <li>
                   <xsl:value-of select="title" disable-output-escaping="yes" />
                  </li>
                </xsl:if>
            </xsl:for-each>
          </ul>
        </li>
      </ol>
     </body>
    </html>
  </xsl:template>
```

------------------------------------------------------------------------
```ruby
    <xsl:template match="/">
     <html>
      <body>
      <ol>
        <!--Select all tblPages nodes that have an _id less than 10-->
       <li>
        <ul>
          <xsl:for-each select="Entities/Data/tblPages[@_id &lt; 10]">
              <li>
                <xsl:value-of select="./Title" disable-output-escaping="yes" />
              </li>
          </xsl:for-each>
        </ul>
       </li>
        <!--Select the trimmed DisplayName of the 4th tblPages node-->
        <li>
          <ul>
            <xsl:for-each select="Entities/Data/tblPages[position() = 4]">
              <li>
                <xsl:value-of select="normalize-space(./DisplayName)" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!--Select the number of sename nodes in this document-->
        <li>
          <ul>
            <xsl:for-each select="Entities/Data">
              <li>
                <xsl:value-of select="count(sename)" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!--Starting with the 5th tblPages node count the number of tblPages that have FDIC set to true-->
        <li>
          <ul>
            <li>
              <xsl:value-of select="count(Entities/Data/tblPages[@_index &gt; 4 and FDIC = 'true'])" disable-output-escaping="yes" />
            </li>
          </ul>
        </li>
        <!--Select the CanonicalUrl of the first tblPages node that has a title which contains 'Calculators'-->
        <li>
          <ul>
            <xsl:for-each select="Entities/Data/sename[TableName = 'tblPages' and contains(CanonicalUrl,'calculators')]">
              <li>
                <xsl:value-of select="CanonicalUrl" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!--Select the DisplayName of the tblPages node pointed to by the last sename node without using the sename node's EntityMasterRecordId-->
        <li>
          <ul>
            <xsl:for-each select="Entities/Data">
              <li>
                <xsl:variable name="entityid" select="sename[last()]/EntityId" />
                <xsl:value-of select="tblPages[@_id = $entityid]/DisplayName" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
        <!--Select the number of parent nodes that the last tblPages node has-->
        <li>
          <ul>
            <xsl:for-each select="Entities/Data/tblPages[last()]">
              <li>
                <xsl:value-of select="count(./ancestor::*)" disable-output-escaping="yes" />
              </li>
            </xsl:for-each>
          </ul>
        </li>
      </ol>
	  </body>
	</html>
	</xsl:template>
```
