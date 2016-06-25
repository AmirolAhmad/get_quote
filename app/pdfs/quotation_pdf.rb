class QuotationPdf < Prawn::Document
  require 'prawn/table'

  def initialize(quotation, view)
    super()
    @quotation = quotation
    @view = view
    logo
    my_company
    customer_details
    item_details
    quotation_details
    notes
    message
  end

  def logo
    text "QUOTATION", :align => :right, size: 30, :color => "585858", :style => :bold

    data = [
      [nil,nil,nil,"Quote Date", "#{@quotation.created_at.strftime("%d/%m/%Y")}"],
      [nil,nil,nil,"Quote ID", "#{@quotation.quoteId}"],
      [nil,nil,nil,"Client ID", "#{@quotation.client.clientId}"],
      [nil,nil,nil,"Valid Until", "#{@quotation.validUntil.strftime("%d/%m/%Y")}"],
      [nil,nil,nil,"Quote Status", "#{@quotation.status.upcase}"]
    ]

    table(data, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 5
      cells.border_width = 0.5
      row(0..4).columns(0..2).borders = [:left]
      columns(0..2).borders = []
      row(0..4).columns(3).font_style = :bold
      columns(3..4).width = 85
    end
  end

  def my_company
    move_up 130
    text "#{@quotation.user.profile.firstName} #{@quotation.user.profile.lastName}", :size => 10, :style => :bold
    move_down 2
    text "#{@quotation.user.profile.businessName} (#{@quotation.user.profile.businessRegNumber})", :size => 9, :style => :bold
    move_down 2
    text "#{@quotation.user.profile.businessAddress}", :size => 8, :color => "585858"
    text "Phone Number: #{@quotation.user.profile.csPhoneNumber}", :size => 8, :color => "585858"
    move_down 2
    text "Email: #{@quotation.user.email}", :size => 8, :color => "585858"
    move_down 2
    text "Tax Registration Number: #{@quotation.user.profile.businessTaxRegNumber}", :size => 8, :color => "585858"
    move_down 20
  end

  def customer_details
    text "CUSTOMER", :size => 10, :style => :bold, :color => "c0392b"
    move_down 3
    text "#{@quotation.client.contactPerson}", :size => 10, :style => :bold
    move_down 2
    text "#{@quotation.client.companyName}", :size => 9, :style => :bold
    move_down 2
    text "#{@quotation.client.companyAddress}", :size => 8, :color => "585858"
    move_down 2
    text "Email: #{@quotation.client.email}", :size => 8, :color => "585858"
    move_down 2
    text "Phone: #{@quotation.client.phone}", :size => 8, :color => "585858"
  end

  def item_details
    move_down 20
    text "ITEM DETAILS", :size => 12, :color => "585858", :style => :bold
    move_down 2
    data = [
      ["Item No", "Description", "Quantity", "Unit Price", "Price"]
    ]
    @quotation.items.each_with_index do |f, index|
      data += [
        ["#{index + 1}", "#{f.description}", "#{f.quantity}", "#{ActionController::Base.helpers.number_to_currency(f.unitPrice)}", "#{ActionController::Base.helpers.number_to_currency(f.totalPrice)}"]
      ]
    end

    table(data, :header => true, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 8
      cells.border_width = 0.5
      row(0).font_style = :bold
      row(1..100).columns(0..4).borders = [:bottom, :left, :right]
      columns(0).width = 45
      columns(3..4).width = 75
      columns(2).width = 55
    end
  end

  def quotation_details
    data = [
      [nil,nil,nil,"Sub Total", "#{ActionController::Base.helpers.number_to_currency(@quotation.subTotal)}"],
      [nil,nil,nil,"Tax", "#{ActionController::Base.helpers.number_to_currency(@quotation.tax)}"],
      [nil,nil,nil,"Tax Rate", "#{@quotation.taxRate}%"],
      [nil,nil,nil,"Total Price", "#{ActionController::Base.helpers.number_to_currency(@quotation.total)}"]
    ]

    table(data, :cell_style => {:size => 8, :text_color => "585858"}, :width => 540) do
      cells.padding = 8
      cells.border_width = 0.5
      row(0..3).columns(0..2).borders = [:left]
      columns(0..2).borders = []
      row(0..4).columns(3).font_style = :bold
      row(0).columns(3..4).borders = [:left, :right, :bottom]
      columns(3..4).width = 75
    end
  end

  def notes
    move_down 20
    text "NOTES", :size => 12, :color => "585858", :style => :bold
    move_down 2
    text "#{@quotation.note}", :size => 9, :color => "585858"
    text "We will be happy to supply any further information you may need and trust that you call on us to fill your order, which will receive our prompt and careful intention.", :size => 9, :color => "585858"
  end

  def message
    move_down 220
    text '"THIS IS A COMPUTER-GENERATED DOCUMENT AND IT DOES NOT REQUIRE A SIGNATURE. THIS DOCUMENT SHALL NOT BE INVALIDATED SOLELY ON THE GROUND THAT IT IS NOT SIGNED. "', :color => "585858", :size => 7, :align => :center, :style => :bold
  end
end
