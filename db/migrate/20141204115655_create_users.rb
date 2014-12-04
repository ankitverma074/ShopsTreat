class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :enc_passwd
      t.string :f_name
      t.string :l_name
      t.string :vendor_flag

      t.timestamps
    end
  end
end
