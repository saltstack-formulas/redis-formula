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
      port: 6777

For a list of all available options, look at: `redis/templates/redis.conf.jinja`