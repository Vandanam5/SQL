create database Bank
use Bank
go


--First creating tables with primary key
--Creating table for user logins

create table UserLogins
(UserLoginID smallint not null,
UserLogin char(15) not null,
UserPassword varchar(20) not null
Constraint pk_userloginid primary key(UserLoginID) )
go

--Creating table for User Security Questions
create table UserSecurityQuestions
(UserSecurityQuestionID tinyint not null,
UserSecurityQuestion varchar(50) not null,
Constraint pk_usersecurityQuestionID primary key (UserSecurityQuestionID))
go

--Creating table for Account Type
Create table AccountType
(AccountTypeID tinyint not null,
AccountTypeDescription Varchar(30) not null,
constraint pk_AccounttypeID primary key (AccountTypeID))
go

--Creating table for SavingsInterestRates
Create table SavingsInterestRates
(InterestSavingsRateID tinyint not null,
InterestRateValue numeric(9,2) not null,
InterestRateDescription varchar(20) not null,
Constraint pk_InterestSavingsRateID primary key(InterestSavingsRateID))
go

--Creating table for AccountStatusType
Create table AccountStatusType
(AccountStatusTypeID tinyint not null,
AccountStatusDescription varchar(30)not null,
constraint pk_AccountstatustypeID primary key (AccountStatusTypeID))
go

--Creating table for Employee
create table Employee
(EmployeeID int not null,
EmployeeFirstName varchar(25) not null,
EmployeeMiddleInitial char(1) not null,
EmployeeLastName varchar(25) not null,
EmployeeIsManager bit not null,
constraint pk_EmployeeID primary key (EmployeeID))
go

--Creating table for TransactionType
create table TransactionType
(TransactionTypeID tinyint not null,
TransactionTypeName char(10) not null,
TransactionTypeDescription varchar(50) not null,
TransactionFeeAmount smallmoney not null,
constraint pk_TransactionTypeID primary key(TransactionTypeID))
go

--Creating table for Loginerrorlog
create table LoginErrorlog 
(ErrorLogID int not null,
ErrorTime datetime not null,
FailedTransactionXML xml not null,
constraint pk_ErrorlogID primary key(ErrorLogID))
go

--Creating table for FailedTransactionErrorType
Create table FailedTransactionErrorType
(FailedTransactionErrorTypeID tinyint not null,
FailedTransactionDescription varchar(50) not null,
constraint pk_FailedTransactionErrorTypeID primary key(FailedTransactionErrorTypeID))
go


--Creating tables with foreign key and primary key combinations 
--Creating table Account 

create table Account
(AccountID int not null,
 CurrentBalance int not null,
 AccounttypeID tinyint not null,
 AccountStatusTypeID tinyint not null,
 InterestSavingsRateID tinyint not null, 
constraint pk_Account primary key (AccountID),
constraint fk_Accounttype foreign key (AccountTypeID) references AccountType(AccountTypeID),
constraint fk_Accountstatus foreign key (AccountStatusTypeID) references AccountStatusType(AccountStatusTypeID),
constraint fk_InterestsavingRateID foreign key(InterestSavingsRateID) references SavingsInterestRates(InterestSavingsRateID))
go



-- creating table for LoginAccount
create table Loginaccount
(UserloginID smallint not null,
AccountID int not null,
constraint fk_User_LoginID foreign key (userloginid) references userlogins(userloginid),
constraint fk_accountID foreign key(Accountid) references Account (AccountId))
go

-- creating table for customer 
create table customer 
(customerID int not null,
CustomerAddress1 varchar(30) not null,
CustomerAddress2 varchar(30) not null,
CustomerFirstName varchar(30) not null,
CustomerMiddleInitial char(1) not null,
CustomerLastName varchar(30) not null,
City varchar(20) not null,
State char(2) not null,
Zipcode char(10) not null,
EmailAddress varchar(40) not null,
Homephone char(10) not null,
Cellphone char(10) not null,
workPhone char(10) not null,
SSN char (9) not null,
UserLoginID smallint not null,
constraint pk_customerID primary key (customerID),
constraint fk_custuserloginid foreign key(userloginID) references userlogins(UserloginID))
go



