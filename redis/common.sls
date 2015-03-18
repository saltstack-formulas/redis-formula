{% from "redis/map.jinja" import redis_settings with context %}


{% set install_from   = redis_settings.install_from -%} 


{% if install_from == 'source' %}
{% set version = redis_settings.version|default('2.8.8') -%}
{% set checksum = redis_settings.checksum|default('sha1=aa811f399db58c92c8ec5e48271d307e9ab8eb81') -%}
{% set root = redis_settings.root|default('/usr/local') -%}

{# there is a missing config template for version 2.8.8 #}

redis-dependencies:
  pkg.installed:
    - names:
    {% if grains['os_family'] == 'RedHat' %}
        - python-devel
        - make
        - libxml2-devel
    {% elif grains['os_family'] == 'Debian' or 'Ubuntu' %}
        - build-essential
        - python-dev
        - libxml2-dev
    {% endif %}


get-redis:
  file.managed:
    - name: {{ root }}/redis-{{ version }}.tar.gz
    - source: http://download.redis.io/releases/redis-{{ version }}.tar.gz
    - source_hash: {{ checksum }}
    - require:
      - pkg: redis-dependencies
  cmd.wait:
    - cwd: {{ root }}
    - names:
      - tar -zxvf {{ root }}/redis-{{ version }}.tar.gz -C {{ root }}
    - watch:
      - file: get-redis


make-and-install-redis:
  cmd.wait:
    - cwd: {{ root }}/redis-{{ version }}
    - names:
      - make
      - make install
    - watch:
      - cmd: get-redis


{% elif install_from == 'package' %}


install-redis:
  pkg.installed:
    - name: {{ redis_settings.pkg_name }}
    {% if redis_settings.version is defined %}
    - version: {{ redis_settings.version }}
    {% endif %}


{% endif %}
