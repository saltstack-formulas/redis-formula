
Changelog
=========

`0.26.2 <https://github.com/saltstack-formulas/redis-formula/compare/v0.26.1...v0.26.2>`_ (2019-10-11)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **rubocop:** add fixes using ``rubocop --safe-auto-correct`` (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/5a9477e>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* merge travis matrix, add ``salt-lint`` & ``rubocop`` to ``lint`` job (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/b105002>`_\ )
* **travis:** merge ``rubocop`` linter into main ``lint`` job (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/f336c60>`_\ )

`0.26.1 <https://github.com/saltstack-formulas/redis-formula/compare/v0.26.0...v0.26.1>`_ (2019-10-10)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **common.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/a4c83ee>`_\ )
* **redis-3.0.conf.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/92ed1f8>`_\ )
* **redis-sentinel_initd.jinja:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/af83bca>`_\ )
* **sentinel.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/37e677a>`_\ )
* **server.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/4522782>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** change ``log_level`` to ``debug`` instead of ``info`` (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/bbf029d>`_\ )
* **kitchen:** install required packages to bootstrapped ``opensuse`` [skip ci] (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/bee64cc>`_\ )
* **kitchen:** use bootstrapped ``opensuse`` images until ``2019.2.2`` [skip ci] (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/65dd24e>`_\ )
* **platform:** add ``arch-base-latest`` (commented out for now) [skip ci] (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/ba5aed7>`_\ )
* merge travis matrix, add ``salt-lint`` & ``rubocop`` to ``lint`` job (\ ` <https://github.com/saltstack-formulas/redis-formula/commit/af99ee6>`_\ )

`0.26.0 <https://github.com/saltstack-formulas/redis-formula/compare/v0.25.2...v0.26.0>`_ (2019-09-14)
----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ `4934355 <https://github.com/saltstack-formulas/redis-formula/commit/4934355>`_\ )
