class SmallPriceNumValidation

  def validate (poster)
    if poster.small.eql? "1"
      if poster.is_number?(poster.price_small)
         ""
      else
         "Price small must be a numberino"
      end
    else
      ""
    end

  end
end
