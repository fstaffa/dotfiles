#!/usr/bin/env fish

set -gx PATH "$HOME/.config/guix/current/bin:$PATH"
set -gx INFOPATH "$HOME/.config/guix/current/share/info:$INFOPATH"

set -gx GUIX_PROFILE "/home/mathematician314/.guix-profile"
bass source "$GUIX_PROFILE/etc/profile"

set -gx SSL_CERT_DIR "$HOME/.guix-profile/etc/ssl/certs"
set -gx SSL_CERT_FILE "$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
set -gx GIT_SSL_CAINFO "$SSL_CERT_FILE"
set -gx GUIX_LOCPATH $HOME/.guix-profile/lib/locale
set -gx GUIX_EXTRA_PROFILES $HOME/.guix-extra-profiles

function guix-install-work
    guix package -m $HOME/.config/guix/manifests/work.scm -p "$GUIX_EXTRA_PROFILES"/work
end

function guix-install-common
    guix package -m $HOME/.config/guix/manifests/common.scm -p "$GUIX_EXTRA_PROFILES"/common
end

for profile in "$GUIX_EXTRA_PROFILES/work" "$GUIX_EXTRA_PROFILES/common"
    if test -e "$profile/etc/profile"
        set GUIX_PROFILE $profile
        bass source "$GUIX_PROFILE/etc/profile"
    end
end
