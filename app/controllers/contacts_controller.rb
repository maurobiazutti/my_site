class ContactsController < ApplicationController
  def index
    @contacts = Contact.order(created_at: :desc)
  end

  def show
    @contacts = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_path, notice: "Mensagem enviada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :message)
  end
end
