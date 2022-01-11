# `lgogdownloader-docker`

It's `lgogdownloader` in a docker image.

Does what it says on the tin.

## Usage

Note, we need to map `$HOME/.config/lgogdownloader` since that's where it stores the credentials.

```bash
docker run -ti -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" acheronfail/lgogdownloader <args>
```
