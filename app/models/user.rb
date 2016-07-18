class User < ApplicationRecord

  has_many :polls
  has_many :poll_responses

end
