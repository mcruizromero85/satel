class Partida < ActiveRecord::Base
   belongs_to :encuentro 
   def existe_debate
   		flag_gano_gamerinscritoa && flag_gano_gamerinscritob
   end
end
