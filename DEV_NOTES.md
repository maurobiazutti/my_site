# Notas de Desenvolvimento — Meu Site Pessoal

Documento de continuidade para retomar o trabalho no projeto. **Leia apenas este arquivo para entender o estado completo.**

---

## Contexto do Projeto

Site pessoal do **Mauro Biazutti** (desenvolvedor Full Stack Ruby on Rails). Objetivo: página "Sobre Mim" que serve como currículo online. Atualmente também recebe mensagens de contato (com área administrativa protegida por login). Futuro: área de "Articles" (artigos de tecnologia com comentários).

- **Stack**: Rails 8.1.3, PostgreSQL, Tailwind CSS, Hotwire (Turbo + Stimulus), Importmap, bcrypt
- **Rotas** (`config/routes.rb`):
  - `resource :session` — sign in/out
  - `resources :passwords, param: :token` — reset de senha
  - `root "about#index"` — página pública
  - `resources :contacts, only: [ :index, :show, :new, :create ]`
  - `resources :categories` — CRUD completo
  - `resources :articles` — CRUD completo
- **Layout**: navbar com logo à esquerda, links centrados ("Sobre Mim", "Blog", "Contato") e, à direita, botão de login + ícone de mensagens com badge.

---

## Estado Atual — O que já foi feito

### Página "Sobre Mim" (`app/views/about/index.html.erb`)

1. **`<details open>`**: itens de Experiência e Educação abrem com conteúdo visível por padrão.
2. **Tags de tecnologia**: dados em `@technologies` no `about_controller.rb`.
3. **Ações rápidas**: "Baixar CV" (ícone download), "WhatsApp" (`wa.me/5532988272267`), "Ver Projetos" (GitHub).
4. **"Sobre Mim" reescrito** com tom indireto sobre engenharia, citando entregas concretas.
5. **Refatoração "mais Ruby"**: partial `_timeline_item.html.erb` reutilizado; botões em `link_to ... do ... end`.

### Mensagens de contato (área nova)

- **Model `Contact`**: `scope :recent`, métodos `display_name`/`initials`; validações `presence` de `name` e `email`.
- **`ContactsController`**: `allow_unauthenticated_access except: [ :index, :show ]` — formulário público; index/show exigem login. `before_action :build_contact` para `new`/`create`.
- **Formulário em modal** (`contacts/new` + `_form` + turbo_frame "modal").
- **Index** (`/contacts`): listagem com avatar (inicial), nome, data, preview da mensagem, e-mail/telefone e link "Ver detalhes".
- **Show** (`/contacts/:id`): mensagem completa e contatos clicáveis (`mailto:`/`tel:`).

### Autenticação (padrão Rails 8)

- `User` (`has_secure_password`), `Session` (cookie assinado), `Current` (CurrentAttributes).
- `Authentication` concern: `before_action :resume_session` roda em **toda** request (para o menu saber se há usuário logado) e `require_authentication` redireciona quando a ação exige login.
- **Sign out redireciona para a root** (`sessions_controller.rb`).
- Recuperação de senha via `PasswordsMailer`.

### Navbar (`app/views/layouts/application.html.erb`)

- Links de navegação centralizados via helper `nav_link_to` (`application_helper.rb`).
- Direita: "Sign in" (estilo do botão WhatsApp, sem ícone) ou "Sign out", e ícone de mensagens → link para `/contacts` com badge de contagem (`Contact.count`, só aparece se > 0).
- Público vs. autenticado: root e `contacts/new` públicos; `contacts/index` e `show` exigem login.

### Área "Articles" (implementada — CRUD completo)

- **Model `Article`**: `belongs_to :category`, `has_many :comments`, `has_one_attached :cover`, `has_rich_text :content` (Action Text). Scopes: `published`, `recent`, `popular`. Métodos: `author_name`, `reading_time`.
- **Model `Category`**: `has_many :articles`, validação `name` unique.
- **Model `Comment`**: `belongs_to :article` (campos: name, email, content, status).
- **`ArticlesController`**: CRUD completo + `allow_unauthenticated_access` (público). `index` com hero article + paginação (pagy) + sidebar (mais vistos, recomendados, categorias). `show` incrementa `views_count`.
- **Views**:
  - `index.html.erb`: Hero + grid 2 colunas + sidebar + paginação.
  - `show.html.erb`: Header com cover blur, metadata, corpo (prose/Trix), footer com views.
  - `_form.html.erb`: Trix editor, Active Storage cover, selects categoria/status, datetime published_at.
