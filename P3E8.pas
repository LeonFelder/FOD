program P3E8;
Type
	str15 = string[15];
	distribucion = record
		nom: str15;
		ano: integer;
		num: integer;
		cant: integer;
		desc: string;
	end;
	archivo = file of distribucion;
function ExisteDistribucion (var arch: archivo; nom: str15): boolean;
var
	dis: distribucion;
begin
	reset(arch);
	read(arch,dis);
	while((not eof(arch)) and (nom <> dis.nom))do
		read(arch,dis);
	close(arch);
	ExisteDistribucion:= nom = dis.nom;
end;
procedure AltaDistribucion (var arch: archivo);
var
	dis,cab: distribucion;
begin
	write('Ingrese ');
	read(dis.nom);
	if (ExisteDistribucion(arch,dis.nom)) then
		writeln('Ya existe la distribucion')
	else begin
		write('Ingrese ');
		read(dis.ano);
		write('Ingrese ');
		read(dis.num);
		write('Ingrese ');
		read(dis.cant);
		write('Ingrese ');
		read(dis.desc);
		reset(arch);
		read(arch,cab);
		if (cab.cant = 0) then begin
			seek(arch,filesize(arch));
			write(arch,dis);
		end
		else begin
			seek(arch,cab.cant*(-1));
			read(arch,cab);
			seek(arch,filepos(arch)-1);
			write(arch,dis);
			seek(arch,0);
			write(arch,cab);
		end;
		close(arch);
	end;
end;
procedure BajaDistribucion (var arch: archivo);
var
	dis,cab: distribucion; 
	nom: str15;
	pos: integer;
begin
	write('Ingrese ');
	read(nom);
	if ( not ExisteDistribucion(arch,nom)) then
		writeln('Distribucion no existente')
	else begin
		reset(arch);
		read(arch,cab);
		pos:= 1;
		repeat
			read(arch,dis);
			pos:= pos + 1
		until(dis.nom = nom);
		seek(arch,filepos(arch)-1);
		write(arch,cab);
		seek(arch,0);
		cab.cant:= pos * (-1);
		write(arch,cab);
		close(arch);
	end;
end;
BEGIN
	
	
END.

