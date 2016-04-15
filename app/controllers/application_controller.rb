class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    require '/home/vitor/RailsProjects/LES/app/commands/command_admin_set.rb'
  def initialize
    super
    @command = Hash.new
    @command['list'] = CommandList.new()
    @command['edit'] = CommandEdit.new()
    @command['delete'] = CommandDelete.new()
    @command['show'] = CommandShow.new()
    @command['create'] = CommandCreate.new()
    @command['find_by_email'] = CommandFindByEmail.new()
    @command['set'] = CommandSet.new()
  end

end
