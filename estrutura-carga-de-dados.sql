create database atividade_pontuada;

use atividade_pontuada;

create table
    depto (
        id int auto_increment primary key,
        nome varchar(100) not null unique
    );

INSERT INTO
    depto (nome)
VALUES
    ('Recursos Humanos'),
    ('Financeiro'),
    ('Marketing'),
    ('Vendas'),
    ('TI'),
    ('Logística'),
    ('Jurídico'),
    ('Comercial'),
    ('Pesquisa e Desenvolvimento'),
    ('Atendimento ao Cliente');

create table
    cargo (
        id int auto_increment primary key,
        nome varchar(100) not null unique,
        salario double not null check (salario > 1500)
    );

INSERT INTO
    cargo (nome, salario)
VALUES
    ('Analista de Recursos Humanos', 3000),
    ('Coordenador de Recursos Humanos', 5000),
    ('Diretor de Recursos Humanos', 10000),
    ('Analista Financeiro', 3500),
    ('Coordenador Financeiro', 6000),
    ('Diretor Financeiro', 12000),
    ('Gerente de Marketing', 5500),
    ('Analista de Marketing', 3200),
    ('Diretor de Marketing', 11000),
    ('Analista de Vendas', 3000),
    ('Coordenador de Vendas', 5800),
    ('Diretor de Vendas', 10000),
    ('Desenvolvedor de Sistemas', 4500),
    ('Analista de TI', 4000),
    ('Gerente de TI', 7000),
    ('Coordenador de Logística', 4800),
    ('Analista de Logística', 3500),
    ('Advogado Corporativo', 7500),
    ('Assistente Comercial', 2500),
    ('Coordenador de Atendimento ao Cliente', 4700);

create table
    tipo_ocor (
        id int auto_increment primary key,
        nome varchar(100) not null unique
    );

INSERT INTO
    tipo_ocor (nome)
VALUES
    ('Licença Saúde'),
    ('Licença Gala'),
    ('Licença Nojo'),
    ('Licença Maternidade'),
    ('Licença Paternidade'),
    ('Falta Justificada'),
    ('Falta Injustificada'),
    ('Atraso'),
    ('Saída Antecipada'),
    ('Saída Durante o Expediente');

create table
    func (
        matricula int auto_increment primary key,
        nome varchar(200) not null,
        endereco varchar(200) not null,
        dt_nasc date not null,
        dt_admissao date not null,
        dt_demissao date,
        id_cargo int not null,
        constraint fk_func_cargo foreign key (id_cargo) references cargo (id)
    );

INSERT INTO
    func (
        nome,
        endereco,
        dt_nasc,
        dt_admissao,
        dt_demissao,
        id_cargo
    )
