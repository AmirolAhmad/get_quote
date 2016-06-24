class QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user
  before_filter :set_quotation, only: [:show, :mark_closed]

  def index
    @quotations = @user.quotations
  end

  def new
    @quotation ||= Quotation.new
  	render
  end

  def create
    @quotation = @user.quotations.new(quotation_params)
    if @quotation.save
      redirect_to quotations_path, notice: "Quotation successfully created!"
    else
      render 'new'
    end
  end

  def show
    if @quotation
      render
    else
      redirect_to quotations_path, notice: "Oppss! Quotation not found!"
    end
  end

  def mark_closed
    @quotation.update_attributes(status: 2)
  end

  private

    def set_user
      @user = current_user
    end

    def set_quotation
      @quotation = @user.quotations.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to(quotations_url, :notice => 'Record not found')
    end
end
