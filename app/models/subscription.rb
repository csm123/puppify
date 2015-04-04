class Subscription < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
end