# Icky intimate knowledge of MiG output.

BEGIN { print "/* This file is generated by shortcut.awk.  */";
	print "#include <mach-shortcuts-hidden.h>";
	echo=1;
	inproto=0; proto=""; arglist="";
      }

$1 == "LINTLIBRARY" { print "#include <mach.h>"; next }

$1 == "weak_alias" { next }

# Copy the first line of the definition, but
# replace the function name (RPC) with CALL.
$NF == rpc \
  {
    for (i = 1; i < NF; ++i) printf "%s ", $i;
    print call;
    next;
  }

# Collect the lines of the prototype in PROTO, and extract the parameter
# names into ARGLIST.
NF == 1 && $1 == ")" { inproto=0 }
inproto { proto = proto $0;
	  arg = $NF;
	  gsub(/[^a-zA-Z0-9_,]/, "", arg);
	  arglist = arglist arg;
	}
NF == 1 && $1 == "(" { inproto=1 }

/^{$/ { echo=0; }

echo == 1 { print $0; }

/^}$/ && proto != "" \
  {
    print "{";
    print "  kern_return_t err;";
    print "  extern kern_return_t " syscall " (" proto ");";
    print "  extern kern_return_t " rpc " (" proto ");";
    print "  err = " syscall " (" arglist ");";
    print "  if (err == MACH_SEND_INTERRUPTED)";
    print "    err = " rpc " (" arglist ");";
    print "  return err;"
    print "}";
    print "weak_alias (" call ", " alias ")";
    print "libc_hidden_def (" call ")";
    # Declare RPC so the weak_alias that follows will work.
    print "extern __typeof (" call ") " rpc ";";
    echo = 1;
  }
