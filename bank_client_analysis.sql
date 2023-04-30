-- esercizio 1
create table banca.uno
select
id_cliente,
year(current_date()) - year(data_nascita) as eta
from banca.cliente
order by id_cliente asc;

-- esercizio 2
create table banca.due
select
con.id_cliente,
count(id_tipo_trans) as num_oper_ent
from banca.transazioni as trans, banca.tipo_transazione as tt, banca.conto as con
where trans.id_conto = con.id_conto and trans.id_tipo_trans = 0 or trans.id_tipo_trans = 1 or trans.id_tipo_trans = 2
group by id_cliente
order by id_cliente asc; 



-- esercizio 3
create table banca.tre
select
con.id_cliente,
count(id_tipo_trans) as num_oper_usc
from banca.transazioni as trans, banca.tipo_transazione as tt, banca.conto as con
where trans.id_conto = con.id_conto and trans.id_tipo_trans = 3 or trans.id_tipo_trans = 4 or trans.id_tipo_trans = 5 or trans.id_tipo_trans = 6 or trans.id_tipo_trans = 7
group by id_cliente
order by id_cliente asc; 


-- esercizio 4
create table banca.quattro
select
con.id_cliente,
sum(importo) as totale_importi
from banca.transazioni as trans, banca.conto as con
where trans.id_conto = con.id_conto and trans.id_tipo_trans = 3 or trans.id_tipo_trans = 4 or trans.id_tipo_trans = 5 or trans.id_tipo_trans = 6 or trans.id_tipo_trans = 7
group by id_cliente
order by id_cliente asc;


-- esercizio 5
create table banca.cinque
select
con.id_cliente,
sum(importo) as totale_importi_ent
from banca.transazioni as trans, banca.conto as con
where trans.id_conto = con.id_conto and trans.id_tipo_trans = 0 or trans.id_tipo_trans = 1 or trans.id_tipo_trans = 2
group by id_cliente
order by id_cliente asc;

-- esercizio 6
create table banca.sei
select
id_cliente,
count(id_conto) as totale_conti
from banca.conto
group by id_cliente
order by id_cliente asc;

-- esercizio 7
-- 7a
create temporary table banca.conteggio_conti0
select
con.id_cliente,
count(id_tipo_conto) as conteggio_conti_0
from banca.conto as con
where con.id_tipo_conto = 0
group by id_cliente
order by id_cliente asc;


-- 7b
create temporary table banca.conteggio_conti1
select
con.id_cliente,
count(id_tipo_conto) as conteggio_conti_1
from banca.conto as con
where con.id_tipo_conto = 1
group by id_cliente
order by id_cliente asc;

-- 7c
create temporary table banca.conteggio_conti2
select
con.id_cliente,
count(id_tipo_conto) as conteggio_conti_2
from banca.conto as con
where con.id_tipo_conto = 2
group by id_cliente
order by id_cliente asc;

-- 7d
create temporary table banca.conteggio_conti3
select
con.id_cliente,
count(id_tipo_conto) as conteggio_conti_3
from banca.conto as con
where con.id_tipo_conto = 3
group by id_cliente
order by id_cliente asc;

create table banca.sette
select
conteggio_conti0.id_cliente,
conteggio_conti0.conteggio_conti_0,
conteggio_conti1.conteggio_conti_1,
conteggio_conti2.conteggio_conti_2,
conteggio_conti3.conteggio_conti_3
from banca.conteggio_conti0
left join banca.conteggio_conti1
on conteggio_conti0.id_cliente = conteggio_conti1.id_cliente
left join banca.conteggio_conti2
on conteggio_conti0.id_cliente = conteggio_conti2.id_cliente
left join banca.conteggio_conti3
on conteggio_conti0.id_cliente = conteggio_conti3.id_cliente;


    
-- esercizio 8 - 
-- creo una tabella temporanea da una join da due tabelle del db originale

create temporary table banca.tran_uscita 
select * from banca.transazioni as trans
inner join banca.tipo_transazione as tt
on trans.id_tipo_trans = tt.id_tipo_transazione
where tt.segno = "-"; -- seleziono unicamente le transazioni in uscita

-- 8 transazioni (uscita) tipo 3
create temporary table banca.tran_uscita3
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo3
from banca.tran_uscita as t_usc
inner join banca.conto as con
on t_usc.id_conto = con.id_conto
where id_tipo_trans = 3
group by id_cliente
order by id_cliente asc;

-- 8 transazioni (uscita) tipo 4
create temporary table banca.tran_uscita4
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo4
from banca.tran_uscita as t_usc
inner join banca.conto as con
on t_usc.id_conto = con.id_conto
where id_tipo_trans = 4
group by id_cliente
order by id_cliente asc;

