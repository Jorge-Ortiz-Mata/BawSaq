class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :company_symbol
      t.string :company_name
      t.string :company_ceo
      t.decimal :company_value_usd
      t.decimal :company_latest_price
      t.decimal :company_percent
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
