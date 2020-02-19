/* 
 *  Project Name: Project #3 - Access database display front-end
 *  [Project Description](../../../asset/files/021020_Csharp_Project3_Access_Database_Display_Front-end.pdf)
 *  File Name: AccessPersister.cs
 *  Author Name: Haemin Ryu
 *  Start Date: 02/10/2020
 *  Last Modified Date: 02/13/2020
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.OleDb;

namespace PFW.CSIST203.Project3.Persisters.Access
{
    public class AccessPersister : IPersistData
    {
        internal readonly string accessFile = null;
        internal bool noDatabase = false;
        internal bool IsDisposed = false;

        // DONE: This constructor must initialize the persister’s local noDatabase variable to true.
        // and all methods must act as though the database is empty and no throw an exception.
        public AccessPersister()
        {
            this.noDatabase = true;
            this.accessFile = null; 
        }

        // DONE: This single parameter constructor accepts the file path to an access database that is used by the persister.    
        public AccessPersister(string accessFile)
        {
            // The file path is stored in a local variable. [Question!] 
            this.accessFile = accessFile;
            // ExcelFiledoesNotExist  // If the supplied file does not exist an exception is thrown.  
            if (!System.IO.File.Exists(accessFile))
            {        // If the specified file does not exist (using System.IO.File.Exists), then a System.IO.FileNotfoundException should be thrown.
                throw new System.IO.FileNotFoundException("The file does not exist.");
            }

            noDatabase = false;

          //  throw new NotImplementedException();
        }

        /// <summary>
        /// The filter used by the open dialog to find files that this persister will handle
        /// </summary>
        /// <returns></returns>
        public string FileFilter
        {
            get
            {
                return "Access Database Files|*.mdb;*.accdb";
            }
        }

        // DONE: This method must use OleDbConnection and OleDbCommand objects using a SQL
        // statement(SELECT * FROM[tblEmployees] where[ID] = @ID) 
        // to retrieve the specific entry required.
        public DataRow GetRow(int id)
        {
            // ThrowObjectDisposedExceptionAfterBeingDisposed
            if (IsDisposed)        // If it was previously disposed
                throw new ObjectDisposedException("This method was called because it was previously disposed");

            DataRow row = null;
            if (!this.noDatabase)
            {
                // Safely wrap the connection string with a using statement
                using (OleDbConnection connection = new OleDbConnection(Util.GetAccessConnectionString(accessFile)))
                // Initialize the connection to the server using the connection string.
                {
                    // Open the DB connection, we do this here so we can instantly be able to use SQL commands in the code. 
                    connection.Open();
                    // create the command object and automatically associate it with the connection 
                    using (OleDbCommand cmd = connection.CreateCommand())
                    {
                        var table = new System.Data.DataTable("tblEmployees");              // Create the table
                        cmd.CommandText = "select * from [tblEmployees] where [ID] = @ID";      // Set up the SQL command object
                            // Use parameterized SQL queries because of the security risk that exposes the application to SQL injection attacks. 
                            var par = cmd.CreateParameter();
                            cmd.Parameters.Add(par);
                            par.ParameterName = "@ID";
                            par.DbType = DbType.UInt32;
                            par.Value = id;
                        cmd.Connection = connection;
                        using (var dataReader = cmd.ExecuteReader())
                        {
                            table.Load(dataReader); // Load data from the table
                        }
                        if (table.Rows.Count > 0)
                            row = table.Rows[0]; // The first row has the result by given Id.
                        else
                            row = null; 
                    }
                }
            return row; 
            }
            else
            {
                return null;
            }
        }

        public int CountRows()
        {
            if (IsDisposed)        // If it was previously disposed
                throw new ObjectDisposedException("This method was called because it was previously disposed");
            // DONE: This method uses 
            // a SQL statement(SELECT count(*) FROM[tblEmployees]) to
            // count the number of entries in the source table
            var table = new System.Data.DataTable("tblEmployees");
            var rowCount = 0;
            if (!this.noDatabase)
            {
                // Safely wrap the connection string with a using statement
                using (OleDbConnection connection = new OleDbConnection(Util.GetAccessConnectionString(accessFile)))
                // Initialize the connection to the server using the connection string.
                {
                    // Open the DB connection, we do this here so we can instantly be able to use SQL commands in the code. 
                    connection.Open();
                    // Create the command object and automatically associate it with the connection 
                    using (OleDbCommand command = connection.CreateCommand())
                    {
                        command.CommandText = "select count(*) from [tblEmployees]";      // Set up the SQL command object
                        command.Connection = connection;
                        rowCount = int.Parse(command.ExecuteScalar().ToString().Trim());
                    }
                }
            }
            return rowCount;
        }

        public void Dispose()
        {
            // DONE: This method must set the IsDisposed variable to true once called.  
            // Once this variable is set to true, further calls to the other
            // methods will throw ObjectDisposedExceptions
            IsDisposed = true; 
        }

        public DataTable GetData()
        {
            // DONE: This method uses a SQL statement (SELECT* FROM[tblEmployees]) to load all data
            // from the database table as a DataTable and returns it back to the caller

            // ThrowObjectDisposedExceptionAfterBeingDisposed
            if (IsDisposed)        // If it was previously disposed
                throw new ObjectDisposedException("This method was called because it was previously disposed");

            // Create a data table 
            var table = new System.Data.DataTable("tblEmployees");
            if (!this.noDatabase) {
                // Safely wrap the connection string with a using statement
                using (OleDbConnection connection = new OleDbConnection(Util.GetAccessConnectionString(accessFile)))
                // Initialize the connection to the server using the connection string.
                {
                    // Open the DB connection, we do this here so we can instantly be able to use SQL commands in the code. 
                    connection.Open();
                    // create the command object and automatically associate it with the connection 
                    using (OleDbCommand command = connection.CreateCommand())
                    {
                        command.CommandText = "select * from [tblEmployees]";      // Set up the SQL command object
                        command.Connection = connection;
                        using (var dataReader = command.ExecuteReader())
                        {
                            table.Load(dataReader);
                        }
                    }
                }
            }
            return table;
        }

        public void UpdateRow(DataRow row)
        {
            // DONE: This method is a new method added to the IPersistData interface due to the 
            // requirement that the application be able to modify content in the database.  It must make use of the 
            // OleDbConnection, OleDbCommand and 
            // a SQL statement (UPDATE [tblEmployees] SET [Company] = @Company, [Last Name] = @LastName,[First Name] = @FirstName,
            // [E-mail Address] = @EmailAddress,[Job Title] = @JobTitle,[Business Phone] = @BusinessPhone WHERE [ID] = @ID) 
            // to make modifications to the database.

            // ThrowObjectDisposedExceptionAfterBeingDisposed
            if (IsDisposed)        // If it was previously disposed
                throw new ObjectDisposedException("This method was called because it was previously disposed.");
            // Create a data table 
            var table = new System.Data.DataTable("tblEmployees");
            if (!this.noDatabase)
            {
                // Safely wrap the connection string with a using statement
                using (OleDbConnection connection = new OleDbConnection(Util.GetAccessConnectionString(accessFile)))
                // Initialize the connection to the server using the connection string.
                {
                    // Open the DB connection, we do this here so we can instantly be able to use SQL commands in the code. 
                    connection.Open();
                    // UpdateMissingRecordThrowsException
                    int rownum = (int)row["ID"];
                    if (rownum < 0)
                        throw new ArgumentException("An invalid value. Try it again.");

                    // Create the command object and automatically associate it with the connection 
                    using (OleDbCommand command = connection.CreateCommand())
                    {
                        command.CommandText = "UPDATE [tblEmployees] SET [Company] = @Company, [Last Name] = @LastName,[First Name] = @FirstName,[E-mail Address] = @EmailAddress,[Job Title] = @JobTitle,[Business Phone] = @BusinessPhone WHERE [ID] = @ID";      // Set up the SQL command object

                        // Create Parameters 
                        var companyPar = command.CreateParameter();
                        companyPar.ParameterName = "@Company";
                        companyPar.DbType = DbType.String;
                        companyPar.Value = row["Company"]; 
                        command.Parameters.Add(companyPar);

                        var lnPar = command.CreateParameter();
                        lnPar.ParameterName = "@LastName";
                        lnPar.DbType = DbType.String;
                        lnPar.Value = row["Last Name"];
                        command.Parameters.Add(lnPar);

                        var fnPar = command.CreateParameter();
                        fnPar.ParameterName = "@FirstName";
                        fnPar.DbType = DbType.String;
                        fnPar.Value = row["First Name"];
                        command.Parameters.Add(fnPar);

                        var emailPar = command.CreateParameter();
                        emailPar.ParameterName = "@EmailAddress";
                        emailPar.DbType = DbType.String;
                        emailPar.Value = row["E-mail Address"];
                        command.Parameters.Add(emailPar);

                        var jobPar = command.CreateParameter();
                        jobPar.ParameterName = "@JobTitle";
                        jobPar.DbType = DbType.String;
                        jobPar.Value = row["job Title"];
                        command.Parameters.Add(jobPar);

                        var businessPar = command.CreateParameter();
                        businessPar.ParameterName = "@BusinessPhone";
                        businessPar.DbType = DbType.String;
                        businessPar.Value = row["Business Phone"];
                        command.Parameters.Add(businessPar);

                        var idPar = command.CreateParameter();
                        idPar.ParameterName = "@ID";
                        idPar.DbType = DbType.UInt32;
                        idPar.Value = row["ID"];
                        command.Parameters.Add(idPar);

                        // Update the value and give the status of update 
                        var rowsAffacted = command.ExecuteNonQuery();

                    }
                }
            }
        }
    }
}
