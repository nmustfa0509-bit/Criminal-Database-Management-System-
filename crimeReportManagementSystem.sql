CREATE DATABASE CriminalCaseManagement;
USE CriminalCaseManagement;

CREATE TABLE FIR(
FIR_ID INT PRIMARY KEY,
CrimeType VARCHAR(50) NOT NULL,
WeaponUsed VARCHAR(50),
TimeOfCrime TIME NOT NULL,
CrimeDate DATE NOT NULL,
SeverityLevel VARCHAR(20) CHECK(SeverityLevel IN ('Low','Medium','High','Critical')),
Status VARCHAR(20) DEFAULT 'Open',
Location VARCHAR(100) NOT NULL,
ReportedByFirstName VARCHAR(100) NOT NULL,
ReportedBylastName VARCHAR(100) NOT NULL
);

CREATE TABLE Officer(
Officer_ID INT PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
RankName VARCHAR(30),
Department VARCHAR(40),
BadgeNo VARCHAR(20) UNIQUE,
ContactNo VARCHAR(15) UNIQUE,
Specialization VARCHAR(50),
YearsOfService INT CHECK(YearsOfService >= 0)
);

CREATE TABLE Criminal(
Criminal_ID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Alias VARCHAR(50),
CNIC VARCHAR(20) UNIQUE NOT NULL,
Nationality VARCHAR(30) DEFAULT 'Pakistani',
Gender VARCHAR(10) CHECK(Gender IN ('Male','Female')),
Age INT CHECK(Age >= 18),
RiskLevel VARCHAR(20),
Is_Arrested VARCHAR(5) CHECK(Is_Arrested IN ('Yes','No')),
CrimeHistory VARCHAR(200),
Area VARCHAR(100),
City VARCHAR(30),
Province VARCHAR(30)
);

CREATE TABLE Victim(
Victim_ID INT PRIMARY KEY,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
Gender VARCHAR(10),
Age INT CHECK(Age > 0),
ContactNo VARCHAR(15),
MedicalStatus VARCHAR(50),
InjuryDescription VARCHAR(200),
Area VARCHAR(100),
City VARCHAR(30),
Province VARCHAR(30)
);

CREATE TABLE Investigation(
Investigation_ID INT PRIMARY KEY,
FIR_ID INT,
Officer_ID INT NULL,
Investigation_Date DATE,
ReportStatus VARCHAR(30),
EvidenceFound VARCHAR(100),
WitnessCount INT DEFAULT 0,
LabReport_ID INT UNIQUE,
FOREIGN KEY(FIR_ID) REFERENCES FIR(FIR_ID) ON DELETE CASCADE,
FOREIGN KEY(Officer_ID) REFERENCES Officer(Officer_ID) ON DELETE SET NULL
);

CREATE TABLE CaseReport(
Report_ID INT PRIMARY KEY,
FIR_ID INT UNIQUE,
Criminal_ID INT NULL,
Victim_ID INT NULL,
CourtDate DATE,
Verdict VARCHAR(50),
ClosedDate DATE,
CaseStatus VARCHAR(20),
FOREIGN KEY(FIR_ID) REFERENCES FIR(FIR_ID) ON DELETE CASCADE,
FOREIGN KEY(Criminal_ID) REFERENCES Criminal(Criminal_ID) ON DELETE SET NULL,
FOREIGN KEY(Victim_ID) REFERENCES Victim(Victim_ID) ON DELETE SET NULL
);

ALTER TABLE Criminal ADD BloodGroup VARCHAR(5);

ALTER TABLE Officer MODIFY Specialization VARCHAR(100);

ALTER TABLE Criminal DROP COLUMN BloodGroup;

ALTER TABLE Victim ADD CONSTRAINT chk_medical CHECK(MedicalStatus IN ('Stable','Critical','Recovered'));

RENAME TABLE Officer TO PoliceOfficer;

RENAME TABLE PoliceOfficer TO Officer;

TRUNCATE TABLE Investigation;

CREATE TABLE TemporaryTable(
TempID INT
);

DROP TABLE IF EXISTS TemporaryTable;

