use muestreos;
select * from pescado;

use muestreos;
select count(*) from pescado where  ((pescado.gonada_id<>1) and (pescado.gonada_id<>6));


use muestreos;
select count(*) from pescado where  ((pescado.gonada_id<>6));


#cuenta de pescados por gonada
use muestreos;
 select  count(*),p.gonada_id,g.descripcion from pescado as p  
 left join gonada as g on g.id=p.gonada_id group by p.gonada_id;

#inicio tabla
use muestreos;
select p.id as numero,p.pesogonada,p.peso,p.altura,p.largo,s.descripcion as sexo,g.descripcion as gonada
from pescado as p 
Left join (sexo as s,gonada as g) on
(p.sexo_id=s.id and p.gonada_id=g.id);

use muestreos;
select distinct p.especie from pescado as p union #no va union
(select count(*) from pesca as pe left join pescado as p1 
on (pe.id=p1.pesca_id) 
where pe.fecha between 03/1/2017 and 03/01/2010 );

#total por especie
use muestreos;
select count( p.especie) as total,p.especie from pescado as p 
inner join 
group by p.especie order by total desc;




#total de pescas por localidad
select loc.iniciales,count(loc.iniciales) from pesca as p  left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) group by loc.iniciales;

#coeficiente!!!!!
select loc.iniciales,count(distinct(horainicio)),count(distinct(red_id)),count(distinct(horainicio))*count(distinct(red_id)) from pesca as p  left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) where (idcampaña=2 and iniciales="pgo" and artescomp != "Artes Complementarias");

select  distinct red_id from pesca as p  inner join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) where (idcampaña= and iniciales="itu" and artescomp != "Artes Complementarias" ) ;

select  count(distinct red_id) from pesca as p  inner join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) where (idcampaña=1 and iniciales="itu" and artescomp != "Artes Complementarias" ) ;


#total pescados por loc
select loc.iniciales,count(distinct camp.id),count(pescado.id) from pesca as p inner join (`campaña-localidad` as camp, localidad as loc,pescado) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pescado.pesca_id=p.id) group by loc.iniciales;




select count(*) from `campaña-localidad`;
select * from localidad where idlocalidad=1;

#total especie localidad mal
select count( pescado.especie) as total,pescado.especie, loc.iniciales,count(distinct camp.id),count(pescado.id) from pesca as p  left join (`campaña-localidad` as camp, localidad as loc,pescado) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pescado.pesca_id=p.id) group by pescado.especie order by loc.iniciales;

#pesca de itu por especies no anda el contador
select count(esp.descripcion) as total,p.especie_id ,esp.descripcion from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
group by p.especie_id order by total desc;

#toatl, id esp y especie por loc
select count(esp.descripcion) as total,p.especie_id ,esp.descripcion from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
group by p.especie_id order by total desc;

select esp.id as id,count(esp.descripcion) as total from pescado as p inner join especie as esp
on (p.especie_id=esp.id); 

#id y totales por especie con total general
(select esp.id as id,count(esp.descripcion) as total from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
 group by p.especie_id order by total desc)
 union all; (select "",count(*) from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=1);

#agraga suma total p/ uno
#union all 
(select "",count(*) from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=1);


#totales por loc
select distinct "", final1.fin1,final2.fin2,final3.fin3,final4.fin4 from pescado right join((select "",count(*) as fin1 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=1)as final1,(select "",count(*) as fin2 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=2)as final2,(select "",count(*) as fin3 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=3)as final3,(select "",count(*) as fin4 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=4)as final4) on (1=1) ;


select "",count(*) as fin1 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=1;


#especie y contador para 1 loc
select es.descripcion, (select ifnull(tabla1.total,0)) from especie as es  left join(
(select esp.id as id,count(esp.descripcion) as total from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
 group by p.especie_id order by total desc) as tabla1
 )  on(es.id=tabla1.id) ;


use muestreos;

( select  es.descripcion, (select ifnull(tabla1.total,0)),(select ifnull(tabla2.total,0)),(select ifnull(tabla3.total,0)),(select ifnull(tabla4.total,0)),
(select ifnull(tablafin.total,0)) as tablafinal  from especie as es  left join(
(select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
 group by p.especie_id order by total desc) as tabla1,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=2
 group by p.especie_id order by total desc) as tabla2,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=3
 group by p.especie_id order by total desc) as tabla3,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=4
 group by p.especie_id order by total desc) as tabla4,(select esp.id as id,count(esp.descripcion) as total from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
 group by p.especie_id order by total desc) as tablafin)  
 on(es.id=tabla1.id and es.id=tabla2.id and es.id=tabla3.id and es.id=tabla4.id and es.id=tablafin.id ) 
 #where tablafin.total>0
 order by tablafinal desc )  ;
 ) limit 700 ;




select esp.id as id,count(esp.descripcion) as total from  especie as esp
  join (pesca, `campaña-localidad` as camp, localidad as loc,pescado as p )
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=2
 group by p.especie_id  
 union  select distinct esp.id as id,0 as total from  especie as esp
  join (pesca, `campaña-localidad` as camp, localidad as loc,pescado as p )
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where esp.id not in(select esp.id as id from  especie as esp
  join (pesca, `campaña-localidad` as camp, localidad as loc,pescado as p )
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=2) ;
 
 select especie.descripcion, count(especie. descripcion) from especie	join pescado
 on (pescado.especie_id=especie.id) where especie.descripcion like "Crenic%" group by especie.descripcion;
 

