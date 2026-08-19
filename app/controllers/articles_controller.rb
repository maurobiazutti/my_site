class ArticlesController < ApplicationController
   allow_unauthenticated_access
  def index
    # Artigo Hero (o mais recente publicado)
    @featured_article = Article.published.recent.first

    # Lista dos mais recentes (excluindo o que já está no Hero para não repetir)
    @recent_articles = Article.published.recent
                              .where.not(id: @featured_article&.id)
                              .limit(6)

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
end
