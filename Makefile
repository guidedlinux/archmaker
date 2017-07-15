CC := g++
SRCDIR := src
OBJDIR := bin/obj
TARGET := bin/archmaker
DESTDIR ?= 
BINDIR := $(DESTDIR)/usr/bin
SHAREDIR := $(DESTDIR)/usr/share
 
SRCEXT := cpp
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(OBJDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g `pkg-config --cflags gtkmm-3.0 vte-2.91`
CFLAGS += -I include
LIB := -pthread `pkg-config --libs gtkmm-3.0 vte-2.91`
GLADEFILE := glade/ui.glade

$(TARGET): $(OBJECTS)
	@echo " Linking..."
	@echo " $(CC) $^ -o $(TARGET) $(LIB)"; $(CC) $^ -o $(TARGET) $(LIB)

$(OBJDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(OBJDIR)
	@echo " $(CC) $(CFLAGS) -c -o $@ $<"; $(CC) $(CFLAGS) -c -o $@ $<

clean:
	@echo " Cleaning..."; 
	@echo " $(RM) -r $(OBJDIR) $(TARGET)"; $(RM) -r $(OBJDIR) $(TARGET)

.PHONY: install
install:
	@echo " mkdir -p $(BINDIR)"; mkdir -p $(BINDIR)
	@echo " install -m 557 $(TARGET) $(BINDIR)/archmaker"; install -m 557 $(TARGET) $(BINDIR)/archmaker
	@echo " mkdir -p $(SHAREDIR)/archmaker"; mkdir -p $(SHAREDIR)/archmaker
	@echo " mkdir -p $(SHAREDIR)/archmaker/default-slideshow"; mkdir -p $(SHAREDIR)/archmaker/default-slideshow
	@echo " cp $(SRCDIR)/standardslideshow/*.png $(SHAREDIR)/archmaker/default-slideshow"; cp $(SRCDIR)/standardslideshow/*.png $(SHAREDIR)/archmaker/default-slideshow
	@echo " cp $(GLADEFILE) $(SHAREDIR)/archmaker/ui.glade"; cp $(GLADEFILE) $(SHAREDIR)/archmaker/ui.glade
	@echo " cp archmaker.svg $(SHAREDIR)/icons/"; cp archmaker.svg $(SHAREDIR)/icons/
	@echo " install -m 777 archmaker.desktop $(SHAREDIR)/applications/"; install -m 777 archmaker.desktop $(SHAREDIR)/applications/

uninstall:
	@echo " rm -rf $(BINDIR)/archmaker $(SHAREDIR)/applications/archmaker $(SHAREDIR)/icons/archmaker.svg $(SHAREDIR)/archmaker/"; rm -rf $(BINDIR)/archmaker $(SHAREDIR)/applications/archmaker.desktop $(SHAREDIR)/icons/archmaker.svg $(SHAREDIR)/archmaker/