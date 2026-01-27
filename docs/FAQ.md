# Perguntas Frequentes (FAQ)

## Geral

### O que é o Sistema Veterinário?
É um aplicativo completo de gerenciamento para clínicas veterinárias, desenvolvido em Flutter. Permite gerenciar pets, clientes, consultas e vacinas de forma integrada.

### O app é gratuito?
Sim, o código é open source sob licença MIT. Você pode usar, modificar e distribuir livremente.

### Precisa de internet para funcionar?
Não! O app funciona 100% offline. Todos os dados são armazenados localmente no dispositivo usando SQLite.

### Em quais plataformas funciona?
- Android (5.0+)
- iOS (11.0+)
- Web (navegadores modernos)
- Windows (10+)
- Linux
- macOS (10.14+)

## Instalação e Configuração

### Como instalo o app?
Siga o [Guia de Configuração](SETUP.md) para instruções detalhadas de instalação.

### Preciso de conhecimento em programação?
Para usar o app: Não
Para desenvolver/modificar: Sim, conhecimento em Flutter/Dart é necessário

### Como atualizo o app?
```bash
git pull origin main
flutter pub get
flutter run
```

### Posso usar em múltiplos dispositivos?
Atualmente cada dispositivo tem seu próprio banco de dados local. Sincronização na nuvem está planejada para versões futuras.

## Uso do Sistema

### Como faço backup dos dados?
Atualmente o backup é manual. O banco de dados está localizado em:
- Android: `/data/data/com.example.veterinario/databases/`
- iOS: `Library/Application Support/`

Backup automático na nuvem está planejado.

### Posso importar dados de outro sistema?
Não há importação automática ainda. Você precisará cadastrar os dados manualmente ou desenvolver um script de importação.

### Quantos registros posso ter?
Não há limite definido. O SQLite suporta milhões de registros, mas a performance pode variar dependendo do dispositivo.

### Como faço busca de pets ou clientes?
Atualmente a busca não está implementada, mas está planejada. Por enquanto, as listas são ordenadas alfabeticamente.

## Funcionalidades

### Posso adicionar fotos dos pets?
O campo está preparado no banco de dados, mas a funcionalidade de câmera/galeria ainda não está implementada. Está planejada para versões futuras.

### Como recebo notificações de consultas?
Notificações push ainda não estão implementadas, mas estão no roadmap.

### Posso gerar relatórios?
Exportação de relatórios em PDF está planejada para versões futuras.

### Há controle de estoque de medicamentos?
Não na versão atual. Pode ser adicionado como funcionalidade futura.

### Posso registrar pagamentos?
Não há módulo financeiro ainda. Está planejado para versões futuras.

### Há sistema de usuários/login?
Não. O app é single-user atualmente. Multi-usuário com autenticação está planejado.

## Dados e Privacidade

### Meus dados estão seguros?
Os dados são armazenados localmente no dispositivo. Não há transmissão para servidores externos.

### Posso excluir todos os dados?
Sim, desinstalando o app ou deletando o arquivo do banco de dados.

### O que acontece se eu excluir um cliente?
Todos os pets do cliente e seus dados relacionados (consultas, vacinas) também serão excluídos (exclusão em cascata).

### O que acontece se eu excluir um pet?
Todas as consultas e vacinas do pet também serão excluídas.

### Posso recuperar dados excluídos?
Não há função de recuperação. Sempre confirme antes de excluir.

## Problemas Técnicos

### O app não abre
1. Verifique se o Flutter está instalado corretamente
2. Execute `flutter doctor`
3. Tente `flutter clean` e `flutter run`

### Erro ao cadastrar dados
1. Verifique se todos os campos obrigatórios estão preenchidos
2. Verifique se há um cliente cadastrado (para pets)
3. Reinicie o app

### Dados não aparecem
1. Verifique se o cadastro foi concluído
2. Feche e abra o app novamente
3. Verifique se não há erros no console

### Erro de banco de dados
1. Desinstale o app
2. Execute `flutter clean`
3. Reinstale com `flutter run`

### Hot reload não funciona
1. Pressione `R` para hot restart
2. Se não funcionar, pare e execute `flutter run` novamente

