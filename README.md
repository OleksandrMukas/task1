# task1

Start by cloning the repository:
```
git clone https://github.com/OleksandrMukas/task1.git
cd task1
```
And you can make your own docker image:
# default arguments: 
PROM_VERSION="3.5.0"
ARCH="amd64"
OS="linux"
# else arg:
ARCH="arm64"
OS="darwin"

```
docker build \ 
--build-arg PROM_VERSION=3.5.0 \
            ARCH="amd64" \
            OS="linux" \
-t my_prom .

```
