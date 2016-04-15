class PhotoExtensionValidation

  def validate(poster)

    begin
      if poster.image.original_filename.include? "jpg" 
        ""
      else
        "Select only images "
      end
    rescue

    end

  end

end
