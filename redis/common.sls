{% set redis = pillar.get('redis', {}) -%}
{% set install_from = redis.get('install_from', 'package') -%}

{% if install_from == 'source' %}
{% set version = redis.get('version', '2.8.8') -%}
{% set checksum = redis.get('checksum', 'sha1=aa811f399db58c92c8ec5e48271d307e9ab8eb81') -%}
{% set root = redis.get('root', '/usr/local') -%}

redis-dependencies:
  pkg.installed:
    - names:
        - build-essential
        - python-dev
        - libxml2-dev

## Get redis
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

make-redis:
  cmd.wait:
    - cwd: {{ root }}/redis-{{ version }}
    - names:
      - make
      - make install
    - watch:
      - cmd: get-redis

{% elif install_from == 'package' %}
{% set version = redis.get('version', None) -%}

install-redis:
  pkg.installed:
    - name: redis-server
    {% if version %}
    - version: {{ version }}
    {% endif %}

{% endif -%}
