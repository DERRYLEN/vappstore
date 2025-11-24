import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // Controller Input
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // State Data
  bool _hasAddress = false;
  String _savedStreet = "";
  String _savedCity = "";
  String _savedZip = "";
  String _savedPhone = "";

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  // --- 1. LOGIKA LOAD DATA ---
  Future<void> _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedStreet = prefs.getString('addr_street') ?? "";
      _savedCity = prefs.getString('addr_city') ?? "";
      _savedZip = prefs.getString('addr_zip') ?? "";
      _savedPhone = prefs.getString('addr_phone') ?? "";
      _hasAddress = _savedStreet.isNotEmpty;
    });
  }

  // --- 2. LOGIKA SIMPAN DATA ---
  Future<void> _saveAddress() async {
    if (_streetController.text.isEmpty || _cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data tidak boleh kosong!"), backgroundColor: Colors.red));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('addr_street', _streetController.text);
    await prefs.setString('addr_city', _cityController.text);
    await prefs.setString('addr_zip', _zipController.text);
    await prefs.setString('addr_phone', _phoneController.text);

    setState(() {
      _savedStreet = _streetController.text;
      _savedCity = _cityController.text;
      _savedZip = _zipController.text;
      _savedPhone = _phoneController.text;
      _hasAddress = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Alamat berhasil disimpan!"), backgroundColor: Colors.green));
  }

  // --- 3. LOGIKA HAPUS DATA (FITUR BARU) ---
  Future<void> _deleteAddress() async {
    final prefs = await SharedPreferences.getInstance();
    // Hapus semua key alamat
    await prefs.remove('addr_street');
    await prefs.remove('addr_city');
    await prefs.remove('addr_zip');
    await prefs.remove('addr_phone');

    setState(() {
      _savedStreet = "";
      _savedCity = "";
      _savedZip = "";
      _savedPhone = "";
      _hasAddress = false; // Kembali ke mode formulir

      // Bersihkan controller juga
      _streetController.clear();
      _cityController.clear();
      _zipController.clear();
      _phoneController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Alamat telah dihapus."), backgroundColor: Colors.red),
    );
  }

  // --- 4. DIALOG KONFIRMASI HAPUS ---
  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Hapus Alamat?", style: TextStyle(color: Colors.white)),
        content: const Text("Alamat ini akan dihapus permanen dari aplikasi.", style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Tutup dialog
              _deleteAddress();   // Lakukan penghapusan
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Logika Tombol Lainnya
  void _editAddress() {
    setState(() {
      _streetController.text = _savedStreet;
      _cityController.text = _savedCity;
      _zipController.text = _savedZip;
      _phoneController.text = _savedPhone;
      _hasAddress = false;
    });
  }

  void _addNewAddress() {
    setState(() {
      _streetController.clear();
      _cityController.clear();
      _zipController.clear();
      _phoneController.clear();
      _hasAddress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Alamat Pengiriman", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _hasAddress ? _buildAddressCard() : _buildAddressForm(),
          ],
        ),
      ),
    );
  }

  // --- TAMPILAN KARTU ALAMAT ---
  Widget _buildAddressCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Alamat Utama", style: TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 10),
                  const Text("Rumah / Kantor", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
                    child: const Text("UTAMA", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const Divider(color: Colors.grey, height: 30),
              Text(_savedPhone, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(_savedStreet, style: const TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 5),
              Text("$_savedCity, $_savedZip", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // BARIS TOMBOL EDIT & HAPUS
        Row(
          children: [
            // Tombol Edit (Expanded agar memenuhi sisa ruang)
            Expanded(
              child: SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _editAddress,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("EDIT"),
                ),
              ),
            ),
            const SizedBox(width: 15),

            // Tombol Hapus (Kecil Merah) - FITUR BARU
            SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _showDeleteConfirmation, // Panggil dialog konfirmasi
                child: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // Tombol Tambah Baru
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _addNewAddress,
            icon: const Icon(Icons.add),
            label: const Text("TAMBAH ALAMAT LAIN"),
          ),
        ),
      ],
    );
  }

  // --- TAMPILAN FORMULIR ---
  Widget _buildAddressForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Isi Detail Alamat", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text("Pastikan alamat yang Anda masukkan benar.", style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 25),

        _buildTextField("Nomor Telepon Penerima", _phoneController, TextInputType.phone),
        const SizedBox(height: 15),
        _buildTextField("Nama Jalan, No Rumah, RT/RW", _streetController, TextInputType.streetAddress),
        const SizedBox(height: 15),
        _buildTextField("Kecamatan / Kota", _cityController, TextInputType.text),
        const SizedBox(height: 15),
        _buildTextField("Kode Pos", _zipController, TextInputType.number),

        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _saveAddress,
            child: const Text("SIMPAN ALAMAT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),

        // Tombol Batal (Hanya muncul jika sebelumnya sudah ada alamat, lalu klik Edit/Tambah)
        if (_savedStreet.isNotEmpty) ...[
          const SizedBox(height: 15),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _hasAddress = true; // Batal edit, kembali ke kartu
                });
              },
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
          )
        ]
      ],
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            hintText: "Masukkan $hint",
            hintStyle: TextStyle(color: Colors.grey[700]),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.amber, width: 1)),
          ),
        ),
      ],
    );
  }
}