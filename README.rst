redis
=====

Formula to install and configure redis.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Todo
====

* merge redis 2.4 and 2.6 templates to generic redis.conf.jinja

Available states
================

.. contents::
    :local:


``redis``
---------

Install redis only

``redis.server``
----------------

Install redis and start up the service ( Ubuntu + RedHat based systems should work ).

For a list of all available options, look at: `redis/templates/redis.{version}.conf.jinja` - also have a look at the pillar.example and map.jinja.
