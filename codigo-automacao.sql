USE atividade_pontuada;

-- ===========================================================================
-- 1. Criar uma view que exiba a quantidade de funcionários ativos e inativos
-- ===========================================================================

CREATE VIEW VW_STATUS_FUNCIONARIOS AS
SELECT 
    CASE 
        WHEN DT_DEMISSAO IS NULL THEN 'Ativo'
        ELSE 'Inativo'
    END AS Status,
    COUNT(*) AS Funcionarios
FROM FUNC
GROUP BY Status;

-- Consulta à view
SELECT * FROM VW_STATUS_FUNCIONARIOS;

-- ===========================================================================
-- 2. Fazer as modificações necessárias para armazenar no banco as regras de progressão
-- ===========================================================================

CREATE TABLE Regras_de_Progressao (
    Grau CHAR(1) PRIMARY KEY,              -- Grau de progressão (A a F)
    Tempo_Servico VARCHAR(50) NOT NULL,    -- Ex: '5 Anos', '10 Anos'...
    Percentual DECIMAL(5,3) NOT NULL       -- Percentual de bônus associado ao grau
);

-- Índice para facilitar consultas 
CREATE INDEX idx_regras_grau_percentual 
    ON Regras_de_Progressao(Grau, Percentual);

-- Inserindo registros
START TRANSACTION;

INSERT INTO Regras_de_Progressao (Grau, Tempo_Servico, Percentual)
VALUES ('A','5 Anos' ,0.000), -- Sem Bonus
       ('B','10 Anos',0.015), -- 1,5 %
       ('C','15 Anos',0.030), -- 3,0 %
       ('D','20 Anos',0.045), -- 4,5 %
       ('E','25 Anos',0.060), -- 6,0 %
       ('F','30 Anos',0.070); -- 7,0 %

COMMIT;

-- Consulta às regras
SELECT * FROM Regras_de_Progressao;

-- ====================================================================================
-- 3. Fazer as modificações necessárias para permitir a identificação do grau atual e
--    próximo período avaliativo de cada funcionário no momento da implantação
-- ====================================================================================

-- Adicionando colunas para o período avaliativo
ALTER TABLE FUNC 
    ADD COLUMN Data_Inicio DATE,
    ADD COLUMN Data_Fim    DATE;

-- Adicionando coluna de grau na tabela de funcionários	
ALTER TABLE FUNC 
    ADD COLUMN Grau CHAR(1);

-- Criando chave estrangeira
ALTER TABLE FUNC 
    ADD CONSTRAINT fk_Regras_Func_Grau 
    FOREIGN KEY (Grau) REFERENCES Regras_de_Progressao(Grau);

-- Consulta à tabela FUNC
SELECT * FROM FUNC;

-- Criando Procedure para calcular grau e período avaliativo
DELIMITER $$

