# Notas de Desenvolvimento — Meu Site Pessoal

Documento de continuidade para retomar o trabalho no projeto.

## Contexto do Projeto

Site pessoal do **Mauro Biazutti** (desenvolvedor Full Stack Ruby on Rails). Objetivo: página "Sobre Mim" que serve como currículo online. Futuro: área de "Articles" (artigos de tecnologia com comentários) e área de "Contatos".

- **Stack**: Rails 8.1.3, Tailwind CSS, Hotwire (Turbo + Stimulus), Importmap
- **Rota única**: `root "about#index"` → `AboutController#index` → `app/views/about/index.html.erb`
- **Layout do projeto**: sidebar/menu para links (o usuário altera à mão)

## Estado Atual — O que já foi feito

### Página "Sobre Mim" (`app/views/about/index.html.erb`)

1. **Formatação/leitura**: reescrito com indentação consistente e blocos organizados.
2. **`<details open>`**: itens de Experiência e Educação abrem com conteúdo visível por padrão (usuário pode ocultar).
3. **Tags de tecnologia**: seção "Tecnologias & Ferramentas" com pills ruby — **dados movidos para o controller** (`@technologies` em `about_controller.rb`), renderizadas com `.each`.
4. **Seção "Educação"** criada no estilo timeline (mesmo visual da Experiência).
5. **Botões da section principal**:
   - "Seguir" → **"Baixar CV"** (com ícone de download)
   - "Compartilhar" → **"WhatsApp"** (link `https://wa.me/5532988272267`, ícone oficial verde)
6. **Botão "Ver Projetos"** (seção Contato) → link para o GitHub, ícone antes do texto.
7. **"Sobre Mim" reescrito** com base em feedback de recrutador:
   - Posicionamento: "Full Stack com ênfase em Backend"
   - Removidos buzzwords ("código limpo, testes...") e erro de português
   - Engenharia citada de forma indireta (opção 4 escolhida pelo usuário)
   - Cita entregas concretas (Shopify, rastreamento de pedidos, landing pages, e-mail marketing, integrações)
8. **Refatoração "mais Ruby"** (validada com STATUS 200):
   - `about_controller.rb`: define `@technologies`
   - Novo partial `app/views/about/_timeline_item.html.erb` reutilizado por Experiência e Educação (render com **bloco** `<%= render "about/timeline_item", title:, subtitle:, period:, last: do %>`)
   - Links agora usam `link_to ... do ... end`

### Outros

- **README.md** reescrito descrevendo o site, funcionalidades e roadmap.

## Onde Paramamos

Última mudança: aplicada a "opção 4" no parágrafo de "Sobre Mim" que fala da engenharia de forma indireta ("Antes do software, construí uma carreira na engenharia...").

Página validada renderizando (STATUS 200). Comando de validação:

```bash
bin/rails runner 'status, _h, b = AboutController.action(:index).call(Rack::MockRequest.env_for("/")); puts "STATUS #{status}"'
```

## Pendências / Próximos Passos

1. **Métricas reais no "Sobre Mim"** — recomendado pelo recrutador; **aguardando o usuário informar números** (ex.: redução de CAC, conversão, tempo de resposta). NÃO inventar dados.
2. **Botão "Baixar CV"** — é um `<button>` sem link. Falta criar/anexar o arquivo do currículo (ex.: `public/cv.pdf`) e transformar em `<a href>` ou usar `send_data`.
3. **E-mail placeholder** — `mailto:seuemail@exemplo.com` na seção Contato precisa do e-mail real.
4. **Área "Articles"** (planejada): CRUD de artigos de tecnologia + **sistema de comentários**.
5. **Área "Contatos"** (planejada): centralizar canais de contato (formulário etc.).
6. Verificar se o usuário quer navegação/menu entre as futuras páginas.

## Observações Importantes

- **O usuário edita o arquivo por conta própria** (troca imagem, dados, textos). Antes de alterar, sempre reler o estado atual do arquivo — ele já modificou conteúdo várias vezes fora da sessão.
- Não usar "Formado em Engenharia Mecânica" de forma direta — o usuário pediu tom indireto.
- Preferência: o usuário já rejeitou refatoração pesada uma vez (partials) e depois a aceitou quando pediu "mais Ruby". Confirmar antes de grandes mudanças estruturais.
- Sempre validar com o comando de render acima após editar o template.
- Comunicação em português.