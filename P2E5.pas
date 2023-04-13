program P2E5;
Const
	valor_alto = 9999;
Type
	str20 = string[20];
	nacimiento = record
		part: integer;
		nom: str20;
		ape: str20;
		direcc: string;
		mat: integer;
		nomM: str20;
		apeM: str20;
		DNIM: integer;
		nomP: str20;
		apeP: str20;
		DNIP: integer;
	end;
	fecha = record
		dia: integer;
		mes: str20;
		ano: integer;
		hora: integer;
	end;
	fallecimiento = record
		part: integer;
		nom: str20;
		ape: str20;
		lugar: string;
		mat: integer;
		fech: fecha;
		DNI: integer;
	end;
	todo = record
		nac: nacimiento;
		fallecio: boolean;
		fall: fallecimiento;
	end;
	maestro = file of todo;
	detalle1 = file of nacimiento;
	detalle2 = file of fallecimiento;
	vdetalle1 = array [1..50] of detalle1; 
	vdetalle2 = array [1..50] of detalle2;
	vnacimiento = array [1..50] of nacimiento;
	vfallecimiento = array [1..50] of fallecimiento;
procedure leer1 (var arch: detalle1; var nac: nacimiento);
begin
	if (not eof(arch)) then
		read(arch,nac)
	else
		nac.part:= valor_alto;
end;
procedure leer2 (var arch: detalle2; var fal: fallecimiento);
begin
	if (not eof(arch)) then
		read(arch,fal)
	else
		fal.part:= valor_alto;
end;
procedure minimo1 (var v: vdetalle1; var v2: vnacimiento; var min: nacimiento);
var
	i,mini: integer;
begin
	for i:= 1 to 50 do
		if (min.part < v2[i].part)then begin
			min:= v2[i];
			mini:= i;
		end;
	leer1(v[mini],v2[mini]);
end;
procedure minimo2 (var v: vdetalle2; var v2: vfallecimiento; var min: fallecimiento);
var
	i,mini: integer;
begin
	for i:= 1 to 50 do
		if (min.part < v2[i].part)then begin
			min:= v2[i];
			mini:= i;
		end;
	leer2(v[mini],v2[mini]);
end;
var
	det1: vdetalle1;
	det2: vdetalle2;
	vmin1: vnacimiento;
	vmin2: vfallecimiento;
	min1: nacimiento;
	min2: fallecimiento;
	mae: maestro;
	i: integer;
	aux: str20;
	nuevo: todo;
	texto: text;
BEGIN
	assign(mae,'nuevo');
	assign(texto,'registro');
	rewrite(mae);
	rewrite(texto);
	for i:= 1 to 50 do begin
		str(i,aux);
		assign(det1[i],'nacimiento'+aux);
		assign(det2[i],'fallecimiento'+aux);
		reset(det1[i]);
		reset(det2[i]);
		leer1(det1[i],vmin1[i]);
		leer2(det2[i],vmin2[i]);
	end;
	minimo1(det1,vmin1,min1);
	minimo2(det2,vmin2,min2);
	while(min1.part <> valor_alto)do begin
		nuevo.nac:= min1;
		if (min1.part = min2.part)then begin
			nuevo.fallecio:= true;
			nuevo.fall:= min2;
			minimo2(det2,vmin2,min2);
		end
		else
			nuevo.fallecio:= false;
		write(mae,nuevo);
		writeln(texto,nuevo.nac.part,' ',nuevo.nac.nom);
		minimo1(det1,vmin1,min1);
	end;
	for i:= 1 to 50 do begin
		close(det1[i]);
		close(det2[i]);
	end;
	close(mae);
	close(texto);
END.
