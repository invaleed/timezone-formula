# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import timezone with context %}

timezone_setting:
  timezone.system:
    - name: {{ timezone }}
    - utc: {{ utc }}

{%- if grains.os not in ('MacOS', 'Windows') %}

timezone_packages:
  pkg.installed:
    - name: {{ timezone.pkg.name }}

timezone_symlink:
  file.symlink:
    - name: {{ timezone.path_localtime }}
    - target: {{ timezone.path_zoneinfo }}{{ timezone }}
    - force: true
    - require:
      - pkg: {{ timezone.pkg.name }}

{%- endif %}
