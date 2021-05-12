#Insert all values - Populating Tables (C)

#OWNER VALUES
INSERT INTO OWNER VALUES (1, 'Mary Jones', 'Mary.Jones@somewhere.com', 'Individual');
INSERT INTO OWNER VALUES (2, 'DT Enterprises', 'DTE@dte.com', 'Corporation');
INSERT INTO OWNER VALUES (3, 'Sam Douglas', 'Sam.Douglas@somewhere.com', 'Individual');
INSERT INTO OWNER VALUES (4, 'UNY Enterprises', 'UNYE@unye.com', 'Corporation');
INSERT INTO OWNER VALUES (5, 'Doug Samuels', 'Doug.Samuels@somewhere.com', 'Individual');

#OWNED_PROPERTY VALUES
INSERT INTO OWNED_PROPERTY VALUES (1, 'Eastlake Building', 'Office', '123 Eastlake',
	'Seattle', 'WA', '98119', 2); 
INSERT INTO OWNED_PROPERTY VALUES (2, 'Elm St Apts', 'Apartments', '4 East Elm',
	'Lynwood', 'WA', '98223', 1);
INSERT INTO OWNED_PROPERTY VALUES (3, 'Jefferson Hill', 'Office', '42 West 7th St',
	'Bellevue', 'WA', '98007', 2);
INSERT INTO OWNED_PROPERTY VALUES (4, 'Lake View Apts', 'Apartments', '1265 32nd Avenue',
	'Redmond', 'WA', '98052', 3);
INSERT INTO OWNED_PROPERTY VALUES (5, 'Kodak Heights Apts', 'Apartments', '65 32nd Avenue',
	'Redmond', 'WA', '98052', 4);
INSERT INTO OWNED_PROPERTY VALUES (6, 'Jones House', 'Private Residence', '1456 48th St',
	'Bellevue', 'WA', '98007', 1);
INSERT INTO OWNED_PROPERTY VALUES (7, 'Douglas House', 'Private Residence', '1567 51st St',
	'Bellevue', 'WA', '98007', 3);
INSERT INTO OWNED_PROPERTY VALUES (8, 'Samuels House', 'Private Residence', '567 151st St',
	'Redmond', 'WA', '98052', 5);
    
#EMPLOYEE VALUES
INSERT INTO EMPLOYEE VALUES (1, 'Smith', 'Sam', '206-254-1234', 'Master');
INSERT INTO EMPLOYEE VALUES (2, 'Evanston', 'John', '206-254-2345', 'Senior');
INSERT INTO EMPLOYEE VALUES (3, 'Murray', 'Dale', '206-254-3456', 'Junior');
INSERT INTO EMPLOYEE VALUES (4, 'Murphy', 'Jerry', '585-545-8765', 'Master');
INSERT INTO EMPLOYEE VALUES (5, 'Fontaine', 'Joan', '206-254-4567', 'Senior');

#CG_SERVICE VALUES
INSERT INTO CG_SERVICE VALUES (1, 'Mow Lawn', 25.00);
INSERT INTO CG_SERVICE VALUES (2, 'Plant Annuals', 25.00);
INSERT INTO CG_SERVICE VALUES (3, 'Weed Garden', 35.00);
INSERT INTO CG_SERVICE VALUES (4, 'Trim Hedge', 45.00);
INSERT INTO CG_SERVICE VALUES (5, 'Prune Small Tree', 60.00);
INSERT INTO CG_SERVICE VALUES (6, 'Trim Medium Tree', 100.00);
INSERT INTO CG_SERVICE VALUES (7, 'Trim Large Tree', 125.00);

