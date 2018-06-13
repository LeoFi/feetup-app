class Export < ApplicationRecord
  belongs_to :shop

  def self.available_export(time = nil)
    time ||= Time.zone.now.strftime('%H:%M')
    where(time: time)
  end
end
