module ApplicationHelper
  def conditionals(alert, notice, shipping, billing)
    true if alert.is_a?(Hash) || notice.is_a?(Hash) || shipping.is_a?(Hash) || billing.is_a?(Hash)
  end

  def address_label(field)
    if field == :first_name
      "Ім’я"
    elsif field == :last_name
      "Фамилія"
    elsif field == :addressing
      "Адреса"
    elsif field == :city
      "Місто"
    elsif field == :zipcode
      "Поштовий індекс"      
    end
  end

end
