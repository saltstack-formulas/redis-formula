{% from "redis/map.jinja" import redis_settings with context %}

redis_sentinel_install:
  pkg.installed:
    - name: {{ redis_settings.sentinel_pkg }}

redis_sentinel_config:
    file.managed:
        - name: {{ redis_settings.sentinel_cfg }}
        - template: jinja
{% if redis_settings.sentinel.source_path is not defined %}
        - source: salt://redis/files/redis-sentinel.conf.jinja
{% else %}
        - source: {{ redis_settings.sentinel.source_path }}
{% endif %}
        - user: {{ redis_settings.sentinel.user }}
        - group: {{ redis_settings.sentinel.group }}
        - watch_in:
            - service: redis_sentinel_service

{% if redis_settings.sentinel.masters is defined %}
{%for master,master_opts in redis_settings.sentinel.masters.items() %}
{% if master_opts['notification-script'] is defined and master_opts['notification-script'].source_path is defined %}

redis_sentinel_{{ master }}_notification_script:
    file.managed:
        - name: {{ master_opts['notification-script'].path }}
        - source: {{ master_opts['notification-script'].source_path }}
        - mode: '755'
        - template: jinja

{% endif %}
{% if master_opts['client-reconfig-script'] is defined and master_opts['client-reconfig-script'].source_path is defined %}

redis_sentinel_{{ master }}_client_reconfig_script:
    file.managed:
        - name: {{ master_opts['client-reconfig-script'].path }}
        - source: {{ master_opts['client-reconfig-script'].source_path }}
        - mode: '755'
        - template: jinja

{% endif %}
{% endfor %}
{% endif %}

{% if grains['os'] == 'Ubuntu' and ( grains['osmajorrelease'] == 14 or grains['osmajorrelease'] == '14' ) %}

redis_sentinel_init:
    file.managed:
        - name: /etc/init.d/redis-sentinel
        - template: jinja
        - source: salt://redis/files/redis-sentinel_initd.jinja
        - mode: '755'
        - user: root
        - group: root

{% endif %}

redis_sentinel_piddir:
    file.directory:
        - name: {{ salt['file.dirname'](redis_settings.sentinel.pidfile) }}
        - user: redis
        - group: redis
        - makedirs: True

redis_sentinel_service:
{% if redis_settings.sentinel.enabled is defined and redis_settings.sentinel.enabled %}
    service.running:
        - name: {{ redis_settings.sentinel_service }}
        - enable: True
{% elif redis_settings.sentinel.enabled is defined and not redis_settings.sentinel.enabled %}
    service.dead:
        - name: {{ redis_settings.sentinel_service }}
        - enable: False
{% endif %}
