require 'rb-scpt'
@iterm = Appscript.app.by_name("iTerm")
@iterm.create_window_with_profile("Default")
@window = @iterm.current_window
@tab = @window.current_tab
ARGV.each do |hostname|
  @window.create_tab_with_default_profile
  session = @tab.sessions[0]
  session.write :text => "echo -ne \"\\033]0;\"#{hostname}\"\\007\""
  session.write :text => "ssh #{hostname}"
end
