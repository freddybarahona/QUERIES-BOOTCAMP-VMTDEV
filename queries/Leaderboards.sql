--CREATE DATABASE LEADERBOARD
--GO

CREATE TABLE UsuarioTipo(
	UsuarioTipoId	INT IDENTITY(1,1)	NOT NULL,
	Descripcion		VARCHAR(15)			NOT NULL,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME()
	
	CONSTRAINT PK_UsuarioTipo PRIMARY KEY UsuarioTipoID
);
GO

CREATE TABLE ModuloTipo(
	ModuloTipoId	INT IDENTITY(1,1)	NOT NULL,
	Especificidad	VARCHAR(12)			NOT NULL,
	Tecnologia		VARCHAR(12)			NOT NULL

	CONSTRAINT PK_ModuloTipo PRIMARY KEY ModuloTipoId
);
GO

CREATE TABLE Usuario(
	UsuarioId	UNIQUEIDENTIFIER		NOT NULL DEFAULT NEWID(),
	TipoId		INT IDENTITY(1,1)		NOT NULL, --FORANEA CON USUARIOTIPO
	Nombre		NVARCHAR(50)			NOT NULL,
	Edad		INT						NOT NULL,
	Correo		NVARCHAR(50)			NOT NULL,
	NumTel		NVARCHAR(10)			,
	Cedula		NVARCHAR(12)			NOT NULL,
	CreatedAt	DATETIME2				NOT NULL DEFAULT SYSUTCDATETIME()

	CONSTRAINT PK_Usuario PRIMARY KEY UsuarioId,
	CONSTRAINT FK_Usuario_UsuarioTipo FOREIGN KEY (TipoId) --COLUMNA INTERNA
	REFERENCES UsuarioTipo(UsuarioTipoId) ON DELETE CASCADE --esta es la sintaxis en sql
	--server para las foreign key
);
GO

CREATE TABLE Modulo(
	ModuloId	INT IDENTITY(1,1)	NOT NULL,
	Nombre		VARCHAR(12)			NOT NULL,
	ProfesorId	INT IDENTITY(1,1)	NOT NULL,
	TipoId		INT IDENTITY(1,1)	NOT NULL --FORANEA CON MODULOTIPO

	CONSTRAINT PK_Modulo PRIMARY KEY ModuloId,
	CONSTRAINT FK_Modulo_ModuloTipo FOREIGN KEY (TipoId)
	REFERENCES ModuloTipo(ModuloTipoId) ON DELETE CASCADE
);
GO

CREATE TABLE Participaciones(
	ParticipacionId
	EstudianteId
	ModuloId
	Puntos
	FechaPart

	CONSTRAINT PK_ModuloTipo PRIMARY KEY ModuloTipoId
);
GO

INSERT INTO UsuarioTipos(Descripcion)
Values	('Profesor')
		('Estudiante')

INSERT INTO ModuloTipos(Especialidad, tecnologia)
Values	('Framework', 'Angular')
		('Motor base de datos', 'SQL SERVER')
		('Framework', '.NET'),
		(