# Data Warehouse

All of the data about staff are currently being held in one big SQL table that you can create locally by running staff.sql.

## Skills

- Implement a star schema
- Implement an ERD
- Understand the difference between OLTP and OLAP databases
- Understand the purpose of an OLAP data warehouse
- Understand design elements of a data warehouse
- Understand the difference between FACTS and DIMENSIONS
- Understand the design of a star schema

### Building a Star Schema

In order to make the database easier and more more efficient to analyse, there is a need to redesign the database into a star schema.
This involves creating new tables in the database to organise the data into the star schema format.

Things to consider:

- dimensions - which hold data that answer these types of questions: what can we extract? What metrics will these allow us to measure?
- facts - with data that answer this types of questions: what does this table look like? How can we create the link to dimensions?
ic