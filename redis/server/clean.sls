
{%- from "redis/map.jinja" import redis_settings as r with context %}

redis-server-service-clean:
  service.dead:
    {%- if r.install_from in ('source', 'archive') %}
    - name: {{ r.svc_name }}_{{ r.port }}
    {%- else %}
    - name: {{ r.svc_name }}
    {%- endif %}
    - enable: false
    - require_in:
      - user: redis-server-clean
      - file: redis-server-clean

redis-server-clean:
    {%- if r.install_from in ('source', 'archive') %}

  user.absent:
    - name: {{ r.user }}
  group.absent:
    - name: {{ r.group }}
    - require:
      - user: redis-server-clean
  file.absent:
    - names:
      - /etc/init/redis-server.conf
      - {{ r.cfg_name }}
      - /etc/init.d/redis
      - {{ r.root|default('/usr/local') }}
      - /etc/redis
      - {{ r.dir.log }}
      - {{ r.dir.service }}/redis*
      - /var/run/redis
      - /var/run/redis_6379.pid

    {%- else %}

  pkg.removed:
    - name: {{ r.pkg_name }}

    {%- endif %}
