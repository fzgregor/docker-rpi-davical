# docker-davical-rpi
This image brings [DAViCal](http://www.davical.org) onto your raspberrypi.

# Configuration
The image is configured via environment variables during startup:

* UPDATE_ON_STARTUP define this variable and the container will apply alpine linux updates (apk upgrade --no-cache) when it is started (default: disabled)
* DEFAULT_LOCALE davical default locale (default: en_EN.UTF-8)
* DB_HOST address of postgresql server (default: db)
* DB_PORT port of postgresql server (default: 5432)
* DB_NAME name of the database (default: davical)
* DB_USER database login of davical application (default: davical_app)
* DB_PASS database password of davical application (default: 53cret)
