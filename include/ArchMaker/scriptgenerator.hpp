/**
  ArchMaker
  scriptgenerator.hpp
  Purpose: Generates the script.

  @author Hannes Schulze
  @version 7/8/17
*/

#ifndef _INCL_SCRIPTGENERATOR
#define _INCL_SCRIPTGENERATOR

#include <string>

class ScriptGenerator {
  public:
    ScriptGenerator(std::string distroname);
    /**
      Sets the distribution description.

      @param distrodescr The new description.
    */
    void set_distdescr(std::string distrodescr);
    /**
      Sets if gui-login is activated or not.

      @param guilogin The new value; true activates graphical login.
    */
    void set_guilogin(bool guilogin);
    /**
      Sets the display manager.

      @param displaymanager The new display manager service.
    */
    void set_displaymanager(std::string displaymanager);
    /**
      Generates the script.

      @return The script as a string.
    */
    std::string GenerateScript();
  
  protected:
    bool guilogin;
    std::string dmservice;
    std::string distname;
    std::string distdescr;
    
};

#endif