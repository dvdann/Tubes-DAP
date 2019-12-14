//Nama : Daniel Septyadi//
//Kelas : IF-42-07//
//NIM : 1301180009//
//TYPE SORTING : INSERTION SORT//
//APLIKASI SUPER MARKET//
{=====================================================================================}
program aplikasisupermarket;
{Diskon didapatkan sesuai jenis member. Member Gold = 50%, Silver = 25%, PLATINUM = 10%.
Diskon tambahan jika pembelian dilakukan di setiap tanggal terakhir di setiap bulan, yaitu sebesar 5%.
Diskon tambahan akan didapatkan jika customer tsb sudah berbelanja total Rp. 1.000.000 selama 1 bulan}
uses crt;
const
    nMax = 100;
type struk = record
    idStruk, jenisMember : String;
    tanggal, bulan, tahun, diskon : integer;
    jmlh_awal, jmlh_setelahdiskon : real;
end;

    arrStruk = array [1..nMax] of struk;

var
    listStruk : arrStruk;
    i,pilih : integer;
{=====================================================================================}
function periksatanggal(inputtanggal, inputBulan: integer) : boolean;
{MENGECEK APAKAH inPUTAN TANGGAL DAN BULAN BENAR ATAU SALAH
 TRUE JIKA SALAH INPUT}
begin
  periksatanggal := false;
  if ((inputtanggal <= 31) or (inputtanggal >= 1) or (inputBulan <= 12) or (inputBulan >= 1)) then
    begin
      if ((inputBulan = 2) and (inputtanggal > 28)) then
        begin
          periksatanggal := true;
        end
      else if ((inputBulan = 4) or (inputBulan = 6) or (inputBulan = 8) or (inputBulan = 11) and (inputtanggal > 30)) then
        begin
          periksatanggal := true;
        end
      else if ((inputBulan = 1) or (inputBulan = 3) or (inputBulan = 5) or (inputBulan = 7) or (inputBulan = 10) and (inputtanggal > 31)) then
        begin
          periksatanggal := true;
        end;
    end;
end;
{=====================================================================================}
function periksamember(inputmember : integer) : boolean;
{MENGECEK APAKAH INPUTAN KODE MEMBER BENAR ATAU SALAH
 TRUE JIKA SALAH INPUT}
begin
  periksamember := true;
  if(inputmember in [1,2,3]) then
    begin
      periksamember := false;
    end;
end;
{=====================================================================================}
function diskonmember(inputmember : integer ) : integer;
{MENCARI DISKON BERDASARKAN KODE MEMBER
 DISKON YANG DIDAPATKAN MEMBER}
var
  diskon : integer;
begin
  case inputmember of
    1 : diskon:= 50;
    2 : diskon:= 25;
    3 : diskon:= 10;
  end;
  diskonmember := diskon;
end;
{=====================================================================================}
function Kodemember(inputmember : integer) : String;
var
  Kode : string;
begin
  case inputmember of
    1 : Kode := 'GOLD';
    2 : Kode := 'SILVER';
    3 : Kode := 'PLATINUM';
  end;
  Kodemember := Kode;
end;
{=====================================================================================}
function diskonakhirbulan(inputtanggal : integer; inputBulan : integer; inputjmlh_awal : real): integer;
{MENGECEK APAKAH MEMBER BERTRANSAKSI DIAKHIR BULAN DAN MELEBIHI SATU JUTA
 +5 DISKON}
begin
    diskonakhirbulan := 0;
  if((inputBulan = 1) or (inputBulan = 3) or (inputBulan = 5) or (inputBulan = 7) or (inputBulan = 10) and (inputtanggal = 31) and (inputjmlh_awal >= 1000000)) then
    begin
      diskonakhirbulan := 5;
    end
  else if ((inputBulan = 4) or (inputBulan = 6) or (inputBulan = 8) or (inputBulan = 11) and (inputtanggal = 30) and (inputjmlh_awal >= 1000000)) then
    begin
      diskonakhirbulan := 5;
    end
  else if ((inputBulan = 2) and (inputtanggal = 28) and (inputjmlh_awal >= 1000000)) then
    begin
      diskonakhirbulan := 5;
    end;
end;
{=====================================================================================}
function jumlahbayarsetelahdiskon(i : integer; listStruk : arrStruk) : real;
{MENDAPATKAN JUMLAH AFTER DISKON}
begin
    jumlahbayarsetelahdiskon:= (listStruk[i].jmlh_awal - ((listStruk[i].jmlh_awal * listStruk[i].diskon) / 100));
