# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  role       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :integer
#
class Message < ApplicationRecord
end
