---
layout: default
title: URL Downloading Console Application
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/project5

nav_order: 7
---

# Project #5 - URL Downloading Console Application
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

--- 
 * Project Name: Project #5 - URL Downloading Console Application
 * [Project Description](../../assets/files/022020_Csharp_Project5_URL_Downloading_Console_Application.pdf)
 * File Name: DownloadConfiguration.cs
 * Author Name: Haemin Ryu
 * Start Date: 02/21/2020

## HTTP: Client Identification 
* Why client identification is important: Content personalization has become part of our daily lives. 
* How Web servers can identify you & How information is used and stored
### HTTP Request Headers Used for Identification
- Web servers have a few ways to extract information about you directly from the HTTP request headers. 
Those headers are:

* From – contains user’s email address if provided
* User-Agent – contains the information about Web client
* Referer – contains the source user came from
* Authorization – contains username and password
* Client-ip – contains user’s IP address
* X-Forwarded-For – contains user’s IP address (when going through the proxy server)
* Cookie – contains server-generated ID label

- The <b>user-agent<b> header contains the information like the browser version, operating system. While this is important for customizing content, it doesn’t identify the user in a more relevant way.
- The <b>Referer</b> header tells the server where the user is coming from. This information is used to improve the understanding of the user behavior, but less so to identify it.
- The remaining headers offer more precise mechanisms of identification.
[Reference](https://code-maze.com/http-series-part-3/)

