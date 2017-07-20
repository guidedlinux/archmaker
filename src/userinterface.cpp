/**
  ArchMaker
  userinterface.cpp
  Purpose: Creates the GUI for ArchMaker.

  @author Hannes Schulze
  @version 7/8/17
*/

#include "ArchMaker/userinterface.hpp"

ArchmakerGui::ArchmakerGui(Glib::RefPtr<Gtk::Application> app) : application(app) {
  try {
    refBuilder->add_from_file("/usr/share/archmaker/ui.glade");
  } catch (const Glib::FileError& ex) {
    std::cerr << "File Error: " << ex.what() << std::endl;
		return;
  } catch (const Glib::MarkupError& ex) {
    std::cerr << "Markup Error: " << ex.what() << std::endl;
    return;
  } catch (const Gtk::BuilderError& ex) {
    std::cerr << "Builder Error: " << ex.what() << std::endl;
    return;
  }
  
  refBuilder->get_widget("mainAssistant", mainAssistant);
	if (!mainAssistant) {
    std::cerr << "Error: Cannot get mainAssistant from builder!" << std::endl;
		return;
  } else {
		refBuilder->get_widget("packageseditor", packageseditor);
    refBuilder->get_widget("add_aur_dialog", add_aur_dialog);
    refBuilder->get_widget("btn_close_assistant", btn_close_assistant);
    refBuilder->get_widget("txt_packages", pkgstext);
    installedpackages = pkgstext->get_buffer()->get_text(true);
    refBuilder->get_widget("btn_edit_packages", btn_edit_packages);
    refBuilder->get_widget("btn_use_packages", btn_use_packages);
    refBuilder->get_widget("btn_packages_save", savebtn);
    refBuilder->get_widget("btn_add_aur_ok", saveaurbtn);
    refBuilder->get_widget("btn_add_list_aur", addaurbtn);
    refBuilder->get_widget("btn_remove_list_aur", remaurbtn);

    refBuilder->get_widget("radiobutton1", emptyradio);
    refBuilder->get_widget("radiobutton2", selectradio);
    refBuilder->get_widget("radio_use_own_home_folder", useconfigsradio);
    refBuilder->get_widget("btn_open_folder_dialog", folderdialogopen);

    refBuilder->get_widget("radiobutton3", sl_emptyradio);
    refBuilder->get_widget("radiobutton4", sl_selectradio);
    refBuilder->get_widget("btn_open_folder_dialog1", sl_folderdialogopen);

    refBuilder->get_widget("btn_save_script", btn_save_script);
    refBuilder->get_widget("btn_run_script", btn_launchscript);
    refBuilder->get_widget("btn_close_terminal", btn_close_terminal);

    refBuilder->get_widget("list_aur", aurlist);
	}
}
ArchmakerGui::~ArchmakerGui() {
}

// Returns the contents of a file as a string.
std::string ArchmakerGui::get_file_contents(std::string fileName) {
  std::FILE *fp = std::fopen(fileName.c_str(), "rb");
  if (fp)
  {
    std::string contents;
    std::fseek(fp, 0, SEEK_END);
    contents.resize(std::ftell(fp));
    std::rewind(fp);
    std::fread(&contents[0], 1, contents.size(), fp);
    std::fclose(fp);
    return(contents);
  }
  throw(errno);
}

/**
  Callback for ftw that either copies a file or creates a directory.

  @param src_path The path of the file/folder.
  @param sb Some properties of the files.
  @param typeflag Describes if the current object is a file or a folder.
*/
extern "C" int cpy_file(const char*, const struct stat, int);
std::string dest_dir = "";
std::string source_dir = "";

// Callback for ftw that either copies a file or creates a directory.
static int cpy_file(const char* src_path, const struct stat* sb, int typeflag) {
  std::string src_pth_string = src_path;
  std::string new_path = "";
  if (src_pth_string.length() > source_dir.length()) {
    new_path = dest_dir + src_pth_string.substr(source_dir.length() + 1);
  
    switch (typeflag) {
      case FTW_D:
        mkdir(new_path.c_str(), sb->st_mode);
        break;
      case FTW_F:
        std::ifstream source(src_path, std::ios::binary);
        std::ofstream dest(new_path, std::ios::binary);
        dest << source.rdbuf();
    }
  }

  return 0;
}

