cdls() { cd "$@" && ls; }
cdll() { cd "$@" && ls -l; }
als () {
      echo "alias" $1'="'$2'"' >> ~/.bash_profile
        source ~/.bash_profile
    }

alias ll="ls -l"
alias ls='ls -G'

#Finds a class from a bunch of jars
function findjar {
  if [ -z "$1" ]; then
     # display usage if no parameters given
     echo "Usage: findjar <class-name> <path optional (if not given current directory is taken)>"
  else
    if [ -z "$2" ]; then
     echo "for i in `find $2 -name *.jar` ; do echo $i ; jar tvf $i | grep -i "$1.class" ; done"
     for i in `find $2 -name *.jar` ; do echo $i ; jar tvf $i | grep -i "$1.class" ; done
    else
     echo "for i in `find . -name *.jar` ; do echo $i ; jar tvf $i | grep -i "$1.class" ; done"
     for i in `find . -name *.jar` ; do echo $i ; jar tvf $i | grep -i "$1.class" ; done
    fi
  fi 
}

# Extract any archives like tar, jar etc
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|jar>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.lzma)      unlzma $1      ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x -ad $1 ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *.jar)       jar xvf $1     ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# Creates archives like tar, jar etc.
function archive {
  if [ -z "$1" ]; then
     # display usage if no parameters given
     echo "Usage: archive <output-path/filename.<tar|jar> <input-path>"
  else
     if [[ -d $2 ]] || [[ -f $2 ]] ; then
         # NAME=${1%.*}
         # mkdir $NAME && cd $NAME
         case $1 in
           *.tar)   tar cvf $1 $2    ;;
           *.jar)   jar cvf $1 $2    ;;
           *)           echo "extract: '$1 $2' - unknown archive method" ;;
         esac
     else
       echo "$2 - input path does not exist"
     fi
  fi
}

 # Lists archives
 function listar {
  if [ -z "$1" ]; then
     # display usage if no parameters given
     echo "Usage: listar <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|jar>"
  else
     if [ -f $1 ] ; then
         # NAME=${1%.*}
         # mkdir $NAME && cd $NAME
         case $1 in
           *.tar.bz2)   tar tvjf $1 | less   ;;
           *.tar.gz)    tar tvzf $1 | less   ;;
           *.tar.xz)    tar tvJf $1 | less   ;;
           # *.lzma)      unlzma $1      ;;
           # *.bz2)       bunzip2 $1     ;;
           # *.rar)       unrar x -ad $1 ;;
           # *.gz)        gunzip $1      ;;
           *.tar)       tar tvf $1  | less    ;;
           *.tbz2)      tar tvjf $1 | less   ;;
           *.tgz)       tar tvzf $1 | less   ;;
           # *.zip)       unzip $1       ;;
           # *.Z)         uncompress $1  ;;
           # *.7z)        7z x $1        ;;
           # *.xz)        unxz $1        ;;
           # *.exe)       cabextract $1  ;;
           *.jar)       jar tvf $1  | less    ;;
           *)           echo "$1 Unknown archive method" ;;
         esac
     else
         echo "$1 - file does not exist"
     fi
 fi
 }

 
