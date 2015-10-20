class AddAditionalFieldsForTournament < ActiveRecord::Migration
  def change
  	add_column :torneos, :urllogo, :string
  end
end
