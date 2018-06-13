require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

module Clockwork
  every(1.hour, 'trigger exporter', tz: 'UTC', at: '**:00') do
    system('rails exporter:run')
  end
end
