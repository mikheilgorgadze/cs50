-- Checking crime scene reports
select *
from crime_scene_reports r
where r.day = 28
  and r.month = 7
  and r.year = 2023
  and r.street = 'Humphrey Street';

-- Checking bakery security logs
select *
from bakery_security_logs l
where l.day = 28
  and l.month = 7
  and l.year = 2023
  and l.hour = 10;

-- Interviews where bakery was mentioned
select *
from interviews i
where i.year = 2023
  and i.day = 28
  and i.month = 7
  and i.transcript like '%bakery%';

-- Bakery security logs of witness license plates
select *
from bakery_security_logs l
where l.license_plate in (select p.license_plate
                          from people p
                          where p.name in (select i.name
                                           from interviews i
                                           where i.year = 2023
                                             and i.day = 28
                                             and i.month = 7
                                             and i.transcript like '%bakery%'));

-- Bakery security logs checking Ruth's info
select *
from bakery_security_logs l
where l.day = 28
  and l.month = 7
  and l.year = 2023
  and l.hour = 10
  and l.minute between 15 - 5 and 15 + 5
  and l.activity = 'exit';

-- Checking atm transactions of possible thief according to Eugene's info
select *
from atm_transactions a
where a.atm_location = 'Leggett Street'
  and a.year = 2023
  and a.month = 7
  and a.day = 28
  and a.transaction_type = 'withdraw';

-- Checking flight os 29 July 2023 out of Fiftyville according to Raymond's info
select da.city
from flights f,
     airports oa,
     airports da
where f.origin_airport_id = oa.id
  and f.destination_airport_id = da.id
  and oa.city = 'Fiftyville'
  and f.year = 2023
  and f.day = 29
  and f.month = 7
order by f.hour, f.minute
limit 1;

-- Checking possible suspect's bank accounts for their names
select p.name, p.license_plate
from bank_accounts ba,
     people p
where ba.person_id = p.id
  and ba.account_number in (select a.account_number
                            from atm_transactions a
                            where a.atm_location = 'Leggett Street'
                              and a.year = 2023
                              and a.month = 7
                              and a.day = 28
                              and a.transaction_type = 'withdraw');
-- Matching possible suspect's license plate numbers to security log's license plate numbers
select p.name, p.license_plate
from bank_accounts ba,
     people p
where ba.person_id = p.id
  and ba.account_number in (select a.account_number
                            from atm_transactions a
                            where a.atm_location = 'Leggett Street'
                              and a.year = 2023
                              and a.month = 7
                              and a.day = 28
                              and a.transaction_type = 'withdraw')
  and p.license_plate in (select l.license_plate
                          from bakery_security_logs l
                          where l.day = 28
                            and l.month = 7
                            and l.year = 2023
                            and l.hour = 10
                            and l.minute between 15 - 5 and 15 + 5
                            and l.activity = 'exit');

-- Checking phone call logs of possible suspects
select cpe.name thief,
       rpe.name accomplice
from phone_calls pc,
     people cpe,
     people rpe
where pc.caller in (select p.phone_number
                    from bank_accounts ba,
                         people p
                    where ba.person_id = p.id
                      and ba.account_number in (select a.account_number
                                                from atm_transactions a
                                                where a.atm_location = 'Leggett Street'
                                                  and a.year = 2023
                                                  and a.month = 7
                                                  and a.day = 28
                                                  and a.transaction_type = 'withdraw')
                      and p.license_plate in (select l.license_plate
                                              from bakery_security_logs l
                                              where l.day = 28
                                                and l.month = 7
                                                and l.year = 2023
                                                and l.hour = 10
                                                and l.minute between 15 - 5 and 15 + 5
                                                and l.activity = 'exit'))
  and pc.year = 2023
  and pc.month = 7
  and pc.day = 28
  and pc.duration < 60
  and pc.caller = cpe.phone_number
  and pc.receiver = rpe.phone_number;