# Guia de Uso

Este guia mostra como usar as principais funcionalidades do Sistema Veterinário.

## Primeiros Passos

### 1. Cadastrar um Cliente

1. Abra o app e navegue até a aba **Clientes**
2. Toque no botão **+** (flutuante no canto inferior direito)
3. Preencha o formulário:
   - Nome Completo: "João Silva"
   - Email: "joao@email.com"
   - Telefone: "(11) 98765-4321" (máscara automática)
   - CPF: "123.456.789-00" (máscara automática)
   - Endereço: "Rua Exemplo, 123 - São Paulo, SP"
4. Toque em **Cadastrar**

### 2. Cadastrar um Pet

1. Navegue até a aba **Pets**
2. Toque no botão **+**
3. Preencha o formulário:
   - Nome: "Rex"
   - Espécie: Selecione "Cachorro"
   - Raça: "Labrador"
   - Sexo: Selecione "Macho"
   - Data de Nascimento: Toque no campo e selecione a data
   - Peso: "25.5"
   - Cor: "Amarelo"
   - Cliente: Selecione "João Silva"
4. Toque em **Cadastrar**

### 3. Agendar uma Consulta

1. Navegue até a aba **Consultas**
2. Toque no botão **+**
3. Preencha o formulário:
   - Pet: Selecione "Rex"
   - Tipo de Consulta: Selecione "Consulta"
   - Status: Selecione "Agendada"
   - Data: Toque e selecione a data desejada
   - Hora: Toque e selecione o horário
   - Observações: "Consulta de rotina"
4. Toque em **Agendar**

### 4. Registrar uma Vacina

1. Navegue até a aba **Pets**
2. Toque no pet desejado (ex: "Rex")
3. Vá para a aba **Vacinas**
4. Toque em **Adicionar Vacina**
5. Preencha o formulário:
   - Nome da Vacina: "V10"
   - Data de Aplicação: Selecione a data
   - Próxima Dose: Selecione a data (opcional)
   - Lote: "ABC123"
   - Veterinário: "Dr. Carlos"
   - Observações: "Primeira dose" (opcional)
6. Toque em **Salvar Vacina**

## Funcionalidades Detalhadas

### Dashboard

#### Visualizar Estatísticas
- Ao abrir o app, você verá automaticamente o Dashboard
- Cards coloridos mostram:
  - Total de Pets cadastrados
  - Número de Clientes
  - Consultas agendadas para hoje
  - Consultas pendentes

#### Consultas do Dia
- Role para baixo para ver a lista de consultas de hoje
- Cada card mostra:
  - Nome do pet
  - Horário da consulta
  - Tipo de consulta
  - Status (com cor indicativa)

### Gerenciamento de Pets

#### Visualizar Lista de Pets
1. Navegue até a aba **Pets**
2. Veja todos os pets cadastrados em ordem alfabética
3. Cada card mostra:
   - Ícone da espécie
   - Nome do pet
   - Espécie e raça
   - Peso

#### Ver Detalhes de um Pet
1. Na lista de pets, toque em qualquer pet
2. Você verá 3 abas:
   - **Informações**: Dados completos do pet
   - **Consultas**: Histórico de atendimentos
   - **Vacinas**: Carteira de vacinação

#### Editar um Pet
1. Abra os detalhes do pet
2. Toque no ícone de **editar** (lápis) no topo
3. Modifique os campos desejados
4. Toque em **Salvar**

#### Excluir um Pet
1. Abra os detalhes do pet
2. Toque no ícone de **excluir** (lixeira) no topo
3. Confirme a exclusão
4. **Atenção**: Isso também excluirá todas as consultas e vacinas do pet

### Gerenciamento de Clientes

#### Visualizar Lista de Clientes
1. Navegue até a aba **Clientes**
2. Veja todos os clientes em ordem alfabética
3. Cada card mostra:
   - Avatar com inicial do nome
   - Nome completo
   - Telefone
   - Email

#### Ver Detalhes de um Cliente
1. Na lista de clientes, toque em qualquer cliente
2. Você verá:
   - Informações completas do cliente
   - Lista de todos os pets do cliente
3. Toque em qualquer pet para ver seus detalhes

#### Editar um Cliente
1. Abra os detalhes do cliente
2. Toque no ícone de **editar** no topo
3. Modifique os campos desejados
4. Toque em **Salvar**

#### Excluir um Cliente
1. Abra os detalhes do cliente
2. Toque no ícone de **excluir** no topo
3. Confirme a exclusão
4. **Atenção**: Isso também excluirá todos os pets e dados relacionados

### Sistema de Consultas

#### Visualizar Calendário
1. Navegue até a aba **Consultas**
2. Veja o calendário mensal
3. Dias com consultas têm marcadores (pontos azuis)
4. Navegue entre meses usando as setas

#### Filtrar Consultas por Data
1. No calendário, toque em qualquer data
2. A lista abaixo mostrará apenas as consultas daquele dia
3. Toque novamente na mesma data para desmarcar e ver todas

