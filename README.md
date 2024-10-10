# fuzz_cd
a basic bash script which you can add to your .bashrc to greatly improve your navigation capabilities within a terminal


## Prerequisites
```
sudo apt install fzf
```

## how to install?
step 1. copy the code in fcd.sh 
step 2. open up bashrc by running 
```
vim ~/.bashrc
```
and paste the function there

step 3. save and exit `[esc]:wq`
step 4. reload bashrc `source ~/.bashrc`
step 5. use it.


## Usage

directory search
```
f
```
then start typing to perform fuzzy filtering, press enter to navigate to that folder


file search
```
f -f
```

search, but providing a search term before it even enters fzf interactive menu
```
f {arguments}
```

