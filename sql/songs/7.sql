select avg(s.energy)
from songs s
         join artists a on s.artist_id = a.id
    and a.name = 'Drake';

