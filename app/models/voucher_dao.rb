class VoucherDao

  def initialize(conn)
    @conn = conn
  end


  def create(voucher, order)
    db = @conn.open
    db.query("insert into vouchers (voucher, price, active, clients_id)  values( '#{voucher}', '#{order.total_price}', #{1}, '#{order.client_id}' )")

    db.close
  end


  def show(voucher)

  end
end
