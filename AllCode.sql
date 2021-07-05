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