-- 8 transazioni (uscita) tipo 5
create temporary table banca.tran_uscita5
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo5
from banca.tran_uscita as t_usc
inner join banca.conto as con
on t_usc.id_conto = con.id_conto
where id_tipo_trans = 5
group by id_cliente
order by id_cliente asc;

-- 8 transazioni (uscita) tipo 6
create temporary table banca.tran_uscita6
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo6
from banca.tran_uscita as t_usc
inner join banca.conto as con
on t_usc.id_conto = con.id_conto
where id_tipo_trans = 6
group by id_cliente
order by id_cliente asc;

-- 8 transazioni (uscita) tipo 7
create temporary table banca.tran_uscita7
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo7
from banca.tran_uscita as t_usc
inner join banca.conto as con
on t_usc.id_conto = con.id_conto
where id_tipo_trans = 7
group by id_cliente
order by id_cliente asc;

create table banca.otto
select
banca.tran_uscita3.id_cliente,
banca.tran_uscita3.cont_trans_tipo3,
banca.tran_uscita4.cont_trans_tipo4,
banca.tran_uscita5.cont_trans_tipo5,
banca.tran_uscita6.cont_trans_tipo6,
banca.tran_uscita7.cont_trans_tipo7
from banca.tran_uscita3
left join banca.tran_uscita4
on banca.tran_uscita3.id_cliente = banca.tran_uscita4.id_cliente
left join banca.tran_uscita5
on banca.tran_uscita3.id_cliente = banca.tran_uscita5.id_cliente
left join banca.tran_uscita6
on banca.tran_uscita3.id_cliente = banca.tran_uscita6.id_cliente
left join banca.tran_uscita7
on banca.tran_uscita3.id_cliente = banca.tran_uscita7.id_cliente;


-- esercizio 9
-- creo una tabella temporanea da una join da due tabelle del db originale

create temporary table banca.tran_entrata 
select * from banca.transazioni as trans
inner join banca.tipo_transazione as tt
on trans.id_tipo_trans = tt.id_tipo_transazione
where tt.segno = "+"; -- seleziono unicamente le transazioni in entrata


-- 9 transazioni (entrata) tipo 0
create temporary table banca.tran_entrata0
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo0
from banca.tran_entrata as t_ent
inner join banca.conto as con
on t_ent.id_conto = con.id_conto
where id_tipo_trans = 0
group by id_cliente
order by id_cliente asc;

create temporary table banca.tran_entrata1
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo1
from banca.tran_entrata as t_ent
inner join banca.conto as con
on t_ent.id_conto = con.id_conto
where id_tipo_trans = 1
group by id_cliente
order by id_cliente asc;

create temporary table banca.tran_entrata2
select 
id_cliente,
count(id_tipo_trans) as cont_trans_tipo2
from banca.tran_entrata as t_ent
inner join banca.conto as con
on t_ent.id_conto = con.id_conto
where id_tipo_trans = 2
group by id_cliente
order by id_cliente asc;


create table banca.nove
select
banca.tran_entrata0.id_cliente,
banca.tran_entrata0.cont_trans_tipo0,
banca.tran_entrata1.cont_trans_tipo1,
banca.tran_entrata2.cont_trans_tipo2
from banca.tran_entrata0
left join banca.tran_entrata1
on banca.tran_entrata0.id_cliente = banca.tran_entrata1.id_cliente
left join banca.tran_entrata2
on banca.tran_entrata0.id_cliente = banca.tran_entrata2.id_cliente;


-- esercizio 10 
create temporary table banca.tc_usc0
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tusc.importo
from banca.conto as con
inner join banca.tran_uscita as tusc
on con.id_conto = tusc.id_conto
where id_tipo_conto = 0 
group by id_cliente
order by id_cliente asc;


create temporary table banca.tc_usc1
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tusc.importo
from banca.conto as con
inner join banca.tran_uscita as tusc
on con.id_conto = tusc.id_conto
where id_tipo_conto = 1 
group by id_cliente
order by id_cliente asc;

create temporary table banca.tc_usc2
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tusc.importo
from banca.conto as con
inner join banca.tran_uscita as tusc
on con.id_conto = tusc.id_conto
where id_tipo_conto = 2
group by id_cliente
order by id_cliente asc;

create temporary table banca.tc_usc3
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tusc.importo
from banca.conto as con
inner join banca.tran_uscita as tusc
on con.id_conto = tusc.id_conto
where id_tipo_conto = 3
group by id_cliente
order by id_cliente asc;


