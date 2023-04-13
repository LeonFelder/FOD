program Ejercicio2;
Type
  archivo = file of integer;
Var
  arc_logico: archivo;
  num,cant,prom: integer;
  arc_fisico: string[12];
begin
  cant:= 0;
  prom:= 0;
  write('Ingrese el nombre del archivo a analizar: ');
  read(arc_fisico);
  assign(arc_logico,arc_fisico);
  reset(arc_logico);
  while not(EOF(arc_logico)) do begin
    read(arc_logico, num);
    if(num<1500) then
      cant:= cant+1;
    prom:= prom + num;
  end;
  writeln('La cantidad de numeros menores a 1500 es ',cant);
  writeln('El promedio de los numeros ingresados es ', prom/cant:5:5);
  close(arc_logico);
end.
