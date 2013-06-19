redis
=====

redis
-------

Install redis only

redis.server
---------------

Install redis and start up the service (currently, only upstart/ubuntu supported).

Can be configured via pillar:

    redis:
      home: /var/lib/redis
      user: redis