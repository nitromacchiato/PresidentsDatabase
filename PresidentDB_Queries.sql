-- How does the President’s height compare to the First Lady?
-- A, B, D
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




-- How many times has one party controlled both the senate and the house?
-- A, B, D
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
        
        
-- How does the Presidents age compare to the Vice presidents at the end of their terms through the years of presidency?
-- A, B, C, D
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

                
-- Which Vice Presidents became President?
-- B, D, E
CREATE OR REPLACE VIEW Vice_to_President
	AS
		SELECT CONCAT(vp_first_name, ", ", vp_last_name) AS "President Name"
        FROM Vice_president AS VP
		WHERE VP.vp_first_name IN (SELECT PI.first_name
					               FROM President_info AS PI)
		ORDER BY VP.vice_president_id;

-- What is the average age of Presidents when they take office?
-- A, C, D, 
CREATE OR REPLACE VIEW Age_at_Office
	AS
		SELECT ROUND(AVG(ROUND((DATEDIFF(PS.term_year_start, PI.DoB) / 365), 0)), 0) AS "Average President Age Taking Office"
        FROM President_info AS PI
			INNER JOIN Political_stats AS PS
				ON PS.president_id = PI.president_id;
			   


                
                
                
                
                