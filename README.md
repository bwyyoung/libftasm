#NASM & BREW

https://gist.github.com/skyl/36563a5be809e54dc139

Download that, set YOUR_HOME in the script to the absolute path. 
chmod +x the script. Create the YOUR_HOME/usr/local directory. 
Then, execute the script.
```
./install.rb
```
In .bash_profile, I set (I'm not positive this is important, pretty sure):

```
export HOMEBREW_PREFIX=/The/path/to/YOUR_HOME/usr/local
```
Now, I can:

brew install wget
Make sure the bin directory, YOUR_HOME + /usr/local/bin is on your $PATH.

```
which wget
```