// Checks if a Radiobutton is checked or not.
bool ArchmakerGui::checkaurradiobtn(std::string widget) {
  Gtk::RadioButton *currentbtn = nullptr;
  refBuilder->get_widget(widget.c_str(), currentbtn);
  bool result = false;
  if (currentbtn->get_active()) {
    result = true;
  }
  return result;
}
// Runs the application.
void ArchmakerGui::ShowGui() {
  application->run(*mainAssistant);
}
// Connects the signals that need to be handled.
void ArchmakerGui::ConnectSignals() {
  mainAssistant->signal_cancel().connect( sigc::mem_fun(*this, &ArchmakerGui::on_exit_application) );
  mainAssistant->signal_prepare().connect( sigc::mem_fun(*this, &ArchmakerGui::on_next_pressed) );
  btn_close_assistant->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_exit_application) );
  btn_edit_packages->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_btn_edit_packages_click) );
  btn_use_packages->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_btn_use_packages_click) );
  savebtn->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_btn_save_packages_click) );
  addaurbtn->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_btn_add_list_aur_click) );
  saveaurbtn->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_save_aur_item_click) );
  remaurbtn->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_btn_remove_list_aur_click) );
  emptyradio->signal_toggled().connect( sigc::mem_fun(*this, &ArchmakerGui::on_rad_empty_toggle) );
  selectradio->signal_toggled().connect( sigc::mem_fun(*this, &ArchmakerGui::on_rad_select_toggle) );
  useconfigsradio->signal_toggled().connect( sigc::mem_fun(*this, &ArchmakerGui::on_rad_use_configs_toggle) );
  folderdialogopen->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::open_folder_dialog) );
  sl_emptyradio->signal_toggled().connect( sigc::mem_fun(*this, &ArchmakerGui::on_sl_rad_empty_toggle) );
  sl_selectradio->signal_toggled().connect( sigc::mem_fun(*this, &ArchmakerGui::on_sl_rad_select_toggle) );
  sl_folderdialogopen->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::open_sl_folder_dialog) );
  btn_save_script->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_save_script_click) );
  btn_launchscript->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::on_launch_script_click) );
  btn_close_terminal->signal_clicked().connect( sigc::mem_fun(*this, &ArchmakerGui::close_terminal) );
}
// Adds a package to the list if the radiobutton is checked.
void ArchmakerGui::checkpkgradiobtn(std::string widget, std::string packagename) {
  Gtk::RadioButton *currentbtn = nullptr;
  refBuilder->get_widget(widget.c_str(), currentbtn);
  if (currentbtn->get_active()) {
    installedpackages = installedpackages + packagename;
  }
  delete currentbtn;
}
// Adds a package to the list and starts a service if the radiobutton is checked.
void ArchmakerGui::checkpkgradiobtn_dm(std::string widget, std::string packagename, std::string servicename) {
  Gtk::RadioButton *currentbtn = nullptr;
  refBuilder->get_widget(widget.c_str(), currentbtn);
  if (currentbtn->get_active()) {
    installedpackages = installedpackages + packagename;
    final_displaymanager = servicename;
  }
  delete currentbtn;
}
// Adds a package to the list if the checkbutton is checked.
void ArchmakerGui::checkpkgcheckbtn(std::string widget, std::string packagename) {
  Gtk::CheckButton *currentbtn = nullptr;
  refBuilder->get_widget(widget.c_str(), currentbtn);
  if (currentbtn->get_active()) {
    installedpackages = installedpackages + packagename;
  }
  delete currentbtn;
}
// Gets the package names and services out of the standard-package-selector.
void ArchmakerGui::pkgsfrombuttons() {
  checkpkgradiobtn_dm("btn_lxdm", "\nlxdm", "lxdm");
  checkpkgradiobtn_dm("btn_lightdm", "\nlightdm\nlightdm-gtk-greeter", "lightdm");
  checkpkgradiobtn_dm("btn_sddm", "\nsddm", "sddm");
  checkpkgradiobtn_dm("btn_gdm", "\ngdm", "gdm");

  checkpkgradiobtn("btn_xfce", "\nxfce4\nxfce4-goodies");
  checkpkgradiobtn("btn_gnome", "\ngnome\ngnome-extra");
  checkpkgradiobtn("btn_kde", "\nplasma-meta");
  checkpkgradiobtn("btn_mate", "\nmate\nmate-extra");
  checkpkgradiobtn("btn_lxde", "\nlxde");
  checkpkgradiobtn("btn_openbox", "\nopenbox");
  checkpkgradiobtn("btn_budgie", "\nbudgie-desktop");
  checkpkgradiobtn("btn_cinnamon", "\ncinnamon");

  checkpkgcheckbtn("btn_firefox", "\nfirefox");
  checkpkgcheckbtn("btn_chromium", "\nchromium");
  checkpkgcheckbtn("btn_opera", "\nopera");
  checkpkgcheckbtn("btn_thunderbird", "\nthunderbird");
  checkpkgcheckbtn("btn_midori", "\nmidori");
  checkpkgcheckbtn("btn_gnome_web", "\nepiphany");
  checkpkgcheckbtn("btn_filezilla", "\nfilezilla");
  checkpkgcheckbtn("btn_transmission", "\ntransmission-gtk");

  checkpkgcheckbtn("btn_vlc", "\nvlc");
  checkpkgcheckbtn("btn_rhythmbox", "\nrhythmbox");
  checkpkgcheckbtn("btn_totem", "\ntotem");
  checkpkgcheckbtn("btn_brasero", "\nbrasero");
  checkpkgcheckbtn("btn_clementine", "\nclementine");
  checkpkgcheckbtn("btn_amarok", "\namarok");
  checkpkgcheckbtn("btn_audacious", "\naudacious");
  checkpkgcheckbtn("btn_audacity", "\naudacity");

  checkpkgcheckbtn("btn_gimp", "\ngimp");
  checkpkgcheckbtn("btn_inkscape", "\ninkscape");
  checkpkgcheckbtn("btn_eog", "\neog");
  checkpkgcheckbtn("btn_darktable", "\ndarktable");

  checkpkgcheckbtn("btn_leafpad", "\nleafpad");
  checkpkgcheckbtn("btn_thunar", "\nthunar");
  checkpkgcheckbtn("btn_pcmanfm", "\npcmanfm");
  checkpkgcheckbtn("btn_nautilus", "\nnautilus");
  checkpkgcheckbtn("btn_gedit", "\ngedit");
  checkpkgcheckbtn("btn_xfce_term", "\nxfce4-terminal");
  checkpkgcheckbtn("btn_dolphin", "\ndolphin");
  checkpkgcheckbtn("btn_kwrite", "\nkwrite");

  checkpkgcheckbtn("btn_libreoffice", "\nlibreoffice-fresh");
  checkpkgcheckbtn("btn_calligra", "\ncalligra");
  checkpkgcheckbtn("btn_okular", "\nokular");
  checkpkgcheckbtn("btn_abiword", "\nabiword");

  checkpkgcheckbtn("btn_pavu", "\npavucontrol");
  checkpkgcheckbtn("btn_cups", "\ncups");
  checkpkgcheckbtn("btn_virtualbox", "\nvirtualbox-host-modules-arch\nvirtualbox");
  checkpkgcheckbtn("btn_ark", "\nark");
  checkpkgcheckbtn("btn_galculator", "\ngalculator");
  checkpkgcheckbtn("btn_kdenlive", "\nkdenlive");
}

