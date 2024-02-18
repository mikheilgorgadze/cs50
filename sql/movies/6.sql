select avg(r.rating)
from movies m
         join ratings r on r.movie_id = m.id
    and m.year = 2012