# frozen_string_literal: true

require "active_support/current_attributes"

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
