#!/bin/bash

readarray -t anee_package_names < anee_packages.txt
for package in "${anee_package_names[@]}"; do
    echo "<li><a href=\"portals/$package/index.html\">$package</a></li>" >> portals.html
    curl -O https://a3s.fi/anee_portal_packages/$package.tar.gz
    tar -xzf $package.tar.gz --directory /usr/share/nginx/html/portals
    # rm -rf /usr/share/nginx/html/portals/$package/egographs
    bash anee-lexical-portal/link-portal-package.sh /usr/share/nginx/html/portals/$package /usr/share/nginx/html/resources/gexf-js-base
done
