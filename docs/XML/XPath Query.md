---
layout: default
title: XPath Query
parent: XML

nav_order: 1
---

# Chapter 1 - XPath Query Lessons
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

--------------------------------------------------
## What is XPath?
= A major element in the XSLT standard.
= It can be used to navigate nodes through elements and attributes in an XML document.
= XML Path Language

--------------------------------------------------
## XPath Node 
 ### 7 Node types : element | attribute | text | namespace | processing-instruction | comment | document nodes
 ### XPath document = Trees of nodes
 ### Items == atomic values || Items == nodes
 ### Relationship of Nodes : Parent | Children | Siblings | Ancestors | Descendants
Given the following XML:
books.xml
<code>
<?xml version="1.0" encoding="ISO-8859-1"?>
<book category="cooking">
<title>Everyday Italian</title>
<author>Giada De Laurentiis</author>
<year>2005</year>
<price>30.00</price>
</book>
</code>

Example of nodes in the XML document above:

<book> (root element node)
category="cooking" (attribute node)
<title>Everyday Italian</title> (element node)

Create XPath Queries that do the following:
Select the Title of the Book
Select the Year of the book
Select the category attribute of the book node
