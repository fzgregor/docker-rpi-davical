# docker-davical-rpi
This image brings [DAViCal](http://www.davical.org) onto your raspberrypi.

# Configuration
The image is configured via environment variables during startup:

* UPDATE_ON_STARTUP define this variable and the container will apply alpine linux updates (apk upgrade --no-cache) when it is started (default: disabled)
* DEFAULT_LOCALE davical default locale (default: en_EN.UTF-8)
* DB_HOST address of postgresql server (default: db)
* DB_PORT port of postgresql server (default: 5432)
* DB_NAME name of the database (default: davical)
* DB_APP_USER database login of davical application (default: davical_app)
* DB_APP_PASS database password of davical application (default: 53cret)

# Database Creation
You are new to DAViCal and don't have a database yet? Set the following environment variables and start the /create-database script.
This script will create the database and two users. The app user (DB_APP_USER) used by the application and an adminstrator user (DB_DBA_USER) owning the database used by the update script for example. Hence, typically you can ignore the following variables.

* DB_SUPER_USER login of database server super user (able to create new databases and users)
* DB_SUPER_PASS
* DB_DBA_USER login of administration account for the create database
* DB_DBA_PASS

So, set the variables appropriately and execute ``docker run --rm -it <vars> rotschopf/rpi-davical /create-database`` to create a fresh database.
