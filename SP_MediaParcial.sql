Use dbAluno
GO

-- Calculo media parcial
CREATE or ALTER PROC Calculo_Media_Parcial
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

EXEC Calculo_Media_Parcial 2024,1