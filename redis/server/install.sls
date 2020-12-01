include:
  - redis.common

{% from "redis/map.jinja" import redis_settings as r with context %}

    {%- if r.install_from in ('source', 'archive') %}

redis_user_group:
  group.present:
    - name: {{ r.group }}
  user.present:
    - name: {{ r.user }}
    - gid_from_name: True
    - home: {{ r.home }}
    - require:
      - group: redis_user_group
  file.managed:
    - name: /etc/init/redis-server.conf
    - template: jinja
    - source: salt://redis/files/upstart.conf.jinja
    - mode: '0750'
    - user: root
    - group: root
    - makedirs: True
    - context:
        conf: /etc/redis/redis.conf
        user: {{ r.user }}
        bin: {{ r.bin }}
    - require:
      - sls: redis.common

redis-log-dir:
  file.directory:
    - name: /var/log/redis
    - mode: 755
    - user: {{ r.user }}
    - group: {{ r.group }}
    - recurse:
        - user
        - group
        - mode
    - makedirs: True
    - require:
      - user: redis_user_group

    {%- endif %}

redis_config:
  file.managed:
    - name: {{ r.cfg_name }}
    - template: jinja
    {% if r.source_path is not defined %}
    - source: salt://redis/files/redis-{{ r.cfg_version }}.conf.jinja
    {% else %}
    - source: {{ r.source_path }}
    {%- endif %}
    - makedirs: True

    {%- if r.install_from in ('source', 'archive') %}
redis-initd:
  file.managed:
    - name: /etc/init.d/redis
    - template: jinja
    - source: salt://redis/files/redis_initd.jinja
    - mode: '0777'
    - user: root
    - group: root
    - require:
      - file: redis_config
    - require_in:
      - file: redis_service
    {%- endif %}

    {% if r.disable_transparent_huge_pages is defined and r.disable_transparent_huge_pages %}
redis_disable_transparent_huge_pages:
    cmd.run:
        - name: echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
    {%- endif %}

redis_service:
  service.{{ r.svc_state }}:
    {% if r.install_from in ('source', 'archive') %}
    - name: {{ r.svc_name }}_{{ r.port }}
    {% else %}
    - name: {{ r.svc_name }}
    {% endif %}
    - enable: {{ r.svc_onboot }}
    - watch:
      - file: redis_config
    - retry: {{ r.retry_option|json }}

    {% if r.overcommit_memory == True %}
redis_overcommit_memory:
  sysctl.present:
    - name: vm.overcommit_memory
    - value: 1
        {% if grains['os_family'] == 'Arch' %}
    - require_in:
      - service: redis_service
        {% endif %}
    {%- endif %}
