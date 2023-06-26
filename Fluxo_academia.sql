Processos de criaçao e atribuição de valores nas tabelas.

Tabela academia 
create table academia (cod_academia char(6) primary key, horario varchar, dias_funcionamento varchar)
Povoamento -
insert into academia values
('777222', '05-22','sg,tr,qr,qn,sx,sb'),
('456900', '05-22','sg,tr,qr,qn,sx,sb'),
('890765', '05-22','sg,tr,qr,qn,sx,sb'),
('665431', '05-21','sg,tr,qr,qn,sx,sb'),
('667433', '05-22','sg,tr,qr,qn,sx,sb'),
('431433', '05-20','sg,tr,qr,qn,sx,sb'),
('121433', '05-20','sg,tr,qr,qn,sx'),
('501433', '05-20','sg,tr,qr,qn,sx,sb'),
('931433', '05-19','sg,tr,qr,qn,sx,sb'),
('345433', '05-19','sg,tr,qr,qn,sx,sb'),
('840433', '05-23','sg,tr,qr,qn,sx,sb');

Tabela aluno
create table aluno
(mat_aluno int primary key, nome varchar(50), sexo char(1), idade int, telefone char(10), cod_academia char (6),
foreign key (cod_academia) references academia)
Povoamento -
insert into aluno values
(190, 'Eduardo', 'M', 19, '8893096593','777222'),
(191, 'George', 'M', 22, '8896532431','777222'),
(192, 'Davi', 'M', 19, '8895543487','777222'),
(193, 'Elvis', 'M', 20, '8863337891','777222'),
(194, 'Carlos', 'M', 23, '8894567839','456900'),
(195, 'Maria', 'F', 20, '8894324511','456900'),
(196, 'Joyce', 'F', 17, '8854231781','456900'),
(197, 'Dayane', 'F', 18, '8865453796','890765' ),
(198, 'Lis', 'F', 18, '8876548982','890765'),
(199, 'Eduarda', 'F', 20, '8876549895','890765');

tabela controle_fluxo
create table controle_fluxo 
(mat_aluno int primary key, cod_academia char(6), foreign key (cod_academia) references academia)
povoamento -
insert into controle_fluxo values
(190, '777222'),
(191, '777222'),
(192, '777222'),
(193, '777222'),
(194, '456900'),
(195, '456900'),
(196, '456900'),
(197, '890765'),
(198, '890765'),
(199, '890765')

tabela dia_treino
create table dia_treino 
(mat_aluno int primary key, cod_academia char(6), dia varchar(50), foreign key (cod_academia) references academia)
povoamento -
insert into dia_treino values
(190, '777222', 'sg,tr,qr'),
(191, '777222', 'sg,tr,qr'),
(192, '777222', 'sg,tr,qn'),
(193, '777222', 'sg,tr,qn,sx'),
(194, '456900', 'sg,tr,qn,sx'),
(195, '456900', 'sg,tr,qn,sx'),
(196, '456900', 'sg,tr,qr,sb'),
(197, '890765', 'sg,tr,qr,sb'),
(198, '890765', 'sg,tr,qr'),
(199, '890765', 'sg,tr,qr,qn,sx,sb')

tabela hora_treino
create table hora_treino (mat_aluno int primary key, cod_academia char(6), hora char(5), foreign key (cod_academia) references academia)
povoamento - 
insert into hora_treino values
(190, '777222','07:00'),
(191, '777222','07:00'),
(192, '777222','10:00'),
(193, '777222','09:00'),
(194, '456900','09:00'),
(195, '456900','17:00'),
(196, '456900','18:00'),
(197, '890765','19:00'),
(198, '890765','20:00'),
(199, '890765','06:00')

 
consultas - 
1 - Consulta para saber nome, hora e dia em que aluno X treina !
select al.nome,  ht.hora , dt.dia
from aluno al join academia ac on al.cod_academia
= ac.cod_academia join hora_treino ht on al.mat_aluno = ht.mat_aluno join dia_treino dt on ht.mat_aluno = dt.mat_aluno

2 - Consulta para saber quais alunos do sexo masculino treinam em dias "x" !
select al.sexo, al.nome,  ht.hora , dt.dia
from aluno al join academia ac on al.cod_academia
= ac.cod_academia join hora_treino ht on al.mat_aluno = ht.mat_aluno join dia_treino dt on ht.mat_aluno = dt.mat_aluno
where sexo = 'M' and dia like 'sg,tr,qr%'


3- Consulta para saber quantos alunos do sexo feminino treinam em determinada academia !
select ac.cod_academia, count(al.sexo)
from aluno al join academia ac on al.cod_academia
= ac.cod_academia  
where sexo = 'F'
group by ac.cod_academia;

4 - Consulta para saber a media de idade do sexo M que treinam em determinada academia.
select  ac.cod_academia ,avg (al.idade) 
from aluno al join academia ac on al.cod_academia = ac.cod_academia 
where ac.cod_academia = '777222' and al.sexo = 'M'
group by ac.cod_academia

5 - a consulta retorna o codigo da academia e o numero total de alunos que pertencem a cada academia
select ac.cod_academia, COUNT(al.mat_aluno) AS total_alunos
from academia ac
join aluno al ON ac.cod_academia = al.cod_academia
group by ac.cod_academia
having count (al.mat_aluno) > 2;