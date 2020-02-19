---
layout: default
title: Convert to Web Application
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/project4

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
 * [Project Description](../../assets/files/021720_Csharp_Project4_Convert_to_Web_Application.pdf)
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
* [How to add row to data table](https://forums.asp.net/t/1448166.aspx?how+to+add+row+to+data+table)
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
* Error Message: "Assert.Fail failed. Delegate threw exception of type 'System.Data.OleDb.OleDbException', but expected 'System.ArgumentException': The persister should throw an exception when an invalid table is specified."
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
1. UpdateExistingRecordWorksWithOleDb, UPdateExistingRecordWorksWithPersister
Same as the UpdateRow(). 
2. StoreNewRecordWorksCorrectly
```ruby
        using (OleDbCommand command = connection.CreateCommand())
        {
            if ((int)row["ID"] == 0)
            {
                // Write the SQL statement that inserts the new row yourself. 
                command.CommandText = "INSERT INTO [tblEmployees]([Company], [Last Name], [First Name], [E-mail Address], [Job Title], [Business Phone], [ID]) VALUES(@Company, @FirstName, @LastName, @EmailAddress, @JobTitle, @BusinessPhone, @ID)";
            }
            else
            {
                command.CommandText = "UPDATE [tblEmployees] SET[Company] = @Company, [Last Name] = @LastName,[First Name] = @FirstName,[E-mail Address] = @EmailAddress,[Job Title] = @JobTitle,[Business Phone] = @BusinessPhone WHERE [ID] = @ID";
            }
```
... clipping 
```ruby
                 var idPar = command.CreateParameter();
                 idPar.ParameterName = "@ID";
                 idPar.DbType = DbType.UInt32;
                 // if the row has an "ID" column of zero, the row must be inserted into the database.
                 if (row["ID"].Equals(0))
                 {
                     row["ID"] = CountRows() + 1;
                     idPar.Value = CountRows() + 1;
                 }
                 else
                 {
                     idPar.Value = row["ID"];
                 }
                 command.Parameters.Add(idPar);

                 var rowsAffacted = command.ExecuteNonQuery();
```

3. UpdateMissingRecordthrowsException
```ruby
  if ((int)row["ID"] < 0)       
  {
      throw new System.ArgumentException("Exception");
  }
```

Q. What is 'SELECT @@IDENTITY'?
[Reference](https://dba.stackexchange.com/questions/4696/why-is-select-identity-returning-a-decimal)

 * File Name: Default.aspx.cs
## Method 3: public int CurrentRow ( [Create a ViewState Property] (https://www.developer.com/net/asp/article.php/3606741/aspnet-tip-create-a-viewstate-property.html) )
```ruby
public int CurrentRow
{
    // TODO: Read and store this value from the page's ViewState. 
    // The ViewState must be used to achieve proper behavior and this cannot use a standard getter 

    get
    {
        return Convert.ToInt32(ViewState["ID"]);
    }
    set
    {
        ViewState["ID"] = value; 
    }
}
 ```
