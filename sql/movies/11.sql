select m.title
from movies m,
     stars s,
     people p,
     ratings r
where m.id = s.movie_id
  and s.person_id = p.id
  and m.id = r.movie_id
  and p.name = 'Chadwick Boseman'
order by r.rating desc
limit 5;