- **`CategoriesController`**: CRUD completo, `allow_unauthenticated_access only: [:index, :show]`.

### Refatoração geral (sem mudar funcionalidade/estilo)

- **Partials compartilhados** (`app/views/shared/`): `_icon_mail`, `_icon_phone` (ícones duplicados), `_download_cv_button` (botão "Baixar CV" duplicado no about), `_pagination`.
- Comentários desnecessários removidos; `Contact.count` calculado uma única vez no layout.

---

## Onde Paramamos

Última mudança: validações de `name` e `email` no model `Contact` e atualização deste documento.

---

## Pendências / Próximos Passos (Ordenados por prioridade)

### 1. Sistema de Comentários — **MAIOR GAP FUNCIONAL**
- **Model/Migration**: ✅ Existe (`comments` table com article_id, name, email, content, status)
- **FALTANDO**:
  - `CommentsController` (create, destroy, moderação via `status`)
  - Partial `app/views/comments/_comment.html.erb`
  - Formulário de comentário em `articles/show.html.erb` (público, sem login)
  - Exibição de comentários aprovados no `articles/show`
  - Validações no model `Comment` (presence name, email, content; format email)
  - Scope `approved` / `pending` no model
  - Turbo Streams para inserção dinâmica após create

### 2. Botão "Baixar CV" — **Parcial**
- Atualmente é `<button>` sem link em `shared/_download_cv_button.html.erb`
- **Ação**: Criar `public/cv.pdf` e trocar por `<a href="/cv.pdf" download class="...">` OU implementar `send_data` em controller

### 3. Marcar mensagens como lidas
- Hoje badge conta `Contact.count` (todas)
- **Opções**: (a) adicionar coluna `read:boolean` default false + toggle no index/show; (b) manter simples (todas)
- **Decisão pendente**

### 4. Métricas reais no "Sobre Mim"
- Recomendado pelo recrutador
- **Aguardando usuário informar números** — NÃO inventar dados

### 5. E-mail de recuperação de senha
- `PasswordsMailer` usa assunto/texto em inglês
- Depende de configuração SMTP (Action Mailer)
- Verificar antes de publicar

### 6. Ícone de mensagens acessível sem login?
- Badge e link aparecem para todos; clicar leva ao login (protegido)
- **Confirmar se é comportamento desejado**

### 7. Seeds / Dados de exemplo
- `db/seeds.rb` vazio
- Popular categorias + artigos de exemplo para testar layout

---

## Observações Importantes

- **O usuário edita os arquivos por conta própria** (textos, estilos, dados). Antes de alterar, sempre reler o estado atual dos arquivos.
- Não usar "Formado em Engenharia Mecânica" de forma direta — tom indireto.
- Preferência: o usuário pede refatorações pontuais ("mais Ruby"); confirmar antes de grandes mudanças estruturais.
- Sempre validar as páginas após editar templates (renderização com STATUS 200). Comandos usados:
  - `bin/rails runner '...'` (render direto) ou curl no servidor em `http://localhost:3000`.
- Comunicação em português.

---

## Arquivos-chave para referência rápida

| Funcionalidade | Controller | Model | Views principais |
|---|---|---|---|
| Sobre Mim | `about_controller.rb` | — | `about/index.html.erb`, `about/_timeline_item.html.erb` |
| Contatos | `contacts_controller.rb` | `contact.rb` | `contacts/index`, `show`, `new`, `_form` |
| Auth | `sessions_controller.rb`, `passwords_controller.rb` | `user.rb`, `session.rb`, `current.rb` | `sessions/new`, `passwords/new`, `edit` |
| Articles | `articles_controller.rb` | `article.rb`, `category.rb`, `comment.rb` | `articles/index`, `show`, `_form`, `new`, `edit` |
| Categories | `categories_controller.rb` | `category.rb` | `categories/index`, `show`, `_form`, `new`, `edit` |
| Layout/Navbar | — | — | `layouts/application.html.erb`, `shared/_download_cv_button.html.erb` |
| Helpers | — | — | `application_helper.rb` (`nav_link_to`) |

---

## Comandos úteis

```bash
# Subir servidor
bin/dev

# Console
bin/rails c

# Testar renderização
bin/rails runner 'puts ApplicationController.render(assigns: { ... }, template: "about/index")'

# Migrations
bin/rails db:migrate
bin/rails db:seed

# Lint / Typecheck (se configurado)
bin/rubocop
bin/brakeman
```