VALUES
    (
        'José Costa Silva',
        'Rua A, 12, Mogi das Cruzes, SP',
        '1989-03-21',
        '2017-05-10',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Recursos Humanos'
        )
    ),
    (
        'Maria Souza Lima',
        'Rua B, 45, São Paulo, SP',
        '1992-07-14',
        '2018-08-15',
        '2021-06-14',
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Recursos Humanos'
        )
    ),
    (
        'Carlos Alberto Mendes',
        'Avenida C, 89, Mogi das Cruzes, SP',
        '1985-11-30',
        '2016-03-20',
        '2021-12-01',
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor de Recursos Humanos'
        )
    ),
    (
        'Fernanda Oliveira',
        'Rua D, 23, Mogi das Cruzes, SP',
        '1990-04-25',
        '2019-02-05',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista Financeiro'
        )
    ),
    (
        'Rafael Ferreira',
        'Rua E, 77, Mogi das Cruzes, SP',
        '1987-09-12',
        '2015-06-10',
        '2017-04-18',
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador Financeiro'
        )
    ),
    (
        'Larissa Santos',
        'Rua F, 102, Suzano, SP',
        '1993-05-20',
        '2021-01-11',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor Financeiro'
        )
    ),
    (
        'Ricardo Nunes',
        'Rua G, 56, Mogi das Cruzes, SP',
        '1988-12-03',
        '2016-07-22',
        '2016-09-17',
        (
            select
                id
            from
                cargo
            where
                nome = 'Gerente de Marketing'
        )
    ),
    (
        'Paula Lima',
        'Avenida H, 78, Mogi das Cruzes, SP',
        '1991-06-15',
        '2017-09-30',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Marketing'
        )
    ),
    (
        'Gustavo Andrade',
        'Rua I, 91, Mogi das Cruzes, SP',
        '1986-10-01',
        '2015-12-20',
        '2023-05-25',
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor de Marketing'
        )
    ),
    (
        'Camila Farias',
        'Rua J, 33, Guararema, SP',
        '1994-01-18',
        '2022-06-01',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Vendas'
        )
    ),
    (
        'Felipe Moura',
        'Avenida K, 15,  Guararema, SP',
        '1990-08-11',
        '2010-04-15',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Vendas'
        )
    ),
    (
        'Juliana Martins',
        'Rua L, 20,  Guararema, SP',
        '1983-02-28',
        '2015-02-10',
        '2021-08-14',
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor de Vendas'
        )
    ),
    (
        'Renato Xavier',
        'Rua M, 88, Suzano, SP',
        '1992-12-19',
        '2018-10-05',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Desenvolvedor de Sistemas'
        )
    ),
    (
        'Amanda Duarte',
        'Avenida N, 67, Suzano, SP',
        '1989-07-22',
        '2019-05-30',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de TI'
        )
    ),
    (
        'Marcos Vinicius',
        'Rua O, 34, Suzano, SP',
        '1986-03-07',
        '2016-11-12',
        '2020-07-09',
        (
            select
                id
            from
                cargo
            where
                nome = 'Gerente de TI'
        )
    ),
    (
        'Tatiane Barbosa',
        'Rua P, 22, Jacareí, SP',
        '1995-09-14',
        '2023-01-20',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Logística'
        )
    ),
    (
        'Rodrigo Neves',
        'Rua Q, 29, Jacareí, SP',
        '1993-11-08',
        '2018-06-18',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Logística'
        )
    ),
    (
        'Letícia Gomes',
        'Avenida R, 47, Jacareí, SP',
        '1984-05-05',
        '2007-03-22',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Advogado Corporativo'
        )
    ),
    (
        'Diego Menezes',
        'Rua S, 71, Mogi das Cruzes, SP',
        '1996-01-30',
        '2022-08-10',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Assistente Comercial'
        )
    ),
    (
        'Bruna Cavalcante',
        'Avenida T, 83, Mogi das Cruzes, SP',
        '1990-02-16',
        '2019-09-17',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Atendimento ao Cliente'
        )
    ),
    (
        'Eduardo Vasconcelos',
        'Rua U, 38, Mogi das Cruzes, SP',
        '1988-06-29',
        '2015-11-01',
        '2022-12-30',
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor de Recursos Humanos'
        )
    ),
    (
        'Isabela Rocha',
        'Rua V, 53, Mogi das Cruzes, SP',
        '1992-03-13',
        '2020-07-05',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Marketing'
        )
    ),
    (
        'Fernando Brito',
        'Avenida W, 90, Mogi das Cruzes, SP',
        '1985-10-24',
        '2016-05-09',
        '2021-06-21',
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor Financeiro'
        )
    ),
    (
        'Renata Silva',
        'Rua X, 13, Guararema, SP',
        '1994-08-01',
        '2021-10-14',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista de Logística'
        )
    ),
    (
        'Thiago Martins',
        'Avenida Y, 25, Suzano, SP',
        '1987-12-07',
        '2017-04-19',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador Financeiro'
        )
    ),
    (
        'Sabrina Nogueira',
        'Rua Z, 59, Arujá, SP',
        '1991-05-30',
        '2018-01-30',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista Financeiro'
        )
    ),
    (
        'Luciano Mendes',
        'Rua AA, 77, Arujá, SP',
        '1989-09-11',
        '2016-09-15',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Gerente de Marketing'
        )
    ),
    (
        'Carolina Duarte',
        'Avenida BB, 36, Mogi das Cruzes, SP',
        '1993-04-22',
        '2023-02-25',
        '2023-02-24',
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Recursos Humanos'
        )
    ),
    (
        'Vinícius Prado',
        'Rua CC, 62, Mogi das Cruzes, SP',
        '1986-07-18',
        '2015-08-29',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Diretor de Vendas'
        )
    ),
    (
        'Roberto Almeida',
        'Rua DD, 15, Mogi das Cruzes, SP',
        '1990-03-15',
        '2022-04-10',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Analista Financeiro'
        )
    ),
    (
        'Vanessa Ribeiro',
        'Rua EE, 28, Mogi das Cruzes, SP',
        '1988-12-25',
        '2021-06-15',
        '2023-02-24',
        (
            select
                id
            from
                cargo
            where
                nome = 'Coordenador de Recursos Humanos'
        )
    ),
    (
        'Anderson Castro',
        'Rua FF, 42, Mogi das Cruzes, SP',
        '1993-07-08',
        '2023-03-20',
        NULL,
        (
            select
                id
            from
                cargo
            where
                nome = 'Gerente de TI'
        )
    );