#tabla final
( select  es.descripcion, (select ifnull(tabla1.total,0)),(select ifnull(tabla2.total,0)),(select ifnull(tabla3.total,0)),(select ifnull(tabla4.total,0)),
(select ifnull(tablafin.total,0)) as tablafinal  from especie as es  right join(
(select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=1
 group by p.especie_id order by total desc) as tabla1,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=2
 group by p.especie_id order by total desc) as tabla2,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=3
 group by p.especie_id order by total desc) as tabla3,
 (select esp.id as id,count(esp.descripcion) as total from pescado as p 
left join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
where loc.idlocalidad=4
 group by p.especie_id order by total desc) as tabla4,(select esp.id as id,count(esp.descripcion) as total from pescado as p 
inner join (pesca, `campaña-localidad` as camp, localidad as loc, especie as esp)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and p.especie_id=esp.id)
 group by p.especie_id order by total desc) as tablafin)  
 on(es.id=tabla1.id and es.id=tabla2.id and es.id=tabla3.id and es.id=tabla4.id and es.id=tablafin.id ) 
 #where tablafin.total>0
 order by tablafinal desc )  
 

 union  (select distinct "", final1.fin1, final2.fin2, final3.fin3, final4.fin4, final11.fin11 from pescado right join((select "",count(*) as fin1 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=1)as final1,(select "",count(*) as fin2 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=2)as final2,(select "",count(*) as fin3 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=3)as final3,(select "",count(*) as fin4 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where loc.idlocalidad=4)as final4,(select "",count(*) as fin11 from pescado as p inner join (pesca, `campaña-localidad` as camp, localidad as loc)
on (p.pesca_id=pesca.id and pesca.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
)as final11)  on(1=1)) order by tablafinal desc;




#camnias
select distinct cam.idcampaña  from campaña as cam left join(localidad as loc, pesca as p, pescado as pez,`campaña-localidad` as camploc)
on (camploc.idcampaña=cam.idcampaña and camploc.id_acta=cam.acta_id and camploc.localidad_id=loc.idlocalidad
and p.`campaña-localidad_id`=camploc.id and pez.pesca_id=p.id)


where año=2015; 


select distinct cam.idcampaña, count(pez.id) from campaña as cam left join(localidad as loc, pesca as p, pescado as pez,`campaña-localidad` as camploc)
on (camploc.idcampaña=cam.idcampaña and camploc.id_acta=cam.acta_id and camploc.localidad_id=loc.idlocalidad
and p.`campaña-localidad_id`=camploc.id and pez.pesca_id=p.id)


where año=2015 and p.artescomp like 'bat%' and loc.idlocalidad=1; 


select * from `campaña-localidad` as camploc left join `campaña` as camp on (camploc.idcampaña=camp.idcampaña and camploc.id_acta=camp.acta_id)
 where ((camploc.idcampaña=2) and (camp.mes=3));

select * from pescado as p left join pesca, `campaña-localidad` as camploc on 
(p.`campaña-localidad-id`) ;









############################################################################################3

#############################################################################################

select camp.idcampaña,count(pescado.id) from pesca as p inner join (`campaña-localidad` as camp, localidad as loc,pescado) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pescado.pesca_id=p.id) where(camp.id_acta=1 and loc.idlocalidad=1) group by camp.idcampaña;

#test previos a proced almacenado
select * from pesca;
select * from pesca where id =1;
select (((pesca.horafin*60)+pesca.minfin)-((pesca.horainicio*60)+pesca.mininicio))/60 from pesca where id =1;
select pesca.horafin-pesca.horainicio from pesca where id =1;



#procedimiento para calcular duracion del lance
#falta agregar un id
DROP PROCEDURE IF EXISTS calcularDuracion;
DELIMITER ;;

CREATE PROCEDURE calcularDuracion()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
declare total double default 0;
declare duracion int default 0;
SELECT COUNT(*) FROM pesca INTO n;
SET i=0;
WHILE i<n DO 
  select pesca.horafin-pesca.horainicio from pesca where id =i into duracion;
  IF (duracion >0) THEN
	select (((pesca.horafin*60)+pesca.minfin)-((pesca.horainicio*60)+pesca.mininicio))/60 from pesca where id =i into total;
   else
   select ((((pesca.horafin+24)*60)+pesca.minfin)-((pesca.horainicio*60)+pesca.mininicio))/60 from pesca where id=i into total;
	end if;
    
    update pesca set duracionlance=total where id=i;
  SET i = i + 1;
END WHILE;
End;
;;

DELIMITER ;

call calcularduracion();
##
##Calcular duracion de un lance
##

DROP PROCEDURE IF EXISTS calcularDuracionPesca;
DELIMITER ;;

CREATE PROCEDURE calcularDuracionPesca(idp int)
BEGIN

