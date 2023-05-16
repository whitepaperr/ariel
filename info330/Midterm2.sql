-- Which climber has climbed the most routes at the gym? Return cid, name, and number of routes. (5pt)
SELECT TOP 1 c.cid, c.name, COUNT(cr.rid) AS NumOfRoutes
FROM Climber c
JOIN ClimberRoute cr ON c.cid = cr.cid
GROUP BY c.cid, c.name
Order BY NumOfRoutes DESC;

-- What is the average age of climbers who have climbed routes with a difficulty rating of 'V4'? Return the average. (5pt)
SELECT AVG(DATEDIFF(year, c.dob, GETDATE())) AS AverageAge
FROM Climber c
WHERE c. cid
    IN(SELECT cr.cid
    FROM ClimberRoute cr
    WHERE cr.rid
        IN(SELECT r.rid
        FROM Route r
        WHERE r.rating = 'V4'
    )
);

-- (Subquery in WHERE REQUIRED) Find all routes that have at least 3 holds. Return rid, name, and rating. (10pt)
SELECT *
FROM Route r
WHERE r.rid
    IN(SELECT p.rid
    FROM Placement p
    GROUP BY p.rid
    HAVING COUNT(p.hid) >= 3
);

/* (Could use CTE or SELF_JOIN) A conflict is when two different holds occupy the same slot. 
    A set of routes are compatible if they have no conflicts. 
    Write a query to check that all the routes with the rating ‘VB’ (for "Beginner") are compatible. 
    Return the list of unique slot ids (sid) that are causing a conflict. (10pt) 
*/
SELECT DISTINCT s.sid
FROM Slot s
JOIN Placement p ON s.sid = p.sid
JOIN Route r ON p.rid = r.rid
WHERE r.rating = 'VB'
GROUP BY s.sid
HAVING COUNT(DISTINCT r.rid) > 1;

/* (Could use CTE) A route is consistent if every hold has the same color, which indicates difficulty. 
    Write a query that returns a list of route ids (rid) that are consistent. 
    Return route ids associated with holds of only one color. (10pt)
*/
SELECT r.rid
FROM Route r
JOIN Placement p ON r.rid = p.rid
JOIN Hold h ON p.hid = h.hid
GROUP BY r.rid
HAVING COUNT(DISTINCT h.color) = 1;

/* (Could use CTE or Subquery in FROM/JOIN) Building upon your previous query, write a query to compute the number of routes of each color. 
    You can still get credit for this query if your previous query does not work. 
    Return color and num_routes. Note that the number of holds of each color is not what we want; we want the number of routes. (10pt)
*/
SELECT h.color, COUNT(DISTINCT r.rid) AS num_routes
FROM Route r
JOIN Placement p ON r.rid = p.rid
JOIN Hold h ON p.hid = h.hid
GROUP BY h.color;