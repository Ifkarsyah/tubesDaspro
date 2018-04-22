unit uF3_startSimulasi;

interface

uses uP1_tipeBentukan, uP2_pesan,
	 uF4_stopSimulasi, uF5_beliBahan, uF6_OlahBahan, 
	 uF7_jualOlahan, uF8_jualResep, uF9_makan, 
	 uF10_istirahat, uF11_tidur, uF12_lihatStatistik,
	 uF13_lihatInventori, uF14_lihatResep, 
	 uF15_cariResep, uF16_tambahResep, uF17_upgradeInventori;

	procedure mainStartSimulasi(ID : integer;
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi;
									var dataInventoriBahanMentah: tabelBahanMentah; 
									var dataInventoriBahanOlahan: tabelBahanOlahan);	
	{memberikan prompt kepada user untuk memasukkan perintah dan melaksanakan perintah tersebut}
									
	function lelah(dataSimulasi : tabelSimulasi; ID : integer):boolean;
	{memberikan nilai true dan sebuah pesan kesalahan apabila dataSimulasi.itemKe[ID].jumlahEnergi <=0}
	
	procedure hapusKosong(var BM : tabelBahanMentah;var BO : tabelBahanOlahan);
	{Menghapus bahan mentah dan olahan yang habis}
	
implementation

	procedure mainStartSimulasi(ID : integer;
									var dataBahanMentah : tabelBahanMentah; 
									var dataBahanOlahan : tabelBahanOlahan; 
									var dataResep : tabelResep; 
									var dataSimulasi : tabelSimulasi;
									var dataInventoriBahanMentah: tabelBahanMentah; 
									var dataInventoriBahanOlahan: tabelBahanOlahan);	
	{memberikan prompt kepada user untuk memasukkan perintah dan melaksanakan perintah tersebut}
	{KAMUS LOKAL}
	var 
		stopSimulasi: boolean;
		perintah	: string;
		jmlMakan	: integer;
		jmlIstirahat: integer;
		bahanYangDibeli : string;
		kuantitasBahanYangDibeli : integer;
	{ALGORITMA LOKAL}
	begin	
		dataSimulasi.itemKe[ID].jumlahEnergi	:= 10;
		dataSimulasi.itemKe[ID].jumlahHariHidup	:= 1;
		dataSimulasi.itemKe[ID].jumlahDuit		:= 2000000;
		dataInventoriBahanOlahan.banyakItem		:= 0;
		
		tampilkanMenu('startSimulasi');	
		
		repeat
			{inisialisasi} 
			stopSimulasi := false;
			dataSimulasi.itemKe[ID].isTidur 		:= false;
			jmlMakan := 0;
			jmlIstirahat := 0;
			
			{antarmuka}
			writeln('--------------------------------------------------');
			writeln('Selamat pagi!, hari ini tanggal: ',dataSimulasi.itemKe[ID].tanggalSimulasi.hari,'/',dataSimulasi.itemKe[ID].tanggalSimulasi.bulan,'/',dataSimulasi.itemKe[ID].tanggalSimulasi.tahun);
			writeln('Sisa Energi		: ', dataSimulasi.itemKe[ID].jumlahEnergi);
			writeln('Sisa Uang		: ', dataSimulasi.itemKe[ID].jumlahDuit);
			writeln('Jumlah Makan		: ', jmlMakan);
			writeln('Jumlah Istirahat	: ', jmlIstirahat);
			writeln('--------------------------------------------------');
			
			write('>> '); readln(perintah);
			
			case (perintah) of 
				'stopSimulasi'		: mainStopSimulasi(stopSimulasi);
				'lihatStatistik'	: mainLihatStatistik(ID, dataSimulasi);
				'lihatInventori'	: mainLihatInventori(dataInventoriBahanMentah, dataInventoriBahanOlahan);
				'lihatResep'		: mainLihatResep(ID, dataResep);
				'cariResep'			: mainCariResep(ID, dataResep);
				'tambahResep'		: mainTambahResep(ID, dataBahanMentah, dataBahanOlahan, dataResep, dataSimulasi, dataInventoriBahanMentah);
				'upgradeInventori' 	: mainUpgradeInventori(ID, dataSimulasi);
				'makan'				: mainMakan(jmlMakan, dataSimulasi.itemKe[ID].jumlahEnergi);
				'istirahat'			: mainIstirahat(jmlIstirahat, dataSimulasi.itemKe[ID].jumlahEnergi);
				'tidur'				: mainTidur(dataBahanMentah, dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan, ID, jmlMakan, jmlIstirahat);
				
				'beliBahan'			: if (lelah(dataSimulasi,ID)) then mainTidur(dataBahanMentah, dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan,ID,jmlMakan,jmlIstirahat)
									else 
									begin
										write('Nama bahan: ');
										readln(bahanYangDibeli);
										write('Kuantitas: ');
										readln(kuantitasBahanYangDibeli);
										mainBeliBahan(bahanYangDibeli, kuantitasBahanYangDibeli, ID, dataBahanMentah, dataSimulasi, dataInventoriBahanMentah);
									end;
				'olahBahan' 		: if (lelah(dataSimulasi,ID)) then mainTidur(dataBahanMentah, dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan,ID,jmlMakan,jmlIstirahat)
									else mainOlahBahan(ID,dataInventoriBahanMentah,dataBahanOlahan,dataSimulasi,dataInventoriBahanOlahan);
				
				'jualOlahan'		: if (lelah(dataSimulasi,ID)) then mainTidur(dataBahanMentah, dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan,ID,jmlMakan,jmlIstirahat)
									else mainJualOlahan(ID,dataInventoriBahanOlahan,dataSimulasi);
				
				'jualResep'			: if (lelah(dataSimulasi,ID)) then mainTidur(dataBahanMentah, dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan,ID,jmlMakan,jmlIstirahat)
									else mainJualResep(ID, dataInventoriBahanMentah, dataInventoriBahanOlahan, dataResep, dataSimulasi);
				
			end; {asumsi : perintah selalu valid}
			hapusKosong(dataInventoriBahanMentah,dataInventoriBahanOlahan);
		until (stopSimulasi) or (dataSimulasi.itemKe[ID].jumlahHariHidup>10);				
	end;
	
	function lelah(dataSimulasi : tabelSimulasi; ID : integer):boolean;
	{memberikan nilai true dan pesan kesalahan apabila dataSimulasi.itemKe[ID].jumlahEnergi <=0}
	begin
		if (dataSimulasi.itemKe[ID].jumlahEnergi <= 0) then
		begin
			writeln('Anda kelelahan, silahkan tidur');
			lelah:= true
		end
		else
			lelah:= false;
	end;
	
	procedure hapusKosong(var BM : tabelBahanMentah;var BO : tabelBahanOlahan);
	{Menghapus bahan mentah dan olahan yang habis}
	var
	i, j : integer;
	
	begin
	for i:=1 to BM.banyakItem do
		begin
		if BM.itemKe[i].jumlahTersedia<=0 then
			begin
			for j:=i to (BM.banyakItem-1) do
				BM.itemKe[j]:=BM.itemKe[j+1];
			BM.itemKe[BM.banyakItem].nama:='';
			dec(BO.banyakItem);
			end;
		end;
	for i:=1 to BO.banyakItem do
		begin
		if BO.itemKe[i].jumlahTersedia<=0 then
			begin
			for j:=i to (BO.banyakItem-1) do
				BO.itemKe[j]:=BO.itemKe[j+1];
			BO.itemKe[BO.banyakItem].nama:='';
			dec(BO.banyakItem);
			end;
		end;
	
	end;
	
end.
