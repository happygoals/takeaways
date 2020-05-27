---
layout: default
title: Using the URL Rewrite Module
parent: XML

nav_order: 8
---

# Using the URL Rewrite Module

## About the URL Rewrite module
The Microsoft URL Rewrite Module 2.0 for IIS 7 and above enables IIS administrators to create powerful customized rules to map request URLs to friendly URLs that are easier for users to remember and easier for search engines to find. You can use the URL Rewrite module to perform URL manipulation tasks, some of which include:
* Define powerful rules to transform complex URLs into simple and consistent Web addresses.
* Easily replace Web application URLs to produce user and search engine friendly results.
* Rewrite URLs based on HTTP headers and IIS server variables.
* Perform redirects, send custom responses, or stop HTTP requests based on the logic expressed in the rewrite rules.
* Control access to Web site content based on URL segments or request metadata.

## Creating Rewrite Rules for the URL Rewrite Module
The rewrite rules are stored either in the ApplicationHost.config file or in Web.config files. To check the configuration of the rule that we have just created, open a Web.config file located in %SystemDrive%\inetpub\wwwroot. In this file you should see the <rewrite> section that contains this rule definition:
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
  
## Creating an Access Block Rule
```ruby
<rewrite>
  <rules>
    <rule name="Fail bad requests">
      <match url=".*"/>
      <conditions>
        <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
      </conditions>
      <action type="AbortRequest" />
    </rule>
    <rule name="Redirect from blog">
      <match url="^blog/([_0-9a-z-]+)/([0-9]+)" />
      <action type="Redirect" url="article/{R:2}/{R:1}" redirectType="Found" />
    </rule>
    <rule name="Rewrite to article.aspx">
      <match url="^article/([0-9]+)/([_0-9a-z-]+)" />
      <action type="Rewrite" url="article.aspx?id={R:1}&amp;title={R:2}" />
    </rule>
  </rules>
</rewrite>
```

## How Certain Parts of the URL String Can Be Accessed from a Rewrite Rule
For an HTTP URL in this form: http(s)://<host>:<port>/<path>?<querystring>

* The <path> is matched against the pattern of the rule.
* The <querystring> is available in the server variable called QUERY_STRING and can be accessed by using a condition within a rule.
* The <host> is available in the server variable HTTP_HOST and can be accessed by using a condition within a rule.
* The <port> is available in the server variable SERVER_PORT and can be accessed by using a condition within a rule.
* Server variables SERVER_PORT_SECURE and HTTPS can be used to determine if a secure connection was used. These server variables can be accessed by using a condition within a rule.
* The server variable REQUEST_URI can be used to access the entire requested URL path, including the query string.

For example, if a request was made for this URL: http://www.mysite.com/content/default.aspx?tabid=2&subtabid=3, and a rewrite rule was defined on the site level then:

* The rule pattern gets the URL string content/default.aspx as an input.
* The QUERY_STRING server variable contains tabid=2&subtabid=3.
* The HTTP_HOST server variable contains www.mysite.com.
* The SERVER_PORT server variable contains 80.
* The SERVER_PORT_SECURE server variable contains 0 and HTTPS contains OFF.
* The REQUEST_URI server variable contains /content/default.aspx?tabid=2&subtabid=3.
* The PATH_INFO server variable contains /content/default.aspx

## Creating Outbound Rules for URL Rewrite Module
### Differences between Inbound Rewrite Rules and Outbound Rewrite Rules 
* <b>Inbound rule</b> is used to rewrite the incoming request. 
  * For example, if you create a rewrite rule to rewrite mydomain/a.aspx to /b.aspx. Then when you access mydomain/a.aspx, the page will display /b.aspx while the URL in web browser is still displaying mydomain/a.aspx. 
  * It could be used to build the reverse proxy while you need your application to display the content from another site or another server. If you set the redirect in inbound rule, it will change both the URL and displayed content to the target URL.
* <b>Outbound rule</b> is used to rewrite the attribute in response like a,img,script tag in the html page. IT could also used to rewrite the response header in rewrite rule.
* If we want to make any changes in the response headers or content after the processing has been completed by the specific handler or execution engine before sending it to the client, we can use outbound rules.

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

## Reference
* [reference1](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/using-the-url-rewrite-module)
* [reference2](https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/url-rewrite-module-configuration-reference)
