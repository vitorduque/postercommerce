class MediumPriceNumValidation

  def validate (poster)
    if poster.medium.eql? "1"
      if poster.is_number?(poster.price_medium)
         ""
      else
         "Prices medium must be a numberino"
      end
    else
      ""
    end


  end
end