INSERT INTO FIR VALUES
(1,'Robbery','Pistol','22:30:00','2025-01-10','High','Open','Lahore','Ahmed','Khan'),
(2,'Murder','Knife','20:00:00','2025-01-11','Critical','Closed','Karachi','Bilal','Ahmed'),
(3,'Cyber Crime','Laptop','13:00:00','2025-01-12','Medium','Open','Islamabad','Usman','Ali'),
(4,'Kidnapping','Gun','18:00:00','2025-01-13','Critical','Open','Multan','Ali','Raza'),
(5,'Fraud','Documents','12:00:00','2025-01-14','Medium','Closed','Faisalabad','Hamza','Siddiqui'),
(6,'Theft','None','09:00:00','2025-01-15','Low','Open','Peshawar','Daniyal','Khan'),
(7,'Drug Smuggling','Truck','03:00:00','2025-01-16','Critical','Open','Quetta','Ayan','Malik'),
(8,'Assault','Bat','16:30:00','2025-01-17','Medium','Closed','Rawalpindi','Saad','Hussain'),
(9,'Extortion','Phone','14:00:00','2025-01-18','High','Open','Sialkot','Kashif','Iqbal'),
(10,'Burglary','Crowbar','01:00:00','2025-01-19','Medium','Open','Hyderabad','Waqas','Shah'),
(11,'Robbery','Gun','22:00:00','2025-01-20','High','Closed','Lahore','Rehan','Butt'),
(12,'Cyber Crime','Mobile','15:00:00','2025-01-21','Medium','Open','Karachi','Tariq','Javed'),
(13,'Murder','Pistol','23:00:00','2025-01-22','Critical','Open','Islamabad','Noman','Akhtar'),
(14,'Fraud','Documents','11:00:00','2025-01-23','Low','Closed','Multan','Fahad','Rashid'),
(15,'Kidnapping','Van','19:00:00','2025-01-24','Critical','Open','Peshawar','Junaid','Qureshi');

INSERT INTO Officer VALUES
(1,'Ali','Khan','Inspector','Investigation','B101','03001111111','Cyber Crime',10),
(2,'Ahmed','Raza','DSP','Operations','B102','03002222222','Murder Cases',15),
(3,'Usman','Tariq','Inspector','Traffic','B103','03003333333','Traffic Control',7),
(4,'Hamza','Saeed','SI','Investigation','B104','03004444444','Fraud Cases',5),
(5,'Bilal','Qureshi','DSP','Operations','B105','03005555555','Drug Cases',12),
(6,'Adeel','Malik','Inspector','Investigation','B106','03006666666','Robbery Cases',9),
(7,'Saad','Khan','SI','Traffic','B107','03007777777','Traffic Control',4),
(8,'Hassan','Rauf','Inspector','Cyber Crime','B108','03008888888','Cyber Security',11),
(9,'Farhan','Ali','DSP','Investigation','B109','03009999999','Forensics',13),
(10,'Kamran','Yousaf','SI','Operations','B110','03001231231','Kidnapping Cases',6),
(11,'Tariq','Nawaz','Inspector','Operations','B111','03004564564','Drug Cases',8),
(12,'Shahzaib','Iqbal','SI','Investigation','B112','03007897897','Fraud Cases',3),
(13,'Imran','Khalid','DSP','Cyber Crime','B113','03003453453','Cyber Crime',14),
(14,'Rizwan','Aslam','Inspector','Investigation','B114','03006546546','Murder Cases',10),
(15,'Noman','Zafar','SI','Operations','B115','03009879879','Robbery Cases',2);


INSERT INTO Criminal VALUES
(1,'Javed Ali','Shadow','35201-1111111-1','Pakistani','Male',35,'High','Yes','Robbery Cases','Model Town','Lahore','Punjab'),
(2,'Salman Khan','Tiger','35201-2222222-2','Pakistani','Male',40,'Critical','Yes','Murder Cases','Gulshan','Karachi','Sindh'),
(3,'Ayesha Noor','Queen','35201-3333333-3','Pakistani','Female',29,'Medium','No','Cyber Crime','F-10','Islamabad','ICT'),
(4,'Bilal Ahmed','Don','35201-4444444-4','Pakistani','Male',32,'High','Yes','Kidnapping','Cantt','Lahore','Punjab'),
(5,'Kamran Shah','Boss','35201-5555555-5','Pakistani','Male',38,'Medium','No','Fraud','Satellite Town','Rawalpindi','Punjab'),
(6,'Naveed','Hunter','35201-6666666-6','Pakistani','Male',27,'Low','Yes','Theft','Hayatabad','Peshawar','KPK'),
(7,'Adeel','Ghost','35201-7777777-7','Pakistani','Male',45,'Critical','Yes','Drug Smuggling','Jinnah Town','Quetta','Balochistan'),
(8,'Hina Tariq','Rose','35201-8888888-8','Pakistani','Female',30,'Medium','No','Fraud','DHA','Karachi','Sindh'),
(9,'Rehan','Cobra','35201-9999999-9','Pakistani','Male',33,'High','Yes','Extortion','Gulberg','Lahore','Punjab'),
(10,'Asim','Sniper','35201-1010101-0','Pakistani','Male',37,'Critical','Yes','Murder','Johar Town','Lahore','Punjab'),
(11,'Sajid','Falcon','35201-1212121-1','Pakistani','Male',31,'Medium','No','Cyber Crime','Bahria Town','Rawalpindi','Punjab'),
(12,'Usama','Wolf','35201-1313131-2','Pakistani','Male',28,'Low','Yes','Burglary','Latifabad','Hyderabad','Sindh'),
(13,'Fahad','King','35201-1414141-3','Pakistani','Male',42,'Critical','Yes','Drug Smuggling','University Road','Peshawar','KPK'),
(14,'Mariam','Black Widow','35201-1515151-4','Pakistani','Female',34,'High','No','Fraud','Blue Area','Islamabad','ICT'),
(15,'Haris','Blade','35201-1616161-5','Pakistani','Male',26,'Medium','Yes','Robbery','Cantt','Sialkot','Punjab');

