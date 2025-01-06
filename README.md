ISSUE (!!WARNING):
Setup pterodactyl is complicated specially on cloud, there are some issue:
- 3 dockers panel, wing, database is complicated.
- on local, fail to load api/system make health check fail.
- on cloud, more complicated, even can not run because mission config.yml
- Less efficiency, depend on nest and pterodactyl, less customize.
SOLUTION:
- Switch to general solution like kubernetes, docker and specific game.

How to start?
docker-compose up

How to list containers?
docker container ls

How to monitor?
docker exec -it 4dc8c3ecfd37 sh

Link Home page pterodactyl:
https://pterodactyl.io/

How to add first user?
https://pterodactyl.io/panel/1.0/getting_started.html#add-the-first-user

How to watch log?
tail -n 100 /var/www/pterodactyl/storage/logs/laravel-$(date +%F).log

Issue resolve:
How to resolve ssl:
var/.env
RECAPTCHA_ENABLED=false
https://www.php.net/manual/en/curl.configuration.php

Tutorial:
https://www.youtube.com/watch?v=_ypAmCcIlBE
https://docs.technotim.live/posts/pterodactyl-game-server/

https://www.youtube.com/watch?v=nfrZl32K90g

How to do migration?
https://shortcode.dev/artisan-cheatsheet