class PriceMediumPoster

  def validate(poster)
    if poster.medium.eql? "1"
      if poster.price_medium.length == 0
         "Medium poster must have a price "
      else
         ""
      end
    else
       ""
    end
  end
end
