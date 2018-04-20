class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :host, null: false
      t.integer :port, null: false
      t.string :username, null: false
      t.string :encrypted_auth_password, null: false
      t.string :encrypted_auth_password_iv, null: false
      t.string :encrypted_priv_password, null: false
      t.string :encrypted_priv_password_iv, null: false
      t.string :auth_protocol, null: false
      t.string :priv_protocol, null: false
    end
  end
end