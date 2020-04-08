---
layout: default
title: JavaScript DOM
parent: Front-end Development Basics
permalink: docs/front-end/js-dom

nav_order: 4
---

# JavaScript DOM
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

# DOM(Document Object Model) 
## What is DOM? 
- A W3C (World Wide Web Consortium) standard for accessing documents or an API to express document(All, HTML, XML) as an object. 
- When a web page is loaded, the browser creates a Document Object Model of the page.

출처: https://abc1211.tistory.com/199?category=940461 [길위의 개발자]
- DOM is composed as a <b>tree</b> of Objects, and it is a hierachy structure with nested tags.

"The W3C Document Object Model (DOM) is a platform and language-neutral interface that allows programs and scripts to dynamically access and update the content, structure, and style of a document."

### HTML DOM
The HTML DOM is a standard for how to get, change, add, or delete HTML elements.

## We need DOM to create dynamic document
- To change the content of HTML elements, attributes
- To change the style (CSS) of HTML elements
- To react to all existing HTML DOM events in the page
- To add/delete existing HTML elements and attributes
- To create/remove new HTML events in the page

## Types of Nodes
* Node = Method(-s) + Property(-ies)
1. Document Node
2. Element Node
3. Attribute Node
4. Text Node 

### Attribute Node: The HTML DOM Attribute Object

<b>The NamedNodeMap Object</b>
NamedNodeMap object represents an unordered collection of an elements attribute nodes.
- Nodes in a NamedNodeMap can be accessed by name or by index (number).




