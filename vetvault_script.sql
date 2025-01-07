-- Step 1

CREATE TABLE AUTHORITY (
AuthorityID VARCHAR(50),
AuthorityName CHAR (50) not null,
CONSTRAINT AuthPK PRIMARY KEY(AuthorityID)
);

CREATE TABLE PET (
PetID VARCHAR(50),
Name VARCHAR (50) not null,
BirthDate Date not null,
Gender Char(10),
Specie VARCHAR(20) not null,
Breed VARCHAR(20),
Description VARCHAR(250),
CONSTRAINT PetPK PRIMARY KEY(PetID)
);

CREATE TABLE CONDITIONS (
ConditionID VARCHAR(50),
BodyPart varchar(50),
Symptom VARCHAR(50),
Description VARCHAR(250),
CONSTRAINT ConPK PRIMARY KEY(ConditionID)
);

CREATE TABLE MEDICATION (
MedID VARCHAR(50),
MedName VARCHAR(50),
Description VARCHAR(250),
CONSTRAINT MedPK PRIMARY KEY(MedID)
);

-- Step 2
CREATE TABLE FOOD (
FoodID VARCHAR(50),
FoodName VARCHAR(50),
Type CHAR(20),
Description VARCHAR(250),
CONSTRAINT FoodPK PRIMARY KEY(FoodID)
);

CREATE TABLE WEIGHTCHECK (
WCID VARCHAR(50),
PetID VARCHAR(50),
Weight decimal(6,2),
Date Date,
CONSTRAINT WCPK PRIMARY KEY(WCID),
CONSTRAINT WCFK FOREIGN KEY(PetID) REFERENCES PET(PetID)
ON UPDATE CASCADE
ON DELETE CASCADE
);


