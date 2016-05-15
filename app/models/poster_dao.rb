class PosterDao
  #No .new da dessa classe será passado um objeto de conexão
  def initialize(conn)
    @connection = conn
  end

  def list
    db = @connection.open
    result_list = db.query('select * from posters', cast: false)
    posters = Array.new
    result_list.each do |row|
      poster = Poster.new()
      poster.id = row['id']
      poster.name = row['name']
      poster.small = row['small']
      poster.medium = row['medium']
      poster.large = row['large']
      poster.price_small = row['price_small']
      poster.price_medium = row['price_medium']
      poster.price_large =  row['price_large']
      poster.category = row['category']
      poster.created_at = row['reg_date']
      poster.active = row['active']
      poster.image = row['image']
      posters << poster
    end
    db.close
    return posters
  end

  def find(id)
    db = @connection.open
    unique_result = db.query("SELECT * FROM posters WHERE id = #{id}")
    poster = Poster.new()

    if unique_result.count == 0
      db.close
      return false
    end

    unique_result.each do |row|
      poster.id = row['id']
      poster.name = row['name']
      poster.small = row['small']
      poster.medium = row['medium']
      poster.large = row['large']
      poster.price_small = row['price_small']
      poster.price_medium = row['price_medium']
      poster.price_large =  row['price_large']
      poster.category = row['category']
      poster.created_at = row['created_at']
      poster.updated_at = row['updated_at']
      poster.active = row['active']
      poster.image = row['image']
    end
    db.close
    return poster
  end

  def delete(id)
    db = @connection.open
    db.query("update posters SET active = 0 where id = '#{id}'")
    db.close
  end

  def create(poster)
    poster.image = Base64.encode64(File.open(poster.image.path, 'r').read)

    poster.created_at = Time.now.to_s(:db)
    poster.updated_at = Time.now.to_s(:db)
    db = @connection.open
    db.query("insert into posters
    (name, small, medium, large, price_small, price_medium, price_large, category, active, created_at, updated_at, image)
          VALUES('#{poster.name}',
          '#{poster.small}',
          '#{poster.medium}',
          '#{poster.large}',
          '#{poster.price_small}',
          '#{poster.price_medium}',
          '#{poster.price_large}',
          '#{poster.category.category}',
          '#{poster.active}',
          '#{poster.created_at}',
          '#{poster.updated_at}',
          '#{poster.image}' )")
  end

  def edit(poster)
    updated_at = Time.now.to_s(:db)
    poster.image = Base64.encode64(File.open(poster.image.path, 'r').read)

    db = @connection.open
    db.query("update posters set name = '#{poster.name}', small = #{poster.small},
    medium = #{poster.medium},
    large = #{poster.large},
    price_small = '#{poster.price_small}',
    price_medium = ' #{poster.price_medium}',
    price_large = '#{poster.price_large}',
    category = '#{poster.category.category}',
    active = #{poster.active},
    updated_at = '#{updated_at}',
    image = '#{poster.image}' where id = #{poster.id} ")
    db.close
  end


end
