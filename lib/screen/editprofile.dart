import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  // final String initialDisplayName;
  final String initialEmail;

  const EditProfilePage({
    Key? key,
    // required this.initialDisplayName,
    required this.initialEmail,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values from the user's data passed from ProfilePage
    // _displayNameController.text = widget.initialDisplayName;
    _emailController.text = widget.initialEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan perubahan data diri ke database atau penyimpanan data
                // Misalnya, Anda bisa menggunakan Firebase Firestore atau REST API.
                // Setelah itu, mungkin ingin kembali ke halaman profil atau halaman sebelumnya.
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
