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
	{ Mereset data simulasi dan memajukan tanggal }

	procedure hapusKadaluarsa(var dataInventoriBahanMentah : tabelBahanMentah; var dataInventoriBahanOlahan : tabelBahanOlahan; var ID : integer; var dataSimulasi : tabelSimulasi);
	{ Menghapus bahan yang kadaluarsa }
	
	procedure hapusDataBM(var dataInventoriBahanMentah : tabelBahanMentah; index : integer);
	{ Menghapus sebuah bahan mentah dari array inventori bahan mentah }
	
	procedure hapusDataBO(var dataInventoriBahanOlahan : tabelBahanOlahan; index : integer);
	{ Menghapus sebuah bahan olahan dari array inventori bahan mentah }
	
	
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
			resetDay(dataSimulasi.itemKe[ID].tanggalSimulasi, dataSimulasi.itemKe[ID].jumlahEnergi, dataSimulasi.itemKe[ID].jumlahHariHidup, jmlMakan, jmlIstirahat);
			//mengecek untuk melakukan restock atau tidak
			if(dataSimulasi.itemKe[ID].jumlahHariHidup mod 3 = 0) then
				mainRestock(ID, dataSimulasi, dataBahanMentah, dataInventoriBahanMentah);
			hapusKadaluarsa(dataInventoriBahanMentah, dataInventoriBahanOlahan, ID, dataSimulasi);
		end;
	end;

	procedure resetDay(var tgl : tanggal;var energy : integer;var hariHidup : integer;var jmlMakan : integer; var jmlIstirahat : integer);
	{Mereset data simulasi dan memajukan tanggal}
	begin
		updateTanggal(tgl); 
		energy:=10;
		hariHidup:=hariHidup+1;
		jmlMakan:=0;
		jmlIstirahat := 0;
	end;
	
	procedure hapusKadaluarsa(var dataInventoriBahanMentah : tabelBahanMentah; var dataInventoriBahanOlahan : tabelBahanOlahan; var ID : integer; var dataSimulasi : tabelSimulasi);
	{Menghapus bahan yang kadaluarsa}
	var
	i : integer;
	now, kdl : tanggal;
	
	begin
	now:=dataSimulasi.itemKe[ID].tanggalSimulasi;
	i:=1;
	while (i<=dataInventoriBahanMentah.banyakItem) do
		begin
		kdl:=dataInventoriBahanMentah.itemKe[i].tanggalKadaluarsa;
		if now.tahun > kdl.tahun then
			begin
			writeln('Bahan mentah ',dataInventoriBahanMentah.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBM(dataInventoriBahanMentah,i);
			dec(i);
			end
		else if (now.tahun = kdl.tahun) and (now.bulan > kdl.bulan) then
			begin
			writeln('Bahan mentah ',dataInventoriBahanMentah.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBM(dataInventoriBahanMentah,i);
			dec(i);
			end
		else if (now.tahun = kdl.tahun) and (now.bulan = kdl.bulan) and (now.hari >= kdl.hari) then
			begin
			writeln('Bahan mentah ',dataInventoriBahanMentah.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBM(dataInventoriBahanMentah,i);
			dec(i);
			end;
		i:=i+1;
		end;
	i:=1;
		while (i<=dataInventoriBahanOlahan.banyakItem) do
		begin
		kdl:=dataInventoriBahanOlahan.itemKe[i].tanggalKadaluarsa;
		if now.tahun > kdl.tahun then
			begin
			writeln('Bahan olahan ',dataInventoriBahanOlahan.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBO(dataInventoriBahanOlahan,i);
			dec(i);
			end
		else if (now.tahun = kdl.tahun) and (now.bulan > kdl.bulan) then
			begin
			writeln('Bahan olahan ',dataInventoriBahanOlahan.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBO(dataInventoriBahanOlahan,i);
			dec(i);
			end
		else if (now.tahun = kdl.tahun) and (now.bulan = kdl.bulan) and (now.hari >= kdl.hari) then
			begin
			writeln('Bahan olahan ',dataInventoriBahanOlahan.itemKe[i].nama,' telah kadaluarsa');
			hapusDataBO(dataInventoriBahanOlahan,i);
			dec(i);
			end;
		i:=i+1;
		end;
	end;

	procedure hapusDataBM(var dataInventoriBahanMentah : tabelBahanMentah; index : integer);
	{Menghapus sebuah data bahan mentah dari data inventori bahan mentah}
	var
	i, j: integer;
	
	begin
	for i:=(index+1) to dataInventoriBahanMentah.banyakItem do
	begin
	dataInventoriBahanMentah.itemKe[i-1]:=dataInventoriBahanMentah.itemKe[i];
	end;
	j:=dataInventoriBahanMentah.banyakItem;
	dataInventoriBahanMentah.itemKe[j].nama:='';
	dataInventoriBahanMentah.itemKe[j].hargaBeli:=0;
	dataInventoriBahanMentah.itemKe[j].durasiKadaluarsa:=0;
	dataInventoriBahanMentah.itemKe[j].jumlahTersedia:=0;
	dec(dataInventoriBahanMentah.banyakItem);
	end;
	
	procedure hapusDataBO(var dataInventoriBahanOlahan : tabelBahanOlahan; index : integer);
	{Menghapus sebuah data bahan mentah dari data inventori bahan mentah}
	var
	i, j: integer;
	
	begin
	for i:=(index+1) to dataInventoriBahanOlahan.banyakItem do
	begin
	dataInventoriBahanOlahan.itemKe[i-1]:=dataInventoriBahanOlahan.itemKe[i];
	end;
	j:=dataInventoriBahanOlahan.banyakItem;
	dataInventoriBahanOlahan.itemKe[j].nama:='';
	dataInventoriBahanOlahan.itemKe[j].hargaJual:=0;
	dataInventoriBahanOlahan.itemKe[j].durasiKadaluarsa:=0;
	dataInventoriBahanOlahan.itemKe[j].jumlahTersedia:=0;
	dec(dataInventoriBahanOlahan.banyakItem);
	end;
	
end.
