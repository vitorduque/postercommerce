class GraphDao

  def initialize(conn)
    @conn = conn
  end

  def return_orders(graph)
    db = @conn.open
    orders = Array.new()

    result = db.query("select * from orders where date between '#{graph.begin}' and '#{graph.end}'")

    result.each do |row|
      order = Order.new()
      order.id = row['id']
      order.total_price = row['total_price']
      order.payment_status = row['payment_status']
      order.shipping_status = row['shipping_status']
      orders << order
    end
    db.close
    orders
  end

  def retrieve_graph_one(date)
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

  def retrieve_graph_two
    db = @conn.open
    male = Array.new
    female = Array.new

    #male buys
    result = db.query("select DATE_FORMAT(date, '%m') as order_date, count(*) as count
                        from orders
                        join clients on orders.clients_id = clients.id where clients.gender = 'Male'
                        group by order_date")

    result.each do |row|
      graph = Graph.new
      graph.order_date = row['order_date']
      graph.count = row['count']
      male << graph
    end

    #female buys
    result = db.query("select DATE_FORMAT(date, '%m') as order_date, count(*) as count
                        from orders
                        join clients on orders.clients_id = clients.id where clients.gender = 'Female'
                        group by order_date")

    result.each do |row|
      graph = Graph.new
      graph.order_date = row['order_date']
      graph.count = row['count']
      female << graph
    end
    return male, female

  end


  def retrieve_data(date, option)
    if option.eql? 1
      retrieve_graph_one(date)
    elsif option.eql? 2
      retrieve_graph_two
    end
  end



end
