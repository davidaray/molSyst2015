This is your introduction to the Unix environment. Several of these excercises are pointless and really do nothing.  Their purpose is to familiarize yourself with some of the basic commands/file manipulations you will use throughout the course.  Keep a cheat sheet for yourself that you can quickly refer to in the future.  You can find these on google, but some of frequent commands you will use (ex. qlogin) are more specific to our system.

#------------------------------------------------------------------------------# 
#                           LOGGING  ON TO HROTHGAR                            #
#------------------------------------------------------------------------------# 
There are various ways to log on to our HPCC.  You can do this through the terminal (for Mac or *nix systems), a unix emulator (CYGWIN) or you can use an SSH client.  For simplicity we will use the SSH Secure Shell with a bundled FTP client.  For Mac people (ugh...Taylor) you can use your terminal and Filezilla.

1] Download and install the appropriate SSH/FTP combo
Windows:    https://shareware.unc.edu/pub/win/SSHSecureShellClient-3.2.9.exe
Mac:        http://sourceforge.net/projects/filezilla/files/FileZilla_Client/3.14.1/FileZilla_3.14.1_macosx-x86.app.tar.bz2/download?nowrap

2] Set up and save your profile on the SSH client
Host Name: hrothgar.hpcc.ttu.edu
User Name: <from when you created your acount>

Save your profile and connect.

The same information can be used to save a profile on your FTP client (Filezilla)

For Macs, in your terminal:
    ssh <userName>@hrothgar.hpcc.ttu.edu


#------------------------------------------------------------------------------# 
#                         MOVING FROM THE HEAD NODE                            #
#------------------------------------------------------------------------------# 
Now that we are logged on, you should notice that we are on the head node.  Do not do any analyses on the head node.  It is a crime punishable by death.  ONE of the ways to move off of the head node is to request an interactive session (via qlogin)
	qlogin -q phylo -P hrothgar -pe fill 1
Notice the change in your command prompt.  This tells you that your are working from a compute node.

You can also check the status of your job request via:
	qstat

#------------------------------------------------------------------------------# 
#                     MANIPULATING FILES AND DIRECTORIES                       #
#------------------------------------------------------------------------------# 
Now that you are logged on, there are several "basics" that we need to cover.  These include
	- Directories
	- Paths (relative and absolute)
	- Commands
		* pwd
		* mkdir
		* cd
		* ls
		* cp
		* mv
		* rm (-r)
	- Tab completion 
There is a lot of information/utility in these commands.  We will discuss them here but it is your responsibility to take as many or as few notes as you need.  For know, download the the following file.

https://www.dropbox.com/s/xln3gd78oeozd09/cytbPero_bayes_2014-02-07.nexus?dl=0

Often, you will need to create or transfer a file to your directory.  The easiest to transfer a files is through the gui FTP.

Now that the file is on Hrothgar, how can we look at it.
	cat
But this can be dangerous (what if the file was 1TB).
	less
	head
	tail

If you want to make minor edits to your file without transfering each time you can use one of the many text editors that are available.  Nano/Pico and VIM/EMACs are the most commonly used.  VIM/EMACs are more powerful than Nano/Pico, but more complicated.  For now stick with nano.

Another way to transfer files is through wget
	wget https://www.dropbox.com/s/xln3gd78oeozd09/cytbPero_bayes_2014-02-07.nexus?dl=0


#------------------------------------------------------------------------------# 
#                     WORKING WITHIN THE QUEUE                                 #
#------------------------------------------------------------------------------# 
So at this point we are still on the head node.  Prove it to yourself.

You can exit your session by closing your terminal.  But that is a jerk thing to do.  Your session will stay in the queue forever.  You have to specifically tell the system you want to end your session by typing:
	exit

Now check the queue again.  You should eventually see your job disappear.  This brings the interactive session to an end, but what if you don't want an interactive session.  You want to submit your job then go home.  To do this, we use submission scripts.

Download the following script to your home folder.
	wget https://www.dropbox.com/s/4jtfepy5gigh8vs/counter.pbs.sh?dl=0
then:
	qsub counter
and watch the queue... Notice the differences.  This job is running, but we aren't doing anything.  Open the file in a text editor.  We have aleady discussed the submission script format, but will do so again here...

<...>

Change your submission script to count to 1000 instead of 100, resubmit, then once it is running look in your home directory.  Do you see the new files that look like jobName.eBIGNUMBER and jobName.oBIGNUMBER.  These files store the output sent to stderr and stdout.  Look at the contents and describe what yous see.

Now that this program has been altered.  It will run for a very long time.  Anytime you want to kill a job just type
	qdel <jobNumber>
The job number can be found using qstat.


#------------------------------------------------------------------------------# 
#                     THE LAST FEW THINGS                                      #
#------------------------------------------------------------------------------# 
It is helpful to understand how about your .bashrc and path....

There are a lot of paramters that can be adjusted surrounding your terminal session.  These can be manipulated via the .bashrc file.  Each time you log on the .bashrc file is read...so if you want to store a program name and always have it available, then you could include this information in your .bashrc.  

Whenever you are running a program you can use <TAB> to bring it up if it is in your path.  This is a list of directories that the system will search to find programs to run.  For example, if you want to run MUSCLE but its in a different directory you can either include the path to MUSCLE or you can add the directory to your $PATH variable...and have it automatically found.  Either way works and both have their advantages.  For know,dont worry about this, but be aware of it.
