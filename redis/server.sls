include:
  - redis.common


{% from "redis/map.jinja" import redis_settings with context %}

{% set cfg_version    = redis_settings.cfg_version -%}
{% set cfg_name       = redis_settings.cfg_name -%}
{% set install_from   = redis_settings.install_from -%}
{% set pkg_name       = redis_settings.pkg_name -%}
{% set svc_name       = redis_settings.svc_name -%}
{% set svc_state      = redis_settings.svc_state -%}
{% set svc_onboot     = redis_settings.svc_onboot -%}


{% if install_from == 'source' %}


{% set user           = redis_settings.user -%}
{% set group          = redis_settings.group -%}
{% set home           = redis_settings.home -%}
{% set bin            = redis_settings.bin -%}

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
        bin: {{ bin }}
    - require:
      - sls: redis.common


redis-old-init-disable:
  cmd.wait:
    - name: update-rc.d -f redis-server remove
    - watch:
      - file: redis-init-script


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
  file.managed:
    - name: /etc/redis/redis.conf
    - makedirs: True
    - template: jinja
    - source: salt://redis/files/redis-{{ cfg_version }}.conf.jinja
    - require:
      - file: redis-init-script
      - cmd: redis-old-init-disable
  service.running:
    - watch:
      - file: redis-init-script
      - cmd: redis-old-init-disable
      - file: redis-server


{% else %}


redis_config:
  file.managed:
    - name: {{ cfg_name }}
    - template: jinja
    - source: salt://redis/files/redis-{{ cfg_version }}.conf.jinja
    - require:
      - pkg: {{ pkg_name }}


redis_service:
  service.{{ svc_state }}:
    - name: {{ svc_name }}
    - enable: {{ svc_onboot }}
    - watch:
      - file: {{ cfg_name }}
    - require:
      - pkg: {{ pkg_name }}


{% endif %}
