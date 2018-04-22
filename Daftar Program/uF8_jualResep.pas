unit uF8_jualResep; 

interface

uses uP1_tipeBentukan, uP3_Umum, uF6_OlahBahan;

	procedure mainJualResep(ID : integer; 
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi); 
	{ Menjual bahan bahan sesuai resep }
	
	procedure cariR(var found : boolean; 
									var iR : integer;
									var dataResep : tabelResep;
									var s : string);
	{Mencari Resep dan menentukan indeks resep yang dimaksud}

implementation

	procedure mainJualResep(ID : integer; 
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi); 
	{ Menjual bahan bahan sesuai resep }
	type
	arr = array[1..NMax] of integer;
	
	var
	i, j, nBO, nBM, iR, x : integer;
	iBO, iBM : arr;
	s : string;
	foundResep, foundBO, foundBM : boolean;
	
	begin
		i:=1;
		j:=1;
		nBO:=0;
		nBM:=0;
		writeln('Resep yang tersedia: ');
		for i:=1 to dataResep.banyakItem do
			begin
			write(dataResep.itemKe[i].nama,'<-- ');
			for j:=1 to dataResep.itemKe[i].banyakBahan do
			begin
				write(dataResep.itemKe[i].bahan[j],' ');
				if j<dataResep.itemKe[i].banyakBahan then
				write('+ ');
			end;
			writeln();
			end;
		writeln('Ketik cancel untuk  membatalkan');
		writeln('Tuliskan resep yang ingin dijual');
		readln(s);
		if (s='cancel') then
			writeln('Olah resep dibatalkan')
		else
		begin
		cariR(foundResep,iR,dataResep,s);
		if (foundResep) then
			begin
			i:=1;
			j:=1;
				repeat
				s:=dataResep.itemKe[iR].bahan[i];
				cariBM(dataBahanMentah, s, foundBM, x);
					if (foundBM) then
					begin
					inc(nBM);
					iBM[nBM]:=x;
					end;
				cariBO(foundBO, x, dataBahanOlahan, s);
					if (foundBM) then
					begin
					inc(nBO);
					iBO[nBO]:=x;
					end;
				inc(i);
				until (not(foundBM) and not(foundBO)) or (i>dataResep.itemKe[iR].banyakBahan);
				if (not(foundBM) and not(foundBO)) then
					writeln('Terdapat bahan yang tidak ada/habis!')
				else
					begin
					for j:=1 to nBM do
						dec(dataBahanMentah.itemKe[iBM[j]].jumlahTersedia);
					for j:=1 to nBO do
						dec(dataBahanOlahan.itemKe[iBO[j]].jumlahTersedia);
					dataSimulasi.itemKe[ID].jumlahDuit:=(dataSimulasi.itemKe[ID].jumlahDuit)+(dataResep.itemKe[iR].hargaJual);
					dec(dataSimulasi.itemKe[ID].jumlahEnergi);
					writeln('Bahan olahan ',dataResep.itemKe[iR].nama,' telah dijual!');
					end;
			end
		else
		writeln('Resep Tidak Ditemukan!');
		end;
	end;
	
	
	procedure cariR(var found : boolean; 
									var iR : integer;
									var dataResep : tabelResep;
									var s : string);
	{Mencari Resep dan menentukan indeks resep yang dimaksud}
	var
	i : integer;
	begin
	found:=false;
	i:=1;
		repeat
		if s=dataResep.itemKe[i].nama then
			begin
			found:=true;
			iR:=i;
			end;
		inc(i);
		until (found=true) or (i>dataResep.banyakItem);
	end;

end.
