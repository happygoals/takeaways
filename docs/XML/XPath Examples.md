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
  select="/bookstore/book[author.count() &gt; 1]">
  <xsl:value-of select="title" disable-output-escaping="yes" />
