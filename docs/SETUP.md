# Guia de Configuração

## Requisitos do Sistema

### Software Necessário

1. **Flutter SDK**
   - Versão: 3.9.0 ou superior
   - Download: https://flutter.dev/docs/get-started/install

2. **IDE (escolha uma)**
   - Android Studio (recomendado)
   - Visual Studio Code com extensões Flutter/Dart
   - IntelliJ IDEA

3. **Emulador ou Dispositivo**
   - Android: Android Studio AVD ou dispositivo físico
   - iOS: Xcode Simulator ou dispositivo físico (apenas macOS)

### Verificar Instalação

Execute o comando para verificar se tudo está configurado:

```bash
flutter doctor
```

Certifique-se de que todos os itens estão marcados com ✓.

## Instalação do Projeto

### 1. Clonar o Repositório

```bash
git clone https://github.com/seu-usuario/veterinario.git
cd veterinario
```

### 2. Instalar Dependências

```bash
flutter pub get
```

### 3. Verificar Configuração

```bash
flutter doctor -v
```

## Configuração por Plataforma

### Android

1. **Android Studio**
   - Instale o Android Studio
   - Configure o Android SDK
   - Crie um AVD (Android Virtual Device)

2. **Variáveis de Ambiente**
   ```bash
   export ANDROID_HOME=$HOME/Android/Sdk
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

3. **Executar**
   ```bash
   flutter run
   ```

### iOS (apenas macOS)

1. **Xcode**
   - Instale o Xcode da App Store
   - Execute: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`
   - Execute: `sudo xcodebuild -runFirstLaunch`

2. **CocoaPods**
   ```bash
   sudo gem install cocoapods
   cd ios
   pod install
   cd ..
   ```

3. **Executar**
   ```bash
   flutter run
   ```

### Web

1. **Habilitar Web**
   ```bash
   flutter config --enable-web
   ```

2. **Executar**
   ```bash
   flutter run -d chrome
   ```

### Windows

1. **Habilitar Windows**
   ```bash
   flutter config --enable-windows-desktop
   ```

2. **Executar**
   ```bash
   flutter run -d windows
   ```

### Linux

1. **Dependências**
   ```bash
   sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
   ```

2. **Habilitar Linux**
   ```bash
   flutter config --enable-linux-desktop
   ```

3. **Executar**
   ```bash
   flutter run -d linux
   ```

## Configuração do Banco de Dados

O banco de dados SQLite é criado automaticamente na primeira execução.

### Localização do Banco

- **Android**: `/data/data/com.example.veterinario/databases/veterinario.db`
- **iOS**: `Library/Application Support/veterinario.db`
- **Windows**: `%APPDATA%/veterinario/veterinario.db`

### Resetar Banco de Dados

Para resetar o banco durante desenvolvimento:

1. Desinstale o app
2. Reinstale com `flutter run`

Ou manualmente:

```bash
# Android
adb shell
run-as com.example.veterinario
cd databases
rm veterinario.db

# iOS
flutter clean
flutter run
```

## Configuração de Desenvolvimento

### Hot Reload

Durante o desenvolvimento, use:
- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

### Debug Mode

```bash
flutter run --debug
```

### Release Mode

```bash
flutter run --release
```

### Profile Mode

```bash
flutter run --profile
```

## Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto (se necessário):

```env
# Exemplo de variáveis
API_URL=https://api.exemplo.com
DEBUG_MODE=true
```

## Troubleshooting

### Problema: Dependências não instaladas

**Solução:**
```bash
flutter clean
flutter pub get
```

### Problema: Erro de build no Android

**Solução:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

### Problema: Erro de build no iOS

**Solução:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

### Problema: Banco de dados corrompido

**Solução:**
1. Desinstale o app
2. Execute `flutter clean`
3. Reinstale com `flutter run`

### Problema: Hot reload não funciona

**Solução:**
1. Pressione `R` para hot restart
2. Se não funcionar, pare e execute `flutter run` novamente

## Ferramentas Úteis

### Flutter DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Análise de Código

```bash
flutter analyze
```

### Formatação de Código

```bash
flutter format .
```

### Testes

```bash
flutter test
```

## Build para Produção

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Próximos Passos

1. Leia a [Documentação de Arquitetura](ARCHITECTURE.md)
2. Veja a [Documentação da API](API.md)
3. Consulte o [Guia de Contribuição](../CONTRIBUTING.md)
4. Explore o código em `lib/`

## Suporte

Se encontrar problemas:
1. Verifique a [documentação oficial do Flutter](https://flutter.dev/docs)
2. Consulte as [issues do GitHub](https://github.com/seu-usuario/veterinario/issues)
3. Abra uma nova issue se necessário
