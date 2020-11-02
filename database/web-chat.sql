-- Copyright 2020 Maksym Liannoi
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

USE master;
GO

IF DB_ID('WebChat') IS NOT NULL DROP DATABASE WebChat;

CREATE DATABASE WebChat;
GO

USE WebChat;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

-- Drop table dbo.Groups
IF OBJECT_ID('dbo.Groups') IS NOT NULL DROP TABLE dbo.Groups;
GO

-- Create table dbo.Groups
CREATE TABLE dbo.Groups
(
    GroupId INT          NOT NULL IDENTITY,
    Name    NVARCHAR(64) NOT NULL,
    CONSTRAINT PK_Groups PRIMARY KEY (GroupId),
    CONSTRAINT CHK_Groups_Name CHECK (DATALENGTH(Name) >= 2)
);

-- Drop table dbo.UserGroups
IF OBJECT_ID('dbo.UserGroups') IS NOT NULL DROP TABLE dbo.UserGroups;
GO

-- Create table dbo.UserGroups
CREATE TABLE dbo.UserGroups
(
    GroupId INT NOT NULL,
    UserId  INT NOT NULL,
    CONSTRAINT PK_UserGroups PRIMARY KEY (GroupId, UserId),
    CONSTRAINT PK_UserGroups_GroupId FOREIGN KEY (GroupId) REFERENCES dbo.Groups (GroupId),
    CONSTRAINT CHK_UserGroups_UserId CHECK (UserId >= 1)
);

-- Drop table dbo.GroupBlacklists
IF OBJECT_ID('dbo.GroupBlacklists') IS NOT NULL DROP TABLE dbo.GroupBlacklists;
GO

-- Create table dbo.GroupBlacklists
CREATE TABLE dbo.GroupBlacklists
(
    GroupId       INT NOT NULL,
    BlockedUserId INT NOT NULL,
    CONSTRAINT PK_GroupBlacklists PRIMARY KEY (GroupId, BlockedUserId),
    CONSTRAINT FK_GroupBlacklists_GroupId FOREIGN KEY (GroupId) REFERENCES dbo.Groups (GroupId),
    CONSTRAINT CHK_GroupBlacklists_BlockedUserId CHECK (BlockedUserId >= 1)
);

-- Drop table dbo.GroupAdministrators
IF OBJECT_ID('dbo.GroupAdministrators') IS NOT NULL DROP TABLE dbo.GroupAdministrators;
GO

-- Create table dbo.GroupAdministrators
CREATE TABLE dbo.GroupAdministrators
(
    GroupId             INT NOT NULL,
    AdministratorUserId INT NOT NULL,
    CONSTRAINT PK_GroupAdministrators PRIMARY KEY (GroupId, AdministratorUserId),
    CONSTRAINT FK_GroupAdministrators_GroupId FOREIGN KEY (GroupId) REFERENCES dbo.Groups (GroupId),
    CONSTRAINT CHK_GroupAdministrators_AdministratorUserId CHECK (AdministratorUserId >= 1)
);

-- Drop table dbo.GroupMessages
IF OBJECT_ID('dbo.GroupMessages') IS NOT NULL DROP TABLE dbo.GroupMessages;
GO

-- Create table dbo.GroupMessages
CREATE TABLE dbo.GroupMessages
(
    GroupMessageId INT            NOT NULL IDENTITY,
    GroupId        INT            NOT NULL,
    OwnerUserId    INT            NOT NULL,
    Message        NVARCHAR(1024) NOT NULL,
    Publish        DATETIME       NOT NULL
        CONSTRAINT DFT_GroupMessages_Publish DEFAULT (GETDATE()),
    CONSTRAINT PK_GroupMessages PRIMARY KEY (GroupMessageId),
    CONSTRAINT FK_GroupMessages_GroupId FOREIGN KEY (GroupId) REFERENCES dbo.Groups (GroupId),
    CONSTRAINT CHK_GroupMessages_OwnerUserId CHECK (OwnerUserId >= 1),
    CONSTRAINT CHK_GroupMessages_Message CHECK (DATALENGTH(Message) >= 2),
    CONSTRAINT CHK_GroupMessages_Publish CHECK (Publish <= GETDATE())
);

-- Drop table dbo.Conversations
IF OBJECT_ID('dbo.Conversations') IS NOT NULL DROP TABLE dbo.Conversations;
GO

-- Create table dbo.Conversations
CREATE TABLE dbo.Conversations
(
    ConversationId INT NOT NULL IDENTITY,
    LeftUserId     INT NOT NULL,
    RightUserId    INT NOT NULL,
    CONSTRAINT PK_Conversations PRIMARY KEY (ConversationId),
    CONSTRAINT CHK_Conversations_LeftUserId CHECK (LeftUserId >= 1),
    CONSTRAINT CHK_Conversations_RightUserId CHECK (RightUserId >= 1)
);

-- Drop table dbo.ConversationMessages
IF OBJECT_ID('dbo.ConversationMessages') IS NOT NULL DROP TABLE dbo.ConversationMessages;
GO

