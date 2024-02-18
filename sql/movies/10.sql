select s.name
from (select distinct p.id, p.name
      from people p
               join directors d on d.person_id = p.id
               join movies m on m.id = d.movie_id
               join ratings r on r.movie_id = m.id
      where r.rating >= 9.0) s
