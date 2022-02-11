{% from "redis/map.jinja" import redis_settings with context %}


{% set install_from   = redis_settings.install_from -%}

{% if install_from in ('source', 'archive') %}
{% set version = redis_settings.version|default('2.8.8') -%}
{% set checksum = redis_settings.checksum|default('sha1=aa811f399db58c92c8ec5e48271d307e9ab8eb81') -%}
{% set root = redis_settings.root|default('/usr/local') -%}

{# there is a missing config template for version 2.8.8 #}

redis-dependencies:
  pkg.installed:
    - names:
        - {{ redis_settings.python_dev_package }}
    {% if grains['os_family'] == 'RedHat' %}
        - make
        - libxml2-devel
    {% elif grains['os_family'] == 'Debian' or grains['os_family'] == 'Ubuntu' %}
        - build-essential
        - libxml2-dev
    {% endif %}

get-redis:
  file.managed:
    - name: {{ root }}/redis-{{ version }}.tar.gz
    - source: http://download.redis.io/releases/redis-{{ version }}.tar.gz
    - source_hash: {{ checksum }}
    - makedirs: True
    - require:
      - pkg: redis-dependencies
  cmd.run:
    - cwd: {{ root }}
    - names:
      - tar -zxvf {{ root }}/redis-{{ version }}.tar.gz -C {{ root }} >/dev/null
    - onchanges:
      - file: get-redis

make-and-install-redis:
  cmd.run:
    - cwd: {{ root }}/redis-{{ version }}
    - names:
      - make >/dev/null 2>&1
      - make install >/dev/null 2>&1
    - onchanges:
      - cmd: get-redis

install-redis-service:
  cmd.run:
    - cwd: {{ root }}/redis-{{ version }}
    - names:
      - echo -n | utils/install_server.sh
    - onchanges:
      - cmd: get-redis
      - cmd: make-and-install-redis
    - require:
      - cmd: make-and-install-redis


{% elif install_from == 'package' %}

{%-   if salt['grains.get']('osfinger', '') in ['Amazon Linux-2'] %}
redis_epel_repo:
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: install-redis
{%-   endif %}

install-redis:
  pkg.installed:
    - name: {{ redis_settings.pkg_name }}
    {% if redis_settings.version is defined %}
    - version: {{ redis_settings.version }}
    - ignore_epoch: True
    {% endif %}
{% endif %}

    {%- if grains.os_family|lower == 'suse' %}
        {# this is basically a workaround for faulty packaging #}
install-redis-user-group:
  group.present:
    - name: {{ redis_settings.group }}
  user.present:
    - name: {{ redis_settings.user }}
    - usergroup: True
    - home: {{ redis_settings.home }}
    - require:
      - group: install-redis-user-group
    - require_in:
      - file: install-redis-log-dir

install-redis-log-dir:
  file.directory:
    - name: {{ redis_settings.dir.log }}
    - mode: 755
    - user: {{ redis_settings.user }}
    - group: {{ redis_settings.group }}
    - recurse:
        - user
        - group
        - mode
    - makedirs: True

install-redis-service:
  file.replace:
    - name: {{ redis_settings.dir.service }}/redis@.service
    - pattern: ^Type=notify
    - repl: Type=simple
    - onlyif: test -f {{ redis_settings.dir.service }}/redis@.service
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: install-redis-log-dir
    {%- endif %}
