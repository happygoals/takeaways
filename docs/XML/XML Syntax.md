---
layout: default
title: XML Syntax
parent: XML

nav_order: 1
---

# XML Syntax
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## XML Entity

There are five special symbols that are reserved in XML.
If you use this <b>reserved symbol</b> in an XML document, the XML parser (the interpreting machine) interprets it in a completely different sense.
Therefore, the charset created to use this reserved symbol exactly as it was used is called an entity.

In HTML, many characters and symbols are predefined and used as entities.
However, only five entities are provided by XML.


<div class="code-example" markdown="1">

| Symbol       | Entity Name | Hexadecimal Entity | Description                  |
|:-------------|:------------|:-------------------|:-----------------------------|
| <            | "&lt;"        | &#60;              | less than                    |
| >            | "&gt;"        | &#62;              | grater than                  |
| &            | "&amp;"       | &#38;              | An ampersand, And            |
| "            | "&quot;"      | &#34;              | Double quotes                |
| '            | "&apos;"      | &#39;              | Single quotes, An apostrophe |

</div>
