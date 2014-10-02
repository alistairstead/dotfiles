# set +e
# set +u

# boxen root
set BOXEN_HOME /opt/boxen

# path
# set PATH $BOXEN_HOME/rbenv/{shims,bin} $BOXEN_HOME/rbenv/plugins/ruby-build/bin $BOXEN_HOME/homebrew/bin $BOXEN_HOME/homebrew/sbin $BOXEN_HOME/bin $PATH
set -x PATH $BOXEN_HOME/homebrew/bin $BOXEN_HOME/homebrew/sbin $BOXEN_HOME/bin $PATH

# man
set MANPATH $BOXEN_HOME/homebrew/share/man $MANPTH

# env
for f in $BOXEN_HOME/env.d/*.sh;
	if test -f $f
		eval bash $f
	end
end

# version
set BOXEN_SETUP_VERSION (set GIT_DIR $BOXEN_HOME/repo/.git git rev-parse --short HEAD)
