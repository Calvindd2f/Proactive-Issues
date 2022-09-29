# Getting sick of this.

- Below are templates / reminders.
- Solutions will be in .ps1 files.
- Remember to edit the actual names as they will be generic.


                    Add-OdbcDsn -DriverName "SQL Server" -DsnType User -Name "Client" -Platform 32-bit

                    Disable-OdbcPerfCounter -InputObject

                    Get-OdbcDriver -Name "SQL Server" -Platform All


                    Get-OdbcDriver -Name "SQL Server Native Client 10.0" -Platform All

                    Get-OdbcDriver -Name "SQL Server Native Client 11.0" -Platform All

                    #Example 1: Add a 32-bit ODBC User DSN
                    Add-OdbcDsn -Name "MyPayroll" -DriverName "Microsoft Access Driver (*.mdb, *.accdb)" -DsnType "User" -Platform "32-bit" -SetPropertyValue 'Dbq=C:\mydatabase.accdb'
                    #Example 2: Add an ODBC System DSN
                    Add-OdbcDsn -Name "MyPayroll" -DriverName "SQL Server Native Client 10.0" -DsnType "System" -SetPropertyValue @("Server=MyServer", "Trusted_Connection=Yes", "Database=Payroll")
                    #Example 3: Add and store an ODBC System DSN
                    $NewDsn = Add-OdbcDsn -Name "MyPayroll" -DriverName "SQL Server Native Client 10.0" -DsnType "System" -SetPropertyValue @("Server=MyServer", "Trusted_Connection=Yes", "Database=Payroll") -PassThru




                    #Example 4: Migrates DSNs to a newer version of a driver
                    $DsnArray = Get-OdbcDsn -DriverName 'SQL Server Native Client 10.0'
                    ForEach ($Dsn in $ DsnArr) {
                              Remove-OdbcDsn -InputObject $Dsn 
                              # You can change the property array as well, 
                              # if DSN attributes have been changed in the new driver version

                    Add-OdbcDsn -Name $Dsn.Name -DsnType $Dsn.DsnType -Platform $Dsn.Platform -DriverName 'SQL Server Native Client 12.0' -SetPropertyValue $Dsn.PropertyValue
                    }

                    #Example 3: Add and store an ODBC System DSN
                    $NewDsn = Add-OdbcDsn -Name "Client" -DriverName "SQL Server Native Client 10.0" -DsnType "System" -SetPropertyValue @("Server=SQLSERVER", "Trusted_Connection=Yes", "Database=Client", "Description=Client") -PassThru 
