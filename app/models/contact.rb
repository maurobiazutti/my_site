class Contact < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  def display_name
    name.presence || "Anônimo"
  end

  def initials
    display_name.first.upcase
  end
end
