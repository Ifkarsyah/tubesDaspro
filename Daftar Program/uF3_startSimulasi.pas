unit uF3_startSimulasi;

interface

uses uP1_tipeBentukan, uP2_pesan,
	 uF4_stopSimulasi, uF11_tidur, uF5_beliBahan, uF8_jualResep, uF9_makan, 
	 uF6_OlahBahan, uF7_jualOlahan, uF16_tambahResep, uF17_upgradeInventori,
	 uF13_lihatInventori, uF14_lihatResep, uF15_cariResep, uF12_lihatStatistik, uF10_istirahat;

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
	{ALGORITMA LOKAL}
	begin	
		dataSimulasi.itemKe[ID].jumlahEnergi	:= 10;
		dataSimulasi.itemKe[ID].jumlahHariHidup	:= 1;
		dataSimulasi.itemKe[ID].jumlahDuit		:= 20000;
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
				//'lihatResep'		: mainLihatResep(ID, dataResep);
				//'cariResep'			: mainCariResep(ID, dataResep);
				'tambahResep'		: mainTambahResep(ID, dataBahanMentah, dataBahanOlahan, dataResep, dataSimulasi, dataInventoriBahanMentah);
				'upgradeInventori' 	: mainUpgradeInventori(ID, dataSimulasi);
				'makan'				: mainMakan(jmlMakan, dataSimulasi.itemKe[ID].jumlahEnergi);
				'istirahat'			: mainIstirahat(ID, dataSimulasi);
				'tidur'				: mainTidur(dataSimulasi, dataInventoriBahanMentah, dataInventoriBahanOlahan, ID, jmlMakan, jmlIstirahat);
				'beliBahan'			: mainBeliBahan(ID, dataBahanMentah, dataSimulasi, dataInventoriBahanMentah);
				'olahBahan' 		: mainOlahBahan(ID,dataInventoriBahanMentah,dataBahanOlahan,dataSimulasi,dataInventoriBahanOlahan);
				'jualOlahan'		: mainJualOlahan(ID,dataInventoriBahanOlahan,dataSimulasi);
				'jualResep'			: if (not(lelah(dataSimulasi,ID))) then  mainJualResep(ID, dataInventoriBahanMentah, dataInventoriBahanOlahan, dataResep, dataSimulasi);
				
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
			//mainTidur(dataSimulasi,dataBahanMentah, dataBahanOlahan, ID, jmlMakan);
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