create table
    lotacao (
        id int auto_increment primary key,
        id_depto int not null,
        mat_func int not null,
        dt_ini date not null,
        dt_fim date,
        constraint fk_lot_depto foreign key (id_depto) references depto (id),
        constraint fk_lot_func foreign key (mat_func) references func (matricula)
    );

INSERT INTO
    lotacao (id_depto, mat_func, dt_ini, dt_fim)
VALUES
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        '2017-05-10',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        '2018-08-15',
        '2021-06-14'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carlos Alberto Mendes'
        ),
        '2016-03-20',
        '2021-12-01'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernanda Oliveira'
        ),
        '2019-02-05',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        '2015-06-10',
        '2017-04-18'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Larissa Santos'
        ),
        '2021-01-11',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Ricardo Nunes'
        ),
        '2016-07-22',
        '2016-09-14'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Paula Lima'
        ),
        '2017-09-30',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Gustavo Andrade'
        ),
        '2015-12-20',
        '2023-05-25'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Vendas'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        '2022-06-01',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Vendas'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Felipe Moura'
        ),
        '2010-04-15',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Vendas'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Juliana Martins'
        ),
        '2015-02-10',
        '2021-08-14'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'TI'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        '2018-10-05',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'TI'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Amanda Duarte'
        ),
        '2019-05-30',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'TI'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        '2016-11-12',
        '2020-07-09'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Logística'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        '2023-01-20',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Logística'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        '2018-06-18',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Jurídico'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        '2007-03-22',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Comercial'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        '2022-08-10',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Atendimento ao Cliente'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        '2019-09-17',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        '2015-11-01',
        '2022-12-30'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Isabela Rocha'
        ),
        '2020-07-05',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        '2016-05-09',
        '2021-06-21'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Logística'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renata Silva'
        ),
        '2021-10-14',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        '2017-04-19',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Sabrina Nogueira'
        ),
        '2018-01-30',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        '2016-09-15',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        '2023-02-25',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Vendas'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vinícius Prado'
        ),
        '2015-08-29',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        '2022-04-10',
        NULL
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        '2021-06-15',
        '2023-02-24'
    ),
    (
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'TI'
        ),
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        '2023-03-20',
        NULL
    );

create table
    gerenciamento (
        id_gerente int,
        id_depto int,
        dt_ini date not null,
        dt_fim date,
        constraint primary key (id_gerente, id_depto, dt_ini),
        constraint fk_ger_depto foreign key (id_depto) references depto (id),
        constraint fk_ger_func foreign key (id_gerente) references func (matricula)
    );

