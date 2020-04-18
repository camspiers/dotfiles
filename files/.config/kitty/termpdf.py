from kittens.tui.handler import result_handler
import os

def main(args):
  pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
  window_title = "termpdf"
  termpdf_cmd = "termpdf.py"
  cmd = termpdf_cmd + " " + os.path.expanduser(args[1])

  # Runs a command in the window
  def run_cmd(window):
    boss.child_monitor.needs_write(window.id, cmd + "\x0d")

  # Try to find an existing pdf window
  for window in boss.match_windows("title:" + window_title):
    # Here we want to make sure we either reload the file, or open the new path
    # If we have found one then check if there is a pdf already open
    fg_cmd = " ".join(window.child.foreground_cmdline)
    if cmd in fg_cmd:
      # Send refresh
      boss.child_monitor.needs_write(window.id, "\x12")
    elif termpdf_cmd in fg_cmd:
      # There is a termpdf.py running, but with a different doc
      # Send safe quit
      boss.child_monitor.needs_write(window.id, "q")
      # boss.child_monitor.needs_write(window.id, "\x03")
      # Open the pdf
      run_cmd(window)
    else:
      # If there wasn't one open then make sure we send sigterm to clear input
      # boss.child_monitor.needs_write(window.id, "\x03")
      # Open the pdf
      run_cmd(window)
    return

  # If there isn't a window open, check that there is an active tab
  tab = boss.active_tab
  if tab is None:
    return

  # Switch the layout to splits, because we want to open the pdf to the right
  tab.goto_layout("tall")
  # Store the currently active window
  active_window = tab.active_window
  # Create the new window
  window = tab.new_window(override_title=window_title, location="vsplit")
  # Write the termpdf.py command
  run_cmd(window)
  # Switch the active window back to what it was
  boss.set_active_window(active_window)
