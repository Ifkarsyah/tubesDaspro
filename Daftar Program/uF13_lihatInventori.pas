unit uF13_lihatInventori; 

interface
uses uP1_tipeBentukan, uP3_Umum; //Sori telat (emoji maaf), gua lagi abis ngurus chaos gua -Dito-

	procedure mainLihatInventori(ID : integer; //hapus parameter yang tidak perlu
									var dataInventoriBahanMentah : tabelBahanMentah; 
									var dataInventoriBahanOlahan : tabelBahanOlahan); 


implementation

	procedure mainLihatInventori(ID : integer; //hapus parameter yang tidak perlu
									var dataInventoriBahanMentah : tabelBahanMentah; 
									var dataInventoriBahanOlahan: tabelBahanOlahan); 

	var 
	X,i : integer;

	begin
		i:=0;
		writeln('Pilih jenis bahan :');
		writeln('1. Bahan Mentah');
		writeln('2. Bahan Olahan');
		readln(X);
		repeat
			if X = 1 then 
			begin
				writeln('INVENTORI BAHAN MENTAH');
				for i := 1 to dataInventoriBahanMentah.banyakItem do
					begin
						writeln('Nama bahan baku 	: ', dataInventoriBahanMentah.itemKe[ID].nama);				
						writeln('Stok				: ', dataInventoriBahanMentah.itemKe[ID].jumlahTersedia);			
						writeln('Durasi kadaluarsa	: ', dataInventoriBahanMentah.itemKe[ID].durasiKadaluarsa);
						writeln(' ')
					end;
			end;
			if i = 2 then
			begin
				writeln('INVENTORI BAHAN OLAHAN');
				for i := 1 to dataInventoriBahanOlahan.banyakItem do 
				begin
					writeln('Nama bahan olahan 	: ', dataInventoriBahanOlahan.itemKe[ID].nama);				
					writeln('Stok				: ', dataInventoriBahanOlahan.itemKe[ID].jumlahTersedia);			
					writeln('Harga jual 		: ', dataInventoriBahanOlahan.itemKe[ID].hargaJual);
				end;
			end;
			if (X <> 1) and (X <> 2) then
			begin
				writeln('Pilih jenis bahan :');
				writeln('1. Bahan Mentah');
				writeln('2. Bahan Olahan');
				readln(X);
			end;
		until (X = 1) or (X = 2);
	end;
end.
	
