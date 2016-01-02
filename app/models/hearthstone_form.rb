class HearthstoneForm < ActiveRecord::Base
  belongs_to :inscripcion  
  validates :battletag, format: { with: /\A\D.{2,11}#\d{4}\Z/, message: ', El battle tag tiene formato nick#1234' }
end
