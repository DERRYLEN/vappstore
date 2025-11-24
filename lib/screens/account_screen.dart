import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- IMPORT HALAMAN BARU ---
import 'order_history_screen.dart';
import 'address_screen.dart';
import 'settings_screen.dart';
import 'help_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isLoggedIn = false;
  bool _isRegistering = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _savedName = "User";
  String _savedEmail = "user@tokovape.id";
  final Color _accentColor = Colors.amber;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (_isLoggedIn) {
        _savedName = prefs.getString('userName') ?? "Sultan Vape";
        _savedEmail = prefs.getString('userEmail') ?? "email@tokovape.id";
      }
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _nameController.text);
      await prefs.setString('userEmail', _emailController.text);
      await prefs.setString('userPassword', _passwordController.text);
      await prefs.setBool('isLoggedIn', true);

      setState(() {
        _savedName = _nameController.text;
        _savedEmail = _emailController.text;
        _isLoggedIn = true;
        _isRegistering = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pendaftaran Berhasil!")));
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      String? registeredEmail = prefs.getString('userEmail');
      String? registeredPass = prefs.getString('userPassword');
      String? registeredName = prefs.getString('userName');

      if (_emailController.text == registeredEmail && _passwordController.text == registeredPass) {
        await prefs.setBool('isLoggedIn', true);
        setState(() {
          _savedName = registeredName ?? "User";
          _savedEmail = registeredEmail!;
          _isLoggedIn = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Berhasil!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email atau Password salah!"), backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) return _buildProfileView();
    return _buildAuthScaffold(
      child: Form(
        key: _formKey,
        child: _isRegistering ? _buildRegisterCard() : _buildLoginCard(),
      ),
    );
  }

  // --- WIDGETS UTAMA ---

  Widget _buildAuthScaffold({required Widget child}) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("TOKOVAPE", style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, letterSpacing: 2)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Menu samping ada di Home Screen")))),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("SELAMAT DATANG DI", style: TextStyle(color: Colors.grey[400], letterSpacing: 1, fontSize: 12)),
            const SizedBox(height: 5),
            const Text("TOKOVAPE INDONESIA", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child: Divider(color: _accentColor.withOpacity(0.5))), Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Icon(Icons.vape_free, color: _accentColor)), Expanded(child: Divider(color: _accentColor.withOpacity(0.5)))]),
            const SizedBox(height: 40),
            child,
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Login Akun", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text("Masuk dengan akun yang sudah terdaftar.", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          const SizedBox(height: 25),
          _buildDarkTextField(controller: _emailController, icon: Icons.email_outlined, hint: "Email", validator: (value) => (value == null || value.isEmpty || !value.contains('@')) ? "Email tidak valid" : null),
          const SizedBox(height: 20),
          _buildDarkTextField(controller: _passwordController, icon: Icons.lock_outline, hint: "Password", isPassword: true, validator: (value) => (value == null || value.isEmpty) ? "Password kosong" : null),
          const SizedBox(height: 25),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: _login, child: const Text("MASUK SEKARANG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
          const SizedBox(height: 20),
          Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Belum punya akun? ", style: TextStyle(color: Colors.grey[400])), GestureDetector(onTap: () { _emailController.clear(); _passwordController.clear(); setState(() => _isRegistering = true); }, child: Text("Daftar disini.", style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold)))])),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[800]),
          const SizedBox(height: 20),
          _buildGoogleButton(),
        ],
      ),
    );
  }

  Widget _buildRegisterCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Buat Akun Baru", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text("Isi data diri Rajaku dengan benar.", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          const SizedBox(height: 25),
          _buildDarkTextField(controller: _nameController, icon: Icons.person_outline, hint: "Nama Lengkap", validator: (value) => value!.isEmpty ? "Nama harus diisi" : null),
          const SizedBox(height: 15),
          _buildDarkTextField(controller: _emailController, icon: Icons.email_outlined, hint: "Email", validator: (value) => !value!.contains('@') ? "Format email salah" : null),
          const SizedBox(height: 15),
          _buildDarkTextField(controller: _passwordController, icon: Icons.lock_outline, hint: "Password", isPassword: true, validator: (value) => value!.length < 6 ? "Min 6 karakter" : null),
          const SizedBox(height: 15),
          _buildDarkTextField(controller: _confirmPasswordController, icon: Icons.lock_reset, hint: "Konfirmasi Password", isPassword: true, validator: (value) => value != _passwordController.text ? "Password tidak sama" : null),
          const SizedBox(height: 25),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: _register, child: const Text("DAFTAR MEMBER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
          const SizedBox(height: 20),
          Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Sudah punya akun? ", style: TextStyle(color: Colors.grey[400])), GestureDetector(onTap: () { _emailController.clear(); _passwordController.clear(); setState(() => _isRegistering = false); }, child: Text("Login disini.", style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold)))])),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(width: double.infinity, height: 50, child: OutlinedButton.icon(style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.grey[700]!), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), alignment: Alignment.centerLeft), icon: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.g_mobiledata, color: Colors.black, size: 20)), label: const Center(child: Text("Masuk dengan Google (Simulasi)")), onPressed: () => setState(() { _savedName = "Google User"; _savedEmail = "google@gmail.com"; _isLoggedIn = true; })));
  }

  Widget _buildDarkTextField({required IconData icon, required String hint, required TextEditingController controller, String? Function(String?)? validator, bool isPassword = false}) {
    return TextFormField(controller: controller, validator: validator, obscureText: isPassword, style: const TextStyle(color: Colors.white), decoration: InputDecoration(filled: true, fillColor: Colors.black, hintText: hint, hintStyle: TextStyle(color: Colors.grey[600]), prefixIcon: Icon(icon, color: Colors.grey[500]), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[800]!), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _accentColor, width: 2), borderRadius: BorderRadius.circular(12)), errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)), focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12))));
  }

  // --- TAMPILAN PROFIL (NAVIGASI AKTIF) ---
  Widget _buildProfileView() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Akun Saya", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: _logout, icon: const Icon(Icons.logout, color: Colors.red))],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(radius: 50, backgroundColor: Colors.grey[900], child: Icon(Icons.person, size: 60, color: _accentColor)),
          const SizedBox(height: 15),
          Text(_savedName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(_savedEmail, style: TextStyle(color: Colors.grey[500])),
          const SizedBox(height: 40),

          // --- MENU YANG SEKARANG SUDAH BERFUNGSI ---
          _buildMenu(Icons.history, "Riwayat Pesanan", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
          }),
          _buildMenu(Icons.location_on, "Alamat Pengiriman", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen()));
          }),
          _buildMenu(Icons.settings, "Pengaturan Akun", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
          Divider(color: Colors.grey[800], height: 40),
          _buildMenu(Icons.help_outline, "Pusat Bantuan", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen()));
          }),
        ],
      ),
    );
  }

  // Widget Menu dengan Fungsi onTap
  Widget _buildMenu(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      onTap: onTap, // Sekarang tombol ini bisa diklik!
    );
  }
}