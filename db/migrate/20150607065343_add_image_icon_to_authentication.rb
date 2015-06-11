class AddImageIconToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :icono, :string
  end
end
