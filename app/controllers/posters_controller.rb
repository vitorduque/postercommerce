class PostersController < ApplicationController
  layout "application", :only => [:index, :show]
  def index
    if session[:admin_signed_in]
      @posters = @command['list'].execute(Poster.new)
      render :index
    else
      redirect_to controller: 'admin'
    end
  end

  def edit
    if !(@poster = @command['show'].execute(Poster.new(id: params[:id])))
      redirect_to controller: 'posters', action: 'index', notice: 'Error: No ID reached out'
    end
  end

  def destroy

    result = @command['delete'].execute(Poster.new(id: params[:id]))
    if result.nil?
      redirect_to controller: posters_path
    else
      @poster = Poster.new()
      @poster.errors.add("Erro: ", result)
      render 'index'
    end
  end

  def show
    @poster = @command['show'].execute(Poster.new(id: params[:id]))
    if @poster == false
      redirect_to controller: 'posters', action: 'index', notice: 'Error: No ID reached out'
    else
      render 'show'
    end

  end

  def update
    result = ""
    @poster = Poster.new(params.require(:poster).permit(:id, :name, :small, :medium, :large, :price_small, :price_medium, :price_large, :category, :active, :image))

    begin
      Base64.encode64(File.open(params[:poster][:image].path, 'r').read)
    rescue
      result = "Select an image"
      @poster.errors.add("Errors: ", result)
      return render 'edit'
    end

    result = @command['edit'].execute(@poster)
    if result.nil?
      redirect_to controller: 'posters', action: 'index'
    else
      @poster.errors.add("Errors: ", result)
      render 'edit'
    end

  end

  def new
    @poster = Poster.new()
  end

  def create
    result = ""
    @poster = Poster.new(params.require(:poster).permit(:id, :name, :small, :medium, :large, :price_small, :price_medium, :price_large, :category, :active, :image))

    begin
      Base64.encode64(File.open(params[:poster][:image].path, 'r').read)
    rescue
      result = "Select an image"
      @poster.errors.add("Errors: ", result)
      return render 'new'
    end

    result = @command['create'].execute(@poster)
    if result.nil?
      redirect_to controller: 'posters', action: 'index'
    else
      @poster.errors.add("Errors: ", result)
      render 'new'
    end
  end

end
