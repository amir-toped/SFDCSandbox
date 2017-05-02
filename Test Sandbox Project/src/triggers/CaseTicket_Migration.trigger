trigger CaseTicket_Migration on Case (before insert, before update) {
    for(case x:trigger.new){
        if(x.migration__c == true){
            if(x.duplicate_key__c != null){
                List<Account> acc = [select id, PersonContactId from account where Duplicate_Key__c =: x.duplicate_key__c];
                if(acc.size()>0){
                    for(account ac:acc){
                        x.accountid = ac.id;
                        x.contactid = ac.PersonContactId;    
                    }
                    
                }
            }
            //digital
            String produk = String.isNotBlank(x.Produk_Tokopedia__c) ? x.Produk_Tokopedia__c.toLowerCase() : 'other' ;
            String subjek = x.subject.toLowerCase();
            String description = x.description.toLowerCase();
            if(subjek!=null){
                if(subjek.contains('pulsa tidak masuk') == true ){
                    x.Case_SubCategory_1__c = 'Pulsa Tidak Masuk'; 
                    x.Category__c = 'Pulsa';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('pengisian pulsa selalu gagal') == true ){
                    x.Case_SubCategory_1__c = 'Pengisian Pulsa Selalu Gagal';
                    x.Category__c = 'Pulsa';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('kendala pembayaran') == true && produk.contains('pulsa')== true){
                    x.Case_SubCategory_1__c = 'Kendala Pembayaran';
                    x.Category__c = 'Pulsa';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('salah mengisi nomor telepon') == true ){
                    x.Case_SubCategory_1__c = 'Salah mengisi nomor telepon';
                    x.Category__c = 'Pulsa';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('paket data') == true ){
                    x.Category__c = 'Paket Data';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('bpjs') == true ){
                    x.Category__c = 'BPJS';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('pln') == true){
                    x.Category__c = 'PLN';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('saldo') == true){
                    x.Category__c = 'Saldo';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('voucher game') == true){
                    x.Category__c = 'Voucher Game';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('air') == true || subjek.contains('pdam') == true  ){
                    x.Category__c = 'Air';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('angsuran kredit') == true ){
                    x.Category__c = 'Angsuran Kredit';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('donasi') == true ){
                    x.Category__c = 'Donasi';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('pascabayar') == true ){
                    x.Category__c = 'Pascabayar';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('tv kabel') == true ){
                    x.Category__c = 'TV Kabel';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('seluler') == true || subjek.contains('telepon') == true ){
                    x.Category__c = 'Telepon';
                    x.RecordTypeId = label.RecID;
                }
                else if(subjek.contains('tokocash') == true && description.contains('kendala transaksi') == true){
                    x.Category__c = 'Tokocash';
                    x.RecordTypeId = label.RecID;
                    x.Case_SubCategory_1__c = 'Kendala Transaksi';
                }
                else if(subjek.contains('tokocash') == true && description.contains('kendala top up') == true){
                    x.Category__c = 'Tokocash';
                    x.RecordTypeId = label.RecID;
                    x.Case_SubCategory_1__c = 'Kendala Top Up';
                }
                else if(subjek.contains('tokocash') == true && description.contains('penerimaan dana') == true){
                    x.Category__c = 'Tokocash';
                    x.RecordTypeId = label.RecID;
                    x.Case_SubCategory_1__c = 'Penerimaan Dana';
                }
                else if(subjek.contains('tokocash') == true && description.contains('pengiriman dana') == true){
                    x.Category__c = 'Tokocash';
                    x.RecordTypeId = label.RecID;
                    x.Case_SubCategory_1__c = 'Pengiriman Dana';
                }
                else if(subjek.contains('tokocash') == true ){
                    x.Category__c = 'Tokocash';
                    x.RecordTypeId = label.RecID;
                    x.Case_SubCategory_1__c = 'Kendala Tokocash Lainnya';
                }
                //Train
                else if(subjek.contains('kode booking tidak valid') == true){
                    x.Category__c = 'Tiket Kereta';
                    x.RecordTypeId = label.RecID_Train;
                    x.Case_SubCategory_1__c = 'Data pada kode booking salah';
                }
                else if(subjek.contains('pembelian tiket gagal') == true){
                    x.Category__c = 'Tiket Kereta';
                    x.Case_SubCategory_1__c = 'Pembelian tiket gagal dan dana terpotong';
                    x.RecordTypeId = label.RecID_Train;
                }
                else if(subjek.contains('pencarian tiket gagal') == true){
                    x.Category__c = 'Tiket Kereta';
                    x.RecordTypeId = label.RecID_Train;
                    x.Case_SubCategory_1__c = 'Pencarian tiket gagal';
                }
                else if(subjek.contains('transaksi dengan kode voucher gagal') == true){
                    x.Category__c = 'Tiket Kereta';
                    x.RecordTypeId = label.RecID_Train;
                    x.Case_SubCategory_1__c = 'Transaksi dengan kode voucher gagal';
                }
            }
            /*
                //else if(produk.contains('Pulsa') == true){
                if(produk.contains('pulsa')==true){
                    x.Category__c = 'Others';
                    x.RecordTypeId = label.RecID;
                }    
            */
            List<String> listdesc = description.split('\\s');	
            if(x.Category__c==null){
                	if(description.contains('ganti hp') == true || description.contains('ubah hp') == true){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Kendala Login';
                        x.Sub_Category2__c = 'Ubah nomor Handphone';
                        
                    }
					else if(description.contains('lupa password') == true || description.contains('lupa kata sandi') == true || description.contains('lupa sandi') == true || description.contains('kata sandi') == true){
                        x.Category__c = 'Akun';
                        x.Case_SubCategory_1__c = 'Kendala Login';
                        x.Sub_Category2__c = 'Lupa kata sandi';
                        x.RecordTypeId = label.RecID_NoInv;
                        
                    }
					else if(description.contains('mengatas namakan tokopedia') == true ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Laporan scam';
                        
                    }
                    else if(description.contains('kendala teknis akun') == true ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Kendala teknis akun';
                        
                    }
                    
                    else if(description.contains('gm belum aktif') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Gold Merchant';
                        x.Sub_Category2__c = 'Belum aktif';
                        
                    }
                    else if(description.contains('statistik gm') == true || description.contains('statistik gold merchant') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Gold Merchant';
                        x.Sub_Category2__c = 'Statistik';
                        
                    }
                    else if(description.contains('logo gm') == true || description.contains('lambang gm') == true || description.contains('logo gold merchant') == true || description.contains('lambang gold merchant') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Gold Merchant';
                        x.Sub_Category2__c = 'Badge tidak muncul';
                        
                    }
                    else if(description.contains('gold merchant') == true || description.contains('langganan gm') == true || description.contains('perpanjang gm') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Gold Merchant';
                        x.Sub_Category2__c = 'Belum diperpanjang';
                        
                    }
                   
                    else if(description.contains('iklan topads') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'TopAds';
                        x.Sub_Category2__c = 'Iklan belum muncul';
                        
                    }
                    else if(description.contains('topads tidak terkirim') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'TopAds';
                        x.Sub_Category2__c = 'Produk tidak aktif';
                        
                    }
                     else if(description.contains('kredit topads') == true || description.contains('saldo topads') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'TopAds';
                        x.Sub_Category2__c = 'Kredit belum bertambah';
                        
                    }
                    else if(description.contains('admin toko') == true || description.contains('tambah admin') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Admin Toko';
                        
                    }
                    else if(description.contains('etalase hilang') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Etalase';
                        x.Sub_Category2__c = 'Etalase hilang';
                        
                    }
                    else if(description.contains('produk hilang') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Etalase';
                        x.Sub_Category2__c = 'Produk tidak muncul di etalase';
                        
                    }
                    else if(description.contains('free return') == true && description.contains('produk tidak aktif') == true){
                        x.Category__c = 'Juala';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Free Return';
                        x.Sub_Category2__c = 'Status produk tidak aktif';
                        
                    }
                    else if(description.contains('free return') == true && description.contains('berhenti berlangganan') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Free Return';
                        x.Sub_Category2__c = 'Berhenti berlangganan';
                        
                    }
                    else if(description.contains('produk tidak muncul') == true && description.contains('etalase') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Tidak muncul di etalase';
                        
                    }
                    else if(description.contains('gambar produk') == true || description.contains('foto produk') == true || description.contains('gambar hilang') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Gambar hilang';
                        
                    }
                    else if((description.contains('gagal upload') == true || description.contains('gagal tambah') == true) && description.contains('produk') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Gambar upload';
                        
                    }
                    else if(description.contains('produk dihapus') == true || description.contains('produk hilang') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Dibanned';
                        
                    }
					else if(description.contains('kolom pencarian') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Tidak muncul di pencarian';
                        
                    }
                    else if(description.contains('persentase transaksi') == true || description.contains('persentase berhasil') == true || description.contains('transaksi sukses produk') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Persentase transaksi berhasil';
                        
                    }
                    else if(description.contains('poin reputasi') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Reputasi Toko';
                        x.Sub_Category2__c = 'Jumlah reoutasi tidak sesuai';
                        
                    }
                    else if(description.contains('produk terjual') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Statistik Toko';
                        x.Sub_Category2__c = 'Statistik produk terjual';
                        
                    }
                    else if((description.contains('transaksi berhasil') == true || description.contains('transaksi sukses') == true) && description.contains('statistik') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Statistik Toko';
                        x.Sub_Category2__c = 'Statistik transaksi berhasil';
                        
                    }
					else if(description.contains('kota asal belum tersedia') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Pengaturan Pengiriman';
                        x.Sub_Category2__c = 'Kota asal belum tersedia';
                        
                    }
                    else if((description.contains('check out cc') == true || description.contains('bayar') == true || description.contains('check out credit card') == true || description.contains('bayar credit card') == true || description.contains('cc') == true || description.contains('bayar cc') == true || description.contains('credit card') == true || description.contains('cicil') == true || description.contains('instalment') == true || description.contains('installment') == true) && description.contains('gagal') == true){
                        x.Category__c = 'Gagal Checkout';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Credit Card';
                        x.Sub_Category2__c = 'Dana terdebat';
                        
                    }
                    else if((description.contains('kartu kredit') == true || description.contains('cc') == true ) && description.contains('tidak bisa') == true){
                        x.Category__c = 'Gagal Checkout';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Credit Card';
                        x.Sub_Category2__c = 'Kartu tidak bisa digunakan';
                        
                    }
                    else if((description.contains('klik bca') == true || description.contains('click bca') == true || description.contains('klik pay') == true || description.contains('ecash') == true || description.contains('epay') == true || description.contains('indomaret') == true || description.contains('alfa') == true || description.contains('sevel') == true || description.contains('pospay') == true || description.contains('clickpay') == true || description.contains('bniva') == true || description.contains('briva') == true || description.contains('saldo') == true) && description.contains('gagal') == true){
                        x.Category__c = 'Gagal Checkout';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Instant payment lainnya';
                        
                    }
                    else if((description.contains('withdraw') == true || description.contains('tarik dana') == true ) && description.contains('belum masuk') == true){
                        x.Category__c = 'Tarik Dana';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Dana belum masuk rekening';
                        
                    }
                    else if((description.contains('withdraw') == true || description.contains('data tarik dana') == true || description.contains('rekening tarik dana') == true ) && description.contains('salah') == true){
                        x.Category__c = 'Tarik Dana';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Salah data saat tarik dana';
                        
                    }
                    else if(description.contains('tarik dana') == true && description.contains('kembali saldo') == true){
                        x.Category__c = 'Tarik Dana';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Dana WD kembali ke saldo Tokopedia';
                        
                    }
                    else if((description.contains('kota') == true || description.contains('tujuan') == true ) && description.contains('pengiriman') == true){
                        x.Category__c = 'Pengiriman';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Tujuan pengiriman belum tersedia';
                        
                    }
                    
                    else if((description.contains('pulsa') == true || description.contains('paket data') == true || description.contains('bpjs') == true || description.contains('pln') == true || description.contains('saldo') == true || description.contains('voucher game') == true || description.contains('air') == true || description.contains('angsuran kredit') == true || description.contains('donasi') == true || description.contains('pascabayar') == true || description.contains('tv kabel') == true || description.contains('telepon') == true ) && description.contains('input voucher') == true){
                        x.Category__c = 'Promo';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Promo Digital';
                        
                    }
                    else if(description.contains('input voucher') == true && (description.contains('tiket') == true || description.contains('kereta') == true || description.contains('kai') == true)){
                        x.Category__c = 'Promo';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Promo Tiketkereta';
                        
                    }
                    else if(description.contains('input voucher') == true){
                        x.Category__c = 'Promo';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Promo Marketplace';
                        
                    }
            }
            if(listdesc.size()>0 && x.Category__c== null){
                for(String des:listdesc){
                    if(des.contains('otp') == true){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Kendala Login';
                        x.Sub_Category2__c = 'Tidak menerima kode OTP';
                        break;
                    }
                    
                    else if(des.contains('sandi') == true || des.contains('password') == true ){
                        x.Category__c = 'Akun';
                        x.Case_SubCategory_1__c = 'Kendala Login';
                        x.Sub_Category2__c = 'Lupa kata sandi';
                        x.RecordTypeId = label.RecID_NoInv;
                        break;
                    }
                    else if(des.contains('hack') == true || des.contains('retas') == true || des.contains('salahgunakan') == true || des.contains('penyalahgunaan') == true ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Akun dihack';
                        break;
                    }
                    else if(des.contains('blok') == true || des.contains('blokir') == true || des.contains('ban') == true || des.contains('banned') == true ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Akun diblokir';
                        break;
                    }
                    else if( description.contains('sandi') == true || description.contains('password') == true ){
                        x.Category__c = 'Akun';
                        x.Case_SubCategory_1__c = 'Kendala Login';
                        x.Sub_Category2__c = 'Lupa kata sandi';
                        x.RecordTypeId = label.RecID_NoInv;
                        break;
                    }
					else if(des.contains('pishing') == true || des.contains('phising') == true || des.contains('phishing') == true || des.contains('inbox') == true ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Laporan phishing';
                        break;
                    }
                    
                    else if(des.contains('pengawasan') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Produk';
                        x.Sub_Category2__c = 'Dalam pengawasan';
                        break;
                    }
                    
                    else if(des.contains('smiley') == true || des.contains('rating') == true){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Statistik Toko';
                        x.Sub_Category2__c = 'Statistik kepuasan toko';
                        break;
                    }
                    
					else if(des.contains('penipuan') == true || des.contains('scam') == true  ){
                        x.Category__c = 'Akun';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Laporan scam';
                        break;
                    }
					else if(des.contains('gm') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'Gold Merchant';
                        x.Sub_Category2__c = 'Belum diperpanjang';
                        break;
                    }
					 else if(des.contains('topads') == true ){
                        x.Category__c = 'Jualan';
                        x.RecordTypeId = label.RecID_NoInv;
                        x.Case_SubCategory_1__c = 'TopAds';
                        x.Sub_Category2__c = 'Kredit belum bertambah';
                        break;
                    }
                    else if(des.contains('kritik') == true || des.contains('saran') == true){
                        x.Category__c = 'Kritik dan Saran';
                        x.RecordTypeId = label.RecID_NoInv;
                        break;
                    }
                    else {
                        x.Category__c = 'Others';
                        x.RecordTypeId = label.RecID_NoInv;
                        break;
                    }
                }
            }
            
            /*
            if(description!=null){
                //without invoice
                if(description.contains('otp') == true){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Kendala Login';
                    x.Sub_Category2__c = 'Tidak menerima kode OTP';
                }
                else if(description.contains('ganti hp') == true || description.contains('ubah hp') == true){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Kendala Login';
                    x.Sub_Category2__c = 'Ubah nomor Handphone';
                }
                else if(description.contains('lupa password') == true || description.contains('lupa kata sandi') == true || description.contains('lupa sandi') == true || description.contains('sandi') == true || description.contains('password') == true || description.contains('kata sandi') == true){
                    x.Category__c = 'Akun';
                    x.Case_SubCategory_1__c = 'Kendala Login';
                    x.Sub_Category2__c = 'Lupa kata sandi';
                    x.RecordTypeId = label.RecID_NoInv;
                }
                else if(description.contains('hack') == true || description.contains('retas') == true || description.contains('salahgunakan') == true || description.contains('penyalahgunaan') == true ){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Akun dihack';
                }
                else if(description.contains('blok') == true || description.contains('blokir') == true || description.contains('ban') == true || description.contains('banned') == true ){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Akun diblokir';
                }
                else if(description.contains('pishing') == true || description.contains('phising') == true || description.contains('phishing') == true || description.contains('inbox') == true ){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Laporan phishing';
                }
                else if(description.contains('penipuan') == true || description.contains('scam') == true || description.contains('mengatas namakan tokopedia') == true ){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Laporan scam';
                }
                else if(description.contains('kendala teknis akun') == true ){
                    x.Category__c = 'Akun';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Kendala teknis akun';
                }
                
                else if(description.contains('gm belum aktif') == true ){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Gold Merchant';
                    x.Sub_Category2__c = 'Belum aktif';
                }
                else if(description.contains('statistik gm') == true || description.contains('statistik gold merchant') == true ){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Gold Merchant';
                    x.Sub_Category2__c = 'Statistik';
                }
                else if(description.contains('logo gm') == true || description.contains('lambang gm') == true || description.contains('logo gold merchant') == true || description.contains('lambang gold merchant') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Gold Merchant';
                    x.Sub_Category2__c = 'Badge tidak muncul';
                }
                else if(description.contains('gm') == true || description.contains('gold merchant') == true || description.contains('langganan gm') == true || description.contains('perpanjang gm') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Gold Merchant';
                    x.Sub_Category2__c = 'Belum diperpanjang';
                }
                else if(description.contains('topads') == true || description.contains('kredit topads') == true || description.contains('saldo topads') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'TopAds';
                    x.Sub_Category2__c = 'Kredit belum bertambah';
                }
                else if(description.contains('iklan topads') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'TopAds';
                    x.Sub_Category2__c = 'Iklan belum muncul';
                }
                else if(description.contains('topads tidak terkirim') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'TopAds';
                    x.Sub_Category2__c = 'Produk tidak aktif';
                }
                else if(description.contains('admin toko') == true || description.contains('tambah admin') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Admin Toko';
                }
                else if(description.contains('etalase hilang') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Etalase';
                    x.Sub_Category2__c = 'Etalase hilang';
                }
                else if(description.contains('produk hilang') == true && description.contains('etalase') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Etalase';
                    x.Sub_Category2__c = 'Produk tidak muncul di etalase';
                }
                else if(description.contains('free return') == true && description.contains('produk tidak aktif') == true){
                    x.Category__c = 'Juala';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Free Return';
                    x.Sub_Category2__c = 'Status produk tidak aktif';
                }
                else if(description.contains('free return') == true && description.contains('berhenti berlangganan') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Free Return';
                    x.Sub_Category2__c = 'Berhenti berlangganan';
                }
                else if(description.contains('produk tidak muncul') == true && description.contains('etalase') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Tidak muncul di etalase';
                }
                else if(description.contains('gambar produk') == true || description.contains('foto produk') == true || description.contains('gambar hilang') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Gambar hilang';
                }
                else if((description.contains('gagal upload') == true || description.contains('gagal tambah') == true) && description.contains('produk') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Gambar upload';
                }
                else if(description.contains('produk dihapus') == true || description.contains('produk hilang') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Dibanned';
                }
                else if(description.contains('pengawasan') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Dalam pengawasan';
                }
                else if(description.contains('kolom pencarian') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Tidak muncul di pencarian';
                }
                else if(description.contains('persentase transaksi') == true || description.contains('persentase berhasil') == true || description.contains('transaksi sukses produk') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Produk';
                    x.Sub_Category2__c = 'Persentase transaksi berhasil';
                }
                else if(description.contains('poin reputasi') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Reputasi Toko';
                    x.Sub_Category2__c = 'Jumlah reoutasi tidak sesuai';
                }
                else if(description.contains('produk terjual') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Statistik Toko';
                    x.Sub_Category2__c = 'Statistik produk terjual';
                }
                else if((description.contains('transaksi berhasil') == true || description.contains('transaksi sukses') == true) && description.contains('statistik') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Statistik Toko';
                    x.Sub_Category2__c = 'Statistik transaksi berhasil';
                }
                else if(description.contains('smiley') == true || description.contains('rating') == true){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Statistik Toko';
                    x.Sub_Category2__c = 'Statistik kepuasan toko';
                }
                else if(description.contains('kota asal belum tersedia') == true ){
                    x.Category__c = 'Jualan';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Pengaturan Pengiriman';
                    x.Sub_Category2__c = 'Kota asal belum tersedia';
                }
                else if((description.contains('check out cc') == true || description.contains('bayar') == true || description.contains('check out credit card') == true || description.contains('bayar credit card') == true || description.contains('cc') == true || description.contains('bayar cc') == true || description.contains('credit card') == true || description.contains('cicil') == true || description.contains('instalment') == true || description.contains('installment') == true) && description.contains('gagal') == true){
                    x.Category__c = 'Gagal Checkout';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Credit Card';
                    x.Sub_Category2__c = 'Dana terdebat';
                }
                else if((description.contains('kartu kredit') == true || description.contains('cc') == true ) && description.contains('tidak bisa') == true){
                    x.Category__c = 'Gagal Checkout';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Credit Card';
                    x.Sub_Category2__c = 'Kartu tidak bisa digunakan';
                }
                else if((description.contains('klik bca') == true || description.contains('click bca') == true || description.contains('klik pay') == true || description.contains('ecash') == true || description.contains('epay') == true || description.contains('indomaret') == true || description.contains('alfa') == true || description.contains('sevel') == true || description.contains('pospay') == true || description.contains('clickpay') == true || description.contains('bniva') == true || description.contains('briva') == true || description.contains('saldo') == true) && description.contains('gagal') == true){
                    x.Category__c = 'Gagal Checkout';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Instant payment lainnya';
                }
                else if((description.contains('withdraw') == true || description.contains('tarik dana') == true ) && description.contains('belum masuk') == true){
                    x.Category__c = 'Tarik Dana';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Dana belum masuk rekening';
                }
                else if((description.contains('withdraw') == true || description.contains('data tarik dana') == true || description.contains('rekening tarik dana') == true ) && description.contains('salah') == true){
                    x.Category__c = 'Tarik Dana';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Salah data saat tarik dana';
                }
                else if(description.contains('tarik dana') == true && description.contains('kembali saldo') == true){
                    x.Category__c = 'Tarik Dana';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Dana WD kembali ke saldo Tokopedia';
                }
                else if((description.contains('kota') == true || description.contains('tujuan') == true ) && description.contains('pengiriman') == true){
                    x.Category__c = 'Pengiriman';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Tujuan pengiriman belum tersedia';
                }
                
                else if((description.contains('pulsa') == true || description.contains('paket data') == true || description.contains('bpjs') == true || description.contains('pln') == true || description.contains('saldo') == true || description.contains('voucher game') == true || description.contains('air') == true || description.contains('angsuran kredit') == true || description.contains('donasi') == true || description.contains('pascabayar') == true || description.contains('tv kabel') == true || description.contains('telepon') == true ) && description.contains('input voucher') == true){
                    x.Category__c = 'Promo';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Promo Digital';
                }
                else if(description.contains('input voucher') == true && (description.contains('tiket') == true || description.contains('kereta') == true || description.contains('kai') == true)){
                    x.Category__c = 'Promo';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Promo Tiketkereta';
                }
                else if(description.contains('input voucher') == true){
                    x.Category__c = 'Promo';
                    x.RecordTypeId = label.RecID_NoInv;
                    x.Case_SubCategory_1__c = 'Promo Marketplace';
                }
                else if(description.contains('kritik') == true || description.contains('saran') == true){
                    x.Category__c = 'Kritik dan Saran';
                    x.RecordTypeId = label.RecID_NoInv;
                }
                else {
                    x.Category__c = 'Others';
                    x.RecordTypeId = label.RecID_NoInv;
                }
			}
*/
             
        }
    }
    String	a1	='';
String	a2	='';
String	a3	='';
String	a4	='';
String	a5	='';
String	a6	='';
String	a7	='';
String	a8	='';
String	a9	='';
String	a10	='';
String	a11	='';
String	a12	='';
String	a13	='';
String	a14	='';
String	a15	='';
String	a16	='';
String	a17	='';
String	a18	='';
String	a19	='';
String	a20	='';
String	a21	='';
String	a22	='';
String	a23	='';
String	a24	='';
String	a25	='';
String	a26	='';
String	a27	='';
String	a28	='';
String	a29	='';
String	a30	='';
String	a31	='';
String	a32	='';
String	a33	='';
String	a34	='';
String	a35	='';
String	a36	='';
String	a37	='';
String	a38	='';
String	a39	='';
String	a40	='';
String	a41	='';
String	a42	='';
String	a43	='';
String	a44	='';
String	a45	='';
String	a46	='';
String	a47	='';
String	a48	='';
String	a49	='';
String	a50	='';
String	a51	='';
String	a52	='';
String	a53	='';
String	a54	='';
String	a55	='';
String	a56	='';
String	a57	='';
String	a58	='';
String	a59	='';
String	a60	='';
String	a61	='';
String	a62	='';
String	a63	='';
String	a64	='';
String	a65	='';
String	a66	='';
String	a67	='';
String	a68	='';
String	a69	='';
String	a70	='';
String	a71	='';
String	a72	='';
String	a73	='';
String	a74	='';
String	a75	='';
String	a76	='';
String	a77	='';
String	a78	='';
String	a79	='';
String	a80	='';
String	a81	='';
String	a82	='';
String	a83	='';
String	a84	='';
String	a85	='';
String	a86	='';
String	a87	='';
String	a88	='';
String	a89	='';
String	a90	='';
String	a91	='';
String	a92	='';
String	a93	='';
String	a94	='';
String	a95	='';
String	a96	='';
String	a97	='';
String	a98	='';
String	a99	='';
String	a100	='';
String	a101	='';
String	a102	='';
String	a103	='';
String	a104	='';
String	a105	='';
String	a106	='';
String	a107	='';
String	a108	='';
String	a109	='';
String	a110	='';
String	a111	='';
String	a112	='';
String	a113	='';
String	a114	='';
String	a115	='';
String	a116	='';
String	a117	='';
String	a118	='';
String	a119	='';
String	a120	='';
String	a121	='';
String	a122	='';
String	a123	='';
String	a124	='';
String	a125	='';
String	a126	='';
String	a127	='';
String	a128	='';
String	a129	='';
String	a130	='';
String	a131	='';
String	a132	='';
String	a133	='';
String	a134	='';
String	a135	='';
String	a136	='';
String	a137	='';
String	a138	='';
String	a139	='';
String	a140	='';
String	a141	='';
String	a142	='';
String	a143	='';
String	a144	='';
String	a145	='';
String	a146	='';
String	a147	='';
String	a148	='';
String	a149	='';
String	a150	='';
String	a151	='';
String	a152	='';
String	a153	='';
String	a154	='';
String	a155	='';
String	a156	='';
String	a157	='';
String	a158	='';
String	a159	='';
String	a160	='';
String	a161	='';
String	a162	='';
String	a163	='';
String	a164	='';
String	a165	='';
String	a166	='';
String	a167	='';
String	a168	='';
String	a169	='';
String	a170	='';
String	a171	='';
String	a172	='';
String	a173	='';
String	a174	='';
String	a175	='';
String	a176	='';
String	a177	='';
String	a178	='';
String	a179	='';
String	a180	='';
String	a181	='';
String	a182	='';
String	a183	='';
String	a184	='';
String	a185	='';
String	a186	='';
String	a187	='';
String	a188	='';
String	a189	='';
String	a190	='';
String	a191	='';
String	a192	='';
String	a193	='';
String	a194	='';
String	a195	='';
String	a196	='';
String	a197	='';
String	a198	='';
String	a199	='';
String	a200	='';
String	a201	='';
String	a202	='';
String	a203	='';
String	a204	='';
String	a205	='';
String	a206	='';
String	a207	='';
String	a208	='';
String	a209	='';
String	a210	='';
String	a211	='';
String	a212	='';
String	a213	='';
String	a214	='';
String	a215	='';
String	a216	='';
String	a217	='';
String	a218	='';
String	a219	='';
String	a220	='';
String	a221	='';
String	a222	='';
String	a223	='';
String	a224	='';
String	a225	='';
String	a226	='';
String	a227	='';
String	a228	='';
String	a229	='';
String	a230	='';
String	a231	='';
String	a232	='';
String	a233	='';
String	a234	='';
String	a235	='';
String	a236	='';
String	a237	='';
String	a238	='';
String	a239	='';
String	a240	='';
String	a241	='';
String	a242	='';
String	a243	='';
String	a244	='';
String	a245	='';
String	a246	='';
String	a247	='';
String	a248	='';
String	a249	='';
String	a250	='';
String	a251	='';
String	a252	='';
String	a253	='';
String	a254	='';
String	a255	='';
String	a256	='';
String	a257	='';
String	a258	='';
String	a259	='';
String	a260	='';
String	a261	='';
String	a262	='';
String	a263	='';
String	a264	='';
String	a265	='';
String	a266	='';
String	a267	='';
String	a268	='';
String	a269	='';
String	a270	='';
String	a271	='';
String	a272	='';
String	a273	='';
String	a274	='';
String	a275	='';
String	a276	='';
String	a277	='';
String	a278	='';
String	a279	='';
String	a280	='';
String	a281	='';
String	a282	='';
String	a283	='';
String	a284	='';
String	a285	='';
String	a286	='';
String	a287	='';
String	a288	='';
String	a289	='';
String	a290	='';
String	a291	='';
String	a292	='';
String	a293	='';
String	a294	='';
String	a295	='';
String	a296	='';
String	a297	='';
String	a298	='';
String	a299	='';
String	a300	='';
String	a301	='';
String	a302	='';
String	a303	='';
String	a304	='';
String	a305	='';
String	a306	='';
String	a307	='';
String	a308	='';
String	a309	='';
String	a310	='';
String	a311	='';
String	a312	='';
String	a313	='';
String	a314	='';
String	a315	='';
String	a316	='';
String	a317	='';
String	a318	='';
String	a319	='';
String	a320	='';
String	a321	='';
String	a322	='';
String	a323	='';
String	a324	='';
String	a325	='';
String	a326	='';
String	a327	='';
String	a328	='';
String	a329	='';
String	a330	='';
String	a331	='';
String	a332	='';
String	a333	='';
String	a334	='';
String	a335	='';
String	a336	='';
String	a337	='';
String	a338	='';
String	a339	='';
String	a340	='';
String	a341	='';
String	a342	='';
String	a343	='';
String	a344	='';
String	a345	='';
String	a346	='';
String	a347	='';
String	a348	='';
String	a349	='';
String	a350	='';
String	a351	='';
String	a352	='';
String	a353	='';
String	a354	='';
String	a355	='';
String	a356	='';
String	a357	='';
String	a358	='';
String	a359	='';
String	a360	='';
String	a361	='';
String	a362	='';
String	a363	='';
String	a364	='';
String	a365	='';
String	a366	='';
String	a367	='';
String	a368	='';
String	a369	='';
String	a370	='';
String	a371	='';
String	a372	='';
String	a373	='';
String	a374	='';
String	a375	='';
String	a376	='';
String	a377	='';
String	a378	='';
String	a379	='';
String	a380	='';
String	a381	='';
String	a382	='';
String	a383	='';
String	a384	='';
String	a385	='';
String	a386	='';
String	a387	='';
String	a388	='';
String	a389	='';
String	a390	='';
String	a391	='';
String	a392	='';
String	a393	='';
String	a394	='';
String	a395	='';
String	a396	='';
String	a397	='';
String	a398	='';
String	a399	='';
String	a400	='';
String	a401	='';
String	a402	='';
String	a403	='';
String	a404	='';
String	a405	='';
String	a406	='';
String	a407	='';
String	a408	='';
String	a409	='';
String	a410	='';
String	a411	='';
String	a412	='';
String	a413	='';
String	a414	='';
String	a415	='';
String	a416	='';
String	a417	='';
String	a418	='';
String	a419	='';
String	a420	='';
String	a421	='';
String	a422	='';
String	a423	='';
String	a424	='';
String	a425	='';
String	a426	='';
String	a427	='';
String	a428	='';
String	a429	='';
String	a430	='';
String	a431	='';
String	a432	='';
String	a433	='';
String	a434	='';
String	a435	='';
String	a436	='';
String	a437	='';
String	a438	='';
String	a439	='';
String	a440	='';
String	a441	='';
String	a442	='';
String	a443	='';
String	a444	='';
String	a445	='';
String	a446	='';
String	a447	='';
String	a448	='';
String	a449	='';
String	a450	='';
String	a451	='';
String	a452	='';
String	a453	='';
String	a454	='';
String	a455	='';
String	a456	='';
String	a457	='';
String	a458	='';
String	a459	='';
String	a460	='';
String	a461	='';
String	a462	='';
String	a463	='';
String	a464	='';
String	a465	='';
String	a466	='';
String	a467	='';
String	a468	='';
String	a469	='';
String	a470	='';
String	a471	='';
String	a472	='';
String	a473	='';
String	a474	='';
String	a475	='';
String	a476	='';
String	a477	='';
String	a478	='';
String	a479	='';
String	a480	='';
String	a481	='';
String	a482	='';
String	a483	='';
String	a484	='';
String	a485	='';
String	a486	='';
String	a487	='';
String	a488	='';
String	a489	='';
String	a490	='';
String	a491	='';
String	a492	='';
String	a493	='';
String	a494	='';
String	a495	='';
String	a496	='';
String	a497	='';
String	a498	='';
String	a499	='';
String	a500	='';
String	a501	='';
String	a502	='';
String	a503	='';
String	a504	='';
String	a505	='';
String	a506	='';
String	a507	='';
String	a508	='';
String	a509	='';
String	a510	='';
String	a511	='';
String	a512	='';
String	a513	='';
String	a514	='';
String	a515	='';
String	a516	='';
String	a517	='';
String	a518	='';
String	a519	='';
String	a520	='';
String	a521	='';
String	a522	='';
String	a523	='';
String	a524	='';
String	a525	='';
String	a526	='';
String	a527	='';
String	a528	='';
String	a529	='';
String	a530	='';
String	a531	='';
String	a532	='';
String	a533	='';
String	a534	='';
String	a535	='';
String	a536	='';
String	a537	='';
String	a538	='';
String	a539	='';
String	a540	='';
String	a541	='';
String	a542	='';
String	a543	='';
String	a544	='';
String	a545	='';
String	a546	='';
String	a547	='';
String	a548	='';
String	a549	='';
String	a550	='';
String	a551	='';
String	a552	='';
String	a553	='';
String	a554	='';
String	a555	='';
String	a556	='';
String	a557	='';
String	a558	='';
String	a559	='';
String	a560	='';
String	a561	='';
String	a562	='';
String	a563	='';
String	a564	='';
String	a565	='';
String	a566	='';
String	a567	='';
String	a568	='';
String	a569	='';
String	a570	='';
String	a571	='';
String	a572	='';
String	a573	='';
String	a574	='';
String	a575	='';
String	a576	='';
String	a577	='';
String	a578	='';
String	a579	='';
String	a580	='';
String	a581	='';
String	a582	='';
String	a583	='';
String	a584	='';
String	a585	='';
String	a586	='';
String	a587	='';
String	a588	='';
String	a589	='';
String	a590	='';
String	a591	='';
String	a592	='';
String	a593	='';
String	a594	='';
String	a595	='';
String	a596	='';
String	a597	='';
String	a598	='';
String	a599	='';
String	a600	='';
String	a601	='';
String	a602	='';
String	a603	='';
String	a604	='';
String	a605	='';
String	a606	='';
String	a607	='';
String	a608	='';
String	a609	='';
String	a610	='';
String	a611	='';
String	a612	='';
String	a613	='';
String	a614	='';
String	a615	='';
String	a616	='';
String	a617	='';
String	a618	='';
String	a619	='';
String	a620	='';
String	a621	='';
String	a622	='';
String	a623	='';
String	a624	='';
String	a625	='';
String	a626	='';
String	a627	='';
String	a628	='';
String	a629	='';
String	a630	='';
String	a631	='';
String	a632	='';
String	a633	='';
String	a634	='';
String	a635	='';
String	a636	='';
String	a637	='';
String	a638	='';
String	a639	='';
String	a640	='';
String	a641	='';
String	a642	='';
String	a643	='';
String	a644	='';
String	a645	='';
String	a646	='';
String	a647	='';
String	a648	='';
String	a649	='';
String	a650	='';
String	a651	='';
String	a652	='';
String	a653	='';
String	a654	='';
String	a655	='';
String	a656	='';
String	a657	='';
String	a658	='';
String	a659	='';
String	a660	='';
String	a661	='';
String	a662	='';
String	a663	='';
String	a664	='';
String	a665	='';
String	a666	='';
String	a667	='';
String	a668	='';
String	a669	='';
String	a670	='';
String	a671	='';
String	a672	='';
String	a673	='';
String	a674	='';
String	a675	='';
String	a676	='';
String	a677	='';
String	a678	='';
String	a679	='';
String	a680	='';
String	a681	='';
String	a682	='';
String	a683	='';
String	a684	='';
String	a685	='';
String	a686	='';
String	a687	='';
String	a688	='';
String	a689	='';
String	a690	='';
String	a691	='';
String	a692	='';
String	a693	='';
String	a694	='';
String	a695	='';
String	a696	='';
String	a697	='';
String	a698	='';
String	a699	='';
String	a700	='';
String	a701	='';
String	a702	='';
String	a703	='';
String	a704	='';
String	a705	='';
String	a706	='';
String	a707	='';
String	a708	='';
String	a709	='';
String	a710	='';
String	a711	='';
String	a712	='';
String	a713	='';
String	a714	='';
String	a715	='';
String	a716	='';
String	a717	='';
String	a718	='';
String	a719	='';
String	a720	='';
String	a721	='';
String	a722	='';
String	a723	='';
String	a724	='';
String	a725	='';
String	a726	='';
String	a727	='';
String	a728	='';
String	a729	='';
String	a730	='';
String	a731	='';
String	a732	='';
String	a733	='';
String	a734	='';
String	a735	='';
String	a736	='';
String	a737	='';
String	a738	='';
String	a739	='';
String	a740	='';
String	a741	='';
String	a742	='';
String	a743	='';
String	a744	='';
String	a745	='';
String	a746	='';
String	a747	='';
String	a748	='';
String	a749	='';
String	a750	='';
String	a751	='';
String	a752	='';
String	a753	='';
String	a754	='';
String	a755	='';
String	a756	='';
String	a757	='';
String	a758	='';
String	a759	='';
String	a760	='';
String	a761	='';
String	a762	='';
String	a763	='';
String	a764	='';
String	a765	='';
String	a766	='';
String	a767	='';
String	a768	='';
String	a769	='';
String	a770	='';
String	a771	='';
String	a772	='';
String	a773	='';
String	a774	='';
String	a775	='';
String	a776	='';
String	a777	='';
String	a778	='';
String	a779	='';
String	a780	='';
String	a781	='';
String	a782	='';
String	a783	='';
String	a784	='';
String	a785	='';
String	a786	='';
String	a787	='';
String	a788	='';
String	a789	='';
String	a790	='';
String	a791	='';
String	a792	='';
String	a793	='';
String	a794	='';
String	a795	='';
String	a796	='';
String	a797	='';
String	a798	='';
String	a799	='';
String	a800	='';
String	a801	='';
String	a802	='';
String	a803	='';
String	a804	='';
String	a805	='';
String	a806	='';
String	a807	='';
String	a808	='';
String	a809	='';
String	a810	='';
String	a811	='';
String	a812	='';
String	a813	='';
String	a814	='';
String	a815	='';
String	a816	='';
String	a817	='';
String	a818	='';
String	a819	='';
String	a820	='';
String	a821	='';
String	a822	='';
String	a823	='';
String	a824	='';
String	a825	='';
String	a826	='';
String	a827	='';
String	a828	='';
String	a829	='';
String	a830	='';
String	a831	='';
String	a832	='';
String	a833	='';
String	a834	='';
String	a835	='';
String	a836	='';
String	a837	='';
String	a838	='';
String	a839	='';
String	a840	='';
String	a841	='';
String	a842	='';
String	a843	='';
String	a844	='';
String	a845	='';
String	a846	='';
String	a847	='';
String	a848	='';
String	a849	='';
String	a850	='';
String	a851	='';
String	a852	='';
String	a853	='';
String	a854	='';
String	a855	='';
String	a856	='';
String	a857	='';
String	a858	='';
String	a859	='';
String	a860	='';
String	a861	='';
String	a862	='';
String	a863	='';
String	a864	='';
String	a865	='';
String	a866	='';
String	a867	='';
String	a868	='';
String	a869	='';
String	a870	='';
String	a871	='';
String	a872	='';
String	a873	='';
String	a874	='';
String	a875	='';
String	a876	='';
String	a877	='';
String	a878	='';
String	a879	='';
String	a880	='';
String	a881	='';
String	a882	='';
String	a883	='';
String	a884	='';
String	a885	='';
String	a886	='';
String	a887	='';
String	a888	='';
String	a889	='';
String	a890	='';
String	a891	='';
String	a892	='';
String	a893	='';
String	a894	='';
String	a895	='';
String	a896	='';
String	a897	='';
String	a898	='';
String	a899	='';
String	a900	='';
String	a901	='';
String	a902	='';
String	a903	='';
String	a904	='';
String	a905	='';
String	a906	='';
String	a907	='';
String	a908	='';
String	a909	='';
String	a910	='';
String	a911	='';
String	a912	='';
String	a913	='';
String	a914	='';
String	a915	='';
String	a916	='';
String	a917	='';
String	a918	='';
String	a919	='';
String	a920	='';
String	a921	='';
String	a922	='';
String	a923	='';
String	a924	='';
String	a925	='';
String	a926	='';
String	a927	='';
String	a928	='';
String	a929	='';
String	a930	='';
String	a931	='';
String	a932	='';
String	a933	='';
String	a934	='';
String	a935	='';
String	a936	='';
String	a937	='';
String	a938	='';
String	a939	='';
String	a940	='';
String	a941	='';
String	a942	='';
String	a943	='';
String	a944	='';
String	a945	='';
String	a946	='';
String	a947	='';
String	a948	='';
String	a949	='';
String	a950	='';
String	a951	='';
String	a952	='';
String	a953	='';
String	a954	='';
String	a955	='';
String	a956	='';
String	a957	='';
String	a958	='';
String	a959	='';
String	a960	='';
String	a961	='';
String	a962	='';
String	a963	='';
String	a964	='';
String	a965	='';
String	a966	='';
String	a967	='';
String	a968	='';
String	a969	='';
String	a970	='';
String	a971	='';
String	a972	='';
String	a973	='';
String	a974	='';
String	a975	='';
String	a976	='';
String	a977	='';
String	a978	='';
String	a979	='';
String	a980	='';
String	a981	='';
String	a982	='';
String	a983	='';
String	a984	='';
String	a985	='';
String	a986	='';
String	a987	='';
String	a988	='';
String	a989	='';
String	a990	='';
String	a991	='';
String	a992	='';
String	a993	='';
String	a994	='';
String	a995	='';
String	a996	='';
String	a997	='';
String	a998	='';
String	a999	='';
String	a1000	='';
String	a1001	='';
String	a1002	='';
String	a1003	='';
String	a1004	='';
String	a1005	='';
String	a1006	='';
String	a1007	='';
String	a1008	='';
String	a1009	='';
String	a1010	='';
String	a1011	='';
String	a1012	='';
String	a1013	='';
String	a1014	='';
String	a1015	='';
String	a1016	='';
String	a1017	='';
String	a1018	='';
String	a1019	='';
String	a1020	='';
String	a1021	='';
String	a1022	='';
String	a1023	='';
String	a1024	='';
String	a1025	='';
String	a1026	='';
String	a1027	='';
String	a1028	='';
String	a1029	='';
String	a1030	='';
String	a1031	='';
String	a1032	='';
String	a1033	='';
String	a1034	='';
String	a1035	='';
String	a1036	='';
String	a1037	='';
String	a1038	='';
String	a1039	='';
String	a1040	='';
String	a1041	='';
String	a1042	='';
String	a1043	='';
String	a1044	='';
String	a1045	='';
String	a1046	='';
String	a1047	='';
String	a1048	='';
String	a1049	='';
String	a1050	='';
String	a1051	='';
String	a1052	='';
String	a1053	='';
String	a1054	='';
String	a1055	='';
String	a1056	='';
String	a1057	='';
String	a1058	='';
String	a1059	='';
String	a1060	='';
String	a1061	='';
String	a1062	='';
String	a1063	='';
String	a1064	='';
String	a1065	='';
String	a1066	='';
String	a1067	='';
String	a1068	='';
String	a1069	='';
String	a1070	='';
String	a1071	='';
String	a1072	='';
String	a1073	='';
String	a1074	='';
String	a1075	='';
String	a1076	='';
String	a1077	='';
String	a1078	='';
String	a1079	='';
String	a1080	='';
String	a1081	='';
String	a1082	='';
String	a1083	='';
String	a1084	='';
String	a1085	='';
String	a1086	='';
String	a1087	='';
String	a1088	='';
String	a1089	='';
String	a1090	='';
String	a1091	='';
String	a1092	='';
String	a1093	='';
String	a1094	='';
String	a1095	='';
String	a1096	='';
String	a1097	='';
String	a1098	='';
String	a1099	='';
String	a1100	='';

}