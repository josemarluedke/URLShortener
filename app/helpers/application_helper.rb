module ApplicationHelper
  def full_url(token, http = false)
    "#{'http://' if http}jdl.cc/#{token}"
  end
end
