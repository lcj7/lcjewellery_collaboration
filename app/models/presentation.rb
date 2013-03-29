# == Schema Information
#
# Table name: presentations
#
#  id             :integer          not null, primary key
#  meeting_id     :integer
#  viewer_url     :string(255)
#  share_code     :string(255)
#  applet_html    :text
#  participant_id :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Presentation < ActiveRecord::Base
  attr_accessible :meeting_id, :viewer_url, :share_code, :applet_html, :participant_id

  belongs_to :meeting
end