class CartItem
  include ActiveModel::Model

  attr_accessor :item_id, :category, :name, :unit_price, :amount, :size

  def is_number?(rola)
    true if Integer(rola) rescue false
  end


  def new_amount(cart, session_cart)
    amount = cart.amount.to_i
    amount_session_cart = session_cart["amount"].to_i
    amount_new = amount + amount_session_cart
    amount_new
  end

  def category_already_exists?(cart_item, cart)
    index = 0
    flg = false
    cart.each do |cart|
      if cart_item.item_id.eql? cart["item_id"]
        if cart_item.size.eql? cart["size"]
          flg = true
          break
        end
      end
      index = index +1
    end

    if flg == true
      index
    else
      false
    end
  end

  def cart_item_already_exists? (cart_item, cart)
    index = 0
    flg = false
    cart.each do |cart|
      if cart_item.item_id.eql? cart["item_id"]
        flg = true
        break
      end
      index = index +1
    end

    if flg == true
      index
    else
      false
    end
  end
end
