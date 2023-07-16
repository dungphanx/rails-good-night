# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :sleep_records, :followers

  def sleep_records
    object.sleep_records.map do |record|
      {
        id: record.id,
        bed_time: record.bed_time,
        wake_up_time: record.wake_up_time
      }
    end
  end

  def followers
    object.followers.map do |record|
      {
        id: record.id,
        name: record.name
      }
    end
  end
end
