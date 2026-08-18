class ContactsController < ApplicationController
  allow_unauthenticated_access except: [ :index, :show ]

  before_action :build_contact, only: %i[new create]

  def index
    @contacts = Contact.recent
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
  end

  def create
    if @contact.save
      redirect_to root_path, notice: "Mensagem enviada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def build_contact
    @contact = params[:contact] ? Contact.new(contact_params) : Contact.new
  end

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :message)
  end
end
