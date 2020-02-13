---
layout: default
title: ADO.NET (Data Utilization)
parent: Advanced Visual Programming (C# .NET)

nav_order: 3
---

# ADO.NET (Data Utilization)
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## System.Data Namespace (ADO.NET) 
 ### ADO.NET component
 - ADO.NET: How .NET refers to these libraries which associated with interacting with Databases and CSV files. .Net iteration. 
 - Fundamental components in ADO.NET
 * DataSet - Represents a collection of data tables(Multiple tables of data). 
 * DataTable - Represents one table of in-memory data. 
 * DataColumn - Represents the schema of a column in a DataTable 
 * DataRow - Represents a row of data in a DataTable.
 * DataView - Represents a databindable, customized view of a DataTable for sorting, filtering, searching, editing, and navigation. 
            - A snapshot of a DataTable if you need to create one. 
              e.g. A view of same data that only filter by last name.
              
 ### Example of DataSet, DataTable, and DataRow
 DataSet implement IDisposable. Immediately we can use 'using' statement. 
 No Database access happen. 
 
 <div class="code-example" markdown="1">
 
   // Create an in-memory dataset and tables
   using (var ds = new System.Data.DataSet())
   {
      // Create a table that will belong to the dataset. Create a structure of a database table. 
      DataTable table1 = new DataTable("tblUsers");
      table1.Columns.Add("FirstName", typeof(string)); 
      table1.Columns.Add("LastName", typeof(string));
      table1.Columns.Add("Age", typeof(int));
    
    // Create a rows of data for our in-memory table
    var row1 = table1.NewRow(); 
    row1["FirstName"] = "Haemin";
    row1["LastName"] = "Ryu";
    row1["Age"] = "24";
    
    // Create a rows of data for our in-memory table
    var row2 = table1.NewRow(); 
    row2["FirstName"] = "Haemin";
    row2["LastName"] = "Ryu";
    row2["Age"] = DBNull.Value;
    
    // Add the rows to the table
    table1.Rows.Add(row1);
    table1.Rows.Add(row2);
    
    // Add the table to our dataset
    ds.Tables.Add(table1); 
    ds.WriteXml("example.xml"); 
   }
    
 </div>
 
### Converting the DataSet into XML(Baked into the .Net Framework): 
<div class="code-example" markdown="1">

<?xml version="1.0" standalone="yes"?>
<MyDataSet>
  <tblUsers>
    <FirstName>Haemin</FirstName> 
    <LastName>Ryu</LastName> 
    <Age>24</Age>
  </tblUsers> 
  <tblUsers>
    <FirstName>Haemin</FirstName>
    <LastName>Ryu</LastName> 
  </tblUsers>
</MyDataSet>

</div>

 ### Important Facts about DataSets
  * DBNull.Value - This is a special singleton object that represents a NULL value from the original data source. 
  * DataSets can be converted into JSON using the Newtonsoft.JSON library and demonstrate a data-format independent from of data representation. 
  * DataSets can contain more than one DataTable.
  * DataSets implement IDisposable and can be used within a Using Statement.
  * DataSets can contain relation information between two tables, and those relations can be enforced with the AcceptChanges() method when changes are made to the tables it contains.
  
    
  
