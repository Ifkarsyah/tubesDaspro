unit uF11_tidur;

interface
uses uP1_tipeBentukan, uP3_Umum, uB4_restock;

	procedure mainTidur(dataBahanMentah : tabelBahanMentah;
						var dataSimulasi : tabelSimulasi; 
						var dataInventoriBahanMentah : tabelBahanMentah; 
						var dataInventoriBahanOlahan : tabelBahanOlahan;ID : integer;
						var jmlMakan : integer; var jmlIstirahat : integer);
	{ I.S : energi = energi hari ini
	* F.S : energi bertambah sampai menjadi 10, hari berganti}
	
	procedure resetDay(var tgl : tanggal;var energy : integer;var hariHidup : integer;var jmlMakan : integer; var jmlIstirahat : integer);
	{ I.S : tgl adalah tgl hari ini, energi adalah energi yang tersisa hari ini, dan begitu juga hariHidup
	* F.S : tanggal berubah menjadi tanggal besok, energi berubah menjadi 10, dan hariHidup bertambah 1 dari sebelumnya}

implementation

	procedure mainTidur(dataBahanMentah : tabelBahanMentah;
						var dataSimulasi : tabelSimulasi; 
						var dataInventoriBahanMentah : tabelBahanMentah; 
						var dataInventoriBahanOlahan : tabelBahanOlahan; 
						ID : integer;
						var jmlMakan : integer; var jmlIstirahat : integer);
	{ I.S : energi = energi hari ini
	* F.S : energi bertambah sampai menjadi 10, hari berganti}
	begin
		if (dataSimulasi.itemKe[ID].jumlahEnergi>=10) then
		begin
			writeln('Anda tidak bisa tidur saat energi anda penuh!')
		end
		else
		begin
			//hapusKadaluarsa(dataInventoriBahanMentah, dataInventoriBahanOlahan, ID); TO DO : BIKIN
			resetDay(dataSimulasi.itemKe[ID].tanggalSimulasi, dataSimulasi.itemKe[ID].jumlahEnergi, dataSimulasi.itemKe[ID].jumlahHariHidup, jmlMakan, jmlIstirahat);
			//mengecek untuk melakukan restock atau tidak
			if(dataSimulasi.itemKe[ID].jumlahHariHidup mod 3 = 0) then
				mainRestock(ID, dataSimulasi, dataBahanMentah, dataInventoriBahanMentah);
		end;
	end;

	procedure resetDay(var tgl : tanggal;var energy : integer;var hariHidup : integer;var jmlMakan : integer; var jmlIstirahat : integer);
	{me-reset hari}
	begin
		updateTanggal(tgl); {Bagian ini harus diperbaiki agar sesuai sistem kalendar(update->sudah ya :D)}
		energy:=10;
		hariHidup:=hariHidup+1;
		jmlMakan:=0;
		jmlIstirahat := 0;
	end;

end.
