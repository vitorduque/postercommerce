class VoucherDao

  def initialize(conn)
    @conn = conn
  end


  def create(voucher, order)
    db = @conn.open
    db.query("insert into vouchers (id, price, active, clients_id)  values( '#{voucher}', '#{order.total_price}', #{1}, '#{order.client_id}' )")

    db.close
  end


  def edit(voucher)
    db = @conn.open

    db.query("update vouchers set active = #{0} where id = '#{voucher.id_voucher}'")

    db.close
  end

  def find(id)
    db = @conn.open

    unique_result = db.query("select * from vouchers where id = '#{id}'")
    voucher = Voucher.new()
    unique_result.each do |row|
      voucher.id_voucher = row['id']
      voucher.price = row['price']
      voucher.active = row['active']
      voucher.clients_id=row['clients_id']
    end
    db.close
    voucher
  end

  def retrieve_clients_active_vouchers(domain)
    db = @conn.open
    list = Array.new
    unique_result = db.query("select * from vouchers where active = 1 and clients_id = '#{domain.clients_id}'")

    unique_result.each do |row|
      voucher = Voucher.new()
      voucher.id_voucher = row['id']
      voucher.price = row['price']
      voucher.active = row['active']
      voucher.clients_id=row['clients_id']
      list << voucher
    end
    db.close
    list
  end

end
