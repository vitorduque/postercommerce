class PriceSmallPoster

  def validate(poster)
    if poster.small.eql? "1"
      if poster.price_small.length == 0
         "Small poster must have a price "
      else
         ""
      end
    else
       ""
    end
  end




end