INSERT INTO Criminal VALUES
(16,'Test Criminal','X','35201-1717171-6','Pakistani','Male',30,'Low','No','Test Crime','Area','Gujranwala','Punjab');

INSERT INTO Victim VALUES
(1,'Zara','Ali','Female',25,'03111111111','Stable','Minor injuries','Johar Town','Lahore','Punjab'),
(2,'Ahmed','Raza','Male',40,'03222222222','Critical','Gunshot wound','DHA','Karachi','Sindh'),
(3,'Usman','Tariq','Male',29,'03333333333','Recovered','Cyber fraud victim','F-8','Islamabad','ICT'),
(4,'Hina','Noor','Female',31,'03444444444','Stable','Kidnapping trauma','Cantt','Multan','Punjab'),
(5,'Bilal','Khan','Male',36,'03555555555','Recovered','Financial fraud','Madina Town','Faisalabad','Punjab'),
(6,'Sara','Ahmed','Female',27,'03666666666','Stable','Theft complaint','University Town','Peshawar','KPK'),
(7,'Hamza','Malik','Male',45,'03777777777','Critical','Drug attack','Satellite Town','Quetta','Balochistan'),
(8,'Ayesha','Khan','Female',30,'03888888888','Recovered','Assault injuries','Rawat','Rawalpindi','Punjab'),
(9,'Noman','Ali','Male',34,'03999999999','Stable','Extortion victim','Cantt','Sialkot','Punjab'),
(10,'Farah','Noor','Female',28,'03010101010','Recovered','Burglary trauma','Latifabad','Hyderabad','Sindh'),
(11,'Saad','Ahmed','Male',38,'03121212121','Stable','Robbery injuries','Iqbal Town','Lahore','Punjab'),
(12,'Madiha','Tariq','Female',22,'03232323232','Critical','Cyber harassment','Clifton','Karachi','Sindh'),
(13,'Rizwan','Khan','Male',41,'03343434343','Stable','Gunshot injury','Blue Area','Islamabad','ICT'),
(14,'Hassan','Ali','Male',33,'03454545454','Recovered','Fraud complaint','Shalimar','Multan','Punjab'),
(15,'Anum','Fatima','Female',26,'03565656565','Stable','Kidnapping trauma','Hayatabad','Peshawar','KPK');

INSERT INTO Investigation VALUES
(1,1,1,'2025-01-11','Pending','Fingerprints',2,101),
(2,2,2,'2025-01-12','Completed','Knife Found',5,102),
(3,3,8,'2025-01-13','Pending','Laptop Seized',3,103),
(4,4,10,'2025-01-14','In Progress','Witness Evidence',4,104),
(5,5,4,'2025-01-15','Completed','Documents',1,105),
(6,6,6,'2025-01-16','Pending','CCTV Footage',2,106),
(7,7,5,'2025-01-17','In Progress','Drugs Seized',6,107),
(8,8,3,'2025-01-18','Completed','Medical Report',2,108),
(9,9,9,'2025-01-19','Pending','Call Recordings',4,109),
(10,10,15,'2025-01-20','In Progress','Crowbar Found',3,110),
(11,11,14,'2025-01-21','Completed','Weapon Recovered',5,111),
(12,12,13,'2025-01-22','Pending','Mobile Data',2,112),
(13,13,2,'2025-01-23','In Progress','Pistol Found',6,113),
(14,14,12,'2025-01-24','Completed','Bank Statements',1,114),
(15,15,11,'2025-01-25','Pending','Vehicle Tracked',5,115);

