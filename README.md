# fuzz_cd
a basic bash script which uses fzf with additional configurations and capabilities to 
quickly navigate your terminal

## Prerequisites
```
./install
```

what the install script does?
```
check that fzf exists in /usr/local/bin
if it doesnt, then download the standalone binary and move it to /usr/local/bin

then download latest version of fcd script from github
compare with checksum provided by us.
install the fcd into /usr/local/bin
```


## Usage

open fzf interactive window in cwd, then you can interact and match, once you press enter, you will cd into that directory
```
fcd 
```

searches for a file, once found will navigate to folder containing file
```
fcd -f 
```

apply regex even before you want to enter interactive window (searches directories)
```
fcd {regex}
```

same as previous command but for files
```
fcd -f {regex}
```