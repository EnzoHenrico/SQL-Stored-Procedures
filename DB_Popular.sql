Use dbAluno
GO

INSERT INTO ALUNO VALUES ('Mario');
INSERT INTO ALUNO VALUES ('Fernanda');
INSERT INTO ALUNO VALUES ('Rodrigo');
GO

INSERT INTO DISCIPLINA VALUES ('Programa��o 1', 80);
INSERT INTO DISCIPLINA VALUES ('C�lculo 2', 120);
INSERT INTO DISCIPLINA VALUES ('Estrutura de dados', 60);
GO

EXEC Matricular_Aluno 1, 1;
EXEC Matricular_Aluno 1, 2;
EXEC Matricular_Aluno 2, 1;
EXEC Matricular_Aluno 2, 2;
EXEC Matricular_Aluno 3, 1;
EXEC Matricular_Aluno 3, 3;
GO

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = 8.00, 
	NOTA2 = 1.00, 
	NOTASUBSTITUTIVA = null,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 1 AND ID_DISCIPLINA = 1;

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = 5.00, 
	NOTA2 = null, 
	NOTASUBSTITUTIVA = 8.00,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 1 AND ID_DISCIPLINA = 2;

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = 8.00, 
	NOTA2 = 9.00, 
	NOTASUBSTITUTIVA = null,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 2 AND ID_DISCIPLINA = 1;

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = 0, 
	NOTA2 = 8.00, 
	NOTASUBSTITUTIVA = 8.00,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 2 AND ID_DISCIPLINA = 2;

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = null, 
	NOTA2 = null, 
	NOTASUBSTITUTIVA = 10.00,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 3 AND ID_DISCIPLINA = 3;

UPDATE ALUNODISCIPLINA SET 
	NOTA1 = null, 
	NOTA2 = null, 
	NOTASUBSTITUTIVA = null,
	MEDIA = null,
	SITUACAO = null,
	ANO = 2024,
	SEMESTRE = 1
	WHERE ID_ALUNO = 3 AND ID_DISCIPLINA = 1;

SELECT * FROM aluno;
SELECT * FROM disciplina;
SELECT * FROM alunodisciplina;