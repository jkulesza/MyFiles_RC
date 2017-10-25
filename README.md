# Notes

This repository is intended to hold Linux/OSX configure files for window
managers as well as various utilities.  In addition, it holds a significant
amount of data (including some desktop wallpapers) for the FVWM window manager.

Finally, some various tips-and-tricks are shown below associated with various
operations (generally those that are needed frequently enough to be useful but
infrequently enough to be easily forgotten).

## Bash

### Get `cal` for a Different Month

One can use `date` piped through some manipulation as input to `cal` to get
monthly calendars for other months.

`date -v-1m +%m-%Y | tr "-" " " | xargs cal`

### Exclude Files from TAR Archive

TAR archives can be created with a command such as:

`tar -cvf filename.tar {source file list}`

However, sometimes it is convenient to to recursively traverse a directory but
yet exclude some files from the process. This can be accomplished with the
--exclude flag, which can accept file names including wildecard characters. For
example:

`tar -cvf filename.tar --exclude="*.fort.16" --exclude="*.lib" {source file
list}`

*Note that sometimes the "excludes" can come after the source file list,
depending on the version of tar.*

## exiftool

### Change all Dates

```
exiftool -AllDates='2015:10:13 13:00:00' -overwrite_original 2015_10_13_02.jpeg
```

## git

### Pushing to Two Repositories at Once

Use `git remote -v` to list all repositories configured as well as their status.
One can then use

`git remote set-url --add --push origin git://somewhere/something.git`

to add an additional 'push' repository for the *origin*.  One can then use `git
remote -v` to view the status of the repositories and should see two push
repositories for *origin* --- indicating that both will be pushed to with a
simple `git push` is called.  For example, one might see:

```
> git remote -v
origin git@github.com:jkulesza/RC_Files.git (fetch) origin
git@bitbucket.org:jkulesza/rc_files.git (push) origin
git@github.com:jkulesza/RC_Files.git (push)
```

## Embed Fonts in PDF

One can embed fonts in a pdf with the `pdftocairo` command line tool using a
command line

```
pdf2cairo -pdf infile.pdf outfile.pdf
```

## Linux

### Create Animated GIFs

To create animated GIF files from a series of images, use the following command:

`convert -delay 5 path/*.gif animation.gif`

where `delay` is the delay between images in 1/100ths of a second.

### Mount USB Stick

A simple method for mounting a USB stick on Linux using udev. The command is
simply:

`mount -t vfat /dev/sde1 usbstick/`

where `/dev/sde1` is the device that corresponds to the stick and `usbstick/` is
the destination directory.

### Set Recursive Directory Permissions

The following two commands give full owner and group permissions to all files
and directories in /path/to.

```
find /path/to -type d -exec chmod 770 {} \; find /path/to -type f -exec chmod 660 {} \;
```

### XTerm Selection with Double Mouseclicks

In order to allow one to double-click files in XTerm and not be hindered by
intermediate characters such as "-,.,\_" one can include the following line in
the ~/.Xdefaults file.

`XTerm*charClass: 33:48,36-38:48,43-47:48,58:48,61:48,63-64:48,126:48`

It'll take some further investigation, but word has it that one can also modify
XTerm click behavior with the regular expressions similar to the following.

```
xterm*on2Clicks:  regex [^/@ \n]+
xterm*on3Clicks:  regex [^ \n]+
xterm*on4Clicks:  regex [^#$]+
xterm*on5Clicks:  line
```

## Mac OSX

### Disable System Integrity Protection (SIP) / Rootless Operation

This mode of operating disallows modification of certain system items, which can
include the .app containers for installed programs.  As such, operations like
changing out the cursor of the Terminal is not possible without doing this.
Nevertheless, to disable SIP, boot into the OSX utilities dialog by holding
*Command-R* during boot until the Apple logo appears with a bar beneath it.
Then, when within the Utilities interface, launch the terminal and type

```
csrutil disable
```

to renable, type

```
csrutil enable
```

### Burn ISO to USB Drive

#### 1. Prepare the USB Drive

Open the *Disk Utility* and perform:

1. Select the USB Drive (select the root device, not its partitions)
2. Select the partition section at the top
3. Change the Scheme to 1 Partition
4. Change the Format to Free Space
5. Click Apply

You will get a confirmation dialog appear ensuring you really want to delete all
data on the key, choose Partition.  Once it’s completed you can quit out of Disk
Utility.

#### 2. Convert the Image

Now that the USB Drive is ready, we convert our .iso image into a format that we
can copy to it. Open up a Terminal, navigate to the directory with the ISO and
enter:

`hdiutil convert -format UDRW -o name.img name.iso`

and note that the utility will likely append `.dmg` to the file name specified.

#### 3. Copy the Image to the USB Drive

First run `diskutil list` to get a listing of the disks in your machine so you
can identify the USB key.  In many cases, the ID will be `/dev/disk1`.

Note that we want to use the RAW disk device so that our copy will happen much
faster because the RAW disk device provides unbuffered access to the device.
This is accomplished by simply prepending **r** to the device so that
`/dev/disk1` becomes `/dev/rdisk1`.

Finally, to perform the copy we enter:

`dd if=./name.img.dmg of=/dev/rdisk1 bs=1m`

where `bs=1m` specifies the blocksize in order to accelerate the copy.

Once done, OSX will probably unmount the drive and complain that it cannot use
the USB Drive, so it can simply be removed.

### Change Terminal I-Beam Cursor