declare total double default 0;
declare duracion int default 0;

 
  select pesca.horafin-pesca.horainicio from pesca where id =idp into duracion;
  IF (duracion >0) THEN
	select (((pesca.horafin*60)+pesca.minfin)-((pesca.horainicio*60)+pesca.mininicio))/60 from pesca where id =idp into total;
   else
   select ((((pesca.horafin+24)*60)+pesca.minfin)-((pesca.horainicio*60)+pesca.mininicio))/60 from pesca where id=idp into total;
	end if;
    
    update pesca set duracionlance=total where id=idp;
  
End;
;;

DELIMITER ;

call calcularDuracionPesca(1);






##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################

#coeficientes!!!
select loc.iniciales,count(distinct(horainicio)),count(distinct(red_id)),count(distinct(horainicio))*count(distinct(red_id)) from pesca as p  
left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) 
where (idcampaña=2 and iniciales="pgo" and artescomp != "Artes Complementarias");

select loc.iniciales,count(distinct(horainicio)),count(distinct(red_id)),(count(distinct(horainicio)))*(count(distinct(red_id))) from pesca as p  
left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) 
where (idcampaña=2 and iniciales="ita" and artescomp != "Artes Complementarias");


select p.id,idcampaña,iniciales from pesca as p
left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) 
where (red_id !=3 and artescomp != "Artes Complementarias" and idcampaña=1 and iniciales="ita");  


   
update pesca set coeficiente= 54 
where id in(
select p.id from pesca as p
left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad) 
where (red_id !=3 and artescomp != "Artes Complementarias" and idcampaña=1 and iniciales="ita"));

update pesca 
left join (`campaña-localidad` as camp, localidad as loc) 
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad)
where (red_id !=3 and artescomp != "Artes Complementarias" and idcampaña=1 and iniciales="ita")
set coeficiente=53;
 select * from pesca;
update pesca 
set coeficiente=54 where id in(
select id from (select * from pesca) as asd where `campaña-localidad_id`=
(select id from `campaña-localidad`
where ( idcampaña=1 and localidad_id=1 and artescomp != "Artes Complementarias")));

##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##promedio de lst

select e.descripcion,avg( p.largo) as total from pescado as p 
inner join  (especie as e,`campaña-localidad` as c) 
on(p.especie_id=e.id and `campaña-localidad_id`=c.id)
where(p.largo is not null and c.idcampaña=12 and e.id=91)
group by e.descripcion order by total desc;

#proc almacenado
select count(distinct(especie_id)) from pescado inner join  (especie as e,`campaña-localidad` as c)
on (`campaña-localidad_id`=c.id)
where c.idcampaña=12;
group by especie_id;

select ((especie_id)) from pescado inner join  (especie as e,`campaña-localidad` as c)
on (`campaña-localidad_id`=c.id)
where c.idcampaña=12
group by especie_id;

select p.largo from pescado as p inner join  (especie as e,`campaña-localidad` as c) where (c.idcampaña=12 and e.id=1);

select avg( p.peso) as pesototal from pescado as p 
				inner join  (especie as e,`campaña-localidad` as c) 
				on(p.especie_id=e.id and `campaña-localidad_id`=c.id)
				where(p.peso is not null and c.idcampaña=12 and e.id=1);

##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################

##Actualiza peso y lago promedio
DROP PROCEDURE IF EXISTS calcularLargoProm;
DELIMITER ;;

CREATE PROCEDURE calcularLargoProm()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE m INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE j INT DEFAULT 0;
declare alttotal double default 0;
declare pesototal double default 0;
declare altura double default 0;
declare peso double default 0;
SELECT COUNT(*) FROM campaña INTO n;
select count(*) from especie into m;

SET i=0;
WHILE i<n DO 
  #select count(distinct(especie_id)) from pescado inner join  (especie as e,`campaña-localidad` as c)
#	on (`campaña-localidad_id`=c.id)
#	where c.idcampaña=i INTO m;
	
    set j=0;
    while j<m do
		if (j in (select (especie_id) from pescado as p inner join  (especie as e,`campaña-localidad` as c,pesca as pe)
			on (p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id) where c.idcampaña=i group by especie_id)) then
            
				select avg( p.largo) as alttotal from pescado as p 
				inner join  (especie as e,`campaña-localidad` as c,pesca as pe) 
				on(p.especie_id=e.id and p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id)
				where(p.largo is not null and c.idcampaña=i and e.id=j) INTO alttotal;
				
                select avg( p.peso) as pesototal from pescado as p 
				inner join  (especie as e,`campaña-localidad` as c,pesca as pe) 
				on(p.especie_id=e.id and p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id)
				where(p.peso is not null and c.idcampaña=i and e.id=j) INTO pesototal;
                
				update pescado as p join (`campaña-localidad` as c,pesca as pe)
                on p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id
                set largoest=alttotal
                where (c.idcampaña=i and p.especie_id=j and p.largo=null);
                
                update pescado as p join (`campaña-localidad` as c,pesca as pe)
                on p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id
                set  pesoest=pesototal
                where (c.idcampaña=i and p.especie_id=j and p.peso=null);
                
                update pescado as p join (`campaña-localidad` as c,pesca as pe)
                on p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id
                set largoest= p.largo
                where (c.idcampaña=i and p.especie_id=j and p.largo is not null);
                
                update pescado as p join (`campaña-localidad` as c,pesca as pe)
                on p.pesca_id=pe.id and pe.`campaña-localidad_id`=c.id
                set  pesoest= p.peso
                where (c.idcampaña=i and p.especie_id=j and p.peso is not null);
        
        end if;
		set j=j+1;
    end while;
        
  SET i = i + 1;
