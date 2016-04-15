class ItemDao

  def initialize(conn)
    @conn = conn
  end


  def create(cart, client_id, order_id)
    db = @conn.open
    id = nil
    size = nil
    amount = nil

    cart.each do |item|
      id = item["item_id"]
      size = item["size"]
      amount = item["amount"]

      db.query("INSERT INTO orders_has_posters (orders_id, orders_clients_id, posters_id, size, amount) VALUES('#{order_id}', '#{client_id}', '#{id}', '#{size}', '#{amount}' )")
    end
    db.close
  end

  def find_items(client_id, order_id)
    db = @conn.open
    items = Array.new

    result = db.query("SELECT orders_has_posters.*, posters.name, posters.price_small, posters.price_medium, posters.price_large, posters.small, posters.medium, posters.large from orders_has_posters
                      JOIN posters
                      ON orders_has_posters.posters_id = posters.id
                      WHERE orders_clients_id = '#{client_id}' AND orders_id = #{order_id};")

    result.each do |row|
      item = OrderItem.new()
      item.orders_id = row['orders_id']
      item.orders_clients_id = row['orders_clients_id']
      item.posters_id = row['posters_id']
      item.size = row['size']
      item.amount = row['amount']
      item.name = row['name']
    
      items << item
    end

    db.close
    items
  end
end
