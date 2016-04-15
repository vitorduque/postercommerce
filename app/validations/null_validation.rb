class NullPosterName

  def validate(poster)
    if poster.name.length == 0
       "Poster must have a name"
    else
       ""
    end
  end
end
