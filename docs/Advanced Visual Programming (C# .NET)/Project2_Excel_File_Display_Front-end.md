---
layout: default
title: Excel File Display Front-end
parent: Advanced Visual Programming (C# .NET)
permalink: /docs/csharp/project2

nav_order: 4
---

# Project #2 Excel file display front-end
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
*  Project Name: Project #2 - Excel file display front-end
* [Project Description](../../assets/files/012720_Csharp_Project2_Excel_File_Display_Front-end.pdf)
*  File Name: ExcelDataPersister.cs and frmMain.cs.
*  Start Date: 01/27/2020
*  Last Modified Date: 01/28/2020


## Issue 1 : Data connection error: could not find installable ISAM.  when you refresh a data table in Excel.

Solved: 
1. 
If you receive ‘Provider not registered’ errors when connecting to the excel document, please download and 
install the following package from Microsoft:
https://www.microsoft.com/en-us/download/details.aspx?id=54920
If you continue to receive this error message, you may need to change the bitness of your project to match your office product installation.  

Right Click on your project > Properties > Build > Change “Any CPU” under “Platform Target” to the appropriate bitness version(x86 or x64).
The “UtilTests+GetExcelConnectionStringMethod” unit test will pass once you configure everything correctly.
If the unit test still does not pass, then click on the settings icon(gear) under the Test Explorer window and switch “Processor Architecture for Any CPU Projects” to use the correct bitness (x86 or x64).

2. Visual Studio > Test > Test Settings > Default Professor Architecture > Change 'X84' to 'X64'
