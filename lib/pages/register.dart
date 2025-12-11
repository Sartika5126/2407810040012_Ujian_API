import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  // Function proses register ke API
  Future<void> prosesRegister() async {
    setState(() {
      isLoading = true;
    });

  // Endpoint simulasi POST
  var uri = Uri.parse("https://dummyjson.com/users/add");
  Map<String, dynamic> dataUser = {
    "firstName": firstNameController.text,
    "lastName": lastNameController.text,
    "age": int.tryParse(ageController.text) ?? 0,
    "email": emailController.text,
  };
  try {
    var respon = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(dataUser),
      );
     if (respon.statusCode == 201 || respon.statusCode == 200) {
        final responseData = json.decode(respon.body);
        final registeredName = responseData['firstName'] ?? firstNameController.text;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil Mendaftar: $registeredName"),
            backgroundColor: Colors.green,
          ),
        );
    if (mounted) {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const TodoListScreen())
          );
        }
      } else {
        // Feedback Gagal
        throw Exception("Gagal Registrasi. Status: ${respon.statusCode}");
      }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString().replaceAll('Exception: ', '')}"),
          backgroundColor: Colors.red,
        )
      );
    } finally {
      setState(() {
        isLoading = false;
      });
  }
}
@override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi Akun"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DAFTAR AKUN BARU",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              ),
              SizedBox(height: 30),

              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                enabled: !isLoading,
              ),
              SizedBox(height: 20),

              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                enabled: !isLoading,
              ),
              SizedBox(height: 20),

              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                enabled: !isLoading,
              ),
              SizedBox(height: 20),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                enabled: !isLoading,
              ),
              SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : prosesRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                   child: isLoading
                   ? const CircularProgressIndicator(color: Colors.white)
                   : const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                   ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}