END WHILE;
End;
;;

DELIMITER ;

call calcularLargoProm();


##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################

#totales por campana



(select count(*),idcampaña from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
		where ( artescomp = "Artes Complementarias" and iniciales="abr")
		group by idcampaña) ;
 
 select distinct( camp.idcampaña),count(*) as suma, sum(peso) as peso,artescomp.total,artescomp.pesocomp from pesca as p
		left join (`campaña-localidad` as camp, localidad as loc, pescado as pe,
				(select count(*) as total,idcampaña,sum(peso) as pesocomp from pesca as p 
                left join (`campaña-localidad` as camp, localidad as loc, pescado as pe) 
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
				where ( artescomp = "Artes Complementarias" and iniciales="abr")
				) as artescomp)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and artescomp.idcampaña=camp.idcampaña) 
		where ( artescomp != "Artes Complementarias" and iniciales="abr")
		 ;
         
         
         
##########################################################################################################################################
##########################################################################################################################################
########################################################################################################################################## 
 
 
 
 #tabla final  de total pesca y peso por campana por loc
select distinct( camp.idcampaña) as campaña,count(*) as `total redes`, sum(peso) as `peso redes`,artescomp.total `AC`,artescomp.pesocomp as `peso AC` from pescado as pe
left join (`campaña-localidad` as camp, localidad as loc, pesca as p,
		(select count(*) as total,idcampaña,sum(peso) as pesocomp from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
		where ( artescomp = "Artes Complementarias" and iniciales="abr")
		group by camp.idcampaña) as artescomp)
on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and artescomp.idcampaña=camp.idcampaña) 
where ( artescomp != "Artes Complementarias" and iniciales="abr")
group by camp.idcampaña
union all(select "total",count(*) as suma, sum(peso) as peso,artescomp.total,artescomp.pesocomp from pescado as pe
		left join (`campaña-localidad` as camp, localidad as loc, pesca as p,
				(select count(*) as total,idcampaña,sum(peso) as pesocomp from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
				where ( artescomp = "Artes Complementarias" and iniciales="abr")
				) as artescomp)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id ) 
		where ( artescomp != "Artes Complementarias" and iniciales="abr")
		) ;
################################################################################################################################################
##tablas 15 a 18

DELIMITER //

DROP PROCEDURE IF EXISTS totalypesoporloc //

CREATE PROCEDURE   totalypesoporloc( loc int,acta int )
	BEGIN  
		   select distinct( camp.idcampaña) as campaña,count(*) as `total redes`, sum(peso) as `peso redes`,artescomp.total `AC`,artescomp.pesocomp as `peso AC` from pescado as pe
		left join (`campaña-localidad` as camp, localidad as loc, pesca as p,
				(select count(*) as total,idcampaña,sum(peso) as pesocomp from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
				where ( artescomp = "Artes Complementarias" and localidad_id=loc  and id_acta=acta)
				group by camp.idcampaña) as artescomp)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and artescomp.idcampaña=camp.idcampaña) 
		where ( artescomp != "Artes Complementarias" and localidad_id=loc)
		group by camp.idcampaña
		union all(select "total",count(*) as suma, sum(peso) as peso,artescomp.total,artescomp.pesocomp from pescado as pe
				left join (`campaña-localidad` as camp, localidad as loc, pesca as p,
						(select count(*) as total,idcampaña,sum(peso) as pesocomp from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
						on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
						where ( artescomp = "Artes Complementarias" and localidad_id=loc and id_acta=acta)
						) as artescomp)
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id ) 
				where ( artescomp != "Artes Complementarias" and localidad_id=loc and id_acta=acta)
				) 
		union all(select "promedio",count(*)/12 as suma, sum(peso)/12 as peso,artescomp.total/12,artescomp.pesocomp/12 from pescado as pe
				left join (`campaña-localidad` as camp, localidad as loc, pesca as p,
						(select count(*) as total,idcampaña,sum(peso) as pesocomp from pescado as pe left join (`campaña-localidad` as camp, localidad as loc, pesca as p) 
						on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id) 
						where ( artescomp = "Artes Complementarias" and localidad_id=loc and id_acta=acta)
						) as artescomp)
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id ) 
				where ( artescomp != "Artes Complementarias" and localidad_id=loc and id_acta=acta)
				) ;
	END 
//

DELIMITER ;

call totalypesoporloc(1,1);


#########################################################################################################################################################

#figura 5 g total por loc y cpue
# 8,148637106 ita camp 1
#1/tamano*100/duracion*8/coeficiente

DELIMITER //

DROP PROCEDURE IF EXISTS sumcpueloc //