CREATE PROCEDURE Atualizar_Grau_Funcionarios()
BEGIN 
    DECLARE Done INT DEFAULT FALSE;
    DECLARE V_Matricula INT;
    DECLARE V_Data_Admissao DATE;
    DECLARE V_Grau CHAR(1);
    DECLARE V_Data_Inicio DATE;
    DECLARE V_Data_Fim DATE;

    -- Cursor para percorrer funcionários ativos
    DECLARE Loop_Funcionarios CURSOR FOR
        SELECT Matricula, Dt_Admissao 
        FROM FUNC 
        WHERE Dt_Demissao IS NULL;

    -- Handler para controle de finalização
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Done = TRUE;

    OPEN Loop_Funcionarios;

    read_loop: LOOP
        FETCH Loop_Funcionarios INTO V_Matricula, V_Data_Admissao;
        IF Done THEN 
            LEAVE read_loop;
        END IF;

        -- Definindo grau e períodos de avaliação conforme tempo de serviço
        IF TIMESTAMPDIFF(YEAR, V_Data_Admissao, CURDATE()) < 5 THEN 
            SET V_Grau = 'A';
            SET V_Data_Inicio = V_Data_Admissao;
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 5 YEAR), INTERVAL 1 DAY);

        ELSEIF TIMESTAMPDIFF(YEAR, V_Data_Admissao, CURDATE()) < 10 THEN
            SET V_Grau = 'B';
            SET V_Data_Inicio = DATE_ADD(V_Data_Admissao, INTERVAL 5 YEAR);
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 10 YEAR), INTERVAL 1 DAY);

        ELSEIF TIMESTAMPDIFF(YEAR, V_Data_Admissao, CURDATE()) < 15 THEN
            SET V_Grau = 'C';
            SET V_Data_Inicio = DATE_ADD(V_Data_Admissao, INTERVAL 10 YEAR);
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 15 YEAR), INTERVAL 1 DAY);

        ELSEIF TIMESTAMPDIFF(YEAR, V_Data_Admissao, CURDATE()) < 20 THEN
            SET V_Grau = 'D';
            SET V_Data_Inicio = DATE_ADD(V_Data_Admissao, INTERVAL 15 YEAR);
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 20 YEAR), INTERVAL 1 DAY);

        ELSEIF TIMESTAMPDIFF(YEAR, V_Data_Admissao, CURDATE()) < 25 THEN
            SET V_Grau = 'E';
            SET V_Data_Inicio = DATE_ADD(V_Data_Admissao, INTERVAL 20 YEAR);
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 25 YEAR), INTERVAL 1 DAY);

        ELSE
            SET V_Grau = 'F';
            SET V_Data_Inicio = DATE_ADD(V_Data_Admissao, INTERVAL 25 YEAR);
            SET V_Data_Fim = DATE_SUB(DATE_ADD(V_Data_Admissao, INTERVAL 30 YEAR), INTERVAL 1 DAY);
        END IF;

        -- Atualizando dados do funcionário
        START TRANSACTION;

        UPDATE FUNC 
        SET 
            Grau = V_Grau, 
            Data_Inicio = V_Data_Inicio,
            Data_Fim = V_Data_Fim
        WHERE Matricula = V_Matricula;

        COMMIT;

    END LOOP;

    CLOSE Loop_Funcionarios;
END $$

DELIMITER ;

-- Executando Procedure
CALL Atualizar_Grau_Funcionarios();

-- Resultado Final
SELECT * FROM FUNC WHERE Dt_Demissao IS NULL;

-- ====================================================================================
-- 4- Criar uma view que mostre a matrícula, o nome do funcionário, o nome do cargo,
-- o salário base (sem o bônus), o grau atual do funcionário, valor do bônus e o novo
-- salário de todos os funcionários ativos;
-- ====================================================================================

CREATE OR REPLACE VIEW VW_BASE_SALARIAL_BONUS AS
SELECT 
    F.Matricula                                     AS Matricula, 
    F.Nome                                          AS Funcionario, 
    C.Nome                                          AS Cargo, 
    FORMAT(C.Salario, 2, 2)                         AS Salario_Old, 
    F.Grau                                          AS Grau,
    FORMAT((C.Salario * R.Percentual), 2, 2)        AS Bonus, 
    FORMAT((C.Salario * R.Percentual) + C.Salario, 2, 2) AS New_Salario
FROM Func F 
JOIN Cargo C ON F.Id_Cargo = C.Id
JOIN Regras_de_Progressao R ON F.Grau = R.Grau
WHERE F.Dt_Demissao IS NULL;

SELECT * FROM VW_BASE_SALARIAL_BONUS;


-- ====================================================================================
-- 5- Criar uma view que mostre o impacto dos bônus na folha de pagamento. Ou seja,
-- exiba o total dos salários a serem pagos com e sem o bônus;
-- ====================================================================================

CREATE OR REPLACE VIEW VW_SALARIO_COM_SEM_BONUS AS
SELECT 
    FORMAT(SUM(C.Salario), 2, 2) AS SALARIOS_SEM_BONUS,
    FORMAT(SUM((C.Salario * 
               (SELECT Percentual 
                FROM Regras_de_Progressao 
                WHERE Grau = F.Grau)) + C.Salario), 2, 2) AS SALARIOS_COM_BONUS
FROM Func F 
JOIN Cargo C ON C.Id = F.Id_Cargo
WHERE F.Dt_Demissao IS NULL;

SELECT * FROM VW_SALARIO_COM_SEM_BONUS;

-- ===============================================================================
-- 6- Criar uma procedure que receba o nome de um mês e um ano e que retorne uma
-- lista contendo a matrícula, o nome, o grau atual e o período a ser avaliado dos
-- funcionários que completem o ciclo no mês e ano solicitados
-- ===============================================================================

DELIMITER $$

CREATE PROCEDURE PROC_OBTER_PERIODO_AVALIACAO(IN P_MES VARCHAR(30),
                                              IN P_ANO INT)