end;
{=====================================================================================}
function cekArrayMax(i : integer) : boolean;
{MENGECEK APAKAH SUDAH MAX ATAU BELUM
 TRUE JIKA SUDAH MAX}
begin
  cekArrayMax := false;
  if (i = nMAx) then
    begin
      cekArrayMax := true;
    end;
end;
{=====================================================================================}
function searchKosong(listStruk : arrStruk): integer;
{MENCARI INDEX YANG KOSONG
 NILAI INDEX YANG KOSONG}
var
  search : integer;
  found : boolean;
begin
  found := false;
  search := 1;
  while  ((not found) or (search <= nMax)) do
    begin
      if((listStruk[search].idStruk = '') or (not found)) then
        begin
          found := true;
          searchKosong := search;
        end
      else
        begin
          search := search + 1;
        end;
    end;
end;
{=====================================================================================}
procedure tampilkanlistbarang (i : integer; listStruk : arrStruk);
{listBarang terdefinisi
  menampilkan isi dari listBarang}
begin
    writeln('ID Struk                 : ',listStruk[i].idStruk);
    writeln('Tanggal                  : ',listStruk[i].tanggal);
    writeln('Bulan                    : ',listStruk[i].bulan);
    writeln('Tahun                    : ',listStruk[i].tahun);
    writeln('Jenis Member             : ',listStruk[i].jenisMember);
    writeln('Diskon                   : ',listStruk[i].diskon);
    writeln('Jumlah Awal              : ',listStruk[i].jmlh_awal:0:2);
    writeln('Jumlah Setelah Diskon    : ',listStruk[i].jmlh_setelahdiskon:0:2);
    writeln;
end;
{=====================================================================================}
function ceklistbarang (N : integer; inputdataID : String; listStruk : arrStruk) : integer;
{MENGECEK APAKAH BARANG YANG DICARI DIDALAM LISTBARANG}
var
  i : integer;
  found : boolean;
begin
  found:=false;
  i := 1;
  ceklistbarang := 0;
  while ((i <= N) and (not found)) do
    begin
      if (inputdataID = listStruk[i].idStruk) then
        begin
          ceklistbarang := i;
          found:=true;
        end
      else
        i := i + 1;
    end;
end;
{=====================================================================================}
procedure inputData(var i : integer; var listStruk : arrStruk);
{ARRAY TERDEFINISI
ARRAY DIISI INPUTAN USER}
var
  kalimat : string;
  inputtanggal, inputBulan, inputTahun, inputmember, inputdisini : integer;
  inputjmlh_awal : real;
  ulang : char;
begin
  clrscr;
  ulang := 'Y';
  while (ulang = 'Y') or (ulang = 'y') do
  {ulangin ketika user menginputkan huruf Y atau y}
    begin
      write('ingin menambah struk ? [Y/N] = ');
      readln(ulang);
      clrscr;
      if (ulang = 'Y') or (ulang = 'y') then
        begin
          if (not cekArrayMax(i)) then
            begin
              write('Masukan Tanggal Transaksi [1-31] : ');
              readln(inputtanggal);
              write('Masukan Bulan Transaksi [1-12]   : ');
              readln(inputBulan);
              write('Masukan Tahun Transaksi          : ');
              readln(inputTahun);
              writeln('Masukan Jenis Member            ');
              writeln('[1] = GOLD, [2] = SILVER, [3] = PLATINUM');
              write('Jenis Member                     : ');
              readln(inputmember);
              write('Masukan Jumlah Awal Transaksi    : ');
              readln(inputjmlh_awal);
              if((not periksatanggal(inputtanggal, inputBulan)) and (not periksamember(inputmember))) then
                begin
                  i := i + 1;
                  str(i, kalimat);
                  listStruk[i].idStruk            := 'ID00'+ kalimat;
                  listStruk[i].tanggal            := inputtanggal;
                  listStruk[i].bulan              := inputBulan;
                  listStruk[i].tahun              := inputTahun;
                  listStruk[i].jenisMember        := Kodemember(inputmember);
                  listStruk[i].diskon             := diskonmember(inputmember) +  diskonakhirbulan(inputBulan, inputtanggal, inputjmlh_awal);
                  listStruk[i].jmlh_awal          := inputjmlh_awal;
                  listStruk[i].jmlh_setelahdiskon := jumlahbayarsetelahdiskon(i, listStruk);
                  clrscr;
                end
              else
                begin
                  clrscr;
                  write('TANGGAL DAN BULAN PADA INPUTAN TIDAK SESUAI! MOHON KOREKSI');
                  readln;
                  clrscr;
                end;
            end
		  else
            begin
            if(searchKosong(listStruk) <> 0) then
                begin
                  inputdisini := searchKosong(listStruk);
                  str(inputdisini, kalimat);
                  listStruk[inputdisini].idStruk            := 'ID00'+ kalimat;
                  listStruk[inputdisini].tanggal            := inputtanggal;
                  listStruk[inputdisini].bulan              := inputBulan;
                  listStruk[inputdisini].tahun              := inputTahun;
                  listStruk[inputdisini].jenisMember        := Kodemember(inputmember);
                  listStruk[inputdisini].diskon             := diskonmember(inputmember) +  diskonakhirbulan(inputBulan, inputtanggal, inputjmlh_awal);
                  listStruk[inputdisini].jmlh_awal          := inputjmlh_awal;
                  listStruk[inputdisini].jmlh_setelahdiskon := jumlahbayarsetelahdiskon(inputdisini, listStruk);
                end
            else
                begin
                  clrscr;
                  write('INDEX ARRAY SUDAH PENUH!');
                end;
            end;
        end;
    end;
