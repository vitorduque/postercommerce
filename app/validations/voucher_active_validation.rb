class VoucherActive

  def validate(domain)
      dao = VoucherDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
      voucher = dao.find(domain.id_voucher)

      if domain.id_voucher.blank?
        ""
      elsif voucher.id_voucher.nil?
        "Voucher non-existed"
      elsif voucher.active.eql? 0
        "Voucher was used"
      elsif not domain.client_id.eql? voucher.clients_id
        "Voucher incorrect"
      else
        ""
      end
  end

end
