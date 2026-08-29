class Article < ApplicationRecord
  belongs_to :category

  # Active Storage (Capa do artigo)
  has_one_attached :cover

  # ESTA LINHA É OBRIGATÓRIA para o Action Text funcionar:
  has_rich_text :content

  # Escopos para alimentar o layout
  scope :published, -> { where(status: "published").where("published_at <= ?", Time.current) }
  scope :recent, -> { published.order(published_at: :desc) }
  scope :popular, -> { published.order(views_count: :desc) }

  # Nome fixo do autor único
  def author_name
    "Mauro Biazutti"
  end

  # Tempo estimado de leitura (baseado em 200 palavras/minuto)
  def reading_time
    words_per_minute = 200
    words = content.to_s.split.size
    time = (words / words_per_minute.to_f).ceil
    time.zero? ? 1 : time
  end
end
