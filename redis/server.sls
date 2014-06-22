include:
  - redis.common

{% from "redis/map.jinja" import redis with context %}

{% set install_from   = salt['pillar.get']('redis:install_from', 'package') -%}
{% set svc_state      = salt['pillar.get']('redis:svc_state', 'running') -%}
{% set cfg_version    = salt['pillar.get']('redis:cfg_version')|default('2.5') -%}

{% if install_from == 'source' %}

{% set user           = salt['pillar.get']('redis:user', 'redis') -%}
{% set group          = salt['pillar.get']('redis:group', user) -%}
{% set home           = salt['pillar.get']('redis:home', '/var/lib/redis') -%}
{% set bin            = salt['pillar.get']('redis:bin', '/usr/local/bin/redis-server') -%}

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
    - source: salt://redis/templates/upstart.conf.jinja
    - mode: 0750
    - user: root
    - group: root
    - context:
        conf: /etc/redis/redis.conf
        user: {{ user }}
        bin: {{ bin }}
    - require:
      - sls: redis.common

redis-old-init-disable:
  cmd:
    - wait
    - name: update-rc.d -f redis-server remove
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

redis-server:
  file:
    - name: /etc/redis/redis.conf
    - managed
    - template: jinja
    - source: salt://redis/templates/redis-{{ cfg_version }}.conf.jinja
    - require:
      - file: redis-init-script
      - cmd: redis-old-init-disable
      - file: redis-pid-dir
  service:
    - running
    - watch:
      - file: redis-init-script
      - cmd: redis-old-init-disable
      - file: redis-server

{% endif %}


redis_service:
  file:
    - name: {{ redis.cfg_name }}
    - managed
    - template: jinja
    - source: salt://redis/templates/redis-{{ redis.cfg_version }}.conf.jinja
    - require:
      - pkg: {{ redis.pkg_name }}
  service:
    - name: {{ redis.svc_name }}
    - {{ svc_state }}
    - watch:
      - file: {{ redis.cfg_name }}
    - require:
      - pkg: {{ redis.pkg_name }}


