# Vagrant

## Shared Folders

The vagrant file should not use shared folders, the root vagrant shared folder should also be explicitly disabled. 

Shared folders are terrible for performance, especially when not running in a native Linux environment. 

Windows also has the added issue of not understanding Linux file/folder permissions and actively prevents setting these unless you hard code all files/folders to a specific permission set.

