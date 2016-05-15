class GraphDateValidation

  def validate(graph)
    if graph.begin.eql? " 00:00:00" or graph.begin.eql? " 23:59:59"
      "Select a date"
    else
      ""
    end
  end

end