-- Create table dbo.ConversationMessages
CREATE TABLE dbo.ConversationMessages
(
    ConversationMessageId INT            NOT NULL IDENTITY,
    ConversationId        INT            NOT NULL,
    OwnerUserId           INT            NOT NULL,
    Message               NVARCHAR(1024) NOT NULL,
    Publish               DATETIME       NOT NULL
        CONSTRAINT DFT_ConversationMessages_Publish DEFAULT (GETDATE()),
    CONSTRAINT PK_ConversationMessages PRIMARY KEY (ConversationMessageId),
    CONSTRAINT FK_ConversationMessages_ConversationId FOREIGN KEY (ConversationId) REFERENCES dbo.Conversations (ConversationId),
    CONSTRAINT CHK_ConversationMessages_OwnerUserId CHECK (OwnerUserId >= 1),
    CONSTRAINT CHK_ConversationMessages_Message CHECK (DATALENGTH(Message) >= 2),
    CONSTRAINT CHK_ConversationMessages_Publish CHECK (Publish <= GETDATE())
);

-- Drop table dbo.Contacts
IF OBJECT_ID('dbo.Contacts') IS NOT NULL DROP TABLE dbo.Contacts;
GO

-- Create table dbo.Contacts
CREATE TABLE dbo.Contacts
(
    ContactId   INT           NOT NULL IDENTITY,
    OwnerUserId INT           NOT NULL,
    FirstName   NVARCHAR(64)  NOT NULL,
    LastName    NVARCHAR(64)  NULL,
    Email       NVARCHAR(128) NOT NULL,
    Photo       NVARCHAR(256) NULL,
    CONSTRAINT PK_Contacts PRIMARY KEY (ContactId),
    CONSTRAINT CHK_Contacts_OwnerUserId CHECK (OwnerUserId >= 1),
    CONSTRAINT CHK_Contacts_FirstName CHECK (DATALENGTH(FirstName) >= 2),
    CONSTRAINT CHK_Contacts_Email CHECK (DATALENGTH(Email) >= 2)
);

-- Drop table dbo.UserBlacklists
IF OBJECT_ID('dbo.UserBlacklists') IS NOT NULL DROP TABLE dbo.UserBlacklists;
GO

-- Create table dbo.UserBlacklists
CREATE TABLE dbo.UserBlacklists
(
    OwnerUserId   INT NOT NULL,
    BlockedUserId INT NOT NULL,
    CONSTRAINT PK_UserBlacklists PRIMARY KEY (OwnerUserId, BlockedUserId),
    CONSTRAINT CHK_UserBlacklists_OwnerUserId CHECK (OwnerUserId >= 1),
    CONSTRAINT CHK_UserBlacklists_BlockedUserId CHECK (BlockedUserId >= 1)
);
GO
---------------------------------------------------------------------
-- Populate Tables
---------------------------------------------------------------------

SET NOCOUNT ON;

-- Populate table dbo.Groups
INSERT INTO Groups (name)
VALUES ('elementum in hac habitasse');
INSERT INTO Groups (name)
VALUES ('nulla sed accumsan felis ut');
INSERT INTO Groups (name)
VALUES ('sapien ut nunc vestibulum');
INSERT INTO Groups (name)
VALUES ('at dolor quis');
INSERT INTO Groups (name)
VALUES ('sed tincidunt eu felis');
INSERT INTO Groups (name)
VALUES ('in quis justo');
INSERT INTO Groups (name)
VALUES ('in est risus auctor');
INSERT INTO Groups (name)
VALUES ('est risus auctor sed');
INSERT INTO Groups (name)
VALUES ('diam erat fermentum');
INSERT INTO Groups (name)
VALUES ('tempus vel pede morbi');
INSERT INTO Groups (name)
VALUES ('ac consequat metus');
INSERT INTO Groups (name)
VALUES ('penatibus et magnis');
INSERT INTO Groups (name)
VALUES ('metus vitae ipsum aliquam non');
INSERT INTO Groups (name)
VALUES ('mollis molestie lorem quisque');
INSERT INTO Groups (name)
VALUES ('euismod scelerisque quam');
INSERT INTO Groups (name)
VALUES ('mi nulla ac');
INSERT INTO Groups (name)
VALUES ('at feugiat non');
INSERT INTO Groups (name)
VALUES ('justo in hac');
INSERT INTO Groups (name)
VALUES ('a ipsum');
INSERT INTO Groups (name)
VALUES ('vitae nisi');
INSERT INTO Groups (name)
VALUES ('libero nam dui');
INSERT INTO Groups (name)
VALUES ('sed vel enim sit amet');
INSERT INTO Groups (name)
VALUES ('vel nisl');
INSERT INTO Groups (name)
VALUES ('vestibulum sagittis sapien cum');
INSERT INTO Groups (name)
VALUES ('id ornare imperdiet sapien');
INSERT INTO Groups (name)
VALUES ('iaculis diam erat fermentum justo');
INSERT INTO Groups (name)
VALUES ('orci luctus et');
INSERT INTO Groups (name)
VALUES ('dapibus duis');
INSERT INTO Groups (name)
VALUES ('in tempus sit amet');
INSERT INTO Groups (name)
VALUES ('in felis eu sapien');
INSERT INTO Groups (name)
VALUES ('aliquam augue');
INSERT INTO Groups (name)
VALUES ('elementum ligula');
INSERT INTO Groups (name)
VALUES ('lacus purus');
INSERT INTO Groups (name)
VALUES ('ac nibh fusce lacus purus');
INSERT INTO Groups (name)
VALUES ('vulputate vitae');
INSERT INTO Groups (name)
VALUES ('phasellus sit amet');
INSERT INTO Groups (name)
VALUES ('sit amet erat nulla');
INSERT INTO Groups (name)
VALUES ('in consequat ut nulla sed');
INSERT INTO Groups (name)
VALUES ('erat tortor sollicitudin mi sit');

