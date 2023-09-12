--1. Liste des potions : NumÃ©ro, libellÃ©, formule et constituant principal. (5 lignes)
select * from potion;

--2. Liste des noms des trophÃ©es rapportant 3 points. (2 lignes)
select nom_categ from categorie where nb_points = 3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select nom_village from village where nb_huttes > 35;

--4. Liste des trophÃ©es (numÃ©ros) pris en mai / juin 52. (4 lignes)
select num_trophee  from trophee where date_prise between '2052-05-01' and '2052-06-30';

--5. Noms des habitants commenÃ§ant par 'a' et contenant la lettre 'r'. (3 lignes)
select nom from habitant where nom like 'A%r%';

--6. NumÃ©ros des habitants ayant bu les potions numÃ©ros 1, 3 ou 4. (8 lignes)
select distinct num_hab from absorber where num_potion in (1,3,4);

--7. Liste des trophÃ©es : numÃ©ro, date de prise, nom de la catÃ©gorie et nom du preneur. (10lignes)
select t.num_trophee, t.date_prise, c.nom_categ, h.nom 
from trophee t 
inner join categorie c on c.code_cat=t.code_cat 
inner join habitant h on t.num_preneur=h.num_hab ;

--8. Nom des habitants qui habitent Ã  Aquilona. (7 lignes)
select h.nom from habitant h 
inner join village v on h.num_village = v.num_village 
where v.nom_village ='Aquilona';

--9. Nom des habitants ayant pris des trophÃ©es de catÃ©gorie Bouclier de LÃ©gat. (2 lignes)
select h.nom from habitant h  
inner join trophee t on t.num_preneur = h.num_hab 
inner join categorie c on t.code_cat = c.code_cat 
where c.nom_categ = 'Bouclier de LÃ©gat';

--10. Liste des potions (libellÃ©s) fabriquÃ©es par Panoramix : libellÃ©, formule et constituantprincipal. (3 lignes)
select p.lib_potion, p.formule, p.constituant_principal from potion p 
inner join fabriquer f on p.num_potion = f.num_potion 
inner join habitant h on f.num_hab  = h.num_hab
where h.nom = 'Panoramix';

--11. Liste des potions (libellÃ©s) absorbÃ©es par HomÃ©opatix. (2 lignes)
select distinct p.lib_potion from potion p 
inner join absorber a on a.num_potion = p.num_potion 
inner join habitant h on a.num_hab  = h.num_hab
where h.nom = 'HomÃ©opatix';

--12. Liste des habitants (noms) ayant absorbÃ© une potion fabriquÃ©e par l'habitant numÃ©ro 3. (4 lignes)
select distinct h.nom from habitant h
inner join absorber a on h.num_hab = a.num_hab
inner join fabriquer f on a.num_potion = f.num_potion  
where f.num_hab = 3;

--13. Liste des habitants (noms) ayant absorbÃ© une potion fabriquÃ©e par AmnÃ©six. (7 lignes)
select distinct h.nom from habitant h
inner join absorber a on h.num_hab = a.num_hab
inner join fabriquer f on a.num_potion = f.num_potion  
inner join habitant h2 on h2.num_hab = f.num_hab  
where h2.nom = 'AmnÃ©six';

--14. Nom des habitants dont la qualitÃ© n'est pas renseignÃ©e. (2 lignes)
select h.nom from habitant h where h.num_qualite is null ; 

--15. Nom des habitants ayant consommÃ© la Potion magique nÂ°1 (c'est le libellÃ© de lapotion) en fÃ©vrier 52. (3 lignes)
select h.nom from habitant h 
inner join absorber a on h.num_hab = a.num_hab  
inner join potion p on a.num_potion = p.num_potion
where p.lib_potion = 'Potion magique nÂ°1'
and a.date_a between '2052-02-01' and '2052-02-29';

--16. Nom et Ã¢ge des habitants par ordre alphabÃ©tique. (22 lignes)
select h.nom, h.age from habitant h order by h.nom ;

--17. Liste des resserres classÃ©es de la plus grande Ã  la plus petite : nom de resserre et nom du village. (3 lignes)
select r.nom_resserre, v.nom_village from resserre r
inner join village v on v.num_village = r.num_village 
order by r.superficie desc ; 

--18. Nombre d'habitants du village numÃ©ro 5. (4)
select count(*) from habitant h where h.num_village = 5; 

--19. Nombre de points gagnÃ©s par Goudurix. (5)
select sum(c.nb_points)  from categorie c 
inner join trophee t on c.code_cat = t.code_cat 
inner join habitant h on h.num_hab = t.num_preneur 
where h.nom = 'Goudurix';

--20. Date de premiÃ¨re prise de trophÃ©e. (03/04/52)
select min(t.date_prise) from trophee t ; 

--21. Nombre de louches de Potion magique nÂ°2 (c'est le libellÃ© de la potion) absorbÃ©es. (19)
select sum(a.quantite) from potion p 
inner join absorber a on p.num_potion = a.num_potion 
where p.lib_potion = 'Potion magique nÂ°2';

--22. Superficie la plus grande. (895)
select max(r.superficie) from resserre r;

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select v.nom_village, count(*)
from village v
inner join habitant h on v.num_village = h.num_village
group by v.nom_village ;

--24. Nombre de trophÃ©es par habitant (6 lignes)
select h.nom, count(*) from habitant h
inner join trophee t on t.num_preneur = h.num_hab 
group by h.num_hab ;

--25. Moyenne d'Ã¢ge des habitants par province (nom de province, calcul). (3 lignes)
select p.nom_province, avg(h.age) from province p 
inner join village v on p.num_province = v.num_province 
inner join habitant h on v.num_village = h.num_village 
group by p.num_province ;

--26. Nombre de potions diffÃ©rentes absorbÃ©es par chaque habitant (nom et nombre). (9lignes)
select h.nom, count(distinct a.num_potion) from habitant h 
inner join absorber a on h.num_hab = a.num_hab
group by h.num_hab 

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select h.nom from habitant h 
inner join absorber a on a.num_hab = h.num_hab
inner join potion p on a.num_potion = p.num_potion 
where p.lib_potion = 'Potion Zen' and a.quantite > 2;

--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select v.nom_village from village v
inner join resserre r on r.num_village = v.num_village ;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select v.nom_village from village v
order by v.nb_huttes desc limit 1;

--30. Noms des habitants ayant pris plus de trophÃ©es qu'ObÃ©lix (3 lignes)
select h.nom from habitant h 
inner join trophee t on t.num_preneur = h.num_hab 
group by h.nom 
having count(t.num_trophee) > (select count(*) from habitant h2 
inner join trophee t2 on t2.num_preneur = h2.num_hab 
where h2.nom = 'Obelix')