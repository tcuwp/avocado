module Avocado
  class Current < ActiveSupport::CurrentAttributes
    attribute :session,
      :user,
      :user_agent,
      :ip_address

    def session=(session)
      super
      self.user = session.user
    end
  end
end
