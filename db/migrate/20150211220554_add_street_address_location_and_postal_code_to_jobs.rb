class AddStreetAddressLocationAndPostalCodeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :street_address, :string
    add_column :jobs, :location, :string
    add_column :jobs, :postal_code, :string
  end
end
