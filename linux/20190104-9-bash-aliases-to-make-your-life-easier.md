Allow me to share with you some intuitive Bash alias definitions for the command line interface in my first Medium post.

Bash aliases, together with tab completion on the command line interface, make you more efficient and productive at work because essentially you type less, and you are less prone to erroneous command inputs.

#### 1.cdd

Similar tocd, this changes directory and also lists its contents.

Usage:
```
$ cdd myFolder
Alias:

function cdd() {
    cd $1
    ls
}
```

#### 2.I don’t Git it

Git pushing and pulling is such a pain. Let’s summarise all those lines of commands in a line.

Usage:

```
$ gitpush "my commit message"
The above adds your files, commits with a commit message, and pushes to your origin from your current branch. To pull any changes, simply:

$ gitrefresh
Aliases:

function gitpush() {
    B=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    git add -A .
    git commit -m $1
    git push -u origin $B
}
function gitrefresh() {
    B=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    git checkout master
    git pull origin master
    git checkout $B
}
```

#### 3.Accessing your remote servers
Removed Bash alias ‘sshtoserver’ because you can do it in a more elegant way.

Usage:

```
$ scptoserver myFolder /home/Allan
The above allows you to SCP from myFolder in your local to a remote server.

Alias:

function scptoserver() {
    scp -r $1 192.168.1.245:"$2"
}
```

#### 4.Googling
You’re on the command line or in an editor with CLI but need to google something. I would assume you have Google Chrome. Otherwise, you can rename to a different browser.

Usage:
```
$ google why is the sky blue
You can also restrict the search results to StackOverflow,

$ googlestack python cannot import module
Aliases:

function google() {
    open -na "Google Chrome" --args "https://www.google.com/search?q=$*"
}
function googlestack() {
    open -na "Google Chrome" --args "https://www.google.com/search?q=site:stackoverflow.com $*"
}
```

#### 5.Conda
Conda is an environment and package manager which I use frequently for my Python projects. The following shortcut reminds you the current environment you are in.

Usage:

```
$ currentenv
Alias:

function currentenv() {
    conda env list | grep \* | cut -d ' ' -f 1
}
```

#### 6.Spotify
Developers listen to music while coding right? This one makes use Spotify API and lynx. Follow the instructions to get the Spotify API here (it’s really easy), and brew install lynx.

Usage:
```
$ lyrics
If this doesn’t work, it means azlyrics.com cannot find the song. 
If this is the case, let Google do it for you using $ lyrics2.

Aliases:

function lyrics() {
    query="$(spotify status | sed -n '2p; 4p' | cut -d ' ' -f 2-10)"
    song="$(lynx -dump -nonumbers -listonly https://search.azlyrics.com/search.php\?q\=$query | sed -n 29p)"
 open -na "Google Chrome" --args $song
}
function lyrics2() {
    query="$(spotify status | sed -n '2p; 4p' | cut -d ' ' -f 2-10)"
    google lyrics $query
}
```

#### 7.Compiling C
I don’t really program in C but this compiles and runs your C program.

Usage:

```
$ compilec helloWorld.c
Alias:

function compilec() {
    clang "$1".c -o "$1" &&
    ./$1
}
```

#### 8.Desktop
I can’t help but to have a shortcut to go to the desktop.

Usage:

```
$ desktop
Alias:

function desktop() { 
    cd ~/Desktop 
}
```

#### 9.Shortcuts
Wait, what was the shortcut you wrote yesterday again? This prints out the list of aliases you have defined.

Usage:
```
$ shortcuts
Alias:

function shortcuts() {
    cat ~/.custom_aliases # the file with your aliases
}
```

Append your favourite alias definitions to the~/.custom_aliases (or ~/.bash_aliases) file. Remember to run source ~/.custom_aliases.

Do you have other shortcuts that you use on a daily basis? Share them here!

Follow me on Twitter @remykarem for digested articles and interactive demos on AI, Deep Learning, and Front End Web Dev.

[Copy from here](https://medium.com/@raimibinkarim/9-bash-aliases-to-make-your-life-easier-3e5855aa95fa)