Edit the cursor tiff image inside the Terminal App at:

`Terminal.app/Contents/Resources/ShadowedIBeam.tiff`

and then run in the terminal:

`defaults write com.apple.Terminal UseCustomIBeamCursor -bool YES`

### List System Timezones

`sudo systemsetup -listtimezones`

### Reset Launchpad

The following will reset the launcher to the default layout whereby the first
screen will have the default arrangement of OSX applications and following
screens will have a roughly alphabetized listing of the user-installed
applications:

`defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock`

### Add Spaces to Dock

`defaults write com.apple.dock persistent-apps -array-add '{tile-data={};
tile-type="spacer-tile";}' && killall Dock`

### Codesign `gdb`

In order to use `gdb` installed through something like fink, macports, homebrew,
etc. it has to be codesigned.  This involves some combination of three steps,
suggested as:

#### Disable SIP

See above.

#### Codesign Executable

1. Start the Keychain Access application (in /Applications/Utilities/Keychain
Access.app)
2. Select the Keychain Access -> Certificate Assistant -> Create a
Certificate... menu
3. Choose a name for the new certificate (this procedure will use "gdb-cert" as
an example)
4. Set "Identity Type" to "Self Signed Root"
5. Set "Certificate Type" to "Code Signing"
6. Activate the "Let me override defaults" option
7. Click several times on "Continue" until the "Specify a Location For The
Certificate" screen appears, then set "Keychain" to "System"
8. Click on "Continue" until the certificate is created
9. Finally, in the view, double-click on the new certificate, and set "When
using this certificate" to "Always Trust"
10. Exit the Keychain Access application and restart the computer (this is
unfortunately required)

Once a certificate has been created, the debugger can be codesigned as follow.
In a Terminal, run the following command...

```
codesign -fs "gdb-cert" /sw/bin/fsf-gdb
```

#### Update Taskgated plist Entry

Changing the `/System/Library/LaunchDaemons/com.apple.taskgated.plist` entry of

```
<array> <string>/usr/libexec/taskgated</string> <string>-s</string> </array>
```

to

```
<array> <string>/usr/libexec/taskgated</string> <string>-sp</string> </array>
```

#### Add User To procmod Group

Add the user to the `procmod` group with `sudo dseditgroup -o edit -a jkulesza
-t user procmod`.

## MCNP

### Plot Cross Section

```
mcnp6 ixz i=${INPUT} 
xs 1001.80c 
mt=-1 
printpts ${OUTFILE}
```

will plot an MCNP file of the form

```
Cross Section Plotter
100  1 -1 -100 imp:n=1
666  0     100 imp:n=0

100  so 1

mode n 
m1 49115.80c 1.0 
sdef 
print 
nps 10
```

### Plot fmesh Tally

```
mcnp6 z runtpe=${RUNTPE} 
fmesh 4
```

## MySQL

### Import / Export

To export a MySQL database, use the following command:

`mysqldump -u username -ppassword --databases database_name > FILE.sql`

Replace username, password and database_name with your MySQL username, password
and database name(s). One can also use the `-A` parameter to export all
databases.

To create and import a MySQL database like one captured previously, simply
enter:

`mysql -u username -ppassword database_name < FILE.sql`

## Perl

### Count Line Length

`cat fuel.dat | perl -lne 'print length'`

## Python

### Calculate Plane Equation From 3 Points

```
from sympy import Point3D, Plane, N 
a = Plane(
    Point3D(-3.7714999999999996,-3.469,1), 
    Point3D(-3.7714999999999996,-3.469,0),
    Point3D(-3.6245+8.010,-3.432,0)
) 
print(N(a.equation()))
```

### Check If In A Screen Session 

`assert(os.getenv('STY') != None), "You are not within a screen session."`

## rsync

A useful `rsync` command to push files, recognizing changes but deleting old
files, is:

`rsync -abviuzP --delete -e ssh <ABSOLUTE_PATH_TO_SOURCE_DIR> user@destination:<ABSOLUTE_PATH_TO_DESTINATION_DIR>`

## sed

To perform in-line replacements using `sed`, use:

`sed -i.bak s/STRING_TO_REPLACE/STRING_TO_REPLACE_IT/g index.html`

where the `-i` option makes the changes inline and creates a backup of the
original file before it performs the change.  Without the .bak the command will
fail on some platforms, such as Mac OSX.  From
http://stackoverflow.com/a/5171935.

## Visio

### Make Shapes the Same Size

The following VB Macro will make multiple Microsoft Visio shapes the same size
as the first shape selected.

```
Public Sub MakeSameSize()
  Dim width As Double, height As Double
  If ActiveWindow.Selection.Count > 0 Then
    With ActiveWindow.Selection
      width = .Item(1).Cells("Width").ResultIU
      height = .Item(1).Cells("Height").ResultIU
      For i = 2 To ActiveWindow.Selection.Count
        .Item(i).Cells("Width").ResultIU = width
        .Item(i).Cells("Height").ResultIU = height
        Next i
    End With
  End If
End Sub
```

## LyX / LaTeX

To map a shortcut for inserting a Cross Reference, one needs to bind a key
combination to `dialog-show-new-inset ref`.

### Create Custom Bibliography Style

First use `latex makebst` to be routed through a menu-driven interface to define
the various stylistic parameters for the bibliography entries.  This will create
a `.log` and `.dbj` file.  From there, run `tex ...djb` to create a standard
`.bst` file.
