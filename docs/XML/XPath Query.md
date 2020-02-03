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
 
 ## XPath Syntax
  ### Selecting Nodes 
  XPath uses path expressions to select nodes or node-sets in an XML document. 

  nodename	Selects all nodes with the name "nodename"
  /	       Selects from the root node (An absolute path to an element)
  //	      Selects nodes in the document from the current node that match the selection no matter where they are
  .	       Selects the current node
  ..	      Selects the parent of the current node
  @	       Selects attributes
  ### Predicates
  <div class="code-example" markdown="1">
  - To find a specific node or a node that contains a specific value.
  - Always embedded in square brackets.
  
  /bookstore/book[1]	Selects the first book element that is the child of the bookstore element.
  /bookstore/book[last()]	Selects the last book element that is the child of the bookstore element
  /bookstore/book[last()-1]	Selects the last but one book element that is the child of the bookstore element
  /bookstore/book[position()<3]	Selects the first two book elements that are children of the bookstore element
  //title[@lang]	Selects all the title elements that have an attribute named lang
  //title[@lang='en']	Selects all the title elements that have a "lang" attribute with a value of "en"
  /bookstore/book[price>35.00]	Selects all the book elements of the bookstore element that have a price element with a value greater than 35.00
  /bookstore/book[price>35.00]/title	Selects all the title elements of the book elements of the bookstore element that have a price element with a value greater than 35.00

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
   ### Selecting Unknown Nodes
   <div class="code-example" markdown="1">

|  Wildcard    | Description       |
|:-------------|:------------------|
| *            | Matches any element node |
| @*           | Matches any attribute node  |
| node()       | Matches any node of any kind  |

  </div>


  /bookstore/* 	Selects all the child element nodes of the bookstore element
  //*           Selects all elements in the document
  //title[@*] 	 Selects all title elements which have at least one attribute of any kind

   ### Selecting Several Paths (AND)
   By using the | operator in an XPath expression you can select several paths.

  //book/title | //book/price	      Selects all the title AND price elements of all book elements
  //title | //price             	   Selects all the title AND price elements in the document
  /bookstore/book/title | //price	  Selects all the title elements of the book element of the bookstore element AND all the price elements in the document
   
 ## XPath Syntax
  
