select bradley.title
from (select m.id, m.title
      from movies m,
           stars s,
           people p
      where m.id = s.movie_id
        and s.person_id = p.id
        and p.name = 'Jennifer Lawrence') jennifer,
     (select m.id, m.title
      from movies m,
           stars s,
           people p
      where m.id = s.movie_id
        and s.person_id = p.id
        and p.name = 'Bradley Cooper') bradley
where jennifer.id = bradley.id;