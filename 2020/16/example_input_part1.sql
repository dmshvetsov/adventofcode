-- Query to insert input data

drop table if exists day16_validators;
create table if not exists day16_validators (
  field_name varchar(40),
  range_l int4range not null,
  range_r int4range not null
);

drop table if exists day16_tickets;
create table if not exists day16_tickets (
  line serial primary key,
  data integer[]
);

begin;

insert
  into day16_validators
  values
    ('class', '[1,3]', '[5,7]'),
    ('row', '[6,11]', '[33,44]'),
    ('seat', '[13,40]', '[45,50]')
;

insert
  into day16_tickets
    (data)
  values
    (array [7,1,14]),
    (array [7,3,47]),
    (array [40,4,50]),
    (array [55,2,20]),
    (array [38,6,12])
;

commit;
