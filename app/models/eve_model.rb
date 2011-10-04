class EveModel < ActiveRecord::Base
  self.abstract_class = true  
  establish_connection :eve
end