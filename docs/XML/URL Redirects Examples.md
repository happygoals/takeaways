---
layout: default
title: URL Redirects Examples
parent: XML

nav_order: 5
---
# Chapter 2 - URL Redirects Examples


<div class="code-example" markdown="1">

| Original URL                                   | New URL              |
|:-----------------------------------------------|:---------------------|
| http://www.acme.com/contact_us.html            | /contact-us.aspx     |
| http://www.acme.com/our_philosophy.cfm         | /about-us.aspx       |
| http://www.acme.com/brochures                  | /brochures.aspx      |
| http://www.acme.com/promotional_ad.php?id=4    | /promotions/ad-4     |
| http://www.acme.com/promotional_ad.php?id=5    | /promotions/ad-5     |
| http://www.acme.com/promotional_ad.php?id=6    | /promotions/ad-6     |
| http://www.acme.com/2007/03/05/hot-new-story   | /news/hot-new-story  |
| http://www.acme.com/latest-news                | /news.aspx           |
| http://www.acme.com/latest-news/your-community | /your-community.aspx |

</div>

```ruby
  <system.webServer>
    <rewrite>
      <rules>
        <!--Haemin's Rules 1-->
        <!--(contact)_us.html-->
        <rule name="ContactUs" stopProcessing="true">
          <match url="^(contact)_(us).html$" />
          <action type="Redirect" url="{R:1}-{R:2}.aspx" redirectType="Permanent" />
        </rule>
        
        <!--Haemin's Rules 2-->
        <rule name="AboutUs">
          <match url="our_philosophy.cfm" />
          <action type="Redirect" url="about-us.aspx" redirectType="Permanent" />
        </rule>
        
        <!--Haemin's Rules 3-->
        <rule name="Brochures" stopProcessing="true" >
          <match url="brochures" />
          <action type="Redirect" url="{R:0}.aspx" redirectType="Permanent" />
        </rule>
        
        <!--Haemin's Rules 4-->
        <rule name="PromotionalAd4" stopProcessing="true">
          <match url="promotional_ad\.php" />
          <conditions logicalGrouping="MatchAll">
            <add input="{QUERY_STRING}" pattern="id\=([4-6]{1})$" />
          </conditions>
          <action type="Redirect" url="/promotions/ad-{C:1}" redirectType="Found" appendQueryString="false" />
        </rule>
        
        <!--Haemin's Rules 5-->
        <rule name="HotNewStory" stopProcessing="true">
          <match url="ho\w{1}[-]?(\w{3})[-]?\w{5}" />
          <action type="Redirect" url="{R:1}s/{R:0}" redirectType="Permanent" />
        </rule>
        
        <!--Haemin's Rules 6-->
        <rule name="LatestNews" stopProcessing="true">
          <match url="(n\w{3})$" />
          <action type="Redirect" url="{R:1}.aspx" redirectType="Permanent" />
        </rule>
        
        <!--Haemin's Rules 7-->
        <rule name="YourCommunity" stopProcessing="true" >
          <match url="y\w{3}[-]?\w{9}" />
          <action type="Redirect" url="{R:0}.aspx" redirectType="Permanent" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
        
```
