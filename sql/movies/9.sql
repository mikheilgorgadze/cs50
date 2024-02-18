select d.name
from (select distinct p.id, p.name, p.birth
      from movies m
               left join stars s on m.id = s.movie_id
               join people p on p.id = s.person_id
      where m.year = 2004) d
order by d.birth;
