class AddAditionalFieldsForTournament < ActiveRecord::Migration
  def change
  	add_column :torneos, :urllogo, :string
  	add_column :torneos, :urllogoSponsors, :string
    add_column :torneos, :monto_auspiciado, :decimal
  end
end
