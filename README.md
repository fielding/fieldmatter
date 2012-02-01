# Extremely primitive vision for the project
  
I've decided to write a program that will start as a simple command line wrapper for git and capture the extended attributes of the files before the git commit. It stores them in a specific file or location(to be determined).  This file, or files, is then committed along with the rest of the git commit.  On the other end it can then be accessed directly through the repo itself to construct images of all the repo objects as files with their original extended attributes. 
  
My main motivation in writing this comes from the desire to use extended attributes in my note/document/file management system. Initially I have a repo full of markdown files (.md) that I want to set specific attributes for and store those attributes as extended attributes. Tags, Author, Permissions, etc are the main things I'd like to preserve.  
