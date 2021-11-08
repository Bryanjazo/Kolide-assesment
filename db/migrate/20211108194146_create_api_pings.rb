class CreateApiPings < ActiveRecord::Migration[6.1]
  def change
    create_table :api_pings do |t|

      t.timestamps
    end
  end
end
