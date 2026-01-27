# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [1.0.0] - 2026-01-26

### Adicionado
- Sistema completo de gerenciamento veterinário
- Dashboard com estatísticas em tempo real
- Gerenciamento de clientes (CRUD completo)
  - Cadastro com nome, email, telefone, CPF e endereço
  - Máscaras de entrada para telefone e CPF
  - Visualização de pets do cliente
- Gerenciamento de pets (CRUD completo)
  - Cadastro com informações detalhadas
  - Suporte para múltiplas espécies
  - Cálculo automático de idade
  - Vinculação com proprietário
- Sistema de agendamento de consultas
  - Calendário interativo
  - Múltiplos tipos de consulta
  - Controle de status
  - Campos para diagnóstico e tratamento
- Controle de vacinação
  - Registro de vacinas aplicadas
  - Controle de próximas doses
  - Informações de lote e veterinário
- Banco de dados SQLite local
  - Persistência de dados
  - Relacionamentos entre tabelas
  - Exclusão em cascata
- Interface Material Design 3
  - Tema customizado
  - Navegação por bottom bar
  - Cards e formulários estilizados
- Validação de formulários
- Formatação de datas em português

### Tecnologias
- Flutter 3.9.0
- Provider para gerenciamento de estado
- SQLite para persistência
- Table Calendar para calendário
- Intl para internacionalização

## [Unreleased]

### Planejado
- Exportação de relatórios em PDF
- Notificações push
- Backup na nuvem
- Gráficos de crescimento
- Integração com câmera
- Sistema de autenticação
- Modo escuro
