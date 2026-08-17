# Meu Site Pessoal

Site pessoal do Mauro Biazutti — desenvolvedor Full Stack Ruby on Rails. Uma vitrine para apresentação profissional, onde visitantes conhecem meu perfil, veem meu currículo e podem entrar em contato.

## Sobre o Projeto

Este é um site pessoal construído com **Ruby on Rails**, pensado para:

- **Me apresentar**: perfil com foto, nome, cargo e resumo profissional.
- **Exibir meu currículo online**: seções de "Sobre Mim", "Experiência & Projetos", "Educação" e "Tecnologias & Ferramentas".
- **Facilitar contato**: botões diretos para baixar o currículo (CV), WhatsApp, e-mail e GitHub.

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

### Área de "Articles" (em desenvolvimento)

Futuro espaço para escrever artigos de tecnologia. A ideia é:

- Publicação de artigos técnicos (Ruby, Rails, boas práticas, etc.).
- **Área de comentários** liberada para os leitores interagirem com o conteúdo.

### Área de "Contatos" (em desenvolvimento)

Espaço dedicado para centralizar os canais de contato e facilitar a comunicação com visitantes e recrutadores.

## Stack

- **Ruby on Rails 8** — framework principal.
- **Tailwind CSS** — estilização (via `tailwindcss-rails`).
- **Hotwire (Turbo + Stimulus)** — interatividade sem complicação.
- **Importmap** — JavaScript sem build.

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
│   └── about_controller.rb   # Controlador da página inicial (Sobre Mim)
└── views/
    └── about/
        └── index.html.erb    # Template da página "Sobre Mim"
```

## Roadmap

- [x] Página "Sobre Mim" com perfil e currículo
- [ ] Área de "Articles" com publicação de artigos de tecnologia
- [ ] Sistema de comentários nos artigos
- [ ] Área de "Contatos" com formulário e canais de comunicação
- [ ] Download do currículo (CV) em PDF

## Licença

Este projeto é de uso pessoal. Entre em contato para mais informações.