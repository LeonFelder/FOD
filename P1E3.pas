program P1E3;
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
  writeln('5) Salir del programa');
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
      5: fin:= true;
      else writeln('Opcion no valida.');
    end;
  until fin;
end.
