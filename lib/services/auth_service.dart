// lib/services/auth_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Classe que gerencia toda a comunicação com a API de autenticação.
class AuthService {
  // URL base da sua API. Altere se necessário.
  final String baseUrl = 'http://127.0.0.1:8000';
  // Instância do FlutterSecureStorage para armazenar dados de forma segura.
  final _storage = const FlutterSecureStorage();

  // --- Métodos de Armazenamento do Token ---

  // Salva o token de acesso no armazenamento seguro.
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // Recupera o token de acesso do armazenamento seguro.
  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Deleta o token de acesso do armazenamento seguro.
  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }
  
  // Verifica se o usuário está autenticado checando a existência do token.
  Future<bool> getAuthStatus() async {
    final token = await getToken();
    return token != null;
  }

  // --- Métodos de Autenticação com a API ---

  // Faz a requisição de registro de um novo usuário para a API.
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'full_name': fullName,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha no cadastro: ${response.statusCode}');
    }
  }

  // Faz a requisição de login para a API e salva o token se o login for bem-sucedido.
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required Map<String, dynamic> deviceInfo,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
        'device_info': deviceInfo,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final String accessToken = responseBody['data']['access_token'];
      await saveToken(accessToken); // Salva o token aqui.
      return responseBody;
    } else {
      throw Exception('Falha no login: ${response.statusCode}');
    }
  }

  // Envia a requisição de logout para a API e remove o token do armazenamento local.
  Future<void> logout() async {
    final token = await getToken();
    if (token != null) {
      await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      await deleteToken(); // Remove o token localmente.
    }
  }

  // Simula a obtenção de informações do dispositivo.
  Future<Map<String, dynamic>> getDeviceInfo() async {
    return {
      "device_id": "generic-test-device-id",
      "platform": "generic-test-platform",
      "model": "Flutter Test Model",
      "os_version": "1.0",
      "app_version": "1.0.0"
    };
  }
}