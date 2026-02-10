# Solução de Problemas - Tela de Login

## 🔴 Problema: "Erro ao executar aplicativo, não consigo ver view"

### Causa Provável
O Firebase não está configurado corretamente, causando erro na inicialização do app.

## ✅ Soluções

### Opção 1: Testar Interface SEM Firebase (RECOMENDADO para teste rápido)

Execute a versão DEMO que não requer Firebase:

```bash
flutter run lib/main_sem_firebase.dart
```

Esta versão:
- ✅ Mostra a tela de login completa
- ✅ Simula autenticação (2 segundos)
- ✅ Redireciona para a tela inicial
- ❌ Não salva sessão real
- ❌ Não usa Google Sign-In real

### Opção 2: Configurar Firebase Corretamente

#### Passo 1: Criar Projeto Firebase
1. Acesse https://console.firebase.google.com/
2. Clique em "Adicionar projeto"
3. Nomeie como "veterinario-app"
4. Siga os passos

#### Passo 2: Adicionar App Android
1. No Firebase Console, clique no ícone Android
2. Package name: `com.example.veterinario`
3. Baixe `google-services.json`
4. Coloque em `android/app/google-services.json`

#### Passo 3: Habilitar Autenticação Google
1. No Firebase Console → Authentication
2. Clique em "Get Started"
3. Aba "Sign-in method" → Habilite "Google"
4. Configure email de suporte

#### Passo 4: Adicionar SHA-1
```bash
cd android
gradlew signingReport
```
Copie o SHA-1 e adicione no Firebase Console:
- Project Settings → Your apps → Android app
- Add fingerprint → Cole o SHA-1

#### Passo 5: Configurar firebase_options.dart

**Opção A: Automática (Recomendado)**
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**Opção B: Manual**
Edite `lib/firebase_options.dart` com as credenciais do Firebase Console

#### Passo 6: Executar
```bash
flutter run
```

### Opção 3: Desabilitar Firebase Temporariamente

Renomeie o arquivo main:
```bash
# Renomear main.dart original
move lib\main.dart lib\main_com_firebase.dart

# Renomear versão sem Firebase
move lib\main_sem_firebase.dart lib\main.dart

# Executar
flutter run
```

## 🐛 Outros Erros Comuns

### "PlatformException(sign_in_failed)"
**Causa:** SHA-1 não configurado
**Solução:** Execute `gradlew signingReport` e adicione SHA-1 no Firebase

### "FirebaseException: [core/no-app]"
**Causa:** Firebase não inicializado
**Solução:** Verifique `firebase_options.dart` e `google-services.json`

### "MissingPluginException"
**Causa:** Plugins não instalados
**Solução:**
```bash
flutter clean
flutter pub get
flutter run
```

### Tela branca ou erro de build
**Causa:** Erro de compilação
**Solução:**
```bash
flutter clean
cd android
gradlew clean
cd ..
flutter pub get
flutter run
```

## 📱 Testando no Emulador

### Verificar dispositivos disponíveis
```bash
flutter devices
```

### Executar em dispositivo específico
```bash
# Android
flutter run -d emulator-5554

# Windows
flutter run -d windows

# Web
flutter run -d edge
```

## 🎯 Verificação Rápida

Execute estes comandos para diagnosticar:

```bash
# 1. Verificar instalação Flutter
flutter doctor

# 2. Verificar dependências
flutter pub get

# 3. Analisar código
flutter analyze

# 4. Limpar cache
flutter clean

# 5. Testar versão DEMO
flutter run lib/main_sem_firebase.dart
```

## 📋 Checklist de Configuração

### Para versão DEMO (sem Firebase)
- [ ] Executar `flutter pub get`
- [ ] Executar `flutter run lib/main_sem_firebase.dart`
- [ ] Testar tela de login
- [ ] Clicar em "Entrar com Google (DEMO)"
- [ ] Verificar redirecionamento para home

### Para versão COM Firebase
- [ ] Criar projeto no Firebase Console
- [ ] Baixar `google-services.json`
- [ ] Habilitar Google Authentication
- [ ] Obter e adicionar SHA-1
- [ ] Configurar `firebase_options.dart`
- [ ] Executar `flutter pub get`
- [ ] Executar `flutter run`

## 💡 Dica

Se você só quer **ver a interface** funcionando rapidamente, use:

```bash
flutter run lib/main_sem_firebase.dart
```

Depois configure o Firebase com calma seguindo o arquivo `CONFIGURACAO_FIREBASE.md`.

## 📞 Logs Úteis

Para ver logs detalhados durante execução:
```bash
flutter run -v
```

Para ver apenas erros:
```bash
flutter run 2>&1 | findstr "Error Exception"
```