end;
{=====================================================================================}
procedure showdata(var i:integer ; var listStruk : arrStruk);
{listStruk terdefinisi
 menampilkan isi dari listStruk}
var
    show : integer;
begin
    clrscr;
    show := 1;
    while (show <= i)do
    begin
        writeln('ID Struk                 : ',listStruk[show].idStruk);
        writeln('Tanggal                  : ',listStruk[show].tanggal);
        writeln('Bulan                    : ',listStruk[show].bulan);
        writeln('Tahun                    : ',listStruk[show].tahun);
        writeln('Jenis Member             : ',listStruk[show].jenisMember);
        writeln('Diskon                   : ',listStruk[show].diskon);
        writeln('Jumlah Awal              : ',listStruk[show].jmlh_awal:0:2);
        writeln('Jumlah Setelah Diskon    : ',listStruk[show].jmlh_setelahdiskon:0:2);
        writeln;
        show := show + 1;
    end;
end;
{=====================================================================================}
procedure editdata(var i : integer; var listStruk : arrStruk);
var
  dilihat,member : integer;
  inputdataID : String;
begin
  clrscr;
  write('MASUKKAN ID DATA YANG INGIN DIUBAH (Ex : ID001) : ');
  readln(inputdataID);
  dilihat :=  ceklistbarang(i, inputdataID, listStruk);
  if(dilihat <> 0) then
    begin
      writeln('Data Awal Barang ');
      tampilkanlistbarang (dilihat, listStruk);
      writeln('Data Baru Barang ');
      write('Tanggal [1-31]        : ');
      readln(listStruk[dilihat].tanggal);
      write('Bulan   [1-12]        : ');
      readln(listStruk[dilihat].bulan);
      write('Tahun                 : ');
      readln(listStruk[dilihat].tahun);
      writeln('[1] = GOLD, [2] = SILVER, [3] = PLATINUM');
      write('Jenis Member          : ');
      readln(member);
      listStruk[dilihat].jenisMember := Kodemember(member);
      write('Jumlah Awal           : ');
      readln(listStruk[dilihat].jmlh_awal);
      listStruk[dilihat].diskon := diskonmember(member) +  diskonakhirbulan(listStruk[dilihat].bulan, listStruk[dilihat].tanggal, listStruk[dilihat].jmlh_awal);
      listStruk[dilihat].jmlh_setelahdiskon := jumlahbayarsetelahdiskon(dilihat,listStruk);
      writeln('SUKSES MENGEDIT DATA! ');
      writeln;
      clrscr;
    end
  else
    begin
      writeln('ID DATA TIDAK DITEMUKAN!');
    end;
end;
{=====================================================================================}
procedure deletedata(var i : integer; var listStruk : arrStruk);
var
  inputdataID : string;
  show,dilihat : integer;