INSERT INTO CaseReport VALUES
(1,1,1,1,'2025-03-01','Pending',NULL,'Open'),
(2,2,2,2,'2025-03-02','Guilty','2025-04-10','Closed'),
(3,3,3,3,'2025-03-03','Pending',NULL,'Open'),
(4,4,4,4,'2025-03-04','Pending',NULL,'Open'),
(5,5,5,5,'2025-03-05','Not Guilty','2025-04-12','Closed'),
(6,6,6,6,'2025-03-06','Pending',NULL,'Open'),
(7,7,7,7,'2025-03-07','Pending',NULL,'Open'),
(8,8,8,8,'2025-03-08','Resolved','2025-04-14','Closed'),
(9,9,9,9,'2025-03-09','Pending',NULL,'Open'),
(10,10,10,10,'2025-03-10','Pending',NULL,'Open'),
(11,11,11,11,'2025-03-11','Resolved','2025-04-18','Closed'),
(12,12,12,12,'2025-03-12','Pending',NULL,'Open'),
(13,13,13,13,'2025-03-13','Pending',NULL,'Open'),
(14,14,14,14,'2025-03-14','Resolved','2025-04-20','Closed'),
(15,15,15,15,'2025-03-15','Pending',NULL,'Open');

SET SQL_SAFE_UPDATES = 0;
UPDATE Criminal SET RiskLevel = 'Critical' WHERE Age > 40;

UPDATE Officer SET Department = 'Cyber Crime' WHERE Specialization = 'Cyber Security';

UPDATE FIR SET Status = 'Closed' WHERE SeverityLevel = 'Low';

DELETE FROM Victim WHERE Victim_ID = 15;
DELETE FROM Criminal WHERE Criminal_ID = 5;

SELECT F.FIR_ID, F.CrimeType, I.ReportStatus, O.FirstName, O.LastName
FROM FIR AS F
INNER JOIN Investigation AS I
ON F.FIR_ID = I.FIR_ID
INNER JOIN Officer AS O
ON I.Officer_ID = O.Officer_ID;

SELECT C.Name AS CriminalName, CR.CaseStatus, V.lastname, V.firstname, F.CrimeType
FROM Criminal AS C
LEFT JOIN CaseReport AS CR
ON C.Criminal_ID = CR.Criminal_ID
LEFT JOIN Victim AS V
ON CR.Victim_ID = V.Victim_ID
LEFT JOIN FIR AS F
ON CR.FIR_ID = F.FIR_ID;

SELECT O.FirstName, I.Investigation_ID, F.Location
FROM Officer AS O
RIGHT JOIN Investigation AS I
ON O.Officer_ID = I.Officer_ID
INNER JOIN FIR AS F
ON I.FIR_ID = F.FIR_ID;

SELECT V.firstName, V.lastName, CR.Report_ID, CR.CaseStatus
FROM Victim AS V
LEFT JOIN CaseReport AS CR
ON V.Victim_ID = CR.Victim_ID
UNION
SELECT V.firstName, V.lastName, CR.Report_ID, CR.CaseStatus
FROM Victim AS V
RIGHT JOIN CaseReport AS CR
ON V.Victim_ID = CR.Victim_ID;

SELECT *
FROM FIR
NATURAL JOIN CaseReport;

SELECT A.FirstName AS Officer1, B.FirstName AS Officer2, A.Department
FROM Officer AS A
INNER JOIN Officer AS B
ON A.Department = B.Department
AND A.Officer_ID != B.Officer_ID;

SELECT Name
FROM Criminal
WHERE Criminal_ID IN (
SELECT Criminal_ID
FROM CaseReport
WHERE CaseStatus = 'Open'
);


SELECT FirstName, LastName
FROM Officer
WHERE Officer_ID NOT IN (
SELECT Officer_ID
FROM Investigation
WHERE Officer_ID IS NOT NULL
);

SELECT Name, Age
FROM Criminal
WHERE Age > ANY (
SELECT Age
FROM Criminal
WHERE RiskLevel = 'Medium'
);

SELECT FirstName, YearsOfService
FROM Officer
WHERE YearsOfService > ALL (
SELECT YearsOfService
FROM Officer
WHERE Department = 'Traffic'
);

SELECT Name
FROM Criminal as C
WHERE EXISTS (
SELECT *
FROM CaseReport AS CR
WHERE C.Criminal_ID = CR.Criminal_ID
);

SELECT FirstName
FROM Officer AS O
WHERE NOT EXISTS (
SELECT *
FROM Investigation AS I
WHERE O.Officer_ID = I.Officer_ID
);

