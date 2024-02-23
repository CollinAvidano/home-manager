{
  # When using sudo, use expansion (otherwise sudo ignores your aliases)
  sudo = "$'sudo -E '";

  # Other sudo aliases
  s = "sudo";
  se = "sudoedit";
  please = "sudo";

  # Ls aliases
  ls = "ls --color=always";        # pwetty colors
  l = "ls -CF";
  ll = "ls -alF";
  lsa = "ls -A";
  lsh = "ls -alh";
  oldestc = "ls -ltcr";         # sort by and show change time, most recent last
  oldesta = "ls -ltur";         # sort by and show access time, most recent last
  oldest = "oldestc";

  latestc = "ls -ltc";
  latesta = "ls -ltu";
  latest = "oldestc";

  # Remove aliases
  rm = "rm -rf";

  # Copy aliases
  cp = "cp -r";
  scp = "scp -r";

  # grep aliases
  hgrep = "\egrep --color=always -e '^' -e ";
  cgrep = "\egrep --color=always -e '^' -e ";

  grep = "grep --color=auto";
  fgrep = "fgrep --color=auto";
  egrep = "egrep --color=auto";

  # Refresh shell
  rfssh = "source ~/.\"$SHELL_EXTENSION\"rc";

  top = "htop";
  glances = "glances --percpu";

  df = "df -H";

  psg = "ps -e | grep ";
  # TODO make a ps tree variant of the above that outputs the whole tree but highlights the line using hgrep

  force-kill = "killall -9 ";

  # Free memory info
  meminfo = "free -m -l -t";

  # get GPU ram on desktop / laptop
  gpumeminfo = "grep -i --color memory /var/log/Xorg.0.log";

  check-serial = "ls -l /dev | grep -E 'ttyUSB|ttyS'";




  # Emacs alias
  emacs = "emacsclient -nc";
  emacs-cmd = "emacsclient -nw";

  # remove this one tie it to sound setup
  sound = "pavucontrol";


  # TODO ADD TO PYTHON
  py = "python";
  py3 = "python3";
  make-env = "virtualenv env";
  make-venv = "python3 -m venv env";
  #env-activate = "source env/bin/activate && unset PYTHONPATH"
  #activate-env = "source env/bin/activate && unset PYTHONPATH"
  env-activate = "source env/bin/activate";
  activate-env = "source env/bin/activate";
  ipython = "python3 -m IPython";

  # networking aliases
  list-ports = "ss -tulpn";
  nmap-quick = "sudo nmap -sN -p - ";

  #-g sd = "; notify-send "done""
  #-g e = "; ssmtp 4049840995@att.com < .mail.txt"

}