BEGIN
    -- Declaração de variável para o mês
    DECLARE v_mes CHAR(2);

    -- Atribuição do mês conforme o parâmetro recebido
    SET v_mes = CASE 
                WHEN P_MES = 'Janeiro'   THEN '01'
                WHEN P_MES = 'Fevereiro' THEN '02'
                WHEN P_MES = 'Março'     THEN '03'
                WHEN P_MES = 'Abril'     THEN '04'
                WHEN P_MES = 'Maio'      THEN '05'
                WHEN P_MES = 'Junho'     THEN '06'
                WHEN P_MES = 'Julho'     THEN '07'
                WHEN P_MES = 'Agosto'    THEN '08'
                WHEN P_MES = 'Setembro'  THEN '09'
                WHEN P_MES = 'Outubro'   THEN '10'
                WHEN P_MES = 'Novembro'  THEN '11'
                WHEN P_MES = 'Dezembro'  THEN '12'
                ELSE '00'  -- Se o mês não for válido, retorna 00
           END;

    -- Consulta para obter os dados de funcionários que completam o ciclo no mês e ano fornecido
    SELECT  
           F.MATRICULA,
           F.NOME,
           F.GRAU,
           F.DATA_INICIO, 
           F.DATA_FIM 
    FROM FUNC F       
    WHERE F.DT_DEMISSAO IS NULL 
      AND EXTRACT(YEAR  FROM DATA_FIM) = P_ANO
      AND EXTRACT(MONTH FROM DATA_FIM) = v_mes;
      
END $$

DELIMITER ;

-- Chamada da Procedure
CALL PROC_OBTER_PERIODO_AVALIACAO('Abril', 2027); -- Ex: ('Junho',2027) ou ('Julho',2028)

-- ====================================================================================
-- 7- Fazer todas as alterações necessárias para realizar as avaliações de forma
-- automática. As avaliações realizadas devem ter seus dados armazenados para
-- consulta futura. Para cada avaliação é necessário armazenar: o código da
-- avaliação, a matrícula do funcionário, o grau no momento da avaliação, o período
-- apurado, a quantidade de faltas, a quantidade de dias de licença saúde, a
-- quantidade total de dias ausentes, o resultado da avaliação e a data em que a
-- avaliação foi feita. Após a avaliação, os dados da próxima avaliação devem ser
-- atualizados na tabela de funcionários;
-- ====================================================================================

CREATE TABLE AvaliacaoBonificacoes (
    identificadorAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    matriculaFuncionario INT NOT NULL,
    grauAnterior CHAR(1) NOT NULL, -- Grau no momento da avaliação
    dataInicioPeriodo DATE NOT NULL,
    dataFimPeriodo DATE NOT NULL,
    quantidadeFaltas INT DEFAULT 0,
    quantidadeLicencasSaude INT DEFAULT 0,
    quantidadeDiasAusentes INT DEFAULT 0,
    resultadoAvaliacao ENUM('Aprovado', 'Reprovado') NOT NULL,
    dataAvaliacao DATE NOT NULL
);

-- Tabela de Log para controle
CREATE TABLE IF NOT EXISTS Log_Avaliacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dt_execucao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('SUCESSO', 'FALHA'),
    observacao TEXT
);

-- Procedure de Avaliação de Funcionários
DELIMITER $$

CREATE PROCEDURE Avaliar_Funcionarios(IN P_MES VARCHAR(30),
                                      IN P_ANO INT)
