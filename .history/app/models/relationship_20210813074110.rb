class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :followers, class_name: "User"
end
