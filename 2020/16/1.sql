-- day16 part1

with without_mine_ticket as (
  select *
  from day16_tickets
  offset 1
)

select sum(invalid_nums.num) from (
  select
    num
    from (
      select
        line,
        ticket,idx as idx,
        ticket.num as num,
        range_r,
        range_l
        from
          without_mine_ticket, unnest(data) with ordinality ticket(num, idx)
          cross join day16_validators) as perm
    where
      (num <@ range_l) = false and (num <@ range_r) = false
    group by
      line,
      idx,
      num
    having
      count(line) = (select count(*) from day16_validators)
  ) as invalid_nums
;
