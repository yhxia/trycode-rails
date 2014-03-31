class AddUsingToProxies < ActiveRecord::Migration
  def change
    add_column :proxies, :using, :integer, :default => 0
  end
end
