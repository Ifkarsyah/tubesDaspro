unit uF7_jualOlahan;{Note : perlu dibuat agar bahan olahan yang habis dihapus nama nya}

interface

uses uP1_tipeBentukan, uP3_Umum, uF6_OlahBahan;

	procedure mainJualOlahan(ID : integer;
									var dataBahanOlahan : tabelBahanOlahan;  
									var dataSimulasi : tabelSimulasi); 
	{ I.S : Bagaimana keadaan awal dari tiap variabel pada parameter?
	* F.S : Bagaimana keadaan akhir dari tiap variabel pada parameter?}
	
implementation

	procedure mainJualOlahan(ID : integer;
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataSimulasi : tabelSimulasi); 
	{ I.S : Bagaimana keadaan awal dari tiap variabel pada parameter?
	* F.S : Bagaimana keadaan akhir dari tiap variabel pada parameter?}
	var
	found : boolean;
	iBO, n : integer;
	BO : bahanOlahan;
	s : string;
	
	begin
		writeln('Masukkan bahan yang ingin dijual: ');
		readln(s);
		writeln('Berapa banyak yang ingin dijual?');
		readln(n);
		cariBO(found,iBO,dataBahanOlahan,s);
		if (found) and (dataBahanOlahan.itemKe[iBO].jumlahTersedia>=n) then
			begin
			BO:=dataBahanOlahan.itemKe[iBO];
			BO.jumlahTersedia:=BO.jumlahTersedia-n;
			dataSimulasi.itemKe[ID].jumlahDuit:=dataSimulasi.itemKe[ID].jumlahDuit+(dataBahanOlahan.itemKe[iBO].hargaJual*n);
			dec(dataSimulasi.itemKe[ID].jumlahEnergi);
			writeln('Bahan olahan ',dataBahanOlahan.itemKe[iBO].nama,' telah dijual!');
			end
		else if not(found) then
			writeln('Bahan olahan tidak ditemukan!')
		else if (dataBahanOlahan.itemKe[iBO].jumlahTersedia<n) then
			writeln('Jumlah bahan olahan tidak mencukupi!');
	end;

end.

{ TIPS DAN CARA MEMPROGRAM DARI UNIT
* 1. Buat I.S dan F.S sebaik mungkin sehingga orang lain bisa tau maksud program lu tanpa harus ngebaca implementasinya
* 2. Keterangan : I.S(initial state); F.S(final state)
* 3. Jangan mengubah uP0_utama.pas, kalo mau ngetest file ini, silahkan "uncomment" HANYA "mainNamaTemplate()" di uP0_utama.pas atau uF3_startSimulasi.pas
* 4. Kalo mau butuh fungsi atau prosedur topik umum kaya updateTanggal(x) dan sejenisnya, silahkan request ke gue atau bikin sendiri di uP3_umum.pas
* 5. Silahkan perhatikan baik-baik untup tipedata bentukan di uP1_tipeBentukan.pas
* 
* }