create table banca.dieci
select
banca.tc_usc0.id_cliente,
banca.tc_usc0.importo as imp_usc_tc0,
banca.tc_usc1.importo as imp_usc_tc1,
banca.tc_usc2.importo as imp_usc_tc2,
banca.tc_usc3.importo as imp_usc_tc3
from banca.tc_usc0
left join banca.tc_usc1
on banca.tc_usc0.id_cliente = banca.tc_usc1.id_cliente
left join banca.tc_usc2
on banca.tc_usc0.id_cliente = banca.tc_usc2.id_cliente
left join banca.tc_usc3
on banca.tc_usc0.id_cliente = banca.tc_usc3.id_cliente
group by id_cliente
order by id_cliente asc;


-- esercizio 11
create temporary table banca.tc_ent0
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tent.importo
from banca.conto as con
inner join banca.tran_entrata as tent
on con.id_conto = tent.id_conto
where id_tipo_conto = 0 
group by id_cliente
order by id_cliente asc;


create temporary table banca.tc_ent1
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tent.importo
from banca.conto as con
inner join banca.tran_entrata as tent
on con.id_conto = tent.id_conto
where id_tipo_conto = 1 
group by id_cliente
order by id_cliente asc;

create temporary table banca.tc_ent2
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tent.importo
from banca.conto as con
inner join banca.tran_entrata as tent
on con.id_conto = tent.id_conto
where id_tipo_conto = 2
group by id_cliente
order by id_cliente asc;

create temporary table banca.tc_ent3
select 
con.id_cliente,
con.id_conto,
con.id_tipo_conto,
tent.importo
from banca.conto as con
inner join banca.tran_entrata as tent
on con.id_conto = tent.id_conto
where id_tipo_conto = 3
group by id_cliente
order by id_cliente asc;


create table banca.undici
select
banca.tc_ent0.id_cliente,
banca.tc_ent0.importo as imp_ent_tc0,
banca.tc_ent1.importo as imp_ent_tc1,
banca.tc_ent2.importo as imp_ent_tc2,
banca.tc_ent3.importo as imp_ent_tc3
from banca.tc_ent0
left join banca.tc_ent1
on banca.tc_ent0.id_cliente = banca.tc_ent1.id_cliente
left join banca.tc_ent2
on banca.tc_ent0.id_cliente = banca.tc_ent2.id_cliente
left join banca.tc_ent3
on banca.tc_ent0.id_cliente = banca.tc_ent3.id_cliente
group by id_cliente;



-- JOIN TOTALE

create view banca.progetto_finale_SQL as
select 
uno.id_cliente, 
uno.eta as ind1,
due.num_oper_ent as ind2,
tre.num_oper_usc as ind3,
quattro.totale_importi as ind4,
cinque.totale_importi_ent as ind5,
sei.totale_conti as ind6,
sette.conteggio_conti_0 as ind7_0,
sette.conteggio_conti_1 as ind7_1,
sette.conteggio_conti_2 as ind7_2,
sette.conteggio_conti_3 as ind7_3,
otto.cont_trans_tipo3 as ind8_3,
otto.cont_trans_tipo4 as ind8_4,
otto.cont_trans_tipo5 as ind8_5,
otto.cont_trans_tipo6 as ind8_6,
otto.cont_trans_tipo7 as ind8_7,
nove.cont_trans_tipo0 as ind9_0,
nove.cont_trans_tipo1 as ind9_1,
nove.cont_trans_tipo2 as ind9_2,
dieci.imp_usc_tc0,
dieci.imp_usc_tc1,
dieci.imp_usc_tc2,
dieci.imp_usc_tc3,
undici.imp_ent_tc0,
undici.imp_ent_tc1,
undici.imp_ent_tc2,
undici.imp_ent_tc3
from banca.uno 
left join banca.due 
on uno.id_cliente = due.id_cliente
left join banca.tre
on uno.id_cliente = tre.id_cliente
left join banca.quattro
on uno.id_cliente = quattro.id_cliente
left join banca.cinque
on uno.id_cliente = cinque.id_cliente
left join banca.sei
on uno.id_cliente = sei.id_cliente
left join banca.sette
on uno.id_cliente = sette.id_cliente
left join banca.otto
on uno.id_cliente = otto.id_cliente
left join banca.nove
on uno.id_cliente = nove.id_cliente
left join banca.dieci
on uno.id_cliente = dieci.id_cliente
left join banca.undici
on uno.id_cliente = undici.id_cliente
group by id_cliente
order by id_cliente asc;
        
select * from banca.progetto_finale_SQL;