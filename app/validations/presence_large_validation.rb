class LargePriceNumValidation


  def validate(poster)
    if poster.large.eql? "1"
      if poster.is_number?(poster.price_large)
        ""
      else
        "Prices large must be a numberino"
      end
    else
      ""
    end
  end
end
