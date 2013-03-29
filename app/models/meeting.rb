# == Schema Information
#
# Table name: meetings
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  is_locked     :boolean          default(FALSE)
#  session_ident :text
#  name          :string(255)
#  max_size      :integer
#  current_size  :integer
#  password      :string(255)
#

class Meeting < ActiveRecord::Base
  attr_accessible :session_ident, :name, :max_size, :current_size, :password, :is_locked, :password_confirmation

  has_one :presentation

  validates_numericality_of :max_size, less_than_or_equal_to: 2
  validates :name, length: { maximum: 255 }, presence: true
  validates :password, length: { maximum: 255 }
  validates_confirmation_of :password
  validates_presence_of :password, if: :is_locked

  def presentation_applet_html
    presentation.nil? ? nil : presentation.applet_html.html_safe
  end

  def presentation_viewer_url
    presentation.nil? ? nil : presentation.viewer_url + "&resize=fit"
  end

  def restart_presentation
    self.presentation = Screenleap.new.start_presenting
    self.save
  end
end