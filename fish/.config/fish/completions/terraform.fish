
function __complete_terraform
    set -lx COMP_LINE (string join ' ' (commandline -o))
    test (commandline -ct) = ""
    and set COMP_LINE "$COMP_LINE "
    /Users/albert/.asdf/installs/terraform/0.15.4/bin/terraform
end
complete -c terraform -a "(__complete_terraform)"

