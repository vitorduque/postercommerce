class ImagePresenceValidation

  def validate(poster)

    if poster.image.nil?
      "Must select an image"
    else
      ""
    end
  end
end
