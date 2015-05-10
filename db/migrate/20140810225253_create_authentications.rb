class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :gamer_id
      t.string :provider
      t.string :uid
      t.string :link_cuenta
      t.timestamps
    end
  end
end
