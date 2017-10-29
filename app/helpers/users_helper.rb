module UsersHelper
  def error_exist?(errors, field)
    errors.has_key? field.to_s unless errors.nil?
  end

  def help_block(errors, field)
    (errors[field.to_s][0] unless errors[field.to_s].nil?) unless errors.nil? 
  end
end
