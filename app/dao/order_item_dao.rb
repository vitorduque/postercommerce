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
      item.price_small = row ['price_small']
      item.price_medium = row ['price_medium']
      item.price_large = row ['price_large']
      items << item
    end

    db.close
    items
  end

  def retrieve_graph(date)
    db = @conn.open
    items = Array.new
    orders_id = Array.new

    result = db.query("select orders_has_posters.orders_id, orders_has_posters.posters_id, orders_has_posters.size, orders.date
                        from orders_has_posters
                        JOIN orders
                        ON orders_has_posters.orders_id = orders.id
                        where orders.date between '#{date.begin}' AND '#{date.end}'")
    result.each do |row|
      item = OrderItem.new
      item.orders_id = row['orders_id']
      item.orders_clients_id = row['orders_clients_id']
      item.posters_id = row['posters_id']
      item.size = row['size']
      items << item
    end

    result = db.query("select * from orders where orders.date between '#{date.begin}' AND '#{date.end}';")

    result.each do |row|
      id = row['id']
      orders_id << id
    end

    db.close
    return items, orders_id
  end


end
