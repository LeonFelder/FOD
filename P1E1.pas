program Ejercicio1;
Type
  archivo = file of integer;
Var
  arc_logico: archivo;
  nro: integer;
  arc_fisico: string[12];
begin
  write('Ingrese el nombre del archivo: ');
  read(arc_fisico);
  assign(arc_logico, arc_fisico);
  rewrite(arc_logico);
  write('Ingrese un numero: ');
  read(nro);
  while (nro <> 30000) do begin
    write(arc_logico, nro);
    write('Ingrese un numero: ');
    read(nro);
  end;
  close(arc_logico);
end.
