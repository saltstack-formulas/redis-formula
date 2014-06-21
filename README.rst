redis
=====

# DO NOT USE YET 

Formula to install and configure redis.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:


``redis``
---------

Install redis only

``redis.server``
----------------

Install redis and start up the service (currently, only upstart/ubuntu supported).

For a list of all available options, look at: `redis/templates/redis.conf.jinja`
