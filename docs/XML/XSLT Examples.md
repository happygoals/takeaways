---
layout: default
title: XSLT Examples
parent: XML

nav_order: 4
---

# Chapter 2 - XSLT Examples
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

##Practice 5

books.xml
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

1. 
Create an XSLT using the above XML that produces the following HTML (everything between the lines):

Book Title: Everyday Italian (by Giada De laurentiis, 2005)
Book Title: Harry Potter (by J K. Rowling, 2005)
Book Title: XQuery Kick Start (by James McGovern, Per Bothner, Kurt Cagle, James Linn, and Vaidyanathan Nagarajan, 2003)
Book Title: Learning XML (by Erik T. Ray)

Raw HTML:
```ruby
<div>Book Title: Everyday Italian (by Giada De laurentiis, 2005)</div> <div>Book Title: Harry Potter (by J K. Rowling, 2005)</div> <div>Book Title: XQuery Kick Start (by James McGovern, Per Bothner, Kurt Cagle, James Linn, and Vaidyanathan Nagarajan, 2003)</div> <div>Book Title: Learning XML (by Erik T. Ray, 2003)</div> 
```

1) My First Answer

{% highlight ruby linenos %}
      <div>Book Title: <xsl:value-of select="bookstore/book[1]/*" /> (by 
       <xsl:value-of select="bookstore/book[1]/author" />, 
       <xsl:value-of select="bookstore/book[1]/year" />)
      </div>
      <div>Book Title: <xsl:value-of select="bookstore/book[2]/*" /> (by 
       <xsl:value-of select="bookstore/book[2]/author" />, 
       <xsl:value-of select="bookstore/book[2]/year" />)
      </div>
      <div>Book Title: <xsl:value-of select="bookstore/book[3]/*" /> (by 
        <xsl:for-each select="bookstore/book[3]/author">
          <xsl:value-of select="." />,
        </xsl:for-each>
         <xsl:value-of select="bookstore/book[3]/year" />)
      </div>
      <div>Book Title: <xsl:value-of select="bookstore/book[4]/*" /> (by 
       <xsl:value-of select="bookstore/book[4]/author" />, 
       <xsl:value-of select="bookstore/book[4]/year" />)
      </div>
{% endhighlight %}

2) My Final Answer (Simple way, DRY)

{% highlight ruby linenos %}
      <div>
        <xsl:for-each select="bookstore/book" >
          Book Title:
          <xsl:value-of select="title"  disable-output-escaping="yes" /> (by
          <xsl:for-each select="author">
            <xsl:value-of select="."  disable-output-escaping="yes" />,
          </xsl:for-each>
          <xsl:value-of select="year"  disable-output-escaping="yes" />)
          <br></br>
        </xsl:for-each>
      </div>
{% endhighlight %}      

 ## Practice 6
 
 2. Create an XSLT using the above XML that produces the following HTML (everything between the lines):

2003 Titles
Learning XML
39.95
XQuery Kick Start
49.99

2005 Titles
Everyday Italian
29.99
Harry Potter
30.00

Raw HTML:

```ruby
<table cellspacing="5px" cellpadding="5px" border="1"> 
 <tr>
   <td colspan="2">2003 Titles</td>
 </tr>
 <tr> 
   <td>Learning XML</td> 
   <td>39.95</td> 
 </tr> 
 <tr> 
   <td>XQuery Kick Start</td> 
   <td>49.99</td> 
 </tr> 
</table
<br /> 
<table cellspacing="5px" cellpadding="5px" border="1"> 
  <tr> 
    <td colspan="2">2005 Titles</td> 
  </tr> 
  <tr> 
    <td>Everyday Italian</td> 
    <td>29.99</td> 
  </tr> 
  <tr> 
    <td>Harry Potter</td> 
    <td>30.00</td> 
  </tr> 
</table> 
```

1) My First Answer

{% highlight ruby linenos %}
  <xsl:template match="/">
    <html>
      <body>
        <table cellspacing="5px" cellpadding="5px" border="1">
          <tr>
            <td colspan="2">
              <xsl:value-of select="bookstore/book[last()]/year" /> Titles
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="bookstore/book[last()]/*" />
            </td>
            <td>
              <xsl:value-of select="bookstore/book[last()]/price" />
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="bookstore/book[last()-1]/*" />
            </td>
            <td>
              <xsl:value-of select="bookstore/book[last()-1]/price" />
            </td>
          </tr>
        </table>
        <br />
        <table cellspacing="5px" cellpadding="5px" border="1">
          <tr>
            <td colspan="2">
              <xsl:value-of select="bookstore/book[1]/year" /> Titles
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="bookstore/book[1]/*" />
            </td>
            <td>
              <xsl:value-of select="bookstore/book[1]/price" />
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="bookstore/book[2]/*" />
            </td>
            <td>
              <xsl:value-of select="bookstore/book[2]/price" />
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  
{% endhighlight %}

  2) My Second Answer (Simple way, DRY-> using xsl:for-each)

{% highlight ruby linenos %}
<xsl:template match="/">
   <html>
      <body>
          <table cellspacing="5px" cellpadding="5px" border="1" width ="200px">
            <tr>
              <td colspan="2">2003 titles</td>
            </tr>
            <xsl:for-each select="bookstore/book[year=2003]" >
              <tr>
                <td>
                  <xsl:value-of select="title" />
                </td>
                <td>
                  <xsl:value-of select="price" />
                </td>
              </tr>
            </xsl:for-each>
          </table>
          <br />
          <table cellspacing="5px" cellpadding="5px" border="1" width ="200px">
            <tr>
              <td colspan="2">
                <xsl:value-of select="bookstore/book[year=2005]/year" /> titles
              </td>
            </tr>
            <xsl:for-each select="bookstore/book[year=2005]" >
              <tr>
                <td>
                  <xsl:value-of select="title" />
                </td>
                <td>
                  <xsl:value-of select="price" />
                </td>
              </tr>
            </xsl:for-each>
          </table>
      </body>
    </html>
   </xsl:template>
 {% endhighlight %}
 
  3) My Final Answer (Simple way, DRY-> using generate-id)

{% highlight ruby linenos %}
<xsl:template match="/">
   <html>
      <body>
        <xsl:for-each select="/bookstore/book/year[generate-id(.) = generate-id(key('distinctYears', .)[1])]">
          <xsl:sort order="ascending" select= "."/>
          <table cellspacing="5px" cellpadding="5px" border="1" width ="200px">
            <xsl:variable name="currentYear" select="." />
            <tr>
              <td colspan="2">
                <xsl:value-of select="/bookstore/book[year = $currentYear]/year"/> Titles
              </td>
            </tr>
            <xsl:for-each select="/bookstore/book[year = $currentYear]" >
              <tr>
                <td>
                  <xsl:value-of select="title" />
                </td>
                <td>
                  <xsl:value-of select="price" />
                </td>
              </tr>
            </xsl:for-each>
          </table>
          <br />
        </xsl:for-each>
      </body>
    </html>
   </xsl:template>
{% endhighlight %}

Reference: https://stackoverflow.com/questions/15548783/using-xslt-key-for-finding-unique-values
