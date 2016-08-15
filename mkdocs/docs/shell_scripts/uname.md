# Using UNAME for System Info

Often times, if you're writing shell scripts for, well, whatever reasons, you'll find  you need to differentiate between macOS, Linux - and then Ubuntu, debian, Red Hat, etc. - or any other system.

## tl;dr [^5bc1e731]

```bash
if [[ "$(uname)" == "Darwin"  ]]; then
    # Do something related to macOS
elif [[ "$(uname)" == "Linux" ]]; then
    # Do something related to Linux
fi
```

## UNAME

One way, using a built-in program, is using `uname`, which gets you more basic system info.

| OPTION | Description |
|:--------:|:---------:|
| -a, --all  |  print all information in the following order, except omit -p and -i if unknown: |
| -s, --kernel-name | print the kernel name |
| -n, --nodename  | print the network node hostname |
| -r, --kernel-release | print the kernel release  |
| -v, --kernel-version  | print the kernel version |
| -m, --machine  | print the machine hardware name |
| -p, --processor  | print the processor type or "unknown" |
| -i, --hardware-platform  | print the hardware platform or "unknown" |
| -o, --operating-system  | print the operating system |

## /etc/*-release

```bash
cat /etc/*-release
```

That gives you quite a lot more info about the OS, but is non-macOS.

So, in a shell script, you would `source /etc/*-release` and then assign the info.

```bash
source /etc/*-release
ID=<see below>
```

For the ID, it'll show `raspbian` or `ubuntu` or any other.

Then, since you've sourced the `/etc/*-release` file, you can call each item. AKA in the file, ID=Linux. So, if you wanted to use that, you'd call it:

```bash
if [[ "$ID" == "Linux" ]]; then
    do linux things
fi
```


[^5bc1e731]: [OS Detection in Bash Script](http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux)
