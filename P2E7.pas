program P2E7;
Const
	valor_alto = 9999;
Type
	producto = record
		cod: integer;
		nom: string;
		precio: real;
		stdis: integer;
		stmin: integer;
	end;
	venta = record
		cod: integer;
		cant: integer;
	end;
	maestro = file of producto;
	detalle = file of venta;
procedure leer (var det: detalle; var ven: venta);
begin
	if (eof(det)) then
		ven.cod:= valor_alto
	else 
		read(det,ven);
end;
procedure Actualizar (var mae: maestro);
var
	det: detalle;
	ven: venta;
	prod: producto;
	cod,cant: integer;
begin
	reset(mae);
	reset(det);
	leer(det,ven);
	read(mae,prod);
	while (ven.cod <> valor_alto) do begin
		cant:= 0;
		cod:= ven.cod;
		while (cod = ven.cod) do begin
			cant:= cant + ven.cant;
			leer(det,ven);
		end;
		while (cod <> prod.cod) do
			read(mae,prod);
		prod.stdis:= prod.stdis - cant;
		seek(mae,filePos(mae)-1);
		write(mae,prod);
	end;
	close(mae);
	close(det);
end;
procedure Listar (var archi: maestro);
var
	texto: text;
	prod: producto;
begin
	assign(texto,'stock_minimo.txt');
	rewrite(texto);
	reset(archi);
	while (not eof(archi)) do  begin
		read(archi,prod);
		if (prod.stmin > prod.stdis) then
			writeln(texto,prod.cod,' ',prod.nom,' ',prod.precio,' ',prod.stdis,' ',prod.stmin);
	end;
	close(texto);
	close(archi);
end;
var
	archi: maestro;
BEGIN
	assign(archi,'productos');
	Actualizar(archi);
	Listar(archi);
END.

