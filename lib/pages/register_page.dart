// lib/pages/register_page.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Widget para a página de Cadastro.
class RegisterPage extends StatefulWidget {
  final Function onLoginPressed;
  const RegisterPage({super.key, required this.onLoginPressed});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Função que lida com o registro.
  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.register(
          email: _emailController.text,
          password: _passwordController.text,
          fullName: _fullNameController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no cadastro: ${e.toString()}')),
        );
      }
    }
  }
  
  // Validador de senha.
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (value.length < 8) {
      return 'Mínimo de 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Deve conter 1 letra maiúscula';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Deve conter 1 letra minúscula';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Deve conter 1 caracter especial';
    }
    return null;
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
          // Título 'CADASTRO' e campos de texto.
          const Text(
            'CADASTRO',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 25, 116, 172),
            ),
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: _fullNameController,
            decoration: _inputDecoration('Nome Completo', Icons.person),
            validator: (value) => value!.isEmpty ? 'O nome completo é obrigatório' : null,
          ),
          const SizedBox(height: 15),
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
            validator: _validatePassword,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: _inputDecoration('Confirmar Senha', Icons.lock),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Confirme sua senha';
              }
              if (value != _passwordController.text) {
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          // Botão de 'Cadastrar'.
          ElevatedButton(
            onPressed: _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 116, 172),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              'Cadastrar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          // Botão de navegação para a página de Login.
          TextButton(
            onPressed: () => widget.onLoginPressed(),
            child: const Text(
              'Já possui uma conta? Login',
              style: TextStyle(color: Color.fromARGB(255, 25, 116, 172)),
            ),
          ),
        ],
      ),
    );
  }
}