INSERT INTO
    gerenciamento
VALUES
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        '2018-08-15',
        '2021-06-14'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        '2021-06-15',
        '2023-02-24'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Recursos Humanos'
        ),
        '2023-02-25',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        '2015-06-10',
        '2017-04-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Financeiro'
        ),
        '2017-04-19',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Ricardo Nunes'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        '2016-07-22',
        '2016-09-14'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Marketing'
        ),
        '2016-09-15',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Felipe Moura'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Vendas'
        ),
        '2020-04-15',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'TI'
        ),
        '2023-03-20',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Logística'
        ),
        '2023-01-20',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Jurídico'
        ),
        '2017-03-22',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Atendimento ao Cliente'
        ),
        '2019-09-17',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Juliana Martins'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Comercial'
        ),
        '2015-02-10',
        '2021-08-14'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vinícius Prado'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Comercial'
        ),
        '2015-08-29',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                depto
            WHERE
                nome = 'Pesquisa e Desenvolvimento'
        ),
        '2024-04-18',
        null
    );

create table
    ocorrencias (
        id int auto_increment primary key,
        mat_func int not null,
        id_tipo int not null,
        dt_ini date not null,
        dt_fim date,
        constraint fk_ocor_func foreign key (mat_func) references func (matricula),
        constraint fk_ocor_tipo foreign key (id_tipo) references tipo_ocor (id)
    );

INSERT INTO
    ocorrencias (mat_func, id_tipo, dt_ini, dt_fim)
