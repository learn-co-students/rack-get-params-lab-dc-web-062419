require "pry"
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      @@items.each do |item|
        if @@cart == []
        resp.write "Your cart is empty"
    elsif req.path.match(/add/)
      @@items.each do |item|
      @@cart << item
        end
      end
    end
    @@cart.each do |cart_item|
      resp.write "#{cart_item}\n"
    end
  else req.path.match(/add/)
    search_term = req.params["item"]
    resp.write handle_search(search_term)
  end
  resp.finish
end

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end
end