// Closes the assistant.
void ArchmakerGui::on_exit_application() {
  mainAssistant->hide();
}

// Shows a dialog to edit the packages manually.
void ArchmakerGui::on_btn_edit_packages_click() {
  Glib::RefPtr<Gtk::TextBuffer> pkgbuffer = Gtk::TextBuffer::create();
  pkgbuffer->set_text(installedpackages);
  Gtk::TextView *pkgstext = nullptr;
  refBuilder->get_widget("txt_packages", pkgstext);
  pkgstext->set_buffer(pkgbuffer);
  packageseditor->show_all();
}

// Gets the currently installed packages.
void ArchmakerGui::on_btn_use_packages_click() {
  // TODO: Use libalpm instead of a system()-call.
  system("pacman -Qq > /tmp/archmakerpkgs");
  installedpackages = get_file_contents("/tmp/archmakerpkgs");
}

// Saves the manually edited packages and closes the dialog.
void ArchmakerGui::on_btn_save_packages_click() {
  packageseditor->hide();
  Gtk::TextView *pkgstext = nullptr;
  refBuilder->get_widget("txt_packages", pkgstext);
  installedpackages = pkgstext->get_buffer()->get_text(true);
}

// Shows a dialog to enter the URL of an AUR-package.
void ArchmakerGui::on_btn_add_list_aur_click() {
  Gtk::Entry *aurpkgtext = nullptr;
  refBuilder->get_widget("txt_add_aur", aurpkgtext);
  aurpkgtext->set_text("");
  add_aur_dialog->show_all();
}

