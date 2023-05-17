class AddIndustryToCoins < ActiveRecord::Migration[7.0]
  def change
    add_column :coins, :industry, :string
  end
end
