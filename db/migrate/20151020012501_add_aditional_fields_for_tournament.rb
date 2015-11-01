class AddAditionalFieldsForTournament < ActiveRecord::Migration
  def change
  	add_column :torneos, :urllogo, :string
  	add_column :torneos, :urllogoSponsors, :string
  end
end
