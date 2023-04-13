program P2E3;
Const valor_alto = 9999;
Type
	str20 = string[20];
	producto = record
		cod: integer;
		nom: str20;
		desc: str20;
		stdis: integer;
		stmin: integer;
		precio: real;
	end;
	venta = record
		cod: integer;
		cant: integer;
	end;
	maestro = file of producto;
	detalle = file of venta;
	vventa = array [1..30] of venta;
	vdetalle = array [1..30] of detalle;
procedure leer (var arch: detalle; var ven: venta);
begin
	if not eof(arch) then
		read(arch,ven)
	else
		ven.cod:= valor_alto;
end;
procedure minimo (var v: vventa; var det: vdetalle;var min: venta);
var
	i,mini: integer;
begin
	for i:= 1 to 30 do
		if(v[i].cod<min.cod)then begin
			min:= v[i];
			mini:= i;
		end;
	leer(det[mini],v[mini]);
end;
var
	mae: maestro;
	det: vdetalle;
	ventas: vventa;
	min: venta;
	prod: producto;
	cod,i,tot: integer;
	hola: string;
BEGIN
	assign(mae,'maestro');
	rewrite(mae);
	for i:= 1 to 30 do begin
		str(i,hola);
		assign(det[i],'detalle'+hola);
		reset(det[i]);
		leer(det[i],ventas[i]);
	end;
	minimo(ventas,det,min);
	read(mae,prod);
	while(min.cod <> valor_alto)do begin
		tot:= 0;
		cod:= min.cod;
		while(min.cod = cod)do begin
			tot:= tot + min.cant;
			minimo(ventas,det,min);
		end;
		while (prod.cod <> cod) do
			read(mae,prod);
		prod.stdis:= prod.stdis - tot;
		seek(mae,filepos(mae)-1);
		write(mae,prod);
		if (not eof(mae)) then
			read(mae,prod);
	end;
	for i:= 1 to 30 do
		close(det[i]);
	close(mae);
END.
