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
    Message        NVARCHAR(1024) NOT NULL,
    CONSTRAINT PK_GroupMessages PRIMARY KEY (GroupMessageId),
    CONSTRAINT FK_GroupMessages_GroupId FOREIGN KEY (GroupId) REFERENCES dbo.Groups (GroupId),
    CONSTRAINT CHK_GroupMessages_Message CHECK (DATALENGTH(Message) >= 2)
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
    ConversationMessageId INT           NOT NULL IDENTITY,
    ConversationId        INT           NOT NULL,
    Message               NVARCHAR(1024) NOT NULL,
    CONSTRAINT PK_ConversationMessages PRIMARY KEY (ConversationMessageId),
    CONSTRAINT FK_ConversationMessages_ConversationId FOREIGN KEY (ConversationId) REFERENCES dbo.Conversations (ConversationId),
    CONSTRAINT CHK_ConversationMessages_Message CHECK (DATALENGTH(Message) >= 2)
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
VALUES ('ac nibh');
INSERT INTO Groups (name)
VALUES ('morbi non lectus');
INSERT INTO Groups (name)
VALUES ('libero quis orci');
INSERT INTO Groups (name)
VALUES ('donec ut dolor morbi vel');
INSERT INTO Groups (name)
VALUES ('quisque ut');
INSERT INTO Groups (name)
VALUES ('vitae quam');
INSERT INTO Groups (name)
VALUES ('in hac habitasse platea');
INSERT INTO Groups (name)
VALUES ('vel enim');
INSERT INTO Groups (name)
VALUES ('consequat ut nulla');
INSERT INTO Groups (name)
VALUES ('in magna');
INSERT INTO Groups (name)
VALUES ('nec nisi vulputate nonummy');
INSERT INTO Groups (name)
VALUES ('dui luctus rutrum');
INSERT INTO Groups (name)
VALUES ('at nulla suspendisse potenti cras');
INSERT INTO Groups (name)
VALUES ('vel ipsum praesent blandit');
INSERT INTO Groups (name)
VALUES ('odio consequat');
INSERT INTO Groups (name)
VALUES ('sed accumsan felis');
INSERT INTO Groups (name)
VALUES ('sapien in');
INSERT INTO Groups (name)
VALUES ('nisi eu orci');
INSERT INTO Groups (name)
VALUES ('ipsum primis in faucibus');
INSERT INTO Groups (name)
VALUES ('ultrices libero non');
INSERT INTO Groups (name)
VALUES ('faucibus accumsan');
INSERT INTO Groups (name)
VALUES ('proin interdum mauris non');
INSERT INTO Groups (name)
VALUES ('duis faucibus');
INSERT INTO Groups (name)
VALUES ('eleifend pede');
INSERT INTO Groups (name)
VALUES ('lacus at turpis donec');
INSERT INTO Groups (name)
VALUES ('morbi quis tortor id nulla');
INSERT INTO Groups (name)
VALUES ('in purus eu');
INSERT INTO Groups (name)
VALUES ('ante vel ipsum praesent blandit');
INSERT INTO Groups (name)
VALUES ('tellus nulla ut');
INSERT INTO Groups (name)
VALUES ('pellentesque ultrices phasellus');
INSERT INTO Groups (name)
VALUES ('diam in magna bibendum imperdiet');
INSERT INTO Groups (name)
VALUES ('rhoncus mauris enim leo');
INSERT INTO Groups (name)
VALUES ('eu massa donec');
INSERT INTO Groups (name)
VALUES ('morbi non lectus aliquam sit');
INSERT INTO Groups (name)
VALUES ('donec ut mauris eget massa');
INSERT INTO Groups (name)
VALUES ('pellentesque viverra pede');
INSERT INTO Groups (name)
VALUES ('ultricies eu');
INSERT INTO Groups (name)
VALUES ('lobortis est phasellus sit amet');
INSERT INTO Groups (name)
VALUES ('primis in faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('sit amet');
INSERT INTO Groups (name)
VALUES ('sit amet erat');
INSERT INTO Groups (name)
VALUES ('congue eget semper rutrum nulla');
INSERT INTO Groups (name)
VALUES ('montes nascetur ridiculus mus vivamus');
INSERT INTO Groups (name)
VALUES ('cubilia curae nulla');
INSERT INTO Groups (name)
VALUES ('etiam vel augue');
INSERT INTO Groups (name)
VALUES ('nisl ut volutpat sapien arcu');
INSERT INTO Groups (name)
VALUES ('aliquet at feugiat non pretium');
INSERT INTO Groups (name)
VALUES ('praesent id massa');
INSERT INTO Groups (name)
VALUES ('venenatis turpis enim');
INSERT INTO Groups (name)
VALUES ('curabitur convallis duis consequat dui');
INSERT INTO Groups (name)
VALUES ('faucibus orci luctus et');
INSERT INTO Groups (name)
VALUES ('faucibus cursus urna');
INSERT INTO Groups (name)
VALUES ('ligula suspendisse ornare consequat');
INSERT INTO Groups (name)
VALUES ('malesuada in imperdiet et');
INSERT INTO Groups (name)
VALUES ('ante vivamus');
INSERT INTO Groups (name)
VALUES ('eget congue eget');
INSERT INTO Groups (name)
VALUES ('volutpat quam pede lobortis ligula');
INSERT INTO Groups (name)
VALUES ('elementum ligula vehicula consequat');
INSERT INTO Groups (name)
VALUES ('dui maecenas tristique est');
INSERT INTO Groups (name)
VALUES ('eget eros elementum pellentesque quisque');
INSERT INTO Groups (name)
VALUES ('pede venenatis non');
INSERT INTO Groups (name)
VALUES ('congue risus semper');
INSERT INTO Groups (name)
VALUES ('augue luctus tincidunt');
INSERT INTO Groups (name)
VALUES ('ultrices aliquet');
INSERT INTO Groups (name)
VALUES ('curabitur in libero ut');
INSERT INTO Groups (name)
VALUES ('ac diam');
INSERT INTO Groups (name)
VALUES ('augue vestibulum ante ipsum primis');
INSERT INTO Groups (name)
VALUES ('lacinia eget');
INSERT INTO Groups (name)
VALUES ('pellentesque volutpat dui maecenas tristique');
INSERT INTO Groups (name)
VALUES ('quis turpis');
INSERT INTO Groups (name)
VALUES ('eget nunc donec quis orci');
INSERT INTO Groups (name)
VALUES ('congue elementum in');
INSERT INTO Groups (name)
VALUES ('est lacinia');
INSERT INTO Groups (name)
VALUES ('libero nam dui proin leo');
INSERT INTO Groups (name)
VALUES ('nisl nunc');
INSERT INTO Groups (name)
VALUES ('ut nulla sed');
INSERT INTO Groups (name)
VALUES ('purus eu');
INSERT INTO Groups (name)
VALUES ('leo odio condimentum id');
INSERT INTO Groups (name)
VALUES ('orci luctus et ultrices posuere');
INSERT INTO Groups (name)
VALUES ('primis in');
INSERT INTO Groups (name)
VALUES ('vel sem sed');
INSERT INTO Groups (name)
VALUES ('fusce congue');
INSERT INTO Groups (name)
VALUES ('quis justo maecenas');
INSERT INTO Groups (name)
VALUES ('viverra eget congue eget');
INSERT INTO Groups (name)
VALUES ('quam sollicitudin vitae');
INSERT INTO Groups (name)
VALUES ('lorem integer');
INSERT INTO Groups (name)
VALUES ('cras in purus');
INSERT INTO Groups (name)
VALUES ('integer aliquet');
INSERT INTO Groups (name)
VALUES ('nec nisi vulputate');
INSERT INTO Groups (name)
VALUES ('metus vitae ipsum aliquam');
INSERT INTO Groups (name)
VALUES ('at diam nam tristique tortor');
INSERT INTO Groups (name)
VALUES ('quisque id');
INSERT INTO Groups (name)
VALUES ('sit amet diam in');
INSERT INTO Groups (name)
VALUES ('vestibulum ante ipsum primis');
INSERT INTO Groups (name)
VALUES ('auctor sed tristique in tempus');
INSERT INTO Groups (name)
VALUES ('magna ac consequat metus sapien');
INSERT INTO Groups (name)
VALUES ('dui vel sem sed');
INSERT INTO Groups (name)
VALUES ('ipsum aliquam non');
INSERT INTO Groups (name)
VALUES ('nisi nam');
INSERT INTO Groups (name)
VALUES ('vestibulum rutrum rutrum neque aenean');
INSERT INTO Groups (name)
VALUES ('facilisi cras non velit');
INSERT INTO Groups (name)
VALUES ('pede morbi porttitor lorem id');
INSERT INTO Groups (name)
VALUES ('sit amet');
INSERT INTO Groups (name)
VALUES ('nulla quisque');
INSERT INTO Groups (name)
VALUES ('a odio');
INSERT INTO Groups (name)
VALUES ('posuere felis sed lacus');
INSERT INTO Groups (name)
VALUES ('in sapien iaculis congue vivamus');
INSERT INTO Groups (name)
VALUES ('varius ut blandit');
INSERT INTO Groups (name)
VALUES ('nulla pede');
INSERT INTO Groups (name)
VALUES ('in eleifend quam a');
INSERT INTO Groups (name)
VALUES ('elementum pellentesque quisque porta');
INSERT INTO Groups (name)
VALUES ('augue vel accumsan tellus nisi');
INSERT INTO Groups (name)
VALUES ('eget rutrum at');
INSERT INTO Groups (name)
VALUES ('ipsum aliquam');
INSERT INTO Groups (name)
VALUES ('eget congue eget semper');
INSERT INTO Groups (name)
VALUES ('pede posuere');
INSERT INTO Groups (name)
VALUES ('duis mattis egestas metus aenean');
INSERT INTO Groups (name)
VALUES ('quisque id justo sit');
INSERT INTO Groups (name)
VALUES ('odio elementum eu interdum');
INSERT INTO Groups (name)
VALUES ('suspendisse potenti nullam porttitor');
INSERT INTO Groups (name)
VALUES ('amet cursus id turpis');
INSERT INTO Groups (name)
VALUES ('odio in hac habitasse');
INSERT INTO Groups (name)
VALUES ('cubilia curae');
INSERT INTO Groups (name)
VALUES ('augue vestibulum ante ipsum');
INSERT INTO Groups (name)
VALUES ('tellus in');
INSERT INTO Groups (name)
VALUES ('nibh quisque');
INSERT INTO Groups (name)
VALUES ('tempus sit');
INSERT INTO Groups (name)
VALUES ('volutpat erat quisque erat eros');
INSERT INTO Groups (name)
VALUES ('ipsum primis in faucibus');
INSERT INTO Groups (name)
VALUES ('non velit nec nisi');
INSERT INTO Groups (name)
VALUES ('vulputate elementum nullam varius nulla');
INSERT INTO Groups (name)
VALUES ('natoque penatibus');
INSERT INTO Groups (name)
VALUES ('natoque penatibus');
INSERT INTO Groups (name)
VALUES ('amet eleifend pede libero quis');
INSERT INTO Groups (name)
VALUES ('a feugiat et eros');
INSERT INTO Groups (name)
VALUES ('tincidunt eu felis fusce');
INSERT INTO Groups (name)
VALUES ('elementum in');
INSERT INTO Groups (name)
VALUES ('pharetra magna vestibulum');
INSERT INTO Groups (name)
VALUES ('nibh in quis');
INSERT INTO Groups (name)
VALUES ('ante ipsum primis in');
INSERT INTO Groups (name)
VALUES ('aenean auctor gravida');
INSERT INTO Groups (name)
VALUES ('lobortis est phasellus sit');
INSERT INTO Groups (name)
VALUES ('sit amet sem fusce consequat');
INSERT INTO Groups (name)
VALUES ('dictumst morbi');
INSERT INTO Groups (name)
VALUES ('potenti nullam porttitor lacus at');
INSERT INTO Groups (name)
VALUES ('lorem quisque ut');
INSERT INTO Groups (name)
VALUES ('penatibus et');
INSERT INTO Groups (name)
VALUES ('et ultrices posuere cubilia curae');
INSERT INTO Groups (name)
VALUES ('faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('elementum pellentesque');
INSERT INTO Groups (name)
VALUES ('imperdiet et commodo');
INSERT INTO Groups (name)
VALUES ('duis at');
INSERT INTO Groups (name)
VALUES ('donec semper');
INSERT INTO Groups (name)
VALUES ('iaculis diam erat');
INSERT INTO Groups (name)
VALUES ('vestibulum ac est');
INSERT INTO Groups (name)
VALUES ('donec semper sapien a');
INSERT INTO Groups (name)
VALUES ('porttitor id');
INSERT INTO Groups (name)
VALUES ('cum sociis natoque');
INSERT INTO Groups (name)
VALUES ('in magna');
INSERT INTO Groups (name)
VALUES ('rutrum nulla nunc purus phasellus');
INSERT INTO Groups (name)
VALUES ('posuere nonummy integer');
INSERT INTO Groups (name)
VALUES ('quam suspendisse potenti nullam');
INSERT INTO Groups (name)
VALUES ('eget eleifend luctus ultricies');
INSERT INTO Groups (name)
VALUES ('sed magna at nunc');
INSERT INTO Groups (name)
VALUES ('augue aliquam');
INSERT INTO Groups (name)
VALUES ('vivamus metus arcu adipiscing molestie');
INSERT INTO Groups (name)
VALUES ('interdum mauris non ligula');
INSERT INTO Groups (name)
VALUES ('lobortis est phasellus sit amet');
INSERT INTO Groups (name)
VALUES ('sapien urna pretium');
INSERT INTO Groups (name)
VALUES ('erat quisque');
INSERT INTO Groups (name)
VALUES ('orci mauris lacinia sapien');
INSERT INTO Groups (name)
VALUES ('lobortis convallis tortor');
INSERT INTO Groups (name)
VALUES ('et ultrices posuere cubilia curae');
INSERT INTO Groups (name)
VALUES ('egestas metus aenean');
INSERT INTO Groups (name)
VALUES ('ut erat curabitur gravida nisi');
INSERT INTO Groups (name)
VALUES ('turpis adipiscing');
INSERT INTO Groups (name)
VALUES ('ultrices aliquet');
INSERT INTO Groups (name)
VALUES ('est phasellus');
INSERT INTO Groups (name)
VALUES ('curabitur convallis duis consequat');
INSERT INTO Groups (name)
VALUES ('in sapien iaculis congue');
INSERT INTO Groups (name)
VALUES ('convallis morbi odio');
INSERT INTO Groups (name)
VALUES ('nisi nam ultrices');
INSERT INTO Groups (name)
VALUES ('etiam justo etiam pretium');
INSERT INTO Groups (name)
VALUES ('nulla nisl nunc nisl duis');
INSERT INTO Groups (name)
VALUES ('vel lectus');
INSERT INTO Groups (name)
VALUES ('ipsum primis in faucibus');
INSERT INTO Groups (name)
VALUES ('pharetra magna vestibulum aliquet ultrices');
INSERT INTO Groups (name)
VALUES ('nulla justo aliquam quis turpis');
INSERT INTO Groups (name)
VALUES ('sed magna');
INSERT INTO Groups (name)
VALUES ('malesuada in');
INSERT INTO Groups (name)
VALUES ('odio elementum eu interdum');
INSERT INTO Groups (name)
VALUES ('primis in faucibus');
INSERT INTO Groups (name)
VALUES ('dui nec nisi volutpat');
INSERT INTO Groups (name)
VALUES ('urna ut tellus nulla');
INSERT INTO Groups (name)
VALUES ('tortor quis');
INSERT INTO Groups (name)
VALUES ('eu massa donec dapibus duis');
INSERT INTO Groups (name)
VALUES ('amet justo morbi ut');
INSERT INTO Groups (name)
VALUES ('lorem ipsum dolor');
INSERT INTO Groups (name)
VALUES ('proin eu mi');
INSERT INTO Groups (name)
VALUES ('rhoncus sed');
INSERT INTO Groups (name)
VALUES ('vestibulum proin eu');
INSERT INTO Groups (name)
VALUES ('tortor duis mattis');
INSERT INTO Groups (name)
VALUES ('non ligula pellentesque');
INSERT INTO Groups (name)
VALUES ('eget rutrum at lorem integer');
INSERT INTO Groups (name)
VALUES ('quis libero nullam');
INSERT INTO Groups (name)
VALUES ('libero rutrum');
INSERT INTO Groups (name)
VALUES ('id lobortis convallis');
INSERT INTO Groups (name)
VALUES ('pharetra magna ac');
INSERT INTO Groups (name)
VALUES ('tortor sollicitudin');
INSERT INTO Groups (name)
VALUES ('felis eu sapien cursus vestibulum');
INSERT INTO Groups (name)
VALUES ('faucibus orci');
INSERT INTO Groups (name)
VALUES ('donec quis orci');
INSERT INTO Groups (name)
VALUES ('nisi volutpat');
INSERT INTO Groups (name)
VALUES ('quisque erat');
INSERT INTO Groups (name)
VALUES ('quam suspendisse potenti nullam');
INSERT INTO Groups (name)
VALUES ('posuere cubilia curae mauris');
INSERT INTO Groups (name)
VALUES ('venenatis lacinia aenean sit amet');
INSERT INTO Groups (name)
VALUES ('augue vel');
INSERT INTO Groups (name)
VALUES ('interdum venenatis turpis');
INSERT INTO Groups (name)
VALUES ('ultrices mattis');
INSERT INTO Groups (name)
VALUES ('neque sapien placerat ante');
INSERT INTO Groups (name)
VALUES ('nisi vulputate nonummy');
INSERT INTO Groups (name)
VALUES ('in quam fringilla');
INSERT INTO Groups (name)
VALUES ('vestibulum sagittis');
INSERT INTO Groups (name)
VALUES ('hac habitasse platea');
INSERT INTO Groups (name)
VALUES ('ut rhoncus aliquet');
INSERT INTO Groups (name)
VALUES ('tortor sollicitudin mi sit amet');
INSERT INTO Groups (name)
VALUES ('pellentesque volutpat dui');
INSERT INTO Groups (name)
VALUES ('pede justo lacinia');
INSERT INTO Groups (name)
VALUES ('turpis adipiscing');
INSERT INTO Groups (name)
VALUES ('felis fusce posuere felis');
INSERT INTO Groups (name)
VALUES ('vehicula condimentum curabitur in');
INSERT INTO Groups (name)
VALUES ('ipsum dolor sit amet');
INSERT INTO Groups (name)
VALUES ('consectetuer eget rutrum at');
INSERT INTO Groups (name)
VALUES ('luctus et ultrices');
INSERT INTO Groups (name)
VALUES ('amet lobortis sapien sapien non');
INSERT INTO Groups (name)
VALUES ('faucibus accumsan odio curabitur');
INSERT INTO Groups (name)
VALUES ('suspendisse ornare consequat');
INSERT INTO Groups (name)
VALUES ('diam id ornare imperdiet');
INSERT INTO Groups (name)
VALUES ('pede lobortis ligula');
INSERT INTO Groups (name)
VALUES ('amet turpis elementum ligula');
INSERT INTO Groups (name)
VALUES ('posuere cubilia curae donec');
INSERT INTO Groups (name)
VALUES ('sapien sapien non mi integer');
INSERT INTO Groups (name)
VALUES ('eget nunc donec');
INSERT INTO Groups (name)
VALUES ('sit amet');
INSERT INTO Groups (name)
VALUES ('et tempus semper');
INSERT INTO Groups (name)
VALUES ('ligula suspendisse ornare consequat');
INSERT INTO Groups (name)
VALUES ('mauris non ligula pellentesque ultrices');
INSERT INTO Groups (name)
VALUES ('accumsan odio curabitur');
INSERT INTO Groups (name)
VALUES ('pellentesque eget nunc');
INSERT INTO Groups (name)
VALUES ('bibendum morbi');
INSERT INTO Groups (name)
VALUES ('leo rhoncus sed vestibulum sit');
INSERT INTO Groups (name)
VALUES ('nec sem duis aliquam');
INSERT INTO Groups (name)
VALUES ('tortor eu pede');
INSERT INTO Groups (name)
VALUES ('luctus et');
INSERT INTO Groups (name)
VALUES ('ornare consequat');
INSERT INTO Groups (name)
VALUES ('sollicitudin mi');
INSERT INTO Groups (name)
VALUES ('vitae nisl aenean');
INSERT INTO Groups (name)
VALUES ('at turpis donec posuere metus');
INSERT INTO Groups (name)
VALUES ('consectetuer eget rutrum at');
INSERT INTO Groups (name)
VALUES ('nulla ac');
INSERT INTO Groups (name)
VALUES ('adipiscing elit proin risus');
INSERT INTO Groups (name)
VALUES ('odio condimentum id luctus nec');
INSERT INTO Groups (name)
VALUES ('hac habitasse platea dictumst');
INSERT INTO Groups (name)
VALUES ('dapibus augue vel');
INSERT INTO Groups (name)
VALUES ('orci luctus et');
INSERT INTO Groups (name)
VALUES ('venenatis tristique fusce');
INSERT INTO Groups (name)
VALUES ('velit id pretium');
INSERT INTO Groups (name)
VALUES ('eget nunc');
INSERT INTO Groups (name)
VALUES ('nulla tellus');
INSERT INTO Groups (name)
VALUES ('odio donec vitae nisi');
INSERT INTO Groups (name)
VALUES ('curae duis faucibus accumsan');
INSERT INTO Groups (name)
VALUES ('sagittis nam');
INSERT INTO Groups (name)
VALUES ('congue risus semper porta volutpat');
INSERT INTO Groups (name)
VALUES ('mauris enim leo');
INSERT INTO Groups (name)
VALUES ('pellentesque eget nunc donec');
INSERT INTO Groups (name)
VALUES ('luctus rutrum nulla tellus');
INSERT INTO Groups (name)
VALUES ('posuere cubilia curae duis');
INSERT INTO Groups (name)
VALUES ('primis in faucibus');
INSERT INTO Groups (name)
VALUES ('dui vel');
INSERT INTO Groups (name)
VALUES ('sapien ut');
INSERT INTO Groups (name)
VALUES ('morbi ut odio cras');
INSERT INTO Groups (name)
VALUES ('leo odio condimentum');
INSERT INTO Groups (name)
VALUES ('bibendum morbi non quam');
INSERT INTO Groups (name)
VALUES ('consequat in');
INSERT INTO Groups (name)
VALUES ('ultrices posuere cubilia');
INSERT INTO Groups (name)
VALUES ('elementum pellentesque quisque');
INSERT INTO Groups (name)
VALUES ('sit amet cursus');
INSERT INTO Groups (name)
VALUES ('sapien sapien non mi');
INSERT INTO Groups (name)
VALUES ('nibh in lectus pellentesque at');
INSERT INTO Groups (name)
VALUES ('metus arcu adipiscing molestie hendrerit');
INSERT INTO Groups (name)
VALUES ('ligula pellentesque ultrices phasellus id');
INSERT INTO Groups (name)
VALUES ('eu est congue');
INSERT INTO Groups (name)
VALUES ('eleifend quam a');
INSERT INTO Groups (name)
VALUES ('felis ut at');
INSERT INTO Groups (name)
VALUES ('porttitor pede');
INSERT INTO Groups (name)
VALUES ('nisi nam ultrices libero');
INSERT INTO Groups (name)
VALUES ('ipsum primis in faucibus orci');
INSERT INTO Groups (name)
VALUES ('felis sed interdum venenatis');
INSERT INTO Groups (name)
VALUES ('pellentesque quisque porta volutpat erat');
INSERT INTO Groups (name)
VALUES ('praesent blandit');
INSERT INTO Groups (name)
VALUES ('lacus purus aliquet at feugiat');
INSERT INTO Groups (name)
VALUES ('faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('nibh fusce lacus purus aliquet');
INSERT INTO Groups (name)
VALUES ('sapien cursus vestibulum');
INSERT INTO Groups (name)
VALUES ('elementum nullam');
INSERT INTO Groups (name)
VALUES ('tortor risus');
INSERT INTO Groups (name)
VALUES ('massa id nisl venenatis');
INSERT INTO Groups (name)
VALUES ('massa donec dapibus duis at');
INSERT INTO Groups (name)
VALUES ('gravida sem');
INSERT INTO Groups (name)
VALUES ('amet cursus id turpis integer');
INSERT INTO Groups (name)
VALUES ('quis odio');
INSERT INTO Groups (name)
VALUES ('eu tincidunt in leo maecenas');
INSERT INTO Groups (name)
VALUES ('lectus aliquam');
INSERT INTO Groups (name)
VALUES ('justo in');
INSERT INTO Groups (name)
VALUES ('iaculis diam erat fermentum');
INSERT INTO Groups (name)
VALUES ('duis consequat dui nec nisi');
INSERT INTO Groups (name)
VALUES ('aliquam non mauris morbi non');
INSERT INTO Groups (name)
VALUES ('nunc vestibulum');
INSERT INTO Groups (name)
VALUES ('ridiculus mus');
INSERT INTO Groups (name)
VALUES ('sapien quis libero nullam sit');
INSERT INTO Groups (name)
VALUES ('ligula pellentesque');
INSERT INTO Groups (name)
VALUES ('integer ac leo pellentesque');
INSERT INTO Groups (name)
VALUES ('in sagittis dui vel');
INSERT INTO Groups (name)
VALUES ('rutrum at lorem integer');
INSERT INTO Groups (name)
VALUES ('faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('in eleifend quam a');
INSERT INTO Groups (name)
VALUES ('rhoncus sed vestibulum sit');
INSERT INTO Groups (name)
VALUES ('nulla integer pede justo lacinia');
INSERT INTO Groups (name)
VALUES ('nunc donec quis orci');
INSERT INTO Groups (name)
VALUES ('blandit lacinia erat');
INSERT INTO Groups (name)
VALUES ('bibendum morbi non quam nec');
INSERT INTO Groups (name)
VALUES ('aliquet ultrices erat tortor sollicitudin');
INSERT INTO Groups (name)
VALUES ('risus auctor sed');
INSERT INTO Groups (name)
VALUES ('sed sagittis nam congue risus');
INSERT INTO Groups (name)
VALUES ('mattis odio');
INSERT INTO Groups (name)
VALUES ('orci luctus et ultrices posuere');
INSERT INTO Groups (name)
VALUES ('risus auctor sed');
INSERT INTO Groups (name)
VALUES ('ligula pellentesque ultrices phasellus id');
INSERT INTO Groups (name)
VALUES ('primis in faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('in hac');
INSERT INTO Groups (name)
VALUES ('scelerisque quam');
INSERT INTO Groups (name)
VALUES ('fusce congue');
INSERT INTO Groups (name)
VALUES ('libero convallis eget');
INSERT INTO Groups (name)
VALUES ('magna vulputate luctus');
INSERT INTO Groups (name)
VALUES ('cursus urna ut tellus');
INSERT INTO Groups (name)
VALUES ('habitasse platea');
INSERT INTO Groups (name)
VALUES ('mus vivamus vestibulum sagittis');
INSERT INTO Groups (name)
VALUES ('donec pharetra');
INSERT INTO Groups (name)
VALUES ('orci mauris lacinia');
INSERT INTO Groups (name)
VALUES ('nibh ligula');
INSERT INTO Groups (name)
VALUES ('vitae mattis');
INSERT INTO Groups (name)
VALUES ('condimentum id luctus nec molestie');
INSERT INTO Groups (name)
VALUES ('sagittis nam congue');
INSERT INTO Groups (name)
VALUES ('venenatis lacinia aenean');
INSERT INTO Groups (name)
VALUES ('consequat metus sapien ut');
INSERT INTO Groups (name)
VALUES ('vitae quam suspendisse');
INSERT INTO Groups (name)
VALUES ('erat eros viverra');
INSERT INTO Groups (name)
VALUES ('pulvinar sed nisl nunc rhoncus');
INSERT INTO Groups (name)
VALUES ('justo sit');
INSERT INTO Groups (name)
VALUES ('nisi at nibh in hac');
INSERT INTO Groups (name)
VALUES ('libero non mattis pulvinar');
INSERT INTO Groups (name)
VALUES ('viverra eget congue');
INSERT INTO Groups (name)
VALUES ('nam nulla');
INSERT INTO Groups (name)
VALUES ('tortor eu');
INSERT INTO Groups (name)
VALUES ('nulla integer');
INSERT INTO Groups (name)
VALUES ('justo in hac habitasse platea');
INSERT INTO Groups (name)
VALUES ('suspendisse potenti nullam porttitor lacus');
INSERT INTO Groups (name)
VALUES ('nunc rhoncus');
INSERT INTO Groups (name)
VALUES ('non quam nec dui luctus');
INSERT INTO Groups (name)
VALUES ('amet eros');
INSERT INTO Groups (name)
VALUES ('vitae consectetuer eget rutrum');
INSERT INTO Groups (name)
VALUES ('nulla tempus');
INSERT INTO Groups (name)
VALUES ('mattis egestas');
INSERT INTO Groups (name)
VALUES ('elementum in hac habitasse');
INSERT INTO Groups (name)
VALUES ('sed vestibulum sit amet');
INSERT INTO Groups (name)
VALUES ('odio justo sollicitudin ut suscipit');
INSERT INTO Groups (name)
VALUES ('maecenas tristique est');
INSERT INTO Groups (name)
VALUES ('in sagittis dui vel');
INSERT INTO Groups (name)
VALUES ('pede libero quis');
INSERT INTO Groups (name)
VALUES ('sem fusce consequat nulla');
INSERT INTO Groups (name)
VALUES ('vivamus metus arcu');
INSERT INTO Groups (name)
VALUES ('ac diam cras');
INSERT INTO Groups (name)
VALUES ('etiam pretium');
INSERT INTO Groups (name)
VALUES ('nam tristique');
INSERT INTO Groups (name)
VALUES ('aenean auctor gravida sem');
INSERT INTO Groups (name)
VALUES ('in hac');
INSERT INTO Groups (name)
VALUES ('amet erat');
INSERT INTO Groups (name)
VALUES ('elit sodales');
INSERT INTO Groups (name)
VALUES ('ante ipsum primis in faucibus');
INSERT INTO Groups (name)
VALUES ('sit amet lobortis');
INSERT INTO Groups (name)
VALUES ('enim lorem ipsum');
INSERT INTO Groups (name)
VALUES ('vivamus vel nulla');
INSERT INTO Groups (name)
VALUES ('ultrices erat tortor');
INSERT INTO Groups (name)
VALUES ('at nunc commodo');
INSERT INTO Groups (name)
VALUES ('mauris vulputate elementum');
INSERT INTO Groups (name)
VALUES ('quam sapien varius ut blandit');
INSERT INTO Groups (name)
VALUES ('dui maecenas tristique');
INSERT INTO Groups (name)
VALUES ('est congue');
INSERT INTO Groups (name)
VALUES ('id luctus nec');
INSERT INTO Groups (name)
VALUES ('orci eget orci vehicula');
INSERT INTO Groups (name)
VALUES ('quam sollicitudin vitae consectetuer eget');
INSERT INTO Groups (name)
VALUES ('cursus id turpis integer');
INSERT INTO Groups (name)
VALUES ('magna ac consequat metus sapien');
INSERT INTO Groups (name)
VALUES ('nullam orci pede');
INSERT INTO Groups (name)
VALUES ('nulla facilisi cras non velit');
INSERT INTO Groups (name)
VALUES ('consequat nulla');
INSERT INTO Groups (name)
VALUES ('nulla mollis molestie lorem');
INSERT INTO Groups (name)
VALUES ('justo sit amet sapien dignissim');
INSERT INTO Groups (name)
VALUES ('sapien arcu sed augue aliquam');
INSERT INTO Groups (name)
VALUES ('feugiat et eros vestibulum ac');
INSERT INTO Groups (name)
VALUES ('turpis a pede posuere nonummy');
INSERT INTO Groups (name)
VALUES ('est et');
INSERT INTO Groups (name)
VALUES ('suspendisse potenti in eleifend quam');
INSERT INTO Groups (name)
VALUES ('ipsum aliquam non');
INSERT INTO Groups (name)
VALUES ('nisi volutpat eleifend donec ut');
INSERT INTO Groups (name)
VALUES ('cubilia curae duis');
INSERT INTO Groups (name)
VALUES ('quisque id');
INSERT INTO Groups (name)
VALUES ('venenatis tristique fusce congue diam');
INSERT INTO Groups (name)
VALUES ('vestibulum sagittis');
INSERT INTO Groups (name)
VALUES ('est risus');
INSERT INTO Groups (name)
VALUES ('a odio in hac');
INSERT INTO Groups (name)
VALUES ('ipsum dolor sit');
INSERT INTO Groups (name)
VALUES ('nunc nisl duis');
INSERT INTO Groups (name)
VALUES ('nunc rhoncus dui');
INSERT INTO Groups (name)
VALUES ('in hac');
INSERT INTO Groups (name)
VALUES ('adipiscing elit');
INSERT INTO Groups (name)
VALUES ('turpis nec');
INSERT INTO Groups (name)
VALUES ('curabitur convallis duis consequat');
INSERT INTO Groups (name)
VALUES ('mattis nibh ligula nec sem');
INSERT INTO Groups (name)
VALUES ('tincidunt lacus');
INSERT INTO Groups (name)
VALUES ('sollicitudin ut suscipit a feugiat');
INSERT INTO Groups (name)
VALUES ('in ante vestibulum ante');
INSERT INTO Groups (name)
VALUES ('tristique est et tempus semper');
INSERT INTO Groups (name)
VALUES ('praesent blandit lacinia erat');
INSERT INTO Groups (name)
VALUES ('aliquet at feugiat non pretium');
INSERT INTO Groups (name)
VALUES ('orci vehicula condimentum curabitur in');
INSERT INTO Groups (name)
VALUES ('sed tristique');
INSERT INTO Groups (name)
VALUES ('suscipit nulla');
INSERT INTO Groups (name)
VALUES ('nam tristique');
INSERT INTO Groups (name)
VALUES ('faucibus cursus urna');
INSERT INTO Groups (name)
VALUES ('non pretium');
INSERT INTO Groups (name)
VALUES ('etiam justo etiam pretium');
INSERT INTO Groups (name)
VALUES ('at lorem integer tincidunt');
INSERT INTO Groups (name)
VALUES ('non velit nec');
INSERT INTO Groups (name)
VALUES ('luctus ultricies');
INSERT INTO Groups (name)
VALUES ('orci nullam');
INSERT INTO Groups (name)
VALUES ('arcu adipiscing molestie hendrerit');
INSERT INTO Groups (name)
VALUES ('nullam varius nulla');
INSERT INTO Groups (name)
VALUES ('nunc commodo placerat');
INSERT INTO Groups (name)
VALUES ('lobortis est');
INSERT INTO Groups (name)
VALUES ('augue vestibulum rutrum');
INSERT INTO Groups (name)
VALUES ('quis turpis eget');
INSERT INTO Groups (name)
VALUES ('natoque penatibus et magnis dis');
INSERT INTO Groups (name)
VALUES ('posuere cubilia curae duis');
INSERT INTO Groups (name)
VALUES ('in faucibus orci luctus');
INSERT INTO Groups (name)
VALUES ('nam tristique');
INSERT INTO Groups (name)
VALUES ('pede morbi porttitor lorem');
INSERT INTO Groups (name)
VALUES ('curae mauris viverra diam vitae');
INSERT INTO Groups (name)
VALUES ('vestibulum ante ipsum primis in');
INSERT INTO Groups (name)
VALUES ('nisl duis ac');
INSERT INTO Groups (name)
VALUES ('imperdiet nullam');
INSERT INTO Groups (name)
VALUES ('nulla facilisi cras');
INSERT INTO Groups (name)
VALUES ('tempor turpis nec euismod');
INSERT INTO Groups (name)
VALUES ('eget semper rutrum nulla nunc');
INSERT INTO Groups (name)
VALUES ('eros viverra eget congue eget');
INSERT INTO Groups (name)
VALUES ('nonummy maecenas tincidunt lacus');
INSERT INTO Groups (name)
VALUES ('curabitur convallis duis');
INSERT INTO Groups (name)
VALUES ('vestibulum ante ipsum');
INSERT INTO Groups (name)
VALUES ('eu magna vulputate luctus');
INSERT INTO Groups (name)
VALUES ('morbi porttitor');
INSERT INTO Groups (name)
VALUES ('odio porttitor id consequat in');
INSERT INTO Groups (name)
VALUES ('at diam');
INSERT INTO Groups (name)
VALUES ('non velit donec');
INSERT INTO Groups (name)
VALUES ('turpis eget elit sodales scelerisque');
INSERT INTO Groups (name)
VALUES ('turpis adipiscing lorem vitae mattis');
INSERT INTO Groups (name)
VALUES ('at diam nam tristique tortor');
INSERT INTO Groups (name)
VALUES ('quis augue');
INSERT INTO Groups (name)
VALUES ('elit ac nulla sed vel');
INSERT INTO Groups (name)
VALUES ('nulla sed accumsan felis ut');
INSERT INTO Groups (name)
VALUES ('sapien ut nunc vestibulum');
INSERT INTO Groups (name)
VALUES ('at dolor quis');
INSERT INTO Groups (name)
VALUES ('sed tincidunt eu felis');
INSERT INTO Groups (name)
VALUES ('etiam faucibus cursus');
INSERT INTO Groups (name)
VALUES ('nibh in quis justo maecenas');
INSERT INTO Groups (name)
VALUES ('eros viverra eget congue');
INSERT INTO Groups (name)
VALUES ('nunc vestibulum ante ipsum primis');
INSERT INTO Groups (name)
VALUES ('vestibulum proin eu mi');
INSERT INTO Groups (name)
VALUES ('at turpis a pede posuere');
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
VALUES ('elit proin interdum');
INSERT INTO Groups (name)
VALUES ('tincidunt nulla');
INSERT INTO Groups (name)
VALUES ('adipiscing elit');
INSERT INTO Groups (name)
VALUES ('pede justo lacinia eget tincidunt');
INSERT INTO Groups (name)
VALUES ('dapibus duis at velit');
INSERT INTO Groups (name)
VALUES ('a feugiat et eros vestibulum');
INSERT INTO Groups (name)
VALUES ('odio consequat varius');
INSERT INTO Groups (name)
VALUES ('vel lectus');
INSERT INTO Groups (name)
VALUES ('nulla elit');
INSERT INTO Groups (name)
VALUES ('in consequat ut nulla sed');
INSERT INTO Groups (name)
VALUES ('erat tortor sollicitudin mi sit');
INSERT INTO Groups (name)
VALUES ('sit amet eleifend pede');
INSERT INTO Groups (name)
VALUES ('donec ut mauris eget massa');
INSERT INTO Groups (name)
VALUES ('amet lobortis sapien');
INSERT INTO Groups (name)
VALUES ('in faucibus orci luctus et');
INSERT INTO Groups (name)
VALUES ('metus sapien ut nunc vestibulum');
INSERT INTO Groups (name)
VALUES ('odio porttitor id');
INSERT INTO Groups (name)
VALUES ('cras non');
INSERT INTO Groups (name)
VALUES ('penatibus et magnis');
INSERT INTO Groups (name)
VALUES ('nec dui luctus');
INSERT INTO Groups (name)
VALUES ('eget elit sodales');
INSERT INTO Groups (name)
VALUES ('sapien cum');
INSERT INTO Groups (name)
VALUES ('quis turpis eget elit');
INSERT INTO Groups (name)
VALUES ('nunc rhoncus dui vel');
INSERT INTO Groups (name)
VALUES ('sit amet eros');
INSERT INTO Groups (name)
VALUES ('fusce consequat nulla nisl nunc');
INSERT INTO Groups (name)
VALUES ('ac enim');
INSERT INTO Groups (name)
VALUES ('nam nulla integer');
INSERT INTO Groups (name)
VALUES ('eget massa tempor convallis');
INSERT INTO Groups (name)
VALUES ('rutrum nulla tellus in sagittis');
INSERT INTO Groups (name)
VALUES ('fermentum justo nec condimentum');
INSERT INTO Groups (name)
VALUES ('ultrices vel augue');
INSERT INTO Groups (name)
VALUES ('vivamus metus arcu');
INSERT INTO Groups (name)
VALUES ('aliquam lacus morbi quis');
INSERT INTO Groups (name)
VALUES ('lacinia sapien quis');
INSERT INTO Groups (name)
VALUES ('in magna bibendum');
INSERT INTO Groups (name)
VALUES ('natoque penatibus et');
INSERT INTO Groups (name)
VALUES ('quisque porta');
INSERT INTO Groups (name)
VALUES ('nam dui proin');
INSERT INTO Groups (name)
VALUES ('vestibulum rutrum rutrum neque aenean');
INSERT INTO Groups (name)
VALUES ('nunc commodo');
INSERT INTO Groups (name)
VALUES ('nisl venenatis lacinia');
INSERT INTO Groups (name)
VALUES ('rhoncus sed vestibulum');
INSERT INTO Groups (name)
VALUES ('sapien iaculis congue vivamus');
INSERT INTO Groups (name)
VALUES ('mus vivamus vestibulum');
INSERT INTO Groups (name)
VALUES ('donec ut dolor');
INSERT INTO Groups (name)
VALUES ('vivamus vestibulum sagittis');
INSERT INTO Groups (name)
VALUES ('est donec odio justo sollicitudin');
INSERT INTO Groups (name)
VALUES ('vestibulum ante ipsum');
INSERT INTO Groups (name)
VALUES ('diam vitae quam');
INSERT INTO Groups (name)
VALUES ('posuere cubilia');
INSERT INTO Groups (name)
VALUES ('mattis odio donec vitae nisi');
INSERT INTO Groups (name)
VALUES ('eget orci vehicula condimentum curabitur');
INSERT INTO Groups (name)
VALUES ('amet diam in magna bibendum');
INSERT INTO Groups (name)
VALUES ('leo odio');
INSERT INTO Groups (name)
VALUES ('amet eleifend pede libero quis');
INSERT INTO Groups (name)
VALUES ('nullam orci');
INSERT INTO Groups (name)
VALUES ('non ligula pellentesque ultrices');
INSERT INTO Groups (name)
VALUES ('posuere felis sed lacus morbi');
INSERT INTO Groups (name)
VALUES ('sit amet turpis elementum ligula');
INSERT INTO Groups (name)
VALUES ('fermentum justo nec condimentum neque');
INSERT INTO Groups (name)
VALUES ('amet nunc viverra dapibus');
INSERT INTO Groups (name)
VALUES ('et ultrices posuere cubilia');
INSERT INTO Groups (name)
VALUES ('nisi venenatis tristique fusce congue');
INSERT INTO Groups (name)
VALUES ('sodales sed tincidunt');
INSERT INTO Groups (name)
VALUES ('ut nulla sed accumsan felis');
INSERT INTO Groups (name)
VALUES ('libero non');
INSERT INTO Groups (name)
VALUES ('volutpat in congue etiam justo');
INSERT INTO Groups (name)
VALUES ('congue diam id');
INSERT INTO Groups (name)
VALUES ('ligula in lacus curabitur at');
INSERT INTO Groups (name)
VALUES ('hac habitasse platea dictumst');
INSERT INTO Groups (name)
VALUES ('amet cursus id');
INSERT INTO Groups (name)
VALUES ('nisl ut volutpat sapien');
INSERT INTO Groups (name)
VALUES ('nibh quisque id justo sit');
INSERT INTO Groups (name)
VALUES ('tristique est et tempus');
INSERT INTO Groups (name)
VALUES ('mauris viverra diam vitae quam');
INSERT INTO Groups (name)
VALUES ('sapien dignissim vestibulum vestibulum ante');
INSERT INTO Groups (name)
VALUES ('platea dictumst maecenas ut');
INSERT INTO Groups (name)
VALUES ('blandit lacinia');
INSERT INTO Groups (name)
VALUES ('praesent blandit nam nulla integer');
INSERT INTO Groups (name)
VALUES ('sit amet eros suspendisse');
INSERT INTO Groups (name)
VALUES ('nec nisi volutpat eleifend');
INSERT INTO Groups (name)
VALUES ('tempus semper');
INSERT INTO Groups (name)
VALUES ('platea dictumst aliquam augue');
INSERT INTO Groups (name)
VALUES ('in tempor turpis nec');
INSERT INTO Groups (name)
VALUES ('nibh in quis');
INSERT INTO Groups (name)
VALUES ('rhoncus mauris enim leo');
INSERT INTO Groups (name)
VALUES ('vestibulum aliquet');
INSERT INTO Groups (name)
VALUES ('parturient montes nascetur ridiculus mus');
INSERT INTO Groups (name)
VALUES ('felis sed interdum venenatis turpis');
INSERT INTO Groups (name)
VALUES ('a libero nam dui proin');
INSERT INTO Groups (name)
VALUES ('ligula suspendisse');
INSERT INTO Groups (name)
VALUES ('etiam pretium iaculis justo in');
INSERT INTO Groups (name)
VALUES ('et magnis dis parturient');
INSERT INTO Groups (name)
VALUES ('in eleifend quam a odio');
INSERT INTO Groups (name)
VALUES ('augue vel accumsan tellus');
INSERT INTO Groups (name)
VALUES ('eu magna vulputate');
INSERT INTO Groups (name)
VALUES ('justo sollicitudin');
INSERT INTO Groups (name)
VALUES ('donec semper');
INSERT INTO Groups (name)
VALUES ('nunc proin at turpis a');
INSERT INTO Groups (name)
VALUES ('in leo maecenas pulvinar');
INSERT INTO Groups (name)
VALUES ('pellentesque viverra pede');
INSERT INTO Groups (name)
VALUES ('faucibus cursus urna');
INSERT INTO Groups (name)
VALUES ('diam in magna bibendum imperdiet');
INSERT INTO Groups (name)
VALUES ('imperdiet sapien urna pretium');
INSERT INTO Groups (name)
VALUES ('rutrum neque aenean auctor');
INSERT INTO Groups (name)
VALUES ('ullamcorper augue a suscipit nulla');
INSERT INTO Groups (name)
VALUES ('tortor sollicitudin mi');
INSERT INTO Groups (name)
VALUES ('sapien iaculis congue');
INSERT INTO Groups (name)
VALUES ('diam nam tristique tortor eu');
INSERT INTO Groups (name)
VALUES ('morbi a');
INSERT INTO Groups (name)
VALUES ('lorem vitae mattis nibh');
INSERT INTO Groups (name)
VALUES ('neque libero');
INSERT INTO Groups (name)
VALUES ('mauris lacinia sapien quis libero');
INSERT INTO Groups (name)
VALUES ('sed tincidunt eu felis');
INSERT INTO Groups (name)
VALUES ('congue risus semper porta');
INSERT INTO Groups (name)
VALUES ('sed tincidunt eu felis fusce');
INSERT INTO Groups (name)
VALUES ('est congue');
INSERT INTO Groups (name)
VALUES ('cras pellentesque volutpat dui maecenas');
INSERT INTO Groups (name)
VALUES ('quam sollicitudin vitae');
INSERT INTO Groups (name)
VALUES ('morbi porttitor lorem');
INSERT INTO Groups (name)
VALUES ('proin leo odio porttitor id');
INSERT INTO Groups (name)
VALUES ('odio in hac habitasse platea');
INSERT INTO Groups (name)
VALUES ('platea dictumst aliquam augue');
INSERT INTO Groups (name)
VALUES ('habitasse platea dictumst aliquam augue');
INSERT INTO Groups (name)
VALUES ('odio elementum eu interdum');
INSERT INTO Groups (name)
VALUES ('non velit');
INSERT INTO Groups (name)
VALUES ('accumsan tellus nisi');
INSERT INTO Groups (name)
VALUES ('vestibulum ante ipsum primis');
INSERT INTO Groups (name)
VALUES ('metus vitae');
INSERT INTO Groups (name)
VALUES ('in felis eu sapien');
INSERT INTO Groups (name)
VALUES ('quam a odio in');
INSERT INTO Groups (name)
VALUES ('sodales scelerisque mauris');
INSERT INTO Groups (name)
VALUES ('morbi vestibulum velit');
INSERT INTO Groups (name)
VALUES ('tempus sit amet sem fusce');
INSERT INTO Groups (name)
VALUES ('potenti nullam');
INSERT INTO Groups (name)
VALUES ('sem praesent id');
INSERT INTO Groups (name)
VALUES ('ultrices erat tortor sollicitudin');
INSERT INTO Groups (name)
VALUES ('diam nam');
INSERT INTO Groups (name)
VALUES ('cursus id');
INSERT INTO Groups (name)
VALUES ('nam dui');
INSERT INTO Groups (name)
VALUES ('ante ipsum');
INSERT INTO Groups (name)
VALUES ('quisque ut erat');
INSERT INTO Groups (name)
VALUES ('molestie sed');
INSERT INTO Groups (name)
VALUES ('enim blandit mi');
INSERT INTO Groups (name)
VALUES ('turpis adipiscing lorem');
INSERT INTO Groups (name)
VALUES ('ornare imperdiet sapien urna pretium');
INSERT INTO Groups (name)
VALUES ('nam nulla');
INSERT INTO Groups (name)
VALUES ('rhoncus aliquam lacus morbi quis');
INSERT INTO Groups (name)
VALUES ('non velit donec diam');
INSERT INTO Groups (name)
VALUES ('sapien non mi integer ac');
INSERT INTO Groups (name)
VALUES ('sapien iaculis');
INSERT INTO Groups (name)
VALUES ('lectus suspendisse potenti');
INSERT INTO Groups (name)
VALUES ('morbi porttitor lorem id ligula');
INSERT INTO Groups (name)
VALUES ('eu interdum eu tincidunt in');
INSERT INTO Groups (name)
VALUES ('porttitor pede justo eu');
INSERT INTO Groups (name)
VALUES ('praesent blandit');
INSERT INTO Groups (name)
VALUES ('diam id ornare');
INSERT INTO Groups (name)
VALUES ('ut odio cras mi pede');
INSERT INTO Groups (name)
VALUES ('nulla nunc purus');
INSERT INTO Groups (name)
VALUES ('eget semper rutrum nulla');
INSERT INTO Groups (name)
VALUES ('rhoncus mauris');
INSERT INTO Groups (name)
VALUES ('velit id');
INSERT INTO Groups (name)
VALUES ('sed accumsan felis ut at');
INSERT INTO Groups (name)
VALUES ('augue vestibulum rutrum rutrum neque');
INSERT INTO Groups (name)
VALUES ('lobortis est');
INSERT INTO Groups (name)
VALUES ('congue diam id ornare');
INSERT INTO Groups (name)
VALUES ('neque libero convallis eget');
INSERT INTO Groups (name)
VALUES ('diam vitae');
INSERT INTO Groups (name)
VALUES ('aenean auctor gravida');
INSERT INTO Groups (name)
VALUES ('aliquam lacus morbi quis tortor');
INSERT INTO Groups (name)
VALUES ('feugiat non pretium quis lectus');
INSERT INTO Groups (name)
VALUES ('justo eu massa');
INSERT INTO Groups (name)
VALUES ('curae duis faucibus');
INSERT INTO Groups (name)
VALUES ('vestibulum quam sapien varius');
INSERT INTO Groups (name)
VALUES ('vivamus vel nulla eget');
INSERT INTO Groups (name)
VALUES ('pede justo eu massa');
INSERT INTO Groups (name)
VALUES ('donec diam neque vestibulum');
INSERT INTO Groups (name)
VALUES ('ut massa');
INSERT INTO Groups (name)
VALUES ('consequat morbi a ipsum');
INSERT INTO Groups (name)
VALUES ('interdum venenatis turpis enim');
INSERT INTO Groups (name)
VALUES ('curabitur at ipsum');
INSERT INTO Groups (name)
VALUES ('nulla justo aliquam');
INSERT INTO Groups (name)
VALUES ('platea dictumst morbi vestibulum velit');
INSERT INTO Groups (name)
VALUES ('morbi porttitor lorem id');
INSERT INTO Groups (name)
VALUES ('lorem id');
INSERT INTO Groups (name)
VALUES ('ut suscipit a feugiat');
INSERT INTO Groups (name)
VALUES ('in magna bibendum imperdiet');
INSERT INTO Groups (name)
VALUES ('turpis integer aliquet massa');
INSERT INTO Groups (name)
VALUES ('adipiscing elit proin risus praesent');
INSERT INTO Groups (name)
VALUES ('pellentesque at nulla suspendisse potenti');
INSERT INTO Groups (name)
VALUES ('volutpat sapien arcu');
INSERT INTO Groups (name)
VALUES ('sapien a');
INSERT INTO Groups (name)
VALUES ('nullam molestie nibh in lectus');
INSERT INTO Groups (name)
VALUES ('curabitur in');
INSERT INTO Groups (name)
VALUES ('ipsum aliquam');
INSERT INTO Groups (name)
VALUES ('mauris vulputate elementum nullam');
INSERT INTO Groups (name)
VALUES ('cubilia curae');
INSERT INTO Groups (name)
VALUES ('a ipsum integer');
INSERT INTO Groups (name)
VALUES ('nec condimentum');
INSERT INTO Groups (name)
VALUES ('integer ac');
INSERT INTO Groups (name)
VALUES ('tincidunt ante vel ipsum');
INSERT INTO Groups (name)
VALUES ('etiam justo etiam');
INSERT INTO Groups (name)
VALUES ('sit amet nunc');
INSERT INTO Groups (name)
VALUES ('primis in faucibus orci');
INSERT INTO Groups (name)
VALUES ('est risus auctor');
INSERT INTO Groups (name)
VALUES ('molestie nibh');
INSERT INTO Groups (name)
VALUES ('ac diam');
INSERT INTO Groups (name)
VALUES ('turpis sed ante vivamus tortor');
INSERT INTO Groups (name)
VALUES ('odio justo sollicitudin');
INSERT INTO Groups (name)
VALUES ('ante nulla justo aliquam quis');
INSERT INTO Groups (name)
VALUES ('arcu sed augue');
INSERT INTO Groups (name)
VALUES ('sed vestibulum sit');
INSERT INTO Groups (name)
VALUES ('ut massa quis');
INSERT INTO Groups (name)
VALUES ('platea dictumst morbi vestibulum');
INSERT INTO Groups (name)
VALUES ('cursus vestibulum');
INSERT INTO Groups (name)
VALUES ('velit donec diam');
INSERT INTO Groups (name)
VALUES ('nulla eget eros elementum pellentesque');
INSERT INTO Groups (name)
VALUES ('tortor duis mattis');
INSERT INTO Groups (name)
VALUES ('urna pretium nisl ut volutpat');
INSERT INTO Groups (name)
VALUES ('justo etiam pretium');
INSERT INTO Groups (name)
VALUES ('ligula suspendisse ornare');
INSERT INTO Groups (name)
VALUES ('vel dapibus at');
INSERT INTO Groups (name)
VALUES ('eget vulputate ut ultrices');
INSERT INTO Groups (name)
VALUES ('semper sapien a libero');
INSERT INTO Groups (name)
VALUES ('viverra dapibus nulla suscipit');
INSERT INTO Groups (name)
VALUES ('vitae nisi nam ultrices libero');
INSERT INTO Groups (name)
VALUES ('nibh ligula nec sem duis');
INSERT INTO Groups (name)
VALUES ('hac habitasse platea dictumst');
INSERT INTO Groups (name)
VALUES ('purus eu magna');
INSERT INTO Groups (name)
VALUES ('venenatis tristique');
INSERT INTO Groups (name)
VALUES ('turpis adipiscing lorem vitae mattis');
INSERT INTO Groups (name)
VALUES ('nisl nunc');
INSERT INTO Groups (name)
VALUES ('mi nulla ac');
INSERT INTO Groups (name)
VALUES ('ultrices vel augue');
INSERT INTO Groups (name)
VALUES ('volutpat erat');
INSERT INTO Groups (name)
VALUES ('diam erat fermentum justo nec');
INSERT INTO Groups (name)
VALUES ('cubilia curae');
INSERT INTO Groups (name)
VALUES ('ultrices posuere');
INSERT INTO Groups (name)
VALUES ('accumsan felis ut at');
INSERT INTO Groups (name)
VALUES ('erat id');
INSERT INTO Groups (name)
VALUES ('dictumst maecenas ut massa quis');
INSERT INTO Groups (name)
VALUES ('iaculis congue');
INSERT INTO Groups (name)
VALUES ('condimentum id luctus nec molestie');
INSERT INTO Groups (name)
VALUES ('ante ipsum primis in');
INSERT INTO Groups (name)
VALUES ('est risus auctor');
INSERT INTO Groups (name)
VALUES ('ultrices posuere cubilia curae donec');
INSERT INTO Groups (name)
VALUES ('vivamus tortor');
INSERT INTO Groups (name)
VALUES ('elementum nullam');
INSERT INTO Groups (name)
VALUES ('ornare consequat lectus in');
INSERT INTO Groups (name)
VALUES ('sed sagittis');
INSERT INTO Groups (name)
VALUES ('nec molestie sed justo');
INSERT INTO Groups (name)
VALUES ('pharetra magna vestibulum aliquet ultrices');
INSERT INTO Groups (name)
VALUES ('erat quisque');
INSERT INTO Groups (name)
VALUES ('ut dolor');
INSERT INTO Groups (name)
VALUES ('aliquam augue quam');
INSERT INTO Groups (name)
VALUES ('sit amet turpis elementum');
INSERT INTO Groups (name)
VALUES ('diam cras pellentesque');
INSERT INTO Groups (name)
VALUES ('molestie hendrerit at vulputate');
INSERT INTO Groups (name)
VALUES ('porttitor pede justo eu massa');
INSERT INTO Groups (name)
VALUES ('dui nec nisi volutpat eleifend');
INSERT INTO Groups (name)
VALUES ('quis orci');
INSERT INTO Groups (name)
VALUES ('suspendisse potenti in eleifend quam');
INSERT INTO Groups (name)
VALUES ('ultrices posuere cubilia curae');
INSERT INTO Groups (name)
VALUES ('lobortis vel');
INSERT INTO Groups (name)
VALUES ('donec ut');
INSERT INTO Groups (name)
VALUES ('justo pellentesque');
INSERT INTO Groups (name)
VALUES ('eleifend quam');
INSERT INTO Groups (name)
VALUES ('metus arcu adipiscing');
INSERT INTO Groups (name)
VALUES ('cursus id turpis');
INSERT INTO Groups (name)
VALUES ('sit amet eros suspendisse');
INSERT INTO Groups (name)
VALUES ('turpis sed ante vivamus tortor');
INSERT INTO Groups (name)
VALUES ('pretium nisl ut volutpat sapien');
INSERT INTO Groups (name)
VALUES ('pharetra magna');
INSERT INTO Groups (name)
VALUES ('vulputate vitae nisl');
INSERT INTO Groups (name)
VALUES ('sociis natoque penatibus et');
INSERT INTO Groups (name)
VALUES ('sed tristique in tempus');
INSERT INTO Groups (name)
VALUES ('condimentum curabitur in');
INSERT INTO Groups (name)
VALUES ('ac tellus semper interdum mauris');
INSERT INTO Groups (name)
VALUES ('elit ac nulla sed');
INSERT INTO Groups (name)
VALUES ('rutrum rutrum');
INSERT INTO Groups (name)
VALUES ('nulla ultrices aliquet');
INSERT INTO Groups (name)
VALUES ('et tempus semper');
INSERT INTO Groups (name)
VALUES ('sem sed sagittis');
INSERT INTO Groups (name)
VALUES ('consequat nulla');
INSERT INTO Groups (name)
VALUES ('gravida sem praesent');
INSERT INTO Groups (name)
VALUES ('blandit lacinia erat');
INSERT INTO Groups (name)
VALUES ('potenti nullam porttitor lacus at');
INSERT INTO Groups (name)
VALUES ('at ipsum ac');
INSERT INTO Groups (name)
VALUES ('non mi integer ac');
INSERT INTO Groups (name)
VALUES ('tincidunt in');
INSERT INTO Groups (name)
VALUES ('suspendisse ornare');
INSERT INTO Groups (name)
VALUES ('quisque ut erat');
INSERT INTO Groups (name)
VALUES ('amet justo morbi ut');
INSERT INTO Groups (name)
VALUES ('luctus cum sociis natoque');
INSERT INTO Groups (name)
VALUES ('pretium iaculis diam');
INSERT INTO Groups (name)
VALUES ('at lorem');
INSERT INTO Groups (name)
VALUES ('ultrices posuere cubilia curae');
INSERT INTO Groups (name)
VALUES ('magna at nunc commodo placerat');
INSERT INTO Groups (name)
VALUES ('eros viverra eget congue eget');
INSERT INTO Groups (name)
VALUES ('pellentesque eget nunc donec quis');
INSERT INTO Groups (name)
VALUES ('vivamus vel nulla eget eros');
INSERT INTO Groups (name)
VALUES ('consequat ut nulla');
INSERT INTO Groups (name)
VALUES ('tempor turpis');
INSERT INTO Groups (name)
VALUES ('at velit');
INSERT INTO Groups (name)
VALUES ('rutrum nulla');
INSERT INTO Groups (name)
VALUES ('justo lacinia eget tincidunt');
INSERT INTO Groups (name)
VALUES ('pharetra magna');
INSERT INTO Groups (name)
VALUES ('suspendisse potenti cras in');
INSERT INTO Groups (name)
VALUES ('lorem vitae mattis nibh');
INSERT INTO Groups (name)
VALUES ('lorem ipsum dolor sit');
INSERT INTO Groups (name)
VALUES ('laoreet ut rhoncus');
INSERT INTO Groups (name)
VALUES ('libero nullam sit amet turpis');
INSERT INTO Groups (name)
VALUES ('commodo placerat praesent blandit nam');
INSERT INTO Groups (name)
VALUES ('pulvinar sed nisl nunc');
INSERT INTO Groups (name)
VALUES ('ridiculus mus');
INSERT INTO Groups (name)
VALUES ('at turpis a');
INSERT INTO Groups (name)
VALUES ('erat id mauris');
INSERT INTO Groups (name)
VALUES ('nisi nam ultrices libero non');
INSERT INTO Groups (name)
VALUES ('tempor turpis');
INSERT INTO Groups (name)
VALUES ('nam ultrices libero');
INSERT INTO Groups (name)
VALUES ('congue diam');
INSERT INTO Groups (name)
VALUES ('curae nulla dapibus dolor');
INSERT INTO Groups (name)
VALUES ('interdum mauris ullamcorper purus sit');
INSERT INTO Groups (name)
VALUES ('faucibus orci');
INSERT INTO Groups (name)
VALUES ('mauris lacinia');
INSERT INTO Groups (name)
VALUES ('quis justo maecenas rhoncus aliquam');
INSERT INTO Groups (name)
VALUES ('id justo');
INSERT INTO Groups (name)
VALUES ('leo maecenas pulvinar lobortis');
INSERT INTO Groups (name)
VALUES ('curae nulla');
INSERT INTO Groups (name)
VALUES ('blandit ultrices');
INSERT INTO Groups (name)
VALUES ('tellus nulla');
INSERT INTO Groups (name)
VALUES ('sapien arcu');
INSERT INTO Groups (name)
VALUES ('volutpat quam');
INSERT INTO Groups (name)
VALUES ('eget rutrum at lorem');
INSERT INTO Groups (name)
VALUES ('porttitor lorem id ligula suspendisse');
INSERT INTO Groups (name)
VALUES ('integer tincidunt ante vel');
INSERT INTO Groups (name)
VALUES ('at lorem integer tincidunt ante');
INSERT INTO Groups (name)
VALUES ('lacus morbi sem mauris');
INSERT INTO Groups (name)
VALUES ('rhoncus aliquet');
INSERT INTO Groups (name)
VALUES ('aenean lectus pellentesque eget');
INSERT INTO Groups (name)
VALUES ('semper interdum');
INSERT INTO Groups (name)
VALUES ('congue vivamus metus arcu adipiscing');
INSERT INTO Groups (name)
VALUES ('nisi nam ultrices');
INSERT INTO Groups (name)
VALUES ('donec quis');
INSERT INTO Groups (name)
VALUES ('sit amet eleifend');
INSERT INTO Groups (name)
VALUES ('eget tincidunt eget tempus');
INSERT INTO Groups (name)
VALUES ('augue vestibulum');
INSERT INTO Groups (name)
VALUES ('tempor convallis');
INSERT INTO Groups (name)
VALUES ('ipsum dolor sit amet consectetuer');
INSERT INTO Groups (name)
VALUES ('posuere cubilia curae nulla');
INSERT INTO Groups (name)
VALUES ('erat quisque erat');
INSERT INTO Groups (name)
VALUES ('non mattis pulvinar nulla');
INSERT INTO Groups (name)
VALUES ('vestibulum vestibulum');
INSERT INTO Groups (name)
VALUES ('tempus vivamus in');
INSERT INTO Groups (name)
VALUES ('hac habitasse platea');
INSERT INTO Groups (name)
VALUES ('luctus rutrum');
INSERT INTO Groups (name)
VALUES ('tellus in sagittis dui');
INSERT INTO Groups (name)
VALUES ('integer pede justo lacinia eget');
INSERT INTO Groups (name)
VALUES ('sagittis dui vel nisl duis');
INSERT INTO Groups (name)
VALUES ('non interdum in ante vestibulum');
INSERT INTO Groups (name)
VALUES ('imperdiet nullam orci pede venenatis');
INSERT INTO Groups (name)
VALUES ('vel est donec odio');
INSERT INTO Groups (name)
VALUES ('nisi eu orci mauris lacinia');
INSERT INTO Groups (name)
VALUES ('ultrices posuere cubilia');
INSERT INTO Groups (name)
VALUES ('curae donec pharetra');
INSERT INTO Groups (name)
VALUES ('duis mattis egestas metus');
INSERT INTO Groups (name)
VALUES ('ipsum primis in');
INSERT INTO Groups (name)
VALUES ('aenean auctor');
INSERT INTO Groups (name)
VALUES ('amet lobortis sapien sapien');
INSERT INTO Groups (name)
VALUES ('dolor morbi');
INSERT INTO Groups (name)
VALUES ('sapien a libero nam dui');
INSERT INTO Groups (name)
VALUES ('aenean auctor gravida sem');
INSERT INTO Groups (name)
VALUES ('auctor gravida sem praesent');
INSERT INTO Groups (name)
VALUES ('mi sit amet lobortis');
INSERT INTO Groups (name)
VALUES ('urna ut tellus nulla ut');
INSERT INTO Groups (name)
VALUES ('suspendisse ornare');
INSERT INTO Groups (name)
VALUES ('id massa id nisl');
INSERT INTO Groups (name)
VALUES ('eget eros elementum');
INSERT INTO Groups (name)
VALUES ('cursus id turpis integer aliquet');
INSERT INTO Groups (name)
VALUES ('placerat ante nulla');
INSERT INTO Groups (name)
VALUES ('amet diam in magna');
INSERT INTO Groups (name)
VALUES ('nulla eget eros');
INSERT INTO Groups (name)
VALUES ('lacinia aenean sit amet');
INSERT INTO Groups (name)
VALUES ('tellus nisi eu orci');
INSERT INTO Groups (name)
VALUES ('sit amet');
INSERT INTO Groups (name)
VALUES ('augue a suscipit nulla elit');
INSERT INTO Groups (name)
VALUES ('ligula sit amet');
INSERT INTO Groups (name)
VALUES ('felis fusce posuere felis sed');
INSERT INTO Groups (name)
VALUES ('id turpis');
INSERT INTO Groups (name)
VALUES ('a suscipit');
INSERT INTO Groups (name)
VALUES ('in faucibus');
INSERT INTO Groups (name)
VALUES ('convallis morbi odio odio elementum');
INSERT INTO Groups (name)
VALUES ('odio elementum eu interdum');

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
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1, 'Curabitur convallis.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1, 'Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO GroupMessages (groupid, message)
VALUES (1,
        'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Nulla suscipit ligula in lacus.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Suspendisse potenti. Nullam porttitor lacus at turpis.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5,
        'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Nunc purus.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5,
        'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.');
INSERT INTO GroupMessages (groupid, message)
VALUES (5, 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8, 'Morbi a ipsum.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8,
        'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.');
INSERT INTO GroupMessages (groupid, message)
VALUES (8, 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.');

-- Populate table dbo.Conversations
INSERT INTO Conversations (leftuserid, rightuserid)
VALUES (1, 2);
INSERT INTO Conversations (leftuserid, rightuserid)
VALUES (1, 3);

-- Populate table dbo.ConversationMessages
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1, 'Donec posuere metus vitae ipsum. Aliquam non mauris.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1, 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1, 'Etiam vel augue.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (2, 'Quisque porta volutpat erat.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (2,
        'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (2, 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1,
        'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.');
INSERT INTO ConversationMessages (conversationid, message)
VALUES (1, 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');

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
