unit uF16_tambahResep;
{unit ini berguna untuk menambah resep masakan baru}

//INTERFACE
interface

uses uP1_tipeBentukan, uF1_load;

	procedure mainTambahResep(ID : integer;
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi;
									var dataInventoriBahanMentah : tabelBahanMentah); 
	
	function isResepExist(nama:string; var dataResep : tabelResep):boolean;

//IMPLEMENTATION
implementation

//Prosedur Pembantu (1)
	function isResepExist(nama : string; var dataResep : tabelResep):boolean;
	{I.S : Menerima input sebuah nama resep
	 F.S : Jikalai ternyata nama resep itu telah ada, maka fungsi ini akan mengeluarkan TRUE
	       Kalau nama resep itu belum ada, keluarannya akan FALSE}
	
	{Kamus Lokal}
	var
		i     : integer;
		found : boolean;
	{Algoritma}
	begin
		i:=1;
		found:=false;
		while (found=false) and ( i<=dataResep.banyakItem) do
		begin
			if dataResep.itemKe[i].nama=nama then
			begin
				found:=true;
			end else
				i:=i+1;
		end;
		if (found=true) then
		begin
			isResepExist:=true;
		end else
			isResepExist:=false;
end;

//Prosedur Pembantu (2)	
		function hitungHargaModalResep(ID : integer;
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep;
									var dataInventoriBahanMentah : tabelBahanMentah):Integer;
		
		{Fungsi ini berguna untuk menghitung harga modal dari sebuah resep
		 I.S : Menerima masukan berupa ID
		 F.S : Mengeluarkan output berupa Integer yang adalah harga modal resep yang telah dikalkulasikan sedemikian rupa}
		{Kamus Lokal}
		var
			i, j : integer;
		{Algoritma}
		begin
			hitungHargaModalResep:=0; {inisialisai harga modal resep tersebut}
			for i:=1 to dataResep.banyakItem do
			begin
				for j:=1 to dataBahanMentah.banyakItem do
				begin
					if dataResep.itemKe[i].nama=dataBahanMentah.itemKe[j].nama then
					begin
						hitungHargaModalResep:=hitungHargaModalResep+dataBahanMentah.itemKe[j].hargaBeli;
					end;
				end;
				for j:=1 to dataBahanOlahan.banyakItem do
				begin
					if dataResep.itemKe[i].nama=dataBahanOlahan.itemKe[j].nama then
					begin
						hitungHargaModalResep:=hitungHargaModalResep+dataBahanOlahan.itemKe[j].hargaJual;
					end;
				end;
				
			end;
		end;
		
////////////////////		
// PROSEDUR UTAMA //
////////////////////
	procedure mainTambahResep(ID : integer;
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi; 
									var dataInventoriBahanMentah : tabelBahanMentah);
	{I.S : Menerima masukan ID dan data-data lainnya
	 F.S : Hasil nama resep dan bahan-bahan penyusunnya akan disimpan di dalam array-array}
	{Kamus Lokal}
	var
		nama : string; {nama resep baru yg dimasukin}
		found : boolean;
		i , j ,k : integer; {pencacah}
		n : integer; {jumlah bahan resep}
		
	{Algoritma}
begin
	repeat
		write('Nama resep :'); readln(nama);
		if (isResepExist(nama,dataResep)=true) then {menggunakan fungsi isResepExist untuk mengecek apakah sudah ada resep dengan nama yang sama}
		begin	
			writeln('Nama resep telah ada, masukan nama yang lain!'); {validasi nama resep}
		end;
	until (isResepExist(nama,dataResep)=false);
	
	repeat
		writeln('Masukkan jumlah bahan resep');
		readln(n);
		if n<2 then
		begin
			writeln('Jumlah bahan resep tidak boleh kurang dari 2!');
		end;
	until (n>=2);
	
	for k:=1 to n do
	i:=1;
	begin
		writeln('Masukkan nama bahan ke ',k);
		repeat 
			readln(nama);
			found := false;
			{lalu dilakukan validasi apakah nama bahan resep ada di tabel nama inventori bahan mentah/olahan}
			
			while (found=false) do
			begin
				for j:=1 to dataBahanMentah.banyakItem do
				begin {dicek dulu, siapa tau nama bahan terbut ada di data inventori bahan mentah}
					if dataBahanMentah.itemKe[ID].nama[j]=nama then
					found:=true;
				end;
				
				for j:=1 to dataBahanOlahan.banyakItem do
				begin
					if dataBahanOlahan.itemKe[ID].nama[j]=nama then
					found:=true;
				end;
				writeln('Bahan tersebut tidak ada, silahkan masukkan nama bahan lain!');
			end;
		until (found=true);
		
		dataResep.itemKe[ID].bahan[i]:=nama;
		i:=i+1;
	end;
			
			repeat 
				write('Harga jual resep :'); read(dataResep.itemKe[ID].hargaJual);
				
				if (dataResep.itemKe[ID].hargaJual < (0.125 * hitungHargaModalResep(ID,dataBahanMentah,dataBahanOlahan,dataResep,dataInventoriBahanMentah))) then
				begin
					writeln('Harga jual minimum harus 12,5% lebih tinggi dari harga modal!'); {proses validasi harga jual resep tersebut}
				end;
			until ((dataResep.itemKe[ID].hargaJual >= (0.125 * hitungHargaModalResep(ID,dataBahanMentah,dataBahanOlahan,dataResep,dataInventoriBahanMentah))));	
end;

end.
