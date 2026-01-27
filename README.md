# 🐾 Sistema Veterinário

Um aplicativo completo de gerenciamento veterinário desenvolvido em Flutter, com recursos para gerenciar pets, clientes, consultas e histórico médico.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📑 Documentação

- **[🚀 Início Rápido](QUICK_START.md)** - Comece em 5 minutos
- **[📋 Resumo Executivo](SUMMARY.md)** - Visão geral do projeto
- **[📑 Índice Geral](INDEX.md)** - Navegação completa
- **[📚 Documentação Completa](docs/README.md)** - Todos os guias

## 📱 Funcionalidades

### 🏠 Dashboard
- Visão geral do sistema com estatísticas
- Total de pets cadastrados
- Número de clientes
- Consultas do dia
- Consultas pendentes

### 🐕 Gerenciamento de Pets
- Cadastro completo de pets (nome, espécie, raça, data de nascimento, peso, cor)
- Edição e exclusão de registros
- Visualização detalhada com abas:
  - Informações gerais
  - Histórico de consultas
  - Carteira de vacinação
- Suporte para múltiplas espécies (cachorro, gato, pássaro, coelho, outros)

### 👥 Gerenciamento de Clientes
- Cadastro de proprietários com dados completos
- Informações: nome, email, telefone, CPF, endereço
- Máscaras de entrada para telefone e CPF
- Visualização de todos os pets do cliente
- Edição e exclusão de registros

### 📅 Agendamento de Consultas
- Calendário interativo para visualização de consultas
- Tipos de consulta: consulta, vacinação, cirurgia, exame, retorno, emergência
- Status: agendada, confirmada, em atendimento, concluída, cancelada
- Campos para diagnóstico e tratamento
- Observações personalizadas

### 💉 Controle de Vacinas
- Registro de vacinas aplicadas
- Data de aplicação e próxima dose
- Informações do lote e veterinário responsável
- Observações adicionais

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Provider** - Gerenciamento de estado
- **SQLite** (sqflite) - Banco de dados local
- **Table Calendar** - Calendário interativo
- **Intl** - Formatação de datas e internacionalização
- **Mask Text Input Formatter** - Máscaras de entrada

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.1
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  path: ^1.8.3
  intl: ^0.19.0
  table_calendar: ^3.0.9
  flutter_slidable: ^3.0.1
  flutter_speed_dial: ^7.0.0
  mask_text_input_formatter: ^2.5.0
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK instalado (versão 3.9.0 ou superior)
- Android Studio ou VS Code com extensões Flutter
- Emulador Android/iOS ou dispositivo físico

### Passos

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/veterinario.git
cd veterinario
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## 📂 Estrutura do Projeto

```
lib/
├── database/
│   └── database_helper.dart      # Gerenciamento do banco de dados SQLite
├── models/
│   ├── owner.dart                # Modelo de Cliente
│   ├── pet.dart                  # Modelo de Pet
│   ├── appointment.dart          # Modelo de Consulta
│   └── vaccine.dart              # Modelo de Vacina
├── providers/
│   ├── owner_provider.dart       # Provider de Clientes
│   ├── pet_provider.dart         # Provider de Pets
│   └── appointment_provider.dart # Provider de Consultas
├── screens/
│   ├── home_screen.dart          # Tela principal com navegação
│   ├── dashboard_screen.dart     # Dashboard com estatísticas
│   ├── owners_screen.dart        # Lista de clientes
│   ├── owner_form_screen.dart    # Formulário de cliente
│   ├── owner_detail_screen.dart  # Detalhes do cliente
│   ├── pets_screen.dart          # Lista de pets
│   ├── pet_form_screen.dart      # Formulário de pet
│   ├── pet_detail_screen.dart    # Detalhes do pet
│   ├── appointments_screen.dart  # Calendário de consultas
│   ├── appointment_form_screen.dart # Formulário de consulta
│   └── vaccine_form_screen.dart  # Formulário de vacina
└── main.dart                     # Ponto de entrada do app
```

## 💾 Banco de Dados

O aplicativo utiliza SQLite para persistência local de dados com as seguintes tabelas:

- **owners** - Dados dos proprietários
- **pets** - Informações dos pets
- **appointments** - Consultas agendadas
- **vaccines** - Registro de vacinas

Todas as tabelas possuem relacionamentos com chaves estrangeiras e exclusão em cascata.

## 🎨 Interface

O aplicativo utiliza Material Design 3 com:
- Navegação por bottom navigation bar
- Cards com elevação e bordas arredondadas
- Tema customizado com cores teal
- Ícones intuitivos para cada funcionalidade
- Formulários com validação

## 📱 Capturas de Tela

### Dashboard
Visão geral com estatísticas e consultas do dia

### Gerenciamento de Pets
Lista completa de pets com informações resumidas

### Calendário de Consultas
Visualização mensal com marcadores de eventos

### Detalhes do Pet
Abas com informações, consultas e vacinas

## 🔄 Funcionalidades Futuras

- [ ] Exportação de relatórios em PDF
- [ ] Notificações push para consultas
- [ ] Backup na nuvem
- [ ] Gráficos de crescimento do pet
- [ ] Integração com câmera para fotos
- [ ] Lembretes de vacinas
- [ ] Sistema de autenticação
- [ ] Modo escuro

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer um fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abrir um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

Desenvolvido com ❤️ usando Flutter

## 📞 Suporte

Para suporte, abra uma issue no GitHub ou entre em contato através do email.

---

⭐ Se este projeto foi útil para você, considere dar uma estrela no repositório!
