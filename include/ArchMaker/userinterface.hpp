/**
  ArchMaker
  userinterface.hpp
  Purpose: Creates the GUI for ArchMaker.

  @author Hannes Schulze
  @version 7/8/17
*/

#ifndef _INCL_USERINTERFACE
#define _INCL_USERINTERFACE

#include <gtkmm.h>
#include <vte/vte.h>
#include <cstdio>
#include <cerrno>
#include <iostream>
#include <string>
#include <stdlib.h>
#include <fstream>
#include <ftw.h>
#include <sys/stat.h>
#include <vector>
#include "ArchMaker/scriptgenerator.hpp"

class ArchmakerGui {
  public:
    ArchmakerGui(Glib::RefPtr<Gtk::Application> app);
    ~ArchmakerGui();
    /**
      Runs the application.
    */
    void ShowGui();
    /**
      Connects the signals that need to be handled.
    */
    void ConnectSignals();
  protected:
    /**
      Closes the assistant.
    */
    void on_exit_application();
    /**
      Shows a dialog to edit the packages manually.
    */
    void on_btn_edit_packages_click();
    /**
      Gets the currently installed packages.
    */
    void on_btn_use_packages_click();
    /**
      Saves the manually edited packages and closes the dialog.
    */
    void on_btn_save_packages_click();
    /**
      Shows a dialog to enter the URL of an AUR-package.
    */
    void on_btn_add_list_aur_click();
    /**
      Adds an AUR-package to the list and closes the dialog.
    */
    void on_save_aur_item_click();
    /**
      Removes an AUR-package from the list.
    */
    void on_btn_remove_list_aur_click();
    /**
      Allows the user to press Next when the option to not use a custom /etc/skel-folder is selected.
    */
    void on_rad_empty_toggle();
    /**
      Doesn't allow the user to press Next when the option to not use a custom /etc/skel-folder and no folder-path are selected.
    */
    void on_rad_select_toggle();
    /**
      Opens a folder-dialog for selecting a /etc/skel-folder.
    */
    void open_folder_dialog();
    /**
      Allows the user to press Next when the option to not use a custom slideshow is selected.
    */
    void on_sl_rad_empty_toggle();
    /**
      Doesn't allow the user to press Next when the option to not use a custom slideshow and no folder-path are selected.
    */
    void on_sl_rad_select_toggle();
    /**
      Opens a folder-dialog for selecting a slideshow-folder.
    */
    void open_sl_folder_dialog();
    /** 
      Function that is called when the child of the terminal exits.

      @param vteterminal the object which received the signal
      @param status the child's exit status
      @param user_data user data set when the signal handler was connected
    */
    static void on_child_exited(VteTerminal *vteterminal, gint status, gpointer user_data);
    /**
      Opens a terminal window and launches the script within the VteTerminal.
    */
    void on_launch_script_click();
    /**
      Closes the terminal window.
    */
    void close_terminal();
    /**
      Function that is called before the next assistant-page is shown.

      @param page The Gtk-Assistant-Page.
    */
    void on_next_pressed(Gtk::Widget* page);
    /**
      Shows a file-dialog and saves the script, the selected packages, the /etc/skel-folder and the slideshow-folder to the selected path.
    */
    void on_save_script_click();
  private:
    /**
      Returns the contents of a file as a string.

      @param fileName The path to the file.
      @return The contents of the file as a string.
    */
    std::string get_file_contents(std::string fileName);
    /**
      Checks if a Radiobutton is checked or not.

      @param widget The name of the radiobutton.
      @return A bool that indicates if the radiobutton is checked.
    */
    bool checkaurradiobtn(std::string widget);
    /**
      Adds a package to the list if the radiobutton is checked.

      @param widget The name of the radiobutton.
      @param packagename The name of the package.
    */
    void checkpkgradiobtn(std::string widget, std::string packagename);
    /**
      Adds a package to the list and starts a service if the radiobutton is checked.

      @param widget The name of the radiobutton.
      @param packagename The name of the package.
      @param servicename The name of the dm-service.
    */
    void checkpkgradiobtn_dm(std::string widget, std::string packagename, std::string servicename);
    /**
      Adds a package to the list if the checkbutton is checked.

      @param widget The name of the checkbutton.
      @param packagename The name of the package.
    */
    void checkpkgcheckbtn(std::string widget, std::string packagename);
    /**
      Gets the package names and services out of the standard-package-selector.
    */
    void pkgsfrombuttons();

    Glib::RefPtr<Gtk::Builder> refBuilder = Gtk::Builder::create();
    Glib::RefPtr<Gtk::Application> application;

    Gtk::Assistant *mainAssistant = nullptr;
    Gtk::Window *packageseditor = nullptr;
    Gtk::Window *add_aur_dialog = nullptr;
    Gtk::ListBox *aurlist = nullptr;
    Gtk::TextView *pkgstext = nullptr;
    Gtk::RadioButton *emptyradio = nullptr;
    Gtk::RadioButton *selectradio = nullptr;
    Gtk::RadioButton *sl_emptyradio = nullptr;
    Gtk::RadioButton *sl_selectradio = nullptr;
    Gtk::Button *btn_close_assistant = nullptr;
    Gtk::Button *btn_edit_packages = nullptr;
    Gtk::Button *btn_use_packages = nullptr;
    Gtk::Button *savebtn = nullptr;
    Gtk::Button *saveaurbtn = nullptr;
    Gtk::Button *addaurbtn = nullptr;
    Gtk::Button *remaurbtn = nullptr;
    Gtk::Button *folderdialogopen = nullptr;
    Gtk::Button *sl_folderdialogopen = nullptr;
    Gtk::Button *btn_save_script = nullptr;
    Gtk::Button *btn_launchscript = nullptr;
    Gtk::Button *btn_close_terminal = nullptr;

    std::string installedpackages = "";

    std::string folderpath = "";
    bool usefolder = false;

    std::string sl_folderpath = "";
    bool sl_usefolder = false;

    std::string final_skelfolder;
    std::string final_distname;
    std::string final_distdescr;
    std::string final_distversion;
    std::string final_distcodename;
    std::string final_slidesfolder;
    bool final_guilogin;
    std::string final_displaymanager;
    std::string final_aurpkgs;
    bool use_skelfolder;
    bool use_custom_slideshow;
    std::string scriptpath;

    std::string final_script;
};

#endif