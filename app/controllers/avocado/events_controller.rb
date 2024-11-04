module Avocado
  class EventsController < BaseController
    def index
      @events = Current
        .user
        .events
        .newest_first
    end
  end
end