#### Ver Todas as Consultas
1. Na tela de consultas, role para baixo
2. Se nenhuma data estiver selecionada, verá todas as consultas
3. Consultas são ordenadas por data (mais recentes primeiro)

#### Editar uma Consulta
1. Toque no menu (três pontos) no card da consulta
2. Selecione **Editar**
3. Modifique os campos desejados
4. Toque em **Salvar**

#### Excluir uma Consulta
1. Toque no menu (três pontos) no card da consulta
2. Selecione **Excluir**
3. Confirme a exclusão

#### Atualizar Status de uma Consulta
1. Edite a consulta
2. Altere o campo **Status**:
   - **Agendada** → **Confirmada** (quando cliente confirmar)
   - **Confirmada** → **Em Atendimento** (quando iniciar)
   - **Em Atendimento** → **Concluída** (quando finalizar)
3. Adicione diagnóstico e tratamento se necessário
4. Salve as alterações

### Controle de Vacinas

#### Visualizar Vacinas de um Pet
1. Abra os detalhes do pet
2. Vá para a aba **Vacinas**
3. Veja todas as vacinas aplicadas
4. Cada card mostra:
   - Nome da vacina
   - Data de aplicação
   - Veterinário responsável

#### Adicionar Nova Vacina
1. Na aba de vacinas do pet
2. Toque em **Adicionar Vacina**
3. Preencha os dados
4. Toque em **Salvar Vacina**

#### Acompanhar Próximas Doses
1. Ao registrar uma vacina, preencha o campo **Próxima Dose**
2. Isso ajuda a lembrar quando aplicar a próxima dose
3. (Notificações automáticas planejadas para versão futura)

## Dicas e Boas Práticas

### Organização

1. **Cadastre clientes primeiro**
   - Sempre cadastre o cliente antes do pet
   - Isso facilita a vinculação

2. **Mantenha dados atualizados**
   - Atualize o peso do pet regularmente
   - Mantenha telefones e emails dos clientes atualizados

3. **Use observações**
   - Adicione notas importantes nas consultas
   - Registre observações nas vacinas

### Consultas

1. **Confirme consultas**
   - Mude o status para "Confirmada" quando o cliente confirmar
   - Isso ajuda a reduzir faltas

2. **Registre diagnóstico e tratamento**
   - Sempre preencha após a consulta
   - Cria um histórico médico completo

3. **Use tipos apropriados**
   - Escolha o tipo correto de consulta
   - Facilita relatórios futuros

### Vacinas

1. **Registre imediatamente**
   - Cadastre a vacina logo após aplicação
   - Não esqueça de anotar o lote

2. **Agende próximas doses**
   - Sempre preencha a data da próxima dose
   - Ajuda no acompanhamento

3. **Mantenha carteira completa**
   - Registre todas as vacinas
   - Importante para viagens e hotéis

## Fluxos Comuns

### Fluxo: Novo Cliente com Pet

1. Cadastrar cliente
2. Cadastrar pet vinculado ao cliente
3. Agendar primeira consulta
4. Registrar vacinas durante a consulta

### Fluxo: Consulta de Rotina

1. Verificar consultas do dia no Dashboard
2. Atualizar status para "Em Atendimento"
3. Realizar atendimento
4. Adicionar diagnóstico e tratamento
5. Atualizar status para "Concluída"
6. Registrar vacinas se aplicadas
7. Agendar retorno se necessário

### Fluxo: Emergência

1. Criar nova consulta
2. Selecionar tipo "Emergência"
3. Definir data/hora imediata
4. Status "Em Atendimento"
5. Registrar procedimentos realizados
6. Finalizar consulta

## Atalhos e Dicas

### Navegação Rápida
- Use a barra inferior para alternar entre seções
- Toque no ícone da seção atual para voltar ao topo

### Busca (Planejado)
- Busca por nome de pet
- Busca por nome de cliente
- Filtros por espécie, raça, etc.

### Relatórios (Planejado)
- Exportar histórico de consultas
- Gerar carteira de vacinação em PDF
- Relatórios financeiros

## Solução de Problemas

### Não consigo cadastrar pet
- Verifique se há clientes cadastrados
- Um pet precisa estar vinculado a um cliente

### Consulta não aparece no calendário
- Verifique se a data está correta
- Navegue até o mês correto no calendário

### Dados não aparecem
- Feche e abra o app novamente
- Verifique se o cadastro foi concluído

### Erro ao excluir
- Verifique se há dados relacionados
- Exclusão de cliente remove todos os pets

## Próximos Passos

Após dominar o básico:
1. Explore todas as funcionalidades
2. Personalize o uso para sua clínica
3. Aguarde novas funcionalidades
4. Contribua com sugestões

## Suporte

Para dúvidas ou problemas:
- Consulte a [documentação completa](README.md)
- Abra uma [issue no GitHub](https://github.com/seu-usuario/veterinario/issues)
- Entre em contato com o suporte
