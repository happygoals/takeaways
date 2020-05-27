---
layout: default
title: Using the URL Rewrite Module
parent: XML

nav_order: 8
---

# Using the URL Rewrite Module

## About the URL Rewrite module


## Creating Rewrite Rules for the URL Rewrite Module

## Accessing URL Parts from a Rewrite Rule

## Creating Outbound Rules for URL Rewrite Module
### Differences between Inbound Rewrite Rules and Outbound Rewrite Rules 
* <b>Inbound rule</b> is used to rewrite the incoming request. 
  * For example, if you create a rewrite rule to rewrite mydomain/a.aspx to /b.aspx. Then when you access mydomain/a.aspx, the page will display /b.aspx while the URL in web browser is still displaying mydomain/a.aspx. 
  * It could be used to build the reverse proxy while you need your application to display the content from another site or another server. If you set the redirect in inbound rule, it will change both the URL and displayed content to the target URL.
* <b>Outbound rule</b> is used to rewrite the attribute in response like a,img,script tag in the html page. IT could also used to rewrite the response header in rewrite rule.

### Adding an Inbound Rewrite Rules 
To add the inbound rewrite rule:
1. Open the web.config file located in the following location: %SystemDrive%\inetpub\wwwroot\
2. Under the /configuration/system.webServer element, add the following and then save the file:
```ruby 
<rewrite>
  <rules>
    <rule name="Rewrite to article.aspx">
      <match url="^article/([0-9]+)/([_0-9a-z-]+)" />
      <action type="Rewrite" url="article.aspx?id={R:1}&amp;title={R:2}" />
    </rule>
  </rules>
</rewrite>
```
### Creating an Outbound Rewrite Rules
To add the outbound rewrite rules:
1. aplicationHost.config file or in web.config files, Open the web.config file located in the following location:  %SystemDrive%\inetput\wwwroot\
2. In this file you see the <rewrite> section that contains all the rules definitions, as in the following example:
```ruby
<rewrite>
 <rules>
  <rule name="Rewrite to article.aspx">
   <match url="^article/([0-9]+)/([_0-9a-z-]+)" />
   <action type="Rewrite" url="article.aspx?id={R:1}&amp;title={R:2}" />
  </rule>
 </rules>
 <outboundRules>
  <rule name="Rewrite to clean URL" preCondition="IsHTML">
   <match filterByTags="A" pattern="^/article\.aspx\?id=([0-9]+)(?:&amp;|&amp;amp;)title=([_0-9a-z-]+)$" />
   <action type="Rewrite" value="/article/{R:1}/{R:2}" />
  </rule>
  <preConditions>
   <preCondition name="IsHTML">
    <add input="{RESPONSE_CONTENT_TYPE}" pattern="^text/html" />
   </preCondition>
  </preConditions>
 </outboundRules>
</rewrite>
  ```