--creating table for Customer Account 
create table CustomerAccount
(AccountID int not null,
CustomerID int not null,
constraint fk_cust_accountID foreign key (AccountID) references Account(AccountID),
constraint fk_customer_Id foreign key(CustomerID) references customer(CustomerID))
go

--creating table for FailedTransactionLog
Create table FailedTransactionLog
(FailedTransactionID int not null,
FailedTransactionErrorTypeID tinyint not null,
FailedTransactionErrorTime datetime not null,
FailedTransactionXML xml not null,
Constraint pk_Failed_TransactionID primary key (FailedTransactionID),
Constraint fk_Failed_Transaction_ErrorTypeID foreign key (FailedTransactionErrorTypeID) references FailedTransactionErrorType(FailedTransactionErrorTypeID))
go

--creating table for TransactionLog
create table TransactionLog
(TransactionID int not null,
TransactionDate datetime not null,
TransactionTypeID tinyint not null,
TransactionAmount money not null,
NewBalance money not null,
AccountID int not null,
CustomerID int not null,
EmployeeID int not null,
UserLoginID smallint not null,
constraint pk_transactionid primary key(TransactionID),
constraint fk_transaction_TypeID foreign key(TransactionTypeID) references TransactionType(TransactionTypeID),
constraint fk_Trans_accountID foreign key (AccountID) references Account(AccountID),
constraint fk_trans_customerID foreign key (customerID) references customer(CustomerID),
Constraint fk_trans_EmployeeID foreign key (EmployeeID) references Employee(EmployeeID),
constraint fk_trans_userloginID foreign key (UserLoginID) references UserLogins (UserLoginID))
go

--Create table named OverDraftLog
create table OverDraftLog
(AccountID int not null,
OverDraftDate datetime not null,
OverDraftAmout money not null,
OverDraftTransactionxml xml not null,
constraint pk_OverDraft_AccountID primary key (AccountID),
constraint fk_Overdraft_AccountID foreign key (AccountID) references Account(AccountID))

--Creating table for UserSecurityAnswers
create table UserSecurityAnswers
(userLoginID smallint not null,
UserSecurityAnswer varchar(25) not null,
UserSecurityQuestionID tinyint not null,
constraint pk_UserSecurity_UserLoginID primary key (UserLoginID),
constraint fk_usersecurity_userloginID foreign key (UserLoginID) references UserLogins(UserLoginID),
Constraint fk_UserSecurity_QuestionID foreign key(UserSecurityQuestionID) references UserSecurityQuestions (UserSecurityQuestionID))
go

--Inserting Data into Tables 
--Inserting data into userlogins table

insert into UserLogins Values(100, 'Scott','password1')
insert into UserLogins Values(101, 'John','password2')
insert into UserLogins Values(102, 'Anna','password3')
insert into UserLogins Values(103, 'Watson','password4')
insert into UserLogins Values(104, 'Mariam','password5')
go
select * from UserLogins

--Inserting Data into UserSecurityQuestions 
insert into UserSecurityQuestions Values (111,'What is your favorite food?')
insert into UserSecurityQuestions Values (112,'What city where you born?')
insert into UserSecurityQuestions Values (113,'What is the name of your favorite pet?')
insert into UserSecurityQuestions Values (114,'What was make of your first car?')
insert into UserSecurityQuestions Values (115,'What is your Mothers Maiden Name?')
go
select* from UserSecurityQuestions

--Inserting Data into AccountType 
insert into AccountType Values (10,'Savings')
insert into AccountType Values (11,'Checking')
go
select* from AccountType

--Inserting Data into SavingsInterestRates
insert into SavingsInterestRates Values (1,0.50,'very low')
insert into SavingsInterestRates Values (2,1.25,'low')
insert into SavingsInterestRates Values (3,2,'moderate')
insert into SavingsInterestRates Values (4,3,'high')
insert into SavingsInterestRates Values (5,4,'very high')

--Inserting Data into AccountStatusType
insert into AccountStatusType Values (31,'Active')
insert into AccountStatusType Values (32,'Suspended')
insert into AccountStatusType Values (33,'Closed')
insert into AccountStatusType Values (34,'Inactive')
insert into AccountStatusType Values (35,'preactive')


