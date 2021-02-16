# PresidentsDatabase

The database is designed efficiently, and organized, to include information referencing current and past President(s) Of the United States. Notable information that we plan to display in the database includes, but is not limited to, political affiliation, date of birth, date of death, time served in office, economic status, notable actions, height, weight, which party controlled the senate and house, and their Vice President. This topic was chosen to help visualize interesting aspects of previous United States Presidents, and to evaluate them side-by-side.

## Table of Contents 
* [Requirements](#Requirements)
* [Installation](#Installation)
* [ERM](#EntityRelationshipDiagram)
* [Views](#Views)



## Requirements 

Some familiarity with MySQL and setting up a local connection 

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


## Entity Relationship Diagram

In order to better understand and create an efficient database an ERD was established. As the database went through modifications the main priority was applying database normalization in order to prevent repetitive data.

<img src="https://github.com/nitromacchiato/PresidentsDatabase/blob/main/demo/president_erd.png" />






## Views 

* How does the President’s height compare to the First Lady?
<img src="https://github.com/nitromacchiato/PresidentsDatabase/blob/main/demo/first_lady_president_view.PNG" />

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
</br>




* How does the Presidents age compare to the Vice presidents at the end of their terms through the years of presidency?
</br>
<img src="https://github.com/nitromacchiato/PresidentsDatabase/blob/main/demo/avg_pres_age.PNG" />

```sql
CREATE OR REPLACE VIEW Avg_pres_age
	AS
		SELECT CONCAT(PI.first_name, ", ", PI.last_name) AS "President Name",
		       CONCAT(VP.vp_first_name, ", ", VP.vp_last_name) AS "Vice President Name",
		       ROUND((DATEDIFF(PS.term_year_end, PI.DoB) / 365), 0) AS "President Age",
			   ROUND((DATEDIFF(PS.term_year_end, VP.DoB) / 365), 0) AS "Vice President Age"
		FROM President_info AS PI
			JOIN Vice_president AS VP
				ON PI.president_id = VP.accompanying_president
			JOIN Political_stats AS PS
				ON PS.president_id = PI.president_id
		ORDER BY PI.president_id;
```
</br>




* How many times has one party controlled both the senate and the house?
<img src="https://github.com/nitromacchiato/PresidentsDatabase/blob/main/demo/party_control.PNG" />

```sql
CREATE OR REPLACE VIEW Party_control
	AS
		SELECT president_id AS "President Num",
			   CONCAT(first_name, ", ", last_name) AS "President Name",
			   political_affiliation AS "Political Affiliation",
			   majority_house AS "House Majority",
			   majority_senate AS "Senate Majority"
		FROM President_info AS PI
			JOIN Political_stats AS PS
				USING(president_id)
			JOIN Majority AS M
				USING(president_id)
		WHERE PS.political_affiliation = M.majority_house
			AND
			  PS.political_affiliation = M.majority_senate
		ORDER BY M.majority_house, M.majority_senate;
```