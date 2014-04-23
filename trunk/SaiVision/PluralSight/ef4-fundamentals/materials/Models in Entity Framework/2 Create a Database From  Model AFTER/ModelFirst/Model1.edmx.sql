
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 03/11/2010 00:18:42
-- Generated from EDMX file: F:\Documents\Visual Studio 2010\Projects\PSOD\ModelFirst\ModelFirst\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Conferences];
GO
IF SCHEMA_ID(N'julie') IS NULL EXECUTE(N'CREATE SCHEMA [julie]');
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
CREATE TABLE [julie].[People] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Sessions'
CREATE TABLE [julie].[Sessions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Minutes] int  NOT NULL,
    [PersonId] int  NOT NULL
);
GO

-- Creating table 'Sessions_Workshop'
CREATE TABLE [julie].[Sessions_Workshop] (
    [Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'People'
ALTER TABLE [julie].[People]
ADD CONSTRAINT [PK_People]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Sessions'
ALTER TABLE [julie].[Sessions]
ADD CONSTRAINT [PK_Sessions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Sessions_Workshop'
ALTER TABLE [julie].[Sessions_Workshop]
ADD CONSTRAINT [PK_Sessions_Workshop]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [PersonId] in table 'Sessions'
ALTER TABLE [julie].[Sessions]
ADD CONSTRAINT [FK_PersonSession]
    FOREIGN KEY ([PersonId])
    REFERENCES [julie].[People]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonSession'
CREATE INDEX [IX_FK_PersonSession]
ON [julie].[Sessions]
    ([PersonId]);
GO

-- Creating foreign key on [Id] in table 'Sessions_Workshop'
ALTER TABLE [julie].[Sessions_Workshop]
ADD CONSTRAINT [FK_Workshop_inherits_Session]
    FOREIGN KEY ([Id])
    REFERENCES [julie].[Sessions]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------