begin
  clrscr;
  write('MASUKKAN ID DATA YANG INGIN DIHAPUS (Ex. ID001 : ');
  readln(inputdataID);
  dilihat :=  ceklistbarang(i, inputdataID, listStruk);
  if(dilihat <> 0) then
    begin
      for show := dilihat to i-1 do
      begin
        listStruk[show].idStruk := listStruk[show+1].idStruk;
        listStruk[show].tanggal := listStruk[show+1].tanggal;
        listStruk[show].bulan := listStruk[show+1].bulan;
        listStruk[show].tahun := listStruk[show+1].tahun;
        listStruk[show].jenisMember := listStruk[show+1].jenisMember;
        listStruk[show].diskon := listStruk[show+1].diskon;
        listStruk[show].jmlh_awal := listStruk[show+1].jmlh_awal;
        listStruk[show].jmlh_setelahdiskon := listStruk[show+1].jmlh_setelahdiskon;
      end;
        i := i - 1;
        writeln('SUKSES MENGHAPUS BARANG! ');
        readln;
        clrscr;
    end
  else
    begin
      writeln('ID DATA TIDAK DITEMUKAN!');
    end;
end;
{=====================================================================================}
procedure searchdata(i : integer; listStruk : arrStruk);
var
  m,j,cari1,cari2 : integer;
  cek : boolean;
begin
  write('Masukkan Bulan : ');
  readln(cari1);
  write('Masukkan Tahun : ');
  readln(cari2);
  cek := false;
  writeln;
  writeln('       Hasil Pencarian Data dengan Bulan ',cari1,' dan Tahun ',cari2);
  writeln('==========================================================================');
  m := 0;
  for j := 1 to i do
    begin
      if (listStruk[j].bulan = cari1) and (listStruk[j].tahun = cari2) then
      begin
          m := m+1;
          writeln('ID Struk              : ',listStruk[j].idStruk);
          writeln('Tanggal               : ',listStruk[j].tanggal);
          writeln('Bulan                 : ',listStruk[j].bulan);
          writeln('Tahun                 : ',listStruk[j].tahun);
          writeln('Jenis Member          : ',listStruk[j].jenisMember);
          writeln('Diskon                : ',listStruk[j].diskon);
          writeln('Jumlah Awal           : ',listStruk[j].jmlh_awal:0:2);
          writeln('Jumlah Setelah Diskon : ',listStruk[j].jmlh_setelahdiskon:0:2);
          writeln;
          cek := true;
      end;
    end;
    if not cek then
    begin
      writeln('              TIDAK ADA DATA BULAN ',cari1,' PADA TAHUN ',cari2,'     ');
       writeln('==============================================================================')
    end;
end;
{=====================================================================================}
procedure insertionsort (var N : integer; var listStruk : arrStruk);
{Harga Awal di tampilkan secara acak
Mengubah urutan data pada list berdasarkan harga awal tertinggi}
var
    i,j : integer;
    temp : struk;
begin
    clrscr;
    for i := 1 to N-1 do
    begin
        for j := i+1 to N do
        begin
            if(listStruk[j].jmlh_setelahdiskon < listStruk[i].jmlh_setelahdiskon) then
            begin
                temp := listStruk[j];
                listStruk[j] := listStruk[i];
                listStruk[i] := temp;
            end;
        end;
    end;
    writeln('SUKSES MENGURUTKAN, SILAHKAN CEK TAMPILKAN DATA');
end;
{=====================================================================================}
procedure Menu();
begin
  i := 0;
  repeat
    begin
      clrscr;
      writeln('====================APLIKASI SUPER MARKET=====================');
      writeln(' ');
      writeln('1. Input List Struk');
      writeln('2. Show Data Struk');
      writeln('3. Edit Data Struk');
      writeln('4. Delete Data Struk');
      writeln('5. Search Data Struk');
      writeln('6. Shorting Data Struk');
      writeln('0. Exit Program');
      writeln;
      write('Masukkan Pilihan : ');
      readln(pilih);
      case pilih of
        1 : inputData(i,listStruk);
        2 : showdata(i,listStruk);
        3 : editdata(i,listStruk);
        4 : deletedata(i,listStruk);
        5 : searchdata(i,listStruk);          
        6 : insertionsort(i,listStruk);
        0 : writeln('TERIMA KASIH');
      end;
      readln;
    end;
  until (pilih = 0);
end;
{=====================================================================================}
begin
  Menu();
end.
