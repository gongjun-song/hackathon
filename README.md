## kmod container user guide

Setup env:
==========

- Update the kmod repo

    ```
    cd kmod && git pull --all && cd -
    ```

- Build kmod docker image

    ```
    docker build -t kmod-image .
    ```

- Run docker container
    
    ```
    docker run --privileged -it --name kmod-container kmod-image
    ```

- Compilation and installation(docker env)

    ```
    meson setup --native-file build-dev.ini builddir/
    meson compile -C builddir/
    meson install -C builddir/
    apt update && apt install --reinstall linux-modules-$(uname -r)
    ```

- Run test suite(docker env)

    ```
    meson test -C builddir/
    ```

- Stop&remove the container

    ```
    docker stop kmod-container && docker rm kmod-container
    ```
