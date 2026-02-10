# Configuração do Firebase e Google Sign-In

## Passo 1: Criar Projeto no Firebase

1. Acesse o [Firebase Console](https://console.firebase.google.com/)
2. Clique em "Adicionar projeto"
3. Dê um nome ao projeto (ex: "veterinario-app")
4. Siga os passos de criação

## Passo 2: Configurar Autenticação

1. No Firebase Console, vá em **Authentication**
2. Clique em **Get Started**
3. Na aba **Sign-in method**, habilite **Google**
4. Configure o email de suporte do projeto

## Passo 3: Adicionar App Android

1. No Firebase Console, clique no ícone do Android
2. Preencha:
   - **Package name**: `com.example.veterinario` (ou o nome do seu pacote)
   - **App nickname**: Veterinário App
3. Baixe o arquivo `google-services.json`
4. Coloque o arquivo em `android/app/google-services.json`

## Passo 4: Configurar Android

### 4.1 Editar `android/build.gradle.kts`

Adicione no topo do arquivo:

```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

### 4.2 Editar `android/app/build.gradle.kts`

Adicione no final do arquivo:

```kotlin
apply(plugin = "com.google.gms.google-services")
```

### 4.3 Obter SHA-1 para Google Sign-In

Execute no terminal:

```bash
cd android
./gradlew signingReport
```

Copie o SHA-1 e adicione no Firebase Console:
- Vá em **Project Settings** > **Your apps** > **Android app**
- Clique em **Add fingerprint**
- Cole o SHA-1

## Passo 5: Configurar firebase_options.dart

Execute o FlutterFire CLI (recomendado):

```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar Firebase
flutterfire configure
```

Ou edite manualmente o arquivo `lib/firebase_options.dart` com as credenciais do seu projeto.

## Passo 6: Instalar Dependências

```bash
flutter pub get
```

## Passo 7: Testar

```bash
flutter run
```

## Estrutura de Arquivos Criados

```
lib/
├── providers/
│   └── auth_provider.dart          # Gerenciamento de estado de autenticação
├── services/
│   └── auth_service.dart           # Serviço de autenticação
├── screens/
│   └── login_screen.dart           # Tela de login
├── firebase_options.dart           # Configurações do Firebase
└── main.dart                       # Atualizado com Firebase

android/
└── app/
    └── google-services.json        # Configuração Android (baixar do Firebase)
```

## Funcionalidades Implementadas

✅ Tela de login com design moderno
✅ Autenticação com Google
✅ Gerenciamento de estado com Provider
✅ Navegação automática após login
✅ Botão de logout no dashboard
✅ Persistência de sessão
✅ Exibição de informações do usuário

## Troubleshooting

### Erro: "PlatformException(sign_in_failed)"
- Verifique se o SHA-1 foi adicionado no Firebase Console
- Confirme que o `google-services.json` está no lugar correto

### Erro: "FirebaseException"
- Verifique se o Firebase foi inicializado corretamente
- Confirme as configurações em `firebase_options.dart`

### Login não funciona
- Verifique se a autenticação Google está habilitada no Firebase Console
- Confirme que o email de suporte está configurado

## Próximos Passos

- [ ] Adicionar autenticação por email/senha
- [ ] Implementar recuperação de senha
- [ ] Adicionar perfil de usuário
- [ ] Implementar roles (admin, veterinário, recepcionista)
