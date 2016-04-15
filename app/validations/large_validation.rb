class PriceLargePoster

  def validate(poster)
    if poster.large.eql? "1"
      if poster.price_large.length == 0
         "Large poster must have a price "
      else
         ""
      end
    else
       ""
    end
  end
end
