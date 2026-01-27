# 🚀 Como Executar o App

## Problema: Visual Studio Toolchain

O erro "Unable to find suitable Visual Studio toolchain" aparece quando você tenta executar no Windows desktop sem ter o Visual Studio configurado.

## ✅ Soluções

### Opção 1: Executar no Emulador Android (Recomendado)

#### Passo 1: Abrir Android Studio
1. Abra o **Android Studio**
2. Clique em **More Actions** → **Virtual Device Manager**
3. Ou vá em **Tools** → **Device Manager**

#### Passo 2: Iniciar Emulador
1. Na lista de dispositivos virtuais, clique no botão **▶️ Play**
2. Escolha um dos emuladores:
   - Pixel 4 API 35
   - Pixel 7 - API 36
3. Aguarde o emulador iniciar (pode levar 1-2 minutos)

#### Passo 3: Executar o App
No terminal do Android Studio ou VS Code:
```bash
flutter run
```

Ou clique no botão **Run** (▶️) no Android Studio.

### Opção 2: Executar no Navegador (Mais Rápido)

```bash
flutter run -d chrome
```

Ou:

```bash
flutter run -d edge
```

### Opção 3: Executar em Dispositivo Físico Android

#### Passo 1: Habilitar Modo Desenvolvedor no Android
1. Vá em **Configurações** → **Sobre o telefone**
2. Toque 7 vezes em **Número da versão**
3. Volte e entre em **Opções do desenvolvedor**
4. Ative **Depuração USB**

#### Passo 2: Conectar o Dispositivo
1. Conecte o celular no PC via USB
2. Aceite a permissão de depuração no celular

#### Passo 3: Verificar Conexão
```bash
flutter devices
```

Você deve ver seu dispositivo na lista.

#### Passo 4: Executar
```bash
flutter run
```

### Opção 4: Configurar Visual Studio (Para Windows Desktop)

Se você realmente quer executar no Windows desktop:

#### Passo 1: Instalar Visual Studio
1. Baixe o **Visual Studio 2022 Community** (gratuito)
2. Durante a instalação, selecione:
   - ✅ **Desktop development with C++**
   - ✅ **Windows 10 SDK**

#### Passo 2: Verificar Instalação
```bash
flutter doctor
```

#### Passo 3: Executar
```bash
flutter run -d windows
```

## 🎯 Recomendação

Para testar o app rapidamente, use uma destas opções em ordem de preferência:

1. **Emulador Android** (melhor para testar funcionalidades mobile)
2. **Navegador Chrome/Edge** (mais rápido para desenvolvimento)
3. **Dispositivo físico Android** (melhor performance)
4. **Windows Desktop** (requer configuração adicional)

## 📱 Comandos Úteis

### Ver dispositivos disponíveis
```bash
flutter devices
```

### Ver emuladores disponíveis
```bash
flutter emulators
```

### Iniciar emulador específico
```bash
flutter emulators --launch Pixel_4_API_35
```

### Executar em dispositivo específico
```bash
flutter run -d <device-id>
```

Exemplos:
```bash
flutter run -d chrome
flutter run -d edge
flutter run -d emulator-5554
flutter run -d windows
```

### Hot Reload durante execução
Pressione `r` no terminal

### Hot Restart durante execução
Pressione `R` no terminal

### Parar execução
Pressione `q` no terminal

## 🐛 Troubleshooting

### Emulador não inicia
1. Abra o Android Studio
2. Vá em **Tools** → **Device Manager**
3. Delete o emulador problemático
4. Crie um novo emulador
5. Tente novamente

### Dispositivo não detectado
```bash
# Reiniciar ADB
adb kill-server
adb start-server
flutter devices
```

### Erro de build
```bash
flutter clean
flutter pub get
flutter run
```

### Erro no Android
```bash
cd android
gradlew clean
cd ..
flutter clean
flutter run
```

## 💡 Dica

Para desenvolvimento rápido, recomendo usar o **Chrome**:

```bash
flutter run -d chrome
```

É mais rápido que o emulador e perfeito para testar a interface e funcionalidades.

## 📞 Ainda com Problemas?

1. Execute `flutter doctor -v` e verifique os problemas
2. Consulte o [FAQ](docs/FAQ.md)
3. Veja o [Guia de Setup](docs/SETUP.md)
4. Abra uma issue no GitHub

---

**Próximo passo**: Depois de executar, consulte o [Guia de Uso](docs/USAGE.md) para aprender a usar o app!
