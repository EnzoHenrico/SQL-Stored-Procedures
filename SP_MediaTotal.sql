Use dbAluno
GO

-- Calculo média total e aprovação
CREATE or ALTER PROC Calculo_Media_Total
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

EXEC Calculo_Media_Total 2024,1
