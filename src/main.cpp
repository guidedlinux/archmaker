#include "ArchMaker/userinterface.hpp"

// Launches the gui.
int main (int argc, char **argv) {
  auto app = Gtk::Application::create(argc, argv, "org.guidedlinux.archmaker");

  ArchmakerGui gui = ArchmakerGui(app);
  gui.ConnectSignals();
  gui.ShowGui();

  return 0;
}