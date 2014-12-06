class Authentication < ActiveRecord::Base
  belongs_to :gamer
  validates :gamer_id, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }
end
