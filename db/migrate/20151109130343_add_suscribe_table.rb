class AddSuscribeTable < ActiveRecord::Migration
  def change
  	create_table :suscriptions do |t|
      t.string :first_name
      t.string :email
      t.string :message
      t.timestamps
    end
  end
end
