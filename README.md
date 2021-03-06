#Flycheck linter for sh using [checkbashisms][checkbashisms-url]

##Installation

###Install [checkbashisms][checkbashisms-url]

[checkbashisms][checkbashisms-url] is part of Debian [devscript][devscript-url].

* On Debian based systems:
```sh
sudo apt-get install devscripts
```

* On Redhat/Centos:
```sh
sudo yum install rpmdevtools
```

* On FreeBSD:
```sh
sudo pkg install checkbashisms
```

or you can download manually and add [checkbashisms][checkbashisms-url] to your `PATH`.

### Install flycheck-checkbashisms

####Manual installation

Copy `flycheck-checkbashisms` file to `load-path`, then add these lines to `init.el`:
```elisp
(require 'flycheck-checkbashisms)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-checkbashisms-setup))
```

### Melpa

...

##Customize variables

```elisp
;; Check 'echo -n' usage
(setq flycheck-checkbashisms-newline t)

;; Check non-POSIX issues but required to be supported  by Debian Policy 10.4
;; Setting this variable to non nil made flycheck-checkbashisms-newline effects
;; regardless of its value
(setq flycheck-checkbashisms-posix t)
```

[checkbashisms-url]: https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl "checkbashisms"
[devscript-url]: https://anonscm.debian.org/cgit/collab-maint/devscripts.git "devscript"
