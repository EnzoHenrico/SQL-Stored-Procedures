Use dbAluno
GO

-- Calculo media parcial
CREATE or ALTER PROC Matricular_Aluno
	@id_aluno int,
	@id_disciplina int
AS
BEGIN
	INSERT INTO ALUNODISCIPLINA(ID_ALUNO, ID_DISCIPLINA) VALUES(@id_aluno, @id_disciplina)
	SELECT * FROM ALUNO;
END

EXEC Matricular_Aluno 3, 1