--inserting data into TranscationType

insert into TransactionType Values (6,'Withdrawal','Take money',0)
insert into TransactionType Values (7,'Deposit','Put money',100)
insert into TransactionType Values (8,'Transfer','Send money',300)
insert into TransactionType Values (9,'CreditCard','purchase',700)
insert into TransactionType Values (10,'Balance','See Money',0)
go
select* from TransactionType

--Inserting LoginErrorLog

insert into LoginErrorLog Values (512,'2018/6/12 05:35:20','Invalid Password')
insert into LoginErrorLog Values (513,'2019/4/5 09:26:00','Invalid Username')
insert into LoginErrorLog Values (514,'2016/3/10 02:04:18','Network issue')
insert into LoginErrorLog Values (515,'2015/11/26 12:23:05','authentication failed')
insert into LoginErrorLog Values (516,'2018/6/12 05:35:20','Account disabled')
go
--updated the table for seeing changes in phase 2 question 8
update loginerrorlog
set errortime = '2022/1/5 12:01:00'
where errorlogid =516

select* from loginerrorlog

--Inserting data into FailedTransactionErrorType

insert into FailedTransactionErrorType Values (1,'Invalid card number')
insert into FailedTransactionErrorType Values (2,'No Sufficient Balance')
insert into FailedTransactionErrorType Values (3,'Amount Limit Exceded')
insert into FailedTransactionErrorType Values (4,'Invalid Security Code')
insert into FailedTransactionErrorType Values (5,'Card Expired')
go

--Insert data into Employee 

insert into Employee Values (2134,'Christin','T','Samuel',0)
insert into Employee Values (3162,'Robert','M','Oliver',1)
insert into Employee Values (5648,'Rakesh','S','Kumar',1)
insert into Employee Values (4839,'Emma','P','William',0)
insert into Employee Values (5368,'Ryan','D','Fernandez',1)
go
select* from Employee
--Inserting data into Failed Transaction Log
insert into FailedTransactionLog Values (61,1,'2016/07/12 05:35:20','failtranserror1')
insert into FailedTransactionLog Values (62,2,'2018/05/26 12:30:45','failtranserror2')
insert into FailedTransactionLog Values (63,3,'2020/11/05 09:15:20','failtranserror3')
insert into FailedTransactionLog Values (64,4,'2019/12/09 05:37:16','failtranserror4')
insert into FailedTransactionLog Values (65,5,'2018/07/12 11:35:00','failtranserror5')
go

--Insert data into Account
insert into Account Values (4321,50000,10,31,1)
insert into Account Values (4341,75000,11,33,3)
insert into Account Values (4567,4000,10,32,4)
insert into Account Values (4412,1000,11,34,2)
insert into Account Values (4683,25000,11,35,5)
go

Insert into UserSecurityAnswers Values (100,'Pizza',111)
Insert into UserSecurityAnswers Values (101,'Toronto',112)
Insert into UserSecurityAnswers Values (102,'Max',113)
Insert into UserSecurityAnswers Values (103,'Toyota',114)
Insert into UserSecurityAnswers Values (104,'Zen',115)
go

--Inserting data into Login Account 
insert into Loginaccount Values (100,4321)
insert into Loginaccount Values (101,4341)
insert into Loginaccount Values (102,4412)
insert into Loginaccount Values (103,4567)
insert into Loginaccount Values (104,4683)
go

--Inserting data into Customer 
insert into customer Values (1,'Churchhill','90Th Avenue','Thomas','R','Clark','Rolling Hills','AB','T0J2S0','Thomas@gmail.com','3241235643','2345896540','7654321789','S45634',100)
insert into customer Values (2,'Bay Boulivard','Landon Street','Noah','K','jaison','Vancouver','BC','V5M3M5','NoahJ@gmail.com','5643698321','5469802341','7642904563','P23457',101)
insert into customer Values (3,'Bay Street','Huruntario','Elizabeth','M','Mason','Toronto','ON','M5J2R8','Eli@gmail.com','5321789040','3450945063','7589005430','W23890',102)
insert into customer Values (4,'Jean Ave','Baptiste St','Sophia','J','David','Montreal','QC','G0M2C0','Sophia@gmail.com','4567345245','6453200087','7543768540','R34874',103)
insert into customer Values (5,'Eglinton','Mavis Ave','Daniel','H','John','Mississauga','ON','L5R3P5','Dani@gmail.com','4789336621','6743590871','7894321670','S37682',104)
go
select* from customer