CREATE TABLE SCHEDULE (
ScheduleID VARCHAR(50),
PetID VARCHAR(50),
DateTime datetime,
Description VARCHAR(250),
CONSTRAINT SCPK PRIMARY KEY(ScheduleID),
CONSTRAINT SCFK FOREIGN KEY(PetID) REFERENCES PET(PetID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE PET_CON_INT (
PetID VARCHAR(50),
ConditionID VARCHAR(50),
Constraint PCINTPK Primary Key(PetID, ConditionID),
Constraint PCINTFK1 Foreign Key(PetID) References PET(PetID)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint PCINTFK2 Foreign Key(ConditionID) References CONDITIONS(ConditionID)ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE PET_MED_INT (
PetID VARCHAR(50),
MedID VARCHAR(50),
Portion Decimal(5,2),
Rate Decimal(3,1),
Constraint PMINTPK Primary Key(PetID, MedID),
Constraint PMINTFK1 Foreign Key(PetID) References PET(PetID)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint PMINTFK2 Foreign Key(MedID) References MEDICATION(MedID)ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE PET_FOOD_INT (
PetID VARCHAR(50),
FoodID VARCHAR(50),
Portion Decimal(5,2),
Rate Decimal(3,1),
Constraint PFINTPK Primary Key(PetID, FoodID),
Constraint PFINTFK1 Foreign Key(PetID) References PET(PetID)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint PFINTFK2 Foreign Key(FoodID) References FOOD(FoodID)ON UPDATE CASCADE ON DELETE CASCADE 
);
Select * from users;

CREATE TABLE OWNERSHIP_INT (
UserID int(50),
PetID VARCHAR(50),
AuthorityID VARCHAR(50),
CreateDate Date,
Constraint OWNPK Primary Key(UserID, PetID, AuthorityID),
Constraint OWNFK1 Foreign Key(UserID) References users(id)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint OWNFK2 Foreign Key(PetID) References PET(PetID)ON UPDATE CASCADE ON DELETE CASCADE,
Constraint OWNFK3 Foreign Key(AuthorityID) References AUTHORITY(AuthorityID)ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE PRESCRIPTION (
ScheduleID VARCHAR(50),
MedID VARCHAR(50),
MedPortion Decimal(5,2),
Constraint PREPK Primary Key(ScheduleID, MedID),
Constraint PREFK1 Foreign Key(ScheduleID) References SCHEDULE(ScheduleID)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint PREFK2 Foreign Key(MedID) References MEDICATION(MedID)ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE REMINDER( 
RemindID varchar(50),
WCID varchar(50) NOT NULL,
Description varchar(250),
CreateDate Date,
CONSTRAINT RMPK  Primary Key(RemindID),
Constraint RMFK1 Foreign Key(WCID) References WEIGHTCHECK(WCID)
ON UPDATE CASCADE ON DELETE CASCADE
);
select * from SCHEDULE;
start transaction;
commit;
CREATE TABLE IMAGE (
ImageID VARCHAR(50),
URL VARCHAR(255),
Description VARCHAR(255),
Constraint IMPK Primary Key(ImageID)
);

CREATE TABLE TAG(
TagID VARCHAR(50),
TagName VARCHAR(50),
Constraint TagPK Primary Key(TagID)
);

CREATE TABLE IMAGE_TAG_INT (
ImageID VARCHAR(50),
TagID VARCHAR(50),
Constraint ITPK Primary Key(ImageID, TagID),
Constraint ITFK1 Foreign Key(ImageID) References IMAGE(ImageID)ON UPDATE CASCADE ON DELETE CASCADE ,
Constraint ITFK2 Foreign Key(TagID) References TAG(TagID)ON UPDATE CASCADE ON DELETE CASCADE
);

Alter table PET
ADD ImageID VARCHAR(50),
ADD Constraint PETFK1 Foreign Key(ImageID) References IMAGE(ImageID) ON UPDATE CASCADE ON DELETE CASCADE;

-- insert data

INSERT INTO AUTHORITY VALUES 
('A001', 'Owner'),
('A002', 'Vet');

INSERT INTO CONDITIONS VALUES 
('C001', 'Left Front Leg', 'Bleeding', ''),
('C002', 'Nose', 'Running Nose', ''),
('C003', 'Intestine', 'Constipation', 'Could poop for more than 3 days')
;

INSERT INTO MEDICATION VALUES 
('M001', 'Massage', 'Be Gentle'),
('M002', 'Steroid', ''),
('M003', 'Insulin', 'For keeping blood glucose level stable')
;

INSERT INTO FOOD VALUES 
('F001', 'Fancy Feast Can', 'Can', 'Mainly Turkey'),
('F002', 'Hay', 'Grass', ''),
('F003', 'Apple', 'Fruit', 'Apple')
;

INSERT INTO PET VALUES 
('P001', 'Lucky', '2020-01-01','Male','Dog', 'Corki', 'Cute and friendly with a big butt.'),
('P002', 'Chance', '1990-01-01', 'Male', 'Horse', '', 'Friendly but old, not able to eat things too sweet.'),
('P003', 'Annie', '2010-01-01','Female','Cat', '', 'Afraid of strangers, does not like treats, very old.')
;
INSERT INTO PET VALUES 
('P004', 'Meowkai', '2018-05-20','Female','Cat', 'Maine Coon', 'A gentle giant always being chill.');


INSERT INTO WEIGHTCHECK (WCID, PetID, Weight, Date) VALUES 
('WC001', 'P001', 5,'2024-05-01'),
('WC002', 'P001', 5.1,'2024-05-02'),
('WC003', 'P002', 120,'2024-05-05'),
('WC004', 'P003', 100,'2024-05-08')
;

INSERT INTO WEIGHTCHECK (PetID, Weight, Date) VALUES 
('P004', 3,'2024-05-01'),
('P004', 3.5,'2024-05-02'),
('P004', 4,'2024-05-13'),
('P004', 4.7,'2024-05-28')
;


INSERT INTO users (name, email, password, role, state) VALUES 
('Bob Tom', 'bob@example.com', '$2b$10$srpthf5LI9rr5aHo6I72Xeasez4UERyjep3jGDJnA2S5frd/qhGIG','user','locked'),
('Nuree Na', 'nuree@example.com', '$2b$10$rPTSRpG/hzTTrdGQgDTL.OODUDH5G8mtJJiNcYY3F.ZjrHbzaGtIq','user','locked')
;

INSERT INTO PET_CON_INT (PetID, ConditionID) VALUES 
('P001', 'C001'),
('P002', 'C002'),
('P003', 'C003')
;
INSERT INTO PET_CON_INT (PetID, ConditionID) VALUES 
('P004', 'C001'),
('P004', 'C002'),
('P004', 'C003')
;

INSERT INTO PET_MED_INT (PetID, MedID, Portion, Rate) VALUES 
('P001', 'M001', 2, 1),
('P002', 'M002', 1.5, 2),
('P003', 'M003', 1, 1)
;

INSERT INTO PET_MED_INT (PetID, MedID, Portion, Rate) VALUES 
('P004', 'M001', 2, 1),
('P004', 'M002', 1.5, 2),
('P004', 'M003', 1, 1)
;

INSERT INTO PET_FOOD_INT (PetID, FoodID, Portion, Rate) VALUES 
('P001', 'F001', 2, 1),
('P002', 'F002', 1.5, 2),
('P003', 'F003', 1, 1)
;

INSERT INTO SCHEDULE (ScheduleID ,PetID, DateTime, Description) VALUES 
('SC001', 'P001', '2024-05-10 07:23:30', ''),
('SC002', 'P002', '2024-05-11 07:23:30', ''),
('SC003', 'P003', '2024-05-12 07:23:30', '')
;

insert into SCHEDULE(PetID, DateTime, Description, Status) values
('P002', '2024-05-25 18:22:00', 'Ton of work to do', 'Undone')
;

INSERT INTO SCHEDULE (PetID, DateTime, Description, Status) VALUES 
('P004', '2024-05-21 08:15:00', 'Test', 'Undone'),
('P004', '2024-05-22 10:45:00', 'Test1', 'Undone'),
('P004', '2024-05-23 14:33:00', 'Test2', 'Undone')
;
INSERT INTO SCHEDULE (PetID, DateTime, Description, Status) VALUES 
('P001', '2024-05-15 08:15:00', 'Test123', 'Undone'),
('P001', '2024-06-10 10:45:00', 'Test456', 'Undone'),
('P001', '2024-05-27 14:33:00', 'Test789', 'Undone')
;

INSERT INTO PRESCRIPTION (ScheduleID ,MedID, MedPortion) VALUES 
('SC001', 'M001',1.5),
('SC002', 'M002',1),
('SC003', 'M003',2)
;

INSERT INTO PRESCRIPTION (ScheduleID ,MedID, MedPortion) VALUES 
('SC005', 'M001',1),
('SC005', 'M002',1),
('SC006', 'M001',0.5),
('SC006', 'M003',0.5),
('SC007', 'M003',2)
;

insert into OWNERSHIP_INT
values
(3, 'P001', 'A001', '2024-05-13'),
(4, 'P002', 'A001', '2024-05-13'),
(5, 'P003', 'A001', '2024-05-13');

insert into TAG (TagName)
values
('Dog'),
('Cat'),
('Horse'),
('Cute'),
('Goofy'),
('Elegant')
;
insert into TAG (TagName)
values
('Shark'),
('Snake'),
('Mouse'),
('Bird'),
('Eagle'),
('Turtle'),
('Sheep'),
('Fish'),
('Guinea Pig')
;
insert into TAG (TagName)
values
('Rat'),
('Mice'),
('Hamster'),
('Frog'),
('Lizard')
;
insert into TAG (TagName)
values
('Chicken');


insert into IMAGE_TAG_INT (ImageID, TagID)
values
('I001','T001'),
('I002','T001'),
('I003','T015'),
('I004','T001'),
('I004','T004'),
('I005','T010'),
('I005','T011'),
('I006','T017'),
('I006','T016'),
('I006','T004'),
('I007','T002'),
('I007','T004'),
('I008','T013'),
('I009','T010'),
('I009','T004'),
('I010','T014'),
('I011','T012'),
('I012','T007'),
('I013','T002'),
('I013','T004'),
('I014','T014'),
('I015','T018'),
('I015','T004'),
('I016','T014'),
('I017','T014'),
('I018','T008'),
('I019','T004'),
('I019','T021'),
('I020','T019'),
('I021','T020'),
('I022','T020'),
('I023','T017'),
('I023','T016'),
('I024','T019'),
('I025','T008'),
('I026','T020'),
('I027','T001');



-- Trigger example
DELIMITER //
CREATE TRIGGER CustomerNo_INSERT
before INSERT ON Customer FOR EACH ROW
BEGIN
    declare customer_count INT;
    declare last_customer_id varchar(16);
    SELECT CustomerNo into last_customer_id from customer
    order by CustomerNo desc limit 1;
    SELECT COUNT(*) INTO customer_count FROM customer;
        if customer_count = 0 then
		set New.CustomerNo = CONCAT('C', LPAD(customer_count + 1, 3, '0'));
    else
		set New.CustomerNo = CONCAT('C', LPAD(SUBSTRING(last_customer_id, 2) + 1, 3, '0'));
    END IF;
END //
DELIMITER ;
-- Auto Generate TagID
DELIMITER //
CREATE TRIGGER TagID_insert
before INSERT ON TAG FOR EACH ROW
BEGIN
    declare tag_count INT;
    declare last_tag_id varchar(50);
    SELECT TagID into last_tag_id from TAG
    order by TagID desc limit 1;
    SELECT COUNT(*) INTO tag_count FROM TAG;
    if tag_count = 0 then
	set New.TagID = CONCAT('T', LPAD(tag_count + 1, 3, '0'));
    else
    set New.TagID = CONCAT('T', LPAD(SUBSTRING(last_tag_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;

-- Auto Generate ImageID
DELIMITER //
CREATE TRIGGER ImageID_insert
before INSERT ON IMAGE FOR EACH ROW
BEGIN
    declare image_count INT;
    declare last_image_id varchar(50);
    SELECT ImageID into last_image_id from IMAGE
    order by ImageID desc limit 1;
    SELECT COUNT(*) INTO image_count FROM IMAGE;
    if image_count = 0 then
	set New.ImageID = CONCAT('I', LPAD(image_count + 1, 3, '0'));
    else
    set New.ImageID = CONCAT('I', LPAD(SUBSTRING(last_image_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;
-- Auto Generate PetID
drop trigger PetID_insert;
DELIMITER //
CREATE TRIGGER PetID_insert
before INSERT ON PET FOR EACH ROW
BEGIN
    declare pet_count INT;
    declare last_pet_id varchar(50);
    SELECT PetID into last_pet_id from PET
    order by PetID desc limit 1;
    SELECT COUNT(*) INTO pet_count FROM PET;
    if pet_count = 0 then
	set New.PetID = CONCAT('P', LPAD(pet_count + 1, 3, '0'));
    else
    set New.PetID = CONCAT('P', LPAD(SUBSTRING(last_pet_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;
-- Auto Generate WCID
drop trigger WCID_insert;
DELIMITER //
CREATE TRIGGER WCID_insert
before INSERT ON WEIGHTCHECK FOR EACH ROW
BEGIN
    declare WC_count INT;
    declare last_WC_id varchar(50);
    SELECT WCID into last_WC_id from WEIGHTCHECK
    order by WCID desc limit 1;
    SELECT COUNT(*) INTO WC_count FROM WEIGHTCHECK;
    if WC_count = 0 then
	set New.WCID = CONCAT('WC', LPAD(WC_count + 1, 3, '0'));
    else
    set New.WCID = CONCAT('WC', LPAD(SUBSTRING(last_WC_id, 3) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;


-- Auto Generate ScheduleID
drop trigger ScheduleID_insert;
DELIMITER //
CREATE TRIGGER ScheduleID_insert
before INSERT ON SCHEDULE FOR EACH ROW
BEGIN
    declare Schedule_count INT;
    declare last_SC_id varchar(50);
    SELECT ScheduleID into last_SC_id from SCHEDULE
    order by ScheduleID desc limit 1;
    SELECT COUNT(*) INTO Schedule_count FROM SCHEDULE;
    if Schedule_count = 0 then
	set New.ScheduleID = CONCAT('SC', LPAD(Schedule_count + 1, 3, '0'));
    else
    set New.ScheduleID = CONCAT('SC', LPAD(SUBSTRING(last_SC_id, 3) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;


-- Auto Generate ConditionID
drop trigger ConditionID_insert;
DELIMITER //
CREATE TRIGGER ConditionID_insert
before INSERT ON CONDITIONS FOR EACH ROW
BEGIN
    declare Condition_count INT;
    declare last_C_id varchar(50);
    SELECT ConditionID into last_C_id from CONDITIONS
    order by ConditionID desc limit 1;
    SELECT COUNT(*) INTO Condition_count FROM CONDITIONS;
    if Condition_count = 0 then
	set New.ConditionID = CONCAT('C', LPAD(Condition_count + 1, 3, '0'));
    else
    set New.ConditionID = CONCAT('C', LPAD(SUBSTRING(last_C_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;


-- Auto Generate MedID
drop trigger MedID_insert;
DELIMITER //
CREATE TRIGGER MedID_insert
before INSERT ON MEDICATION FOR EACH ROW
BEGIN
    declare Med_count INT;
    declare last_M_id varchar(50);
    SELECT MedID into last_M_id from MEDICATION
    order by MedID desc limit 1;
    SELECT COUNT(*) INTO Med_count FROM MEDICATION;
    if Med_count = 0 then
	set New.MedID = CONCAT('C', LPAD(Med_count + 1, 3, '0'));
    else
    set New.MedID = CONCAT('C', LPAD(SUBSTRING(last_M_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;


-- Auto Generate FoodID
drop trigger FoodID_insert;
DELIMITER //
CREATE TRIGGER FoodID_insert
before INSERT ON FOOD FOR EACH ROW
BEGIN
    declare Food_count INT;
    declare last_F_id varchar(50);
    SELECT FoodID into last_F_id from FOOD
    order by FoodID desc limit 1;
    SELECT COUNT(*) INTO Food_count FROM FOOD;
    if Food_count = 0 then
	set New.FoodID = CONCAT('F', LPAD(Food_count + 1, 3, '0'));
    else
    set New.FoodID = CONCAT('F', LPAD(SUBSTRING(last_F_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;


-- Auto Generate AuthorityID
drop trigger AuthorityID_insert;
DELIMITER //
CREATE TRIGGER AuthorityID_insert
before INSERT ON AUTHORITY FOR EACH ROW
BEGIN
    declare Authority_count INT;
    declare last_A_id varchar(50);
    SELECT AuthorityID into last_A_id from AUTHORITY
    order by AuthorityID desc limit 1;
    SELECT COUNT(*) INTO Authority_count FROM AUTHORITY;
    if Authority_count = 0 then
	set New.AuthorityID = CONCAT('A', LPAD(Authority_count + 1, 3, '0'));
    else
    set New.AuthorityID = CONCAT('A', LPAD(SUBSTRING(last_A_id, 2) + 1, 3, '0'));
	END IF;
END //
DELIMITER ;

select * from AUTHORITY;
-- Reminder Trigger for Weight_Gain
DELIMITER //
CREATE TRIGGER Reminder_INSERT_WEIGHTGAIN
AFTER INSERT ON WEIGHTCHECK FOR EACH ROW
BEGIN
    DECLARE remind_count INT;
    DECLARE last_weight DECIMAL(10, 2); -- Assuming weight is a DECIMAL type
    DECLARE pet_name VARCHAR(50);

    -- Get the last recorded weight
    SELECT Weight INTO last_weight
    FROM WEIGHTCHECK
    Where PetID = New.PetID AND WCID < NEW.WCID
    ORDER BY WCID DESC LIMIT 1;

    -- Get the count of reminders
    SELECT COUNT(*) INTO remind_count FROM REMINDER;
  

    -- Check condition for inserting reminder
    IF NEW.Weight >= (last_weight * 1.2) then
        -- Get the name of the pet associated with the customer
        SELECT Name INTO pet_name FROM PET WHERE PetID = NEW.PetID;

        -- Insert reminder
        INSERT INTO REMINDER (RemindID, WCID, Description, CreateDate) 
        VALUES (
            CONCAT('R', LPAD(remind_count + 1, 3, '0')),
            NEW.WCID,
            CONCAT('Hi, ', pet_name, ' has a great chance to be over-weighted, please be aware or ask a vet for advice.'),
            NOW()
        );
    END IF;
END //
DELIMITER ;
SELECT * FROM WEIGHTCHECK;
-- trigger for weightloss
DELIMITER //
CREATE TRIGGER Reminder_INSERT_WEIGHTLOSS
AFTER INSERT ON WEIGHTCHECK FOR EACH ROW
BEGIN
    DECLARE remind_count INT;
    DECLARE last_weight DECIMAL(10, 2); -- Assuming weight is a DECIMAL type
    DECLARE pet_name VARCHAR(50);

    -- Get the last recorded weight
    SELECT Weight INTO last_weight
    FROM WEIGHTCHECK
    Where PetID = New.PetID AND WCID < NEW.WCID
    ORDER BY WCID DESC LIMIT 1;

    -- Get the count of reminders
    SELECT COUNT(*) INTO remind_count FROM REMINDER;
  

    -- Check condition for inserting reminder
    IF NEW.Weight <= (last_weight * 0.8) then
        -- Get the name of the pet associated with the customer
        SELECT Name INTO pet_name FROM PET WHERE PetID = NEW.PetID;

        -- Insert reminder
        INSERT INTO REMINDER (RemindID, WCID, Description, CreateDate) 
        VALUES (
            CONCAT('R', LPAD(remind_count + 1, 3, '0')),
            NEW.WCID,
            CONCAT('Hi, ', pet_name, ' has a great chance to have health issue with massive weight loss, please be aware or ask a vet for advice.'),
            NOW()
        );
    END IF;
END //
DELIMITER ;
drop trigger Reminder_INSERT_WEIGHTLOSS;
select * from users;
select * from REMINDER;
select * from WEIGHTCHECK;
select * from CONDITIONS;

UPDATE SCHEDULE
set Status = 'Undone'
;

ALTER TABLE users
modify COLUMN name VARCHAR(255) NOT NULL;

ALTER TABLE users
modify COLUMN email VARCHAR(255) NOT NULL;
ALTER TABLE users
modify COLUMN password VARCHAR(255) NOT NULL;
ALTER TABLE users
modify COLUMN phone_number VARCHAR(20) NOT NULL;

ALTER TABLE SCHEDULE
ADD constraint status_check check (Status = 'Done' or Status = 'Undone');

   
start transaction;
rollback;
commit;
show triggers;
INSERT INTO WEIGHTCHECK (PetID, Weight, Date) VALUES 
('P004', 100,'2024-05-24');
INSERT INTO WEIGHTCHECK (PetID, Weight, Date) VALUES 
('P004', 200,'2024-05-24');
SELECT * FROM REMINDER;
SELECT * FROM WEIGHTCHECK
order by WCID desc;

-- view
create view Pet_View as
select OWN.UserID, P.*, TIMESTAMPDIFF(YEAR, P.BirthDate, now()) as Pet_Age 
from PET P
Join OWNERSHIP_INT OWN ON OWN.PetID = P.PetID;
select * from Pet_View;
drop view Pet_View;


CREATE VIEW Reminder_List AS
SELECT U.id, P.Name, SC.DateTime, SC.Description, SC.Status
FROM SCHEDULE SC
JOIN PET P ON P.PetID = SC.PetID
JOIN OWNERSHIP_INT OWN ON OWN.PetID = P.PetID
JOIN users U ON U.id = OWN.UserID
WHERE SC.Status = 'Undone' and NOW() >= DATE_SUB(DATE(SC.DateTime), INTERVAL 3 DAY);

start transaction;
ALTER VIEW Reminder_List (UserID, PetID, PetName, ScheduleTime, Description, Status) AS
SELECT U.id, P.PetID, P.Name, SC.DateTime, SC.Description, SC.Status
FROM SCHEDULE SC
JOIN PET P ON P.PetID = SC.PetID
JOIN OWNERSHIP_INT OWN ON OWN.PetID = P.PetID
JOIN users U ON U.id = OWN.UserID
WHERE SC.Status = 'Undone' and NOW() >= DATE_SUB(DATE(SC.DateTime), INTERVAL 3 DAY)
ORDER BY SC.DateTime, P.Name;

select * from Reminder_List;

CREATE VIEW Prescription_Page AS
SELECT SC.ScheduleID, SC.PetID, SC.DateTime, SC.Description as Schedule_Discription, M.MedName, PM.Portion, PM.Rate, M.Description as Medication_Discription
FROM SCHEDULE SC
JOIN PET_MED_INT PM ON PM.PetID = SC.PetID
JOIN MEDICATION M ON M.MedID = PM.MedID
ORDER BY SC.DateTime DESC;
select * from Prescription_Page;

CREATE VIEW Urgent_list AS
SELECT R.RemindID, WC.PetID, R.WCID, Description as Urgent_Message, R.CreateDate
FROM REMINDER R
Join WEIGHTCHECK WC on WC.WCID = R.WCID
ORDER BY RemindID desc
limit 5;
drop view Urgent_list;
start transaction;
commit;
rollback;
drop view Urgent_list;
select * from Urgent_list;

CREATE VIEW Pet_Image_Tag_List AS
select I.* ,T.TagID, T.TagName, P.PetID from IMAGE I
Join IMAGE_TAG_INT IT on I.ImageID = IT.ImageID
Join TAG T on IT.TagID = T.TagID
LEFT Join PET P on P.ImageID = I.ImageID
ORDER BY ImageID;
select * from Pet_Image_Tag_List;
drop view Pet_Image_Tag_List;
