# frozen_string_literal: true

class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :bed_time
      t.datetime :wake_up_time

      t.timestamps
    end
  end
end
