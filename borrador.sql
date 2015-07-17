select * from inscripciones
select * from gamers order by 1 
select * from hots_formularios
select * from schema_migrations
delete from inscripciones where torneo_id=1

select * from torneos
select * from rondas where torneo_id=5
select * from encuentros order by 1 desc
delete from partidas
delete from encuentros 

update encuentros set flag_listo_gamera=false, flag_listo_gamerb=false, estado='Pendiente', gamerinscrito_ganador_id=null;
delete from encuentros where ronda_id != 17
update torneos set estado='Creado'
select * from partidas
update partidas set flag_gano_gamerinscritoa=false, flag_gano_gamerinscritob=false, estado='Pendiente'


SELECT "encuentros".* FROM "encuentros" WHERE (encuentros.ronda_id in (38,37) and encuentros.gamerinscrito_ganador_id is null and
 (encuentros.gamerinscritoa_id = 377 or encuentros.gamerinscritob_id = 377)) LIMIT 1


select * from partidas 
select * from encuentros
delete from partidas where flag_gano_gamerinscritob
update rondas set modo_ganar = 3
update torneos set estado='Creado'

select * from schema_migrations
delete from schema_migrations where version='20150704155959'
select * from inscripciones
update inscripciones set estado='Confirmado' 
SELECT "torneos".* FROM "torneos" INNER JOIN "inscripciones" ON "inscripciones"."torneo_id" = "torneos"."id" AND ((tipo_inscripcion != 0 or tipo_inscripcion is null)) WHERE (torneos.estado = 'Iniciado' and inscripciones.gamer_id = 52 and inscripciones.estado = 'Confirmado' ) ORDER BY "torneos"."clasificacion" ASC, "torneos"."cierre_inscripcion" ASC
delete from chats
=================================================
Scripts ayuda en producción.
--http://localhost:3000/simular_sesion/17
--http://localhost:3000/encuentros/472/edit
select * from encuentros
select e.id, r.numero ,ia.gamer_id ,ia.etiqueta_llave, ib.gamer_id, ib.etiqueta_llave, e.encuentro_anterior_a_id, e.encuentro_anterior_b_id,e.gamerinscritoa_id ,e.gamerinscritob_id ,e.gamerinscrito_ganador_id 
from encuentros e, inscripciones ia, inscripciones ib, rondas r
where e.gamerinscritoa_id=ia.id and e.gamerinscritob_id=ib.id and r.id = e.ronda_id
select * from partidas where encuentro_id=501
delete from partidas where id=51

