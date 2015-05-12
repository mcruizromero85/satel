class CreateInscripciones < ActiveRecord::Migration
  def change
    create_table :inscripciones do |t|
      t.integer :torneo_id
      t.integer :gamer_id
      t.string :estado
      t.string :nick	
      t.timestamps
    end
  end
end
