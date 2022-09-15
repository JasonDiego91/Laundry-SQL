USE Master
GO

IF DB_ID('BBBDB_UNILOGIN') IS NOT NULL
	
	BEGIN
		ALTER DATABASE BBBDB_UNILOGIN SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE BBBDB_UNILOGIN
	END


GO
CREATE DATABASE BBBDB_UNILOGIN
	

	GO
USE BBBDB_UNILOGIN
	GO

 
 
DROP TABLE IF EXISTS [Laundry]
	CREATE TABLE [Laundry] (
		  [LaundryId] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		  [LaundryName] NVARCHAR(100) NOT NULL,
		  [OpeningTime] TIME,
		  [ClosingTime] TIME
);



DROP TABLE IF EXISTS [Customer]
	CREATE TABLE [Customer] (
		  [CustomerId] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		  [Username] NVARCHAR(100),
		  [Email] NVARCHAR(100) UNIQUE,
		  [Password] NVARCHAR(100), 
		  [Account] DECIMAL,
		  [FK_LaundryId] INT NOT NULL,
		  [DateMade] DATE,
		  CONSTRAINT [FK_LaundryId] FOREIGN KEY ([FK_LaundryId]) REFERENCES [Laundry]([LaundryId]),
		  CONSTRAINT [Password_Length] CHECK (LEN([Password]) >= 5)
 );
 
 
DROP TABLE IF EXISTS [Machine]
	CREATE TABLE [Machine] (
		  [MachineId] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		  [MachineName] NVARCHAR(100),
		  [Price] DECIMAL, 
		  [WashLength] INT,
		  [Fk_MachineId] INT NOT NULL,
		  CONSTRAINT [FK_MachineId] FOREIGN KEY ([Fk_MachineId]) REFERENCES [Laundry]([LaundryId])
);



DROP TABLE IF EXISTS [Bookings]
	CREATE TABLE [Bookings] (
		  [BookingId] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		  [OrderDate] DATETIME,
		  [FK_BookingCustomerId] INT NOT NULL,
		  [FK_BookingMachineId] INT NOT NULL,
 
		  CONSTRAINT [FK_BookingCustomerId] FOREIGN KEY ([FK_BookingCustomerId]) REFERENCES [Customer]([CustomerId]),
		  CONSTRAINT [FK_BookingMachineId] FOREIGN KEY ([FK_BookingMachineId]) REFERENCES [Machine]([MachineId])
);

INSERT INTO Laundry ( LaundryName, OpeningTime, ClosingTime) 
VALUES ('Whitewash Inc.', '08:00', '20:00')

INSERT INTO Laundry (LaundryName, OpeningTime, ClosingTime) 
VALUES (' Double Bubble', '02:00', '22:00')

INSERT INTO Laundry ( LaundryName, OpeningTime, ClosingTime) 
VALUES (' Wash & Coffee', '12:00', '20:00')

SELECT * FROM Laundry



INSERT INTO Customer (Username, Email, [Password], Account, FK_LaundryId, DateMade) 
VALUES ('John', 'john_doe66@gmail.com', 'password', 100.00, 2,'2021-02-15')

INSERT INTO Customer (Username, Email, [Password], Account, FK_LaundryId, DateMade) 
VALUES ('Neil', 'Armstrong,firstman@nasa.gov', 'eagleLander69', 1000.00,1, '2021-02-10')

INSERT INTO Customer (Username, Email, [Password], Account, FK_LaundryId, DateMade) 
VALUES ('Batman', 'noreply@thecave.com', 'Rob1n', 500.00,3, '2020-03-10')

INSERT INTO Customer ( Username, Email, [Password], Account, FK_LaundryId, DateMade) 
VALUES ('Goldman Sachs', 'moneylaundering@gs.com', 'NotRecognized', 100000.00, 1, '2021-01-01')

INSERT INTO Customer ( Username, Email, [Password], Account, FK_LaundryId, DateMade) 
VALUES (' 50 Cent', '50cent@gmail.com', 'ItsMyBirthday', 0.50, 3, '2020-07-06')







INSERT INTO Machine ( MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('Mielle 911 Turbo', '5.00', 60, 2)

INSERT INTO Machine ( MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('Siemons IClean', '10000.00', 30, 1)

INSERT INTO Machine ( MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('Electrolax FX-2', '15.00', 45, 2)

INSERT INTO Machine ( MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('NASA Spacewasher 8000', '500.00', 5, 1)

INSERT INTO Machine (MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('The Lost Sock', '3.50', 90, 3)

INSERT INTO Machine (MachineName, Price, WashLength, Fk_MachineId) 
	VALUES ('Yo Mama', '0.50', 120, 3)




INSERT INTO Bookings ( OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 12:00:00', 1, 1)

INSERT INTO Bookings ( OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 16:00:00', 1, 3)

INSERT INTO Bookings ( OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 08:00:00', 2, 4)	

INSERT INTO Bookings (OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 15:00:00', 3, 5)

INSERT INTO Bookings (OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 20:00:00', 4, 2)

INSERT INTO Bookings (OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 19:00:00', 4, 2)

INSERT INTO Bookings (OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 10:00:00', 4, 2)

INSERT INTO Bookings (OrderDate, FK_BookingCustomerId, FK_BookingMachineId) 
	VALUES ('2021-02-26 16:00:00', 5, 6)




BEGIN TRANSACTION GoldmanSachs
	INSERT INTO Bookings ( OrderDate, FK_BookingCustomerId, FK_BookingMachineId)
	VALUES ('2021-09-15 12:00:00', 4,2)
	COMMIT SELECT * FROM Bookings


GO
CREATE VIEW BookingTimes as
	 SELECT OrderDate, Customer.Username, Machine.MachineName, Machine.Price from Bookings
	 JOIN Customer ON Bookings.FK_BookingCustomerId = Customer.CustomerId
	 JOIN Machine ON Bookings.FK_BookingMachineId = Machine.MachineId
 GO
 

 GO
 
 SELECT * From Customer where Email like '%@gmail.com%' 	
 
 GO


GO
SELECT MachineName, Price, WashLength, Laundry.LaundryName, Laundry.OpeningTime, Laundry.ClosingTime FROM Machine
JOIN Laundry ON Machine.Fk_MachineId = Laundry.LaundryId

GO

GO
SELECT Machine.MachineName, COUNT(BookingId) FROM Bookings
JOIN Machine ON Bookings.FK_BookingMachineId = Machine.Fk_MachineId
GROUP BY MachineName
GO


GO
DELETE FROM Bookings WHERE CAST(OrderDate as Time) BETWEEN '12:00' AND '13:00'
GO



UPDATE [Customer]
SET [Password] = 'SelinaKyle'
WHERE [Email] = 'noreply@thecave.com'
AND [Password] = 'Rob1n';