SELECT Name
FROM Criminal
WHERE Age != ANY (
SELECT Age
FROM Criminal
WHERE RiskLevel = 'Low'
);

SELECT Name
FROM Criminal
WHERE Age != ALL (
SELECT Age
FROM Criminal
WHERE RiskLevel = 'Critical'
);

SELECT COUNT(*) AS TotalCriminals FROM Criminal;

SELECT SUM(WitnessCount) AS TotalWitnesses FROM Investigation;

SELECT AVG(Age) AS AverageCriminalAge FROM Criminal;

SELECT MIN(YearsOfService) FROM Officer;

SELECT MAX(Age) FROM Victim;

SELECT Department, COUNT(*) AS TotalOfficers
FROM Officer
GROUP BY Department;

SELECT Department, COUNT(*) AS TotalOfficers
FROM Officer
GROUP BY Department
HAVING COUNT(*) > 2;

SELECT SeverityLevel, COUNT(*) AS TotalCases, MAX(CrimeDate) AS LatestCase, MIN(CrimeDate) AS OldestCase
FROM FIR
GROUP BY SeverityLevel
HAVING COUNT(*) >= 2;

SELECT City FROM Criminal
UNION
SELECT City FROM Victim;

SELECT Province FROM Criminal
UNION ALL
SELECT Province FROM Victim;

SELECT DISTINCT City
FROM Criminal
WHERE City IN (
SELECT City
FROM Victim
);

SELECT DISTINCT City
FROM Criminal
WHERE City NOT IN (
SELECT City FROM Victim
);

SELECT Name, Age
FROM Criminal
WHERE Age <= ANY (
SELECT Age
FROM Criminal
WHERE RiskLevel = 'Low'
);

SELECT Name, Age
FROM Criminal
WHERE Age < ALL (
SELECT Age
FROM Criminal
WHERE RiskLevel = 'High'
);

CREATE VIEW OpenCases AS
SELECT Report_ID, CaseStatus
FROM CaseReport
WHERE CaseStatus = 'Open';

CREATE VIEW OfficerInvestigations AS 
SELECT O.FirstName, O.LastName, I.Investigation_ID
FROM Officer AS O
INNER JOIN Investigation AS I
ON O.Officer_ID = I.Officer_ID;

CREATE VIEW CriminalCaseSummary AS
SELECT C.Name, CR.CaseStatus, CR.Verdict
FROM Criminal AS C
INNER JOIN CaseReport AS CR
ON C.Criminal_ID = CR.Criminal_ID;

CREATE VIEW CriticalCases AS
SELECT FIR_ID, CrimeType, SeverityLevel
FROM FIR
WHERE SeverityLevel = 'Critical';


SELECT * FROM OpenCases;

SELECT * FROM OfficerInvestigations;

SELECT * FROM CriminalCaseSummary;

SELECT * FROM CriticalCases;

SELECT * FROM FIR WHERE FIR_ID = 1;

SELECT * FROM Investigation WHERE FIR_ID = 1;

DELETE FROM FIR WHERE FIR_ID = 1;

SELECT * FROM Investigation WHERE FIR_ID = 1;

SELECT * FROM Criminal WHERE Criminal_ID = 2;

SELECT * FROM CaseReport WHERE Criminal_ID = 2;

DELETE FROM Criminal WHERE Criminal_ID = 2;

SELECT * FROM CaseReport WHERE Report_ID = 2;

INSERT INTO FIR VALUES (1,'Robbery','Gun','10:00:00','2025-02-01', 'High','Open','Lahore','Ali','Khan');

INSERT INTO FIR VALUES
(16,'Robbery','Gun','10:00:00','2025-02-01','High','Open','Lahore','Ali','Khan');


INSERT INTO Victim VALUES
(16,'Test','User','Male',25,'03000000000','Serious','Test Injury','Area','Lahore','Punjab');

INSERT INTO Victim VALUES
(16,'Test','User','Male',25,'03000000000','Stable','Test Injury','Area','Lahore','Punjab');

INSERT INTO Investigation VALUES
(20,100,1,'2025-02-01','Pending','Evidence',2,120);

INSERT INTO Investigation VALUES
(20,2,1,'2025-02-01','Pending','Evidence',2,120);

INSERT INTO Criminal VALUES
(17,'Test','X','35201-1717171-7','Pakistani','Male',30,'Low','No','Test','Area','City','Province');

CREATE TABLE FIR(
FIR_ID INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS FIR(
FIR_ID INT PRIMARY KEY
);