#PROPERTY_SERVICE VALUES
INSERT INTO PROPERTY_SERVICE VALUES (1, 1, 2, '2019-05-05', 1, 4.50);
INSERT INTO PROPERTY_SERVICE VALUES (2, 3, 2, '2019-05-08', 3, 4.50);
INSERT INTO PROPERTY_SERVICE VALUES (3, 2, 1, '2019-05-08', 2, 2.75);
INSERT INTO PROPERTY_SERVICE VALUES (4, 6, 1, '2019-05-10', 5, 2.50);
INSERT INTO PROPERTY_SERVICE VALUES (5, 5, 4, '2019-05-12', 4, 7.50);
INSERT INTO PROPERTY_SERVICE VALUES (6, 8, 1, '2019-05-15', 4, 2.75);
INSERT INTO PROPERTY_SERVICE VALUES (7, 4, 4, '2019-05-19', 1, 1.00);
INSERT INTO PROPERTY_SERVICE VALUES (8, 7, 1, '2019-05-21', 2, 2.50);
INSERT INTO PROPERTY_SERVICE VALUES (9, 6, 3, '2019-06-03', 5, 2.50);
INSERT INTO PROPERTY_SERVICE VALUES (10, 5, 7, '2019-06-08', 4, 10.50);
INSERT INTO PROPERTY_SERVICE VALUES (11, 8, 3, '2019-06-12', 4, 2.75);
INSERT INTO PROPERTY_SERVICE VALUES (12, 4, 5, '2019-06-15', 1, 5.00);
INSERT INTO PROPERTY_SERVICE VALUES (13, 7, 3, '2019-06-19', 2, 4.00);

#SQL statements from book for final project

#Return LastName, FirstName, and CellPhone for all employees with an experience level of Master (E)
SELECT LastName, FirstName, CellPhone
FROM EMPLOYEE
WHERE ExperienceLevel = 'Master';

#Return LastName, FirstName, and CellPhone for all employees having an expereince level of Master
#and the FirstName begins with J (F)
SELECT LastName, FirstName, CellPhone
FROM EMPLOYEE
WHERE ExperienceLevel = 'Master' 
AND FirstName Like 'J%';

#Return LastName, FirstName, and CellPhone of employees who worked on a property in Seattle
#must use a Subquery (G)
SELECT LastName, FirstName, CellPhone
FROM EMPLOYEE, PROPERTY_SERVICE, OWNED_PROPERTY
WHERE EMPLOYEE.EmployeeID = PROPERTY_SERVICE.EmployeeID
	AND PROPERTY_SERVICE.PropertyID = OWNED_PROPERTY.PropertyID
    AND City = 'Seattle';
    
#Use a JOIN ON/JOIN or JOIN within the WHERE clause for G (H)
SELECT LastName, FirstName, CellPhone
FROM EMPLOYEE AS EMPLOYEE JOIN PROPERTY_SERVICE AND
PROPERTY_SERVICE AS PROPERTY_SERVICE JOIN OWNED_PROPERTY
ON EMPLOYEE.EmployeeID = PROPERTY_SERVICE.EmployeeID
ON PROPERTY_SERVICE.PropertyID = OWNED_PROPERTY.PropertyID
WHERE City = 'Seattle';


#Return LastName, FirstName, and CellPhone of employees who worked on a property
#owned by a corporation. Use a Subquery (I)
#If you do not put distinct you will get some that return multiple times
SELECT DISTINCT LastName, FirstName, CellPhone
FROM EMPLOYEE, PROPERTY_SERVICE, OWNED_PROPERTY, OWNER
WHERE EMPLOYEE.EmployeeID = PROPERTY_SERVICE.EmployeeID
	AND PROPERTY_SERVICE.PropertyID = OWNED_PROPERTY.PropertyID
    AND OWNED_PROPERTY.OwnerID = OWNER.OwnerID
    AND OwnerType = 'Corporation';
    
#Return LastName, FirstName, CellPhone, and the sum of hours worked for each employee (K)
SELECT LastName, FirstName, CellPhone, SUM(HoursWorked)
FROM EMPLOYEE, PROPERTY_SERVICE
WHERE EMPLOYEE.EmployeeID = PROPERTY_SERVICE.EmployeeID
GROUP BY PROPERTY_SERVICE.EmployeeID;

#Return Sum of HoursWorked for each ExperienceLevel of EMPLOYEE
#sort by ExperienceLevel descending (L)
SELECT ExperienceLevel, SUM(HoursWorked)
FROM EMPLOYEE, PROPERTY_SERVICE
WHERE EMPLOYEE.EmployeeID = PROPERTY_SERVICE.EmployeeID
GROUP BY EMPLOYEE.ExperienceLevel
ORDER BY EMPLOYEE.ExperienceLevel DESC;


#Write a statement to modify all EMPLOYEE rows with ExperienceLevel of Master
#to SuperMaster (N)
UPDATE EMPLOYEE 
SET ExperienceLevel = 'SuperMaster'
WHERE ExperienceLevel = 'Master'; 


	