--insert data into Customer Account
insert into CustomerAccount Values (4321,1)
insert into CustomerAccount Values (4341,2)
insert into CustomerAccount Values (4567,3)
insert into CustomerAccount Values (4412,4)
insert into CustomerAccount Values (4683,5)
go

--Insert data into transactionlog
insert into TransactionLog	Values (1,'2015/05/06 12:17:00',6,15000,76000,4321,1,2134,100)
insert into TransactionLog	Values (2,'2019/09/03 09:40:07',7,25000,125000,4341,2,3162,101)
insert into TransactionLog	Values (3,'2020/03/08 02:45:20',8,127000,375000,4567,3,5648,102)
insert into TransactionLog	Values (4,'2015/11/10 10:20:21',9,76000,112000,4412,4,4839,103)
insert into TransactionLog	Values (5,'2017/12/09 03:25:34',10,12000,76000,4683,5,5368,104)
go

--insert data into Over Draft Log
insert into OverDraftLog Values (4321,'2015/03/06 12:17:20',200,'pending')
insert into OverDraftLog Values (4341,'2019/09/03 09:40:07',150,'Approved')
insert into OverDraftLog Values(4567,'2020/03/08 05:45:20',50,'Approved')
insert into OverDraftLog Values(4412,'2015/11/09 03:25:34',350,'Pending')
insert into OverDraftLog Values(4683,'2015/11/10 10:20:21',50,'Approved')
go



--1.Create a view to get all customers with checking account from ON province. [Moderate]

Create View VWCheckingON
as
select Customer.customerID,Customer.CustomerFirstName+' '+customer.CustomerLastName[Customer Name],customer.State,accounttype.AccountTypeDescription
from customer
join CustomerAccount
on CustomerAccount.CustomerID =Customer.customerID
join Account
on CustomerAccount.accountid = account.AccountID
join AccountType 
on account.AccounttypeID =AccountType.AccountTypeID
where AccountType.AccountTypeDescription = 'checking' and customer.State= 'ON'
go

select * from VWCheckingON
go

--2.Create a view to get all customers with total account balance (including interest rate) greater than 5000. [Advanced]

create View VWtotalBalance
as
select customer.CustomerFirstName,customer.CustomerLastName,SUM (account.CurrentBalance + (account.CurrentBalance*savingsinterestRates.InterestRateValue)/100) as Total_Balance
from customer
join CustomerAccount
on CustomerAccount.CustomerID =Customer.customerID
join Account
on CustomerAccount.AccountID =Account.AccountID
JOIN SavingsInterestRates
ON Account.InterestSavingsRateID = SavingsInterestRates.InterestSavingsRateID
group by CustomerFirstName,CustomerLastName
having SUM (account.CurrentBalance + (account.CurrentBalance*savingsinterestRates.InterestRateValue)/100)>5000
go

select * from VWtotalBalance
go


--3.Create a view to get counts of checking and savings accounts by customer. [Moderate]

Create View VWtotalCount
as
select customer.CustomerFirstName,customer.CustomerLastName,Accounttype.AccountTypeDescription,COUNT (*)as Total_Count from customer
join CustomerAccount
on CustomerAccount.CustomerID =Customer.customerID
join account
on CustomerAccount.AccountID=Account.AccountID
join accounttype
on account.accounttypeid=accounttype.AccountTypeID
Group by customerfirstName,CustomerLastName,Accounttype.AccounttypeDescription
go

select * from VWtotalCount
go



--4.Create a view to get any particular user’s login and password using AccountId. [Moderate]
create View VWloginpassworrd
as
select UserLogins.UserLogin,UserLogins.UserPassword from UserLogins
join Loginaccount
on UserLogins.UserLoginID = Loginaccount.UserloginID
join Account
on account.AccountID = Loginaccount.AccountID
WHERE LoginAccount.AccountID = '4341'
go

