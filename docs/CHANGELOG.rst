
Changelog
=========

`0.27.2 <https://github.com/saltstack-formulas/redis-formula/compare/v0.27.1...v0.27.2>`_ (2021-04-02)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **debian:** install/configure sentinel on stretch/buster (\ `cba4fbe <https://github.com/saltstack-formulas/redis-formula/commit/cba4fbe067627285cab8a2f7028ffdfd032dd045>`_\ )
* **debian:** optimize code for deletion (\ `a4a5d3c <https://github.com/saltstack-formulas/redis-formula/commit/a4a5d3cf1639659822d657bc3137b5600ab2a2fd>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] (\ `4b3644c <https://github.com/saltstack-formulas/redis-formula/commit/4b3644ca8a966983ae2fa8da466c7c86a59355b4>`_\ )

Tests
^^^^^


* standardise use of ``share`` suite & ``_mapdata`` state [skip ci] (\ `de567a6 <https://github.com/saltstack-formulas/redis-formula/commit/de567a6b49d84ac5fabb391dab642029c9540abe>`_\ )

`0.27.1 <https://github.com/saltstack-formulas/redis-formula/compare/v0.27.0...v0.27.1>`_ (2021-03-04)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **common:** add inline EPEL repo configuration for Amazon Linux 2 (\ `6b1c316 <https://github.com/saltstack-formulas/redis-formula/commit/6b1c31613ffdf86776a54ab133935de04e47de95>`_\ )
* **noise:** only change hugepage state if needed (\ `cd793f2 <https://github.com/saltstack-formulas/redis-formula/commit/cd793f29f363bff95db2cb37ce3d371193eacc62>`_\ )
* **suse:** fix for OpenSUSE Leap & Tumbleweed (\ `9ce0e7f <https://github.com/saltstack-formulas/redis-formula/commit/9ce0e7f780780ceada393250b3ecb6fdc45828a1>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **commitlint:** ensure ``upstream/master`` uses main repo URL [skip ci] (\ `c9bde0b <https://github.com/saltstack-formulas/redis-formula/commit/c9bde0b2907a785c12a46b3f733abf2b3d12a724>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``kitchen-docker`` repo [skip ci] (\ `05cb8a1 <https://github.com/saltstack-formulas/redis-formula/commit/05cb8a1ed84cc84e505d8e5b5740795983318b17>`_\ )
* **gitlab-ci:** add ``rubocop`` linter (with ``allow_failure``\ ) [skip ci] (\ `526d533 <https://github.com/saltstack-formulas/redis-formula/commit/526d5338b1623dc7089722e562803862221fd12f>`_\ )
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] (\ `889c8f8 <https://github.com/saltstack-formulas/redis-formula/commit/889c8f8adca2fdf0cbcf715f3d64ce527f8763b2>`_\ )
* **pre-commit:** update hook for ``rubocop`` [skip ci] (\ `03bcbcf <https://github.com/saltstack-formulas/redis-formula/commit/03bcbcf3a9713852257376b43a4bc870f29fe151>`_\ )

`0.27.0 <https://github.com/saltstack-formulas/redis-formula/compare/v0.26.2...v0.27.0>`_ (2020-12-16)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **defaults:** fix ``yamllint`` violation [skip ci] (\ `90093e2 <https://github.com/saltstack-formulas/redis-formula/commit/90093e2592a039ca8ab382a88d5f0682dd70f6a8>`_\ )
* **init:** convert to metastate; add clean state (\ `ca5f5aa <https://github.com/saltstack-formulas/redis-formula/commit/ca5f5aadbb33e2ebcda82595221232cdde12ba2a>`_\ )
* **release.config.js:** use full commit hash in commit link [skip ci] (\ `9c0b42a <https://github.com/saltstack-formulas/redis-formula/commit/9c0b42a3b64768d0e75ed1e06cc9d4a4aed54036>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **server:** simplify install.sls (\ `f86a718 <https://github.com/saltstack-formulas/redis-formula/commit/f86a718bddf7da40e7f57d5480160b78432cb7c8>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `adff150 <https://github.com/saltstack-formulas/redis-formula/commit/adff15056572fc3b3198d405e944032b0e55498b>`_\ )
* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `e7f1305 <https://github.com/saltstack-formulas/redis-formula/commit/e7f13054514241858b3e24da8c972c71262f1e46>`_\ )
* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `38840b7 <https://github.com/saltstack-formulas/redis-formula/commit/38840b7cbf4754faed3d8ebcc13fc26911043a40>`_\ )
* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `7957381 <https://github.com/saltstack-formulas/redis-formula/commit/7957381a36185ee1fda6dda86c037b7cdd59bbd1>`_\ )
* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `e01a263 <https://github.com/saltstack-formulas/redis-formula/commit/e01a263f3fc91c47e9d389987cdd0907bedf0996>`_\ )
* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `769ec90 <https://github.com/saltstack-formulas/redis-formula/commit/769ec907a94e66d53472a3f77d3ef132c42f289c>`_\ )
* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `8bf0065 <https://github.com/saltstack-formulas/redis-formula/commit/8bf0065b4f7ac57380aec2a5d61ec7b9d3f4bc9c>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `a0d6394 <https://github.com/saltstack-formulas/redis-formula/commit/a0d63945ba9860f597e55829ae88a9b57b260bcc>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `0d7108e <https://github.com/saltstack-formulas/redis-formula/commit/0d7108e0ef48b57a2900e0b52c6ce4eecca5e3f0>`_\ )
* **pre-commit:** add to formula [skip ci] (\ `b48efa9 <https://github.com/saltstack-formulas/redis-formula/commit/b48efa9fe371f433b3f4cf1fd8fc3e5f9770d33a>`_\ )
* **pre-commit:** enable/disable ``rstcheck`` as relevant [skip ci] (\ `d180e9b <https://github.com/saltstack-formulas/redis-formula/commit/d180e9b40e9e7ae7d84605458be3e0ef428aed19>`_\ )
* **pre-commit:** finalise ``rstcheck`` configuration [skip ci] (\ `13311ce <https://github.com/saltstack-formulas/redis-formula/commit/13311ced4ac193e58deb9e8a3a24b1390f75f5fb>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `6e49f55 <https://github.com/saltstack-formulas/redis-formula/commit/6e49f55c1ffd8e9f9cf31149c803f81da4271bb8>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `503fa20 <https://github.com/saltstack-formulas/redis-formula/commit/503fa20cfbb17560c9e8c53786125dfa5dbf9d62>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation [skip ci] (\ `a3efd1f <https://github.com/saltstack-formulas/redis-formula/commit/a3efd1f94d38c1f238ddfaf357afb9e83bdf7369>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `da71c9d <https://github.com/saltstack-formulas/redis-formula/commit/da71c9d60458079d71a775abbfaadf2a0ea99665>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `e63b945 <https://github.com/saltstack-formulas/redis-formula/commit/e63b945e615c7a35cf87f86d2885a1349814332a>`_\ )
* **travis:** update ``salt-lint`` config for ``v0.0.10`` [skip ci] (\ `b317fec <https://github.com/saltstack-formulas/redis-formula/commit/b317fec818f243acd45d184e30ac34aa5313b37d>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `fe02b53 <https://github.com/saltstack-formulas/redis-formula/commit/fe02b53ebde0595a03fd6f3f4b77d0826f060363>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `a0ffb8a <https://github.com/saltstack-formulas/redis-formula/commit/a0ffb8adc0e4f31f5893e12ffc33120ec89c78f6>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `b9b286b <https://github.com/saltstack-formulas/redis-formula/commit/b9b286b7efa71435f6804dbc351e1615e11f221a>`_\ )

Documentation
^^^^^^^^^^^^^


* **contributing:** remove to use org-level file instead [skip ci] (\ `a803116 <https://github.com/saltstack-formulas/redis-formula/commit/a803116832161bfdf10085cc3788fbfdf5963b4d>`_\ )
* **readme:** fix ``rstcheck`` violation & standardise [skip ci] (\ `ca32bfd <https://github.com/saltstack-formulas/redis-formula/commit/ca32bfdc1d2016deda4a074103d0bbea6b553a6a>`_\ )
* **readme:** update link to ``CONTRIBUTING`` [skip ci] (\ `bd011b8 <https://github.com/saltstack-formulas/redis-formula/commit/bd011b8e06017cd8c78a4a53a2a49889d6c7ab48>`_\ )

Features
^^^^^^^^


* **suse:** basic opensuse support; tidyup (\ `f29f544 <https://github.com/saltstack-formulas/redis-formula/commit/f29f544f6cbb87dbb3f568eae9f352cb75af1f90>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `186796b <https://github.com/saltstack-formulas/redis-formula/commit/186796b70d656b4c3c27d8934eccb92458f7ec02>`_\ )

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