BEGIN
    DECLARE Done INT DEFAULT FALSE;
    DECLARE v_new_Mes INT;
    DECLARE V_Matricula INT;
    DECLARE V_grau CHAR(1);
    DECLARE V_Data_Inicio DATE;
    DECLARE V_Data_Fim DATE;
    DECLARE V_quantidadeFaltas INT DEFAULT 0;
    DECLARE V_quantidadeLicencasSaude INT DEFAULT 0;
    DECLARE V_quantidadeDiasAusentes INT DEFAULT 0;
    DECLARE V_Resultado VARCHAR(50);
    DECLARE V_New_Grau CHAR(1);
    DECLARE V_New_Data_Inicio DATE;
    DECLARE V_New_Data_Fim DATE;

    -- Cursor para percorrer todos os funcionários
    DECLARE LOOP_AVALICAO_FUNC CURSOR FOR
    SELECT MATRICULA, GRAU, DATA_INICIO, DATA_FIM
    FROM FUNC
    WHERE DT_DEMISSAO IS NULL 
      AND EXTRACT(YEAR FROM DATA_FIM) = P_ANO
      AND EXTRACT(MONTH FROM DATA_FIM) = CASE 
                                             WHEN P_MES = 'Janeiro'   THEN 1
                                             WHEN P_MES = 'Fevereiro' THEN 2
                                             WHEN P_MES = 'Março'     THEN 3
                                             WHEN P_MES = 'Abril'     THEN 4
                                             WHEN P_MES = 'Maio'      THEN 5
                                             WHEN P_MES = 'Junho'     THEN 6
                                             WHEN P_MES = 'Julho'     THEN 7
                                             WHEN P_MES = 'Agosto'    THEN 8
                                             WHEN P_MES = 'Setembro'  THEN 9
                                             WHEN P_MES = 'Outubro'   THEN 10
                                             WHEN P_MES = 'Novembro'  THEN 11
                                             WHEN P_MES = 'Dezembro'  THEN 12
                                             ELSE 00
                                         END
    ORDER BY MATRICULA;

    -- Handler para controle de finalização
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Done = TRUE;

    -- Handler para erros SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO Log_Avaliacao (status, observacao) VALUES ('FALHA', 'Erro durante execução da procedure');
    END;

    OPEN LOOP_AVALICAO_FUNC;
    read_loop: LOOP
        FETCH LOOP_AVALICAO_FUNC INTO V_Matricula, V_grau, V_Data_Inicio, V_Data_Fim;
        IF Done THEN
            LEAVE read_loop;
        END IF;

        -- Definindo dias em que ocorreram faltas
        SET V_quantidadeFaltas = (
            SELECT COUNT(*)
            FROM ocorrencias
            WHERE MAT_FUNC = V_Matricula
            AND ID_TIPO IN (7, 6)
            AND DT_INI BETWEEN V_Data_Inicio AND V_Data_Fim
        );

        -- Definindo dias de licença Saúde
        SET V_quantidadeLicencasSaude = (
            SELECT IFNULL(SUM(
                CASE
                    WHEN (DT_INI < V_Data_Inicio) AND (V_Data_Fim BETWEEN V_Data_Inicio AND V_Data_Fim) THEN DATEDIFF(DT_FIM, V_Data_Inicio) + 1
                    WHEN (DT_INI BETWEEN V_Data_Inicio AND V_Data_Fim) AND (DT_FIM BETWEEN V_Data_Inicio AND V_Data_Fim) THEN DATEDIFF(DT_FIM, V_Data_Inicio) + 1
                    WHEN (DT_INI BETWEEN V_Data_Inicio AND V_Data_Fim) AND (DT_FIM > V_Data_Fim) THEN DATEDIFF(V_Data_Fim, DT_INI) + 1
                    WHEN (DT_INI < V_Data_Inicio) AND (DT_FIM > V_Data_Fim) THEN DATEDIFF(V_Data_Fim, V_Data_Inicio) + 1
                    ELSE 0
                END
            ), 0)
            FROM ocorrencias
            WHERE MAT_FUNC = V_Matricula
            AND ID_TIPO = 1
            AND (
                DT_INI BETWEEN V_Data_Inicio AND V_Data_Fim OR
                DT_FIM BETWEEN V_Data_Inicio AND V_Data_Fim OR
                (DT_INI < V_Data_Inicio AND DT_FIM > V_Data_Fim)
            )
        );
        
        -- Definindo dias ausentes
        SET V_quantidadeDiasAusentes = (V_quantidadeLicencasSaude + V_quantidadeFaltas);

        IF V_quantidadeDiasAusentes > 90 THEN
            SET V_Resultado = 'Reprovado';
            SET V_New_Data_Inicio = DATE_ADD(V_Data_Inicio, INTERVAL 5 YEAR);
            SET V_New_Data_Fim = DATE_ADD(V_Data_Fim, INTERVAL 5 YEAR);

            UPDATE FUNC
            SET DATA_INICIO = V_New_Data_Inicio,
                DATA_FIM = V_New_Data_Fim
            WHERE MATRICULA = V_Matricula;
        ELSE
            SET V_Resultado = 'Aprovado';
            IF V_grau != 'F' THEN
                IF V_grau = 'A' THEN
                    SET V_New_Grau = 'B';
                ELSEIF V_grau = 'B' THEN
                    SET V_New_Grau = 'C';
                ELSEIF V_grau = 'C' THEN
                    SET V_New_Grau = 'D';
                ELSEIF V_grau = 'D' THEN
                    SET V_New_Grau = 'E';
                ELSEIF V_grau = 'E' THEN
                    SET V_New_Grau = 'F';
                END IF;

                SET V_New_Data_Inicio = DATE_ADD(V_Data_Inicio, INTERVAL 5 YEAR);
                SET V_New_Data_Fim = DATE_ADD(V_Data_Fim, INTERVAL 5 YEAR);

                UPDATE FUNC
                SET GRAU = V_New_Grau,
                    DATA_INICIO = V_New_Data_Inicio,
                    DATA_FIM = V_New_Data_Fim
                WHERE MATRICULA = V_Matricula;
            END IF;
        END IF;

        -- Registro da avaliação
        INSERT INTO AvaliacaoBonificacoes (matriculaFuncionario, grauAnterior, dataInicioPeriodo, dataFimPeriodo, quantidadeFaltas,
                                           quantidadeLicencasSaude, quantidadeDiasAusentes, resultadoAvaliacao, dataAvaliacao)
        VALUES (V_Matricula, V_grau, V_Data_Inicio, V_Data_Fim, V_quantidadeFaltas, V_quantidadeLicencasSaude, V_quantidadeDiasAusentes, V_Resultado, CURDATE());

        -- Log de execução
        INSERT INTO Log_Avaliacao (status, observacao) VALUES ('SUCESSO', 'Avaliações realizadas com sucesso');

    END LOOP;
    CLOSE LOOP_AVALICAO_FUNC;
    
