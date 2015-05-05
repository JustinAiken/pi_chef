# Pi Chef

This is the chef repo that runs my openHAB system on a [Raspberry Pi B+](https://www.amazon.com/gp/product/B00LPESRUK/?tag=cc0a0-20).

## What it does

- Cleans a ton of junk off the default raspian image
- Puts on my dotfiles
- Installs a modern Ruby
- Installs openhab with an 'openhab' user and gets it fully ready to run
- Installs my openhab config from a private repo
- Plugs openhab into my.openhab
- Gets the pi ready to talk to a rooted Wink Hub over ssh commands.

# Usage

### Setup

#### Prepare the Pi

- Get a Pi.
- Put Raspbian on
- Add ssh keys for the default `pi` user
- Make sure you also know the root password

#### Prepare the local workstation

- Clone this repo
- `cd` into it
- `bundle install`
- Prepare configs
  - Edit `pi.json`
  - `cp data_bags/openhab/my_openhab.sample.json data_bags/openhab/my_openhab.json` and edit to taste
  - `cp data_bags/openhab/ssh_keys.sample.json data_bags/openhab/ssh_keys.json` and edit to taste
- `rake prepare`

### Provisioning

- `rake cook`
