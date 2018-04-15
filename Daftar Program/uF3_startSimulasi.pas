unit uF3_startSimulasi;

interface

uses uP1_tipeBentukan, uP2_pesan, uF4_stopSimulasi, uF11_tidur, uF5_beliBahan, uF14_lihatResep, uF15_cariResep;

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
	{ALGORITMA LOKAL}
	begin	
		repeat
			{inisialisasi}
			stopSimulasi := false;
			dataSimulasi.itemKe[ID].isTidur 		:= false;
			dataSimulasi.itemKe[ID].jumlahEnergi	:= 10;
			dataSimulasi.itemKe[ID].jumlahDuit		:= 20000;
			dataSimulasi.itemKe[ID].jumlahHariHidup	:= 1;
			
			{antarmuka}
			tampilkanMenu('startSimulasi');	
			writeln('Selamat pagi!, hari ini tanggal: ',dataSimulasi.itemKe[ID].tanggalSimulasi.hari,'/',dataSimulasi.itemKe[ID].tanggalSimulasi.bulan,'/',dataSimulasi.itemKe[ID].tanggalSimulasi.tahun);
			write('>> '); readln(perintah);
			
			case (perintah) of 
				'stopSimulasi'		: mainStopSimulasi(stopSimulasi);
				'mainTidur'			: mainTidur(dataSimulasi, dataBahanMentah, dataBahanOlahan, ID);(*
				'lihatStatistik'	: mainLihatStatistik(dataSimulasi, ID);
				'lihatInventori'	: mainLihatInventori(dataBahanMentah, dataBahanOlahan, ID);*)
				'lihatResep'		: mainLihatResep(ID, dataResep);
				'cariResep'			: mainCariResep(ID, dataResep);
				(*'tambahResep'		: mainTambahResep(dataResep, dataBahanOlahan, dataBahanMentah, ID);
				'upgradeInventori' 	: mainUpgradeInventori(dataSimulasi, ID);*)
				'beliBahan'			: mainBeliBahan(ID, dataBahanMentah, dataSimulasi, dataInventoriBahanMentah);
				(*'olahBahan' 		: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainOlahBahan();
				'jualOlahan'		: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainJualOlahan();
				'jualResep'			: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainJualResep();
				'makan'				: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainMakan();
				'istirahat'			: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainIstirahat();
				'tidur'				: if (lelah(dataSimulasi,ID)) then mainTidur(dataSimulasi,dataBahanMentah, dataOlahan, ID) else mainTidur();*)
			end; {asumsi : perintah selalu valid}
			
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
	
end.
