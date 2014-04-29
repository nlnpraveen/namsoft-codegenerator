
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 04/29/2014 15:47:24
-- Generated from EDMX file: C:\dev\SaiVision\PluralSight\ef4-fundamentals\materials\Models in Entity Framework\2 DatabaseFromModel-Before\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [AdventureWorksSuper];
GO
IF SCHEMA_ID(N'praveen') IS NULL EXECUTE(N'CREATE SCHEMA [praveen]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'People'
CREATE TABLE [praveen].[People] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(200)  NOT NULL
);
GO

-- Creating table 'Sessions'
CREATE TABLE [praveen].[Sessions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Minutes] int  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [PersonId] int  NOT NULL
);
GO

-- Creating table 'Sessions_Workshop'
CREATE TABLE [praveen].[Sessions_Workshop] (
    [Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'People'
ALTER TABLE [praveen].[People]
ADD CONSTRAINT [PK_People]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Sessions'
ALTER TABLE [praveen].[Sessions]
ADD CONSTRAINT [PK_Sessions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Sessions_Workshop'
ALTER TABLE [praveen].[Sessions_Workshop]
ADD CONSTRAINT [PK_Sessions_Workshop]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [PersonId] in table 'Sessions'
ALTER TABLE [praveen].[Sessions]
ADD CONSTRAINT [FK_PersonSession]
    FOREIGN KEY ([PersonId])
    REFERENCES [praveen].[People]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonSession'
CREATE INDEX [IX_FK_PersonSession]
ON [praveen].[Sessions]
    ([PersonId]);
GO

-- Creating foreign key on [Id] in table 'Sessions_Workshop'
ALTER TABLE [praveen].[Sessions_Workshop]
ADD CONSTRAINT [FK_Workshop_inherits_Session]
    FOREIGN KEY ([Id])
    REFERENCES [praveen].[Sessions]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------