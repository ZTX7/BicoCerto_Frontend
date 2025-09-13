#### `README.md`

```markdown
# App de Autenticação em Flutter

Este projeto demonstra um fluxo de autenticação completo em Flutter, incluindo cadastro, login e logout, com comunicação com uma API e gerenciamento de estado.

## Funcionalidades

* **Páginas Separadas:** O projeto segue uma estrutura de pastas organizada, com as telas de Login e Cadastro em arquivos separados (`login_page.dart` e `register_page.dart`).
* **Serviço de Autenticação:** A lógica de comunicação com a API é centralizada em um serviço (`AuthService`) para melhor organização do código.
* **Armazenamento Seguro:** O `access_token` é armazenado de forma segura no dispositivo usando o `flutter_secure_storage`.
* **Gerenciamento de Estado:** O aplicativo verifica se o usuário está logado ao iniciar, navegando automaticamente para a `HomePage` se houver um token válido.
* **Fluxo de Logout:** O logout é feito de forma segura, invalidando o token na API e removendo-o do armazenamento local.
* **Design Customizado:** Telas com gradiente de fundo e um design de onda.

## Estrutura de Pastas

```

seu\_projeto/
├── assets/
│   └── images/
│       └── bico\_certo.jpg (Sua imagem)
├── lib/
│   ├── pages/
│   │   ├── home\_page.dart
│   │   ├── login\_page.dart
│   │   └── register\_page.dart
│   ├── services/
│   │   └── auth\_service.dart
│   └── main.dart
├── pubspec.yaml
└── README.md

````

## Como Configurar e Rodar o Projeto

### 1. Instalar Dependências

Abra seu terminal e navegue até a pasta raiz do projeto. Instale os pacotes necessários:

```bash
flutter pub add http flutter_secure_storage
````

### 2\. Adicionar Imagens

1.  Crie a pasta `assets/images` na raiz do seu projeto.
2.  Coloque suas imagens lá (por exemplo, `bico_certo.jpg`).
3.  Abra o arquivo `pubspec.yaml` e adicione o caminho das suas imagens, garantindo a identação correta:

<!-- end list -->

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

4.  Execute `flutter pub get` no terminal para que o Flutter reconheça os novos arquivos.

### 3\. Rodar o Aplicativo

Para rodar o aplicativo, use o seguinte comando no terminal:

```bash
flutter run
```

### 4\. Usando o Hot Reload e Hot Restart

  * **Hot Reload:** Para ver as mudanças de UI e lógica rapidamente, salve o arquivo ou pressione a tecla `r` no terminal.
  * **Hot Restart:** Para mudanças que afetam o estado inicial do aplicativo, pressione a tecla `R` (maiúscula) no terminal.

<!-- end list -->

```
```