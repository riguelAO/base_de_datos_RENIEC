create database Reniec;
Use Reniec;

DROP TABLE tcliente;

CREATE TABLE tcliente(

  Coddni varchar(15) not null,
  Nombres varchar(50) NOT NULL,
  ApellidoPaterno varchar(50) NOT NULL,
  ApellidoMaterno varchar(50) NOT NULL,
  Sexo varchar(1)check (Sexo in ('F','M') ) not null,
  FecNacimiento datetime not null,
  Nacionalidad varchar(50) NOT NULL,
  Dirección varchar(80),
  PRIMARY KEY (Coddni)
)

insert into tcliente values ('78153156','Antonio Manuel','Sánchez','Tena','M','04/25/1982','Peruano','CA ROSA CRISOSTOMO 110, EL TAMBO')
insert into tcliente values ('85854020','Ana Cristina','Nadal','Barranco','F','10/12/1990','Peruano','AV. República de Panamá 3385 - San Isidro')


select * from tcliente
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
create procedure spBuscarDNI
@DNI char(8)
as
begin
	if exists (select Coddni from tcliente where Coddni = @DNI)
		select Nombres, ApellidoPaterno, ApellidoMaterno, Sexo, FecNacimiento, Nacionalidad, Dirección from tcliente where Coddni = @DNI
	else 
		select Mensaje = 'No existe datos para el DNI'
end
go

exec spBuscarDNI '23342324'
go

create procedure spListarDNI
as
begin
		select * from tcliente
end

create procedure spAgregarDNI
@Coddni varchar(15),
@Nombres varchar(50),
@ApellidoPaterno varchar(50),
@ApellidoMaterno varchar(50),
@Sexo varchar(1),
@FecNacimiento datetime,
@Nacionalidad varchar(50),
@Dirección varchar(80),
as
begin
	if exists(select Coddni from tcliente where Coddni = @Coddni)
		select Mensaje = 'Usuario ya existente'
	else
		insert into tcliente values (@Coddni,@Nombres,@ApellidoPaterno,@ApellidoMaterno,@Sexo,@FecNacimiento,@Nacionalidad,@Dirección);
end

create procedure spActualizarDNI
@Coddni varchar(15),
@Nombres varchar(50),
@ApellidoPaterno varchar(50),
@ApellidoMaterno varchar(50),
@Sexo varchar(1),
@FecNacimiento datetime,
@Nacionalidad varchar(50),
@Dirección varchar(80)
as
begin
	update tcliente set Nombres=@Nombres, ApellidoPaterno=@ApellidoPaterno, ApellidoMaterno=@ApellidoMaterno, Sexo=@Sexo, FecNacimiento=@FecNacimiento, Nacionalidad=@Nacionalidad, Dirección=@Dirección where Coddni=@Coddni
end

create procedure spEliminarDNI
@Coddni varchar(15)
as
begin
	if exists (select Coddni from tcliente where Coddni = @Coddni)
		delete from tcliente where Coddni = @Coddni 
	else 
		select Mensaje = 'No existe datos para el DNI'
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
exec spAgregarDNI '77162146','Rafael','Gutierrez','Torbisco','M','01/13/1999','Peruano','Av. La cultura 508'