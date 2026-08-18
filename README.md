# Meu Site Pessoal

Site pessoal do Mauro Biazutti — desenvolvedor Full Stack Ruby on Rails. Uma vitrine para apresentação profissional, onde visitantes conhecem meu perfil, veem meu currículo e podem entrar em contato.

## Sobre o Projeto

Este é um site pessoal construído com **Ruby on Rails**, pensado para:

- **Me apresentar**: perfil com foto, nome, cargo e resumo profissional.
- **Exibir meu currículo online**: seções de "Sobre Mim", "Experiência & Projetos", "Educação" e "Tecnologias & Ferramentas".
- **Receber mensagens**: formulário de contato em modal que grava as mensagens no banco, com uma área administrativa (login) para listar e ler cada mensagem.

## Funcionalidades

### Página "Sobre Mim" (página inicial)

O coração do site. Nela o visitante encontra:

- **Perfil** — foto, nome e link para o GitHub.
- **Resumo profissional** — cargo atual e uma breve descrição do que faço.
- **Sobre Mim** — texto apresentando minha trajetória, foco no ecossistema Ruby e diferenciais.
- **Experiência & Projetos** — linha do tempo com cargos, empresas, períodos e descrição das atividades, em blocos expansíveis.
- **Educação** — formações acadêmicas e cursos, também em blocos expansíveis.
- **Tecnologias & Ferramentas** — tags com as tecnologias que utilizo no dia a dia.
- **Ações rápidas** — botões para baixar o CV, chamar no WhatsApp e abrir o GitHub.

### Mensagens de contato

- **Formulário público** — abrindo em modal ("Enviar Mensagem"), sem necessidade de login.
- **Caixa de entrada** — listagem de todas as mensagens recebidas (`/contacts`), com preview, dados do remetente e link para o detalhe.
- **Detalhe da mensagem** (`/contacts/:id`) — mensagem completa e dados de contato clicáveis (e-mail e telefone).
- **Proteção** — a listagem e o detalhe exigem login; validações garantem nome e e-mail preenchidos.

### Autenticação

- **Sign in / Sign out** — sessão por cookie, senha com `has_secure_password` (bcrypt).
- **Recuperação de senha** — e-mail de reset (rotas `/passwords`).
- **Navegação condicional** — o menu mostra "Sign in" ou "Sign out" conforme o estado da sessão, e o ícone de mensagens exibe um badge com a contagem de mensagens recebidas.

### Área de "Articles" (em desenvolvimento)

Futuro espaço para escrever artigos de tecnologia. A ideia é:

- Publicação de artigos técnicos (Ruby, Rails, boas práticas, etc.).
- **Área de comentários** liberada para os leitores interagirem com o conteúdo.

## Stack

- **Ruby on Rails 8** — framework principal.
- **PostgreSQL** — banco de dados.
- **Tailwind CSS** — estilização (via `tailwindcss-rails`).
- **Hotwire (Turbo + Stimulus)** — interatividade sem complicação.
- **Importmap** — JavaScript sem build.
- **bcrypt** — hashing de senhas para autenticação.

## Requisitos

- Ruby 3.x
- Rails 8.1.x
- Node.js (opcional, para o build do Tailwind)

## Configuração e Execução

```bash
# Instalar as dependências
bundle install

# Preparar o banco de dados
bin/rails db:prepare

# Iniciar o servidor de desenvolvimento
bin/dev
```

Acesse em `http://localhost:3000`.

## Estrutura Principal

```
app/
├── controllers/
│   ├── about_controller.rb        # Página inicial (Sobre Mim) — pública
│   ├── contacts_controller.rb     # Mensagens (new/create públicos; index/show com login)
│   ├── sessions_controller.rb     # Sign in / Sign out
│   ├── passwords_controller.rb    # Recuperação de senha
│   └── concerns/
│       └── authentication.rb      # Autenticação compartilhada
├── models/
│   ├── contact.rb                 # Mensagens de contato (scope :recent, validações)
│   ├── user.rb                    # Usuário admin (has_secure_password)
│   ├── session.rb                 # Sessões por cookie
│   └── current.rb                 # CurrentAttributes (usuário da sessão)
├── helpers/
│   └── application_helper.rb      # nav_link_to
└── views/
    ├── about/                     # Página "Sobre Mim" + timeline
    ├── contacts/                  # Formulário (modal), listagem e detalhe
    ├── sessions/                  # Sign in
    ├── passwords/                 # Reset de senha
    ├── shared/                    # Partials de ícones e botão CV
    └── layouts/
        └── application.html.erb   # Layout com navbar, login e badge de mensagens
```

## Roadmap

- [x] Página "Sobre Mim" com perfil e currículo
- [x] Formulário de contato com mensagens salvas no banco
- [x] Área de mensagens (listagem e detalhe) com login
- [x] Autenticação (sign in/out e recuperação de senha)
- [ ] Área de "Articles" com publicação de artigos de tecnologia
- [ ] Sistema de comentários nos artigos
- [ ] Download do currículo (CV) em PDF
- [ ] Marcar mensagens como lidas

## Licença

Este projeto é de uso pessoal. Entre em contato para mais informações.