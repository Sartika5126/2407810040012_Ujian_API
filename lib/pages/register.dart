import 'package:flutter/material.dart';

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
  
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}