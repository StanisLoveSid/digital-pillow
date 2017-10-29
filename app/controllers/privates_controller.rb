class PrivatesController < ApplicationController
  require 'cgi'
  require 'net/http'
  require 'net/https'

  def scanner
    @user = current_user
    @order = current_order
    @payment_info = params[:payment]
    @result = CGI::parse @payment_info
    @checking = [] << @user.orders.last.subtotal.to_s
    if @result["amt"] == @checking
      @order.order_items.each do |oi|
        oi.book.quantity -= oi.quantity
        oi.book.save!
      end
      OrderMailer.send_order(@order, current_user).deliver
      @order.payed_through_privat!
    else
      flash[:alert] = "Something's gone wrong"
    end
  end

  def send_request_to_privat
    url = URI.parse('https://api.privatbank.ua/p24api/ishop')
    req = Net::HTTP::Post.new(url.path)
    req.form_data = what_args_you_want_to_send
    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    con.start {|http| http.request(req)}
    respond_to do |format|
      format.html {redirect_to 'https://api.privatbank.ua/p24api/ishop' }
      format.json {render json: what_args_you_want_to_send}
    end
  end

  def what_args_you_want_to_send
    {
      "amt" => "<%= current_order.subtotal %>",
      "ccy" => "UAH",
      "merchant" => "130045",
      "order" => "<%= current_order.id %>",
      "details" => "Podushka ",
      "ext_details" => "Описание товара №...",
      "pay_way" => "privat24",
      "return_url" => "http://thawing-crag-87796.herokuapp.com/checkouts/confirm",
      "server_url" => "http://thawing-crag-87796.herokuapp.com/checkouts/payment"
    }
  end

end
