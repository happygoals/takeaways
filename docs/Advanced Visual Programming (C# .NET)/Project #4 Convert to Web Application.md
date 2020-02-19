---
layout: default
title: Convert to Web Application
parent: Advanced Visual Programming (C# .NET)

nav_order: 7
---

# Project #4 - Convert to Web Application
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

--- 
 * Project Name: Project #4 - Convert to Web Application
 * [Project Description](../../assets/files/021720_Csharp_Project4_Conver%20to%20Web%20Application.pdf)
 * File Name: AccessPersister.cs
 * Author Name: Haemin Ryu
 * Start Date: 02/17/2020
 * Last Modified Date: 02/19/2020


## Method 1: public DataRow CreateRow(string tableName)
- Description: This method must create a data table object, add the rows manually to the datatable, 
call the NewRow() method on the DataTable to create the new Row object and return it. 
1. ThrowsObjectDisposedAfterDisposeCalled
```ruby
 if (IsDisposed)
    throw new ObjectDisposedException("Previously Disposed."); 
 ```
2. NewRowHasCorrectColumns
```ruby
            DataTable table = new DataTable(tableName);

            table.Columns.Add(new DataColumn("ID", typeof(Int32)));
            table.Columns.Add(new DataColumn("Company", typeof(string)));
            table.Columns.Add(new DataColumn("Last Name", typeof(string)));
            table.Columns.Add(new DataColumn("First Name", typeof(string)));
            table.Columns.Add(new DataColumn("E-mail Address", typeof(string)));
            table.Columns.Add(new DataColumn("Job Title", typeof(string)));
            table.Columns.Add(new DataColumn("Business Phone", typeof(string)));

            DataRow newRow = table.NewRow();
            newRow["ID"] = 0;
            return newRow;
```
3. SupportsEmployeeTable 
```ruby
if (tableName != "tblEmployees")
    throw new System.ArgumentException("Arguement is invalid.");
```

## Method 2: public void StoreRow(DataRow row)
- Description: This method has been renamed as part of the interface from UpdateRow() to StoreRow(). 
This method must now perform the same function it did before with updating the supplied row,
but if the row has an "ID" column of zero, the row must be inserted into the database. 
It must then execute a 'SELECT @@IDENTITY' to retrieve the newly assigned ID of the new row and assign it to the DataRow's ID column. 
You will need to write the SQL statement that inserts the new row yourself. 
