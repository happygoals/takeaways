---
layout: default
title: ADO.NET (Data Utilization)
parent: Advanced Visual Programming (C# .NET)

nav_order: 5
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
 1. ADO.NET: How .NET refers to these libraries which associated with interacting with Databases and CSV files. .Net iteration. 
 2. Fundamental components in ADO.NET
 * DataSet - Represents a collection of data tables(Multiple tables of data). 
 * DataTable - Represents one table of in-memory data. 
 * DataColumn - Represents the schema of a column in a DataTable 
 * DataRow - Represents a row of data in a DataTable.
 * DataView - Represents a databindable, customized view of a DataTable for sorting, filtering, searching, editing, and navigation. 
            - A snapshot of a DataTable if you need to create one. 
              e.g. A view of same data that only filter by last name.
              
### Example of DataSet, DataTable, and DataRow
- DataSet implement IDisposable. Immediately we can use 'using' statement. 
- No Database access happens. 
 
 <div class="code-example" markdown="1">

     // Create an in-memory dataset and tables 
     using (var ds = new System.Data.DataSet())
     {
       // Create a table that will belong to the dataset. Creat a structure of a database table. 
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

```ruby
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
```

### Important Facts about DataSets
  * DBNull.Value - This is a special singleton object that represents a NULL value from the original data source. 
  * DataSets can be converted into JSON using the Newtonsoft.JSON library and demonstrate a data-format independent from of data representation. 
  * DataSets can contain more than one DataTable.
  * DataSets implement IDisposable and can be used within a Using Statement.
  * DataSets can contain relation information between two tables, and those relations can be enforced with the AcceptChanges() method when changes are made to the tables it contains.
  

### Consider the following Department – User relationship
- Any number of users may belong to a department
- All users must belong to a department
1. Create the tblUsers table programmatically 
2. Add two users programmatically
3. Create the tblDepartments table programmatically
4. Establish relationship between tblUsers and tblDepartments
5. Write the result out to an XML file

<div class="code-example" markdown="1">

      // Create a table that will belong to the dataset. Create a structure of a database table. ... 1)
    using (var ds = new System.Data.DataSet())
    {
      var table1 = new System.Data.DataTable("tblUsers");
      table1.Columns.Add("FirstName", typeof(string)); 
      table1.Columns.Add("LastName", typeof(string));
      table1.Columns.Add("Age", typeof(int));
      var departmentIDColumn = new System.data.DataColumn("DepartmentId", typeof(int));
      table1.Columns.Add(departmentIdColumn); 

       // Create a rows of data for our in-memory table  ...2)       
       var row1 = table1.NewRow(); 
       row1["FirstName"] = "Haemin";
       row1["LastName"] = "Ryu";
       row1["Age"] = "24";
       row1["DepartmentId"] = 1;

       // Create a rows of data for our in-memory table  ...2) 
       var row2 = table1.NewRow(); 
       row2["FirstName"] = "Haemin";
       row2["LastName"] = "Ryu";
       row2["Age"] = DBNull.Value;
       row2["DepartmentId"] = 1;
       
       // now add the rows to the table
       table1.Rows.Add(row1); 
       table1.Rows.Add(row2); 
       
       // Create the department table schema  ...3) 
       var table2 = new System.Data.DataTable("tblDepartment"); 
       var parentColumn = new System.Data.DataColumn("Id", typeof(int)); 
       table2.Columns.Add(parentColumn); 
       table2.Columns.Add("name", typeof(string));
       
       // Create the marketing department entry    ...3) 
       var marketingDepartment = table2.NewRow(); 
       marketingDepartment["Id"] = 1; 
       marketingDepartment["Name"] = "Marketing";
       table2.Rows.Add(marketingDepartment); 
       
       // Add both tables to our dataset  ...3) 
       ds.Tables.Add(table1); 
       ds.Tables.Add(table2); 
       
       // Configure the relationship that requires a user must belong to a valid department ...4) 
       var relation = ds.Relations.Add("DepartmentRelation", parentColumn, departmentIdColumn);
       relation.Nested = true; // Cause the parent to contain the children in generated XML
       
       ds.WriteXml("nesting-example.xml");   ...5) 
    }

</div>

Resultant XML: 
```ruby
<?xml version="1.0" standalone="yes"?>
<MyDataSet>
 <tblDepartment>
  <Id>1</Id>
  <Name>Marketing</Name>
  <tblUsers>
    <FirstName>Haemin</FirstName> 
    <LastName>Ryu</LastName> 
    <Age>24</Age>
    <DepartmentId>1</DepartmentId> 
  </tblUsers> 
  <tblUsers>
    <FirstName>Haemin</FirstName>
    <LastName>Ryu</LastName>
    <DepartmentId>1</DepartmentId> 
  </tblUsers>
 </tblDepartment>
</MyDataSet>
```
