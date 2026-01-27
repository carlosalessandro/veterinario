# Guia de Contribuição

Obrigado por considerar contribuir com o Sistema Veterinário! 🎉

## Como Contribuir

### Reportando Bugs

Se você encontrou um bug, por favor abra uma issue incluindo:

- Descrição clara do problema
- Passos para reproduzir
- Comportamento esperado vs comportamento atual
- Screenshots (se aplicável)
- Versão do Flutter e sistema operacional

### Sugerindo Melhorias

Para sugerir novas funcionalidades:

1. Verifique se já não existe uma issue similar
2. Abra uma nova issue com a tag "enhancement"
3. Descreva detalhadamente a funcionalidade
4. Explique por que seria útil

### Pull Requests

1. Faça um fork do repositório
2. Crie uma branch a partir da `main`:
   ```bash
   git checkout -b feature/minha-feature
   ```
3. Faça suas alterações seguindo o estilo de código do projeto
4. Teste suas alterações
5. Commit suas mudanças com mensagens claras:
   ```bash
   git commit -m "feat: adiciona funcionalidade X"
   ```
6. Push para sua branch:
   ```bash
   git push origin feature/minha-feature
   ```
7. Abra um Pull Request

## Padrões de Código

### Convenções de Nomenclatura

- Classes: `PascalCase`
- Variáveis e funções: `camelCase`
- Constantes: `UPPER_SNAKE_CASE`
- Arquivos: `snake_case.dart`

### Estrutura de Commits

Seguimos o padrão Conventional Commits:

- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Alterações na documentação
- `style:` Formatação, ponto e vírgula, etc
- `refactor:` Refatoração de código
- `test:` Adição ou correção de testes
- `chore:` Tarefas de manutenção

### Código Dart

- Use `const` sempre que possível
- Prefira `final` ao invés de `var`
- Adicione comentários para lógica complexa
- Mantenha funções pequenas e focadas
- Use nomes descritivos para variáveis

## Testando

Antes de submeter um PR, certifique-se de:

1. Executar `flutter analyze` sem erros
2. Executar `flutter test` (quando testes estiverem disponíveis)
3. Testar manualmente em diferentes dispositivos/emuladores

## Dúvidas?

Se tiver dúvidas, sinta-se à vontade para:
- Abrir uma issue com a tag "question"
- Comentar em issues existentes
- Entrar em contato com os mantenedores

Obrigado por contribuir! 🚀
