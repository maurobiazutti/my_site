class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy vote ]
   allow_unauthenticated_access
  def index
    # Artigo Hero (o mais recente publicado)
    @featured_article = Article.published.recent.first

  # Lista dos mais recentes (excluindo o que já está no Hero para não repetir)
  # @recent_articles = Article.published.recent
  #                           .where.not(id: @featured_article&.id)
  #                           .limit(6)

  # Pagina os artigos recentes (6 por página)
  @pagy, @recent_articles = pagy(
    Article.published.recent.where.not(id: @featured_article&.id)
  )

    # Sidebar: Mais vistos
    @popular_articles = Article.published.popular.limit(5)

    # Sidebar: Categorias com contagem de artigos
    @categories = Category.joins(:articles)
                          .where(articles: { status: "published" })
                          .group("categories.id")
                          .select("categories.*, COUNT(articles.id) AS articles_count")
  end

  def show
    @article = Article.published.find(params[:id])

    # Incrementa as visualizações para a sidebar de "Mais Vistos"
    @article.increment!(:views_count)

    # Registra o voto atual do visitante a partir da session para exibir na view
    @user_vote = session.dig(:votes, @article.id.to_s)
  end

 def vote
    kind = params[:kind] # "like" ou "dislike"
    article_id = @article.id.to_s

    # Inicializa o hash de votos na sessão se não existir
    session[:votes] ||= {}
    previous_vote = session[:votes][article_id]

    if previous_vote == kind
      # 1. Clique duplo na mesma opção -> Remove o voto (Toggle)
      decrement_vote(kind)
      session[:votes].delete(article_id)
    elsif previous_vote.present?
      # 2. Trocou de opinião (ex: de Like para Dislike) -> Remove o anterior e soma o novo
      decrement_vote(previous_vote)
      increment_vote(kind)
      session[:votes][article_id] = kind
    else
      # 3. Novo voto -> Soma o voto
      increment_vote(kind)
      session[:votes][article_id] = kind
    end

    @user_vote = session[:votes][article_id]

    respond_to do |format|
      format.html { redirect_to @article }
      format.turbo_stream
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Artigo criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Artigo atualizado com Sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: "Artigo excluído com sucesso."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  # Esse é o método que estava faltando:
  def article_params
    params.require(:article).permit(
      :title,
      :excerpt,
      :status,
      :published_at,
      :category_id,
      :cover,
      :content
    )
  end

  def increment_vote(kind)
    @article.increment!("#{kind}s_count")
  end

  def decrement_vote(kind)
    # decrement! não deixa o contador cair abaixo de 0 se o método for chamado corretamente
    @article.decrement!("#{kind}s_count") if @article.send("#{kind}s_count") > 0
  end
end
