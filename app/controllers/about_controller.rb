class AboutController < ApplicationController
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