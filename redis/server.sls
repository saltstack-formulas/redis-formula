include:
  - redis.common


{% from "redis/map.jinja" import redis_settings with context %}

{% set cfg_version       = redis_settings.cfg_version -%}
{% set cfg_name          = redis_settings.cfg_name -%}
{% set install_from      = redis_settings.install_from -%}
{% set svc_name          = redis_settings.svc_name -%}
{% set svc_state         = redis_settings.svc_state -%}
{% set svc_onboot        = redis_settings.svc_onboot -%}
{% set overcommit_memory = redis_settings.overcommit_memory -%}
{% set port              = redis_settings.port -%}


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


redis-log-dir:
  file.directory:
    - name: /var/log/redis
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - makedirs: True
    - require:
      - user: redis_user

{% if grains['os_family'] == 'Arch' %}
{% set user           = redis_settings.user -%}
{% set group          = redis_settings.group -%}
redis-log-dir:
  file.directory:
    - name: /var/log/redis
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - makedirs: True
{% endif %}
{% endif %}

redis_config:
  file.managed:
    - name: {{ cfg_name }}
    - template: jinja
{% if redis_settings.source_path is not defined %}
    - source: salt://redis/files/redis-{{ cfg_version }}.conf.jinja
{% else %}
    - source: {{ redis_settings.source_path }}
{% endif %}

{% if install_from == 'source' %}
redis-initd:
  file.managed:
    - name: /etc/init.d/redis
    - template: jinja
    - source: salt://redis/files/redis_initd.jinja
    - mode: 0777
    - user: root
    - group: root
    - require:
      - file: redis_config
    - require_in:
      - file: redis_service
{% endif %}

{% if redis_settings.disable_transparent_huge_pages is defined and redis_settings.disable_transparent_huge_pages %}
redis_disable_transparent_huge_pages:
    cmd.run:
        - name: echo "never" > /sys/kernel/mm/transparent_hugepage/enabled

{% endif %}
redis_service:
  service.{{ svc_state }}:
    {% if install_from == 'source' %}
    - name: {{ svc_name }}_{{ port }}
    {% else %}
    - name: {{ svc_name }}
    {% endif %}
    - enable: {{ svc_onboot }}
    - watch:
      - file: {{ cfg_name }}


{% if overcommit_memory == True %}
redis_overcommit_memory:
  sysctl.present:
    - name: vm.overcommit_memory
    - value: 1
    {% if grains['os_family'] == 'Arch' %}
    - require_in:
      - service: redis_service
    {% endif %}
{% endif %}
