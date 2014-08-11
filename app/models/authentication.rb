class Authentication < ActiveRecord::Base
	belongs_to :gamer
	validates_presence_of :gamer_id, :uid, :provider
    validates_uniqueness_of :uid, :scope => :provider


end
