# CrappUI

CrappUI é uma biblioteca de interface de usuário moderna e componentizada desenvolvida em Haxe, projetada para criar interfaces web interativas com foco em performance e experiência de usuário.

## Sobre a Biblioteca

A CrappUI fornece um conjunto abrangente de componentes UI pré-construídos que seguem práticas modernas de design, permitindo a criação de interfaces ricas e responsivas com código mínimo. A biblioteca utiliza o framework Priori como base e expande suas funcionalidades com componentes e recursos adicionais.

### Principais Características

- **Componentização Avançada**: Sistema modular com composição de componentes
- **Temas Customizáveis**: Sistema de estilos e temas flexível
- **Roteamento Integrado**: Navegação entre cenas e componentes
- **Gerenciamento de Layout**: Sistema inteligente para posicionamento de elementos
- **Componentes Pré-construídos**: Botões, inputs, listas, modais e muito mais
- **Efeitos Visuais**: Transições suaves e feedback interativo

### Pontos Positivos

- ✅ API intuitiva e fácil de usar
- ✅ Alto grau de reusabilidade de componentes
- ✅ Sistema de temas consistente
- ✅ Suporte para layouts complexos
- ✅ Excelente desempenho mesmo com muitos elementos
- ✅ Gestão eficiente de estados e eventos
- ✅ Compilação para JavaScript otimizado

### Limitações

- ⚠️ Curva de aprendizado inicial para quem não conhece Haxe
- ⚠️ Documentação ainda em desenvolvimento
- ⚠️ Ecossistema menor comparado a frameworks mainstream como React ou Vue

## Começando com CrappUI

### Requisitos

- Haxe 4.x ou superior
- Node.js (para projetos web)
- Docker (opcional, para ambiente de desenvolvimento)

### Instalação

```bash
haxelib install crapp-ui
```

## Ambiente de Desenvolvimento

### Usando Dev Container (Recomendado)

O projeto suporta desenvolvimento via Dev Container usando Docker, facilitando o onboarding para experimentar a biblioteca sem se preocupar com configurações complexas de ambiente.

1. Certifique-se que o Docker e VS Code estão instalados no seu sistema
2. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/crapp-ui.git
   cd crapp-ui
   ```
3. Abra o projeto no VS Code e quando solicitado, selecione "Reabrir no Container"
4. O container já vem configurado com todas as dependências necessárias

### Executando o Projeto de Exemplo

Depois que os containers estiverem ativos, execute o script de teste:

```bash
./run.sh
```

Acesse o projeto de exemplo no navegador:
```
http://localhost:8283
```

Alternativamente, se você configurou o arquivo hosts, também pode acessar via:
```
http://priori.crapp_ui:8283
```

## Componentes Disponíveis

- `CrappUIButton`: Botões padrão com vários estados
- `CrappUIButtonIcon`: Botões com ícones
- `CrappUIButtonIconText`: Botões com ícones e textos
- `CrappUITextInput`: Campos de entrada de texto
- `CrappUISelectInput`: Campos de seleção dropdown
- `CrappUIList`: Listas dinâmicas
- `CrappUIStack`: Componente de pilha vertical
- `CrappUIModal`: Sistema de modais
- `CrappUIDialog`: Diálogos informativos e de confirmação
- `CrappUIImage`: Componente de imagem com vários modos
- `CrappUILine`: Linhas horizontais e verticais
- E muitos outros...

## Documentação

- **API Documentation**: [https://felipevex.github.io/](https://felipevex.github.io/)
- **Guia do Usuário**: [https://crapp-ui.gitbook.io/](https://crapp-ui.gitbook.io/)

A documentação do código é gerada usando Dox e inclui descrições detalhadas de todos os componentes, métodos e propriedades. O guia do usuário fornece tutoriais, exemplos e melhores práticas para criar aplicações com CrappUI.

## Estrutura do Projeto

```
crapp-ui/
├── src-lib/             # Código fonte da biblioteca
├── src-front/           # Componentes frontais
├── src-test/            # Testes unitários
├── example/             # Projeto de exemplo
├── build/               # Arquivos compilados
└── scripts/             # Scripts utilitários
```

## Contribuindo

Contribuições são bem-vindas!

### Desenvolvimento

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/amazing-feature`)
3. Comite suas mudanças (`git commit -m 'Add some amazing feature'`)
4. Push para a branch (`git push origin feature/amazing-feature`)
5. Abra um Pull Request

### Testes

```bash
haxe test-unit.hxml
neko ./build/test/unit/UnitTests.n
```

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.

## Contato

- Mantenedor do Projeto: [Felipe Peternella](https://github.com/felipevex)

---

Criado com ❤️ pela equipe CrappUI