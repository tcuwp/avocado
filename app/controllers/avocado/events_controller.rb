# frozen_string_literal: true

module Avocado
  class EventsController < BaseController
    def index
      @events = current_user.events.newest_first
    end
  end
end
