module Avocado
  class SessionsController < BaseController
    def index
      @sessions = Current
        .user
        .sessions
        .newest_first
    end
  end
end