// Adds an AUR-package to the list and closes the dialog.
void ArchmakerGui::on_save_aur_item_click() {
  add_aur_dialog->hide();

  Gtk::CheckButton *newaurpkg = nullptr;
  refBuilder->get_widget("chkbox_common_pkgs", newaurpkg);
  if (newaurpkg->get_active()) {
    if (checkaurradiobtn("btn_yaourt")) {
      installedpackages = installedpackages + "\npackage-query\nyaourt";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz"));
      aurlist->append(*newlbl1);
      Gtk::Label *newlbl2 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz"));
      aurlist->append(*newlbl2);
    }
    if (checkaurradiobtn("btn_downgrade")) {
      installedpackages = installedpackages + "\ndowngrade";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/downgrade.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_upterm")) {
      installedpackages = installedpackages + "\nupterm";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/upterm.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_vivaldi")) {
      installedpackages = installedpackages + "\nvivaldi";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/vivaldi.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_onlyoffice")) {
      installedpackages = installedpackages + "\nonlyoffice-bin";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/onlyoffice-bin.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_skype")) {
      installedpackages = installedpackages + "\nskypeforlinux-bin";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/skypeforlinux-bin.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_code")) {
      installedpackages = installedpackages + "\nvisual-studio-code";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/visual-studio-code.tar.gz"));
      aurlist->append(*newlbl1);
    }
    if (checkaurradiobtn("btn_sublime")) {
      installedpackages = installedpackages + "\nsublime-text-dev";
      Gtk::Label *newlbl1 = Gtk::manage(new Gtk::Label("https://aur.archlinux.org/cgit/aur.git/snapshot/sublime-text-dev.tar.gz"));
      aurlist->append(*newlbl1);
    }
    aurlist->show_all();
  } else {
    Gtk::Entry *aurpkgtext = nullptr;
    refBuilder->get_widget("txt_add_aur", aurpkgtext);
    Gtk::Label *newlbl = Gtk::manage(new Gtk::Label(aurpkgtext->get_text()));
    aurlist->append(*newlbl);
    aurlist->show_all();
  }
}

// Removes an AUR-package from the list.
void ArchmakerGui::on_btn_remove_list_aur_click() {
  if (aurlist->get_selected_row()) {
    aurlist->remove(*aurlist->get_selected_row());
  }
}

// Allows the user to press Next when the option to not use a custom /etc/skel-folder is selected.
void ArchmakerGui::on_rad_empty_toggle() {
  if (emptyradio->get_active()) {
    mainAssistant->set_page_complete(*mainAssistant->get_nth_page(3), true);
    usefolder = false;
    usehomefolder = false;
  }
}

// Doesn't allow the user to press Next when the option to not use a custom /etc/skel-folder and no folder-path are selected.
void ArchmakerGui::on_rad_select_toggle() {
  if (selectradio->get_active()) {
    if (folderpath == "") {
      mainAssistant->set_page_complete(*mainAssistant->get_nth_page(3), false);
    } else {
      mainAssistant->set_page_complete(*mainAssistant->get_nth_page(3), true);
    }
    usefolder = true;
    usehomefolder = false;
  }
}

// Allows the user to press Next and sets usehomefolder to true.
void ArchmakerGui::on_rad_use_configs_toggle() {
  if (useconfigsradio->get_active()) {
    mainAssistant->set_page_complete(*mainAssistant->get_nth_page(3), true);
    usefolder = false;
    usehomefolder = true;
  }
}

// Opens a folder-dialog for selecting a /etc/skel-folder.
void ArchmakerGui::open_folder_dialog() {
  Gtk::FileChooserDialog dialog("Please pick a folder.", Gtk::FILE_CHOOSER_ACTION_SELECT_FOLDER);
  dialog.set_transient_for(*mainAssistant);
  dialog.add_button("_Cancel", Gtk::RESPONSE_CANCEL);
  dialog.add_button("Select", Gtk::RESPONSE_OK);

  int result = dialog.run();
  if (result == Gtk::RESPONSE_OK) {
    folderpath = dialog.get_filename();
    Gtk::Label *currentfolder = nullptr;
    refBuilder->get_widget("currentfolder", currentfolder);
    currentfolder->set_text(folderpath);
    mainAssistant->set_page_complete(*mainAssistant->get_nth_page(3), true);
  } else { }
}

