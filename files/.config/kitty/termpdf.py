from kittens.tui.handler import result_handler
from kittens.tui.loop import debug
import os

def main(args):
  pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
  cmd = "termpdf.py " + os.path.expanduser(args[1])
  window_title = "termpdf"

  # Try to find an existing pdf window
  for window in boss.match_windows("title:" + window_title):
    # Here we want to make sure we eitehr reload the file, or open the new path
    # If we have found one then check if there is a pdf already open
    if " ".join(window.child.foreground_cmdline).endswith(cmd):
      # If there is one open then quit it, using the same quit
      boss.child_monitor.needs_write(window.id, "q")
      # I wish refresh would work
      # boss.child_monitor.needs_write(window.id, "\x12")
    else:
      # If there wasn't one open then make sure we send sigterm to clear input
      boss.child_monitor.needs_write(window.id, "\x03")

    # Open the pdf
    boss.child_monitor.needs_write(window.id, cmd + "\x0d")
    return

  # If there isn't a window open, check that there is an active tab
  tab = boss.active_tab
  if tab is not None:
    # Switch the layout to splits, because we want to open the pdf to the right
    tab.goto_layout("tall")
    # Store the currently active window
    active_window = tab.active_window
    # Create the new window
    window = tab.new_window(override_title=window_title, location="vsplit")
    # Write the termpdf.py command
    boss.child_monitor.needs_write(window.id, cmd + "\x0d")
    # Switch the active window back to what it was
    boss.set_active_window(active_window)
