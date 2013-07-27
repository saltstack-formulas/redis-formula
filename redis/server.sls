include:
  - redis.common

{% set redis  = pillar.get('redis', {}) -%}
{% set home   = redis.get('home', '/var/lib/redis') -%}
{% set user   = redis.get('user', 'redis') -%}
{% set group  = redis.get('group', user) -%}

redis_group:
  group.present:
    - name: {{ group }}
    
redis_user:
  user.present:
    - name: {{ user }}
    - gid_from_name: True
    - home: {{ home }}
    - group: {{ group }}
    - require:
      - group: redis_group
      
redis-init-script:
  file.managed:
    - name: /etc/init/redis-server.conf
    - template: jinja
    - source: salt://redis/files/upstart.conf.jinja
    - mode: 0750
    - user: root
    - group: root
    - context:
        conf: /etc/redis/redis.conf
        user: {{ user }}
    - require:
      - file: get-redis

redis-old-init-disable:
  cmd:
    - wait
    - name: update-rc.d redis-server remove
    - watch:
      - file: redis-init-script

redis-pid-dir:
  file.directory:
    - name: /var/db/redis
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - makedirs: True
    - require:
      - user: redis_user
    - recurse:
      - user
      - group

redis-log-dir:
  file.directory:
    - name: /var/log/redis
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - makedirs: True
    - require:
      - user: redis_user
redis-log-file:
  file.touch:
    - name: /var/log/redis
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
    - require:
      - file: redis-log-dir

redis-server:
  file:
    - name: /etc/redis/redis.conf
    - managed
    - template: jinja
    - source: salt://redis/files/redis.conf.jinja
    - require:
      - file: redis-init-script
      - cmd: redis-old-init-disable
      - file: redis-pid-dir
  service:
    - running
    - require:
      - file: redis-init-script
      - cmd: redis-old-init-disable
      - file: redis-server
