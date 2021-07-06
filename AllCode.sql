--Jaesa Maxwell 103669129
/*
Tour(TourName, Description) 
PK TourName

Client(ClientID, Surname, GivenName, Gender) 
PK ClientID

Event(EventYear, EventMonth, EventDay, EventFee) 
Comp PK EventYear, EventMonth, EventDay. Comp PK/FK RefTour TourName

Booking(ClientID, TourName, EventMonth, EventDay, EventYear, DateBooked, Payment)
Comp PK, FK ref Client ClientID, Comp PK/FK Ref Event TourName, EventMonth, EventDay, EventYear
*/
create table Tour(
    TourName NVARCHAR(100),
    Description NVARCHAR(500),
    Primary Key(TourName)
)
-------------
create table Client(
    ClientID INT,
    Surname NVARCHAR(100),
    GivenName NVARCHAR(100),
    Gender NVARCHAR(1) CHECK(gender in ('M', 'F', 'I', NULL))
    Primary Key(ClientID)
)
-------------
create table Event(
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) Check(EventMonth in('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
    EventDay INT CHECK(EventDay BETWEEN 1 AND 31),
    EventYear INT CHECK (EventYear Between 2000 and 3000),
    EventFee money check(EventFee > 0) NOT NULL,
    PRIMARY KEY(TourName, EventMonth, EventDay, EventYear),
    FOREIGN KEY(TourName) REFERENCES Tour(TourName)
)
-------------
create table Booking(
    ClientID INT,
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) Check(EventMonth in('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
    EventDay INT CHECK(EventDay BETWEEN 1 AND 31),
    EventYear INT CHECK (EventYear Between 2000 and 3000),
    Payment money check(Payment > 0) NULL,
    PRIMARY KEY(ClientID, TourName, EventMonth, EventDay, EventYear),
    FOREIGN KEY(ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY(TourName, EventMonth, EventDay, EventYear) REFERENCES Event(TourName, EventMonth, EventDay, EventYear)
)
-------------
-- Query 1 --
select  Booking.ClientID as 'ID',
        Client.GivenName as 'Given Name',
        Client.Surname as 'Surname',
        Booking.TourName as 'Tour Name',
        Tour.Description as 'Description',
        Event.EventMonth as 'Month',
        Event.EventDay as 'Day',
        Event.EventYear as 'Year',
        Event.Payment as 'Fee'
from Booking
INNER JOIN Tour on Booking.TourName = Tour.TourName
INNER JOIN Client on Booking.ClientID = Client.ClientID
INNER JOIN Event on Booking.EventYear = Event.EventYear
-------------
-- Query 2 --
select  EventMonth as 'Month',
        TourName as 'Tour Name',
        Count(*) as 'Num Bookings'
from Booking
GROUP BY EventMonth, Tourname HAVING COUNT(*) > 1
-------------
-- Query 3 --
select  * from Booking
WHERE ClientID in (select ClientID from Booking where Payment > 200)
