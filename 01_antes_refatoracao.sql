-- TEMA 4 - SISTEMA ESCOLAR
-- REFATORAÇÃO DO BANCO DE DADOS
-- Integrantes: Julia Rocha e Analice Nascimento

PRAGMA foreign_keys = ON;

-- 1. TABELA ALUNO
CREATE TABLE aluno (
    matricula VARCHAR(20) PRIMARY KEY,
    aluno VARCHAR(100) NOT NULL,
    data_nascimento DATE
);

-- 2. TABELA TURMA
CREATE TABLE turma (
    id_turma INTEGER PRIMARY KEY,
    turma VARCHAR(20),
    ano_letivo INTEGER
);

-- 3. TABELA RESPONSAVEL
CREATE TABLE responsavel (
    id_responsavel INTEGER PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- 4. TABELA ALUNO_RESPONSAVEL
CREATE TABLE aluno_responsavel (
    matricula VARCHAR(20),
    id_responsavel INTEGER,
    parentesco VARCHAR(20),
    PRIMARY KEY (matricula, id_responsavel),
    FOREIGN KEY (matricula) REFERENCES aluno(matricula),
    FOREIGN KEY (id_responsavel)
        REFERENCES responsavel(id_responsavel)
);

-- 5. TABELA PROFESSOR
CREATE TABLE professor (
    id_professor INTEGER PRIMARY KEY,
    professor VARCHAR(100)
);

-- 6. TABELA DISCIPLINA
CREATE TABLE disciplina (
    id_disciplina INTEGER PRIMARY KEY,
    disciplina VARCHAR(50)
);

-- 7. TABELA OFERTA
CREATE TABLE oferta (
    id_oferta INTEGER PRIMARY KEY,
    id_turma INTEGER,
    id_disciplina INTEGER,
    id_professor INTEGER,
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

-- 8. TABELA MATRICULA
CREATE TABLE matricula (
    id_matricula INTEGER PRIMARY KEY,
    matricula VARCHAR(20),
    id_turma INTEGER,
    FOREIGN KEY (matricula) REFERENCES aluno(matricula),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

-- 9. TABELA NOTA
CREATE TABLE nota (
    id_matricula INTEGER,
    id_oferta INTEGER,
    nota_b1 NUMERIC(4,2),
    nota_b2 NUMERIC(4,2),
    nota_b3 NUMERIC(4,2),
    nota_b4 NUMERIC(4,2),
    situacao VARCHAR(20),
    PRIMARY KEY (id_matricula, id_oferta),
    FOREIGN KEY (id_matricula)
        REFERENCES matricula(id_matricula),
    FOREIGN KEY (id_oferta)
        REFERENCES oferta(id_oferta)
);

-- 10. TABELA FREQUENCIA
CREATE TABLE frequencia (
    id_matricula INTEGER,
    id_oferta INTEGER,
    faltas_total INTEGER,
    PRIMARY KEY (id_matricula, id_oferta),
    FOREIGN KEY (id_matricula, id_oferta)
        REFERENCES nota(id_matricula, id_oferta)
);

-- INDICES
CREATE INDEX idx_aluno_nome ON aluno(aluno);
CREATE INDEX idx_nota_matricula ON nota(id_matricula);
CREATE INDEX idx_disciplina_nome ON disciplina(disciplina);
