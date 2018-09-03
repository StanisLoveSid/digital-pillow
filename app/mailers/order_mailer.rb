class OrderMailer < ActionMailer::Base
	include Roadie::Rails::Automatic
	def send_order(order, user)
		@order = order
		@user = user
		@order_items = @order.order_items
		recipients = [@user.email, "kingoftextil@gmail.com"]
       	mail(to: recipients, 
       		from: 'no-reply@pdushka.dp.ua',
       		subject: "Замовлення #{@order.number} завершено")
	end
end