// Allows the user to press Next when the option to not use a custom slideshow is selected.
void ArchmakerGui::on_sl_rad_empty_toggle() {
  if (sl_emptyradio->get_active()) {
    mainAssistant->set_page_complete(*mainAssistant->get_nth_page(5), true);
    sl_usefolder = false;
  }
}

// Doesn't allow the user to press Next when the option to not use a custom slideshow and no folder-path are selected.
void ArchmakerGui::on_sl_rad_select_toggle() {
  if (sl_selectradio->get_active()) {
    if (sl_folderpath == "") {
      mainAssistant->set_page_complete(*mainAssistant->get_nth_page(5), false);
    } else {
      mainAssistant->set_page_complete(*mainAssistant->get_nth_page(5), true);
    }
    sl_usefolder = true;
  }
}

// Opens a folder-dialog for selecting a slideshow-folder.
void ArchmakerGui::open_sl_folder_dialog() {
  Gtk::FileChooserDialog dialog("Please pick a folder.", Gtk::FILE_CHOOSER_ACTION_SELECT_FOLDER);
  dialog.set_transient_for(*mainAssistant);
  dialog.add_button("_Cancel", Gtk::RESPONSE_CANCEL);
  dialog.add_button("Select", Gtk::RESPONSE_OK);

  int result = dialog.run();
  if (result == Gtk::RESPONSE_OK) {
    sl_folderpath = dialog.get_filename();
    Gtk::Label *currentfolder = nullptr;
    refBuilder->get_widget("currentfolder1", currentfolder);
    currentfolder->set_text(sl_folderpath);
    mainAssistant->set_page_complete(*mainAssistant->get_nth_page(5), true);
  } else { }
}

// Function that is called when the child of the terminal exits.
void ArchmakerGui::on_child_exited(VteTerminal *vteterminal, gint status, gpointer user_data) {
  gtk_widget_set_sensitive(GTK_WIDGET(user_data), TRUE);
}

// Opens a terminal window and launches the script within the VteTerminal.
void ArchmakerGui::on_launch_script_click() {
  Gtk::Window *terminalwindow = nullptr;
  refBuilder->get_widget("terminalwindow", terminalwindow);
  terminalwindow->show_all();
  Gtk::Widget *term = nullptr;
  refBuilder->get_widget("scriptterminal", term);
  char *startterm[2] = {"/bin/sh", 0};
  GError *err = NULL;
  GPid child_pid;
  if (vte_terminal_spawn_sync(VTE_TERMINAL(term->gobj()), VTE_PTY_DEFAULT,
                                      scriptpath.c_str(),
                                      startterm,
                                      {},
                                      G_SPAWN_SEARCH_PATH,
                                      NULL,
                                      NULL,
                                      &child_pid,
                                      NULL,
                                      &err)) {
    vte_terminal_watch_child(VTE_TERMINAL(term->gobj()), child_pid);
    vte_terminal_feed_child(VTE_TERMINAL(term->gobj()), ("clear && ./generateiso.sh "+final_distversion+" "+final_distcodename+" && exit\n").c_str(), -1);
    g_signal_connect(term->gobj(), "child-exited", G_CALLBACK(ArchmakerGui::on_child_exited), btn_close_terminal->gobj());
  } else {
    std::cout << "Error while launching script in terminal: " << err->message << std::endl;
  }
}

// Closes the terminal window.
void ArchmakerGui::close_terminal() {
  Gtk::Window *terminalwindow = nullptr;
  refBuilder->get_widget("terminalwindow", terminalwindow);
  terminalwindow->hide();
}

