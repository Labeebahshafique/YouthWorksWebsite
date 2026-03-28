CREATE DATABASE youth_workss;
USE youth_workss;
CREATE TABLE Login (
    LoginID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    UserType VARCHAR(20) NOT NULL
);


CREATE DATABASE youth_workss;
GO
USE youth_workss;

CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(20)
);

CREATE TABLE Job (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100),
    Location VARCHAR(100),
    Salary INT,
    EmployerID INT
);


CREATE TABLE Employer (
    EmployerID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    LoginID INT,
    CONSTRAINT FK_Employer_Login
        FOREIGN KEY (LoginID) REFERENCES Login(LoginID)
);
CREATE TABLE Applicant (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    LoginID INT,
    CONSTRAINT FK_Applicant_Login
        FOREIGN KEY (LoginID) REFERENCES Login(LoginID)
);

CREATE TABLE Job (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Salary INT,
    EmployerID INT,
    CONSTRAINT FK_Job_Employer
        FOREIGN KEY (EmployerID) REFERENCES Employer(EmployerID)
);

CREATE TABLE Application (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicantID INT,
    JobID INT,
    Status VARCHAR(20) DEFAULT 'Applied',
    CONSTRAINT FK_Application_Applicant
        FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    CONSTRAINT FK_Application_Job
        FOREIGN KEY (JobID) REFERENCES Job(JobID)
);
USE youth_workss;
GO


ALTER TABLE Job ADD Category VARCHAR(50) DEFAULT 'General';
ALTER TABLE Job ADD PostedDate DATE DEFAULT GETDATE();
ALTER TABLE Job ADD ApplicantCount INT DEFAULT 0;
ALTER TABLE Job ADD company NVARCHAR(255);
ALTER TABLE Job ADD details NVARCHAR(MAX);

GO
CREATE TRIGGER trg_AfterJobInsert
ON Job
AFTER INSERT
AS
BEGIN
    PRINT ' SUCCESS: Job saved to SQL Database';
END;
GO


UPDATE Job SET Category = 'Tech' WHERE Category IS NULL;


SELECT * FROM Job;

SELECT L.Username, E.CompanyName, E.Email
FROM Login L
JOIN Employer E ON L.LoginID = E.LoginID;

USE youth_workss;
SELECT * FROM Job;

USE youth_workss;
GO
SELECT * FROM Job ORDER BY JobID DESC;

INSERT INTO Login (Username, Password, UserType) VALUES ('admin', 'admin123', 'Employer');

INSERT INTO Employer (CompanyName, Email, LoginID) VALUES ('My Demo Company', 'demo@test.com', 1);
USE youth_workss;



INSERT INTO Employer (CompanyName, Email, LoginID) 
VALUES ('Test Company', 'test@test.com', 1);
SELECT * FROM Employer WHERE EmployerID = 1;

USE youth_workss;
SELECT * FROM job;
USE youth_workss;

IF NOT EXISTS (SELECT * FROM Login WHERE LoginID = 1)
    INSERT INTO Login (Username, Password, UserType) VALUES ('admin', '123', 'Employer');

IF NOT EXISTS (SELECT * FROM Employer WHERE EmployerID = 1)
    INSERT INTO Employer (CompanyName, Email, LoginID) VALUES ('Demo Corp', 'demo@test.com', 1);
ALTER TABLE jobs ADD company NVARCHAR(255);
ALTER TABLE jobs ADD details NVARCHAR(MAX);


CREATE TABLE Login (
    LoginID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    UserType VARCHAR(20) NOT NULL 
);


CREATE TABLE Employer (
    EmployerID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    LoginID INT,
    CONSTRAINT FK_Employer_Login FOREIGN KEY (LoginID) REFERENCES Login(LoginID)
);

CREATE TABLE Applicant (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    LoginID INT,
    CONSTRAINT FK_Applicant_Login FOREIGN KEY (LoginID) REFERENCES Login(LoginID)
);


CREATE TABLE Job (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Salary INT,
    EmployerID INT,
    Category VARCHAR(50) DEFAULT 'General',
    PostedDate DATE DEFAULT GETDATE(),
    ApplicantCount INT DEFAULT 0,
    Company NVARCHAR(255),
    Details NVARCHAR(MAX),
    CONSTRAINT FK_Job_Employer FOREIGN KEY (EmployerID) REFERENCES Employer(EmployerID)
);


CREATE TABLE Application (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    ApplicantID INT,
    JobID INT,
    Status VARCHAR(20) DEFAULT 'Applied',
    CONSTRAINT FK_Application_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    CONSTRAINT FK_Application_Job FOREIGN KEY (JobID) REFERENCES Job(JobID)
);
GO


CREATE TRIGGER trg_AfterJobInsert
ON Job
AFTER INSERT
AS
BEGIN
    PRINT 'SUCCESS: Job saved to SQL Database';
END;
GO


IF NOT EXISTS (SELECT * FROM Login WHERE Username = 'admin')
    INSERT INTO Login (Username, Password, UserType) VALUES ('admin', '123', 'Employer');


DECLARE @NewLoginID INT = (SELECT TOP 1 LoginID FROM Login WHERE Username = 'admin');

IF NOT EXISTS (SELECT * FROM Employer WHERE CompanyName = 'Demo Corp')
    INSERT INTO Employer (CompanyName, Email, LoginID) VALUES ('Demo Corp', 'demo@test.com', @NewLoginID);
GO


SELECT * FROM Login;
SELECT * FROM Employer;
SELECT * FROM Job;
SELECT L.Username, E.CompanyName, L.UserType
FROM Login L
INNER JOIN Employer E ON L.LoginID = E.LoginID
WHERE L.Username = 'admin' AND L.Password = '123';
USE youth_workss;
UPDATE Login SET Username = 'admin@youthworks.com' WHERE Username = 'admin';


