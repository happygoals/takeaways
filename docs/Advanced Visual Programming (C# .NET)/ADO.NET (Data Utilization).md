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

# System.Data Namespace (ADO.NET) 
## ADO.NET component
 1. ADO.NET: How .NET refers to these libraries which associated with interacting with Databases and CSV files. .Net iteration. 
 2. Fundamental components in ADO.NET
 * DataSet - Represents a collection of data tables(Multiple tables of data). 
 * DataTable - Represents one table of in-memory data. 
 * DataColumn - Represents the schema of a column in a DataTable 
 * DataRow - Represents a row of data in a DataTable.
 * DataView - Represents a databindable, customized view of a DataTable for sorting, filtering, searching, editing, and navigation. 
            - A snapshot of a DataTable if you need to create one. 
              e.g. A view of same data that only filter by last name.

# DataSet, DataTable, and DataRow
## Examples of DataSet, DataTable, and DataRow
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
## DataSet
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

## DataTable
### Important facts about DataTable
- A DataTable in an <b>independent in-memory</b> representation of tabular data.
- It is a collection of columns, each with a name, type and other properties such as allowing nulls, case sensitivity, uniqueness, auto-increment, etc. 
- A DataTable can create new row objects with the <b>NewRow()</b> method, but those rows are not automatically added to the datatable and are only compatible with a DataTable if it has the exact same DataColumns. You cannot actually create a DataRow object directly. You must actually call the NewRow() method on a DataTable to create a DataRow. 
- DataTables can be created programmatically or automatically based on the need. Programmatic method adds the columns, types and properties within the code itself. <b>Automatic creation</b> occurs when reading from an input XML file, excel file or a database (typically via a <b>DataReader</b>).

### Sample DataTable
```ruby
var table = new System.Data.DataTable("tblEmployee"); 
table.Columns.Add("ID", typeof(int)); 
table.Columns.Add("First Name", typeof(string)); 
table.Columns.Add("Last Name", typeof(string)); 
table.Columns.Add("E-mail Name", typeof(string)); 
table.Columns.Add("business Phone", typeof(string)); 
table.Columns.Add("Company", typeof(string)); 
table.Columns.Add("Job Title", typeof(string)); 
```

## DataRow
### Important facts about DataRow
- Items represent the raw data on your table. <b>Data in each row</b>. 
- Columns are accessed (get or set) using an <b>indexer</b>.
- The indexer can be an <b>ordinal</b> (integer) or a <b>string name</b> (column name)
 * Ordinal: A unique number that identifies a column for the current data table. Zero-based index of the column. Columns are generally assigned an ordinal (integer) value based on the order they are added.
 * String Name: The raw name given to the appropriate DataColumn.
 * Performance: Similar to other areas of the .NET Framework, it is almost always <b>faster to utilize an ordinal</b> instead of a string column name, but for most applications and smaller data sets, the gains are negligible and in practice seldom makes a significant difference.
- The DataRow values are of type <b>Object</b>, despite being constrained by the actual column type or a DataRelation object on the DataSet itself.  
- SetAdd(), SetModified() and Delete() modify the state of a row programmatically when utilizing a TableAdapter that propagates changes to a database. 

### Setting a value on a row using column name vs ordinal index
* Column name
```ruby
public void AccessRowColumnByName()
{
  // Create the table schema programmatically 
  var table = new System.Data.DataTable("tblEmployee"); 
  table.Columns.Add("ID", typeof(int)); 
  table.Columns.Add("First Name", typeof(string)); 
  table.Columns.Add("Last Name", typeof(string)); 
  table.Columns.Add("E-mail Name", typeof(string)); 
  table.Columns.Add("business Phone", typeof(string)); 
  table.Columns.Add("Company", typeof(string)); 
  table.Columns.Add("Job Title", typeof(string)); 
  
  // Create a new row
  var newRow = table.NewRow(); 
  
  // Set the column using ordinal 
  newRow["Job Title"] = "Chieg Technology Officer"; 
}
```
* Ordinal index
```ruby
public void AccessRowColumnByOrdninal()
{
  // Create the table schema programmatically 
  var table = new System.Data.DataTable("tblEmployee"); 
  table.Columns.Add("ID", typeof(int)); 
  table.Columns.Add("First Name", typeof(string)); 
  table.Columns.Add("Last Name", typeof(string)); 
  table.Columns.Add("E-mail Name", typeof(string)); 
  table.Columns.Add("business Phone", typeof(string)); 
  table.Columns.Add("Company", typeof(string)); 
  table.Columns.Add("Job Title", typeof(string)); 
  var jobTitleColumn = table.Columns.Add("Job Title", typeof(string)); 
  
  // Retrieve the column ordinal (index) 
  var jobTitleColumnOrdinal = jobTitleColumn.Ordinal;
  
  // Create a new row
  var newRow = table.NewRow(); 
  
  // Set the column using ordinal 
  newRow[jobTitleColumn] = "Chieg Technology Officer"; 
}
```
### Beware DbNull! 
- Null != DbNull in C#
- You may want to know the database with cells doesn't have information in there. 
- A singletone value that can be checked for on an individual column within a DataRow by calling IsNull() on the DataRow. 
```ruby
// Check for DBNULL.Value and actual "null" values 
if (newRow.IsNull("Job title"))
{
    // Do logic if Job Title is DBNULL or actual null 
    Console.WriteLine("Found null value!"); 
}
```
## Advantages and Disadvantages for the DataSet, DataTable, and associated objects
### Advantages 
- Typically <b>auto-populated</b> from a SQL query, Excel or XML query. Done automatically by simply connecting to the data source and tell .NET to read Schema directly from the data source.
- Typically do not contain relationships in code and instead rely on the underlying persistent medium (database) to enforce those constraints. <b>Not forced</b>
- Provide functionality that allows for programmatic manipulation that can be propagated to and from an underlying persistent medium (database), which will be explored soon via <b>Table Adapters</b> and <b>Data Readers</b>.
- Provides <b>a standard interface</b> for interacting with data, columns and sets of that data in <b>any known structure</b>.
### Disadvantages
- These objects do not contain nor are they strongly typed. <b>Nothing strongly typed.</b> 
- Column data is defined as the root Object type, which <b>does not enforce compile type</b> checking that would allow incorrect data to enter a column. Comfiling was fine, but when it runs, it will fail. <b>C# is a strongly typed language.</b> 
- Prone to misuse and loading of entire representative data sets that can be a <b>source of performance and memory utilization issues</b>. 
- Does not support native serialization into anything except XML. 

# Reference Links
* [Overview of ADO.NET in the .NET Framework](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/ado-net-overview)
* [Overview of DataSets, DataTables & DataViews](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/dataset-datatable-dataview/index?view=netframework-4.8)
* [Overview of DataTable](https://docs.microsoft.com/en-us/dotnet/api/system.data.datatable?view=netframework-4.8)
* [Overview of the DataColumn](https://docs.microsoft.com/en-us/dotnet/api/system.data.datacolumn?view=netframework-4.8)
* [Overview of DataRow](https://docs.microsoft.com/en-us/dotnet/api/system.data.datarow?view=netframework-4.8)
