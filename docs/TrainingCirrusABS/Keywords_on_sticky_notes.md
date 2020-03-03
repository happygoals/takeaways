
* My working directory (020720)
Local Disk(C:) > Develop > Local > training-hry > App_Data> SetupScript..?

* Tortoise SVN = source version control 

* My repo URL: https://cirrus-2.cirrusabs.com:8080/svn/trining-v40/trunk/hryu

* Cirrus-2, Remote Desktop Connection = RDC

* Should not be in the SVN folder : bin, data, static, dll, user 

* WordPress setting : IIS super authority needed, MySql and Workbench should be synchronized, check wp-config.php file. 
[link to setup WordPress](https://www.pantz.org/software/mysql/mysqlcommands.html)
I could access using that new user account and we created it on workbench first and made sure that the user and the database we created on the Workbench is showed up on the CLI too.
* Go to Cirrus-2 (for Development) using 'Remote Desktop Connection(RDC)'
* MSSM: Microsoft SQL Server Management Studio
* Location of Cirrus Password Document: Corporate(J:) > Clients > Cirrus Password File 
* Cirrus Password Creation Rule
  - For the 'administrator' : (Abbreviation)V3rt123!   // Abbr. e.g. serx, louver, lennox or lx
  - For the 'Support@cirrusabs.com' : C@b$upp0rt    or     wordsPass
  
 * How to move the database that you want to work on from Production Environment to CIRRUS3 
 1) Open the Command Prompt 
 2) Go to the location of sql file you want to use (e.g. cd C:\Users\hryu\Download) 
 3) Type > osql -S CIRRUS-3\MSSQL2008R2 -E -d iwdc.com -i iwdc.sql

    - Drive Name: CIRRUS-3\MSSQL2008R2
    - DB Name: iwdc.com
    - Script Name: iwdc.sql

