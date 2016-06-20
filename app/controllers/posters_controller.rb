class PostersController < ApplicationController
  layout "application", :only => [:index, :show]
  def index
    if session[:admin_signed_in]
      #@posters = @command['list'].execute(Poster.new)
      @posters = @command['list'].execute(PosterObject.new(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil))
      render :index
    else
      redirect_to controller: 'admin'
    end
  end

  def edit
    if !(@poster = @command['show'].execute(PosterObject.new(params[:id],nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)))
      redirect_to controller: 'posters', action: 'index', notice: 'Error: No ID reached out'
    end
  end

  def destroy
    result = @command['delete'].execute(PosterObject.new(params[:id],nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil))
    if result.nil?
      redirect_to controller: posters_path
    else
      @poster = Poster.new()
      @poster.errors.add("Erro: ", result)
      render 'index'
    end
  end

  def show
    @poster = @command['show'].execute(PosterObject.new(params[:id],nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil))
    if @poster == false
      redirect_to controller: 'posters', action: 'index', notice: 'Error: No ID reached out'
    else
      render 'show'
    end
  end

  def update
    result = ""
    @poster = Poster.new(params.require(:poster).permit(:id, :name, :small, :medium, :large, :price_small, :price_medium, :price_large, :category, :active, :image))

    category = Category.new(@poster.category)

    @poster_object = PosterObject.new(params[:id], @poster.name, @poster.small, @poster.medium, @poster.large, @poster.price_small, @poster.price_medium,
    @poster.price_large, category, @poster.active, @poster.image, nil)


    result = @command['edit'].execute(@poster_object)
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

    category = Category.new(@poster.category)

    @poster_object = PosterObject.new(nil, @poster.name, @poster.small, @poster.medium, @poster.large, @poster.price_small, @poster.price_medium,
    @poster.price_large, category, @poster.active, @poster.image, nil)

    result = @command['create'].execute(@poster_object)
    if result.nil?
      redirect_to controller: 'posters', action: 'index'
    else
      @poster.errors.add("Errors: ", result)
      render 'new'
    end
  end

end
