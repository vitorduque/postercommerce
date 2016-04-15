#require '/home/vitor/RailsProjects/LES/app/models/open_connection.rb'
#require '/home/vitor/RailsProjects/LES/app/models/poster_dao.rb'
#require 'mysql2'
require './open_connection'
require './poster_dao'
require 'mysql2'
require 'date'
require './poster'
require './domain'

=begin
=end

HOST = 'localhost'
PORT = '3306'
DATABASE_NAME = 'appmysql_development'
USER = 'root'
PASSWORD = 'root'

poster_dao = PosterDao.new(OpenConnection.new(HOST,USER,PASSWORD,PORT,DATABASE_NAME))

#poster_dao.list
poster_dao.find(1)
#poster_dao.delete(1)

#poster = Poster.new(id: 1, name: "Naruto", small: true, medium: true, large: false, price_small: "20,00", price_medium: "30,00", price_large: "40,00",
#                    category: "Ninja", active: true)
