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
  
        ... clipping

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
## Method 3: public int CurrentRow 

( [Create a ViewState Property](https://www.developer.com/net/asp/article.php/3606741/aspnet-tip-create-a-viewstate-property.html) )
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
 
## Method 3: protected void Page_Load(object sender, System.EventArgs e)
First Trial
```ruby
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
                Detect 
            else
            {
                 int checkRow = ap.CountRows();    // Check the number of database rows. ap is an AccessPersister instance.
                 if (checkRow > 0)
                 {
                    UpdateDisplay();
                 } 
            }
        }
```
Final Solution 
```ruby
        protected void Page_Load(object sender, System.EventArgs e)
        {
            // Detect if the page is a PostBack
            if (IsPostBack)
            {
                lblID.Text = CurrentRow.ToString();
            }
            //if not
            else
            {
                // check the number of database rows
                int checkRow = ap.CountRows();
                // and if that number is greater than zero 
                if (checkRow > 0)
                {
                    // call the UpdateDisplay() method.
                    UpdateDisplay();
                }
            }
        }
```
## Method 4: private void UpdateDisplay()
```ruby
        private void UpdateDisplay()
        {
            // DONE: Retrieve the row for the value specified by the CurrentRow property. 
            System.Data.DataRow row2 = ap.GetRow(CurrentRow);

            // If the row returned is null, then assign the empty string to all of the textboxes on the form 
            // and set the lblID.Text to "0". 
            if (row2 == null)
            {
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtEmailAddress.Text = "";
                txtBusinessPhone.Text = "";
                txtCompany.Text = "";
                txtJobTitle.Text = "";
                lblID.Text = "0";
            }
            // If the row is non-null, assign all of the textboxes the corresponding values from the DataRow 
            // and lblID.Text accordingly. 
            else
            {
                txtCompany.Text = (row2["Company"]).ToString();
                txtLastName.Text = (row2["Last Name"]).ToString();
                txtFirstName.Text = (row2["First Name"]).ToString();
                txtEmailAddress.Text = (row2["E-mail Address"]).ToString();
                txtBusinessPhone.Text = (row2["Business Phone"]).ToString();
                txtJobTitle.Text = (row2["Job Title"]).ToString();
                lblID.Text = (row2["ID"]).ToString();
            }
        }
```
## Method 5: protected void btnSave_Click(object sender, EventArgs e) <-- Most difficult one 
 My wrong answer
```ruby
         protected void btnSave_Click(object sender, EventArgs e)
        {
            // TODO: First check to see if the current page is IsValid() and if so, retrieve the row pointed to by the CurrentRow property. 
            // If the DataRow returned is null, then call the CreateRow() method on the persister to create it. 
            // Then, assign all of the DataRow's columns from those values present in the textboxes on the webform and call StoreRow() with the DataRow.
            // Also, update the lblID to show the ID column form the data row after storeRow() is called and assign the DataRow's ID to the CurrentRow property. 

            // if the current page is IsValid() and if so, retrieve the row pointed to by the CurrentRow property.
            if (Page.IsValid)
            {
                //retrieve the row pointed to by the CurrentRow property.
                ap.GetRow(CurrentRow);
            }
            if (ap.GetRow(CurrentRow) == null)
            {
                // call the CreateRow() method on the persister to create it. 
                // assign all of the DataRow's columns from those values present in the textboxes on the webform
                // and call StoreRow() with the DataRow.
                System.Data.DataRow row = ap.CreateRow("tblEmployees");
                (row["Company"]) = txtCompany.Text;
                (row["Last Name"]) = txtLastName.Text;
                (row["First Name"]) = txtFirstName.Text;
                (row["E-mail Address"]) = txtEmailAddress.Text;
                (row["Business Phone"]) = txtBusinessPhone.Text;
                (row["Job Title"]) = txtJobTitle.Text;

                ap.StoreRow(ap.CreateRow("tblEmployees"));
                // update the lblID to show the ID column form the data row after storeRow() is called
                // assign the DataRow's ID to the CurrentRow property. 
                (ap.CreateRow("tblEmployees")["ID"]) = lblID.Text;
                CurrentRow = (int)(ap.CreateRow("tblEmployees")["ID"]);
            }
        }
 ```
 Correct Solution
 ```ruby
         protected void btnSave_Click(object sender, EventArgs e)
        {
            // if the current page is IsValid() and if so, retrieve the row pointed to by the CurrentRow property.
            // Add required field validators to each of the textboxes that uses a reasonable message to the user informing them that the field is required.
            if (Page.IsValid)
            {
                //retrieve the row pointed to by the CurrentRow property.
                var row = ap.GetRow(CurrentRow);

                // If the DataRow returned is null, then call the CreateRow() method on the persister to create it. 
                if (row == null)
                    row = ap.CreateRow("tblEmployees");

                // Then, assign all of the DataRow's columns from those values present in the textboxes on the webform
                row["Company"] = txtCompany.Text;
                row["Last Name"] = txtLastName.Text;
                row["First Name"] = txtFirstName.Text;
                row["E-mail Address"] = txtEmailAddress.Text;
                row["Business Phone"] = txtBusinessPhone.Text;
                row["Job Title"] = txtJobTitle.Text;

                // and call StoreRow() with the DataRow.
                ap.StoreRow(row);

                // assign the DataRow's ID to the CurrentRow property. 
                CurrentRow = (int)row["ID"];
                // update the lblID to show the ID column form the data row after storeRow() is called.
                lblID.Text = CurrentRow.ToString();
            }
        }
 ```
