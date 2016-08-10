# Basic Use of `grep` in `if-else`

```bash
#!/bin/bash

dpkg -l | grep openvpn &> /dev/null
if [[ $? == 0 ]]; then
    echo "matched"
else
    echo "Not Matched"
fi
```
