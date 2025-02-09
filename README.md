## Database Programming with SQL

This document serves as a beginner's guide to database programming using SQL (Structured Query Language). SQL is a standard language for accessing and manipulating databases[1]. It is used to store, query, and manipulate data in a relational database[3].

### Introduction to SQL

SQL is a special-purpose programming language designed for managing data in a relational database[3]. SQL allows you to execute queries, retrieve data, insert records, update records, delete records, create new databases and tables, create stored procedures and views, and set permissions on tables[1]. SQL is the standard language for relational database management systems (RDBMS) such as MS SQL Server, IBM DB2, Oracle, MySQL, and Microsoft Access[1].

SQL enables users to perform CRUD (create, read, update, and delete) operations on relational databases[7].

The most common SQL statements include[2]:
*   **SELECT**: Retrieves data from one or more tables.
*   **INSERT**: Adds new data into a table.
*   **UPDATE**: Modifies existing data in a table.
*   **DELETE**: Removes data from a table.

A basic `SELECT` statement consists of the following[2]:

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

*   `SELECT` specifies the columns you want to retrieve from the table.
*   `FROM` specifies the table you want to retrieve data from.
*   `WHERE` (optional) specifies the conditions for filtering the data.

### Modifying Data

SQL allows modification of data stored in a database[2].

To add new data into a table, use the `INSERT` statement[2]:

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

This statement inserts a new row into `table_name` with the specified values for `column1`, `column2`, and so on[2].

### Additional Topics

Further topics to explore in database programming with SQL include:

*   Functions
*   Procedures
*   Cursors
*   Data insertion
*   Data manipulation
*   Classification
*   Conversion[2]

Citations:
[1] https://www.w3schools.com/sql/sql_intro.asp
[2] https://github.com/s-shemmee/SQL-101
[3] https://www.khanacademy.org/computing/computer-programming/sql
[4] https://github.com/PacktPublishing/learn-sql-database-programming/blob/master/README.md
[5] https://www.udacity.com/blog/2021/02/sql-tutorial-database-programming.html
[6] http://repo.darmajaya.ac.id/4996/1/Practical%20Database%20Programming%20with%20Java%20(%20PDFDrive%20).pdf
[7] https://www.programiz.com/sql/database-introduction
[8] https://www.academia.edu/8701727/Practical_Database_Programming_With_Java
[9] https://erieit.edu/introduction-guide-to-database-programming/
