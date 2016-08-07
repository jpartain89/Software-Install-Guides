# Imaging SD Card for Raspberry Pi

This is my personal, favorite means of imaging an SD Card through the command line - which is the easiest, most foolproof means of doing so. Plus, its also learning, which is reason #1 for doing this....

I use the tool `ddrescue` rather than `dd` like most other sites say to. The reason? A nice, command line output of its copying progress.... Not to mention ddrescue tends to be a more granular means of copying files over.

Plus, sans SD Card? Its a good backup tool to have for, well, backing up filesystems on a more granular, hardware-is-prone-to-fail type of level. Also allowing multiple passes over said data, so that if the sector pooped out the first time, maybe a 2nd or 3rd pass would, maybe not help but increase the odds of that one sector copying.

So, if you're using macOS? I would assume/hope you have HomeBrew installed. 
