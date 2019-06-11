create table logConsulta(
	idLogConsulta serial,
	dataLogConsulta date,
	horaLogConsulta time,
	codigoDaConsulta integer, 
	usuario varchar(100),
	tipo varchar(100)
);

create or replace function  logConsulta()
	returns trigger as $logConsulta$
begin
	
	if TG_OP = 'INSERT' then
		if NEW.datacons is not null and NEW.hora is not null and NEW.idConsulta is not null then

			insert into logConsulta select 1, NEW.datacons, NEW.hora, NEW.idConsulta, CURRENT_USER, 'insert';
			return NEW;
		end if;
	elsif TG_OP = 'UPDATE' then
		if NEW.datacons is not null and NEW.hora is not null and NEW.idConsulta is not null then

			insert into logConsulta select 1, OLD.datacons, OLD.hora, OLD.idConsulta, CURRENT_USER, 'update';	
			insert into logConsulta select 1, NEW.datacons, NEW.hora, NEW.idConsulta, CURRENT_USER, 'update';
			return NEW;
		end if;
	elsif TG_OP = 'DELETE' then
		insert into logConsulta select 1, OLD.datacons, OLD.hora, OLD.idConsulta, CURRENT_USER, 'delete';
		return OLD;
	else  
		return NULL; 
	end if;
end 
$logConsulta$ language plpgsql;


create trigger logConsulta 
	before insert or update or delete
	on Consulta
	for each row execute procedure logConsulta();


insert into Consulta (idanimal, idpessoa, hora, datacons, obs, idConsulta)
	values (2, 1, '12:00:00', '2019-06-11', null, 7);

update Consulta
	set hora='12:30:00'
	where idConsulta=7;

delete from Consulta
	where idConsulta=7;
