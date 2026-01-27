# 🚀 Guia Rápido - Sistema Veterinário

## ⚡ Início em 5 Minutos

### 1. Pré-requisitos
```bash
# Verifique se o Flutter está instalado
flutter doctor
```

### 2. Clone e Instale
```bash
# Clone o repositório
git clone https://github.com/seu-usuario/veterinario.git
cd veterinario

# Instale as dependências
flutter pub get
```

### 3. Execute
```bash
# Execute o app
flutter run
```

Pronto! O app está rodando! 🎉

## 📱 Primeiros Passos no App

### Passo 1: Cadastre um Cliente
1. Vá para a aba **Clientes** (ícone de pessoas)
2. Toque no botão **+**
3. Preencha os dados
4. Toque em **Cadastrar**

### Passo 2: Cadastre um Pet
1. Vá para a aba **Pets** (ícone de pata)
2. Toque no botão **+**
3. Preencha os dados
4. Selecione o cliente cadastrado
5. Toque em **Cadastrar**

### Passo 3: Agende uma Consulta
1. Vá para a aba **Consultas** (ícone de calendário)
2. Toque no botão **+**
3. Selecione o pet
4. Escolha data e hora
5. Toque em **Agendar**

### Passo 4: Registre uma Vacina
1. Vá para a aba **Pets**
2. Toque no pet desejado
3. Vá para a aba **Vacinas**
4. Toque em **Adicionar Vacina**
5. Preencha os dados
6. Toque em **Salvar Vacina**

## 🎯 Funcionalidades Principais

### Dashboard
- Veja estatísticas em tempo real
- Consultas do dia
- Totais de pets e clientes

### Pets
- ✅ Cadastrar, editar e excluir
- ✅ Ver detalhes completos
- ✅ Histórico de consultas
- ✅ Carteira de vacinação

### Clientes
- ✅ Cadastrar, editar e excluir
- ✅ Ver todos os pets do cliente
- ✅ Dados completos com validação

### Consultas
- ✅ Calendário interativo
- ✅ Múltiplos tipos e status
- ✅ Diagnóstico e tratamento
- ✅ Filtrar por data

## 🛠️ Comandos Úteis

```bash
# Executar em modo debug
flutter run

# Executar em modo release
flutter run --release

# Executar no Chrome (Web)
flutter run -d chrome

# Verificar problemas
flutter analyze

# Limpar build
flutter clean

# Atualizar dependências
flutter pub get

# Ver dispositivos disponíveis
flutter devices
```

## 📚 Documentação Completa

- **[README.md](README.md)** - Visão geral do projeto
- **[docs/USAGE.md](docs/USAGE.md)** - Guia detalhado de uso
- **[docs/SETUP.md](docs/SETUP.md)** - Instalação completa
- **[docs/FAQ.md](docs/FAQ.md)** - Perguntas frequentes

## 🐛 Problemas Comuns

### Erro ao executar
```bash
flutter clean
flutter pub get
flutter run
```

### Dependências não instaladas
```bash
flutter pub get
```

### Erro de build
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

## 💡 Dicas

1. **Use Hot Reload**: Pressione `r` durante desenvolvimento
2. **Dados de Teste**: Cadastre alguns dados para testar
3. **Explore**: Navegue por todas as telas
4. **Leia a Documentação**: Consulte os docs para mais detalhes

## 🎨 Personalização Rápida

### Mudar Cor do Tema
Edite `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.blue, // Mude aqui!
),
```

### Adicionar Tipo de Consulta
Edite `lib/screens/appointment_form_screen.dart`:
```dart
final List<String> _types = [
  'Consulta',
  'Vacinação',
  'Cirurgia',
  'Exame',
  'Retorno',
  'Emergência',
  'Seu Novo Tipo', // Adicione aqui!
];
```

## 🚀 Próximos Passos

1. ✅ Execute o app
2. ✅ Cadastre dados de teste
3. ✅ Explore todas as funcionalidades
4. 📖 Leia a [documentação completa](docs/README.md)
5. 🤝 [Contribua](CONTRIBUTING.md) com o projeto

## 📞 Precisa de Ajuda?

- 📖 [Documentação](docs/README.md)
- ❓ [FAQ](docs/FAQ.md)
- 🐛 [Reportar Bug](https://github.com/seu-usuario/veterinario/issues)
- 💡 [Sugerir Funcionalidade](https://github.com/seu-usuario/veterinario/issues)

## ⭐ Gostou?

- ⭐ Dê uma estrela no GitHub
- 🐛 Reporte bugs
- 💡 Sugira melhorias
- 🤝 Contribua com código

---

**Desenvolvido com ❤️ usando Flutter**

[Ver Documentação Completa](README.md) | [Guia de Uso](docs/USAGE.md) | [FAQ](docs/FAQ.md)
