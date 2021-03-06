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

  def retrieve_graph_two(graph)
    year = ""
    year << graph.begin[0]
    year << graph.begin[1]
    year << graph.begin[2]
    year << graph.begin[3]
    db = @conn.open
    male = Array.new
    female = Array.new

    #male buys
    result = db.query("select DATE_FORMAT(date, '%m') as order_date, count(*) as count
                        from orders
                        join clients on orders.clients_id = clients.id where clients.gender = 'Male' AND date like '#{year}%'
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
                        join clients on orders.clients_id = clients.id where clients.gender = 'Female' AND date like '#{year}%'
                        group by order_date")

    result.each do |row|
      graph = Graph.new
      graph.order_date = row['order_date']
      graph.count = row['count']
      female << graph
    end
    db.close
    return male, female

  end

  def retreve_graph_three
    db = @conn.open

    between_10_and_19 = Array.new
    between_20_and_29 = Array.new
    between_30_and_39 = Array.new
    between_40_and_49 = Array.new

    result = db.query("select posters.category, count(posters.category) as score from orders_has_posters
                        join posters on orders_has_posters.posters_id = posters.id
                        join clients on orders_has_posters.orders_clients_id = clients.id
                        where born_date between DATE_SUB(curdate(),INTERVAL 19 year) AND DATE_SUB(curdate(),INTERVAL 10 year)
                        group by category")

    result.each do |row|
      graph = Graph.new
      graph.category = row['category']
      graph.category_score = row['score']
      between_10_and_19 << graph
    end

    result = db.query("select posters.category, count(posters.category) as score from orders_has_posters
                        join posters on orders_has_posters.posters_id = posters.id
                        join clients on orders_has_posters.orders_clients_id = clients.id
                        where born_date between DATE_SUB(curdate(),INTERVAL 29 year) AND DATE_SUB(curdate(),INTERVAL 20 year)
                        group by category")

    result.each do |row|
      graph = Graph.new
      graph.category = row['category']
      graph.category_score = row['score']
      between_20_and_29 << graph
    end

    result = db.query("select posters.category, count(posters.category) as score from orders_has_posters
                        join posters on orders_has_posters.posters_id = posters.id
                        join clients on orders_has_posters.orders_clients_id = clients.id
                        where born_date between DATE_SUB(curdate(),INTERVAL 39 year) AND DATE_SUB(curdate(),INTERVAL 30 year)
                        group by category")

    result.each do |row|
      graph = Graph.new
      graph.category = row['category']
      graph.category_score = row['score']
      between_30_and_39 << graph
    end

    result = db.query("select posters.category, count(posters.category) as score from orders_has_posters
                        join posters on orders_has_posters.posters_id = posters.id
                        join clients on orders_has_posters.orders_clients_id = clients.id
                        where born_date between DATE_SUB(curdate(),INTERVAL 49 year) AND DATE_SUB(curdate(),INTERVAL 40 year)
                        group by category")

    result.each do |row|
      graph = Graph.new
      graph.category = row['category']
      graph.category_score = row['score']
      between_40_and_49 << graph
    end

    db.close
    return between_10_and_19, between_20_and_29, between_30_and_39, between_40_and_49
  end

  def retrieve_data(date, option)
    if option.eql? 1
      retrieve_graph_one(date)
    elsif option.eql? 2
      retrieve_graph_two(date)
    elsif option.eql? 3
      retreve_graph_three
    end
  end



end