-- Populate table dbo.UserGroups
INSERT INTO UserGroups (groupid, userid)
VALUES (1, 1);
INSERT INTO UserGroups (groupid, userid)
VALUES (5, 1);
INSERT INTO UserGroups (groupid, userid)
VALUES (8, 1);

-- Populate table dbo.GroupBlacklists


-- Populate table dbo.GroupAdministrators
INSERT INTO GroupAdministrators (groupid, administratoruserid)
VALUES (1, 1);
INSERT INTO GroupAdministrators (groupid, administratoruserid)
VALUES (5, 1);
INSERT INTO GroupAdministrators (groupid, administratoruserid)
VALUES (8, 1);

-- Populate table dbo.GroupMessages
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 1, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 1, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 2, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 2, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 2, 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 3, 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 3, 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 1, 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 2, 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.');
INSERT INTO GroupMessages (GroupId, OwnerUserId, Message) VALUES (1, 1, 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.');

-- Populate table dbo.Conversations
INSERT INTO Conversations (leftuserid, rightuserid)
VALUES (1, 2);
INSERT INTO Conversations (leftuserid, rightuserid)
VALUES (1, 3);

-- Populate table dbo.ConversationMessages
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (2, 1, 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (2, 3, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (2, 1, 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (2, 3, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (2, 3, 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (1, 2, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (1, 1, 'Quisque ut erat.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (1, 1, 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (1, 2, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.');
INSERT INTO ConversationMessages (ConversationId, OwnerUserId, Message) VALUES (1, 2, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');

-- Populate table dbo.Contacts
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Dorian', 'Yaxley', 'dyaxley0@census.gov');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Zaccaria', 'Showler', 'zshowler1@simplemachines.org');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Edmon', 'Kiff', 'ekiff2@4shared.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Gordie', 'Luard', 'gluard3@yellowpages.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Valdemar', 'Halcro', 'vhalcro4@e-recht24.de');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Isidoro', 'Cluse', 'icluse5@tuttocitta.it');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Florrie', 'Rubinchik', 'frubinchik6@cpanel.net');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Kelsey', 'Mallya', 'kmallya7@aol.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Ives', 'Mc Grath', 'imcgrath8@rambler.ru');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Cory', 'Varley', 'cvarleyc@aol.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (1, 'Tannie', 'Breese', 'tbreesea@youku.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Alphard', 'Hedingham', 'ahedingham1@loc.gov');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Veronika', 'Roose', 'vroose2@cnn.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Bethanne', 'McFall', 'bmcfall3@mail.ru');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Payton', 'Harlow', 'pharlow4@kickstarter.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Ariel', 'Videneev', 'avideneev5@reuters.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Donny', 'Trevon', 'dtrevon6@ftc.gov');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Douglass', 'Zielinski', 'dzielinski7@stumbleupon.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Joey', 'Castelow', 'jcastelow8@surveymonkey.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (2, 'Corella', 'Scullion', 'cscullion9@jugem.jp');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Emmalyn', 'Feldhorn', 'efeldhornd@washington.edu');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Cathie', 'Turley', 'cturleye@prweb.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Aldrich', 'Trenear', 'atrenearf@drupal.org');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Marietta', 'Tembey', 'mtembeyg@symantec.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Ekaterina', 'Strafford', 'estraffordh@washington.edu');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Fraser', 'Kilrow', 'fkilrowi@cdbaby.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Leopold', 'Beddoe', 'lbeddoej@homestead.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Moselle', 'Turgoose', 'mturgoose0@kickstarter.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Jemimah', 'Tuhy', 'jtuhy9@latimes.com');
INSERT INTO Contacts (owneruserid, firstname, lastname, email)
VALUES (3, 'Hillary', 'Cholerton', 'hcholertonb@de.vu');

-- Populate table dbo.UserBlacklists
INSERT INTO UserBlacklists (owneruserid, blockeduserid)
VALUES (1, 4);

SET NOCOUNT OFF;
GO
