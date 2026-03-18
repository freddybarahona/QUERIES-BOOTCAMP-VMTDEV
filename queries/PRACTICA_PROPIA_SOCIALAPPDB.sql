USE MASTER 
GO

CREATE DATABASE socialAppDB
GO

CREATE TABLE Usuarios (
	Id				UNIQUEIDENTIFIER	NOT NULL DEFAULT NEWID(), --NEWID() devuelve uniqueidentifier
	Username		NVARCHAR(50)		NOT NULL,
	Email			NVARCHAR(100)       NOT NULL,
	PasswordHash	NVARCHAR(255)		NOT NULL, --el hash puede tener 60 -255 caracteres usa password como nombre para la columna de contrasena es estandar
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_Usuarios 
		PRIMARY KEY (Id),
	CONSTRAINT UQ_Usuarios_Username 
		UNIQUE (Username),
	CONSTRAINT UQ_Usuarios_Email 
		UNIQUE (Email)
);
GO


CREATE TABLE Posts(
	Id				INT IDENTITY(1,1)	NOT NULL, --IDENTITY se usa para generar valores automáticos (usualmente PK) en FOREIGN es INT
	UserId			UNIQUEIDENTIFIER	NOT NULL, --UNA FOREIGN nunca cre valores por defecto hace referencia a otra tabla
	Content			NVARCHAR(300)		NOT NULL,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),
	DeletedAt		DATETIME2			NULL,

	CONSTRAINT PK_Posts 
		PRIMARY KEY (Id),
	CONSTRAINT FK_Posts_Usuarios FOREIGN KEY (UserID)
		REFERENCES Usuarios(Id) ON DELETE CASCADE
);
GO

---------------------2DA PARTE------------------------------
CREATE TABLE Likes (
	Id				INT IDENTITY(1,1)	NOT NULL,
	UserId			UNIQUEIDENTIFIER	NOT NULL,
	PostId			INT					NOT NULL,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_Likes 
		PRIMARY KEY (Id),
	
	CONSTRAINT FK_Likes_Usuarios 
		FOREIGN KEY (UserId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Likes_Posts 
		FOREIGN KEY (PostId)
		REFERENCES Posts(Id) ON DELETE CASCADE,

	CONSTRAINT UQ_UserId_PostId 
		UNIQUE (UserId, PostId)-- el unique id es como un if puede tener multiples valores a comparar textualmete if(UserId && PostId==UserId[-1] && PostId[-1]){ no lo coloques en la tabla}
);
GO

CREATE TABLE Comentarios (
	Id				INT IDENTITY(1,1)	NOT NULL,
	UserId			UNIQUEIDENTIFIER	NOT NULL,
	PostId			INT					NOT NULL,
	Texto			NVARCHAR(150)		NOT NULL,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_Comentarios 
		PRIMARY KEY (Id),
	
	CONSTRAINT FK_Comentarios_Usuarios 
		FOREIGN KEY (UserId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Comentarios_Posts 
		FOREIGN KEY (PostId)
		REFERENCES Posts(Id) ON DELETE CASCADE
);
GO

---------------------------3RA PARTE--------------------------------------

Create Table Seguidores (
	FollowerId		UNIQUEIDENTIFIER	NOT NULL,
	FollowingId		UNIQUEIDENTIFIER	NOT NULL,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_Seguidores 
		PRIMARY KEY (FollowerId, FollowingId),

	CONSTRAINT FK_Seguidores_Follower 
		FOREIGN KEY (FollowerId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Seguidores_Following 
		FOREIGN KEY (FollowingId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,

	CONSTRAINT CK_NoSeguirseAsiMismo
		CHECK (FollowingId  != FollowerId)  -- O tambien asi CONSTRAINT CK_NoSelfFollow CHECK (FollowerId <> FollowingId) 
);
GO
--elige un idioma y mantenlo ahora no lo corrijo porque seria cansado
----------------------4TA PARTE-------------------------------------------------

CREATE TABLE Mensajes (--primero relaciones luego datos
	Id				INT IDENTITY(1,1)	NOT NULL,
	RemitenteId		UNIQUEIDENTIFIER	NOT NULL,
	ReceiverId		UNIQUEIDENTIFIER	NOT NULL,
	Content			NVARCHAR(400)		NOT NULL,
	IsRead			BIT					NOT NULL DEFAULT 0,
	CreatedAt		DATETIME2			NOT NULL DEFAULT SYSUTCDATETIME(),
	DeletedAt		DATETIME2			NULL,

	CONSTRAINT PK_Mensajes 
		PRIMARY KEY (Id),
	
	CONSTRAINT FK_Mensajes_Remitente 
		FOREIGN KEY (RemitenteId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,
	CONSTRAINT FK_Mensajes_DestinyId 
		FOREIGN KEY (ReceiverId)
		REFERENCES Usuarios(Id) ON DELETE CASCADE,
	
	CONSTRAINT CK_NoMenAsiMismo	
		CHECK (ReceiverId != RemitenteId)
);
GO
