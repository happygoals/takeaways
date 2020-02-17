---
layout: default
title: Chapter 2 - URL Redirects Examples
parent: XML

nav_order: 5
---

Original URL
New URL
http://www.acme.com/contact_us.html
/contact-us.aspx
http://www.acme.com/our_philosophy.cfm
/about-us.aspx
http://www.acme.com/brochures
/brochures.aspx
http://www.acme.com/promotional_ad.php?id=4
/promotions/ad-4
http://www.acme.com/promotional_ad.php?id=5
/promotions/ad-5
http://www.acme.com/promotional_ad.php?id=6
/promotions/ad-6
http://www.acme.com/2007/03/05/hot-new-story
/news/hot-new-story
http://www.acme.com/latest-news
/news.aspx
http://www.acme.com/latest-news/your-community
/your-community.aspx   
   
   <!--Haemin's Lesson-7 PART 1-->
        <!--You have been asked to configure URL Redirects for an existing client's website-->
        <!--Haemin's Rules 1-->
        <rule name="Contact Us" >  <!--stopProcessing="true"-->
          <match url="(contact).+" />  <!--(contacts)_us.html-->
          <action type="Redirect" url="{R:1}-us.aspx" redirectType="Permanent" />
        </rule>
        <!--Haemin's Rules 2-->
        <rule name="About Us" >
          <match url="our_philosophy.cfm" />
          <action type="Redirect" url="about-us.aspx" redirectType="Permanent" />
        </rule>
        <!--Haemin's Rules 3-->
        <rule name="Brochures" >
          <match url="brochures" />
          <action type="Redirect" url="{R:0}.aspx" redirectType="Permanent" />
        </rule>
        <!--Haemin's Rules 4-->
        <rule name="Promotional Ad 4" >
          <match url="promotional_ad\.php" />
          <conditions logicalGrouping="MatchAll">
            <add input="{QUERY_STRING}" pattern="id\=([4-6]{1})$" />
          </conditions>
          <action type="Redirect" url="/promotions/ad-{C:1}" redirectType="Found" appendQueryString="false" />
        </rule>
        <!--Haemin's Rules 5-->
        <rule name="Hot new story" >
          <match url="ho\w{1}[-]?(\w{3})[-]?\w{5}" />
          <action type="Redirect" url="{R:1}s/{R:0}" redirectType="Permanent" />
        </rule>
        <!--Haemin's Rules 7-->
        <rule name="Your Community" stopProcessing="true" >
          <match url="y\w{3}[-]?\w{9}" />
          <action type="Redirect" url="{R:0}.aspx" redirectType="Permanent" />
        </rule>
        <!--Haemin's Rules 6-->
        <rule name="Latest News" >
          <match url="(n\w{3})$" />
          <action type="Redirect" url="{R:1}.aspx" redirectType="Permanent" />
        </rule>