VALUES
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2018-03-15',
        '2018-03-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2019-07-10',
        '2019-07-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-05-15',
        '2022-05-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2027-05-08',
        '2027-05-13'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-05-05',
        '2022-05-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-08-15',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-10-01',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-04-15',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-01',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-02',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-03',
        null
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2020-01-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2021-09-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-04-28',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2019-05-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2022-08-14',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2020-11-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2021-06-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'José Costa Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2023-12-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Maternidade'
        ),
        '2019-02-10',
        '2019-06-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2018-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2019-12-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2020-08-14',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2019-07-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2020-03-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2021-02-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Maria Souza Lima'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2021-05-28',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carlos Alberto Mendes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2021-08-28',
        '2021-08-31'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernanda Oliveira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2020-05-15',
        '2020-05-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2016-01-10',
        '2016-01-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2016-11-05',
        '2016-11-12'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2015-07-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2016-03-08',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2017-02-14',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2015-09-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2016-07-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2017-04-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2015-12-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2016-09-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rafael Ferreira'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2017-03-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Larissa Santos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Maternidade'
        ),
        '2022-08-18',
        '2022-12-17'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Ricardo Nunes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Paternidade'
        ),
        '2018-08-18',
        '2018-08-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Ricardo Nunes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2021-01-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Gustavo Andrade'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2020-12-15',
        '2021-04-14'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2022-12-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-02-17',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2024-08-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2025-01-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Camila Farias'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2024-01-25',
        '2024-05-24'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Felipe Moura'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2020-01-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Felipe Moura'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2024-09-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2019-09-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2020-07-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2020-09-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2021-10-01',
        '2021-10-14'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renato Xavier'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2021-10-25',
        '2021-11-04'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Amanda Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2020-10-25',
        '2020-11-04'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Amanda Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2021-10-25',
        '2021-11-04'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Amanda Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2021-10-25',
        '2021-11-04'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2017-02-10',
        '2017-02-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2018-05-12',
        '2018-05-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2019-09-18',
        '2019-09-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2016-12-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2019-04-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2020-06-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2017-11-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Marcos Vinicius'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2018-07-09',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-02-15',
        '2023-02-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2023-03-10',
        '2023-03-12'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2023-06-05',
        '2023-06-08'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-09-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-10-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-11-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-12-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2024-01-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2024-02-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2024-03-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Tatiane Barbosa'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2024-04-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2018-07-10',
        '2018-07-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2019-02-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2019-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2020-03-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Rodrigo Neves'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2020-06-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2017-05-10',
        '2017-05-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2018-08-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2019-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2020-07-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2021-09-12',
        '2021-09-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-04-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-11-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-03-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2023-07-08',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Letícia Gomes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2023-10-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-09-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-04-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-10-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2024-01-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Diego Menezes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2024-03-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2019-10-05',
        '2019-10-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2020-03-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2020-08-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2021-06-14',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-01-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2023-05-09',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Bruna Cavalcante'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2024-02-20',
        '2024-02-22'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2015-11-15',
        '2015-11-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2016-03-10',
        '2016-03-12'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2016-06-05',
        '2016-06-07'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Paternidade'
        ),
        '2017-01-15',
        '2017-01-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2017-04-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2017-08-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2017-10-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2018-02-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2018-05-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2018-07-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2018-09-03',
        '2018-09-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2019-01-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2019-04-16',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2019-06-25',
        '2019-06-28'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Paternidade'
        ),
        '2020-01-15',
        '2020-01-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2020-03-08',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2021-04-22',
        '2021-04-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2021-07-18',
        '2021-07-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-11-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Eduardo Vasconcelos'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-12-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2016-06-01',
        '2016-06-05'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2017-11-10',
        '2017-11-12'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2018-08-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2019-04-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2020-06-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Fernando Brito'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2021-06-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Renata Silva'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Maternidade'
        ),
        '2023-03-07',
        '2023-07-06'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2018-02-15',
        '2018-02-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2018-05-01',
        '2018-05-05'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2018-08-15',
        '2018-08-17'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Paternidade'
        ),
        '2019-07-01',
        '2019-07-05'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2020-02-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2020-06-19',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2021-03-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2021-05-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2021-09-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-02-10',
        '2022-02-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2022-07-15',
        '2022-07-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-07',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Thiago Martins'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-09-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2020-11-10',
        '2020-11-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2021-02-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2021-08-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Luciano Mendes'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2022-03-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-02-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-03-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-04-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-05-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-06-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-07-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-09-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Carolina Duarte'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-04-10',
        '2022-04-15'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-05-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-06-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2022-07-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-08-03',
        '2022-08-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-09-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2022-11-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2022-12-20',
        '2022-12-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-01-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-02-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-03-08',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-04-15',
        '2023-04-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-05-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-06-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-07-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-08-22',
        '2023-08-30'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-09-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-10-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-11-13',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-12-01',
        '2023-12-07'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2024-01-14',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2024-02-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2024-03-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2024-04-05',
        '2024-04-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Roberto Almeida'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2024-05-11',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2021-06-15',
        '2021-06-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Gala'
        ),
        '2021-08-10',
        '2021-08-12'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2022-02-15',
        '2022-02-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Maternidade'
        ),
        '2022-04-05',
        '2022-04-20'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2022-07-12',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2022-11-22',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-03-30',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Vanessa Ribeiro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2023-07-07',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-03-20',
        '2023-03-25'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2023-04-01',
        '2023-04-03'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-04-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-05-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-05-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2023-06-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2023-06-18',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-07-01',
        '2023-07-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-08-05',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2023-08-15',
        '2023-08-18'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-09-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-09-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2023-09-25',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Saúde'
        ),
        '2023-10-05',
        '2023-10-10'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Justificada'
        ),
        '2023-10-20',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Licença Nojo'
        ),
        '2023-11-05',
        '2023-11-07'
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Falta Injustificada'
        ),
        '2023-11-15',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Atraso'
        ),
        '2023-12-01',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Durante o Expediente'
        ),
        '2023-12-10',
        NULL
    ),
    (
        (
            SELECT
                matricula
            FROM
                func
            WHERE
                nome = 'Anderson Castro'
        ),
        (
            SELECT
                id
            FROM
                tipo_ocor
            WHERE
                nome = 'Saída Antecipada'
        ),
        '2023-12-20',
        NULL
    );