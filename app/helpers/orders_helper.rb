module OrdersHelper
  def order_state(state)
	case state
	when :in_queue
	 "Замовлення у черзі"
	when :in_delivery
	 "У стані доставки"
	when :payed
	 "Буде оплачено готівкою"	
	when :delivered
	 "Доставлено"
	when :canceled
	 "Замовлення відхилено"
	when :filled, :in_progress
	 "Не заповнене до кінця"
	end
  end
end
