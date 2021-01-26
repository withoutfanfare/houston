#!/usr/bin/env bash

php artisan migrate \
&& php artisan passport:refresh --force \
&& php artisan storage:link
