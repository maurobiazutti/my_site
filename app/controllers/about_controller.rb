class AboutController < ApplicationController
  allow_unauthenticated_access

  def index
    @technologies = [
      "Ruby",
      "Ruby on Rails",
      "Linux",
      "PostgreSQL",
      "Docker",
      "Git",
      "JavaScript",
      "HTML",
      "CSS",
      "Tailwind CSS",
      "Bootstrap"
    ]
  end
end