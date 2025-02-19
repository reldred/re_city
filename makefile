# reldreds garbage nfo compile system
# Written by reldred, the artist formerly known as Aegir. Major kudos to Josef 'Patchman' Drexler for the 
# suggestion to abuse the hell out of gcc preprocess and then make nforenum wipe our arses for us.

# Have fun.

# Our Steps:
# 1: gcc -ECP preprocess
# 2: nforenum process
# 3: grfcodec compile

# Macros:
# Paths for our tools
<<<<<<< HEAD
GRFCODEC = grfcodec
NFORENUM = nforenum -b +
GRFDIR = ../../../../../REHI-GREEN/Software/Games/JGR\ Patchpack/newgrf/
=======
GRFCODEC = ../../Executables/grfcodec.exe -e
NFORENUM = ../../Executables/nforenum.exe -b +
GRFDIR = ../../../../../DMZ/Software/Games/OpenTTD\ Nightly/newgrf/
>>>>>>> 1c855b52de9135bcf51e5b64d493d4772189d189

# GCC Settings:
CC = gcc
PREPROCESS = -E -C -P - <

# Aliases for the set:
NAME = re_city

# Now, the fun stuff:

# Target for all:
all : compile

# Compile GRF's
#don't need graphics anymore since grfcodec can eat pngs
#compile : process graphics
compile : process
#	@echo "Compiling Windows GRF:"
#	$(GRFCODEC) $(NAME)w.nfo .
#	@echo
	@echo "Compiling OpenTTD/DOS GRF:"
	$(GRFCODEC) -em 1 $(NAME).nfo .
	@echo
	
# NFORENUM process the Windows copy of the NFO
process : preprocess
	@echo "NFORENUM Processing:"
	-$(NFORENUM) $(NAME).nfo
#	-cp $(NAME).nfo $(NAME)w.nfo
	@echo
	
# GCC Preprocess the HNFO	
preprocess :
	@echo "GCC Preprocessing HNFO:"
	$(CC) $(PREPROCESS) $(NAME).hnfo > $(NAME).nfo
	@echo

# so grfcodec can handle pngs now... 
#oh what wonders the new decade has wrought
#graphics :
#	@echo "Converting .png files to .pcx:"
#	$(MAKE) -C art/
#	@echo

# Clean the source tree
clean:
	@echo "Cleaning source tree:"
	@echo "Remove backups:"
	-rm *.bak *~
#	@echo
#	@echo "Remove .pcx:"
#	-rm art/*.pcx
	@echo
	@echo "Remove .nfo:"
	-rm *.nfo
	@echo
	@echo "Remove compiled .grf:"
	-rm *.grf

# Installation process
install:
	@echo Installing .grf files to $(GRFDIR).
#	@echo "Windows GRF:"
#	-cp $(NAME)w.grf $(GRFDIR)/$(NAME)w.grf
#	@echo
	@echo "DOS/OpenTTD GRF:"
	-cp $(NAME).grf $(GRFDIR)/$(NAME).grf
