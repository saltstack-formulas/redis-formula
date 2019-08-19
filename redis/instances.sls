{% from "redis/map.jinja" import redis_settings with context %}

include:
  - redis.server

{% set cfg_version       = redis_settings.cfg_version -%}
{% set install_from      = redis_settings.install_from -%}
{% set user           = redis_settings.user -%}
{% set group          = redis_settings.group -%}

redis_systemd_template:
  file.managed:
  - name: /lib/systemd/system/redis-server@.service
  - replace: False
  - source: salt://redis/files/redis-server@.service

{% for instance_name, instance_options in redis_settings.instances|default({})|dictsort %}
{%   if instance_name != '_default' %}
{%     set config = {} %}
{%     do config.update(redis_settings) %}
{%     for key, value in redis_settings.instances.get('_default')|dictsort %}
{%       do config.update({key: (value|string).format(name=instance_name)}) %}
{%     endfor %}
{%     do config.update(instance_options) %}

redis_root_dir {{ instance_name }}:
  file.directory:
    - name: {{ config.root_dir }}
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - makedirs: True
    - require_in:
      - service: redis_service {{ instance_name }}

redis_config {{ instance_name }}:
  file.managed:
    - name: {{ config.cfg_name }}
    - template: jinja
{%     if redis_settings.source_path is not defined %}
    - source: salt://redis/files/redis-{{ cfg_version }}.conf.multi.jinja
{%     else %}
    - source: {{ config.source_path }}
{%     endif %}
    - defaults:
        redis_settings: {{ config|json }}

redis_service {{ instance_name }}:
  service.{{ config.svc_state }}:
    {% if install_from == 'source' %}
    - name: {{ config.svc_name }}_{{ config.port }}
    {% else %}
    - name: {{ config.svc_name }}
    {% endif %}
    - enable: {{ config.svc_onboot }}
    - require:
      - file: redis_systemd_template
    - watch:
      - file: {{ config.cfg_name }}
{%   endif %}
{% endfor %}
