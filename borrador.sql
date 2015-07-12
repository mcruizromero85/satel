select * from inscripciones
select * from gamers
select * from hots_formularios
select * from schema_migrations
delete from inscripciones where torneo_id=1

delete from encuentros

select * from encuentros order by 1 desc
delete from encuentros where id>803 
update encuentros set flag_listo_gamera=false, flag_listo_gamerb=false, estado='Pendiente', gamerinscrito_ganador_id=null;
update partidas set flag_gano_gamerinscritoa=false, flag_gano_gamerinscritob=false, estado='Pendiente'

select * from rondas

select e.gamerinscritoa_id,e.gamerinscrito_b from encuentros e, rondas r, torneos t where

select e.gamerinscritoa_id from encuentros e, rondas r where gamerinscrito_ganador_id is null and e.ronda_id = r.id and e.gamerinscritob_id = '' and r.torneo_id = ''
delete from schema_migrations where version='20150704155959'

SELECT "encuentros".* FROM "encuentros" WHERE (encuentros.ronda_id in (38,37) and encuentros.gamerinscrito_ganador_id is null and
 (encuentros.gamerinscritoa_id = 377 or encuentros.gamerinscritob_id = 377)) LIMIT 1


select * from partidas 
select * from encuentros
delete from partidas where flag_gano_gamerinscritob
update rondas set modo_ganar = 3


 SELECT COUNT(*) FROM "partidas" WHERE (partidas.encuentro_id=803 and partidas.estado = 'Finalizado' and flag_gano_gamerinscritoa = 't')
 SELECT COUNT(*) FROM "partidas" WHERE (partidas.encuentro_id=803 and partidas.estado = 'Finalizado' and flag_gano_gamerinscritob = 't')

 select * from gamers where id in (60,61,66,63)