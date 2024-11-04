class Session < ApplicationRecord
  include Avocado::Session

  belongs_to :user
end
