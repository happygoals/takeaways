---
layout: default
title: Creating a Custom Configuration Section with ASP.NET
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/custom-configuration

nav_order: 8
---

# Creating a Custom Configuration Section with ASP.NET
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
## System.Configuration 
1. System.Configuration 
- System.Configuration represents a configuration file that is applicable to a particular computer, application, or resource. 
- This namespace provides classes and interfaces that allow you to programmatically access .NET Framework configuration settings and handle errors in configuration files (.config files). 
2. ConfigurationManager 
- This class provides access to configuration files for client applications. 
- This class cannot be inherited. 
3. AppSettings
- This property gets the AppSettingsSection data for the current application's default configuration. 


## How to read App.config file in C#
- App.config : An XML file and it contains any variable configurable of the application. 
- Feature of App.config 
1. It contains key value pairs.
2. Mainly used to store the configurable parameters of an application.
3. When the project is compiled the content of App.Config file is copied into another file by name <ApplicationName>.exe.config (or) <ApplicationName>.dll.config.
- Instructions 
2. RightClick on project -> Add References -> .NET Tab -> System.Configuration -> OK
3. MessageBox.Show(System.Configuration.ConfigurationManager.AppSettings["k1"]) 


### Example 

#### App.config
```ruby
<?xml version="1.0" encoding="utf-8" ?>
<configuration> 
     <startup> 
          <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.6.1" /> 
     </startup> 
   <appSettings>  
      <add key="name" value="Haemin" /> 
      <add key="city" value="Seoul"  /> 
   </appSettings> 
</configuration> 
```

#### Program.cs
```ruby
using System; 
using System.Collections.Generic; 
using System.Linq; 
using System.Text; 
using System.Threading.Tasks; 

namespace AppSettingsData
{
    class Program
    {
        static void Main(string[] args)
        {
                string void Main(string[] args) 
                {
                     // Create instance of configurationManager class which allows me to access these add key values. 
                    string s1 = ConfigurationManager.AppSettings["name"];
                    Console.WriteLine("Name = " + s1); 
                    string s2 = ConfigurationManager.AppSettings["city"];
                    Console.WriteLine("City = " + s2); 
                }
        }
    }
}
```

#### Result
```ruby
Name = Haemin
City = Seoul
```

[System.Configuration.ConfigurationProperty("name")]
