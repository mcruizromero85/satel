class AddImageIconToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :icono, :string
    add_column :detalle_pago_inscripciones, :monto_auspiciado, :decimal
  end
end
