program P2E6;
Const
	highValue = 9999;
Type
	str20 = string[20];
	place = record
		code: integer;
		name: str20;
		strainCode: integer;
		strain: str20;
		active: integer;
		new: integer;
		recovered: integer;
		past: integer;
	end;
	update = record
		code: integer;
		strainCode: integer;
		active: integer;
		new: integer;
		recovered: integer;
		past: integer;
	end;
	masterFile = file of place;
	detailFile = file of update;
	detailArray = array [1..10] of detailFile;
	updateArray = array [1..10] of update;
procedure specialRead (var detail: detailFile; var upd: update);
begin
	if (not eof(detail)) then
		read(detail,upd)
	else
		upd.code:= highValue;
end;
procedure minimum (var details: detailArray; var minimums: updateArray; var min: update);
var
	i,mini: integer;
begin
	min.code:= 9999;
	for i:= 1 to 10 do
		if ((min.code > minimums[i].code) or ((min.code = minimums[i].code) and (min.strainCode > minimums[i].code))) then begin
				min:= minimums[i];
				mini:= i;
		end;
	specialRead(details[mini],minimums[mini]);
end;
var 
	details: detailArray;
	master: masterFile;
	aux: string;
	i,counter: integer;
	pla: place;
	min: update;
	minimums: updateArray;
BEGIN
	counter:= 0;
	assign(master,'master');
	reset(master);
	for i:= 1 to 10 do begin
		Str(i,aux);
		assign(details[i],'detail'+aux);
		reset(details[i]);
		specialRead(details[i],minimums[i]);
	end;
	minimum(details,minimums,min);
	read(master,pla);
	while (min.code <> highValue) do begin
		while (pla.code <> min.code) do
			if (pla.active > 50) then
				counter:= counter + 1;
			read(master,pla);
		while(pla.strainCode <> min.strainCode) do
			if (pla.active > 50) then
				counter:= counter + 1;
			read(master,pla);
		pla.past:= pla.past + min.past;
		pla.recovered:= pla.recovered + min.recovered;
		pla.active:= min.active;
		if (pla.active > 50) then
				counter:= counter + 1;
		pla.new:= min.new;
		seek(master, filePos(master) - 1);
		write(master, pla);
		if (not eof(master)) then
			read(master,pla);
		minimum(details,minimums,min);
	end;
	for i:= 1 to 10 do begin
		close(details[i]);	
	end;
	close(master);
	writeln('La cantidad de localidades con casos activos es de ',counter);
END.

