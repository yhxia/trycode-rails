class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string :addr
      t.integer :speed

      t.timestamps
    end
  end
end
