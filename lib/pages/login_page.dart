// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_page.dart'; // Importa a página para a qual navegaremos após o login.

// Widget para a página de Login.
class LoginPage extends StatefulWidget {
  final Function onRegisterPressed;
  const LoginPage({super.key, required this.onRegisterPressed});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Função que lida com o login.
  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        final Map<String, dynamic> deviceInfo = await _authService.getDeviceInfo();
        await _authService.login(
          email: _emailController.text,
          password: _passwordController.text,
          deviceInfo: deviceInfo,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        
        // Navega para a HomePage e remove a página de login da pilha de navegação.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no login: ${e.toString()}')),
        );
      }
    }
  }

  // Função utilitária para decorar os campos de texto.
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título 'LOGIN' e campos de texto.
          const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 25, 116, 172),
            ),
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: _emailController,
            decoration: _inputDecoration('Email', Icons.email),
            validator: (value) => value!.isEmpty ? 'O email é obrigatório' : null,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordController,
            decoration: _inputDecoration('Senha', Icons.lock),
            obscureText: true,
            validator: (value) => value!.isEmpty ? 'A senha é obrigatória' : null,
          ),
          const SizedBox(height: 25),
          // Botão de 'Entrar'.
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 116, 172),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Entrar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          // Botão de navegação para a página de Cadastro.
          TextButton(
            onPressed: () => widget.onRegisterPressed(),
            child: const Text(
              'Ainda não possui uma conta? Registrar',
              style: TextStyle(color: Color.fromARGB(255, 25, 116, 172)),
            ),
          ),
        ],
      ),
    );
  }
}