
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
      resp.write cart_path
    elsif req.path.match(/add/)
      item = req.params["item"]
      resp.write add_path(item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def cart_path
    if @@cart == []
      return "Your cart is empty"
    else 
      @@cart.each {|item| return "#{item}\nOranges"}
    end 
  end 

  def add_path(item)
    
    if @@items.include? (item)
      @@cart << "added #{item}"
      @@cart << item
    else 
      return "We don't have that item"
    end 
    @@cart
  end 





end
