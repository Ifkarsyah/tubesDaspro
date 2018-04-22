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
	iBO : integer;
	BO : bahanOlahan;
	s : string;
	
	begin
		writeln('Masukkan bahan yang ingin dijual');
		cariBO(found,iBO,dataBahanOlahan,s);
		if (found) and (dataBahanOlahan.itemKe[iBO].jumlahTersedia>0) then
			begin
			BO:=dataBahanOlahan.itemKe[iBO];
			dec(BO.jumlahTersedia);
			dataSimulasi.itemKe[ID].jumlahDuit:=dataSimulasi.itemKe[ID].jumlahDuit+dataBahanOlahan.itemKe[iBO].hargaJual;
			dec(dataSimulasi.itemKe[ID].jumlahEnergi);
			inc(dataSimulasi.itemKe[ID].totalBahanOlahanDijual);
			dataSimulasi.itemKe[ID].totalPemasukan:=dataSimulasi.itemKe[ID].totalPemasukan+dataBahanOlahan.itemKe[iBO].hargaJual;
			writeln('Bahan olahan ',dataBahanOlahan.itemKe[iBO].nama,' telah dijual!');
			end
		else if not(found) then
			writeln('Bahan olahan tidak ditemukan!')
		else if (dataBahanOlahan.itemKe[iBO].jumlahTersedia<=25) then
			writeln('Jumlah bahan olahan habis!');
	end;

end.
