redis
=====

Formula to install and configure redis.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

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

For a list of all available options, look at: `redis/files/redis-{version}.conf.jinja` - also have a look at the pillar.example and map.jinja.


Testing
=======

Testing is done with `kitchen-salt <https://github.com/simonmcc/kitchen-salt>`_.

Install it via bundler:

``$ bundle``

Then run test-kitchen with:

``$ kitchen converge``

Make sure the tests pass:

``$ kitchen verify``
