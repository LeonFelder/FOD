program aves;
Type
	ave = record
		cod: integer;
		nom: string;
		fam: string;
		desc: string;
		zona: string;
	end;
	arch_ave = file of ave;
procedure marcar (var a: arch_ave);
var
	esp: string;
	av: ave;
begin
	reset(a);
	read(esp);
	while (esp <> '500000') do begin
		seek(a,0);
		repeat
			read(a,av);
		until (av.nom = esp);
		av.nom:= '***';
		read(esp);
	end;
	close(a);
end;
procedure compactar (var a: arch_ave);
var
	pos,cant: integer;
	av: ave;
begin
	reset(a);
	cant:= 0;
	pos:= -1;
	while (not eof(a)) do begin
		repeat
			read(a,av);
			pos:= pos + 1
		until (eof(a)) or (av.nom = '***');
		if(av.nom = '***') then begin
			cant:= cant + 1;
			seek(a,filesize(a)-cant);
			read(a,av);
			seek(a,pos);
			write(a,av);
		end;
	end;
	seek(a,filesize(a)-cant);
	truncate(a);
end;
BEGIN
	
	
END.

