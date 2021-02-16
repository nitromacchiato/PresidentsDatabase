# PresidentsDatabase

The database is designed efficiently, and organized, to include information referencing current and past President(s) Of the United States. Notable information that we plan to display in the database includes, but is not limited to, political affiliation, date of birth, date of death, time served in office, economic status, notable actions, height, weight, which party controlled the senate and house, and their Vice President. This topic was chosen to help visualize interesting aspects of previous United States Presidents, and to evaluate them side-by-side.

## Table of Contents 
* [Requirements](#Requirements)
* [Installation](#Installation)
* [Examples](#Examples)



## Requirements 

Some familiarty with MySQL and setting up a local connection 

* [MySQLWorkbench](https://dev.mysql.com/downloads/workbench/)
* [MySQLCommunity](https://dev.mysql.com/downloads/mysql/)


## Installation 
1. Download and open or copy [PreisdentsDB](https://github.com/nitromacchiato/PresidentsDatabase/blob/main/PresidentDB.sql)

2. Open [MySQLWorkbench](https://dev.mysql.com/downloads/workbench/) and connect/create your local connection

3. Open/Paste the SQL script and click the first thunderbolt to execute the enitre script  </br> 
    Trouble locating thunderbolt? 
    At the top Select Query -> Execute(All or Selected) 

4. Refresh your schema 

* [PresidentDB_Quries](https://github.com/nitromacchiato/PresidentsDatabase/blob/main/PresidentDB_Queries.sql) are automatically install [PreisdentsDB](https://github.com/nitromacchiato/PresidentsDatabase/blob/main/PresidentDB.sql)


## Examples 

### Views 

How does the President’s height compare to the First Lady?


<img src="demo/first_lady_president.png" />


```sql 
CREATE OR REPLACE VIEW President_VS_Lady_height
	AS
		SELECT CONCAT(PI.first_name, ", ", PI.last_name) AS "President Name",
		       PI.height AS "President Height",
			   CONCAT(FL.first_name, ", ", FL.last_name) AS "First Lady",
			   FL.height AS "First Lady Height"
		FROM President_info AS PI
			INNER JOIN First_lady AS FL
				ON PI.president_id = FL.accompanying_president
		ORDER BY PI.height DESC, FL.height DESC;

```



