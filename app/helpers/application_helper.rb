module ApplicationHelper
  def find_film(id)
    MovieFacade.find_film(id)
  end 
end
