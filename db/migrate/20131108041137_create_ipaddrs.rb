class CreateIpaddrs < ActiveRecord::Migration
  def change
    create_table :ipaddrs do |t|
      t.string :ipaddress
      t.string :manageno
      t.string :macaddress
      t.string :use
      t.string :remarks

      t.timestamps
    end
  end
end
