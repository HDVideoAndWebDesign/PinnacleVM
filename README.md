# Pinnacle Dev VM

Intended for use with vagrant & virtualbox (no version testing has been done with either so my fingers are crossed that it will work where it needs to)

The default settings here install nginx and rethinkDB as well as configuring each to the bare minimum of working _somewhat_ together.

The vm grabs [192.168.1.88](http://192.168.1.88/) by default. This address is the root of the /srv/sites directory currently (Sept 4 2015). That seems likely to change.

Also the RethinkDB Admin page can be found at [192.168.1.88/rethink](http://192.168.1.88/rethink).


## Dev VM files

- __Vagrantfile__ contains a rough version of bash setup script for provisioning.
  With luck maybe it is portable enough to use parts of it in production.

- __pinnacle.conf__ is a basic nginx conf file for hosting the pinnacle site from `/srv/sites/`

## TODO
- [ ] update Vagrantfile to share app files
- [ ] make provisioning script external for potential production uses
- [ ] add security to the rethink admin pages
- [ ] tons of other things I can't remember right now
- [ ] remember to setup production env variables
