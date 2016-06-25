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
    respond_to do |format|
      format.html
      format.pdf do
        pdf = QuotationPdf.new(@quotation, view_context)
        send_data pdf.render, filename:
        "#{@quotation.quoteId}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
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
      @quotation = @user.quotations.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to(quotations_url, :notice => 'Record not found')
    end
end
