# Login Simples - Sistema Veterinário

## ✅ Implementado

Sistema de login simples **SEM Firebase** e **SEM Google Sign-In**.

### Credenciais de Acesso

```
Usuário: admin
Senha: 123456
```

## 🎨 Funcionalidades

### Tela de Login
- ✅ Design moderno com gradiente
- ✅ Campos de usuário e senha
- ✅ Validação de campos obrigatórios
- ✅ Botão para mostrar/ocultar senha
- ✅ Mensagens de erro amigáveis
- ✅ Loading indicator durante autenticação
- ✅ Credenciais exibidas na tela para facilitar

### Autenticação
- ✅ Login com usuário e senha fixos
- ✅ Validação de credenciais
- ✅ Persistência de sessão com SharedPreferences
- ✅ Redirecionamento automático após login
- ✅ Logout funcional

### Dashboard
- ✅ Exibe nome do usuário logado
- ✅ Ícone de perfil
- ✅ Menu com opção de logout
- ✅ Todas as funcionalidades do sistema mantidas

## 📁 Arquivos Modificados

```
lib/
├── main.dart                       # Removido Firebase
├── providers/
│   └── auth_provider.dart          # Autenticação simples
├── services/
│   └── auth_service.dart           # Login com credenciais fixas
├── screens/
│   ├── login_screen.dart           # Formulário de login
│   └── dashboard_screen.dart       # Exibe usuário logado
└── pubspec.yaml                    # Removidas dependências Firebase/Google
```

## 🚀 Como Usar

### 1. Instalar Dependências
```bash
flutter pub get
```

### 2. Executar o App
```bash
flutter run
```

### 3. Fazer Login
1. Abra o app
2. Digite: **admin**
3. Digite: **123456**
4. Clique em **Entrar**
5. Você será redirecionado para a tela inicial

### 4. Fazer Logout
1. No Dashboard, clique no menu (⋮) no canto superior direito
2. Selecione **Sair**
3. Você voltará para a tela de login

## 🔧 Detalhes Técnicos

### Validação de Login
```dart
// Credenciais fixas no AuthService
static const String _adminUsername = 'admin';
static const String _adminPassword = '123456';
```

### Persistência de Sessão
- Usa `SharedPreferences` para salvar estado de login
- Usuário permanece logado após fechar o app
- Logout limpa os dados salvos

### Segurança
⚠️ **IMPORTANTE**: Este é um sistema de login básico para desenvolvimento/demonstração.

Para produção, considere:
- [ ] Criptografar senhas
- [ ] Usar banco de dados para usuários
- [ ] Implementar tokens de autenticação
- [ ] Adicionar recuperação de senha
- [ ] Implementar múltiplos usuários
- [ ] Adicionar roles/permissões

## 📦 Dependências Removidas

As seguintes dependências do Firebase foram removidas:
- ❌ `firebase_core`
- ❌ `firebase_auth`
- ❌ `google_sign_in`

Mantida apenas:
- ✅ `shared_preferences` (para persistência local)

## 🎯 Vantagens desta Abordagem

1. **Sem configuração externa** - Não precisa configurar Firebase
2. **Funciona offline** - Não depende de internet
3. **Simples e rápido** - Ideal para desenvolvimento e testes
4. **Leve** - Menos dependências = app menor
5. **Fácil de entender** - Código simples e direto

## 🔄 Próximas Melhorias Sugeridas

### Curto Prazo
- [ ] Adicionar mais usuários (veterinário, recepcionista)
- [ ] Implementar roles/permissões
- [ ] Adicionar "Lembrar-me"
- [ ] Melhorar mensagens de erro

### Médio Prazo
- [ ] Banco de dados local para usuários (SQLite)
- [ ] Criptografia de senhas
- [ ] Recuperação de senha
- [ ] Perfil de usuário editável

### Longo Prazo
- [ ] Autenticação com backend real
- [ ] Login biométrico
- [ ] Autenticação de dois fatores
- [ ] Sincronização com servidor

## 🐛 Troubleshooting

### Não consigo fazer login
- Verifique se digitou exatamente: `admin` e `123456`
- Usuário e senha são case-sensitive

### Sessão não persiste
- Verifique se `shared_preferences` está instalado
- Execute `flutter clean` e `flutter pub get`

### Erro ao compilar
```bash
flutter clean
flutter pub get
flutter run
```

## ✨ Pronto para Usar!

O sistema está completamente funcional e pronto para uso. Basta executar e fazer login com as credenciais fornecidas!
