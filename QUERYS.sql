drop database mydb;
create database mydb;
select * from mydb.rep_solicitudservicio;

select * from mydb.rep_datosusuario;
update mydb.rep_datosusuario
set Tipo_Usuario = 2
where Id_Usuario = 19;

delete from mydb.rep_datosusuario
where Tipo_Usuario in (1,2);

delete from mydb.rep_solicitudservicio
where Comuna_Servicio = 'Temuco';

select * from mydb.rep_datosproveedor;
update mydb.rep_datosproveedor
set Valoracion = 3
where id_proveedor in (10,13);


SELECT * FROM rep_solicitudservicio
INNER JOIN rep_datosusuario ON rep_solicitudservicio.Indice_Usuario = rep_datosusuario.Id_Usuario
WHERE rep_solicitudservicio.Indice_Solicitud = 38;