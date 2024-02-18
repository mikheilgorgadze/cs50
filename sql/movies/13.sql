select distinct pe.name
from movies m,
     stars s,
     people pe
where s.movie_id = m.id
  and s.person_id = pe.id
  and m.id in (select m.id
               from movies m,
                    stars s,
                    people p
               where s.movie_id = m.id
                 and s.person_id = p.id
                 and p.name = 'Kevin Bacon'
                 and p.birth = 1958)
  and pe.id not in (select t.id
                    from people t
                    where t.name = 'Kevin Bacon'
                      and t.birth = 1958)