CREATE PROCEDURE   sumcpueloc( loca int,acta int )
	BEGIN  

 select distinct( camp.idcampaña),count(*) as suma,sum(1/tamaño*100/duracionlance*8/p.coeficiente) as cpue,
	sum(pesoest/tamaño*100/duracionlance*8/p.coeficiente) as `cpue g` from pesca as p
		left join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id) 
		where (  idlocalidad=loca and id_acta=acta)
        group by camp.idcampaña
		 ;
	END 
//

DELIMITER ;
call sumcpueloc(1,1);

########################################################################################################################################################

#especies por loc divido por campan dividido por cantidad y cpue
 
  select distinct( e.descripcion), ifnull(sum(1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue
	 from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  iniciales="itu" and camp.idcampaña=1 )
        group by pe.especie_id
        order by e.descripcion asc;
        
        select count(*) from `campaña-localidad` where (localidad_id=1);
        select idcampaña from `campaña-localidad` where (localidad_id=1);
  DELIMITER //

DROP PROCEDURE IF EXISTS cpueEspecies //

CREATE PROCEDURE  cpueEspecies( loc int,camp int,acta int)
	BEGIN  
		select distinct( e.descripcion), ifnull(sum(1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue
	 from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  localidad_id=loc and camp.idcampaña=camp and id_acta=acta )
        group by pe.especie_id
        having cpue>0
        order by e.descripcion asc;
	END 
//

DELIMITER ;

call cpueEspecies(1,2,1);


     
     
 #lo mismo con cpueg     
        select distinct( e.descripcion), ifnull(sum(1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue,
	ifnull(round(sum(pesoest/tamaño*100/duracionlance*8/p.coeficiente)),0) as `cpue g` from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  iniciales="itu" and camp.idcampaña=1 )
        group by pe.especie_id
        order by e.descripcion asc;
   
   
 
   
SELECT GROUP_CONCAT(DISTINCT idcampaña) AS  column_list FROM  (select idcampaña from `campaña-localidad` group by idcampaña order by idcampaña) as a1;
#########################################
###############################################################################33



#ANDA!!!!!
 #  total cpue por especie  por camp
 #tabla 19 a 22
 #agregar id localidad 
   ########################
   
   
   SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(IF(camp = ',
      camp,
      ', cpue, 0)) as "',camp,'"'
      
    )
  ) INTO @sql
FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

   
SET @sql = CONCAT('SELECT esp, ', @sql, ', round(sum(cpue),8) as total,round(sum(cpue),8)/12 as promedio FROM (select  ( e.descripcion) as esp, ifnull((1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue, camp.idcampaña as camp,
	ifnull(round((pesoest/tamaño*100/duracionlance*8/p.coeficiente)),0) as `cpue g` from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  iniciales="itu"  )
        order by e.descripcion asc)as asd GROUP BY esp');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
select @sql;



  DELIMITER //

DROP PROCEDURE IF EXISTS cuboCpueEspecies //

CREATE PROCEDURE  cuboCpueEspecies(p_loc int,p_cpue text)
	BEGIN  
    
      
   
   SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(IF(camp = ',
      camp,
      ',', p_cpue,', 0)) as "',camp,'"'
      
    )
  ) INTO @sql
	FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

	   
	SET @sql = CONCAT('SELECT esp, ', @sql, ', round(sum(cpue),8) as total,round(sum(cpue),8)/12 as promedio FROM (select  ( e.descripcion) as esp, ifnull((1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue, camp.idcampaña as camp,
		ifnull(round((pesoest/tamaño*100/duracionlance*8/p.coeficiente),4),0) as `cpueg` from pesca as p
			join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
			on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
			right join (especie as e)
			on (e.id=pe.especie_id)
			where (  localidad_id=',p_loc,' )
			order by e.descripcion asc)as asd GROUP BY esp');

	PREPARE stmt FROM @sql;
	EXECUTE stmt;
    
    	END 
//

DELIMITER ;

call cuboCpueEspecies(1,'cpueg');
call cuboCpueEspecies(1,'cpue');
#########################################################################

#######################################################################

		select  ifnull(sum(1/tamaño*100/duracionlance*8/p.coeficiente),0) as cpue,pe.sexo_id,count(*)
		from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        where (  localidad_id=1 and pe.sexo_id =1 and largoest between 100 and 174)
       # group by pe.largoest
        #order by pe.largoest asc;
        ;
        (select "<100" as 'lst cpue'  union select "100-174" union select "175-249" union select "250-324" union select "325-399" 
		union select "400-474" 	union select "475-550" union select ">550") as lstcpue;


#############################################3
#cpue por rango

#fig 19

##############################################
select   case    
			when largoest < 100 then ' 0-100'  
			when largoest between 100 and 174 then ' 100-174'  
			when largoest between 175 and 249 then ' 175-249'  
			when largoest between 250 and 324 then ' 250-324'  
			when largoest between 325 and 399 then ' 325-399'  
			when largoest between 400 and 474 then ' 400-474'
			when largoest between 475 and 550 then ' 475-550'
			else '>550'   
			 end as rangos ,ifnull(sum(if(pe.sexo_id=1,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as H,
							ifnull(sum(if(pe.sexo_id=2,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as M  
		from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        where ( localidad_id=1 )
        group by rangos
       # order by rangos asc
        union(
select   'total', ifnull(sum(if(pe.sexo_id=1,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as H,
							ifnull(sum(if(pe.sexo_id=2,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as M  
		from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        where ( localidad_id=1 ));
 
 
 DELIMITER //

DROP PROCEDURE IF EXISTS rangocpuelst //

CREATE PROCEDURE  rangocpuelst(p_loc int)
	BEGIN  
     
     select   case    
			when largoest < 100 then ' 0-100'  
			when largoest between 100 and 174 then ' 100-174'  
			when largoest between 175 and 249 then ' 175-249'  
			when largoest between 250 and 324 then ' 250-324'  
			when largoest between 325 and 399 then ' 325-399'  
			when largoest between 400 and 474 then ' 400-474'
			when largoest between 475 and 550 then ' 475-550'
			else '>550'   
			 end as rangos ,ifnull(sum(if(pe.sexo_id=1,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as H,
							ifnull(sum(if(pe.sexo_id=2,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as M  
		from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
        where ( localidad_id=p_loc )
        group by rangos
       # order by rangos asc
        union(
			select   'total', ifnull(sum(if(pe.sexo_id=1,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as H,
							ifnull(sum(if(pe.sexo_id=2,1/tamaño*100/duracionlance*8/p.coeficiente,0)),0) as M  
				from pesca as p
				join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red)
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id )
				where ( localidad_id=p_loc ));
 

    END 
//

DELIMITER ;	

call rangocpuelst(1);

#############################################3
#relacion long peso
##############################################




###############################################
#edades por sexo
##############################################



#####################################################################################################################
#EDADES por sexo, peso
#####################################################################################################################
select * from especie where descripcion='Prochilodus lineatus'; #SABALO
select * from otolito where lado="I" and edad is not null;



select o.edad,sum(if(sexo_id=1,1,0)) as M,avg(if(sexo_id=1,pe.peso,0)) as 'peso M',sum(if(sexo_id=2,1,0)) as H,avg(if(sexo_id=2,pe.peso,0)) as 'peso F'
  from pescado as pe 
	join otolito as o on(pe.id= pescado_id)
    join `campaña-localidad` as c on (pe.`campaña-localidad_id`=c.id)
    
    
  where pe.especie_id=15 and lado='I' and o.edad is not null and localidad_id=1
  group by o.edad
  
  
;
###############################################
#edades  cantidad y peso
##############################################



select o.edad,count(*) as total,avg(pe.peso) as 'peso prom' from pescado as pe 
	join otolito as o on(pe.id= pescado_id)
    join `campaña-localidad` as c on (pe.`campaña-localidad_id`=c.id)
    
    
  where pe.especie_id=15 and lado='I' and o.edad is not null #and localidad_id=1
  group by o.edad;
  
  
  
  
  
###############################################
#suma especies por sexo 
#tabla 23
##############################################
#hacer proc, agregar id loc
select e.descripcion,sum(if(sexo_id=2,1,0))as H,sum(if(sexo_id=1,1,0)) as M,sum(if(sexo_id=3,1,0)) as x,count(*) as total from pescado as p
join `campaña-localidad` as c on (p.`campaña-localidad_id`=c.id)
join especie as e on p.especie_id=e.id
where localidad_id=1
group by e.descripcion

union select 'total',sum(if(sexo_id=2,1,0))as H,sum(if(sexo_id=1,1,0)) as M,sum(if(sexo_id=3,1,0)) as x,count(*) from pescado as p
join `campaña-localidad` as c on (p.`campaña-localidad_id`=c.id)
where localidad_id=1;
 
 
 DELIMITER //

DROP PROCEDURE IF EXISTS cuentaSexoEsp //

CREATE PROCEDURE  cuentaSexoEsp(p_loc int, acta int)
	BEGIN  
    
		select e.descripcion,sum(if(sexo_id=2,1,0))as H,sum(if(sexo_id=1,1,0)) as M,sum(if(sexo_id=3,1,0)) as x,count(*) as total from pescado as p
		join pesca as pe on p.pesca_id=pe.id
        join `campaña-localidad` as c on (pe.`campaña-localidad_id`=c.id)
		join especie as e on p.especie_id=e.id
		where localidad_id=p_loc and id_acta=acta
		group by e.descripcion

		union select 'total',sum(if(sexo_id=2,1,0))as H,sum(if(sexo_id=1,1,0)) as M,sum(if(sexo_id=3,1,0)) as x,count(*) from pescado as p
        join pesca as pe on p.pesca_id=pe.id
		join `campaña-localidad` as c on (pe.`campaña-localidad_id`=c.id)
		where localidad_id=p_loc and id_acta=acta;
    
    
    
    
    end;
    //
    delimiter ;
   
  call cuentaSexoEsp(3,1) ;
###############################################
#gonada especies por sexo 
##############################################
   
   SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'sum(IF(camp = ',
      camp,
      ', cpue, 0)) as "',camp,'"'
      
    )
  ) INTO @sql
FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

   
SET @sql = CONCAT('SELECT esp,des, ', @sql, ', round(sum(cpue),8) as total FROM (select  ( e.descripcion) as esp,g.descripcion as des, 1 as cpue, camp.idcampaña as camp
	    from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red,gonada as g)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  iniciales="ita" and g.descripcion !="indefinido" ))as asd 
        GROUP BY esp,des
		order by esp,des');

PREPARE stmt FROM @sql;
EXECUTE stmt;




 DELIMITER //

DROP PROCEDURE IF EXISTS cuentaSexoGon //

CREATE PROCEDURE  cuentaSexoGon(p_loc int)
	begin
		   SELECT
		  GROUP_CONCAT(DISTINCT
			CONCAT(
			  'sum(IF(camp = ',
			  camp,
			  ', cpue, 0)) as "',camp,'"'
			  
			)
		  ) INTO @sql
		FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

		   
		SET @sql = CONCAT('SELECT esp,des, ', @sql, ', round(sum(cpue),8) as total FROM (select  ( e.descripcion) as esp,g.descripcion as des, 1 as cpue, camp.idcampaña as camp
				from pesca as p
				join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red,gonada as g)
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
				right join (especie as e)
				on (e.id=pe.especie_id)
				where (  localidad_id=',p_loc,' and g.descripcion !="indefinido" ))as asd 
				GROUP BY esp,des
				order by esp,des');

		PREPARE stmt FROM @sql;
		EXECUTE stmt;


    end;
    //
    delimiter ;

call cuentaSexoGon(1);









select @sql;

####
#prueba sql
####
SELECT esp,des, sum(IF(camp = 1, cpue, 0)) as "1",sum(IF(camp = 2, cpue, 0)) as "2",sum(IF(camp = 3, cpue, 0)) as "3",sum(IF(camp = 4, cpue, 0)) as "4",sum(IF(camp = 5, cpue, 0)) as "5",sum(IF(camp = 6, cpue, 0)) as "6",sum(IF(camp = 7, cpue, 0)) as "7",sum(IF(camp = 8, cpue, 0)) as "8",sum(IF(camp = 9, cpue, 0)) as "9",sum(IF(camp = 10, cpue, 0)) as "10",sum(IF(camp = 11, cpue, 0)) as "11",sum(IF(camp = 12, cpue, 0)) as "12", round(sum(cpue),8) as total 
		FROM (select  g.descripcion as des,( e.descripcion) as esp, 1 as cpue, camp.idcampaña as camp
	    from pesca as p
		join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red, gonada as g)
		on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
        right join (especie as e)
        on (e.id=pe.especie_id)
		where (  iniciales="ita"  ))as asd 
        GROUP BY esp,des
		order by esp,des;
        
#############################################################
#        sin discriminar especie
#############################################################        
 DELIMITER //

DROP PROCEDURE IF EXISTS cuentaGonada //

CREATE PROCEDURE  cuentaGonada(p_loc int)
	begin
		SELECT des, sum(IF(camp = 1, cpue, 0)) as "1",sum(IF(camp = 2, cpue, 0)) as "2",sum(IF(camp = 3, cpue, 0)) as "3",sum(IF(camp = 4, cpue, 0)) as "4",sum(IF(camp = 5, cpue, 0)) as "5",sum(IF(camp = 6, cpue, 0)) as "6",sum(IF(camp = 7, cpue, 0)) as "7",sum(IF(camp = 8, cpue, 0)) as "8",sum(IF(camp = 9, cpue, 0)) as "9",sum(IF(camp = 10, cpue, 0)) as "10",sum(IF(camp = 11, cpue, 0)) as "11",sum(IF(camp = 12, cpue, 0)) as "12", round(sum(cpue),8) as total 
				FROM 
					(select  g.descripcion as des, 1 as cpue, camp.idcampaña as camp
					from pesca as p
					join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red, gonada as g)
					on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
				
					where (  localidad_id=p_loc and g.descripcion !='indefinido' ))as asd 
				GROUP BY des
				order by des;

    end;
    //
    delimiter ;

call cuentaGonada(2);
##################################################################33
  # agregar id,y sexo id este va al proc
 ################################################################## 
    DELIMITER //

DROP PROCEDURE IF EXISTS cuentaGonadaSexo //

CREATE PROCEDURE  cuentaGonadaSexo(p_loc int,p_sexo int)
	begin
    
		   SELECT
		  GROUP_CONCAT(DISTINCT
			CONCAT(
			  'sum(IF(camp = ',
			  camp,
			  ', cpue, 0)) as "',camp,'"'
			  
			)
		  ) INTO @sql
		FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

		   
		SET @sql = CONCAT('SELECT des, ', @sql, ', round(sum(cpue),8) as total FROM (select  g.descripcion as des, 1 as cpue, camp.idcampaña as camp
				from pesca as p
				join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red,gonada as g)
				on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
				where (  localidad_id=',p_loc,' and g.descripcion !="indefinido" and sexo_id=',p_sexo,'))as asd 
				GROUP BY des
				order by des');

		PREPARE stmt FROM @sql;
		EXECUTE stmt;

    end;
    //
    delimiter ;

call cuentaGonadaSexo(2,2);
###############################################
#gonada especies por sexo 
#agregar id y sexo id
##############################################
      DELIMITER //

DROP PROCEDURE IF EXISTS cuentaEspGonada //

CREATE PROCEDURE  cuentaEspGonada(p_loc int,p_sexo int)
	begin
 
	   SELECT
	  GROUP_CONCAT(DISTINCT
		CONCAT(
		  'sum(IF(camp = ',
		  camp,
		  ', cpue, 0)) as "',camp,'"'
		  
		)
	  ) INTO @sql
	FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

	   
	SET @sql = CONCAT('SELECT esp,des, ', @sql, ', round(sum(cpue),8) as total FROM (select  ( e.descripcion) as esp,g.descripcion as des, 1 as cpue, camp.idcampaña as camp
			from pesca as p
			join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red,gonada as g)
			on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
			right join (especie as e)
			on (e.id=pe.especie_id)
			where (  localidad_id=',p_loc,' and g.descripcion !="indefinido" and sexo_id=',p_sexo,'))as asd 
			GROUP BY esp,des
			order by esp,des');

	PREPARE stmt FROM @sql;
	EXECUTE stmt;


   end;
    //
    delimiter ;

call cuentaEspGonada(2,2);



select @sql;

####
#prueba sql
####
###############################################################################################################################
select * from especie where descripcion like 'Prochilodus lineatus';

select * from especie where especie.id in(15,67,28,74,40,13,81,22,47,29,80,89);
select 15,67,28,74,40,13,81,22,47,29,80,89;


SELECT 
    esp, des,
    SUM(IF(camp = 1, cpue, 0)) AS '1',
    SUM(IF(camp = 2, cpue, 0)) AS '2',
    SUM(IF(camp = 3, cpue, 0)) AS '3',
    SUM(IF(camp = 4, cpue, 0)) AS '4',
    SUM(IF(camp = 5, cpue, 0)) AS '5',
    SUM(IF(camp = 6, cpue, 0)) AS '6',
    SUM(IF(camp = 7, cpue, 0)) AS '7',
    SUM(IF(camp = 8, cpue, 0)) AS '8',
    SUM(IF(camp = 9, cpue, 0)) AS '9',
    SUM(IF(camp = 10, cpue, 0)) AS '10',
    SUM(IF(camp = 11, cpue, 0)) AS '11',
    SUM(IF(camp = 12, cpue, 0)) AS '12',
    ROUND(SUM(cpue), 8) AS total
FROM
    (SELECT 
        loc.iniciales AS des,(e.descripcion) AS esp,
            IFNULL(avg(pesogonada / peso * 100 ), 0) AS cpue,
            camp.idcampaña AS camp,
            IFNULL(ROUND((pesogonada / peso * 100 )), 0) AS `cpue g`
    FROM
        pesca AS p
    JOIN (`campaña-localidad` AS camp, localidad AS loc, pescado AS pe, red) ON (p.`campaña-localidad_id` = camp.id
        AND camp.localidad_id = loc.idlocalidad
        AND pe.pesca_id = p.id
        AND red.id = p.red_id)
    RIGHT JOIN (especie AS e) ON (e.id = pe.especie_id)
    WHERE
        (iniciales = 'itu') AND e.id IN (15 , 67, 28, 74, 40, 13, 81, 22, 47, 29, 80, 89) and pe.gonada_id!=5 and pe.gonada_id!=6 and sexo_id=2
    group by e.descripcion,camp ASC) AS asd
GROUP BY esp;

###############################################
#RGS%
##############################################
       DELIMITER //

DROP PROCEDURE IF EXISTS rgsXCien //

CREATE PROCEDURE  rgsXCien(p_loc int)
	begin

		  
		   SELECT
		  GROUP_CONCAT(DISTINCT
			CONCAT(
			  'sum(IF(camp = ',
			  camp,
			  ', rgs, 0)) as "',camp,'"'
			  
			)
		  ) INTO @sql
		FROM ((select idcampaña as camp from `campaña-localidad` group by idcampaña order by idcampaña) as a1);

		   
		SET @sql = CONCAT('SELECT esp,des, ', @sql, ', round(sum(rgs),8) as total FROM (
				select  ( e.descripcion) as esp,loc.iniciales as des, IFNULL(avg(pesogonada / peso * 100 ), 0) as rgs, camp.idcampaña as camp
					from pesca as p
					join (`campaña-localidad` as camp, localidad as loc, pescado as pe, red,gonada as g)
					on (p.`campaña-localidad_id`=camp.id and camp.localidad_id=loc.idlocalidad and pe.pesca_id=p.id and red.id=p.red_id and pe.gonada_id=g.id )
					right join (especie as e)
					on (e.id=pe.especie_id)
					where (  (localidad_id=',p_loc,') AND e.id IN (15 , 67, 28, 74, 40, 13, 81, 22, 47, 29, 80, 89) and pe.gonada_id!=5 and pe.gonada_id!=6 and sexo_id=2)
			group by e.descripcion,camp ASC)as asd 
				GROUP BY esp,des
				order by esp,des');

		PREPARE stmt FROM @sql;
		EXECUTE stmt;


   end;
    //
    delimiter ;

call rgsXCien(1);

select grasa from pescado where grasa="inactivo";

select p.id,count(p.id) from pesca as p 
left join `campaña-localidad` as cl on p.`campaña-localidad_id`=cl.id
left join pescado as pe on p.id=pe.pesca_id
where idcampaña in (1)
