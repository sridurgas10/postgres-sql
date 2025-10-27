--8. Create a trigger that updates the last_update column whenever a film record is modified.


create or replace function mod_Record()
returns trigger
language plpgsql
as $$
begin 
	
	new.last_update=now();
	return new;
end;
$$

DROP TRIGGER if exists new_record on film;

create trigger new_record
before update on film
for each row
execute function mod_Record();

update film set title='leo'
WHERE film_id = 1


select*from film where film_id=1

select*from film_record

--9. that automatically deletes payment records older than 5 years whenever a new payment is inserted.

select*from payment

create table old_record as
select * from payment where false; 


create or replace function new_recordof_payment()
returns trigger
language plpgsql
as $$
begin 
	insert into old_record
    select*from payment
    where payment_date< now() - interval '5 years';

	
     delete from payment
     where payment_date< now() - interval '5 years';

    return new;
end;
$$;

create trigger main_record
after insert on payment
for each row
execute function new_recordof_payment();

insert into payment (payment_id,  customer_id,staff_id,rental_id,amount, payment_date)
values (33400, 348,1,16050,5.00, NOW())

select*from old_record 

--10. Create a trigger that logs film title or description changes into a separate audit table.

--audit table
create table audit_table(
 film_title text,
 description varchar(50)
 )
 
 --function
 create or replace function film_record()
 returns trigger
 language plpgsql
 as $$

 	if (new.title is distinct from old.title)
       or (new.description is distinct from old.description)  then 
      insert into audit_table (film_title,description)
 	 values(new.film_title,new.description);
     return new;
   end if;
 end;
 $$
 
 create trigger record
 after update on film
 for each row
 execute function film_record()
 
 update film set new.title='world' where film_id=1
