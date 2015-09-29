primeacademy.io
===============

PrimeAcademy.io website codebase

##Git Setup
###Local Machine Installation
####Windows

1. Download [Git for Windows](https://git-for-windows.github.io/) (select the latest Git-* file, not msysgit)
  1. If you plan on using TortoiseGit, you may want to disable Git's default Windows Explorer Integration options
  2. "Adjusting your PATH Environment": Select Run Git from the Windows Command Prompt
  3. "Configuring line ending conversions": Select Checkout as-is, commit Unix-style line endings
2. Open a Command Prompt window and enter the following:
  1. `git config --global user.name "{Your Full Name}"`
  2. `git config --global user.email {your email address}`
3. Optionally install [TortoiseGit](http://code.google.com/p/tortoisegit/downloads/list?q=label:Featured)
4. Optionally follow the 'Recommended Configuration' steps below.

####OSX

1. Download the latest [OSX Installer](http://code.google.com/p/git-osx-installer/downloads/list?can=3) for Git.<br>
  *Alternatively, install it through [Homebrew](http://mxcl.github.com/homebrew/) using: brew install git*
2. Open a Terminal window and enter the following:
  1. `git config --global user.name "Your FullName"`
  2. `git config --global user.email short-username@nerdery.com`
  3. `git config --global core.autocrlf input`
3. Optionally follow the 'Recommended Configuration' steps below.

###Recommended Configuration

The following items are optional, but recommended, configuration commands. Enter them in a Terminal or Command Prompt window:

Enable color: `git config --global color.ui "auto"`
<br>When pushing, only push the current branch: `git config --global push.default "current"`
<br>If you work over a mounted drive you may run into files being marked as changed due to permission changes. This can be fixed by running: `git config --global core.filemode false`

###Aliases

Aliases are shortcuts for commands, allowing you to use things like git ci instead of git commit.
```
git config --global alias.ci "commit"
git config --global alias.co "checkout"
git config --global alias.st "status"
git config --global alias.br "branch"
```

###Credential Caching

If you are working locally, you can configure Git to store your username and password. You must be using version 1.7.10 or newer.

Windows: Download and install [git-credential-winstore](https://github.com/anurse/git-credential-winstore/downloads)

OSX:

1. Download [git-credential-osxkeychain](https://confluence.atlassian.com/download/attachments/282989712/git-credential-osxkeychain?version=1&modificationDate=1335483205454)
2. Set the file as executable: `chmod a+x git-credential-osxkeychain`
3. Move the file to `/usr/local/bin`
4. Run the command: `git config --global credential.helper osxkeychain`

###Configuration to Consider

When pulling, use rebase instead of merge which results in a cleaner, more linear history: `git config --global branch.autosetuprebase always`

##Installing site localy for development

*These notes are written for an OSX environment.*

*These notes are written for an OSX environment.*

1. Create a directory to put the source code in: `mkdir prime`
2. Change directories to the source code directory: `cd prime`
3. Clone the repository into the current directory (*__Important__ - don't forget the dot on the end*): `git clone https://github.com/markhurlburt/primeacademy.io.git .`
4. If you don't have bundler installed, install it now: `gem install bundler`
5. Use bundler to install the required gem files: `bundler install`