select * from VWloginpassworrd
go



--5. Create a view to get all customers’ overdraft amount. [Moderate]
Create view VWoverdraft
as
select Customer.customerID,Customer.CustomerFirstName+' '+customer.CustomerLastName[Customer Name],OverDraftLog.OverDraftAmout from OverDraftLog
join CustomerAccount
on CustomerAccount.AccountID =OverDraftLog.AccountID
join Customer
on customer.customerID = CustomerAccount.CustomerID
go

select * from VWoverdraft
go


--6.Create a stored procedure to add “User_” as a prefix to everyone’s login (username). [Moderate]

Create procedure spuserprefix
as
begin 
update UserLogins
set userlogin = 'user_'+ userlogin from userlogins
end

exec spuserprefix
select* from UserLogins
go
--7. Create a stored procedure that accepts AccountId as a parameter and returns customer’s full name. [Advanced]
IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spcustname')
DROP PROC spcustname
GO
create proc spcustname                     --assigning a name for procedure
@AccountID int,                           --Defining input parameter and it's data type 		                              
@Fullname nvarchar(100) output            --Defining output parameter and it's data type and specifying it is output
as
begin
	  if (@AccountID in (select AccountID from CustomerAccount))
		  Begin
				Select @FullName= customer.CustomerFirstName+' '+customer.CustomerMiddleInitial+' '+customer.CustomerLastName
				from Customer 
				join CustomerAccount 
				on CustomerAccount.CustomerID=Customer.CustomerID
				where CustomerAccount.AccountID=@AccountID
	     End
	Else 
	    Begin
		   print 'There is no account with AccountID= '+CONVERT(varchar(12),@AccountID)
	    End
End
go
--Executing for valid account id
Declare @FullName nvarchar(100)
exec spcustname 4567, @FullName out
Print ' Full name is '+replace (@FullName,'   ',' ')


--Executing for invalid account id
Declare @FullName nvarchar(100)
exec spcustname 4867, @FullName out
Print ' Full name is '+replace (@FullName,'   ',' ')
go





--8.Create a stored procedure that returns error logs inserted in the last 24 hours. [Advanced]

create procedure sperror_login                        --assigning a name for procedure
as
begin
select * from loginerrorlog                         -- select all from table loginerrorlog
where errortime >= Dateadd(hh,-24, GETDATE()) -- error time is current time - 24 hrs
end

exec sperror_login  
go


--9.Create a stored procedure that takes a deposit as a parameter and updates CurrentBalance value for that particular account. [Advanced]

create procedure spcurrent_balance
@accountID int,
@deposit int
as
begin
select totalbalance=(currentbalance+@deposit) from Account
where accountID=@accountID
end

exec spcurrent_balance @accountid = 4412, @deposit = 4000
go

--or using output
create procedure spcurrentamount   --assigning a name for procedure
@deposit money,               ----Defining input parameters and it's data types 
@accountid int,
@totalbalance money out                           --Defining output parameter and it's data type and specifying it as output
as
begin
declare @balance money                    -- retrieving currentbalance from account table and storing it in a variable
select @balance=CurrentBalance from Account
where accountID=@accountID
set @totalbalance = @balance + @deposit    -- now calculating the the balance after deposit
end


 declare @newbalance int
 execute spcurrentamount 4000, 4412, @newbalance out
 print 'New balance = '+CONVERT(varchar(12),@newbalance)






--10.Create a stored procedure that takes a withdrawal amount as a parameter and updates 


--using output

 create procedure spbalancecurrent   --assigning a name for procedure
@withdrawalamount int,               ----Defining input parameters and it's data types 
@accountid int,
@tb int out                           --Defining output parameter and it's data type and specifying it as output
as
begin
declare @bal money                    -- retrieving currentbalance from account table and storing it in a variable
select @bal=CurrentBalance from Account
where accountID=@accountID
set @tb = @bal - @withdrawalamount    -- now calculating the the balance after withdrawal
end


 declare @totalbalance int
 execute spbalancecurrent 5000, 4683, @totalbalance out
 print 'New balance = '+CONVERT(varchar(12),@totalbalance)


 