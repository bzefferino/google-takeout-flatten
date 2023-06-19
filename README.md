# google-takeout-flatten (PowerShell Script)
When you download all your photos and videos from the google cloud, it's split into many pieces and subfolders with a lot of unnecessary json files.
This script will allow you to move all the non-json files into a single directory instead of having them split across multiple directories.

Use:

`.\Takeout.ps1 -SourceDirectory "<Enter Source Directory>" -DestinationDirectory "<Enter Destination Directory>"`
