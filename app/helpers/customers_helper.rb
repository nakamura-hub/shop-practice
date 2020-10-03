module CustomersHelper
  def gravatar_url(customer, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(customer.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end