unit uF12_lihatStatistik; 

interface

uses uP1_tipeBentukan, uP3_Umum;

	procedure mainLihatStatistik(ID : integer;  var dataSimulasi : tabelSimulasi); 
	{ Menampilkan data simulasi }
	

implementation

	procedure mainLihatStatistik(ID : integer;  var dataSimulasi : tabelSimulasi); 
	{ Menampilkan data simulasi }
	begin
		writeln('Jumlah Hari Hidup          : ', dataSimulasi.itemKe[ID].jumlahHariHidup);
		writeln('Jumlah Energi Saat Ini     : ', dataSimulasi.itemKe[ID].jumlahEnergi);
		writeln('Kapasitas Maximum Inventori: ', dataSimulasi.itemKe[ID].kapasitasMaxInventori);
		writeln('Total Bahan Mentah Dibeli  : ', dataSimulasi.itemKe[ID].totalBahanMentahDibeli);
		writeln('Total Bahan Olahan Dibuat  : ', dataSimulasi.itemKe[ID].totalBahanOlahanDibuat);
		writeln('Total Bahan OLahan Dijual  : ', dataSimulasi.itemKe[ID].totalBahanOlahanDijual);
		writeln('Total Resep Dijual         : ', dataSimulasi.itemKe[ID].totalResepDijual);
		writeln('Total Pemasukan            : ', dataSimulasi.itemKe[ID].totalPemasukan);
		writeln('Total Pengeluaran          : ', dataSimulasi.itemKe[ID].totalPengeluaran);
		writeln('Total Uang                 : ', dataSimulasi.itemKe[ID].jumlahDuit);
	end;

end.