## Desenvolvimento

### Como contribuo com o projeto?
Leia o [Guia de Contribuição](../CONTRIBUTING.md) para detalhes.

### Posso usar em minha clínica?
Sim! O projeto é open source sob licença MIT.

### Posso vender o app?
Sim, a licença MIT permite uso comercial.

### Como adiciono novas funcionalidades?
1. Faça um fork do repositório
2. Crie uma branch para sua feature
3. Desenvolva e teste
4. Abra um Pull Request

### Onde reporto bugs?
Abra uma [issue no GitHub](https://github.com/seu-usuario/veterinario/issues) com:
- Descrição do problema
- Passos para reproduzir
- Screenshots se possível
- Versão do Flutter e sistema operacional

### Como sugiro melhorias?
Abra uma issue com a tag "enhancement" descrevendo sua sugestão.

## Customização

### Posso mudar as cores do app?
Sim! Edite o arquivo `lib/main.dart` e modifique o `ColorScheme`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.blue, // Mude aqui
),
```

### Posso adicionar novos tipos de consulta?
Sim! Edite `lib/screens/appointment_form_screen.dart` e adicione na lista `_types`.

### Posso adicionar novas espécies de pets?
Sim! Edite `lib/screens/pet_form_screen.dart` e adicione na lista `_species`.

### Posso mudar o idioma?
O app está em português. Para adicionar outros idiomas, você precisará implementar internacionalização (i18n).

## Performance

### O app está lento
1. Verifique quantos registros você tem
2. Execute em modo release: `flutter run --release`
3. Considere limpar dados antigos

### Quanto espaço ocupa?
- App: ~20-50 MB
- Banco de dados: Varia conforme uso (geralmente < 10 MB)

### Funciona em dispositivos antigos?
Sim, mas a performance pode variar. Recomendado:
- Android 5.0+ com 2GB RAM
- iOS 11.0+ com 2GB RAM

## Roadmap

### Quais funcionalidades estão planejadas?
Veja o [CHANGELOG.md](../CHANGELOG.md) para o roadmap completo.

### Quando terá sincronização na nuvem?
Está no roadmap de longo prazo. Sem data definida.

### Quando terá modo escuro?
Está planejado para médio prazo.

### Quando terá notificações?
Está planejado para curto prazo.

## Suporte

### Onde encontro mais ajuda?
- [README.md](../README.md) - Visão geral
- [SETUP.md](SETUP.md) - Instalação
- [USAGE.md](USAGE.md) - Como usar
- [ARCHITECTURE.md](ARCHITECTURE.md) - Arquitetura
- [API.md](API.md) - Documentação da API

### Como entro em contato?
- Abra uma issue no GitHub
- Email: [seu-email]
- Discord: [seu-discord] (se houver)

### O projeto está ativo?
Sim! Contribuições são bem-vindas.

### Há comunidade?
Estamos construindo! Junte-se através do GitHub.

## Licença

### Qual a licença?
MIT License - Veja [LICENSE](../LICENSE)

### Posso usar comercialmente?
Sim, a licença MIT permite uso comercial.

### Preciso dar créditos?
Não é obrigatório, mas é apreciado!

### Posso modificar o código?
Sim, você tem total liberdade para modificar.

## Outros

### Por que Flutter?
- Multiplataforma (um código, várias plataformas)
- Performance nativa
- UI moderna e responsiva
- Grande comunidade

### Por que SQLite?
- Leve e rápido
- Não precisa de servidor
- Confiável e maduro
- Perfeito para apps offline

### Há versão web demo?
Não há demo online ainda. Você pode executar localmente com:
```bash
flutter run -d chrome
```

### Posso integrar com outros sistemas?
Sim! Você pode desenvolver integrações via API REST (quando implementada) ou acessar o banco SQLite diretamente.

### Há documentação da API?
Sim! Veja [API.md](API.md)

### Onde está o código fonte?
GitHub: [https://github.com/seu-usuario/veterinario](https://github.com/seu-usuario/veterinario)

---

**Não encontrou sua pergunta?**
Abra uma [issue no GitHub](https://github.com/seu-usuario/veterinario/issues) com a tag "question"!
