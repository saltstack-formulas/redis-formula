
{%- from "redis/map.jinja" import redis_settings with context %}
{%- set cfg_name          = redis_settings.cfg_name -%}
{%- set install_from      = redis_settings.install_from -%}
{%- set svc_name          = redis_settings.svc_name -%}
{%- set port              = redis_settings.port -%}

redis-server-service-clean:
  service.dead:
    {%- if install_from == 'source' %}
    - name: {{ svc_name }}_{{ port }}
    {%- else %}
    - name: {{ svc_name }}
    {%- endif %}
    - enable: false
    - require_in:
      - user: redis-server-clean
      - file: redis-server-clean

redis-server-clean:
    {%- if install_from == 'source' %}
        {%- set user = redis_settings.user -%}
        {%- set group = redis_settings.group -%}

  user.absent:
    - name: {{ user }}
  group.absent:
    - name: {{ group }}
    - require:
      - user: redis-server-clean
  file.absent:
    - names:
      - /etc/init/redis-server.conf
      - /var/log/redis
      - {{ cfg_name }}
      - /etc/init.d/redis
      - {{ redis_settings.root|default('/usr/local') }}

    {%- else %}

  pkg.removed:
    - name: {{ redis_settings.pkg_name }}

    {%- endif %}
