class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user
  before_filter :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = @user.clients
  end

  def new
    @client ||= Client.new
  	render
  end

  def create
    @client = @user.clients.new(client_params)
    if @client.save
      redirect_to clients_path, notice: "Client successfully created!"
    else
      render 'new'
    end
  end

  def show
    if @client
      render
    else
      redirect_to clients_path, notice: "Oppss! Client not found!"
    end
  end

  def edit
    if @client
      render
    else
      redirect_to clients_path, notice: "Oppss! Client not found!"
    end
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: "Client successfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    if @client.destroy
      redirect_to clients_path, notice: 'Client successfully destroyed!'
    else
      render 'index'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def set_client
      @client = @user.clients.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to(clients_url, :notice => 'Record not found')
    end

end
