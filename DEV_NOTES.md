# Notas de Desenvolvimento — Meu Site Pessoal

Documento de continuidade para retomar o trabalho no projeto.

## Contexto do Projeto

Site pessoal do **Mauro Biazutti** (desenvolvedor Full Stack Ruby on Rails). Objetivo: página "Sobre Mim" que serve como currículo online. Atualmente também recebe mensagens de contato (com área administrativa protegida por login). Futuro: área de "Articles" (artigos de tecnologia com comentários).

- **Stack**: Rails 8.1.3, PostgreSQL, Tailwind CSS, Hotwire (Turbo + Stimulus), Importmap, bcrypt
- **Rotas** (`config/routes.rb`):
  - `resource :session` — sign in/out
  - `resources :passwords, param: :token` — reset de senha
  - `root "about#index"` — página pública
  - `resources :contacts, only: [ :index, :show, :new, :create ]`
- **Layout**: navbar com logo à esquerda, links centrados ("Sobre Mim", "Artigos", "Contato") e, à direita, botão de login + ícone de mensagens com badge.

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

### Refatoração geral (sem mudar funcionalidade/estilo)

- **Partials compartilhados** (`app/views/shared/`): `_icon_mail`, `_icon_phone` (ícones duplicados), `_download_cv_button` (botão "Baixar CV" duplicado no about).
- Comentários desnecessários removidos; `Contact.count` calculado uma única vez no layout.

## Onde Paramamos

Última mudança: validações de `name` e `email` no model `Contact` e atualização deste documento.

## Pendências / Próximos Passos

1. **Métricas reais no "Sobre Mim"** — recomendado pelo recrutador; **aguardando o usuário informar números**. NÃO inventar dados.
2. **Botão "Baixar CV"** — ainda é `<button>` sem link. Falta criar/anexar o CV (ex.: `public/cv.pdf`) e transformar em `<a href>` ou usar `send_data`.
3. **E-mail de recuperação de senha** — o `PasswordsMailer` usa assunto/texto em inglês e depende de configuração de e-mail (SMTP). Verificar antes de publicar.
4. **Marcar mensagens como lidas** — decidir se o badge da navbar deve refletir só mensagens não lidas (hoje conta todas).
5. **Área "Articles"** (planejada): CRUD de artigos de tecnologia + **sistema de comentários**.
6. **Ícone de mensagens acessível sem login?** — o badge e o link aparecem para todos; clicar leva ao login (protegido). Confirmar se é o comportamento desejado.

## Observações Importantes

- **O usuário edita os arquivos por conta própria** (textos, estilos, dados). Antes de alterar, sempre reler o estado atual dos arquivos.
- Não usar "Formado em Engenharia Mecânica" de forma direta — tom indireto.
- Preferência: o usuário pede refatorações pontuais ("mais Ruby"); confirmar antes de grandes mudanças estruturais.
- Sempre validar as páginas após editar templates (renderização com STATUS 200). Comandos usados:
  - `bin/rails runner '...'` (render direto) ou curl no servidor em `http://localhost:3000`.
- Comunicação em português.