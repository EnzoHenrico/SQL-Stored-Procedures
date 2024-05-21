USE [master]
GO
/****** Object:  Database [dbAluno]    Script Date: 21/05/2024 16:59:19 ******/
CREATE DATABASE [dbAluno]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbAluno', FILENAME = N'/var/opt/mssql/data/dbAluno.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbAluno_log', FILENAME = N'/var/opt/mssql/data/dbAluno_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbAluno] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbAluno].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbAluno] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbAluno] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbAluno] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbAluno] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbAluno] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbAluno] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbAluno] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbAluno] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbAluno] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbAluno] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbAluno] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbAluno] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbAluno] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbAluno] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbAluno] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbAluno] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbAluno] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbAluno] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbAluno] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbAluno] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbAluno] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbAluno] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbAluno] SET RECOVERY FULL 
GO
ALTER DATABASE [dbAluno] SET  MULTI_USER 
GO
ALTER DATABASE [dbAluno] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbAluno] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbAluno] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbAluno] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbAluno] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbAluno] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbAluno', N'ON'
GO
ALTER DATABASE [dbAluno] SET QUERY_STORE = OFF
GO
USE [dbAluno]
GO
/****** Object:  Table [dbo].[ALUNO]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALUNO](
	[ID_ALUNO] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ALUNO] PRIMARY KEY CLUSTERED 
(
	[ID_ALUNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALUNODISCIPLINA]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALUNODISCIPLINA](
	[ID_ALUNO] [int] NOT NULL,
	[ID_DISCIPLINA] [int] NOT NULL,
	[NOTA1] [numeric](10, 2) NULL,
	[NOTA2] [numeric](10, 2) NULL,
	[NOTASUBSTITUTIVA] [numeric](10, 2) NULL,
	[MEDIA] [numeric](10, 2) NULL,
	[SITUACAO] [varchar](20) NULL,
	[ANO] [int] NULL,
	[SEMESTRE] [int] NULL,
 CONSTRAINT [PK_ALUNODISCIPLINA] PRIMARY KEY CLUSTERED 
(
	[ID_ALUNO] ASC,
	[ID_DISCIPLINA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DISCIPLINA]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISCIPLINA](
	[ID_DISCIPLINA] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](30) NOT NULL,
	[CARGAHORARIA] [int] NOT NULL,
 CONSTRAINT [PK_DISCIPLINA] PRIMARY KEY CLUSTERED 
(
	[ID_DISCIPLINA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ALUNODISCIPLINA]  WITH CHECK ADD  CONSTRAINT [FK_ALUNODISCIPLINA_ALUNO] FOREIGN KEY([ID_ALUNO])
REFERENCES [dbo].[ALUNO] ([ID_ALUNO])
GO
ALTER TABLE [dbo].[ALUNODISCIPLINA] CHECK CONSTRAINT [FK_ALUNODISCIPLINA_ALUNO]
GO
ALTER TABLE [dbo].[ALUNODISCIPLINA]  WITH CHECK ADD  CONSTRAINT [FK_ALUNODISCIPLINA_DISCIPLINA] FOREIGN KEY([ID_DISCIPLINA])
REFERENCES [dbo].[DISCIPLINA] ([ID_DISCIPLINA])
GO
ALTER TABLE [dbo].[ALUNODISCIPLINA] CHECK CONSTRAINT [FK_ALUNODISCIPLINA_DISCIPLINA]
GO
/****** Object:  StoredProcedure [dbo].[Calculo_Media_Parcial]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[Calculo_Media_Parcial]
	@Ano int,
	@Semestre int
AS
BEGIN
	DECLARE @id_aluno integer,
			@id_disciplina integer,
			@nota1 numeric(10, 2),
			@nota2 numeric(10, 2),
			@media numeric(10, 2)

	DECLARE Aux_Cursor CURSOR FOR
		SELECT  id_aluno, 
				id_disciplina,
				nota1,
				nota2,
				media
		FROM ALUNODISCIPLINA
		WHERE ano = @Ano and semestre = @semestre
 
	OPEN Aux_Cursor
	
	FETCH NEXT FROM Aux_Cursor
	INTO @id_aluno,
		 @id_disciplina,
		 @nota1, 
 		 @nota2, 
		 @media

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		IF (@nota1 is null) SET @nota1 = 0;
		IF (@nota2 is null) SET @nota2 = 0;

		SET @media = (@nota1 + @nota2) / 2;

		UPDATE ALUNODISCIPLINA SET 
		MEDIA = @media
		WHERE ID_ALUNO = @id_aluno AND ID_DISCIPLINA = @id_disciplina;
		
		FETCH NEXT FROM Aux_Cursor  
		INTO @id_aluno,
			 @id_disciplina,
			 @nota1, 
 			 @nota2,
			 @media
	END
 
	CLOSE Aux_Cursor
	DEALLOCATE Aux_Cursor
	select * from alunodisciplina;
END
GO
/****** Object:  StoredProcedure [dbo].[Calculo_Media_Total]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[Calculo_Media_Total]
	@Ano int,
	@Semestre int
AS
BEGIN
	DECLARE @id_aluno integer,
			@id_disciplina integer,
			@nota1 numeric(10, 2),
			@nota2 numeric(10, 2),
			@media numeric(10, 2),
			@notasubstitutiva numeric(10, 2),
			@situacao varchar(20)

	DECLARE Aux_Cursor CURSOR FOR
		SELECT  id_aluno, 
				id_disciplina,
				nota1,
				nota2,
				notasubstitutiva,
				media,
				situacao
		FROM ALUNODISCIPLINA
		WHERE ano = @Ano and semestre = @semestre
 
	OPEN Aux_Cursor
	
	FETCH NEXT FROM Aux_Cursor  
	INTO @id_aluno,
		 @id_disciplina,
		 @nota1, 
 		 @nota2, 
		 @notasubstitutiva,
		 @media,
		 @situacao

	WHILE @@FETCH_STATUS = 0 
	BEGIN
		IF (@notasubstitutiva is not null)
		BEGIN
			IF (@nota1 is null or @nota2 is null)
			BEGIN
				IF (@nota1 is null and @nota2 is null) SET @media = @notasubstitutiva / 2;
				IF (@nota1 is null and @nota2 is not null) SET @media = (@nota2 + @notasubstitutiva) / 2;
				IF (@nota2 is null and @nota1 is not null) SET @media = (@nota1 + @notasubstitutiva) / 2;
			END
			ELSE
			BEGIN
				IF (@nota1 > @nota2) SET @media = (@nota1 + @notasubstitutiva) / 2;
				IF (@nota1 <= @nota2) SET @media = (@nota2 + @notasubstitutiva) / 2;
			END

			UPDATE ALUNODISCIPLINA SET 
			MEDIA = @media,
			SITUACAO = CASE WHEN @media >= 5 THEN 'APROVADO' ELSE 'REPROVADO' END
			WHERE ID_ALUNO = @id_aluno AND ID_DISCIPLINA = @id_disciplina;
		END
		ELSE
		BEGIN
			IF (@nota1 is null or @nota2 is null)
			BEGIN
				IF (@nota1 is null and @nota2 is null) SET @media = 0;
				IF (@nota1 is null and @nota2 is not null) SET @media = (@nota2 + 0) / 2;
				IF (@nota2 is null and @nota1 is not null) SET @media = (@nota1 + 0) / 2;
			END
			ELSE SET @media = (@nota1 + @nota2) / 2;

			UPDATE ALUNODISCIPLINA SET 
			MEDIA = @media,
			SITUACAO = CASE WHEN @media >= 5 THEN 'APROVADO' ELSE 'REPROVADO' END
			WHERE ID_ALUNO = @id_aluno AND ID_DISCIPLINA = @id_disciplina;
		END

		FETCH NEXT FROM Aux_Cursor  
		INTO @id_aluno,
			 @id_disciplina,
			 @nota1, 
 			 @nota2, 
			 @notasubstitutiva,
			 @media,
			 @situacao
	END
 
	CLOSE Aux_Cursor
	DEALLOCATE Aux_Cursor
	select * from alunodisciplina;
END
GO
/****** Object:  StoredProcedure [dbo].[Matricular_Aluno]    Script Date: 21/05/2024 16:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Calculo media parcial
CREATE   PROC [dbo].[Matricular_Aluno]
	@id_aluno int,
	@id_disciplina int
AS
BEGIN
	INSERT INTO ALUNODISCIPLINA(ID_ALUNO, ID_DISCIPLINA) VALUES(@id_aluno, @id_disciplina)
END
GO
USE [master]
GO
ALTER DATABASE [dbAluno] SET  READ_WRITE 
GO
