class Player < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :skills
end