// Function that is called before the next assistant-page is shown.
void ArchmakerGui::on_next_pressed(Gtk::Widget* page) {
  if (mainAssistant->get_current_page() == 6) {
    // Displays a summary in lbl_summary
    Gtk::Label *summarytext = nullptr;
    refBuilder->get_widget("lbl_summary", summarytext);
    std::string skelfolder = "none";
    use_skelfolder = false;
    if (usefolder) {
      use_skelfolder = true;
      skelfolder = folderpath;
    }
    use_custom_slideshow = false;
    std::string slidesfolder = "none";
    if (sl_usefolder) {
      use_custom_slideshow = true;
      slidesfolder = sl_folderpath;
    }
    Gtk::Entry *distname = nullptr;
    refBuilder->get_widget("entry_name", distname);
    Gtk::Entry *distdescr = nullptr;
    refBuilder->get_widget("entry_descr", distdescr);
    Gtk::Entry *distversion = nullptr;
    refBuilder->get_widget("entry_version", distversion);
    Gtk::Entry *distcodename = nullptr;
    refBuilder->get_widget("entry_codename", distcodename);

    std::string aurtext = "none\n";
    std::vector<Gtk::Widget*> listitems = aurlist->get_children();
    if (listitems.size() > 0) {
      aurtext = "";
      int i;
      for (i = 0; i < listitems.size(); i++) {
        Gtk::Label *currentlabel = static_cast<Gtk::Label*> (aurlist->get_row_at_index(i)->get_child());
        aurtext = aurtext + currentlabel->get_label() + "\n";
      }
    }

    final_guilogin = false;
    final_displaymanager = "";
    Gtk::CheckButton *guilogin = nullptr;
    refBuilder->get_widget("chkbox_graphical_login", guilogin);
    if (guilogin->get_active()) {
      final_guilogin = true;
    }

    std::string finalstring = "Packages that need to be installed: selected packages\n"
                                "Packages from the AUR: "+aurtext+""
                                "/etc/skel-folder: "+skelfolder+"\n"
                                "Name of the distribution: "+distname->get_text()+"\n"
                                "Description of the Distribution: "+distdescr->get_text()+"\n"
                                "First version of the Distribution: "+distversion->get_text()+"\n"
                                "First codename of the Distribution: "+distcodename->get_text()+"\n"
                                "Slideshow-folder: "+slidesfolder;
    summarytext->set_text(finalstring.c_str());

    // Sets the variables to the final values.
    final_skelfolder = skelfolder;
    final_distname = distname->get_text();
    final_distdescr = distdescr->get_text();
    final_distversion = distversion->get_text();
    final_distcodename = distcodename->get_text();
    final_slidesfolder = slidesfolder;
    final_aurpkgs = aurtext;
    pkgsfrombuttons();
  } else if (mainAssistant->get_current_page() == 7) {
    // Generates the final script
    ScriptGenerator scriptgenerator = ScriptGenerator(final_distname);
    scriptgenerator.set_distdescr(final_distdescr);
    scriptgenerator.set_guilogin(final_guilogin);
    scriptgenerator.set_displaymanager(final_displaymanager);
    final_script = scriptgenerator.GenerateScript();
  }
}

// Shows a file-dialog and saves the script, the selected packages, the /etc/skel-folder and the slideshow-folder to the selected path.
void ArchmakerGui::on_save_script_click() {
  Gtk::FileChooserDialog dialog("Please pick the script-folder.", Gtk::FILE_CHOOSER_ACTION_SELECT_FOLDER);
  dialog.set_transient_for(*mainAssistant);
  dialog.add_button("_Cancel", Gtk::RESPONSE_CANCEL);
  dialog.add_button("Select", Gtk::RESPONSE_OK);

  int result = dialog.run();
  if (result == Gtk::RESPONSE_OK) {
    scriptpath = dialog.get_filename();
    std::cout << dialog.get_filename() << std::endl;
    std::ofstream scriptfile;
    scriptfile.open((dialog.get_filename() + "/generateiso.sh"));
    scriptfile << final_script << "\n";
    scriptfile.close();
    std::ofstream pkgfile;
    pkgfile.open((dialog.get_filename() + "/packages"));
    pkgfile << installedpackages << "\n";
    pkgfile.close();
    std::ofstream aurfile;
    aurfile.open((dialog.get_filename() + "/aurpackages"));
    aurfile << final_aurpkgs;
    aurfile.close();
    dest_dir = dialog.get_filename() + "/skeldata/";
    mkdir(dest_dir.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
    if (use_skelfolder) {
      source_dir = final_skelfolder;
      ftw(final_skelfolder.c_str(), cpy_file, 20);
    }
    dest_dir = dialog.get_filename() + "/calamaresslides/";
    mkdir(dest_dir.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
    if (use_custom_slideshow) {
      source_dir = final_slidesfolder;
      ftw(final_slidesfolder.c_str(), cpy_file, 20);
    } else {
      source_dir = "/usr/share/archmaker/default-slideshow";
      ftw("/usr/share/archmaker/default-slideshow", cpy_file, 20);
    }
    chmod((dialog.get_filename() + "/generateiso.sh").c_str(), S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH);

    Gtk::Button *btn_launchscript = nullptr;
    refBuilder->get_widget("btn_run_script", btn_launchscript);
    btn_launchscript->set_sensitive(true);
  } else { }
}