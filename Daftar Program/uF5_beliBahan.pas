unit uF5_beliBahan;

interface

uses uP1_tipeBentukan, uP3_Umum;

	procedure mainBeliBahan(bahanYangDibeli: string; kuantitas: integer; ID : integer; dataBahanMentah: tabelBahanMentah;var dataSimulasi: tabelSimulasi;//hapus parameter yang tidak perlu
									var inventoriBahanMentah : tabelBahanMentah );
	{ Menjalankan fungsi beliBahan }
	function cariKadaluarsa(bahanYangDibeli : string; dataBahanMentah : tabelBahanMentah):integer;
	{Mencari index bahanYangDibeli pada array dataBahanMentah}
	

implementation

	procedure mainBeliBahan(bahanYangDibeli: string; kuantitas: integer; ID : integer; dataBahanMentah: tabelBahanMentah;var dataSimulasi: tabelSimulasi;//hapus parameter yang tidak perlu
									var inventoriBahanMentah : tabelBahanMentah
									);
	var
		i,j,index: integer;
		ada: boolean;
		modal : longint;
	{ Menjalankan fungsi beliBahan }
	begin
		i:=1;
		ada:=false;
		while((i<=dataBahanMentah.banyakItem) and (ada=false)) do
		begin
			if(dataBahanMentah.itemKe[i].nama = bahanYangDibeli) then
				ada:=true
			else
				i:=i+1;
		end;
		{mengecek apakah bahan yang dibeli ada tidak di supermarket}
		if(ada = false) then
			writeln('Bahan yang ingin Anda beli tidak dijual disupermarket')
		else
		begin
			if(inventoriBahanMentah.banyakItem+1 <= dataSimulasi.itemKe[ID].kapasitasMaxInventori) then
			begin
				modal := dataSimulasi.itemKe[ID].jumlahDuit;
			
					if ((modal>=dataBahanMentah.itemKe[i].hargaBeli*kuantitas) and (ada)) then
					begin
						writeln('Total harga: ', dataBahanMentah.itemKe[i].hargaBeli*kuantitas);
						writeln('Pembelian Sukses');
						index:= inventoriBahanMentah.banyakItem+1; 
						
						{memasukan ke array inventoriBahanMentah}
						inventoriBahanMentah.itemKe[index].nama := bahanYangDibeli;
						
						{membuat tanggal beli}
						inventoriBahanMentah.itemKe[index].tanggalBeli := dataSimulasi.itemKe[ID].tanggalSimulasi;
						
						{membuat tanggal kadaluarsa}
						inventoriBahanMentah.itemKe[index].tanggalKadaluarsa := inventoriBahanMentah.itemKe[index].tanggalBeli;
						for j:= 1 to dataBahanMentah.itemKe[cariKadaluarsa(bahanYangDibeli, dataBahanMentah)].durasiKadaluarsa do 
						begin
							updateTanggal(inventoriBahanMentah.itemKe[index].tanggalKadaluarsa);
						end;
										
						inventoriBahanMentah.itemKe[index].jumlahTersedia := kuantitas;
						dataSimulasi.itemKe[ID].jumlahDuit:=dataSimulasi.itemKe[ID].jumlahDuit-dataBahanMentah.itemKe[i].hargaBeli*kuantitas;
						inventoriBahanMentah.banyakItem:= inventoriBahanMentah.banyakItem+1;
						dataSimulasi.itemKe[ID].totalPengeluaran:= dataSimulasi.itemKe[ID].totalPengeluaran+ dataBahanMentah.itemKe[i].hargaBeli*kuantitas;
						dataSimulasi.itemKe[ID].jumlahEnergi := dataSimulasi.itemKe[ID].jumlahEnergi-1;
					end else
					begin
						writeln('Total harga: ', dataBahanMentah.itemKe[i].hargaBeli*kuantitas);
						writeln('Pembelian Gagal');
					end;
				

			end else
				writeln('kapasitas inventori tidak mencukupi');
		end;
			
	end;
	
	function cariKadaluarsa(bahanYangDibeli : string; dataBahanMentah : tabelBahanMentah):integer;
	{Mencari index bahanYangDibeli pada array dataBahanMentah}
	{KAMUS}
	var	i : integer;
	{ALGORITMA}
	begin
		for i:=1 to dataBahanMentah.banyakItem do
		begin
			if (dataBahanMentah.itemKe[i].nama = bahanYangDibeli) then
			begin
				cariKadaluarsa := i;
				break;
			end;
		end;
	end;
	
end.
