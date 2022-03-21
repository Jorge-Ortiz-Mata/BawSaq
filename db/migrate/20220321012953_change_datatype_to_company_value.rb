class ChangeDatatypeToCompanyValue < ActiveRecord::Migration[7.0]
  def change
    change_column :stocks, :company_value_usd, :string
  end
end
