unit uF9_makan; 

interface

uses uP1_tipeBentukan, uP3_Umum;

	procedure mainMakan(var jmlMakan : integer;
									var energy : integer);
	{ I.S : jmlMakan = berapa kali makan hari ini, energy = energy hari ini
	* F.S : jmlMakan = berapa kali makan hari ini+1, energy = energy hari ini+3}

implementation

	procedure mainMakan(var jmlMakan : integer;
									var energy : integer); 
	{ I.S : jmlMakan = berapa kali makan hari ini, energy = energy hari ini
	* F.S : jmlMakan = berapa kali makan hari ini+1, energy = energy hari ini+3}
	begin
		if energy >= 10 then
			writeln('Energi anda masih penuh!')
		else if jmlMakan>=3 then
			writeln('Anda hanya bisa makan 3x sehari!')
		else if energy >=7 then
			begin
			jmlMakan:=jmlMakan+1;
			energy:=10;
			end
		else
			begin
			jmlMakan:=jmlMakan+1;
			energy:=energy+3;
			end;
	end;
	

end.

