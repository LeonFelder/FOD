program P1E4;
Type
  empleado = record
    num: integer;
    apellido: string[15];
    nombre: string[15];
    edad: integer;
    DNI: integer;
  end;
  arch_empleado = file of empleado;
procedure DisplayMenu;
begin
  writeln('---------------------------------------------------');
  writeln('Ingrese el numero de la opcion deseada');
  writeln('1) Crear un archivo de empleados');
  writeln('2) Listar empleados con cierto nombre o apellido');
  writeln('3) Listar todos los empleados');
  writeln('4) Listar los empleados proximos a jubilarse');
  writeln('5) Anadir empleados');
  writeln('6) Modificar edad de empleados');
  writeln('7) Exportar a texto');
  writeln('8) Exportar empleados sin DNI');
  writeln('9) Eliminar empleados');
  writeln('10) Salir del programa');
  writeln('---------------------------------------------------');
end;
procedure CrearArchivo (var arch: arch_empleado);
var
  nom:string[12];
begin
  write('Ingrese nombre del archivo a crear: ');
  readln(nom);
  assign(arch,nom);
  rewrite(arch);
end;
procedure Opcion1 (var arch: arch_empleado);
var
  emp: empleado;
begin
  CrearArchivo(arch);
  write('Ingrese apellido del empleado: ');
  readln(emp.apellido);
  while (emp.apellido <> 'fin') do begin
    write('Ingrese nombre del empleado: ');
    readln(emp.nombre);
    write('Ingrese numero del empleado: ');
    readln(emp.num);
    write('Ingrese edad del empleado: ');
    readln(emp.edad);
    write('Ingrese DNI del empleado: ');
    readln(emp.DNI);
    write(arch,emp);
    write('Ingrese apellido del empleado: ');
    readln(emp.apellido);
  end;
  close(arch);
end;
procedure imprimirEmpleado (emp: empleado);
begin
  writeln('Nombre: ',emp.nombre);
  writeln('Apellido: ',emp.apellido);
  writeln('Edad: ',emp.edad);
  if(emp.DNI <> 00) then
    writeln('DNI: ',emp.DNI);
  writeln('Numero de empleado: ',emp.num);
end;
procedure Opcion2(var arch: arch_empleado);
var
  nom: string[15];
  emp: empleado;
begin
  reset(arch);
  writeln('Ingrese el apellido o nombre a buscar: ');
  readln(nom);
  while (not eof(arch)) do begin
    read(arch, emp);
    if (emp.apellido = nom) or (emp.nombre = nom) then
      imprimirEmpleado(emp);
  end;
  close(arch);
end;
procedure Opcion3(var arch: arch_empleado);
var
  emp: empleado;
begin
  reset(arch);
  while (not eof(arch)) do begin
    read(arch, emp);
    imprimirEmpleado(emp);
  end;
  close(arch);
end;
procedure Opcion4(var arch: arch_empleado);
var
  emp: empleado;
begin
  reset(arch);
  while (not eof(arch)) do begin
    read(arch, emp);
    if(emp.edad > 70) then
      imprimirEmpleado(emp);
  end;
  close(arch);
end;
procedure Opcion5(var arch: arch_empleado);
var
  emp,com: empleado;
  existe: boolean;
begin
  write('Ingrese numero del empleado: ');
  readln(emp.num);
  while(emp.num <> 0)do begin
    reset(arch);
    existe:= false;
    while (not eof(arch)) and (not existe) do begin
      read(arch,com);
      if(emp.num = com.num) then
        existe:= true;
    end;
    if (not existe) then begin
      write('Ingrese nombre del empleado: ');
      readln(emp.nombre);
      write('Ingrese apellido del empleado: ');
      readln(emp.apellido);
      write('Ingrese edad del empleado: ');
      readln(emp.edad);
      write('Ingrese DNI del empleado: ');
      readln(emp.DNI);
      write(arch,emp);
    end
    else
      writeln('Este empleado ya existe');
  write('Ingrese numero del empleado: ');
  readln(emp.num);
  end;
  close(arch);
end;
procedure Opcion6 (var arch: arch_empleado);
var
  emp: empleado;
  num,edad: integer;
begin
  write('Ingrese numero del empleado a modificar su edad: ');
  readln(num);
  while (num <> 0) do begin
    reset(arch);
    repeat
      read(arch,emp);
    until (eof(arch)) or (num = emp.num);
    if (num <> emp.num) then
      writeln('Ese empleado no existe')
    else begin
      writeln('Ingrese nueva edad del empleado: ');
      readln(edad);
      emp.edad:= edad;
      seek(arch,filePos(arch)-1);
      write(arch, emp);
    end;
    write('Ingrese numero del empleado a modificar su edad: ');
    readln(num);
  end;
  close(arch);
end;
procedure Opcion7 (var arch: arch_empleado);
var
  texto: text;
  emp: empleado;
begin
  assign(texto,'todos_empleados.txt');
  rewrite(texto);
  reset(arch);
  while(not eof(arch))do begin
    read(arch,emp);
    writeln(texto,emp.num,' ',emp.apellido,' ',emp.nombre,' ',emp.DNI,' ',emp.edad);
  end;
  close(arch);
  close(texto);
end;
procedure Opcion8 (var arch: arch_empleado);
var
  texto: text;
  emp: empleado;
begin
  assign(texto,'faltaDNIEmpleado.txt');
  rewrite(texto);
  reset(arch);
  while(not eof(arch))do begin
    read(arch,emp);
    if (emp.DNI = 00) then
      writeln(texto,emp.num,' ',emp.apellido,' ',emp.nombre,' ',emp.edad);
  end;
  close(arch);
  close(texto);
end;
procedure Opcion9 (var arch: arch_empleado);
var
  emp,ult: empleado;
  num: integer;
begin
	reset(arch);
	write('Ingrese numero del empleado a eliminar: ');
	readln(num);
	seek(arch,filesize(arch)-1);
	read(arch,ult);
	seek(arch,0);
	repeat
		read(arch,emp);
	until (eof(arch)) or (num = emp.num);
	if (num <> emp.num) then
		writeln('Ese empleado no existe')
	else begin
		seek(arch,filePos(arch)-1);
		write(arch, ult);
		seek(arch,filesize(arch)-1);
    end;
	truncate(arch);
end;
procedure AbrirArchivo(var arch: arch_empleado);
begin
  assign(arch,'gh');
  reset(arch);
end;
var
  fin: boolean;
  opcion: integer;
  arch: arch_empleado;
begin
  fin:= false;
  repeat
    DisplayMenu;
    readln(opcion);
    case (opcion) of
      1: Opcion1(arch);
      2: Opcion2(arch);
      3: Opcion3(arch);
      4: Opcion4(arch);
      5: Opcion5(arch);
      6: Opcion6(arch);
      7: Opcion7(arch);
      8: Opcion8(arch);
      9: Opcion9(arch);
      10: fin:= true;
      20: AbrirArchivo(arch);
      else writeln('Opcion no valida.');
    end;
  until fin;
end.
