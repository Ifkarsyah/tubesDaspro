unit uF15_cariResep;

interface

uses uP1_tipeBentukan, uP3_Umum;

	procedure mainCariResep(ID : integer; dataResep : tabelResep); 
	{ Menjalankan fitur 15 }

implementation

	procedure mainCariResep(ID : integer; dataResep : tabelResep); 
	{ Menjalankan fitur 15 }
	var
	i,j: integer;
	resepAda: boolean;
	resepYangDiCari: string;
	begin
		writeln('Resep apa yang ingin Anda cari?');
		readln(resepYangDiCari);
		
		{mencari resepYangDiCari di dataResep}
		i:=0;
		resepAda:=false;
			
			while((i<=dataResep.banyakItem) and (resepAda = false)) do
			begin
				i:= i+1;
				if(resepYangDiCari = dataResep.itemKe[i].nama) then
					resepAda:=true;
			end;
		
		{Menuliskan hasil pencarian, jika ditulisan resepNya jika tidak dituliskan pesan kesalahan}
		if(resepAda) then
		begin
			writeln('Resep ditemukan');
			writeln(dataResep.itemKe[i].nama);
			writeln('harga jual : ',dataResep.itemKe[i].hargaJual);
			write('Bahan : ');
				for j:=1 to (dataResep.itemKe[i].banyakBahan)-1 do
				begin
					write(dataResep.itemKe[i].bahan[j], ', ');
				end;
			writeln(dataResep.itemKe[i].bahan[dataResep.itemKe[i].banyakBahan]);
		end else
				writeln('Resep tidak ditemukan didaftar resep');
	
	end;

end.
