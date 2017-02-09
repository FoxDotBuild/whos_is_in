# Who is Here?

## How it Works?

 0. Register your phone and laptop at Fox.Build.
 0. Visit Fox.Build
 0. Our Raspberry Pi will detect your presence.
 0. You will show up as present for others to see [here](http://foxbuild.rickcarlino.com/who.html)
 0. You gain 1 XP for every minute at the space, helping you advance on our leaderboard.

## Setup

 0. Delete old cron jobs by running `crontab -e` (we used to run an old version called `who_is_here.rb`).
 0. `git clone https://github.com/FoxDotBuild/whos_is_in.git`
 0. `cd who_is_in`
 0. Install `whenever`: `gem install whenever`
 0. Create a cron job (once only!): `whenever --update-crontab`
 0. ???
 0. PROFIT! Seriously though, you should be done at this point.