END $$

DELIMITER ;

-- Executando a Procedure para o mês de Abril e o ano de 2027
CALL avaliar_funcionarios('Maio', 2027);

-- Consultando o log de avaliações
SELECT * FROM Log_Avaliacao;

-- Consultando as avaliações realizadas
SELECT * FROM AvaliacaoBonificacoes;

-- Consultando os funcionários ativos (não demitidos)
SELECT * FROM FUNC WHERE DT_DEMISSAO IS NULL;

-- Criando um evento agendado para executar a procedure uma vez por dia,
-- mas com uma condição interna que garante que ela só será executada no dia 5 de cada mês.
-- Dessa forma, a procedure pode verificar e atualizar os registros anualmente,
-- respeitando a regra de que a avaliação de cada funcionário só deve ocorrer a cada 5 anos
-- (conforme a data de próxima avaliação registrada na tabela).

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT IF NOT EXISTS evt_verifica_e_roda_avaliacao
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    IF DAY(CURRENT_DATE) = 5 THEN
        CALL avaliar_funcionarios();
    END IF;
END$$

DELIMITER ;

-- ====================================================================================
-- 8 - Garantir que novas licenças maternidade inseridas prorrogam automaticamente 
--     a próxima avaliação da funcionária.
-- ====================================================================================

DELIMITER $$

CREATE TRIGGER tr_prorrogar_lic_maternidade
AFTER INSERT ON ocorrencias
FOR EACH ROW
BEGIN
    DECLARE DIAS INT DEFAULT 0;

    -- Verifica se é uma licença maternidade (ID_TIPO = 4)
    IF NEW.ID_TIPO = 4 THEN
        SET DIAS = DATEDIFF(NEW.DT_FIM, NEW.DT_INI);

        -- Atualiza o campo DATA_FIM da funcionária, prorrogando a avaliação
        UPDATE FUNC
        SET DATA_FIM = DATE_ADD(DATA_FIM, INTERVAL DIAS DAY)
        WHERE MATRICULA = NEW.MAT_FUNC;
    END IF;
END $$

DELIMITER ;

-- ====================================================================================
--                                   TESTES                                           --
-- ====================================================================================

-- Início da transação para testes
START TRANSACTION;

-- Verificar DATA_FIM antes da inserção da licença maternidade
SELECT matricula, DATA_FIM
FROM FUNC
WHERE matricula = 14;

-- Inserir nova licença maternidade
INSERT INTO ocorrencias (id_tipo, mat_func, dt_ini, dt_fim)
VALUES (4, 14, '2024-01-01', '2024-04-01');

-- Verificar se DATA_FIM foi prorrogada corretamente
SELECT matricula, DATA_FIM
FROM FUNC
WHERE matricula = 14;

-- Reverter alterações (utilize COMMIT se desejar manter)
ROLLBACK;
-- COMMIT;
