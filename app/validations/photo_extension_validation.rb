class PhotoExtensionValidation

  def validate(poster)

    if poster.image.nil?
      ""
    else
      if poster.image.original_filename.include? "jpg"
        ""
      else
        "Select only images "
      end
    end

  end

end
