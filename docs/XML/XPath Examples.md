---
layout: default
title: XPath Query
parent: XML

nav_order: 2
---

# Chapter 1 - XPath Query Examples
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

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
