class CategoriesController < ApplicationController
  # Se você estiver usando o gerador de autenticação nativo do Rails 8:
  # Permite que qualquer pessoa veja index e show, mas exige login para o resto
  allow_unauthenticated_access only: %i[index show]

  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  def index
    @categories = Category.joins(:articles)
                          .where(articles: { status: "published" })
                          .group("categories.id")
                          .select("categories.*, COUNT(articles.id) AS articles_count")
  end

  # GET /categories/1 ou /categories/slug
  def show
    # Busca os artigos publicados pertencentes a esta categoria
    @articles = @category.articles.published.recent.page(params[:page])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Categoria '#{@category.name}' criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Categoria atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Categoria removida com sucesso.", status: :see_other
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
