class AddEmailPhoneNotesToGuest < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :email, :string
    add_column :guests, :phone, :string
    add_column :guests, :travel_notes, :text
    add_column :guests, :dietary_notes, :text
    add_column :guests, :general_notes, :text
    add_column :guests, :hotel_notes, :text
  end
end
